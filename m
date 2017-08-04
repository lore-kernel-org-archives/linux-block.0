Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/6] blk-mq: enable checking two part inflight counts at
 the same time
Date: Fri, 4 Aug 2017 19:44:35 +0000
Message-ID: <1501875874.2757.28.camel@wdc.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
	 <1501859062-11120-6-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501859062-11120-6-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-08-04 at 09:04 -0600, Jens Axboe wrote:
> @@ -98,11 +98,13 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ct=
x *hctx,
>  		return;
> =20
>  	/*
> -	 * Count as inflight if it either matches the partition we asked
> -	 * for, or if it's the root
> +	 * Count as inflight if it matches the partition, count separately
> +	 * (but all) if we got asked for the root
>  	 */
> -	if (rq->part =3D=3D mi->part || mi->part->partno)
> +	if (rq->part =3D=3D mi->part)
>  		mi->inflight[0]++;
> +	if (mi->part->partno)
> +		mi->inflight[1]++;
>  }

Hello Jens,

Same question here: should "if (mi->part->partno)" perhaps be changed into
"if (mi->part->partno =3D=3D 0)"?

Thanks,

Bart.
