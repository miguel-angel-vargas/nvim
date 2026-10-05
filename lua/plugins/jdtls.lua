return {
	{
		"mfussenegger/nvim-jdtls",

		ft = "java",

		config = function()
			local function attach_jdtls()
				local jdtls = require("jdtls")

				-- Ruta de instalación de jdtls gestionada por Mason
				local mason_registry = require("mason-registry")
				local jdtls_pkg = mason_registry.get_package("jdtls")
				local jdtls_path = jdtls_pkg:get_install_path()

				local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

				local os_config = "config_win"
				if vim.fn.has("mac") == 1 then
					os_config = "config_mac"
				elseif vim.fn.has("unix") == 1 then
					os_config = "config_linux"
				end

				-- jdtls necesita un "workspace" de datos separado por
				-- proyecto para no mezclar estado entre proyectos distintos.
				local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
				local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

				-- Lombok: Mason instala un lombok.jar junto con jdtls. Si el
				-- proyecto no usa Lombok, este flag simplemente no hace nada.
				local lombok_jar = jdtls_path .. "/lombok.jar"

				local config = {
					cmd = {
						"java",
						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.protocol=true",
						"-Dlog.level=ALL",
						"-javaagent:" .. lombok_jar,
						"-Xms1g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",
						"-jar",
						launcher_jar,
						"-configuration",
						jdtls_path .. "/" .. os_config,
						"-data",
						workspace_dir,
					},

					-- Detecta la raíz del proyecto Maven (pom.xml). También
					-- cae a Gradle/.git por si algún día usas otro tipo de
					-- proyecto.
					root_dir = require("jdtls.setup").find_root({ "pom.xml", "gradlew", ".git" }),

					settings = {
						java = {
							configuration = {
								updateBuildConfiguration = "interactive",
							},
							eclipse = {
								downloadSources = true,
							},
							maven = {
								downloadSources = true,
							},
							signatureHelp = { enabled = true },
							completion = {
								favoriteStaticMembers = {
									"org.junit.Assert.*",
									"org.junit.jupiter.api.Assertions.*",
									"org.mockito.Mockito.*",
								},
							},
						},
					},

					capabilities = require("blink.cmp").get_lsp_capabilities(),

					init_options = {
						bundles = {},
					},
				}

				jdtls.start_or_attach(config)
			end

			-- Re-adjunta al abrir cualquier otro archivo .java durante la
			-- misma sesión (config() solo corre una vez al cargar el plugin).
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = attach_jdtls,
			})

			-- Adjunta también al buffer .java que disparó la carga inicial
			-- del plugin.
			attach_jdtls()
		end,
	},
}
