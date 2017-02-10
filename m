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
Date: Fri, 10 Feb 2017 16:08:51 +0000
Message-ID: <1486742918.2840.1.camel@sandisk.com>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
In-Reply-To: <20170207172446.4528-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-02-07 at 18:24 +0100, Paolo Valente wrote:
> [1] https://github.com/Algodev-github/bfq-mq

Hello Paolo,

That branch includes two changes of the version suffix (EXTRAVERSION in Mak=
efile).
Please don't do that but set CONFIG_LOCALVERSION in .config to add a suffix=
 to
the kernel version string.

Thanks,

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
