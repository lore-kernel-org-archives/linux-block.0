Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33648 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbcFBIaJ (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2016 04:30:09 -0400
Received: by mail-yw0-f196.google.com with SMTP id y6so5946404ywe.0
        for <linux-block@vger.kernel.org>; Thu, 02 Jun 2016 01:30:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cb7c4181478c6483fa3d5fe499f53cb9dc937f44.1464844522.git.osandov@fb.com>
References: <cb7c4181478c6483fa3d5fe499f53cb9dc937f44.1464844522.git.osandov@fb.com>
Date: Thu, 2 Jun 2016 16:30:08 +0800
Message-ID: <CACVXFVObD6SOvoOYJsVVj+dFHfcbPUmvtxHA_76deVtEH7fDGg@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: really fix plug list flushing for nomerge queues
From: Ming Lei <tom.leiming@gmail.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, Jeff Moyer <jmoyer@redhat.com>,
	linux-block@vger.kernel.org, FB Kernel Team <kernel-team@fb.com>,
	Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 2, 2016 at 1:18 PM, Omar Sandoval <osandov@osandov.com> wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> Commit 0809e3ac6231 ("block: fix plug list flushing for nomerge queues")
> updated blk_mq_make_request() to set request_count even when
> blk_queue_nomerges() returns true. However, blk_mq_make_request() only
> does limited plugging and doesn't use request_count;
> blk_sq_make_request() is the one that should have been fixed. Do that
> and get rid of the unnecessary work in the mq version.
>
> Fixes: 0809e3ac6231 ("block: fix plug list flushing for nomerge queues")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Looks good catch.

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

> ---
> Applies to v4.7-rc1.
>
>  block/blk-mq.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 29cbc1b5fbdb..f9b9049b1284 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1262,12 +1262,9 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>
>         blk_queue_split(q, &bio, q->bio_split);
>
> -       if (!is_flush_fua && !blk_queue_nomerges(q)) {
> -               if (blk_attempt_plug_merge(q, bio, &request_count,
> -                                          &same_queue_rq))
> -                       return BLK_QC_T_NONE;
> -       } else
> -               request_count = blk_plug_queued_count(q);
> +       if (!is_flush_fua && !blk_queue_nomerges(q) &&
> +           blk_attempt_plug_merge(q, bio, &request_count, &same_queue_rq))
> +               return BLK_QC_T_NONE;
>
>         rq = blk_mq_map_request(q, bio, &data);
>         if (unlikely(!rq))
> @@ -1358,9 +1355,11 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
>
>         blk_queue_split(q, &bio, q->bio_split);
>
> -       if (!is_flush_fua && !blk_queue_nomerges(q) &&
> -           blk_attempt_plug_merge(q, bio, &request_count, NULL))
> -               return BLK_QC_T_NONE;
> +       if (!is_flush_fua && !blk_queue_nomerges(q)) {
> +               if (blk_attempt_plug_merge(q, bio, &request_count, NULL))
> +                       return BLK_QC_T_NONE;
> +       } else
> +               request_count = blk_plug_queued_count(q);
>
>         rq = blk_mq_map_request(q, bio, &data);
>         if (unlikely(!rq))
> --
> 2.8.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Ming Lei
