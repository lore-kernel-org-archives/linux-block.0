Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C13C3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 21:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9782722DD6
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 21:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfHTVVO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:21:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41050 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTVVN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 17:21:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so4129453pfz.8
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 14:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dud9yN/yGcd36s8g6IFmHXpjoH6Dc2KsLywQjwuNLgE=;
        b=X+kX5H/sDLqNsrnVWJZoU2txMKuwBFoB9/gsy7Pjf5t2ErIrbyhfNTMkwF1c7+N4pp
         TZSwpIl85/+Q6act3VEBCWT/xs+Xcoo2WrvMuwROMHYn94FaulYT1ejFqRcMJxKhZOkW
         DN9xg2UYTq0IvPWPOtPMJ/3iqtoVear/l2+VfbZNVcFH1Y3SIa5dIIx4FlzOZWrP9HM+
         PpLXmGg/ZIR+DjjbgL6ZLTjSGaIyKm3LqJcCAiLtqOWCLR/Mjg3YtnDw+HXJUHSLeoJd
         GUdKrCkTvQuY5VMgNpX2+kcP5cuAoMglbekVjdty9Cp13VwFK6O/V6g2D3JntSwJkJ1F
         QLJg==
X-Gm-Message-State: APjAAAU+lzJGjeSxbP6ozM3gVLMtIdwLPLU8wGaikUkVshH/xugfSRmB
        O1A7lGLSz5VZqJXijQiWhkok6S3O
X-Google-Smtp-Source: APXvYqz6LI3q6jEZLTXl5LH2NZUdkN79wB/J6pzZ36Z6trE/bGfPdxc8z04zMWPA3yvyjPhgr9yGAw==
X-Received: by 2002:a62:e515:: with SMTP id n21mr32569321pff.186.1566336073088;
        Tue, 20 Aug 2019 14:21:13 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g2sm38998669pfq.88.2019.08.20.14.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 14:21:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] block: don't acquire .sysfs_lock before removing mq &
 iosched kobjects
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190816135506.29253-1-ming.lei@redhat.com>
Message-ID: <09092247-1623-57ff-6297-1abd9a8cc8a2@acm.org>
Date:   Tue, 20 Aug 2019 14:21:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816135506.29253-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/19 6:55 AM, Ming Lei wrote:
> @@ -567,8 +568,17 @@ int elevator_switch_mq(struct request_queue *q,
>   	lockdep_assert_held(&q->sysfs_lock);
>   
>   	if (q->elevator) {
> -		if (q->elevator->registered)
> +		if (q->elevator->registered) {
> +			/*
> +			 * sysfs write is exclusively, release
> +			 * sysfs_lock for avoiding deadlock with
> +			 * sysfs built-in lock which is required
> +			 * in either .show or .store path.
> +			 */
> +			mutex_unlock(&q->sysfs_lock);
>   			elv_unregister_queue(q);
> +			mutex_lock(&q->sysfs_lock);
> +		}
>   		ioc_clear_queue(q);
>   		elevator_exit(q, q->elevator);
>   	}

Hi Ming,

I don't like this part of the patch. Consider the following call chain:

queue_attr_store() -> elv_iosched_store() -> __elevator_change() ->
elevator_switch() -> elevator_switch_mq().

queue_attr_store() locks sysfs_lock to serialize sysfs attribute show
and store callbacks. So the above changes unlocks sysfs_lock from inside
such a callback function and hence breaks that serialization. Can you
have a look at the alternative patch below?

Thanks,

Bart.


Subject: [PATCH] block: Fix lock inversion triggered during request queue removal

Call blk_mq_unregister_dev() after having deleted q->kobj. Move
the kobject_uevent(q->mq_kobj, KOBJ_REMOVE) call from inside
blk_mq_unregister_dev() to its caller.

---
  block/blk-mq-sysfs.c |  5 ++---
  block/blk-sysfs.c    | 19 +++----------------
  block/elevator.c     |  2 --
  3 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index d6e1a9bd7131..0ec968009791 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -270,16 +270,15 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
  	struct blk_mq_hw_ctx *hctx;
  	int i;

-	lockdep_assert_held(&q->sysfs_lock);
-
  	queue_for_each_hw_ctx(q, hctx, i)
  		blk_mq_unregister_hctx(hctx);

-	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
  	kobject_del(q->mq_kobj);
  	kobject_put(&dev->kobj);

+	mutex_lock(&q->sysfs_lock);
  	q->mq_sysfs_init_done = false;
+	mutex_unlock(&q->sysfs_lock);
  }

  void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 977c659dcd18..e6f8cd99aded 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -1029,31 +1029,18 @@ void blk_unregister_queue(struct gendisk *disk)
  	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
  		return;

-	/*
-	 * Since sysfs_remove_dir() prevents adding new directory entries
-	 * before removal of existing entries starts, protect against
-	 * concurrent elv_iosched_store() calls.
-	 */
-	mutex_lock(&q->sysfs_lock);
-
  	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);

-	/*
-	 * Remove the sysfs attributes before unregistering the queue data
-	 * structures that can be modified through sysfs.
-	 */
  	if (queue_is_mq(q))
-		blk_mq_unregister_dev(disk_to_dev(disk), q);
-	mutex_unlock(&q->sysfs_lock);
-
+		kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
  	kobject_uevent(&q->kobj, KOBJ_REMOVE);
  	kobject_del(&q->kobj);
  	blk_trace_remove_sysfs(disk_to_dev(disk));

-	mutex_lock(&q->sysfs_lock);
+	if (queue_is_mq(q))
+		blk_mq_unregister_dev(disk_to_dev(disk), q);
  	if (q->elevator)
  		elv_unregister_queue(q);
-	mutex_unlock(&q->sysfs_lock);

  	kobject_put(&disk_to_dev(disk)->kobj);
  }
diff --git a/block/elevator.c b/block/elevator.c
index 2f17d66d0e61..128e7cf032e1 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -495,8 +495,6 @@ int elv_register_queue(struct request_queue *q)

  void elv_unregister_queue(struct request_queue *q)
  {
-	lockdep_assert_held(&q->sysfs_lock);
-
  	if (q) {
  		struct elevator_queue *e = q->elevator;

