Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1486745110.2840.3.camel@sandisk.com>
Date: Fri, 10 Feb 2017 17:49:32 +0100
Cc: "tj@kernel.org" <tj@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Message-Id: <1241B224-A446-4C76-87BB-4EA63852B6D1@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org> <1486745110.2840.3.camel@sandisk.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 10 feb 2017, alle ore 17:45, Bart Van Assche =
<Bart.VanAssche@sandisk.com> ha scritto:
>=20
> On Tue, 2017-02-07 at 18:24 +0100, Paolo Valente wrote:
>> 2) Enable people to test this first version bfq-mq.
>=20
> Hello Paolo,
>=20
> I installed this version of bfq-mq on a server that boots from a SATA
> disk. That server boots fine with kernel v4.10-rc7 but not with this
> tree. The first 30 seconds of the boot process seem to proceed =
normally
> but after that time the messages on the console stop scrolling and
> about another 30 seconds later the server reboots. I haven't found
> anything useful in the system log. I configured the block layer as
> follows:
>=20
> $ grep '^C.*_MQ_' .config
> CONFIG_BLK_MQ_PCI=3Dy
> CONFIG_MQ_IOSCHED_BFQ=3Dy
> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> CONFIG_MQ_IOSCHED_NONE=3Dy
> CONFIG_DEFAULT_MQ_BFQ_MQ=3Dy
> CONFIG_DEFAULT_MQ_IOSCHED=3D"bfq-mq"
> CONFIG_SCSI_MQ_DEFAULT=3Dy
> CONFIG_DM_MQ_DEFAULT=3Dy
>=20

Could you reconfigure with none or mq-deadline as default, check
whether the system boots, and, it it does, switch manually to bfq-mq,
check what happens, and, in the likely case of a failure, try to get
the oops?

Thank you very much,
Paolo

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
