Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1489509154.2676.6.camel@sandisk.com>
Date: Sat, 18 Mar 2017 10:52:12 +0000
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Message-Id: <A8A05E9B-2FDF-4986-833E-166D92DFEF4F@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <1488848390.3125.14.camel@sandisk.com> <81048010-02AB-4A7A-8C10-FAF7E3242DCC@linaro.org> <1489509154.2676.6.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 14 mar 2017, alle ore 16:32, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Tue, 2017-03-14 at 16:35 +0100, Paolo Valente wrote:
>>> Il giorno 07 mar 2017, alle ore 02:00, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>>>=20
>>> Additionally, the complexity of the code is huge. Just like for CFQ,
>>> sooner or later someone will run into a bug or a performance issue
>>> and will post a patch to fix it. However, the complexity of BFQ is
>>> such that a source code review alone won't be sufficient to verify
>>> whether or not such a patch negatively affects a workload or device
>>> that has not been tested by the author of the patch. This makes me
>>> wonder what process should be followed to verify future BFQ patches?
>>=20
>> Third and last, a proposal: why don't we discuss this issue at LSF
>> too?  In particular, we could talk about the parts of BFQ that seem
>> more complex to understand, until they become clearer to you.  Then I
>> could try to understand what helped make them clearer, and translate
>> it into extra comments in the code or into other, more radical
>> changes.
>=20
> Hello Paolo,
>=20
> Sorry if my comment was not clear enough. Suppose that e.g. someone =
would
> like to modify the following code:
>=20
> static int bfq_min_budget(struct bfq_data *bfqd)
> {
>       if (bfqd->budgets_assigned < bfq_stats_min_budgets)
>               return bfq_default_max_budget / 32;
>       else
>               return bfqd->bfq_max_budget / 32;
> }
>=20
> How to predict the performance impact of any changes in e.g. this =
function?
> It is really great that a performance benchmark is available. But what =
should
> a developer do who only has access to a small subset of all the =
storage
> devices that are supported by the Linux kernel and hence who can not =
run the
> benchmark against every supported storage device? Do developers who do =
not
> fully understand the BFQ algorithms and who run into a performance =
problem
> have any other option than trial and error for fixing such performance =
issues?
>=20

Hi Bart,
maybe I got your point even before, but I did not reply consistently.
You are highlighting an important problem, which, I think, can be
stated in more general terms: if one makes a change in any complex
component, which, in its turn, interacts with complex I/O devices,
then it is hard, if ever possible, to prove, that that change will
cause no regression with any possible device, just by speculation.
Actually, facts show that this often holds even for simple components,
given the complexity of the environment in which they work.  Of
course, if not only the component is complex, but who modifies it does
not even fully understand how that component works, then regressions
on untested devices are certainly more probable.

These general considerations are the motivation for my previous
proposals: reduce complexity by breaking into simpler, independent
pieces; fix or improve documentation where needed or useful (why don't
we discuss the most obscure parts at lsfmm?); use a fixed set of
benchmarks to find regressions.  Any other proposal is more than
welcome.

Thanks,
Paolo


> Thanks,
>=20
> Bart.
