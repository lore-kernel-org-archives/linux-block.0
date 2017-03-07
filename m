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
Subject: Re: [PATCH RFC 04/14] block, bfq: modify the peak-rate estimator
Date: Tue, 7 Mar 2017 00:47:50 +0000
Message-ID: <1488847656.3125.10.camel@sandisk.com>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
	 <20170304160131.57366-5-paolo.valente@linaro.org>
In-Reply-To: <20170304160131.57366-5-paolo.valente@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Sat, 2017-03-04 at 17:01 +0100, Paolo Valente wrote:
> +static sector_t get_sdist(sector_t last_pos, struct request *rq)
> +{
> +	sector_t sdist =3D 0;
> +
> +	if (last_pos) {
> +		if (last_pos < blk_rq_pos(rq))
> +			sdist =3D blk_rq_pos(rq) - last_pos;
> +		else
> +			sdist =3D last_pos - blk_rq_pos(rq);
> +	}
> +
> +	return sdist;
> +}

Have you considered to use abs() from <linux/kernel.h>?

Thanks,

Bart.=
