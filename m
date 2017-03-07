Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tj@kernel.org" <tj@kernel.org>, "paolo.valente@linaro.org"
	<paolo.valente@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"fchecconi@gmail.com" <fchecconi@gmail.com>, "avanzini.arianna@gmail.com"
	<avanzini.arianna@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
Date: Tue, 7 Mar 2017 01:00:03 +0000
Message-ID: <1488848390.3125.14.camel@sandisk.com>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
In-Reply-To: <20170304160131.57366-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Sat, 2017-03-04 at 17:01 +0100, Paolo Valente wrote:
> Finally, a few details on the patchset.
>=20
> The first two patches introduce BFQ-v0, which is more or less the
> first version of BFQ submitted a few years ago [1].  The remaining
> patches turn progressively BFQ-v0 into BFQ-v8r8, the current version
> of BFQ.

Hello Paolo,

Thank you for having done the work to improve, test, fix and post the
BFQ scheduler as a patch series. However, from what I have seen in the
patches there is a large number of tunable constants in the code for
which no scientific approach exists to chose an optimal value.
Additionally, the complexity of the code is huge. Just like for CFQ,
sooner or later someone will run into a bug or a performance issue
and will post a patch to fix it. However, the complexity of BFQ is
such that a source code review alone won't be sufficient to verify
whether or not such a patch negatively affects a workload or device
that has not been tested by the author of the patch. This makes me
wonder what process should be followed to verify future BFQ patches?

Thanks,

Bart.=
