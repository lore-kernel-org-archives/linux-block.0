Subject: Re: [PATCH 2/5] blk-mq: fix potential race in queue restart and
 driver tag allocation
To: linux-block@vger.kernel.org
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
 <1485460098-16608-3-git-send-email-axboe@fb.com>
Cc: bart.vanassche@sandisk.com, hch@lst.de, osandov@fb.com,
 paolo.valente@linaro.org, hare@suse.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <e70e18cb-56fc-ca03-8845-8b1a1dea6953@fb.com>
Date: Thu, 26 Jan 2017 12:52:15 -0700
MIME-Version: 1.0
In-Reply-To: <1485460098-16608-3-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/26/2017 12:48 PM, Jens Axboe wrote:
> Once we mark the queue as needing a restart, re-check if we can
> get a driver tag. This fixes a theoretical issue where the needed
> IO completes _after_ blk_mq_get_driver_tag() fails, but before we
> manage to set the restart bit.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 223b9b080820..8041ad330289 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -928,7 +928,16 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
>  		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
>  			if (!queued && reorder_tags_to_front(list))
>  				continue;
> +
> +			/*
> +			 * We failed getting a driver tag. Mark the queue(s)
> +			 * as needing a restart. Retry getting a tag again,
> +			 * in case the needed IO completed right before we
> +			 * marked the queue as needing a restart.
> +			 */
>  			blk_mq_sched_mark_restart(hctx);
> +			if (!blk_mq_get_driver_tag(rq, &hctx, false))
> +				break;
>  			break;
>  		}
>  		list_del_init(&rq->queuelist);

I screwed this up when splitting up the patchset, that last break needs to
be removed as well, of course. Updated below:


>From 9d68cf9232c06a793e305d10b6d655df4beae928 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@fb.com>
Date: Thu, 26 Jan 2017 12:50:36 -0700
Subject: [PATCH 1/4] blk-mq: fix potential race in queue restart and driver
 tag allocation

Once we mark the queue as needing a restart, re-check if we can
get a driver tag. This fixes a theoretical issue where the needed
IO completes _after_ blk_mq_get_driver_tag() fails, but before we
manage to set the restart bit.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 223b9b080820..5cf013d87c2e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -928,8 +928,16 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
 			if (!queued && reorder_tags_to_front(list))
 				continue;
+
+			/*
+			 * We failed getting a driver tag. Mark the queue(s)
+			 * as needing a restart. Retry getting a tag again,
+			 * in case the needed IO completed right before we
+			 * marked the queue as needing a restart.
+			 */
 			blk_mq_sched_mark_restart(hctx);
-			break;
+			if (!blk_mq_get_driver_tag(rq, &hctx, false))
+				break;
 		}
 		list_del_init(&rq->queuelist);
 
-- 
2.7.4


-- 
Jens Axboe
