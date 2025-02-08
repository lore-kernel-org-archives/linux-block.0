Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848771A8F71
	for <linux-block@vger.kernel.org>; Sat,  8 Feb 2025 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005585; cv=none; b=G7/vG2p7ul/ngBh01YjLgEZhHMlvQ/VFNna2hOH/T2EnxuNo0MGkvufkqq7x/KacWvLkeugmcIEbp1DL06IAG6YQmWV91iq0pYbmIs0OSLK9hOftuLV/byMTYc3mLsxn4+dj+SCxqkiRHCSb9PyqFWegxuskhQEgqfE0J8sMyXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005585; c=relaxed/simple;
	bh=+a6/zIR7aUtVLh/xqg8uHFhRgBSdM5hg5CQ8TUtP3fU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KRbhCTLl1P2wdHQ9D9RH3NDBFSM0jKaXbGNWsufx81oOL+xvZLuNQzcbpyaQ5H/hI1bsbEyeKRVDp+C4bQmNTIUX7S6TnmBrf2IK4I0TNpzYxzXNnDmUsXfYPkejEuo6yftUBaZmn8wC6j0EwXzIQncztrIYgcMevOGGTJU3MS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YHP9OysS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YHP9OysS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9bac7699aso4212330a91.1
        for <linux-block@vger.kernel.org>; Sat, 08 Feb 2025 01:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739005583; x=1739610383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VimOFsgw+Swp8E6M/LlYfD+laUfW9cNd9WZmqvSJYZM=;
        b=YHP9OysS4YlmXwtCnj8VUgHtvihYqa93pVQNVklHruiEykX1qHV0BQTi3TBR15R7NE
         +kR5Uqwf9YMcVXnxnHaNgrRUKaLwH0fIAKGRW0Crig9/r5hYzouxWvsKZkhiLCRZOxqx
         W/W0zjyYnMSsn+DCvvonpItC3blD7nx1yXo9N8TqaoyWq7khuyd+CWchpYUe/QucaDZL
         xeUqKNBULn7vUCoEWZf0QZovCqz8hCFGRvvU23zusJRzTNNKzwHcyXjKcPyWpeyjcO6+
         b7/Tu21I2xhEzlb/zgXiU9ZQP16H8y0ud/8wJp/Ts0Vm2WDTnxM/tR7t95CcazTzgVIe
         efbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739005583; x=1739610383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VimOFsgw+Swp8E6M/LlYfD+laUfW9cNd9WZmqvSJYZM=;
        b=Mt7coOV/VGyqpLoROHcaUFI/ecAGh4qo7vabnsj+kFWRffx1SDjUppAHUAjOJkkUF/
         uX93UbusblZRZqlYlxYOleeHMHdy2FNAf/XzFRLUeWGP7wvqM79d3aKNW5+SIP8pMebQ
         4T7N8pI84sowO9zY6nHNaAJ14579CtfuGCWkr9YRFimz9+LmiIMXUu8CnzfAEH0AyVzE
         UKvckVec0G7OKM+6nf5Fcf+vBl7PiZaDDPDe/kVfKiGD8Q9hhqsNEYKpyFQXjplv9p5n
         n383p9sCSVOTIjocYEK6jMuvbq6paHqvO2MZpX1lXGyjYo/ovNWNRST+/8dWJgI+Ci17
         +okg==
X-Forwarded-Encrypted: i=1; AJvYcCWpiWjQNP0vzGGtSxMmOe3/KbajTR7pLwSuG3PnX0wxmytQWYLCvKV18M9aIYzRp/rESujUNzM+gmYDpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYMHRTOUprXL71Y/MkpsJuU7rRcLeJF6X0HRlnNP6SSdELWMY
	ohslbfNbXRCKfEZdKubB/SKOZU47cgmDu2FjySwRs4HyjsYX12WYh2W36Pjgllc=
X-Gm-Gg: ASbGncsI83qyIRQvEi7LzEzHp4C1MKeViia6MhQd56dTsv4prymYqoswFHvtGhZCIM0
	uFzef7SW72xBMYJqnYM0FwL906O5REjMJRO6QVyCxM7SD5ItkqsTB8jhwZnMConAGPMt/QpAE1X
	OL5UPZyyoQ2XWN4XzpBLrDaOFVl8gct0L327p8o31qPjkOXRHnDq/KSeoojuBJS3hmehRqJC5rb
	Xe27MfKfpRkZQ5LInKe6pKTxmkwwHvEjcg5jzL0xnOrKRB0Spvoi9Ho4SQBKjJ4N5pTfnZr/dat
	mTbeCfa4cUqn+8fqqcz29fGc9h8KaJ0F9Pb3H4aXph6Ln1yO
X-Google-Smtp-Source: AGHT+IHIfuv1hiD9aKxowrFs0MBjBUPrCRYc4hhnVJb5nBQslXRDlon9G4j8sz7t8HEc8M7x+hNiTg==
X-Received: by 2002:a05:6a00:3cc9:b0:725:f1b1:cbc5 with SMTP id d2e1a72fcca58-7305d417203mr11538995b3a.3.1739005582749;
        Sat, 08 Feb 2025 01:06:22 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf1413sm4366493b3a.98.2025.02.08.01.06.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Feb 2025 01:06:22 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	yukuai1@huaweicloud.com
Cc: chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RESEND v2 1/2] block: introduce init_wait_func()
Date: Sat,  8 Feb 2025 17:04:15 +0800
Message-Id: <20250208090416.38642-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already a macro DEFINE_WAIT_FUNC() to declare a wait_queue_entry
with a specified waking function. But there is not a counterpart for
initializing one wait_queue_entry with a specified waking function. So
introducing init_wait_func() for this, which also could be used in iocost
and rq-qos. Using default_wake_function() in rq_qos_wait() to wake up
waiters, which could remove ->task field from rq_qos_wait_data.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 block/blk-iocost.c   |  3 +--
 block/blk-rq-qos.c   | 14 +++++++-------
 include/linux/wait.h |  6 ++++--
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a5894ec9696e7..2f611649a2edb 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2718,8 +2718,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	 * All waiters are on iocg->waitq and the wait states are
 	 * synchronized using waitq.lock.
 	 */
-	init_waitqueue_func_entry(&wait.wait, iocg_wake_fn);
-	wait.wait.private = current;
+	init_wait_func(&wait.wait, iocg_wake_fn);
 	wait.bio = bio;
 	wait.abs_cost = abs_cost;
 	wait.committed = false;	/* will be set true by waker */
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index eb9618cd68adf..0b1245d368cd1 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -196,7 +196,6 @@ bool rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
 
 struct rq_qos_wait_data {
 	struct wait_queue_entry wq;
-	struct task_struct *task;
 	struct rq_wait *rqw;
 	acquire_inflight_cb_t *cb;
 	void *private_data;
@@ -218,7 +217,12 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 		return -1;
 
 	data->got_token = true;
-	wake_up_process(data->task);
+	/*
+	 * autoremove_wake_function() removes the wait entry only when it
+	 * actually changed the task state. We want the wait always removed.
+	 * Remove explicitly and use default_wake_function().
+	 */
+	default_wake_function(curr, mode, wake_flags, key);
 	list_del_init_careful(&curr->entry);
 	return 1;
 }
@@ -244,11 +248,6 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		 cleanup_cb_t *cleanup_cb)
 {
 	struct rq_qos_wait_data data = {
-		.wq = {
-			.func	= rq_qos_wake_function,
-			.entry	= LIST_HEAD_INIT(data.wq.entry),
-		},
-		.task = current,
 		.rqw = rqw,
 		.cb = acquire_inflight_cb,
 		.private_data = private_data,
@@ -259,6 +258,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
 		return;
 
+	init_wait_func(&data.wq, rq_qos_wake_function);
 	has_sleeper = !prepare_to_wait_exclusive(&rqw->wait, &data.wq,
 						 TASK_UNINTERRUPTIBLE);
 	do {
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 6d90ad9744087..2bdc8f47963bf 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1207,14 +1207,16 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
 
 #define DEFINE_WAIT(name) DEFINE_WAIT_FUNC(name, autoremove_wake_function)
 
-#define init_wait(wait)								\
+#define init_wait_func(wait, function)						\
 	do {									\
 		(wait)->private = current;					\
-		(wait)->func = autoremove_wake_function;			\
+		(wait)->func = function;					\
 		INIT_LIST_HEAD(&(wait)->entry);					\
 		(wait)->flags = 0;						\
 	} while (0)
 
+#define init_wait(wait)	init_wait_func(wait, autoremove_wake_function)
+
 typedef int (*task_call_f)(struct task_struct *p, void *arg);
 extern int task_call_func(struct task_struct *p, task_call_f func, void *arg);
 
-- 
2.20.1

