Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CE5C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 22:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AD72078E
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 22:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592949801;
	bh=OQ+QeokvDYm4G+sjZg2MPghgpqkt1ZROLOV19sOCAmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xNje/YUxqIAsD+qYIrDTlwIo+eeu6Xd/ofXhycGimCa24NsfvE7CfEfOweUXVpLM1
	 3JcsP9MoB/H4GRqoEAKwdFqmlkkmZBMwRnBQ1YWVQW0Ls4Wpc4jfhc888lPyawZeqU
	 lhVTIph6Gu9+eckJsog7Kvno3PlgkHQnnyCNSVTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389669AbgFWWDU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:03:20 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54078 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbgFWWDS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 18:03:18 -0400
Received: by mail-pj1-f67.google.com with SMTP id i12so56473pju.3;
        Tue, 23 Jun 2020 15:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=li/zoT6ey+RI/mZpf2JVVplPja4A+n7yXfFfXgc7t84=;
        b=sOFRsdaCs3FvkZPDvgrzbfWPm49mFpJditw22GCG+kJ9YY+q8lK837S9ozJaQUOzm5
         wpFLEIU2rO9ZPvGtHoz1+GaDjeBTaskal5bsJAaJ8cphOiEIU83oLY0yZAvkQQiYTuP0
         WWgZI2oN7xPcWY4eJ65MZHwG1OyigHOS0DsjMnCLfARCJCohIL4LfIIgrhLUWRj6yJSy
         dKHzGrz7oTurQmvyblHZXkvTp4fUPWJIZuHngU3PMszxinJfc09NKye2IE9Q6V/8Oe/l
         VXFBuLZKhFo0Gg2onji7EXLGmkYDW4nXEqZeki+To7UZXfm8pJMjUScJqfNlzXqbrIYg
         IYXQ==
X-Gm-Message-State: AOAM5329g8e0vFc5I5MTKQ/sUltXiJ7ajO1hj14+HhueazyZDhgXNYe2
        zT3Zc0MGK0aZ0hNa4jA7WNQ=
X-Google-Smtp-Source: ABdhPJzuiddLwIqL4H2tqrtD50ckLr+spWJ570b8yt7WcIYpQPzqpYg6X1aQHci1TD4CiySP8I2sbA==
X-Received: by 2002:a17:902:6bc6:: with SMTP id m6mr25909543plt.6.1592949795962;
        Tue, 23 Jun 2020 15:03:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h3sm14962351pgk.67.2020.06.23.15.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 15:03:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F28B841C23; Tue, 23 Jun 2020 22:03:12 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, damien.lemoal@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, martin.petersen@oracle.com, satyat@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] block: move request_queue member docs to kdoc
Date:   Tue, 23 Jun 2020 22:03:11 +0000
Message-Id: <20200623220311.8033-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200623220311.8033-1-mcgrof@kernel.org>
References: <20200623220311.8033-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we have a template, expand on the kdoc form for
the request_queue data structure with documentation from
the rest of the members, *only* for information we already
had.

This does not add any new documentation. This just shifts
documentation to kdoc form.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/blkdev.h | 139 ++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 99 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ea319c2b0593..d30bfef893b9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -396,8 +396,38 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
 
 /**
  * struct request_queue - block device driver request queue
+ * @queue_ctx: software queue context
+ * @queue_hw_ctx: hw dispatch queues
+ * @queuedata: the queue owner gets to use this for whatever they like.
+ *	ll_rw_blk doesn't touch it.
+ * @queue_flags: various queue flags, see %QUEUE_* below
+ * @pm_only: Number of contexts that have called blk_set_pm_only(). If this
+ *	counter is above zero then only %RQF_PM and %RQF_PREEMPT requests are
+ *	processed.
+ * @id: ida allocated id for this queue.  Used to index queues from ioctx.
+ * @bounce_gfp: queue needs bounce pages for pages above this limit
+ * @kobj: queue kobject
+ * @mq_kobj: mq queue kobject
+ * @nr_requests: maximum number of of requests
+ * @ksm: Inline crypto capabilities
+ * @nr_zones:
+ * @nr_zones: total number of zones of the device. This is always 0 for regular
+ *	block devices.
+ * @conv_zones_bitmap: bitmap of nr_zones bits which indicates if a zone
+ *	is conventional (bit set) or sequential (bit clear).
+ * @seq_zones_wlock: bitmap of nr_zones bits which indicates if a zone
+ *	is write locked, that is, if a write request targeting the zone was
+ *	dispatched.
+ * @debugfs_mutex: used to protect access to the @ebugfs_dir
  * @debugfs_mutex: used to protect access to the @debugfs_dir
  * @blk_trace: used by blktrace to keep track of setup / tracing
+ * @fq: for flush operations
+ * @td: throttle data
+ * @unused_hctx_list: list used for reusing dead hctx instance in case of
+ *	updating nr_hw_queues.
+ * @unused_hctx_lock: used to protect the @unused_hctx_list
+ * @mq_freeze_lock: protects concurrent access to q_usage_counter by
+ *	percpu_ref_kill() and percpu_ref_reinit().
  * @debugfs_dir: directory created to place debugfs information. This is always
  *	created for make_request and request-based block drivers upon
  *	initialization. blktrace requires for this directory to be created,
@@ -413,67 +443,35 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
  *   o custom solutions such as scsi-generic
  *
  * All partitions share the same request_queue data structure.
+ *
+ * Zoned block device dispatch control is managed by the fields @nr_zones,
+ * @conv_zones_bitmap and @seq_zones_wlock. These fields are fields are
+ * initialized by the low level device driver (e.g. scsi/sd.c).  Stacking
+ * drivers (device mappers) may or may not initialize these fields.
+ * Reads of this information must be protected with blk_queue_enter() /
+ * blk_queue_exit(). Modifying this information is only allowed while
+ * no requests are being processed. See also blk_mq_freeze_queue() and
+ * blk_mq_unfreeze_queue().
  */
 struct request_queue {
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
-
 	struct blk_queue_stats	*stats;
 	struct rq_qos		*rq_qos;
-
 	make_request_fn		*make_request_fn;
-
 	const struct blk_mq_ops	*mq_ops;
-
-	/* sw queues */
 	struct blk_mq_ctx __percpu	*queue_ctx;
-
 	unsigned int		queue_depth;
-
-	/* hw dispatch queues */
 	struct blk_mq_hw_ctx	**queue_hw_ctx;
 	unsigned int		nr_hw_queues;
-
 	struct backing_dev_info	*backing_dev_info;
-
-	/*
-	 * The queue owner gets to use this for whatever they like.
-	 * ll_rw_blk doesn't touch it.
-	 */
 	void			*queuedata;
-
-	/*
-	 * various queue flags, see QUEUE_* below
-	 */
 	unsigned long		queue_flags;
-	/*
-	 * Number of contexts that have called blk_set_pm_only(). If this
-	 * counter is above zero then only RQF_PM and RQF_PREEMPT requests are
-	 * processed.
-	 */
 	atomic_t		pm_only;
-
-	/*
-	 * ida allocated id for this queue.  Used to index queues from
-	 * ioctx.
-	 */
 	int			id;
-
-	/*
-	 * queue needs bounce pages for pages above this limit
-	 */
 	gfp_t			bounce_gfp;
-
 	spinlock_t		queue_lock;
-
-	/*
-	 * queue kobject
-	 */
 	struct kobject kobj;
-
-	/*
-	 * mq queue kobject
-	 */
 	struct kobject *mq_kobj;
 
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
@@ -485,66 +483,32 @@ struct request_queue {
 	int			rpm_status;
 	unsigned int		nr_pending;
 #endif
-
-	/*
-	 * queue settings
-	 */
-	unsigned long		nr_requests;	/* Max # of requests */
-
+	unsigned long		nr_requests;
 	unsigned int		dma_pad_mask;
 	unsigned int		dma_alignment;
-
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
-	/* Inline crypto capabilities */
 	struct blk_keyslot_manager *ksm;
 #endif
-
 	unsigned int		rq_timeout;
 	int			poll_nsec;
-
 	struct blk_stat_callback	*poll_cb;
 	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];
-
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
-
 	struct list_head	icq_list;
 #ifdef CONFIG_BLK_CGROUP
 	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
 	struct blkcg_gq		*root_blkg;
 	struct list_head	blkg_list;
 #endif
-
 	struct queue_limits	limits;
-
 	unsigned int		required_elevator_features;
-
 #ifdef CONFIG_BLK_DEV_ZONED
-	/*
-	 * Zoned block device information for request dispatch control.
-	 * nr_zones is the total number of zones of the device. This is always
-	 * 0 for regular block devices. conv_zones_bitmap is a bitmap of nr_zones
-	 * bits which indicates if a zone is conventional (bit set) or
-	 * sequential (bit clear). seq_zones_wlock is a bitmap of nr_zones
-	 * bits which indicates if a zone is write locked, that is, if a write
-	 * request targeting the zone was dispatched. All three fields are
-	 * initialized by the low level device driver (e.g. scsi/sd.c).
-	 * Stacking drivers (device mappers) may or may not initialize
-	 * these fields.
-	 *
-	 * Reads of this information must be protected with blk_queue_enter() /
-	 * blk_queue_exit(). Modifying this information is only allowed while
-	 * no requests are being processed. See also blk_mq_freeze_queue() and
-	 * blk_mq_unfreeze_queue().
-	 */
 	unsigned int		nr_zones;
 	unsigned long		*conv_zones_bitmap;
 	unsigned long		*seq_zones_wlock;
 #endif /* CONFIG_BLK_DEV_ZONED */
 
-	/*
-	 * sg stuff
-	 */
 	unsigned int		sg_timeout;
 	unsigned int		sg_reserved_size;
 	int			node;
@@ -552,59 +516,36 @@ struct request_queue {
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace __rcu	*blk_trace;
 #endif
-	/*
-	 * for flush operations
-	 */
 	struct blk_flush_queue	*fq;
-
 	struct list_head	requeue_list;
 	spinlock_t		requeue_lock;
 	struct delayed_work	requeue_work;
-
 	struct mutex		sysfs_lock;
 	struct mutex		sysfs_dir_lock;
-
-	/*
-	 * for reusing dead hctx instance in case of updating
-	 * nr_hw_queues
-	 */
 	struct list_head	unused_hctx_list;
 	spinlock_t		unused_hctx_lock;
-
 	int			mq_freeze_depth;
-
 #if defined(CONFIG_BLK_DEV_BSG)
 	struct bsg_class_device bsg_dev;
 #endif
 
 #ifdef CONFIG_BLK_DEV_THROTTLING
-	/* Throttle data */
 	struct throtl_data *td;
 #endif
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
-	/*
-	 * Protect concurrent access to q_usage_counter by
-	 * percpu_ref_kill() and percpu_ref_reinit().
-	 */
 	struct mutex		mq_freeze_lock;
 	struct percpu_ref	q_usage_counter;
-
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
-
 	struct dentry		*debugfs_dir;
-
 #ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
 #endif
-
 	bool			mq_sysfs_init_done;
-
 	size_t			cmd_size;
-
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
-- 
2.26.2

