#[derive(Debug, Clone)]
pub struct Yacc<'a> {
    pub rules: Vec<YRule<'a>>,
}

#[derive(Debug, Clone)]
pub struct YRule<'a> {
    pub entry: &'a str,
    pub allow_empty: bool,
    pub tokens_list: Vec<YTokens<'a>>,
}

#[derive(Debug, Clone)]
pub struct YTokens<'a> {
    pub tokens: Vec<YToken<'a>>,
}

#[derive(Debug, Clone)]
pub enum YToken<'a> {
    Id(&'a str),
    Terminal(&'a str),
    String(&'a str),
}
