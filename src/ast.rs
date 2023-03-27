pub struct Yacc<'a> {
    pub rules: Vec<YRule<'a>>,
}

pub struct YRule<'a> {
    pub entry: &'a str,
    pub allow_empty: bool,
    pub tokens_list: Vec<YTokens<'a>>,
}

pub struct YTokens<'a> {
    pub tokens: Vec<YToken<'a>>,
}

pub enum YToken<'a> {
    Id(&'a str),
    Terminal(&'a str),
    String(&'a str),
}
