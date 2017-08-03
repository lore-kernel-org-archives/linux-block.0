Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] blk-mq: enable checking two part inflight counts at
 the same time
Date: Thu, 3 Aug 2017 21:29:25 +0000
Message-ID: <1501795764.2922.26.camel@wdc.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
	 <1501790516-6924-5-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501790516-6924-5-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-08-03 at 14:01 -0600, Jens Axboe wrote:
>  static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
> @@ -97,17 +98,25 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ct=
x *hctx,
>  {
>  	struct mq_inflight *mi =3D priv;
> =20
> -	if (rq->part =3D=3D mi->part)
> -		mi->inflight++;
> +	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
> +		return;

Should the REQ_ATOM_STARTED test perhaps have been introduced in patch 3/4
instead of in this patch?

> +	if (rq->part =3D=3D mi->part1) {
> +		mi->inflight[0]++;
> +		if (mi->part1->partno &&
> +		    &part_to_disk(mi->part1)->part0 =3D=3D mi->part2)
> +			mi->inflight[1]++;
> +	} else if (rq->part =3D=3D mi->part2)
> +		mi->inflight[1]++;
>  }

So mi->part2 may represent part0 but mi->part1 not? Does that deserve a com=
ment?

Additionally, shouldn't the mi->part2 =3D=3D part0 test be moved out of the=
 if-statement
such that all requests are counted for part0 instead of storing the same co=
unt in
inflight[0] and inflight[1] if mi->part2 =3D=3D part0?

> -unsigned int blk_mq_in_flight(struct request_queue *q,
> -			       struct hd_struct *part)
> +void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part1,
> +		      struct hd_struct *part2, unsigned int *inflight)
>  {

Should inflight be declared as an array to make it clear that it is a point=
er to
an array with two elements?

Thanks,

Bart.=
