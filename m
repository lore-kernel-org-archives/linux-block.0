Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD42E218591
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386901; cv=none; b=HpPzC+WfkL9eGUkG2i6ewOAef+Y/O0fZZzDw8NnnYekdSts6KpBRBBBih+J8hHDq20cHMXu1d5q8d+SXIveZxtoY8SkRyx5dVPWTKIzsHxS7QYYqV1WfzM4VBNytS86RXaPrvH4o2xAac7ufDUHzt+m3F0UeIMbtlBdWCUGFH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386901; c=relaxed/simple;
	bh=EKaGxiLerpvAhaoj/Bkw2+Qa/D3Fb5aNXt+5i9rRtAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqYdBQCZ2rrPLsU/BYibPrhNRWiNjiPYOAdwBgSiR0yVRe0QT0bedcivRf06bAIz+8M9gtjDFiUHh0H21XYV1o8L3UKxcjKD75Bt1y2knmaU90PjaQlerwwFxcSOA3nI3xk8Jonu/SAFivrqFWOgxKqJ0cGG4uJRGz+zWL003b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=O1opTv1r; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="O1opTv1r"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-23278ce78efso27375905ad.2
        for <linux-block@vger.kernel.org>; Tue, 27 May 2025 16:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748386897; x=1748991697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s61w6nBl3jhK5oE1Pz/G6m687SNZu5Nj6nJhmHdEi4Y=;
        b=O1opTv1rmY4/cbKJhoPN3MI/RrIOBddeSNqdh9nkGQ4cEITkISvI/VmZvSIuHSeCVm
         OdscQs6XDjckCA1HF+CK5kjhPCDnFrkMbzBQ/lGqyeeoKuAL+AeJp/dNz7HVVhg5IY+y
         0vaJwRVZ//g0YbXqWf1lVaqEEbZQdgTuV6z9h0I91KrxnRzPEq7raPUStIwp3OvNgZrB
         vd2OGA39NB2mfCLUC+9xWutaHB4i/RZy1dLgQcKR2PmQ/+6m+NvpHOiwCNQ2hvq+1evo
         fqXiqqv+7ZnD2JeahPUeqE9tbygLUWD6KFEuWeCzeDt9nYUtlzK2J5fOWnPwXII8mzgJ
         xK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748386897; x=1748991697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s61w6nBl3jhK5oE1Pz/G6m687SNZu5Nj6nJhmHdEi4Y=;
        b=YYgxHsdww86TUNDNtBAyRwxQ21N/Pzd5jMSkCsfJh14wjV+ov+CJ2qsT0RM6lq8E5s
         s0IP2o9fMa9JoPjIy3ZNX6UjSiSWyirsXOBcij9Z/Z8TVux4Afhp7TRb1jRVSPK7JSDS
         b2BfP1/PcrHxOlb6CSUv+/vmQnGtg6g124P2TG0z63wJDnz7JfEC6zhvpsmp2Cf9FVkW
         J1RPgrzaHdRzizJAzWMl2mSXmXRbEwde9PuO8DQ2ki7vFxYrGP3b/jfKuXTu3MYYPrHv
         Otdl7tCjm//AMbIUaeuM7Qs94ZEoecRrL2i8nzirnHk9QQqh5HaerIibCHFwb+BWEb+q
         gfHQ==
X-Gm-Message-State: AOJu0YxEdG46Q603uTEOvQM5lVxK5fc2xn52BlBzCCJd1z6W8ECR2mXK
	yiTaBi1w5Y6PyStGxzQwcai3MQYh2pKaj4hY7999L4f4YnDDAbFAqM+FMxPUe1Q3qjI2fw1PZkg
	yJGaRiWEw8jIE76p9CVjwd5pEKr7O5tGPxkYC
X-Gm-Gg: ASbGncscrgo5nG0Xc5nfOV0ZPs18P3rd6oMnb/U2QVARLU9JuBlDocwYHnioWtHG5Xu
	2XhpQA7LDi4LMIuTeyT1VURe46fKF3uL2M1+Rpq8ZN5VGvMWehAr/UoewhG7egQ5Pq1ofam3GOk
	V21Xh6qkqmLKcoxAJ8LBG8kKzhtSbBbDjNtbd51Ny4rQtdzVou/+oifV9xVsB6FRNCwTtqsXJp0
	uDvp4YCw5ks2Pd6RKX0qtlTVBfZ6ojRTJ8+qvJWOmhcjMKe+ta6AnuzdgHXbPvLIYYxcPnXeXlt
	Op16IvG+AglLaMEOGcVbUGB2ZB7sq9edxLJ3EHKN52ffLw==
X-Google-Smtp-Source: AGHT+IHBgJnJ4t0ZHX1cK5i/ctstGNjkLaCfd1pbaD7diiQqvXBHGlDnwc++pxUSmXvdZ73tM7RbAeZq21nh
X-Received: by 2002:a17:902:e842:b0:22e:4a2e:8ae7 with SMTP id d9443c01a7336-23414f7d0ebmr273932075ad.22.1748386896905;
        Tue, 27 May 2025 16:01:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b2d99e19562sm314a12.12.2025.05.27.16.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 16:01:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 31E01340353;
	Tue, 27 May 2025 17:01:36 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2E59AE539B9; Tue, 27 May 2025 17:01:36 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 27 May 2025 17:01:27 -0600
Subject: [PATCH v7 4/8] selftests: ublk: kublk: lift queue initialization
 out of thread
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-ublk_task_per_io-v7-4-cbdbaf283baa@purestorage.com>
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
In-Reply-To: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Currently, each ublk server I/O handler thread initializes its own
queue. However, as we move towards decoupled ublk_queues and ublk server
threads, this model does not make sense anymore, as there will no longer
be a concept of a thread having "its own" queue. So lift queue
initialization out of the per-thread ublk_io_handler_fn and into a loop
in ublk_start_daemon (which runs once for each device).

There is a part of ublk_queue_init (ring initialization) which does
actually need to happen on the thread that will use the ring; that is
separated into a separate ublk_thread_init which is still called by each
I/O handler thread.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 68 +++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 1602cf6f07a02e5dab293b91f301218c38c8f4d9..2d6d163b74483a07066f47fd36781782ce25a16e 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -412,6 +412,17 @@ static void ublk_queue_deinit(struct ublk_queue *q)
 	int i;
 	int nr_ios = q->q_depth;
 
+	if (q->io_cmd_buf)
+		munmap(q->io_cmd_buf, ublk_queue_cmd_buf_sz(q));
+
+	for (i = 0; i < nr_ios; i++)
+		free(q->ios[i].buf_addr);
+}
+
+static void ublk_thread_deinit(struct ublk_queue *q)
+{
+	q->tid = 0;
+
 	io_uring_unregister_buffers(&q->ring);
 
 	io_uring_unregister_ring_fd(&q->ring);
@@ -421,28 +432,20 @@ static void ublk_queue_deinit(struct ublk_queue *q)
 		close(q->ring.ring_fd);
 		q->ring.ring_fd = -1;
 	}
-
-	if (q->io_cmd_buf)
-		munmap(q->io_cmd_buf, ublk_queue_cmd_buf_sz(q));
-
-	for (i = 0; i < nr_ios; i++)
-		free(q->ios[i].buf_addr);
 }
 
 static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
 {
 	struct ublk_dev *dev = q->dev;
 	int depth = dev->dev_info.queue_depth;
-	int i, ret = -1;
+	int i;
 	int cmd_buf_size, io_buf_size;
 	unsigned long off;
-	int ring_depth = dev->tgt.sq_depth, cq_depth = dev->tgt.cq_depth;
 
 	q->tgt_ops = dev->tgt.ops;
 	q->state = 0;
 	q->q_depth = depth;
 	q->cmd_inflight = 0;
-	q->tid = gettid();
 
 	if (dev->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_AUTO_BUF_REG)) {
 		q->state |= UBLKSRV_NO_BUF;
@@ -479,6 +482,22 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
 		}
 	}
 
+	return 0;
+ fail:
+	ublk_queue_deinit(q);
+	ublk_err("ublk dev %d queue %d failed\n",
+			dev->dev_info.dev_id, q->q_id);
+	return -ENOMEM;
+}
+
+static int ublk_thread_init(struct ublk_queue *q)
+{
+	struct ublk_dev *dev = q->dev;
+	int ring_depth = dev->tgt.sq_depth, cq_depth = dev->tgt.cq_depth;
+	int ret;
+
+	q->tid = gettid();
+
 	ret = ublk_setup_ring(&q->ring, ring_depth, cq_depth,
 			IORING_SETUP_COOP_TASKRUN |
 			IORING_SETUP_SINGLE_ISSUER |
@@ -508,9 +527,9 @@ static int ublk_queue_init(struct ublk_queue *q, unsigned extra_flags)
 	}
 
 	return 0;
- fail:
-	ublk_queue_deinit(q);
-	ublk_err("ublk dev %d queue %d failed\n",
+fail:
+	ublk_thread_deinit(q);
+	ublk_err("ublk dev %d queue %d thread init failed\n",
 			dev->dev_info.dev_id, q->q_id);
 	return -ENOMEM;
 }
@@ -778,7 +797,6 @@ struct ublk_queue_info {
 	struct ublk_queue 	*q;
 	sem_t 			*queue_sem;
 	cpu_set_t 		*affinity;
-	unsigned char 		auto_zc_fallback;
 };
 
 static void *ublk_io_handler_fn(void *data)
@@ -786,15 +804,11 @@ static void *ublk_io_handler_fn(void *data)
 	struct ublk_queue_info *info = data;
 	struct ublk_queue *q = info->q;
 	int dev_id = q->dev->dev_info.dev_id;
-	unsigned extra_flags = 0;
 	int ret;
 
-	if (info->auto_zc_fallback)
-		extra_flags = UBLKSRV_AUTO_BUF_REG_FALLBACK;
-
-	ret = ublk_queue_init(q, extra_flags);
+	ret = ublk_thread_init(q);
 	if (ret) {
-		ublk_err("ublk dev %d queue %d init queue failed\n",
+		ublk_err("ublk dev %d queue %d thread init failed\n",
 				dev_id, q->q_id);
 		return NULL;
 	}
@@ -813,7 +827,7 @@ static void *ublk_io_handler_fn(void *data)
 	} while (1);
 
 	ublk_dbg(UBLK_DBG_QUEUE, "ublk dev %d queue %d exited\n", dev_id, q->q_id);
-	ublk_queue_deinit(q);
+	ublk_thread_deinit(q);
 	return NULL;
 }
 
@@ -857,6 +871,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 {
 	const struct ublksrv_ctrl_dev_info *dinfo = &dev->dev_info;
 	struct ublk_queue_info *qinfo;
+	unsigned extra_flags = 0;
 	cpu_set_t *affinity_buf;
 	void *thread_ret;
 	sem_t queue_sem;
@@ -878,14 +893,23 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	if (ret)
 		return ret;
 
+	if (ctx->auto_zc_fallback)
+		extra_flags = UBLKSRV_AUTO_BUF_REG_FALLBACK;
+
 	for (i = 0; i < dinfo->nr_hw_queues; i++) {
 		dev->q[i].dev = dev;
 		dev->q[i].q_id = i;
 
+		ret = ublk_queue_init(&dev->q[i], extra_flags);
+		if (ret) {
+			ublk_err("ublk dev %d queue %d init queue failed\n",
+				 dinfo->dev_id, i);
+			goto fail;
+		}
+
 		qinfo[i].q = &dev->q[i];
 		qinfo[i].queue_sem = &queue_sem;
 		qinfo[i].affinity = &affinity_buf[i];
-		qinfo[i].auto_zc_fallback = ctx->auto_zc_fallback;
 		pthread_create(&dev->q[i].thread, NULL,
 				ublk_io_handler_fn,
 				&qinfo[i]);
@@ -918,6 +942,8 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	for (i = 0; i < dinfo->nr_hw_queues; i++)
 		pthread_join(dev->q[i].thread, &thread_ret);
  fail:
+	for (i = 0; i < dinfo->nr_hw_queues; i++)
+		ublk_queue_deinit(&dev->q[i]);
 	ublk_dev_unprep(dev);
 	ublk_dbg(UBLK_DBG_DEV, "%s exit\n", __func__);
 

-- 
2.34.1

