Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/6] blk-mq: provide internal in-flight variant
Date: Fri, 4 Aug 2017 19:43:06 +0000
Message-ID: <1501875785.2757.27.camel@wdc.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
	 <1501859062-11120-5-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501859062-11120-5-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-08-04 at 09:04 -0600, Jens Axboe wrote:
> +static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
> +				  struct request *rq, void *priv,
> +				  bool reserved)
> +{
> +	struct mq_inflight *mi =3D priv;
> +
> +	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
> +		return;
> +
> +	/*
> +	 * Count as inflight if it either matches the partition we asked
> +	 * for, or if it's the root
> +	 */
> +	if (rq->part =3D=3D mi->part || mi->part->partno)
> +		mi->inflight[0]++;
> +}

Hello Jens,

How to check for the root? Does partno =3D=3D 0 or partno !=3D 0 represent =
the
root? Please note that I'm not familiar with the partition code.

Thanks,

Bart.=
