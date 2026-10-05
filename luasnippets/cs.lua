local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node

local fmt = require("luasnip.extras.fmt").fmt


-- =========================================================
-- Helpers
-- =========================================================

local function class_name()
    return vim.fn.expand("%:t:r")
end


local function namespace_name()
    local file = vim.fn.expand("%:t:r")

    return file
end


-- =========================================================
-- C# Snippets
-- =========================================================

ls.add_snippets("cs", {

    -- =====================================================
    -- CLASS
    -- =====================================================

    s(
        "class",
        fmt(
            [[
namespace {};

public class {}
{{
    {}
}}
]],
            {
                i(1, namespace_name()),
                f(class_name),
                i(2),
            }
        )
    ),


    -- =====================================================
    -- INTERFACE
    -- =====================================================

    s(
        "interface",
        fmt(
            [[
namespace {};

public interface I{}
{{
    {}
}}
]],
            {
                i(1, namespace_name()),
                f(class_name),
                i(2),
            }
        )
    ),


    -- =====================================================
    -- RECORD
    -- =====================================================

    s(
        "record",
        fmt(
            [[
namespace {};

public record {}({})
{{
}}
]],
            {
                i(1, namespace_name()),
                f(class_name),
                i(2),
            }
        )
    ),


    -- =====================================================
    -- PROPERTY
    -- =====================================================

    s(
        "prop",
        fmt(
            [[
public {} {} {{ get; set; }}
]],
            {
                i(1, "string"),
                i(2, "Property"),
            }
        )
    ),


    -- =====================================================
    -- CONSTRUCTOR
    -- =====================================================

    s(
        "ctor",
        fmt(
            [[
public {}({})
{{
    {}
}}
]],
            {
                f(class_name),
                i(1),
                i(2),
            }
        )
    ),


    -- =====================================================
    -- CONTROLLER
    -- =====================================================

    s(
        "controller",
        fmt(
            [[
using Microsoft.AspNetCore.Mvc;

namespace {};

[ApiController]
[Route("api/v1/[controller]")]
public class {}Controller : ControllerBase
{{
    public {}Controller()
    {{
    }}

    [HttpGet]
    public async Task<IActionResult> Find()
    {{
        return Ok();
    }}

    [HttpGet("{{id}}")]
    public async Task<IActionResult> FindById(Guid id)
    {{
        return Ok();
    }}

    [HttpPost]
    public async Task<IActionResult> Create()
    {{
        return Ok();
    }}

    [HttpPut("{{id}}")]
    public async Task<IActionResult> Update(Guid id)
    {{
        return Ok();
    }}

    [HttpDelete("{{id}}")]
    public async Task<IActionResult> Delete(Guid id)
    {{
        return Ok();
    }}
}}
]],
            {
                i(1, namespace_name()),
                f(class_name),
                f(class_name),
            }
        )
    ),


    -- =====================================================
    -- DTO
    -- =====================================================

    s(
        "dto",
        fmt(
            [[
namespace {};

public class {}Dto
{{
    public void ValidateFields()
    {{
    }}
}}
]],
            {
                i(1, namespace_name()),
                f(class_name),
            }
        )
    ),


    -- =====================================================
    -- ASYNC METHOD
    -- =====================================================

    s(
        "async",
        fmt(
            [[
public async Task<{}> {}({})
{{
    {}
}}
]],
            {
                i(1, "void"),
                i(2, "Method"),
                i(3),
                i(4),
            }
        )
    ),


    -- =====================================================
    -- TRY / CATCH
    -- =====================================================

    s(
        "try",
        fmt(
            [[
try
{{
    {}
}}
catch (Exception ex)
{{
    {}
}}
]],
            {
                i(1),
                i(2),
            }
        )
    ),


    -- =====================================================
    -- DEPENDENCY INJECTION FIELD
    -- =====================================================

    s(
        "field",
        fmt(
            [[
private readonly {} _{};
]],
            {
                i(1, "IService"),
                i(2, "service"),
            }
        )
    ),

    -- =====================================================
    -- SERVICE
    -- =====================================================

    s(
        "service",
        fmt(
            [[
namespace {};

public class {}Service
{{
    public {}Service()
    {{
    }}

    public async Task<List<object>> Find()
    {{
        {}
    }}

    public async Task<object> FindById(Guid id)
    {{
        {}
    }}

    public async Task<object> Create()
    {{
        {}
    }}

    public async Task<object> Update(Guid id)
    {{
        {}
    }}

    public async Task<object> Delete(Guid id)
    {{
        {}
    }}
}}
]],
            {
                f(class_name),
                f(class_name),
                f(class_name),
                i(1),
                i(2),
                i(3),
                i(4),
                i(5),
            }
        )
    ),
    -- =====================================================
    -- API RESPONSE
    -- =====================================================

    s(
        "apiresponse",
        t({
            "using System.Text.Json.Serialization;",
            "",
            "",
            "namespace Annar.Common;",
            "",
            "public class ApiResponse<T> {",
            "    public int code { get; set;}",
            "    public string status { get; set; }",
            "    public string message { get; set; }",
            "",
            "    [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]",
            "    public T? data { get; set; }",
            "",
            "    public ApiResponse(){}",
            "",
            "    public ApiResponse( int code, string status, string message, T? data){",
            "        this.code = code;",
            "        this.status = status;",
            "        this.message = message;",
            "        this.data = data;",
            "    }",
            "",
            "",
            "    public static ApiResponse<T> Success(T data, string message){",
            "        return new ApiResponse<T>(200, \"OK\", message, data);",
            "    }",
            "",
            "    public static ApiResponse<T> Created(T data, string message){",
            "        return new ApiResponse<T>(201, \"CREATED\", message, data);",
            "    }",
            "",
            "    public static ApiResponse<T> Error(int code, string status, string message){",
            "        return new ApiResponse<T>(code, status, message, default);",
            "    }",
            "}",
        })
    ),

    -- =====================================================
    -- CUSTOM ERROR
    -- =====================================================

    s(
        "customerror",
        t({
            "namespace Annar.Errors;",
            "",
            "    ",
            "public class CustomError : Exception {",
            "    public int code { get;}",
            "    public string status { get; }",
            "",
            "    private CustomError(int code, string status, string message): base(message){",
            "        this.code = code;",
            "        this.status = status;",
            "    }",
            "",
            "    public static CustomError BadRequest( string message) => new CustomError(400, \"Bad-Request\", message);",
            "",
            "    public static CustomError Unauthorized( string message) => new CustomError(401, \"Unauthorized\", message);",
            "",
            "    public static CustomError Forbidden( string message) => new CustomError(403, \"Forbidden\", message);",
            "",
            "    public static CustomError NotFound( string message) => new CustomError(404, \"Not-Found\", message);",
            "",
            "    public static CustomError Conflict( string message) => new CustomError(409, \"Conflict\", message);",
            "",
            "    public static CustomError InternalServer( string message) => new CustomError(500, \"Internal-Server\", message);",
            "",
            "}",
        })
    ),

        -- =====================================================
    -- GLOBAL EXCEPTION MIDDLEWARE
    -- =====================================================

    s(
        "globalexceptionmiddleware",
        t({
            "",
            "",
            "",
            "using System.Text.Json;",
            "",
            "using Annar.Errors;",
            "using Annar.Common;",
            "",
            "",
            "namespace Annar.Middlewares;",
            "",
            "",
            "public class GlobalExceptionMiddleware {",
            "",
            "    private readonly RequestDelegate _next;",
            "    ",
            "    public GlobalExceptionMiddleware(RequestDelegate next){",
            "        this._next = next;",
            "    }",
            "    ",
            "    public async Task InvokeAsync(HttpContext context){",
            "        try",
            "        {",
            "            await this._next(context);",
            "        }",
            "        catch (CustomError error)",
            "        {",
            "            context.Response.StatusCode = error.code;",
            "            context.Response.ContentType = \"application/json\";",
            "",
            "            var response = ApiResponse<object>.Error( ",
            "                error.code,",
            "                error.status,",
            "                error.Message",
            "            );",
            "",
            "            await context.Response.WriteAsync(JsonSerializer.Serialize(response));",
            "        }catch(Exception ex){",
            "            context.Response.StatusCode = StatusCodes.Status500InternalServerError;",
            "            context.Response.ContentType = \"application/json\";",
            "",
            "            var response = ApiResponse<object>.Error ( ",
            "                StatusCodes.Status500InternalServerError,",
            "                \"Internal-Server-Error\",",
            "                \"Ha occurido un error interno: \" + ex.Message",
            "            );",
            "",
            "            await context.Response.WriteAsync(JsonSerializer.Serialize(response));",
            "        }",
            "    }",
            "}",
        })
    ),

    -- =====================================================
    -- DB CONTEXT REGISTRATION
    -- =====================================================

    s(
        "adddbcontext",
        t({
            "builder.Services.AddDbContext<AnnarDBContext>( options => {",
            "    options.UseSqlServer(builder.Configuration.GetConnectionString(\"AnnarConnection\"));",
            "});",
        })
    ),

    -- =====================================================
    -- CORS CONFIGURATION
    -- =====================================================

    s(
        "addcors",
        t({
            "// Configuration Cors",
            "builder.Services.AddCors(options => {",
            "    options.AddPolicy(\"AngularPolicy\", policy => {",
            "        policy.WithOrigins(\"http://localhost:4200\")",
            "        .AllowAnyHeader()",
            "        .AllowAnyMethod();",
            "    });",
            "});",
        })
    ),
    -- =====================================================
    -- ANNAR DB CONTEXT
    -- =====================================================

    s(
        "dbcontext",
        t({
            "using Microsoft.EntityFrameworkCore;",
            "using Annar.Models;",
            "",
            "",
            "namespace Annar.Data;",
            "",
            "public class AnnarDBContext : DbContext",
            "{",
            "",
            "    public DbSet<Patient> Patients { get; set; }",
            "",
            "",
            "",
            "    public AnnarDBContext(DbContextOptions<AnnarDBContext> options): base(options) { }",
            "",
            "    protected override void OnModelCreating(ModelBuilder modelBuilder)",
            "    {",
            "",
            "        modelBuilder.Entity<Patient>(entity => {",
            "            entity.ToTable(\"patients\");",
            "",
            "            entity.HasKey(p => p.Id);",
            "",
            "            entity.Property(p => p.Id)",
            "                .HasColumnType(\"UNIQUEIDENTIFIER\")",
            "                .ValueGeneratedOnAdd()",
            "                .HasDefaultValueSql(\"NEWID()\");",
            "",
            "",
            "            entity.Property(p => p.DocumentNumber)",
            "                .HasMaxLength(15)",
            "                .IsRequired();",
            "",
            "            entity.HasIndex(p => p.DocumentNumber)",
            "                .IsUnique();",
            "",
            "            entity.Property(p => p.FullName)",
            "                .HasMaxLength(100)",
            "                .IsRequired();",
            "",
            "            entity.Property(p => p.Email)",
            "                .HasMaxLength(100)",
            "                .IsRequired();",
            "",
            "            entity.HasIndex(p => p.Email)",
            "                .IsUnique();",
            "",
            "",
            "            entity.Property(p => p.BirthDate)",
            "                .HasColumnType(\"DATE\")",
            "                .IsRequired();",
            "",
            "",
            "            entity.Property(p => p.IsActive)",
            "                .HasColumnType(\"BIT\")",
            "                .IsRequired();",
            "        });",
            "    }",
            "",
            "}",
        })
    ),

})


