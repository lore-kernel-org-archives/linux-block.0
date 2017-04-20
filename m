Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-throttle: Suppress a compiler warning
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170419235504.5463-1-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Shaohua Li <shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <089b9e20-c20d-1d10-f230-4aebbb5f03ee@kernel.dk>
Date: Wed, 19 Apr 2017 18:09:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170419235504.5463-1-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 04/19/2017 05:55 PM, Bart Van Assche wrote:
> Avoid that the following warning is reported when building with
> W=1 and with CONFIG_BLK_DEV_THROTTLING_LOW=n:
> 
> block/blk-throttle.c: In function ‘blk_throtl_bio’:
> block/blk-throttle.c:2042:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>   int ret;
>       ^~~
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Shaohua Li <shli@fb.com>
> ---
>  block/blk-throttle.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index c82bf9b1fe72..9081ed9a5345 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2059,6 +2059,10 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
>  	if (ret == 0 || ret == -EBUSY)
>  		bio->bi_cg_private = tg;
>  	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
> +#else
> +	/* Avoid that the compiler complains about not using ret */
> +	if (ret) {
> +	}
>  #endif

Ugh, that may get rid of the warning, but it does not help on
the readability or the ifdefs. How about something like the below?
Naming could probably be improved...


diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c82bf9b1fe72..b78db2e5fdff 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2030,6 +2030,20 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 }
 #endif
 
+static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
+{
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+	int ret;
+
+	ret = bio_associate_current(bio);
+	if (ret == 0 || ret == -EBUSY)
+		bio->bi_cg_private = tg;
+	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
+#else
+	bio_associate_current(bio);
+#endif
+}
+
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
@@ -2039,7 +2053,6 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
 	struct throtl_data *td = tg->td;
-	int ret;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
@@ -2054,12 +2067,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (unlikely(blk_queue_bypass(q)))
 		goto out_unlock;
 
-	ret = bio_associate_current(bio);
-#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	if (ret == 0 || ret == -EBUSY)
-		bio->bi_cg_private = tg;
-	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
-#endif
+	blk_throtl_assoc_bio(tg, bio);
 	blk_throtl_update_idletime(tg);
 
 	sq = &tg->service_queue;

-- 
Jens Axboe
