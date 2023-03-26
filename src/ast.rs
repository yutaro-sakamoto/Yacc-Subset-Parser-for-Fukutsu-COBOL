pub struct Yacc<'a> {
    pub rules: Vec<Rule<'a>>,
}

pub struct Rule<'a> {
    pub entry: &'a str,
    pub allow_empty: bool,
    pub tokens_list: Vec<Vec<Token<'a>>>,
}

pub enum Token<'a> {
    Terminal(&'a str),
    NonTerminal(&'a str),
    String(&'a str),
}
