Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tj@kernel.org" <tj@kernel.org>, "paolo.valente@linaro.org"
	<paolo.valente@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
Date: Fri, 10 Feb 2017 16:45:23 +0000
Message-ID: <1486745110.2840.3.camel@sandisk.com>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
In-Reply-To: <20170207172446.4528-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-02-07 at 18:24 +0100, Paolo Valente wrote:
> 2) Enable people to test this first version bfq-mq.

Hello Paolo,

I installed this version of bfq-mq on a server that boots from a SATA
disk. That server boots fine with kernel v4.10-rc7 but not with this
tree. The first 30 seconds of the boot process seem to proceed normally
but after that time the messages on the console stop scrolling and
about another 30 seconds later the server reboots. I haven't found
anything useful in the system log. I configured the block layer as
follows:

$ grep '^C.*_MQ_' .config
CONFIG_BLK_MQ_PCI=3Dy
CONFIG_MQ_IOSCHED_BFQ=3Dy
CONFIG_MQ_IOSCHED_DEADLINE=3Dy
CONFIG_MQ_IOSCHED_NONE=3Dy
CONFIG_DEFAULT_MQ_BFQ_MQ=3Dy
CONFIG_DEFAULT_MQ_IOSCHED=3D"bfq-mq"
CONFIG_SCSI_MQ_DEFAULT=3Dy
CONFIG_DM_MQ_DEFAULT=3Dy

Bart.
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
