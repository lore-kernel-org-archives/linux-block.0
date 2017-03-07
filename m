Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tj@kernel.org" <tj@kernel.org>, "paolo.valente@linaro.org"
	<paolo.valente@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"fchecconi@gmail.com" <fchecconi@gmail.com>, "avanzini.arianna@gmail.com"
	<avanzini.arianna@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH RFC 13/14] block, bfq: boost the throughput with random
 I/O on NCQ-capable HDDs
Date: Tue, 7 Mar 2017 00:54:06 +0000
Message-ID: <1488848033.3125.12.camel@sandisk.com>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
	 <20170304160131.57366-14-paolo.valente@linaro.org>
In-Reply-To: <20170304160131.57366-14-paolo.valente@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Sat, 2017-03-04 at 17:01 +0100, Paolo Valente wrote:
> @@ -8301,7 +8297,7 @@ static struct blkcg_policy blkcg_policy_bfq =3D {
>  static int __init bfq_init(void)
>  {
>  	int ret;
> -	char msg[50] =3D "BFQ I/O-scheduler: v6";
> +	char msg[50] =3D "BFQ I/O-scheduler: v7r3";
> =20
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
>  	ret =3D blkcg_policy_register(&blkcg_policy_bfq);

In the Linux kernel the kernel as a whole has a version number but we
do not assign a version number to individual core components.

Bart.=
