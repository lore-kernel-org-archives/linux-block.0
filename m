Received: from mail-qk1-f232.google.com (mail-qk1-f232.google.com [209.85.222.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B201991BD
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906996; cv=none; b=D6yy3m3v/9vmW8HvbY7WZdGGl+GEOqjDTDM2XjIYOlDxiNmB2ivg9ONPGbEeefnSULZUofPuJdvuLU3WDmSLwDgzmYpkGtq8Y1sEXwpvxmmNtozIjUWlUFbSgZuT9ZaQR6wwb1y+dUGFTWYaCz260Dho7dNkZPhEnEFeBS9PTQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906996; c=relaxed/simple;
	bh=K6lqJhzm7YR7lBHCgmDgWN+G1CAiiXRsRbPJUTa3v1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bLX4Vh1NIZBdwnFO9yE0ASK6o3/pm6hSLQddFgJs5OqDddd6X+Y6zkT96ihT+88Ra48oAZLXbA5hNulH/dtZL9j534DagHAtfZts5W8Yi8KqpcQu8qL9VmS1a5aITLuqrypZbWMUmm0eolA0GenkKRqunHgMt6Y4lw+Sdh1Wbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BgsWJG7h; arc=none smtp.client-ip=209.85.222.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BgsWJG7h"
Received: by mail-qk1-f232.google.com with SMTP id af79cd13be357-7a99fd0535bso25094385a.3
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727906993; x=1728511793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU2DZx5ct3RTr2jnB5Xo41RSVhjBYfTx+vlun8bxbyw=;
        b=BgsWJG7hL+H794X8QOjC3NYE91m6gPDuk0VtF/JTxwfC5gZG+Tt+LfEEqCpfAoH4+m
         4sQS+bXQZXMO8uk2cn1Frk9S0mgKhiPwvHCuy185JSuR4d9afFqgxOTkKDyDEIfFuje4
         4DXWMTBy2ja0oBpZH6sxRea2c5+e4LXMjLjqL4XDN839YMeRJPBBNeUhe/eYZFpK502D
         wjScOt7fhEsfoC+Qc62PJc0y4zgn/OxI0rSkeueta/HeNOBQarmXZlbEI7x4WXIE6dcE
         V1JWBJyIfmgkURFcax26nm4UagyOeY74mO9putJ0viD5893AZQ3jQmm/mPe04a9ymBPr
         xItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727906993; x=1728511793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU2DZx5ct3RTr2jnB5Xo41RSVhjBYfTx+vlun8bxbyw=;
        b=Y5Pt1eEihjKckhckwvsgp7NAHNPXQzuM1DS8SUVtWmMxYH7PHeBeIba070D2LSyB19
         arx1K6JSPmB37Z4QBDah/hBcdAvkCDWwpX+6gtYrYqsOt1Wo8qIQ5F2yoPBzZQjRHDOB
         yWXvJK+v1EQnkKFTx9KEl9ELAdd2fJWERe24H/xXyZuLS4ox0H/lYJekqY5dAXdXctnb
         NFkcNeLV7Sdx2WlzcLbk4DenLmpPzyXAvD0YVY5QB0Z5kBRV3ptrHxWYzkBIuRR9ab+x
         be/Ebq8/eqZ79IVYhnJ9HaM+d38s3nKdy7H8hWmeVM6duB/yel/MjWw82GwhHyYtmJVG
         uSeg==
X-Forwarded-Encrypted: i=1; AJvYcCWTk3MPCA141FpBFluR61A2Er+uUlw0yFDDX4yc9ZX+FEyQ4k2kMCj21GpiHuuUmNpoSz3YXdtkQGLLaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBMkaKwAQcgIK49IiboG6sZ0zOCMybbAd3eNRVLVjxqHkM3PJ
	k51/uPwbhz4QuXQX63+jRfzNl46ymPKumn/GQjNXpdrIxXu5nNkDhtwBDbPlx/nWeXQrbuH7x7X
	AWJEHq40JXqKIGkMARwqih5aCrURqWAz8
X-Google-Smtp-Source: AGHT+IE828zWKrmHce+mpepbuC5Rz6E6Ze1pu1PCVLPSuwMEi74h/Y0p4GnnhJ+Z/6Bg/uDvoVx0Sp8zt8+e
X-Received: by 2002:a05:620a:2590:b0:7ac:e839:df99 with SMTP id af79cd13be357-7ae6270df31mr789626385a.44.1727906993202;
        Wed, 02 Oct 2024 15:09:53 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-7ae378c5390sm38291685a.9.2024.10.02.15.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:09:53 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 62AFF3403A0;
	Wed,  2 Oct 2024 16:09:51 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 5AAB7E51EFE; Wed,  2 Oct 2024 16:09:51 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 2/5] ublk: refactor recovery configuration flag helpers
Date: Wed,  2 Oct 2024 16:09:46 -0600
Message-Id: <20241002220949.3087902-3-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002220949.3087902-1-ushankar@purestorage.com>
References: <20241002220949.3087902-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk currently supports the following behaviors on ublk server exit:

A: outstanding I/Os get errors, subsequently issued I/Os get errors
B: outstanding I/Os get errors, subsequently issued I/Os queue
C: outstanding I/Os get reissued, subsequently issued I/Os queue

and the following behaviors for recovery of preexisting block devices by
a future incarnation of the ublk server:

1: ublk devices stopped on ublk server exit (no recovery possible)
2: ublk devices are recoverable using start/end_recovery commands

The userspace interface allows selection of combinations of these
behaviors using flags specified at device creation time, namely:

default behavior: A + 1
UBLK_F_USER_RECOVERY: B + 2
UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2

We can't easily change the userspace interface to allow independent
selection of one of {A, B, C} and one of {1, 2}, but we can refactor the
internal helpers which test for the flags. Replace the existing helpers
with the following set:

ublk_nosrv_should_reissue_outstanding: tests for behavior C
ublk_nosrv_[dev_]should_queue_io: tests for behavior B
ublk_nosrv_should_stop_dev: tests for behavior 1

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes since v2 (https://lore.kernel.org/linux-block/20240917002155.2044225-3-ushankar@purestorage.com/):
- Remove redundant test from ublk_nosrv_should_stop_dev

 drivers/block/ublk_drv.c | 62 +++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 318a4dfe8266..a838ba809445 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -675,22 +675,44 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 			PAGE_SIZE);
 }
 
-static inline bool ublk_queue_can_use_recovery_reissue(
-		struct ublk_queue *ubq)
+/*
+ * Should I/O outstanding to the ublk server when it exits be reissued?
+ * If not, outstanding I/O will get errors.
+ */
+static inline bool ublk_nosrv_should_reissue_outstanding(struct ublk_device *ub)
 {
-	return (ubq->flags & UBLK_F_USER_RECOVERY) &&
-			(ubq->flags & UBLK_F_USER_RECOVERY_REISSUE);
+	return (ub->dev_info.flags & UBLK_F_USER_RECOVERY) &&
+	       (ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE);
 }
 
-static inline bool ublk_queue_can_use_recovery(
-		struct ublk_queue *ubq)
+/*
+ * Should I/O issued while there is no ublk server queue? If not, I/O
+ * issued while there is no ublk server will get errors.
+ */
+static inline bool ublk_nosrv_dev_should_queue_io(struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
+}
+
+/*
+ * Same as ublk_nosrv_dev_should_queue_io, but uses a queue-local copy
+ * of the device flags for smaller cache footprint - better for fast
+ * paths.
+ */
+static inline bool ublk_nosrv_should_queue_io(struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_USER_RECOVERY;
 }
 
-static inline bool ublk_can_use_recovery(struct ublk_device *ub)
+/*
+ * Should ublk devices be stopped (i.e. no recovery possible) when the
+ * ublk server exits? If not, devices can be used again by a future
+ * incarnation of a ublk server via the start_recovery/end_recovery
+ * commands.
+ */
+static inline bool ublk_nosrv_should_stop_dev(struct ublk_device *ub)
 {
-	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
+	return !(ub->dev_info.flags & UBLK_F_USER_RECOVERY);
 }
 
 static void ublk_free_disk(struct gendisk *disk)
@@ -1066,7 +1088,7 @@ static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
-	if (ublk_queue_can_use_recovery_reissue(ubq))
+	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
 		blk_mq_requeue_request(req, false);
 	else
 		ublk_put_req_ref(ubq, req);
@@ -1094,7 +1116,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		struct request *rq)
 {
 	/* We cannot process this rq so just requeue it. */
-	if (ublk_queue_can_use_recovery(ubq))
+	if (ublk_nosrv_dev_should_queue_io(ubq->dev))
 		blk_mq_requeue_request(rq, false);
 	else
 		blk_mq_end_request(rq, BLK_STS_IOERR);
@@ -1239,10 +1261,10 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 		struct ublk_device *ub = ubq->dev;
 
 		if (ublk_abort_requests(ub, ubq)) {
-			if (ublk_can_use_recovery(ub))
-				schedule_work(&ub->quiesce_work);
-			else
+			if (ublk_nosrv_should_stop_dev(ub))
 				schedule_work(&ub->stop_work);
+			else
+				schedule_work(&ub->quiesce_work);
 		}
 		return BLK_EH_DONE;
 	}
@@ -1271,7 +1293,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * Note: force_abort is guaranteed to be seen because it is set
 	 * before request queue is unqiuesced.
 	 */
-	if (ublk_queue_can_use_recovery(ubq) && unlikely(ubq->force_abort))
+	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
 	if (unlikely(ubq->canceling)) {
@@ -1492,10 +1514,10 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	ublk_cancel_cmd(ubq, io, issue_flags);
 
 	if (need_schedule) {
-		if (ublk_can_use_recovery(ub))
-			schedule_work(&ub->quiesce_work);
-		else
+		if (ublk_nosrv_should_stop_dev(ub))
 			schedule_work(&ub->stop_work);
+		else
+			schedule_work(&ub->quiesce_work);
 	}
 }
 
@@ -1600,7 +1622,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
 		goto unlock;
-	if (ublk_can_use_recovery(ub)) {
+	if (ublk_nosrv_dev_should_queue_io(ub)) {
 		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
 			__ublk_quiesce_dev(ub);
 		ublk_unquiesce_dev(ub);
@@ -2701,7 +2723,7 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	int i;
 
 	mutex_lock(&ub->mutex);
-	if (!ublk_can_use_recovery(ub))
+	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 	if (!ub->nr_queues_ready)
 		goto out_unlock;
@@ -2754,7 +2776,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
 
 	mutex_lock(&ub->mutex);
-	if (!ublk_can_use_recovery(ub))
+	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 
 	if (ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
-- 
2.34.1

