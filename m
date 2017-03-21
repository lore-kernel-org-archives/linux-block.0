Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/4] blk-mq: merge mq and sq make_request instances
Date: Tue, 21 Mar 2017 01:33:13 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0F96D8@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <20170320203930.12533-1-hch@lst.de>
 <20170320203930.12533-3-hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 03/20/2017 04:39 PM, Christoph Hellwig wrote:=0A=
> @@ -1534,7 +1529,36 @@ static blk_qc_t blk_mq_make_request(struct request=
_queue *q, struct bio *bio)=0A=
>  	}=0A=
>  =0A=
>  	plug =3D current->plug;=0A=
> -	if (((plug && !blk_queue_nomerges(q)) || is_sync)) {=0A=
> +	if (plug && q->nr_hw_queues =3D=3D 1) {=0A=
> +		[ ... ]=0A=
> +	} else if (((plug && !blk_queue_nomerges(q)) || is_sync)) {=0A=
>  		struct request *old_rq =3D NULL;=0A=
>  =0A=
>  		blk_mq_bio_to_request(rq, bio);=0A=
=0A=
I think this patch will change the behavior for the plug =3D=3D NULL &&=0A=
q->nr_hw_queues =3D=3D 1 && is_sync case: with this patch applied the code=
=0A=
under "else if" will be executed for that case but that wasn't the case=0A=
before this patch.=0A=
=0A=
Bart.=0A=
