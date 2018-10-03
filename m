Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1538582446.205649.22.camel@acm.org>
Date: Wed, 3 Oct 2018 18:04:02 +0200
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jens Axboe <axboe@kernel.dk>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Jan Kara <jack@suse.cz>,
 Andreas Herrmann <aherrmann@suse.com>,
 Mel Gorman <mgorman@suse.com>,
 Chunyan Zhang <zhang.chunyan@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>,
 Mark Brown <broonie@kernel.org>
Message-Id: <843B42A9-DDE9-46C4-A3AE-616E8DF3946E@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1eca41df95ff660eb247a3de666adeb4@natalenko.name>
 <6AF8CEDE-2720-4206-900A-1A9B914A8FF0@linaro.org>
 <1538582446.205649.22.camel@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 03 ott 2018, alle ore 18:00, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>=20
> On Wed, 2018-10-03 at 17:55 +0200, Paolo Valente wrote:
>> The problem, in particular, is that bfq is a complex beast, fighting
>> against a jungle of I/O issues.  You have to be really into bfq, even
>> to just know all of its features!
>=20
> This is a problem by itself. I don't know anyone who wants to have to =
deal
> with I/O scheduler tunables.
>=20

In fact, I designed and am constantly improving bfq, exactly so that
you don't have to touch any tunable.

Thanks,
Paolo

> Bart.
>=20
