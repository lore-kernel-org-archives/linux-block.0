Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E7249E5
	for <linux-block@vger.kernel.org>; Thu, 29 May 2025 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748555424; cv=none; b=a6z6uVv9s8s7ICNofwng5+Up53DlLyf+L5LYLhcnmC5W180LNJfAJ8/37t6jgV7S4Yjf+uGadoSadgDfHNUauIjxsU5rWke6jGVtsF4YuDvWTSYwpT2A0mx7TPqETQsYLbER/SU/cLGzR0qRFNyD7IEHUwwzHH0LidM40WCkFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748555424; c=relaxed/simple;
	bh=x+sIJSNwulo3ssa5P9RyaxIrMG2iFN9nT6hHod6g0Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIphhISI5UDtWoHv9GmQ+E5Q9H9K+tnIAMSm0XSHQexSGPKnSIQotXtMriU0eFIicwOBJ2q+Sd1iW67MakREogSP1LbE/3X1iHNChtpbNfWdtGdSxcC0bb4V+NfcbBHNpdozAgT57rYJcMy1jOVIdxmwqTHEdAR87SaiWtf0muQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gDiKd1/7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gDiKd1/7"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-231e8553248so14280955ad.1
        for <linux-block@vger.kernel.org>; Thu, 29 May 2025 14:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748555420; x=1749160220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rP04lYlYhCzSKYbIYDEOX6Aw1AXsd7vtsQQ8TB3garM=;
        b=gDiKd1/7T8j7pDdtqf1JV1RDGO7WzTj4GRjmAA8GThzbNv0gWlGihQufGgKBO4BvkQ
         +Urvt6zTV6jMRcAmkNo4ekdFmdMNH1vIDNsTztLrJB7K8lFDl61a2JnN8Uz9u4D6FeyK
         VHkJRPBWuzQYXYAxm59gLxIgHfVUQXiZV7RTQKEgu7PiXS9Th+JZZ8VpmynGvLTNQgdf
         ddjk9sIt/yZcRoZqYFV8qHejmwnjYid3pEc+U12iSUvu+vY9eoavNjvUpQnSqagH92yF
         dpDGa3Ja/+CBU0IJz1L1A5WoPFYJ2CF31ZyzZaS0H9l7junNduUHmEn26MundbQrv974
         xbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748555420; x=1749160220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rP04lYlYhCzSKYbIYDEOX6Aw1AXsd7vtsQQ8TB3garM=;
        b=fnN8lmYv6OqVGF0/hk6xyBXhmVmbWmtbfT2xSrLlydHrFM+/utgFfYFAT87eGbpwfP
         mF/Goj3netO/XhxIcawS0S5wrlRhK/FXf3GPzcIN3TyR5pGbpeR8fwY2QHVxpCqC7Pu5
         hZf3BuNcvyOJNUbHCa/UFOJShx4xJ3B0C/YiiQCqgpZcCXGiY0IXBz0qmxT9LBvaavJo
         c6DaC5AoZs+aSVl0waZsm1niZZUF7wUZ0uVkOSaXLAnM4Mi/ITdo+4dgl0xZw+bgTePz
         n+BH/xGgTWLap6K2KGPWTjuheUyO9m5Eh81PmYgxDXv94QEPFAp72SJFMJ9JCJcGvRo8
         Vlrw==
X-Forwarded-Encrypted: i=1; AJvYcCUcvBvCxE8Tnw+TBvr9WqKXFmz9PHADOQV2JrD56rcFVXtc0W9BIXTKH9ITa5G8UaoB4wT2L+c3ZtzPsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHCyN8aA2u27NU+a5VVwf2H/GvAVDlzLAyxldeGL7GlGeZJmo
	fqe0VburQeoCsbIqPrfaSVvTtR9yUVBbYHJgawBEDu/DCroPkYz0WPoRgTyfWHzt+d8=
X-Gm-Gg: ASbGncs69WiVllE/2XF0l+BNIY9aajy8tfq3vVtN5ItP1a2h6+PMhy13JsfU7JKSgXF
	yI7yhYrbNI+ipkqAaLIgWK2AQz3KF3PRaodqIgn0Y2/wf49nkkz70mufG/ewnUJ0h4VG3IFvJ4n
	+CWv1HGV0zfqv2+UDAlESowup2FcMidsKha5ksg8RkZ3x30x3dphkKdVUUYqf0mBBPaimbDi3gh
	Vdzrs7R/ysEtAzy2vSJ6iTyFgiZeXCx9RnXFR2DJQDMMOqQlfGQLQfQdTPKh0Lv4LzAgGLkZUWy
	EQwmfFhs3fDMRaeU8Z5obL8zvjQMsaPfryWVhZCmGvAbSXu1rLcUKFsh3V8d3aOfCW00K9QYJQc
	=
X-Google-Smtp-Source: AGHT+IG0nN5FxWPpsof9ZPbRsP2V6n/QqXkYMji1Ib8QOq0dFqjz8mtVxzH2o1QOtFy+/EyOLFY7nw==
X-Received: by 2002:a17:902:d4c1:b0:235:7c6:ebbf with SMTP id d9443c01a7336-23529506db3mr16952215ad.35.1748555420519;
        Thu, 29 May 2025 14:50:20 -0700 (PDT)
Received: from dev-mkhalfella.purestorage.com ([2620:125:9007:640:ffff::a2e9])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23506cf523esm16698255ad.170.2025.05.29.14.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 14:50:19 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Michael Liang <mliang@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>
Subject: [PATCH] block: Fix blk_sync_queue() to properly stop timeout timer
Date: Thu, 29 May 2025 15:49:28 -0600
Message-ID: <20250529214928.2112990-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ 5084.255110] INFO: task kworker/42:1H:914 blocked for more than 917 seconds.
[ 5084.255563]       Not tainted 5.14.0-503.22.1mk.el9.x86_64 #6
[ 5084.255966] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5084.256421] task:kworker/42:1H   state:D stack:0     pid:914   tgid:914   ppid:2      flags:0x00004000
[ 5084.256794] Workqueue: kblockd blk_mq_timeout_work
[ 5084.257200] Call Trace:
[ 5084.257557]  <TASK>
[ 5084.257909]  __schedule+0x229/0x550
[ 5084.258322]  schedule+0x2e/0xd0
[ 5084.258665]  schedule_timeout+0x11f/0x160
[ 5084.259003]  __wait_for_common+0x90/0x1d0
[ 5084.259414]  ? __pfx_schedule_timeout+0x10/0x10
[ 5084.259740]  __flush_work.isra.0+0x160/0x230
[ 5084.260072]  ? __pfx_wq_barrier_func+0x10/0x10
[ 5084.260390]  __cancel_work_sync+0x104/0x1a0
[ 5084.260701]  ? __timer_delete_sync+0x2c/0x40
[ 5084.261008]  nvme_sync_io_queues+0x53/0xa0 [nvme_core]
[ 5084.261399]  __nvme_fc_abort_outstanding_ios+0x1b8/0x250 [nvme_fc]
[ 5084.261700]  nvme_fc_error_recovery+0x2d/0x50 [nvme_fc]
[ 5084.261997]  nvme_fc_timeout.cold+0x12/0x24 [nvme_fc]
[ 5084.262353]  blk_mq_handle_expired+0x7e/0x160
[ 5084.262637]  bt_iter+0x8b/0xa0
[ 5084.262912]  blk_mq_queue_tag_busy_iter+0x2b8/0x590
[ 5084.263224]  ? __pfx_blk_mq_handle_expired+0x10/0x10
[ 5084.263490]  ? __pfx_blk_mq_handle_expired+0x10/0x10
[ 5084.263748]  ? __call_rcu_common.constprop.0+0x210/0x2b0
[ 5084.264002]  blk_mq_timeout_work+0x162/0x1b0
[ 5084.264307]  process_one_work+0x194/0x380
[ 5084.264550]  worker_thread+0x2fe/0x410
[ 5084.264788]  ? __pfx_worker_thread+0x10/0x10
[ 5084.265019]  kthread+0xdd/0x100
[ 5084.265306]  ? __pfx_kthread+0x10/0x10
[ 5084.265527]  ret_from_fork+0x29/0x50
[ 5084.265741]  </TASK>

nvme-fc initiator hit hung_task with stacktrace above while handling
request timeout call. The work thread is waiting for itself to finish
which is never going to happen. From the stacktrace the nvme controller
was in NVME_CTRL_CONNECTING state when nvme_fc_timeout() was called.
We do not expect to get IO timeout call in NVME_CTRL_CONNECTING state
because blk_sync_queue() must have been called on this queue before
switching from NVME_CTRL_RESETTING to NVME_CTRL_CONNECTING.

It turned out that blk_sync_queue() did not stop q->timeout_work from
running as expected. nvme_fc_timeout() returned BLK_EH_RESET_TIMER
causing q->timeout to be rearmed after it was canceled earlier.
q->timeout queued q->timeout_work after the controller switched to
NVME_CTRL_CONNECTING state causing deadlock above.

Add QUEUE_FLAG_NOTIMEOUT queue flag to tell q->timeout not to queue
q->timeout_work while queue is being synced. Update blk_sync_queue() to
cancel q->timeout_work first and then cancel q->timeout.

Fixes: 287922eb0b18 ("block: defer timeouts to a workqueue")
Fixes: 4e9b6f20828a ("block: Fix a race between blk_cleanup_queue() and timeout handling")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Reviewed-by: Michael Liang <mliang@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
---
 block/blk-core.c       | 10 ++++++++--
 block/blk-mq-debugfs.c |  1 +
 include/linux/blkdev.h |  2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b862c66018f2..8b70c0202f07 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -219,8 +219,11 @@ EXPORT_SYMBOL_GPL(blk_status_to_str);
  */
 void blk_sync_queue(struct request_queue *q)
 {
-	timer_delete_sync(&q->timeout);
+	blk_queue_flag_set(QUEUE_FLAG_NOTIMEOUT, q);
+	synchronize_rcu();
 	cancel_work_sync(&q->timeout_work);
+	timer_delete_sync(&q->timeout);
+	blk_queue_flag_clear(QUEUE_FLAG_NOTIMEOUT, q);
 }
 EXPORT_SYMBOL(blk_sync_queue);
 
@@ -383,7 +386,10 @@ static void blk_rq_timed_out_timer(struct timer_list *t)
 {
 	struct request_queue *q = from_timer(q, t, timeout);
 
-	kblockd_schedule_work(&q->timeout_work);
+	rcu_read_lock();
+	if (!blk_queue_notimeout(q))
+		kblockd_schedule_work(&q->timeout_work);
+	rcu_read_unlock();
 }
 
 static void blk_timeout_work(struct work_struct *work)
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 29b3540dd180..a98ff6fbf75d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -81,6 +81,7 @@ static int queue_pm_only_show(void *data, struct seq_file *m)
 #define QUEUE_FLAG_NAME(name) [QUEUE_FLAG_##name] = #name
 static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(DYING),
+	QUEUE_FLAG_NAME(NOTIMEOUT),
 	QUEUE_FLAG_NAME(NOMERGES),
 	QUEUE_FLAG_NAME(SAME_COMP),
 	QUEUE_FLAG_NAME(FAIL_IO),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 332b56f323d9..c0e6a18f5325 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -633,6 +633,7 @@ struct request_queue {
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
 enum {
 	QUEUE_FLAG_DYING,		/* queue being torn down */
+	QUEUE_FLAG_NOTIMEOUT,		/* do not schedule timeout work */
 	QUEUE_FLAG_NOMERGES,		/* disable merge attempts */
 	QUEUE_FLAG_SAME_COMP,		/* complete on same CPU-group */
 	QUEUE_FLAG_FAIL_IO,		/* fake timeout */
@@ -657,6 +658,7 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
 #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
+#define blk_queue_notimeout(q)	test_bit(QUEUE_FLAG_NOTIMEOUT, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
 #define blk_queue_noxmerges(q)	\
 	test_bit(QUEUE_FLAG_NOXMERGES, &(q)->queue_flags)
-- 
2.49.0

