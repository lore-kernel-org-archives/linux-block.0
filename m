Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1525508378.5406.6.camel@gmx.de>
Date: Sat, 5 May 2018 12:39:44 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com,
 oleksandr@natalenko.name
Message-Id: <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
To: Mike Galbraith <efault@gmx.de>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 05 mag 2018, alle ore 10:19, Mike Galbraith <efault@gmx.de> =
ha scritto:
>=20
> On Fri, 2018-05-04 at 21:46 +0200, Mike Galbraith wrote:
>> Tentatively, I suspect you've just fixed the nasty stalls I reported =
a
>> while back.
>=20
> Oh well, so much for optimism.  It took a lot, but just hung.

Yep, it'd have been a lot of luck, being your hang related to
different operations from those touched by this fix.  Maybe
time-before-failure stretched because your system suffered from the
illness cured by this fix too.

BTW, if you didn't run out of patience with this permanent issue yet,
I was thinking of two o three changes to retry to trigger your failure
reliably.  In case of success, I could restart racking my brains from
there.

Thanks,
Paolo=
