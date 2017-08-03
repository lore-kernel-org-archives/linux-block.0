Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] blk-mq: provide internal in-flight variant
Date: Thu, 3 Aug 2017 21:25:12 +0000
Message-ID: <1501795510.2922.25.camel@wdc.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
	 <1501790516-6924-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501790516-6924-4-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-08-03 at 14:01 -0600, Jens Axboe wrote:
> +static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
> +				  struct request *rq, void *priv,
> +				  bool reserved)
> +{
> +	struct mq_inflight *mi =3D priv;
> +
> +	if (rq->part =3D=3D mi->part)
> +		mi->inflight++;
> +}
> [ ... ]
> -static inline void part_inc_in_flight(struct request_queue *q,
> -				      struct hd_struct *part, int rw)
> -{
> -	atomic_inc(&part->in_flight[rw]);
> -	if (part->partno)
> -		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
> -}

Hello Jens,

The existing part_inc_in_flight() code includes all requests in the in_flig=
ht
statistics for part0 but the new code in blk_mq_check_inflight() not. Is th=
at
on purpose? Should the rq->part =3D=3D mi->part check perhaps be skipped if
mi->part represents part0?

Thanks,

Bart.=
