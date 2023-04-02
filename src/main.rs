#[macro_use]
extern crate lalrpop_util;

lalrpop_mod!(pub parser);

mod ast;

fn main() {
    let infile = "parser.y";
    let source = std::fs::read_to_string(infile)
        .expect(format!("[Error] input file `{}` not found", infile).as_str());
    let cst = parser::YaccParserParser::new()
        .parse(&source)
        .expect("parse error");
    println!("{:?}", cst);
}
