Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fQRcJ27X"
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A866CA6
	for <linux-block@vger.kernel.org>; Thu, 14 Dec 2023 10:08:17 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35f684c24c8so280095ab.0
        for <linux-block@vger.kernel.org>; Thu, 14 Dec 2023 10:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702577296; x=1703182096; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0ectwuaqSxd0nUxDWAjp7fuBMyIrZWvG+UsDrhcJXI=;
        b=fQRcJ27XvmJcOm4bjJRJyWf17XXodm6a0BhwAXsC01ue+KECgH3p89v3InMnWwqtyJ
         uQvZDEk8RG7AkRTaTP42DgpPwjBDlFLBoV68MGYRrLPwz8BPrZc8+ibT9pYgLaS0vu3J
         mVOpK7ZBcBMsRx2q+GbdtpEvWd7+I9++ws4eK7pV4qeemMygaamPDTILnuM9vQBHDihz
         AWbmMlOkozCuM2CP8DVTCxDu5kJ0Qejkzjq/LhAsAsC2xyJqUV5GRGuPbOnWPKnx83na
         KIguTy1InGyxGyyRrxxm5dW62mbw8ILAJcH8O5Go/sYExJHfwxhp7WgvgXDI5sX7Zl5N
         GlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577296; x=1703182096;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K0ectwuaqSxd0nUxDWAjp7fuBMyIrZWvG+UsDrhcJXI=;
        b=tMKApQNsAZiqF7Uvam2re7t35Zh9SbMfWJ8uSUiQ8HPiDy5ZmfJM4W3P3voBGeTLP5
         o46E3f3NrfCWJ2A73VIXVLNzFgEA+0G3x4nbcuvF6rf3cj7tLHLS37a5qDYaLMlQRQVp
         CFBm1EMdowHeXVnNhGmtSYLWL8TUUGl1CtvEtA7k+9SGdKsL8tkavWfakiRF+f2JrreN
         tlLwW2DMe/kUiFvWkB7xXt7yybrqZLh+5siiTi6DaTsOmxMszbs++avOVtVMh1a9NQn3
         uQArOMq31Y+B2rA2C/Q8Ftws3c91Xq0e3cGWO1jLSB8nXeIqg8KGLxvcN21a2iSfL8nT
         R2LA==
X-Gm-Message-State: AOJu0Yy4I3iDmwGLRjVtZvzlyg8byeLdLmLmofKlQL5L7lT12KawzlXv
	loRwjkIYpZwYdbHFJFQimE2TyNkrNPjpazg4AmzWoA==
X-Google-Smtp-Source: AGHT+IHo30M2pV4pWynhh0fu1DSJTlrrSo+y+qAZCJ+lhcpAzhRoB+Cu6Tp0UvW67+rpPwqzWc8upA==
X-Received: by 2002:a6b:fe09:0:b0:7b4:2e28:2343 with SMTP id x9-20020a6bfe09000000b007b42e282343mr17013450ioh.1.1702577296224;
        Thu, 14 Dec 2023 10:08:16 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h15-20020a056638338f00b0046658ddba94sm3695477jav.81.2023.12.14.10.08.15
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 10:08:15 -0800 (PST)
Message-ID: <d2b7b61c-4868-45c0-9060-4f9c73de9d7e@kernel.dk>
Date: Thu, 14 Dec 2023 11:08:15 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: improve struct request_queue layout
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It's clearly been a while since someone looked at this, so I gave it a
quick shot. There are few issues in here:

- Random bundling of members that are mostly read-only and often written
- Random holes that need not be there

This moves the most frequently used bits into cacheline 1 and 2, with
the 2nd one being more write intensive than the first one, which is
basically read-only.

Outside of making this work a bit more efficiently, it also reduces the
size of struct request_queue for my test setup from 864 bytes (spanning
14 cachelines!) to 832 bytes and 13 cachelines.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17c0a7d0d319..185ed3770e3a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -367,59 +367,51 @@ struct blk_independent_access_ranges {
 };
 
 struct request_queue {
-	struct request		*last_merge;
-	struct elevator_queue	*elevator;
-
-	struct percpu_ref	q_usage_counter;
+	/*
+	 * The queue owner gets to use this for whatever they like.
+	 * ll_rw_blk doesn't touch it.
+	 */
+	void			*queuedata;
 
-	struct blk_queue_stats	*stats;
-	struct rq_qos		*rq_qos;
-	struct mutex		rq_qos_mutex;
+	struct elevator_queue	*elevator;
 
 	const struct blk_mq_ops	*mq_ops;
 
 	/* sw queues */
 	struct blk_mq_ctx __percpu	*queue_ctx;
 
+	/*
+	 * various queue flags, see QUEUE_* below
+	 */
+	unsigned long		queue_flags;
+
+	unsigned int		rq_timeout;
+
 	unsigned int		queue_depth;
 
+	refcount_t		refs;
+
 	/* hw dispatch queues */
-	struct xarray		hctx_table;
 	unsigned int		nr_hw_queues;
+	struct xarray		hctx_table;
 
-	/*
-	 * The queue owner gets to use this for whatever they like.
-	 * ll_rw_blk doesn't touch it.
-	 */
-	void			*queuedata;
-
-	/*
-	 * various queue flags, see QUEUE_* below
-	 */
-	unsigned long		queue_flags;
-	/*
-	 * Number of contexts that have called blk_set_pm_only(). If this
-	 * counter is above zero then only RQF_PM requests are processed.
-	 */
-	atomic_t		pm_only;
+	struct percpu_ref	q_usage_counter;
 
-	/*
-	 * ida allocated id for this queue.  Used to index queues from
-	 * ioctx.
-	 */
-	int			id;
+	struct request		*last_merge;
 
 	spinlock_t		queue_lock;
 
-	struct gendisk		*disk;
+	int			quiesce_depth;
 
-	refcount_t		refs;
+	struct gendisk		*disk;
 
 	/*
 	 * mq queue kobject
 	 */
 	struct kobject *mq_kobj;
 
+	struct queue_limits	limits;
+
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
 	struct blk_integrity integrity;
 #endif	/* CONFIG_BLK_DEV_INTEGRITY */
@@ -430,24 +422,40 @@ struct request_queue {
 #endif
 
 	/*
-	 * queue settings
+	 * Number of contexts that have called blk_set_pm_only(). If this
+	 * counter is above zero then only RQF_PM requests are processed.
 	 */
-	unsigned long		nr_requests;	/* Max # of requests */
+	atomic_t		pm_only;
+
+	struct blk_queue_stats	*stats;
+	struct rq_qos		*rq_qos;
+	struct mutex		rq_qos_mutex;
+
+	/*
+	 * ida allocated id for this queue.  Used to index queues from
+	 * ioctx.
+	 */
+	int			id;
 
 	unsigned int		dma_pad_mask;
 
+	/*
+	 * queue settings
+	 */
+	unsigned long		nr_requests;	/* Max # of requests */
+
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
 	struct kobject *crypto_kobject;
 #endif
 
-	unsigned int		rq_timeout;
-
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 
 	atomic_t		nr_active_requests_shared_tags;
 
+	unsigned int		required_elevator_features;
+
 	struct blk_mq_tags	*sched_shared_tags;
 
 	struct list_head	icq_list;
@@ -458,11 +466,12 @@ struct request_queue {
 	struct mutex		blkcg_mutex;
 #endif
 
-	struct queue_limits	limits;
+	int			node;
 
-	unsigned int		required_elevator_features;
+	spinlock_t		requeue_lock;
+	struct list_head	requeue_list;
+	struct delayed_work	requeue_work;
 
-	int			node;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace __rcu	*blk_trace;
 #endif
@@ -472,10 +481,6 @@ struct request_queue {
 	struct blk_flush_queue	*fq;
 	struct list_head	flush_list;
 
-	struct list_head	requeue_list;
-	spinlock_t		requeue_lock;
-	struct delayed_work	requeue_work;
-
 	struct mutex		sysfs_lock;
 	struct mutex		sysfs_dir_lock;
 
@@ -500,8 +505,6 @@ struct request_queue {
 	 */
 	struct mutex		mq_freeze_lock;
 
-	int			quiesce_depth;
-
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
 
-- 
Jens Axboe

