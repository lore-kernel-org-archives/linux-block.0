Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"fchecconi@gmail.com" <fchecconi@gmail.com>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"avanzini.arianna@gmail.com" <avanzini.arianna@gmail.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "tj@kernel.org" <tj@kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 00/16] Introduce the BFQ I/O scheduler
Date: Wed, 12 Apr 2017 15:30:30 +0000
Message-ID: <1492011029.2764.3.camel@sandisk.com>
References: <20170411134315.44135-1-paolo.valente@linaro.org>
	 <1491921434.2540.1.camel@sandisk.com>
	 <17A56264-D096-4F6E-8E66-50030A10B331@linaro.org>
	 <1491935512.2654.16.camel@sandisk.com>
	 <17416A05-8401-4B03-B46C-78A8976C5B8E@linaro.org>
In-Reply-To: <17416A05-8401-4B03-B46C-78A8976C5B8E@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-04-12 at 08:01 +0200, Paolo Valente wrote:
> Where is my mistake?

I think in the Makefile. How about the patch below? Please note that I'm no
Kbuild expert.

diff --git a/block/Makefile b/block/Makefile
index 546066ee7fa6..b3711af6b637 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -20,7 +20,8 @@ obj-$(CONFIG_IOSCHED_NOOP) =A0=A0=A0+=3D noop-iosched.o
=A0obj-$(CONFIG_IOSCHED_DEADLINE) +=3D deadline-iosched.o
=A0obj-$(CONFIG_IOSCHED_CFQ) =A0=A0=A0=A0=A0+=3D cfq-iosched.o
=A0obj-$(CONFIG_MQ_IOSCHED_DEADLINE) =A0=A0=A0=A0=A0+=3D mq-deadline.o
-obj-$(CONFIG_IOSCHED_BFQ) =A0=A0=A0=A0=A0+=3D bfq-iosched.o bfq-wf2q.o bfq=
-cgroup.o
+bfq-y =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0:=3D bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
+obj-$(CONFIG_IOSCHED_BFQ) =A0=A0=A0=A0=A0+=3D bfq.o
=A0=A0=A0obj-$(CONFIG_BLOCK_COMPAT) =A0=A0=A0=A0+=3D compat_ioctl.o
=A0obj-$(CONFIG_BLK_CMDLINE_PARSER) =A0=A0=A0=A0=A0=A0+=3D cmdline-parser.o
