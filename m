Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E4187542
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653501; cv=none; b=ddbPTmewwkQgZKEJvj3Jx8l3vLP39us3ql4iD7W2PoibTvihkQ+7IbWS05y1uPDsuxt2PKFooAwzmAFLqqrz42CIFehipJrBF4lNWK7FRe/RTmm/ySVu3wqQBDM2movf/kPv8DY80e6p2jNtQAiL8gj+VeKh0rItkXUI7gq0lug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653501; c=relaxed/simple;
	bh=lrMGTTg5aJZSzO9i2PprZIkUkeJlHaO7FEbcoSn7euI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fqddQzRoC7INALMDFRtQSP+N1EnNYF2NgtZRLYEvsPiPnEOV4qK1kAKS5BV5o0NLKYrLoPbQ/lXAwqYMdqzpVAPsyt7Xwt9/82+o6vt3aleqEfjNbhjKxiNgqlM+lFs22qrLPLXelveWAcFF4bx3fw9qOcU9b+i3YNyTGudBQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VP4HeccA; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VP4HeccA"
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so39701275e9.0
        for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1718653497; x=1719258297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aghx42yP//ci2m0muis70ts+owHj1yS8R/2aMs8x6/Y=;
        b=VP4HeccAk3CNeueiHhlsCvw/L1qarTFHc4WY270e0EeJbFlIi6e1Euc5KIDMheRxRU
         dwtkky/2v4v14U2r10TbOQSlwKGDHB3q6GurppvyheP/pI8Dy/OEcUXc3BK/eaukzVSO
         t2i7isTOk59WxXnlnwsADSdCf7ExIdO6TCLGzcexQ3CVO9FtCdrmouWVA32ESYr4+Hai
         wG8UJNoQ6QX9Gl0JbczkjZFHZIEGH/KNKCQy+u/DjOSgCtMexlbPwalWexiVTKcNdkqI
         o1/VYnhku6BpgY62MgelvdgRSem55lL35q+npCNGec14gPlXdBgF5kx06+F3d7fEnJCT
         t0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718653497; x=1719258297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aghx42yP//ci2m0muis70ts+owHj1yS8R/2aMs8x6/Y=;
        b=wI2g4JA4Tr+yIVlIWTmWL7/YU5cIsi4r/6Gc1Da35hmlGB0aen1OFVH1idQsTzGfO4
         Au4ast4JlhH7BfBo7YET7VVwr7yh/Rqsm7JjN/x0FHqiSkXDRmLZwFVwftx5lArKtDd2
         ViJUOfO+VKF3ljWdlJ74+mOqbfElWF8MBdmHZYdHsTq5GcmUGMtGX/QzEEcHedQSgUsu
         ZJ0TaKBWyceFJODBRd/oBZIDKGuThKD4osZqY9CnXK3oGCi75xfCQM3mMJbfFtF/mhyP
         mpdMEi3Pu/mZovPauALLoM2Q3TGkkia2Egz5k1sBa0V2eVwVJ5E6q+pAOnQzy2pMWZgC
         qWnw==
X-Forwarded-Encrypted: i=1; AJvYcCW42KUSrjYHM5J2u1kG3OKqx+mj5Mx/sP/2ci9BOV+x4weJaCR3aJ/pfIw794vin7uK66O521ZZHE6/HF4SNxhKFyqQxlg0xIqj1pE=
X-Gm-Message-State: AOJu0YwgnT5YmhdAGoCxOzNe3DpbRJcq7XUYgb+hxjDkdYbaHWvPSiNU
	Uf7+Hoc+Eb27lTumAD9+pXzbA5Bw2LXS5sOS3aoKyflTDkOkJkXu/zz5SjvFhcOvfJeyGZ8vztN
	+IKwBarmYgMvJ73isNjoDXkFfpyKCryJj
X-Google-Smtp-Source: AGHT+IGd/Z5Fsm8rIEFLUr+qBfyVoAISYuE+A/Dm7LN8v8nb6y80kXzlK7WNLnWx+Lj9p4DfCQUTpBDZFoVw
X-Received: by 2002:a05:600c:1c9a:b0:422:6449:1307 with SMTP id 5b1f17b1804b1-4230484f994mr103939685e9.32.1718653497282;
        Mon, 17 Jun 2024 12:44:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42286fe92bbsm5716225e9.13.2024.06.17.12.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:44:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 03076340A21;
	Mon, 17 Jun 2024 13:44:56 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0043BE41412; Mon, 17 Jun 2024 13:44:55 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 4/4] ublk: support device recovery without I/O queueing
Date: Mon, 17 Jun 2024 13:44:51 -0600
Message-Id: <20240617194451.435445-5-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617194451.435445-1-ushankar@purestorage.com>
References: <20240617194451.435445-1-ushankar@purestorage.com>
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

The behavior A + 2 is currently unsupported. Add support for this
behavior under the new flag UBLK_F_USER_RECOVERY_NOQUEUE.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c      | 53 +++++++++++++++++++++++++++--------
 include/uapi/linux/ublk_cmd.h | 18 ++++++++++++
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0496fa372cc1..4fec8b48d30e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -57,10 +57,12 @@
 		| UBLK_F_UNPRIVILEGED_DEV \
 		| UBLK_F_CMD_IOCTL_ENCODE \
 		| UBLK_F_USER_COPY \
-		| UBLK_F_ZONED)
+		| UBLK_F_ZONED \
+		| UBLK_F_USER_RECOVERY_NOQUEUE)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
-		| UBLK_F_USER_RECOVERY_REISSUE)
+		| UBLK_F_USER_RECOVERY_REISSUE \
+		| UBLK_F_USER_RECOVERY_NOQUEUE)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL                                \
@@ -679,7 +681,14 @@ static inline bool ublk_nosrv_should_queue_io(struct ublk_device *ub)
 static inline bool ublk_nosrv_should_stop_dev(struct ublk_device *ub)
 {
 	return (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY)) &&
-	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE));
+	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE)) &&
+	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_NOQUEUE));
+}
+
+static inline bool ublk_dev_in_recoverable_state(struct ublk_device *ub)
+{
+	return ub->dev_info.state == UBLK_S_DEV_QUIESCED ||
+	       ub->dev_info.state == UBLK_S_DEV_FAIL_IO;
 }
 
 static void ublk_free_disk(struct gendisk *disk)
@@ -1243,6 +1252,11 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq = bd->rq;
 	blk_status_t res;
 
+	if (ubq->dev->dev_info.state == UBLK_S_DEV_FAIL_IO) {
+		return BLK_STS_TARGET;
+	}
+	WARN_ON_ONCE(ubq->dev->dev_info.state != UBLK_S_DEV_LIVE);
+
 	/* fill iod to slot in io cmd buffer */
 	res = ublk_setup_iod(ubq, rq);
 	if (unlikely(res != BLK_STS_OK))
@@ -1602,7 +1616,15 @@ static void ublk_nosrv_work(struct work_struct *work)
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
 		goto unlock;
-	__ublk_quiesce_dev(ub);
+
+	if (ublk_nosrv_should_queue_io(ub)) {
+		__ublk_quiesce_dev(ub);
+	} else {
+		blk_mq_quiesce_queue(ub->ub_disk->queue);
+		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
+		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	}
+
  unlock:
 	mutex_unlock(&ub->mutex);
 	ublk_cancel_dev(ub);
@@ -2351,6 +2373,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	case 0:
 	case UBLK_F_USER_RECOVERY:
 	case (UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_REISSUE):
+	case UBLK_F_USER_RECOVERY_NOQUEUE:
 		break;
 	default:
 		pr_warn("%s: invalid recovery flags %llx\n", __func__,
@@ -2682,14 +2705,18 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	 *     and related io_uring ctx is freed so file struct of /dev/ublkcX is
 	 *     released.
 	 *
+	 * and one of the following holds
+	 *
 	 * (2) UBLK_S_DEV_QUIESCED is set, which means the quiesce_work:
 	 *     (a)has quiesced request queue
 	 *     (b)has requeued every inflight rqs whose io_flags is ACTIVE
 	 *     (c)has requeued/aborted every inflight rqs whose io_flags is NOT ACTIVE
 	 *     (d)has completed/camceled all ioucmds owned by ther dying process
+	 *
+	 * (3) UBLK_S_DEV_FAIL_IO is set, which means the queue is not
+	 *     quiesced, but all I/O is being immediately errored
 	 */
-	if (test_bit(UB_STATE_OPEN, &ub->state) ||
-			ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
+	if (test_bit(UB_STATE_OPEN, &ub->state) || !ublk_dev_in_recoverable_state(ub)) {
 		ret = -EBUSY;
 		goto out_unlock;
 	}
@@ -2727,18 +2754,22 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 
-	if (ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
+	if (!ublk_dev_in_recoverable_state(ub)) {
 		ret = -EBUSY;
 		goto out_unlock;
 	}
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
 			__func__, ublksrv_pid, header->dev_id);
-	blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	pr_devel("%s: queue unquiesced, dev id %d.\n",
-			__func__, header->dev_id);
-	blk_mq_kick_requeue_list(ub->ub_disk->queue);
+
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	if (ublk_nosrv_should_queue_io(ub)) {
+		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+		pr_devel("%s: queue unquiesced, dev id %d.\n",
+				__func__, header->dev_id);
+		blk_mq_kick_requeue_list(ub->ub_disk->queue);
+	}
+
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index c8dc5f8ea699..c4512b3a3c52 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -147,8 +147,18 @@
  */
 #define UBLK_F_NEED_GET_DATA (1UL << 2)
 
+/*
+ * - Block devices are recoverable if ublk server exits and restarts
+ * - Outstanding I/O when ublk server exits is met with errors
+ * - I/O issued while there is no ublk server queues
+ */
 #define UBLK_F_USER_RECOVERY	(1UL << 3)
 
+/*
+ * - Block devices are recoverable if ublk server exits and restarts
+ * - Outstanding I/O when ublk server exits is reissued
+ * - I/O issued while there is no ublk server queues
+ */
 #define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
 
 /*
@@ -184,10 +194,18 @@
  */
 #define UBLK_F_ZONED (1ULL << 8)
 
+/*
+ * - Block devices are recoverable if ublk server exits and restarts
+ * - Outstanding I/O when ublk server exits is met with errors
+ * - I/O issued while there is no ublk server is met with errors
+ */
+#define UBLK_F_USER_RECOVERY_NOQUEUE (1ULL << 9)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
 #define UBLK_S_DEV_QUIESCED	2
+#define UBLK_S_DEV_FAIL_IO 3
 
 /* shipped via sqe->cmd of io_uring command */
 struct ublksrv_ctrl_cmd {
-- 
2.34.1

