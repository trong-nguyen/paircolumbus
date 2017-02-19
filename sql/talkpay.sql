/*
Name the top 5 twitter users with the most tweets about #talkpay?
    user_name    | tweets 
-----------------+--------
 Pristine Indigo |    123
*/
SELECT user_name,
       count(text) AS tweets
FROM talkpay
WHERE text LIKE '%#talkpay%'
GROUP BY user_name
ORDER BY 2 DESC LIMIT 1;

/*
What is the highest salary mentioned in a #talkpay tweet? (best guess)
Intriguing info, highest of $900k, salary of $500k (prob. bluffing), 
realistically may be around $300k, Google Sn PM Dir
or white male UI dev $300k
or software engineer VP Product $250, jumping from waiter in 2011 $28k, startup
SEE bottom for data
*/
SELECT AVG(salary)
FROM 
(SELECT *
FROM
    (SELECT cast(unnest(regexp_matches(text, '\$([\d]+)k', 'g')) AS int) * 1000 AS salary,
            TEXT('PA') as hour_or_annum, text
     FROM talkpay
     WHERE text LIKE '%#talkpay%'
         AND text ~ '.*\$\d+.*') salary_in_grand
UNION ALL
SELECT *
FROM
    (SELECT cast(unnest(regexp_matches(text, '\$([\d]+)[\-\s]', 'g')) AS int) AS salary,
            TEXT('H or PA') as hour_or_annum, text
     FROM talkpay
     WHERE text LIKE '%#talkpay%'
         AND text ~ '.*\$\d+.*') salary_in_plain
ORDER BY 1 DESC) com;

/*
How many talkpay tweeters tweeted from San Francisco? ;)
 tweets | total 
--------+-------
    576 |  9604
*/
SELECT *
FROM
    (SELECT count(*) AS tweets
     FROM talkpay
     WHERE user_location LIKE '%San Francisco%') a,

    (SELECT count(*) AS total
     FROM talkpay) b;

/*
 salary | hour_or_annum |                                                                        text                                                                         
--------+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------
 900000 | PA            | #talkpay DM "CS College dropout, 130k/year + 20k shares over 4 years, currently trading in the $40-50 range / share (about $900k pre tax)."
 500000 | PA            | .@kelseyinnis @zmagg I'm a grad student and I get paid $500k/yr and you should too! #talkpay
 350000 | PA            | My annual cash income has varied from -$220k to +$350k, and was $0 for many years, &lt;$40k for more years, for comp $250k/yr roles. #talkpay
 300000 | PA            | @triketora don't remember specifics but my last yr at GOOG as Sr PM Dir I was prob $300k. 1st yr @homebrew we paid ourselves $150k #talkpay
 300000 | PA            | #talkpay DM "white male UI dev:                                                                                                                    +
        |               | 2012 - $55k CAD                                                                                                                                    +
        |               | 2013 - $70k CAD                                                                                                                                    +
        |               | 2014 - $200k USD                                                                                                                                   +
        |               | 2015 - $300k USD"
 300000 | PA            | I've always made less working for other people. A lot less.                                                                                        +
        |               |                                                                                                                                                    +
        |               | Tech Support: 15/hr vs 65/hr                                                                                                                       +
        |               | Software: $100k/yr vs $300k/yr                                                                                                                     +
        |               |                                                                                                                                                    +
        |               | #talkpay
 250000 | PA            | #talkpay software engineer, current salary is $120k, highest offer I've gotten was $250k, lowest was $75k
 250000 | PA            | 2009 - Non Profit Founder: $0                                                                                                                      +
        |               | 2011 - Waiter: $28k                                                                                                                                +
        |               | 2012 - CEO: -$14k                                                                                                                                  +
        |               | 2013 - CEO: $50k                                                                                                                                   +
        |               | 2014 - CEO: $110k                                                                                                                                  +
        |               | 2015 - VP Products: $250k                                                                                                                          +
        |               | #talkpay
 250000 | PA            | My annual cash income has varied from -$220k to +$350k, and was $0 for many years, &lt;$40k for more years, for comp $250k/yr roles. #talkpay
 250000 | PA            | #talkpay DM "white male in UI web dev:                                                                                                             +
        |               | 2013: $35k self-employed                                                                                                                           +
        |               | 2014: $170k startup                                                                                                                                +
        |               | 2015: ~$250k current"
 250000 | PA            | 2/3 #talkpay                                                                                                                                       +
        |               | 2006:                                                                                                                                              +
        |               | $75k, 0.08%                                                                                                                                        +
        |               | $56k (pay cut pre-A)                                                                                                                               +
        |               |                                                                                                                                                    +
        |               | 2007:                                                                                                                                              +
        |               | $84k, more equity                                                                                                                                  +
        |               |                                                                                                                                                    +
        |               | 2008 (ACQUIRED):                                                                                                                                   +
        |               | $100k + retention = $250k                                                                                                                          +
        |               |                                                                                                                                                    +
        |               | 2010:                                                                                                                                              +
        |               | $100k, 1.15%
 250000 | PA            | Civil engineer in California $65k start to $250k small/midsize firm partner #talkpay
 250000 | PA            | #talkpay I know people that have walked away from $250k because they didn't like the interview.
 240000 | PA            | Latina SW Engineer                                                                                                                                 +
        |               | west coast                                                                                                                                         +
        |               | 2006: $40k                                                                                                                                         +
        |               | 2015: $240k+                                                                                                                                       +
        |               | #talkpay #POC
 220000 | PA            | #talkpay DM "white male L1 visa. Staff SWE at Goog: $201k + $45k bonus + $220k liquid equity."
 220000 | PA            | My annual cash income has varied from -$220k to +$350k, and was $0 for many years, &lt;$40k for more years, for comp $250k/yr roles. #talkpay
 201000 | PA            | #talkpay DM "white male L1 visa. Staff SWE at Goog: $201k + $45k bonus + $220k liquid equity."
 200000 | PA            | 1994 - $12.50/hr                                                                                                                                   +
        |               | 1998 - $60k/yr +options                                                                                                                            +
        |               | 2000 - $125k/yr                                                                                                                                    +
        |               | 2004 - $160k/yr+bonus                                                                                                                              +
        |               | 2002/2008 - 1099 $100/hr                                                                                                                           +
        |               | 2012 - $200k/yr+bonus                                                                                                                              +
        |               | #talkpay
 200000 | PA            | $200k / yr #talkpay
 200000 | PA            | #talkpay revenue of my projects:                                                                                                                   +
        |               | 2012 - $40k                                                                                                                                        +
        |               | 2013 - $52k                                                                                                                                        +
        |               | 2014 - $45k                                                                                                                                        +
        |               | 2015 - $200k (end-of-year est)
 200000 | PA            | And eventually became a freelancer billing $50-85/hr. Started agency, and was lucky to clear $200k (expenses!). Much higher now. #talkpay
 200000 | PA            | #talkpay BigLaw firm salary info some of the most readily available, since most are lock-step. Mine 2007 - 2012, ranged from $148k - $200k+.
 200000 | PA            | #talkpay $70k/year early startup tech lead, then got to $120k/year for a while, then hit $200k/yr+ just before I decided to do my own thing
 200000 | PA            | #talkpay Pre-tax 1998-2015: $28k-$145k (record high, Sr. Eng. Dir.). Higher ed: ~$200k w/ loan interest. No net change in pay since 2009.
 200000 | PA            | Most money I’ve ever earned ($200k+) was also the year I got laid off. Thanks to constant re-orgs and severance. #talkpay
 200000 | PA            | 2005: $25k (non-tech)                                                                                                                              +
        |               | 2007: $45k - Company A                                                                                                                             +
        |               | 2009: $75k - A                                                                                                                                     +
        |               | 2011: $120k - B                                                                                                                                    +
        |               | 2013: $175k - B                                                                                                                                    +
        |               | 2015: &gt;&gt;$200k - C                                                                                                                            +
        |               | #talkpay B and on are in NYC
 200000 | PA            | 1st job out of school: $55k/yr in Toronto,                                                                                                         +
        |               | 2nd: $100k/yr in Cali,                                                                                                                             +
        |               | GOOG: $200k/yr with bonus/grants, plus ███ GSU/yr for acquihire. #talkpay
 200000 | PA            | @ianpatrickhines: …I'd be willing to pay $200k. #talkpay
 200000 | PA            | #talkpay DM "white male UI dev:                                                                                                                    +
        |               | 2012 - $55k CAD                                                                                                                                    +
        |               | 2013 - $70k CAD                                                                                                                                    +
        |               | 2014 - $200k USD                                                                                                                                   +
        |               | 2015 - $300k USD"
 200000 | PA            | Career #talkpay                                                                                                                                    +
        |               | '06-09 design/dev intern: $12/hr (NC)                                                                                                              +
        |               | '12 design/dev: $60~75k (NYC)                                                                                                                      +
        |               | '13 design/dev: $105k (SF)                                                                                                                         +
        |               | '14 design/dev: $200k (SF)
 200000 | PA            | Software Engineer, Upon Entering Silicon Valley:                                                                                                   +
        |               | 4) $60K/yr -&gt; (raise) $70K/yr -&gt; $85k/yr                                                                                                     +
        |               | 5) $95k/yr                                                                                                                                         +
        |               | 6) $175k/yr -&gt; $200k/yr                                                                                                                         +
        |               | #talkpay
 200000 | PA            | #talkpay computer programmer, $96,000 a year as a contractor on a grant funded project. no benefits. could make $200k at google
*/