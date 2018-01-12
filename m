Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH IMPROVEMENT] block, bfq: limit sectors served with
 interactive weight raising
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <5a9c6573-84a6-ae7b-7058-f202c7187065@applied-asynchrony.com>
Date: Fri, 12 Jan 2018 06:58:05 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 broonie@kernel.org,
 linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com,
 oleksandr@natalenko.name
Message-Id: <12660CC7-AD89-434A-9BEA-BA0B4C362807@linaro.org>
References: <20171228111917.2767-1-paolo.valente@linaro.org>
 <5a9c6573-84a6-ae7b-7058-f202c7187065@applied-asynchrony.com>
To: =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 28 dic 2017, alle ore 15:00, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>=20
>=20
> On 12/28/17 12:19, Paolo Valente wrote:
> (snip half a tech report ;)
>=20
> So either this or the previous patch ("limit tags for writes and async =
I/O"
> can lead to a hard, unrecoverable hang with heavy writes. Since I =
couldn't
> log into the affected system anymore I couldn't get any stack traces, =
blk-mq
> debug output etc. but there was nothing in dmesg/on the console, so it
> wasn't a BUG/OOPS.
>=20
> -h

Hi Holger,
if, as I guess, this problem hasn't gone away for you, I have two
requests:
1) could you share your exact test
2) if nothing happens in my systems with your test, would you be
willing to retry with the dev version of bfq?  It should be able to
tell us what takes to your hang.  If you are willing to do this test,
I'll prepare a branch with everything already configured for you.

Thanks,
Paolo=
