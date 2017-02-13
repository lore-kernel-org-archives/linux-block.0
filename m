Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "tj@kernel.org"
	<tj@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: Re: [WIP PATCHSET 0/4] WIP branch for bfq-mq
Date: Mon, 13 Feb 2017 22:38:57 +0000
Message-ID: <1487025524.2719.11.camel@sandisk.com>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
	 <1486745110.2840.3.camel@sandisk.com>
	 <1241B224-A446-4C76-87BB-4EA63852B6D1@linaro.org>
	 <4a893c20-5a6b-a16c-073a-57c1a3d91b5a@sandisk.com>
	 <55E6D3EE-27D1-4D46-ABE5-750445FB941B@linaro.org>
	 <1A8DF6A8-C251-472A-9CE1-ACB1BCD0E9AB@linaro.org>
	 <1487023626.2719.9.camel@sandisk.com>
In-Reply-To: <1487023626.2719.9.camel@sandisk.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-02-13 at 22:07 +0000, Bart Van Assche wrote:
> On Mon, 2017-02-13 at 22:07 +0100, Paolo Valente wrote:
> > but what do you think about trying this fix?
> =

> Sorry but with ... the same server I used for the previous test still
> didn't boot up properly. A screenshot is available at
> https://goo.gl/photos/Za9QVGCNe2BJBwxVA.
> =

> > Otherwise, if you have no news or suggestions, would you be willing to
> > try my micro-logging proposal https://github.com/Algodev-github/bfq-mq?
> =

> Sorry but it's not clear to me what logging mechanism you are referring
> to and how to enable it? Are you perhaps referring to
> CONFIG_BFQ_REDIRECT_TO_CONSOLE?

Anyway, a second screenshot has been added to the same album after I had
applied the following patch:

diff --git a/block/Makefile b/block/Makefile
index 1c04fe19e825..bf472ac82c08 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the kernel block layer
 #
 =A0
+KBUILD_CFLAGS +=3D -DCONFIG_BFQ_REDIRECT_TO_CONSOLE
+

 obj-$(CONFIG_BLOCK) :=3D bio.o elevator.o blk-core.o blk-tag.o blk-sysfs.o=
 \
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0blk-f=
lush.o blk-settings.o blk-ioc.o blk-map.o \
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0blk-e=
xec.o blk-merge.o blk-softirq.o blk-timeout.o \

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
