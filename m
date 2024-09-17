Received: from mail-lf1-f101.google.com (mail-lf1-f101.google.com [209.85.167.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6900DA31
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726532538; cv=none; b=ETTIL8E7XPCIliGXNb/XRKW7xX5T4GJ11aMI5SylKOebJHQXeA91Ld1a2RNz/EJCzE4qwTA0QEJGxTDPO/38BH+BrSQEEnhl3PnsguLOKCjxNSBHwJpmTldqcNCeLyxRewQ0ok1b0vAXk1SVuFPUM83RIc9BbBzbMHG1QnY8TJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726532538; c=relaxed/simple;
	bh=ijDkR0tL6MfX4Xp6ndHHX70zEo5pmMWmV9NCOATO9qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HQc0DyobnBMLkpXDvSSWzZ+w5XguorxNHdtLZ4ZtfLU4VRDbDY3T9bIRKgB9b8a8jfwqmPWZaf8osZdz7Ap3Pby4Ob3K0O/YxXcOyWBaV6eMKXxKTZXXv2uNS0pn/v0T885ytcGrelkcInGNlnMReAS7DTvAfmul1hrqx121abs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=f+KlKB7y; arc=none smtp.client-ip=209.85.167.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="f+KlKB7y"
Received: by mail-lf1-f101.google.com with SMTP id 2adb3069b0e04-53659867cbdso4902276e87.3
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 17:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1726532534; x=1727137334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JdKX56b+gpWqIVvOt/qDFoHswvHnCn8Q0Srw3ShBnw=;
        b=f+KlKB7yfLcG7Mqcogvhx6RXAC950h02wXsxjukY8r8votQLF67ZjAwKy32VOb2/aY
         R+i07T6YiA/ortQ+mu2UinPwB+Dz07U1Zgl9fv4lpGOvqaCyLTHc1zlN1B68ViG+sbZE
         bIsyf/ngWZku8ykXpWdf5zGBbcgwdb/LpkPYutMYCaMo74V8O55wFRIUpLTkTdsi1Ve1
         t1DRs2JuNNeybbkBsC36AmNqYgtjGYAWYldEDe4247uGG2YVe9COkcKGQcQ0NS3mLWon
         bnsG7TSi5ix8sttF6Z4Kux9r/ZJgyF/pDwUgXrOYYB8FKKbijcE1VqQrWnJrYtXdhTOh
         gmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726532534; x=1727137334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JdKX56b+gpWqIVvOt/qDFoHswvHnCn8Q0Srw3ShBnw=;
        b=M0LrNIEN8VOm8ZoqwI53tgxbxhPeFQpx0JDXGqan94/DUMiNEtbJIRS+6PHrYc32+N
         OFKNYf829gT0P9+195C/ALqq1qa4AohW5l4ZM5/Ow1IlpF+QMXcwrRu9xd0wzF2nBsx/
         cTtwxQ/lWz3pp4ZPwV4fRsxzy9h3oDFjzxBfflgoZxS4e90t7a4n+/Jw806OMIXyzNGP
         MAO7iQEEsFyVBLMgbzuH6w31OQ645hDvQX7gL98b9emgBeebobRXfPBg2q1ECXnK93wT
         lPlIe8lNTdQ2mG7EoqN7TCBsg/cRTHsMeNaEyi7ephPnHcrYKqXlNi1GP0RSG2hnWIXH
         vPZA==
X-Forwarded-Encrypted: i=1; AJvYcCVsoC6YaxFbq7PYVJq8dqGbtGcbd3vmdgoBSDBzr4gEnwpMudSa9dnYb3mw7+yCreyr3KGlc2ZNJnX5QA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1R+83JlDj8yf8WWaI7+x5J7pBes5ZeA0kfpdxwI48JIeGd5v7
	yzDMQs6YtrV7O7odavqHhVdibY4zUkkpQr3FaJcSBFfA0SRvqLAGXv1CzYqsxadtm1tbbaZw3qj
	TcjoP7UBcCGUqzpMM8N/BiPjINdCncFR9
X-Google-Smtp-Source: AGHT+IEvMU6bTqy/vFHh4GiEaQaaknjHWGgZHUang16j2QBZWJeQMLotSiRhfSci/ciCQPnVL/CjoUUXPPB1
X-Received: by 2002:a05:6512:31cd:b0:536:553f:a6e7 with SMTP id 2adb3069b0e04-5367fee95d4mr8295993e87.32.1726532534059;
        Mon, 16 Sep 2024 17:22:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5368709662esm80736e87.78.2024.09.16.17.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:22:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 69DDB34223E;
	Mon, 16 Sep 2024 18:22:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 61923E40F10; Mon, 16 Sep 2024 18:22:12 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 2/4] ublk: refactor recovery configuration flag helpers
Date: Mon, 16 Sep 2024 18:21:53 -0600
Message-Id: <20240917002155.2044225-3-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240917002155.2044225-1-ushankar@purestorage.com>
References: <20240917002155.2044225-1-ushankar@purestorage.com>
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
Changes since v1 (https://lore.kernel.org/linux-block/20240617194451.435445-3-ushankar@purestorage.com/):
- Make the fast-path test in ublk_queue_rq access the queue-local copy
  of the device flags.

 drivers/block/ublk_drv.c | 63 +++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5e04a0fcd0b7..b069f4d2b9d2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -675,22 +675,45 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
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
+	return (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY)) &&
+	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE));
 }
 
 static void ublk_free_disk(struct gendisk *disk)
@@ -1066,7 +1089,7 @@ static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
-	if (ublk_queue_can_use_recovery_reissue(ubq))
+	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
 		blk_mq_requeue_request(req, false);
 	else
 		ublk_put_req_ref(ubq, req);
@@ -1094,7 +1117,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		struct request *rq)
 {
 	/* We cannot process this rq so just requeue it. */
-	if (ublk_queue_can_use_recovery(ubq))
+	if (ublk_nosrv_dev_should_queue_io(ubq->dev))
 		blk_mq_requeue_request(rq, false);
 	else
 		blk_mq_end_request(rq, BLK_STS_IOERR);
@@ -1239,10 +1262,10 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
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
@@ -1271,7 +1294,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * Note: force_abort is guaranteed to be seen because it is set
 	 * before request queue is unqiuesced.
 	 */
-	if (ublk_queue_can_use_recovery(ubq) && unlikely(ubq->force_abort))
+	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
 	if (unlikely(ubq->canceling)) {
@@ -1492,10 +1515,10 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
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
 
@@ -1600,7 +1623,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
 		goto unlock;
-	if (ublk_can_use_recovery(ub)) {
+	if (ublk_nosrv_dev_should_queue_io(ub)) {
 		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
 			__ublk_quiesce_dev(ub);
 		ublk_unquiesce_dev(ub);
@@ -2702,7 +2725,7 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	int i;
 
 	mutex_lock(&ub->mutex);
-	if (!ublk_can_use_recovery(ub))
+	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 	if (!ub->nr_queues_ready)
 		goto out_unlock;
@@ -2755,7 +2778,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
 
 	mutex_lock(&ub->mutex);
-	if (!ublk_can_use_recovery(ub))
+	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 
 	if (ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
-- 
2.34.1

