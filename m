Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1486751635.2840.5.camel@sandisk.com>
Date: Fri, 10 Feb 2017 20:33:38 +0100
Cc: "tj@kernel.org" <tj@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Message-Id: <D0578FC1-96A8-4B4D-BAC6-0F52A8697DC3@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org> <1486751635.2840.5.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 10 feb 2017, alle ore 19:34, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Tue, 2017-02-07 at 18:24 +0100, Paolo Valente wrote:
>> (lock assertions, BUG_ONs, ...).
>=20
> Hello Paolo,
>=20
> If you are using BUG_ON(), does that mean that you are not aware of =
Linus'
> opinion about BUG_ON()? Please read https://lkml.org/lkml/2016/10/4/1.
>=20

I am, thanks.  But this is a testing version, overfull of assertions
as a form of hysteric defensive programming.  I will of course remove
all halting assertions in the submission for merging.

Thanks,
Paolo

> Thanks,
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
