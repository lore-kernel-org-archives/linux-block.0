Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V3 00/16] Introduce the BFQ I/O scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1492011029.2764.3.camel@sandisk.com>
Date: Wed, 12 Apr 2017 18:08:02 +0200
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Message-Id: <0E4AC836-F950-4849-BFF7-B055FC318916@linaro.org>
References: <20170411134315.44135-1-paolo.valente@linaro.org> <1491921434.2540.1.camel@sandisk.com> <17A56264-D096-4F6E-8E66-50030A10B331@linaro.org> <1491935512.2654.16.camel@sandisk.com> <17416A05-8401-4B03-B46C-78A8976C5B8E@linaro.org> <1492011029.2764.3.camel@sandisk.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 12 apr 2017, alle ore 17:30, Bart Van Assche =
<Bart.VanAssche@sandisk.com> ha scritto:
>=20
> On Wed, 2017-04-12 at 08:01 +0200, Paolo Valente wrote:
>> Where is my mistake?
>=20
> I think in the Makefile. How about the patch below? Please note that =
I'm no
> Kbuild expert.
>=20

Thank you very much for finding and fixing the bug.  I was working
exactly on that, and had got to the same solution (which I guess is
the only correct one).  I'll apply these changes and resubmit.

Thanks,
Paolo

> diff --git a/block/Makefile b/block/Makefile
> index 546066ee7fa6..b3711af6b637 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -20,7 +20,8 @@ obj-$(CONFIG_IOSCHED_NOOP)    +=3D noop-iosched.o
>  obj-$(CONFIG_IOSCHED_DEADLINE) +=3D deadline-iosched.o
>  obj-$(CONFIG_IOSCHED_CFQ)      +=3D cfq-iosched.o
>  obj-$(CONFIG_MQ_IOSCHED_DEADLINE)      +=3D mq-deadline.o
> -obj-$(CONFIG_IOSCHED_BFQ)      +=3D bfq-iosched.o bfq-wf2q.o =
bfq-cgroup.o
> +bfq-y                          :=3D bfq-iosched.o bfq-wf2q.o =
bfq-cgroup.o
> +obj-$(CONFIG_IOSCHED_BFQ)      +=3D bfq.o
>    obj-$(CONFIG_BLOCK_COMPAT)     +=3D compat_ioctl.o
>  obj-$(CONFIG_BLK_CMDLINE_PARSER)       +=3D cmdline-parser.o
>=20
