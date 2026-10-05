local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

-- Nombre del archivo actual sin extensión, usado como valor por defecto
-- para el nombre de componente.
local function basename()
	local name = vim.fn.fnamemodify(vim.fn.expand("%"), ":t:r")
	if name == "" or name == nil then
		return "Component"
	end
	return name
end

-- Tabstop editable con el nombre del archivo como valor por defecto
-- (se puede sobreescribir con Tab).
local function name_node(pos)
	return d(pos, function()
		return sn(nil, { i(1, basename()) })
	end)
end

-- Copia en vivo de lo que se haya escrito en el tabstop `pos`.
local function name_rep(pos)
	return rep(pos)
end

-- "valor" -> "Valor" (para setters de useState: const [x, setX] = useState()).
local function capitalize(args)
	local str = (args[1] and args[1][1]) or ""
	if str == "" then
		return ""
	end
	return str:sub(1, 1):upper() .. str:sub(2)
end

return {

	-- ---------- Componente funcional básico ----------
	s(
		"rfc",
		fmt(
			[[
const {} = ({{ {} }}) => {{
	return (
		<div>
			{}
		</div>
	);
}};

export default {};
]],
			{
				name_node(1),
				i(2),
				i(3),
				name_rep(1),
			}
		)
	),

	-- ---------- Componente funcional sin props ----------
	s(
		"rfce",
		fmt(
			[[
const {} = () => {{
	return (
		<div>
			{}
		</div>
	);
}};

export default {};
]],
			{
				name_node(1),
				i(2),
				name_rep(1),
			}
		)
	),

	-- ---------- Export default arrow function genérica ----------
	s(
		"rafce",
		fmt(
			[[
export const {} = ({{ {} }}) => {{
	return (
		<div>{}</div>
	);
}};
]],
			{
				name_node(1),
				i(2),
				i(3),
			}
		)
	),

	-- ---------- useState ----------
	s(
		"us",
		fmt(
			[[
const [{}, set{}] = useState({});
]],
			{
				i(1, "value"),
				f(capitalize, { 1 }),
				i(2),
			}
		)
	),

	-- ---------- useEffect ----------
	s(
		"ue",
		fmt(
			[[
useEffect(() => {{
	{}
}}, [{}]);
]],
			{
				i(1, "// efecto"),
				i(2, "dependencias"),
			}
		)
	),

	-- ---------- useEffect con cleanup ----------
	s(
		"uec",
		fmt(
			[[
useEffect(() => {{
	{}

	return () => {{
		{}
	}};
}}, [{}]);
]],
			{
				i(1, "// efecto"),
				i(2, "// cleanup"),
				i(3, "dependencias"),
			}
		)
	),

	-- ---------- useRef ----------
	s(
		"uref",
		fmt(
			[[
const {} = useRef(null);
]],
			{
				i(1, "ref"),
			}
		)
	),

	-- ---------- useMemo ----------
	s(
		"umemo",
		fmt(
			[[
const {} = useMemo(() => {{
	return {};
}}, [{}]);
]],
			{
				i(1, "valor"),
				i(2, "expresion"),
				i(3, "dependencias"),
			}
		)
	),

	-- ---------- useCallback ----------
	s(
		"ucb",
		fmt(
			[[
const {} = useCallback(({}) => {{
	{}
}}, [{}]);
]],
			{
				i(1, "handler"),
				i(2, "args"),
				i(3, "// lógica"),
				i(4, "dependencias"),
			}
		)
	),

	-- ---------- useContext ----------
	s(
		"uctx",
		fmt(
			[[
const {} = useContext({});
]],
			{
				i(1, "value"),
				i(2, "MiContexto"),
			}
		)
	),

	-- ---------- Custom hook ----------
	s(
		"hook",
		fmt(
			[[
import {{ useState, useEffect }} from 'react';

export const use{} = ({}) => {{
	{}

	return {{ {} }};
}};
]],
			{
				i(1, "NombreHook"),
				i(2, "params"),
				i(3, "// lógica del hook"),
				i(4, "valores"),
			}
		)
	),

	-- ---------- Custom hook simple ----------
	s(
		"useh",
		fmt(
			[[
export const {} = () => {{
	return {{{}}};
}};
]],
			{
				name_node(1),
				i(2),
			}
		)
	),

	-- ---------- Manejador de evento onClick ----------
	s(
		"onclick",
		fmt(
			[[
const handle{} = ({}) => {{
	{}
}};
]],
			{
				i(1, "Click"),
				i(2, "e"),
				i(3, "// lógica"),
			}
		)
	),

	-- ---------- Manejador de evento onChange (input) ----------
	s(
		"onchange",
		fmt(
			[[
const handle{} = (e) => {{
	{}
}};
]],
			{
				i(1, "Change"),
				i(2, "setValue(e.target.value);"),
			}
		)
	),

	-- ---------- Manejador de submit de formulario ----------
	s(
		"onsubmit",
		fmt(
			[[
const handleSubmit = (e) => {{
	e.preventDefault();
	{}
}};
]],
			{
				i(1, "// lógica de envío"),
			}
		)
	),

	-- ---------- Fetch de datos con useEffect ----------
	s(
		"fetchue",
		fmt(
			[[
const [{}, set{}] = useState([]);
const [loading, setLoading] = useState(true);
const [error, setError] = useState(null);

useEffect(() => {{
	const fetch{} = async () => {{
		try {{
			setLoading(true);
			const res = await fetch({});
			if (!res.ok) throw new Error('Error en la petición');
			const json = await res.json();
			set{}(json);
		}} catch (err) {{
			setError(err.message || 'Error desconocido');
		}} finally {{
			setLoading(false);
		}}
	}};

	fetch{}();
}}, []);
]],
			{
				i(1, "data"),
				f(capitalize, { 1 }),
				f(capitalize, { 1 }),
				i(2, "'/api/endpoint'"),
				f(capitalize, { 1 }),
				f(capitalize, { 1 }),
			}
		)
	),

	-- ---------- Map de lista con key ----------
	s(
		"map",
		fmt(
			[[
{{{}.map(({}) => (
	<{} key={{{}.{}}}>
		{}
	</{}>
))}}
]],
			{
				i(1, "items"),
				i(2, "item"),
				i(3, "li"),
				rep(2),
				i(4, "id"),
				i(5),
				rep(3),
			}
		)
	),

	-- ---------- Renderizado condicional && ----------
	s(
		"cond",
		fmt(
			[[
{{{} && (
	{}
)}}
]],
			{
				i(1, "condicion"),
				i(2, "<div>contenido</div>"),
			}
		)
	),

	-- ---------- Renderizado condicional ternario ----------
	s(
		"condt",
		fmt(
			[[
{{{} ? (
	{}
) : (
	{}
)}}
]],
			{
				i(1, "condicion"),
				i(2, "<div>Verdadero</div>"),
				i(3, "<div>Falso</div>"),
			}
		)
	),

	-- ---------- Context Provider completo ----------
	s(
		"context",
		fmt(
			[[
import React, {{ createContext, useContext, useState }} from 'react';

const {}Context = createContext(undefined);

export const {}Provider = ({{ children }}) => {{
	const [{}, set{}] = useState({});

	return (
		<{}Context.Provider value={{{{ {}, set{} }}}}>
			{{children}}
		</{}Context.Provider>
	);
}};

export const use{} = () => {{
	const context = useContext({}Context);
	if (!context) {{
		throw new Error('use{} debe usarse dentro de un {}Provider');
	}}
	return context;
}};
]],
			{
				i(1, "Mi"),
				rep(1),
				i(2, "valor"),
				f(capitalize, { 2 }),
				i(3, "valorInicial"),
				rep(1),
				rep(2),
				f(capitalize, { 2 }),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
			}
		)
	),

	-- ---------- Componente con children ----------
	s(
		"rfcc",
		fmt(
			[[
const {} = ({{ children{}{} }}) => {{
	return (
		<div>
			{{children}}
		</div>
	);
}};

export default {};
]],
			{
				name_node(1),
				i(2, ", "),
				i(3),
				name_rep(1),
			}
		)
	),

	-- ---------- Import de React (cuando no usas el nuevo JSX transform) ----------
	s("imr", { t("import React from 'react';") }),

	-- ---------- Import de hooks comunes ----------
	s(
		"imh",
		fmt(
			[[
import {{ useState, useEffect{} }} from 'react';
]],
			{
				i(1, ", useRef"),
			}
		)
	),

	-- ---------- Definir tipo de Props (JSDoc) ----------
	s(
		"props",
		fmt(
			[[
/**
 * @typedef {{Object}} {}Props
 * @property {{{}}} {}
 */
]],
			{
				i(1, "Component"),
				i(3, "tipo"),
				i(2, "propiedad"),
			}
		)
	),

	-- ---------- Styled component básico (styled-components) ----------
	s(
		"styled",
		fmt(
			[[
const {} = styled.{}`
	{}
`;
]],
			{
				i(1, "Wrapper"),
				i(2, "div"),
				i(3, "/* estilos */"),
			}
		)
	),

	-- ---------- Componente memoizado con React.memo ----------
	s(
		"memo",
		fmt(
			[[
const {} = React.memo(({{ {} }}) => {{
	return (
		<div>
			{}
		</div>
	);
}});

{}.displayName = '{}';

export default {};
]],
			{
				name_node(1),
				i(2, "props"),
				i(3),
				name_rep(1),
				name_rep(1),
				name_rep(1),
			}
		)
	),

	-- ---------- Reducer con useReducer ----------
	s(
		"reducer",
		fmt(
			[[
const {} = (state, action) => {{
	switch (action.type) {{
		case '{}':
			return {{ ...state, {}: action.payload }};
		default:
			return state;
	}}
}};

const [state, dispatch] = useReducer({}, {{ {}: {} }});
]],
			{
				i(1, "reducer"),
				i(2, "ACCION"),
				i(3, "campo"),
				rep(1),
				rep(3),
				i(4, "valorInicial"),
			}
		)
	),
}
