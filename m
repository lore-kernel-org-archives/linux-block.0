Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E71DDC3A
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325476; cv=none; b=IJ774hOotVDsDk0TZC6KFDe4jSKt0Mj5sp4I5wUqeLgKYP2huz28Z2Qmca3Cbn7dxJMmJ72Qkij63a5scaZAaG3ka3RI+HtUFrPVJc6lTWH3ez4oYDJZD+9sx5EIoqGnRQAtq0/BKF//xdRUBd15BNZDU/Twg1nwmbpeC8rFmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325476; c=relaxed/simple;
	bh=5BAYvcjKwAx/J4GvPz/qFxxZnbBXgXOpB5dJOP8thhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/PoBFq6tEFjBqm6ymi5zA7UCRaSB7Nk9GkeYgnuA7etRatIsaMuugqQuhYrr5lku++AAxGlralAo2t5hEO9T5fIRLWiKhzHX6ltZG+pXql8qFj3lW1t6wihUa0RQWEUViDVVvJRqSh+f72Lz3aERAuHGr82/ON9TYATXtCYgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BqZLsFp6; arc=none smtp.client-ip=209.85.167.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BqZLsFp6"
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-5399675e14cso5437157e87.3
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2024 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1728325472; x=1728930272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lzfa3TD2aAJu1t8Ngs41AQfKWfztgMT258K/19H9wjE=;
        b=BqZLsFp6JUwEzCNj0BsBHNjrmTjqtbFzzBtuankZJXP9dlyGBjTiPaoLYp3B8ohbX/
         UCIKKTXKHsPVbxiNmowfMtr0XZ4zlRiRWWEDB/DyL+pY4q+4TjNUn9hAQFsTsoY2o5eF
         S8h4wgpJELTVUmMymeekZ9/5rQkeNKT2P0JXKo0q680MZYWGAfUGjopeZDxgNzi22x+e
         u5OIJo+MrJx6lw5lsT00ZRBaqEDMja7Jt5er4Z9gNCCs7TX43KNGmHkVbzsVE0HWWzXn
         EkjjbXqyrZDTSuoRD9WTnsdpTbLXPgyeLNn8WpvnOJt6nsnPJ0zaN/THtWmgMHw16ffE
         iwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325472; x=1728930272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lzfa3TD2aAJu1t8Ngs41AQfKWfztgMT258K/19H9wjE=;
        b=VZW9BLUFtChm/fLDmBWThboDKJzNPR1HCm7cfc2+DgYmbMGV+vBxYFaiMxMiu+SUXj
         DQ8O6E03HwvdcrMGzOkBinw1Eg0iojiUhJFJ1cp/PlskhFdI47nam0RcE5NG3LargsCb
         1s7kPZLJcRgEwIxZdmzXj7pwkymeh66y0HoWovAnE+v9nczCit0BJReMdFnzR6NIXTFN
         atSkQCQiNpw9gMG5u7DrzkUB4IyPyWOtaW8+YUbX1gAqwGr1OMFTcoAR4vGB8oHNPddU
         lM2if8a9GK4xYCkvHBhoa0PPPHDt0PnnsrypNrxeNW7GqLaDJm7js4964vHLJTTUOPx1
         Td+w==
X-Forwarded-Encrypted: i=1; AJvYcCUgp2Ujv6tGruyLzAObL/xbNCqJtizoZR08nV4Bjic4f68Bo8zk9TOpBVE0A5OuTfEv6p+T/i8ov0GR5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YydVKV9u46xNXEUnNIby4GNf32czsZriX+dUJwHb9k5h/r9Wb53
	pW2esMhVlcRu6YCFbx5WKFExhTG9SRWaH3C8PWA2XaHNwfJTFbqmQPxpAcce9GiWEQboNx1nASU
	yFkepNH2bUuCayO4wznSVuUl3q6brPP3jrYnQ22aYlm4IZweN
X-Google-Smtp-Source: AGHT+IF56kfSHWsxoYRfjsv+axS1dCXzXR57XmJZl3oM4t2HjUaDqW8lZ1RTGPGWRTXX/ON22nysZbHvl8ND
X-Received: by 2002:a05:6512:3d0c:b0:533:d3e:16f5 with SMTP id 2adb3069b0e04-539ab9cf3cemr6353568e87.38.1728325471969;
        Mon, 07 Oct 2024 11:24:31 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-539aff1f1aesm161333e87.82.2024.10.07.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:24:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3662534022F;
	Mon,  7 Oct 2024 12:24:30 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2DCA2E413A4; Mon,  7 Oct 2024 12:24:30 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v4 2/5] ublk: refactor recovery configuration flag helpers
Date: Mon,  7 Oct 2024 12:24:15 -0600
Message-Id: <20241007182419.3263186-3-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007182419.3263186-1-ushankar@purestorage.com>
References: <20241007182419.3263186-1-ushankar@purestorage.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
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

