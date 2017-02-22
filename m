Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1487025524.2719.11.camel@sandisk.com>
Date: Wed, 22 Feb 2017 22:29:36 +0100
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Message-Id: <62F8F65E-A376-44EB-B53C-C2CFB8F8693F@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org> <1486745110.2840.3.camel@sandisk.com> <1241B224-A446-4C76-87BB-4EA63852B6D1@linaro.org> <4a893c20-5a6b-a16c-073a-57c1a3d91b5a@sandisk.com> <55E6D3EE-27D1-4D46-ABE5-750445FB941B@linaro.org> <1A8DF6A8-C251-472A-9CE1-ACB1BCD0E9AB@linaro.org> <1487023626.2719.9.camel@sandisk.com> <1487025524.2719.11.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 13 feb 2017, alle ore 23:38, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Mon, 2017-02-13 at 22:07 +0000, Bart Van Assche wrote:
>> On Mon, 2017-02-13 at 22:07 +0100, Paolo Valente wrote:
>>> but what do you think about trying this fix?
>>=20
>> Sorry but with ... the same server I used for the previous test still
>> didn't boot up properly. A screenshot is available at
>> https://goo.gl/photos/Za9QVGCNe2BJBwxVA.
>>=20
>>> Otherwise, if you have no news or suggestions, would you be willing =
to
>>> try my micro-logging proposal =
https://github.com/Algodev-github/bfq-mq?
>>=20
>> Sorry but it's not clear to me what logging mechanism you are =
referring
>> to and how to enable it? Are you perhaps referring to
>> CONFIG_BFQ_REDIRECT_TO_CONSOLE?
>=20
> Anyway, a second screenshot has been added to the same album after I =
had
> applied the following patch:
>=20

Hi Bart,
thanks for this second attempt of yours.  Although, unfortunately, not
providing some clear indication of the exact cause of your hang (apart
from a possible deadlock), your log helped me notice another bug.

At any rate, as I have just written to Jens, I have pushed a new
version of the branch [1] (not just added new commits, but also
integrated some old commit with new changes, to make it more quickly).
The branch now contains both a fix for the above bug, and, more
importantly, a fix for the circular dependencies that were still
lurking around.  Could you please test it?

Crossing my fingers,
Paolo

[1] https://github.com/Algodev-github/bfq-mq

> diff --git a/block/Makefile b/block/Makefile
> index 1c04fe19e825..bf472ac82c08 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -2,6 +2,8 @@
> # Makefile for the kernel block layer
> #
> =20
> +KBUILD_CFLAGS +=3D -DCONFIG_BFQ_REDIRECT_TO_CONSOLE
> +
>=20
> obj-$(CONFIG_BLOCK) :=3D bio.o elevator.o blk-core.o blk-tag.o =
blk-sysfs.o \
>                        blk-flush.o blk-settings.o blk-ioc.o blk-map.o =
\
>                        blk-exec.o blk-merge.o blk-softirq.o =
blk-timeout.o \
>=20
> Bart.
> Western Digital Corporation (and its subsidiaries) E-mail =
Confidentiality Notice & Disclaimer:
>=20
> This e-mail and any files transmitted with it may contain confidential =
or legally privileged information of WDC and/or its affiliates, and are =
intended solely for the use of the individual or entity to which they =
are addressed. If you are not the intended recipient, any disclosure, =
copying, distribution or any action taken or omitted to be taken in =
reliance on it, is prohibited. If you have received this e-mail in =
error, please notify the sender immediately and delete the e-mail in its =
entirety from your system.
>=20
