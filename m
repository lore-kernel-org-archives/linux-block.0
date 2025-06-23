Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900251E492D
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750677038; cv=none; b=RO679rQ3WK/szY9IJB9vvcvYYWiv23fCc84MC2xysoEEL00ApPrFgb30iTCc7kMCHrXy5xFRAsOsUGmv9KLQuG/b0u6lrkIiymyFAkTQdX1YQxtd9P6ZiG0GHEyIR0xexFf3/Qbg7IXoV/1kHPkZvVAADMTWdW4fziJCRNVgzoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750677038; c=relaxed/simple;
	bh=M/DRTCVIaZjDhAvBGsTuhSkZvV9Pew0Tyjw8rPzR4q8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPXHHymqaSJOmwgLfmJG2RwHMoHDWx3AS5ArFCiR9U+er9nRoz6eFXh5lAStWHSXPVg0/NtnDVLaRAzuHkeYRwEg4/4Nt/TSIoIHC5VLFo4IBsAKLlPeQogQHU6A5rvywdcogtWYbcThDqOVQKNfyTI6G3KcooG/BL8dQV6R9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e9JX8RCF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e9JX8RCF"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c7a52e97so3146073b3a.3
        for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750677036; x=1751281836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXoQxdkEuYn4E6/iuooR5r/F0mWTLqCSrcjI3eKpg4U=;
        b=e9JX8RCF6NDKXsti0aHPeK6ONXbK7SF4HYW6AupESn3WiTPKaHoT3LDYdJSUuRswYp
         h0K0vCAJAw/5YHsd7HqItQUseGchkR7lfI8PmIjQpd9SvuV43uPzvYA4LI1Z6KdEnC0H
         LxCGsISizj3LbelnehTei12fbkM3WwV3OHbRm4Nyjifg4pz9RuoB4bts8icdsuY0IA9w
         Fz+gCQquZtC2RN9F1Jsjra3aKGEFu8Zoz/5YD47rWlUsUfFcqkrn6OmhbJi+AbY++50F
         bV0/+CrPsK6cJ/zbtRJJzvUpSngeTN8iDVqoLbP9nGIUZPXr3AB2YiWo0AHk6FlAWQja
         jyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750677036; x=1751281836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXoQxdkEuYn4E6/iuooR5r/F0mWTLqCSrcjI3eKpg4U=;
        b=a8/B3V/OAf6LafCAwY3AZujvHfo/1AbLXjNxwSq08XquTQToMtYKOrnyFRugFs+SSJ
         GBoZgBor0iGqP8mjCM2kGF77Lvmrjq3oZCsdqAXJlzDK6vsnFBsKKl1GCQAKncbJMzRz
         VhQQvk82NJcpRInEKI6l6qX8hy15mLV6yKiBMokv2hCFoVQAHDGfAmZ0mN6obji/8WQs
         xlAmLeMBQ4sz/H59liKAi4c63XwrLAh6s9PVUH084xXUHHoZDQ+hDteY6+YiZyIZCsIS
         IpAhZ7Hp2PXF/696iyIHHb8AK4D04IRaD9xbDrCiVaC6qPCYcrOrfghuO6ApHBm9A56O
         pc9g==
X-Forwarded-Encrypted: i=1; AJvYcCVhtNsmI1sdgpwpd2TvCA0pHsUjUQdIl2FdVoNqLmyFYk2ZCodeRxGnjOXC3FFPP4A0UDGZENkcWIttEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWHALtPgOEP8rfxDFzyqc7/0GqcCSekLtAz4PaWRZAnhPrkEP
	IaG22kkQoPpoWwxqsagSLP1XLKD66kUvpZWXqSGOlNauwqFVbtoxjmmyZUXZDde80vY=
X-Gm-Gg: ASbGnct1I/usfqB2fQSok0hgLW3reHMLuJqXFsggKSef5+UdNkFqNjAdNryr+nUILKi
	54751WtfE6J+6onUkgMbk0FvaoEQkuk9Ht4BimwmHVBd6LdaD4L9DXEujtr+Sv2ya9a5QOYaciL
	POhky62WW25yhkCiYw3cdPRZyOEu5lHblkh86ZSwiIZ7kska6bYLyOlFE+uyEnWePrfyGYly1Xf
	Dnna5xSiYL3vAyo3oLqGexdRk7BbZOJrZVGzXZVTtd5y+pi1WzRQQug+XOia+yBYqZTHRIf82zU
	rmBYUFf7cCOUx5PELc7U8O2GtfdBcDCtDoicYWACnxt6yPSScdS+BShA2pTB0799AsT74HwavK6
	aMihCa6D54+v3vxSzimS5WPZH
X-Google-Smtp-Source: AGHT+IF/Z91C2aeEPd+2YPxvhi2OEJWqgPtuBQuMInDbh9qE/CPSCMQZvIH4E2M44RLvU9lFaYeH4Q==
X-Received: by 2002:a05:6a20:4324:b0:220:315:20b7 with SMTP id adf61e73a8af0-22026fea1a4mr23799991637.40.1750677035666;
        Mon, 23 Jun 2025 04:10:35 -0700 (PDT)
Received: from HTW5T2C6VL.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a46bc2bsm8113529b3a.28.2025.06.23.04.10.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Jun 2025 04:10:35 -0700 (PDT)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [RFC PATCH] block: Add a workaround for the miss wakeup problem
Date: Mon, 23 Jun 2025 19:10:21 +0800
Message-Id: <20250623111021.64094-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some io hang problems are caused by miss wakeup, and these cases could
be mitigated if io_schedule could be replaced with io_schedule_timeout.
By default, the io_schedule is still executed, and in the case of
problems, a workaround solution can be turned on by
modify io_schedule_timeout_msecs.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/blk-core.c       | 33 +++++++++++++++++++++++++++++++++
 block/blk-iocost.c     |  2 +-
 block/blk-mq-tag.c     |  2 +-
 block/blk-rq-qos.c     |  2 +-
 include/linux/blkdev.h |  2 ++
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdac48aec5ef..722a32f98b95 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -62,6 +62,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_insert);
 
 static DEFINE_IDA(blk_queue_ida);
 
+static unsigned long __read_mostly sysctl_io_schedule_timeout_msecs;
+
 /*
  * For queue allocation
  */
@@ -72,6 +74,18 @@ static struct kmem_cache *blk_requestq_cachep;
  */
 static struct workqueue_struct *kblockd_workqueue;
 
+#ifdef CONFIG_SYSCTL
+static const struct ctl_table kernel_io_schedule_timeout_table[] = {
+	{
+		.procname	= "io_schedule_timeout_msecs",
+		.data		= &sysctl_io_schedule_timeout_msecs,
+		.maxlen		= sizeof(sysctl_io_schedule_timeout_msecs),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+};
+#endif
+
 /**
  * blk_queue_flag_set - atomically set a queue flag
  * @flag: flag to be set
@@ -1250,6 +1264,21 @@ void blk_finish_plug(struct blk_plug *plug)
 }
 EXPORT_SYMBOL(blk_finish_plug);
 
+/**
+ * Maybe it can be integrated into blk_io_schedule?
+ */
+void blk_io_schedule_timeout(void)
+{
+	/* Prevent hang_check timer from firing at us during very long I/O */
+	unsigned long timeout = msecs_to_jiffies(sysctl_io_schedule_timeout_msecs);
+
+	if (timeout)
+		io_schedule_timeout(timeout);
+	else
+		io_schedule();
+}
+EXPORT_SYMBOL_GPL(blk_io_schedule_timeout);
+
 void blk_io_schedule(void)
 {
 	/* Prevent hang_check timer from firing at us during very long I/O */
@@ -1280,5 +1309,9 @@ int __init blk_dev_init(void)
 
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
 
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("kernel", kernel_io_schedule_timeout_table);
+#endif
+
 	return 0;
 }
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5bfd70311359..56aac7ac7a71 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2732,7 +2732,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (wait.committed)
 			break;
-		io_schedule();
+		blk_io_schedule_timeout();
 	}
 
 	/* waker already committed us, proceed */
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d880c50629d6..892704292005 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -185,7 +185,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 			break;
 
 		bt_prev = bt;
-		io_schedule();
+		blk_io_schedule_timeout();
 
 		sbitmap_finish_wait(bt, ws, &wait);
 
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 848591fb3c57..5c81e863c092 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -306,7 +306,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	do {
 		if (data.got_token)
 			break;
-		io_schedule();
+		blk_io_schedule_timeout();
 		set_current_state(TASK_UNINTERRUPTIBLE);
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a59880c809c7..e58353c8523e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1170,6 +1170,8 @@ static inline long nr_blockdev_pages(void)
 
 extern void blk_io_schedule(void);
 
+extern void blk_io_schedule_timeout(void);
+
 int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask);
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-- 
2.39.2 (Apple Git-143)

