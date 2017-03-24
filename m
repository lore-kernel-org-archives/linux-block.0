Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33186 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932626AbdCXR5V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 13:57:21 -0400
Received: by mail-qt0-f194.google.com with SMTP id r45so1386560qte.0
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2017 10:57:20 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] blk-mq: include errors in did_work calculation
From: Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <f82c3ba7-2c19-1bf4-a68b-1793b3a2ac4e@kernel.dk>
Date: Fri, 24 Mar 2017 13:57:17 -0400
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <CD4356AC-F82A-4D3E-91D8-4F309DD69B34@toxicpanda.com>
References: <f82c3ba7-2c19-1bf4-a68b-1793b3a2ac4e@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On Mar 24, 2017, at 1:39 PM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> Currently we return true in blk_mq_dispatch_rq_list() if we queued IO
> successfully, but we really want to return whether or not the we made
> progress. Progress includes if we got an error return.  If we don't,
> this can lead to a hang in blk_mq_sched_dispatch_requests() when a
> driver is draining IO by returning BLK_MQ_QUEUE_ERROR instead of
> manually ending the IO in error and return BLK_MQ_QUEUE_OK.
>=20
> Signed-off-by: Jens Axboe <axboe@fb.com>
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a4546f060e80..e3b09abf9d5b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -978,7 +978,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx =
*hctx, struct list_head *list)
> 	struct request *rq;
> 	LIST_HEAD(driver_list);
> 	struct list_head *dptr;
> -	int queued, ret =3D BLK_MQ_RQ_QUEUE_OK;
> +	int errors, queued, ret =3D BLK_MQ_RQ_QUEUE_OK;
>=20
> 	/*
> 	 * Start off with dptr being NULL, so we start the first request
> @@ -989,7 +989,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx =
*hctx, struct list_head *list)
> 	/*
> 	 * Now process all the entries, sending them to the driver.
> 	 */
> -	queued =3D 0;
> +	errors =3D queued =3D 0;
> 	while (!list_empty(list)) {
> 		struct blk_mq_queue_data bd;
>=20
> @@ -1046,6 +1046,7 @@ bool blk_mq_dispatch_rq_list(struct =
blk_mq_hw_ctx *hctx, struct list_head *list)
> 		default:
> 			pr_err("blk-mq: bad return on queue: %d\n", =
ret);
> 		case BLK_MQ_RQ_QUEUE_ERROR:
> +			errors++;
> 			rq->errors =3D -EIO;
> 			blk_mq_end_request(rq, rq->errors);
> 			break;
> @@ -1097,7 +1098,7 @@ bool blk_mq_dispatch_rq_list(struct =
blk_mq_hw_ctx *hctx, struct list_head *list)
> 			blk_mq_run_hw_queue(hctx, true);
> 	}
>=20
> -	return queued !=3D 0;
> +	return (queued + errors) !=3D 0;
> }
>=20
> static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>=20

Thanks this fixed it, you can add

Tested-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef=
