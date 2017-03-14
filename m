Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"fchecconi@gmail.com" <fchecconi@gmail.com>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"avanzini.arianna@gmail.com" <avanzini.arianna@gmail.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "tj@kernel.org" <tj@kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
Date: Tue, 14 Mar 2017 16:32:47 +0000
Message-ID: <1489509154.2676.6.camel@sandisk.com>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
	 <1488848390.3125.14.camel@sandisk.com>
	 <81048010-02AB-4A7A-8C10-FAF7E3242DCC@linaro.org>
In-Reply-To: <81048010-02AB-4A7A-8C10-FAF7E3242DCC@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-03-14 at 16:35 +0100, Paolo Valente wrote:
> > Il giorno 07 mar 2017, alle ore 02:00, Bart Van Assche <bart.vanassche@=
sandisk.com> ha scritto:
> >=20
> > Additionally, the complexity of the code is huge. Just like for CFQ,
> > sooner or later someone will run into a bug or a performance issue
> > and will post a patch to fix it. However, the complexity of BFQ is
> > such that a source code review alone won't be sufficient to verify
> > whether or not such a patch negatively affects a workload or device
> > that has not been tested by the author of the patch. This makes me
> > wonder what process should be followed to verify future BFQ patches?
>=20
> Third and last, a proposal: why don't we discuss this issue at LSF
> too?  In particular, we could talk about the parts of BFQ that seem
> more complex to understand, until they become clearer to you.  Then I
> could try to understand what helped make them clearer, and translate
> it into extra comments in the code or into other, more radical
> changes.

Hello Paolo,

Sorry if my comment was not clear enough. Suppose that e.g. someone would
like to modify the following code:

static int bfq_min_budget(struct bfq_data *bfqd)
{
       if (bfqd->budgets_assigned < bfq_stats_min_budgets)
               return bfq_default_max_budget / 32;
       else
               return bfqd->bfq_max_budget / 32;
}

How to predict the performance impact of any changes in e.g. this function?
It is really great that a performance benchmark is available. But what shou=
ld
a developer do who only has access to a small subset of all the storage
devices that are supported by the Linux kernel and hence who can not run th=
e
benchmark against every supported storage device? Do developers who do not
fully understand the BFQ algorithms and who run into a performance problem
have any other option than trial and error for fixing such performance issu=
es?

Thanks,

Bart.=
