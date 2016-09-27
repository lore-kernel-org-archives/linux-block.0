Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35643 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932192AbcI0JZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2016 05:25:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id 6so497112pfl.2
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2016 02:25:48 -0700 (PDT)
Date: Tue, 27 Sep 2016 17:25:36 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] blk-mq: Return invalid cookie if bio was split
Message-ID: <20160927172536.53a1315f@tom-ThinkPad-T450>
In-Reply-To: <20160926230030.GB24200@localhost.localdomain>
References: <20160926230030.GB24200@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 26 Sep 2016 19:00:30 -0400
Keith Busch <keith.busch@intel.com> wrote:

> The only user of polling requires its original request be completed in
> its entirety before continuing execution. If the bio needs to be split
> and chained for any reason, the direct IO path would have waited for just
> that split portion to complete, leading to potential data corruption if
> the remaining transfer has not yet completed.

The issue looks a bit tricky because there is no per-bio place for holding
the cookie, and generic_make_request() only returns the cookie for the
last bio in the current bio list, so maybe we need the following patch too.

Also seems merge case need to take care of too.

---
diff --git a/block/blk-core.c b/block/blk-core.c
index 14d7c0740dc0..f1ab547173f8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1996,6 +1996,8 @@ blk_qc_t generic_make_request(struct bio *bio)
 {
 	struct bio_list bio_list_on_stack;
 	blk_qc_t ret = BLK_QC_T_NONE;
+	blk_qc_t lret;
+	const struct bio *orig = bio;
 
 	if (!generic_make_request_checks(bio))
 		goto out;
@@ -2036,7 +2038,9 @@ blk_qc_t generic_make_request(struct bio *bio)
 		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
 		if (likely(blk_queue_enter(q, false) == 0)) {
-			ret = q->make_request_fn(q, bio);
+			lret = q->make_request_fn(q, bio);
+			if (bio == orig)
+				ret = lret;
 
 			blk_queue_exit(q);
 


> 
> This patch has blk-mq return an invalid cookie if a bio requires splitting
> so that polling does not occur.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  block/blk-mq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c207fa9..6385985 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1311,6 +1311,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  	unsigned int request_count = 0;
>  	struct blk_plug *plug;
>  	struct request *same_queue_rq = NULL;
> +	struct bio *orig = bio;
>  	blk_qc_t cookie;
>  
>  	blk_queue_bounce(q, &bio);
> @@ -1389,7 +1390,7 @@ run_queue:
>  	}
>  	blk_mq_put_ctx(data.ctx);
>  done:
> -	return cookie;
> +	return bio == orig ? cookie : BLK_QC_T_NONE;
>  }
>  
>  /*
> @@ -1404,6 +1405,7 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
>  	unsigned int request_count = 0;
>  	struct blk_map_ctx data;
>  	struct request *rq;
> +	struct bio *orig = bio;
>  	blk_qc_t cookie;
>  
>  	blk_queue_bounce(q, &bio);
> @@ -1467,7 +1469,7 @@ run_queue:
>  	}
>  
>  	blk_mq_put_ctx(data.ctx);
> -	return cookie;
> +	return bio == orig ? cookie : BLK_QC_T_NONE;
>  }
>  
>  /*

