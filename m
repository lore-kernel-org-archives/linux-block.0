Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F424E73DA
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611663; cv=none; b=fMmniI49iX71lY3okfwvPjSNVZUviWV4bElxSvSVRgr3cD+jDv7xyVO6DxViOP41HSUigJ2f1uryM/oqWLAWnU1ElcOs8eqwuEAwqVGAP0Tr1BYu71KhmAef+MTgYokIbiuBYUJdLyeyjYRSRSJBtmRr0GwmRrAF1SBoLYkU7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611663; c=relaxed/simple;
	bh=BsW/KynpPT70mhcmfmRHhPnB9y/aYBM35+utMEdwMRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gvm1UacGnNqgxTAiW2uUEQFKrJ4Z8c5AGzy6ivoT/7j4XTMoQFnTvaunsgqvPgHJouyqBO1BxrqWAxNj5NMXnEuWu1+02C//cTL9YOzhMVu2755kHl2MGRVS3OAp98DwOwEB9ux/G4OsqI1YgVSwA9e9pPpMZQ/5CpM9xIWgmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=D4chtjlL; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="D4chtjlL"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5ce99149so202973085a.0
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790611659; x=1791216459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uO96jm0+s5X+z7oEjf0KtJz5pPPX3rA9NhxJ00oR2LE=;
        b=D4chtjlL2wg6U4Gayz4KNc4Dsnzhu2JCOIv0KIEvuwMZmk1RSCev9zhinRoeyGbzYo
         OylCEbRdwwod2S8BHiZdMI0kSkDSk2M/w5ylBqe3Khb89oMfKh748mbLW/YJd5U4EQty
         BW9L7DTNBW/t0z2YzUVOQzWB4jlOD7uDkh4WTxn3fZjzAC+W+J6T4iND7pbDdL0DTios
         COG1mloCWd9R1T8I+DfN3wgY+bIcy83l9U51lupfDM5mM4kIpIwHn4r91exfqzeBH2bf
         vgbxJ8Kj2T6PR8YAaXdH5769Bc6n5GpNs8HBKiZJZj8surf8KA+kbZK7JLr9xUmr/ZNK
         Nmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611659; x=1791216459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uO96jm0+s5X+z7oEjf0KtJz5pPPX3rA9NhxJ00oR2LE=;
        b=apnGGRKcXUdWFWjmP6TaUmQkkRt4Z/G0rN0ZDy4Vr7/rXPdCpP8NV2kYbHA76A89Io
         zH8WD+v7UDl4ljNMFnLCpJwS1VTdqFhPSGCr5D29A8w58KN8FQcIuGeIkwoStZSU83LL
         2SyxnoZTa5TxQf7G5fZNoAS8ccH3hEgWO/G8wDSNdmXQzPIT4VymPBccaS6KDe+uCcHy
         29KhLm4cmmzbTsK2TuPMHkKpMJaFknmaqwg8xVRIKd6goKASWk1cI4xh+2t/K8mMp092
         KXMzsjFE70KQHM8+th0CHnsZ/7ZbFPycVotPLKu4zw8FzwXlg5eluooqwSKO81zdo9Ej
         chOQ==
X-Gm-Message-State: AFuF++nDAHiKoQcWO4xAALmhUgMpHIWWJMMSKJBrquUrZsk7itmcsqCO
	bv2lE63j192VLV1zX4zeNXbZ+Q7XHSe88qFnCYESNs8DdCv6JxckEWcxWY9WpJApFEI=
X-Gm-Gg: AYBFou0W7hNAmDsgiKdyOkv8TfdS3eTQR9wNSKuoeBXWPsaTzdPo7kzgUPY07ALbU4v
	dp0s/WocFkEgJqSVPoqDyfIvk9J5NSWkCKXWKSAwGREkbLMVeRgcmHcVuTTYvMnI58NY7oriJoP
	P/kfJtj2rCFqeh/4bTrNNIRXJJhMiTmlkInTz5A1EDCIp9+DxOMJNY3egQFazLOqGgm2AlgMs4y
	xcgzSpkIDqz74UXFfGDwFLR3A3+1bDIEkj1Ef99Y5SMWoNByYkpRg/yw5aUqD5GpkssKES3WW77
	CDSHfnlSMOh8vO7yrgwAxJqLQY4LRCIJWpJSe1pS4yHeKNDzX6cJYxi2lgYs1zcS1Dn5EVW8OlR
	fF9nPeUhtGUmPjjuazNE39HqdKFuHJDFwpdAf1yWW6SBF+spus4YRVsqaBYC2BwQbHYSZwRsza0
	XqqWZETsBHi2+p7OBIFAIeEiDe+Yv1JWwOCwcm/eCa7HwIzEYnxIsfU2kVKFlKVgCuc499G8SNQ
	Sy0SGTAkIL3KtQ=
X-Received: by 2002:a05:620a:690d:b0:937:5298:7820 with SMTP id af79cd13be357-93c43cc592cmr2189378585a.8.1790611659158;
        Mon, 28 Sep 2026 09:07:39 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813a306bsm181978685a.16.2026.09.28.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:07:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 28 Sep 2026 16:00:44 +0000
Subject: [PATCH 8/9] ublk: claim commands under ub->mutex in
 ublk_stop_dev()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-ublk-cancel-stop-v1-8-4a4360232a46@toxicpanda.com>
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
In-Reply-To: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790611254; l=9645;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=BsW/KynpPT70mhcmfmRHhPnB9y/aYBM35+utMEdwMRE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJXyuycZ386835N+qcz+1DQ76DDc4fwnLXFBccQQNKJ0RAg3a0Y4CAh5CzatDQnfRgqbkxM/82O
 QJ2ghfKokEA4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

STOP_DEV followed by START_DEV on a device which is ready but was never
started oopses on the first read, which reaches ublk_queue_cmd() with a
NULL io->cmd. ublk_stop_dev() completes the fetched commands through
ublk_cancel_dev() after dropping ub->mutex, which is only safe once
del_gendisk() has returned:

    STOP_DEV on a ready device without a disk
      ublk_stop_dev_unlocked() returns early, state is UBLK_S_DEV_DEAD
      ublk_cancel_dev() completes the commands
      ->canceling is never set, the device still counts as ready
    START_DEV
      passes every check, adds the disk, schedules the partition scan

START_DEV can also take ub->mutex right after ublk_stop_dev() drops it.
The idle commands of a live disk are canceled then with nothing
serializing that against ublk_queue_rq(). Commit 1133b93fc7f6 ("ublk:
set canceling flag even when disk is not allocated") closed the same
window for the io_uring cancel callbacks and left the STOP_DEV side
open.

START_DEV has to take ub->mutex before it can add a disk, so once the
commands are claimed under that mutex a queue getting ready afterwards
finds them canceled and stays canceling. Cancel the partition scan work
before dropping ub->mutex too, so that a START_DEV right after the
unlock does not get its new scan canceled.

ublk_cancel_dev() runs without ub->mutex, after this pass and after
QUIESCE_DEV, and a queue which is no longer canceling then belongs to a
round which started after the marking. So far it completed the new
commands of such a queue too, for a QUIESCE_DEV sent to a quiesced
device while the queue was already taking requests. Decide once under
cancel_mutex whether the queue is still canceling, take its commands in
that section, the fetch commands of a UBLK_F_BATCH_IO queue as well, and
complete them after it, as with the per-io commands. The fetch commands
stay linked on the list they are moved to, so take each one off it under
evts_lock before completing it, as ublk_batch_cancel_cmd() does, since
the cancel callback of their ring may take one first.

Fix by marking the queues as canceling and claiming their fetched
commands while ub->mutex is still held, and completing them once it is
dropped.

Fixes: 85248d670b71 ("ublk: move ublk_cancel_dev() out of ub->mutex")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/ublk_drv.c | 145 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 119 insertions(+), 26 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 18046e2bf753..5e86405b294b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -129,6 +129,8 @@ struct ublk_uring_cmd_pdu {
 	union {
 		struct request *req;
 		struct request *req_list;
+		/* links commands claimed by ublk_claim_queue_cmds() */
+		struct io_uring_cmd *next_claimed;
 	};
 
 	/*
@@ -2417,7 +2419,7 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
 		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
-		/* Sync with ublk_cancel_cmd() */
+		/* Sync with ublk_claim_cmd() */
 		spin_lock(&ubq->cancel_lock);
 		ublk_queue_reinit(ub, ubq);
 		spin_unlock(&ubq->cancel_lock);
@@ -2840,15 +2842,6 @@ static struct io_uring_cmd *ublk_claim_cmd(struct ublk_queue *ubq, u16 tag)
 	return cmd;
 }
 
-static void ublk_cancel_cmd(struct ublk_queue *ubq, u16 tag,
-			    unsigned int issue_flags)
-{
-	struct io_uring_cmd *cmd = ublk_claim_cmd(ubq, tag);
-
-	if (cmd)
-		io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, issue_flags);
-}
-
 /*
  * Cancel a batch fetch command if it hasn't been claimed by another path.
  *
@@ -2877,23 +2870,45 @@ static void ublk_batch_cancel_cmd(struct ublk_queue *ubq,
 	}
 }
 
-static void ublk_batch_cancel_queue(struct ublk_queue *ubq)
+/*
+ * Move the parked fetch commands of a batch queue to @fcmd_list, for
+ * ublk_batch_complete_fcmds(); the active one is left to its dispatcher.
+ * They stay linked, and the cancel callback of their ring may still take
+ * one off @fcmd_list first: whoever unlinks a command under evts_lock
+ * completes it.
+ */
+static void ublk_batch_claim_fcmds(struct ublk_queue *ubq,
+				   struct list_head *fcmd_list)
 {
 	struct ublk_batch_fetch_cmd *fcmd;
-	LIST_HEAD(fcmd_list);
 
 	spin_lock(&ubq->evts_lock);
 	ubq->force_abort = true;
-	list_splice_init(&ubq->fcmd_head, &fcmd_list);
+	list_splice_init(&ubq->fcmd_head, fcmd_list);
 	fcmd = READ_ONCE(ubq->active_fcmd);
 	if (fcmd)
 		list_move(&fcmd->node, &ubq->fcmd_head);
 	spin_unlock(&ubq->evts_lock);
+}
 
-	while (!list_empty(&fcmd_list)) {
-		fcmd = list_first_entry(&fcmd_list,
-				struct ublk_batch_fetch_cmd, node);
-		ublk_batch_cancel_cmd(ubq, fcmd, IO_URING_F_UNLOCKED);
+static void ublk_batch_complete_fcmds(struct ublk_queue *ubq,
+				      struct list_head *fcmd_list)
+{
+	struct ublk_batch_fetch_cmd *fcmd;
+
+	for (;;) {
+		spin_lock(&ubq->evts_lock);
+		fcmd = list_first_entry_or_null(fcmd_list,
+						struct ublk_batch_fetch_cmd, node);
+		if (fcmd)
+			list_del_init(&fcmd->node);
+		spin_unlock(&ubq->evts_lock);
+		if (!fcmd)
+			break;
+
+		io_uring_cmd_done(fcmd->cmd, UBLK_IO_RES_ABORT,
+				  IO_URING_F_UNLOCKED);
+		ublk_batch_free_fcmd(fcmd);
 	}
 }
 
@@ -2960,7 +2975,8 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	 */
 	mutex_lock(&ub->cancel_mutex);
 	disk = ublk_start_cancel(ub);
-	WARN_ON_ONCE(io->cmd != cmd);
+	/* ublk_stop_dev() may have claimed the command already */
+	WARN_ON_ONCE(io->cmd && io->cmd != cmd);
 	claimed = ublk_claim_cmd(ubq, pdu->tag);
 	mutex_unlock(&ub->cancel_mutex);
 	ublk_put_disk(disk);
@@ -2979,20 +2995,75 @@ static inline bool ublk_dev_ready(const struct ublk_device *ub)
 	return ub->nr_queue_ready == ub->dev_info.nr_hw_queues;
 }
 
-static void ublk_cancel_queue(struct ublk_queue *ubq)
+/*
+ * Claim the fetched commands of a queue and link them for completion
+ * outside of cancel_mutex.  A batch queue keeps its commands on the fetch
+ * command list, mark it the way ublk_batch_claim_fcmds() does instead.
+ */
+static struct io_uring_cmd *ublk_claim_queue_cmds(struct ublk_queue *ubq,
+						  struct io_uring_cmd *claimed)
+	__must_hold(&ubq->dev->cancel_mutex)
 {
-	u16 i;
+	u16 tag;
 
 	if (ublk_support_batch_io(ubq)) {
-		ublk_batch_cancel_queue(ubq);
-		return;
+		spin_lock(&ubq->evts_lock);
+		ubq->force_abort = true;
+		spin_unlock(&ubq->evts_lock);
+		return claimed;
 	}
 
-	for (i = 0; i < ubq->q_depth; i++)
-		ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
+	for (tag = 0; tag < ubq->q_depth; tag++) {
+		struct io_uring_cmd *cmd = ublk_claim_cmd(ubq, tag);
+
+		if (cmd) {
+			ublk_get_uring_cmd_pdu(cmd)->next_claimed = claimed;
+			claimed = cmd;
+		}
+	}
+	return claimed;
 }
 
-/* Cancel all pending commands, must be called after del_gendisk() returns */
+static void ublk_complete_claimed_cmds(struct io_uring_cmd *cmd)
+{
+	while (cmd) {
+		struct io_uring_cmd *next =
+			ublk_get_uring_cmd_pdu(cmd)->next_claimed;
+
+		io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, IO_URING_F_UNLOCKED);
+		cmd = next;
+	}
+}
+
+static void ublk_cancel_queue(struct ublk_queue *ubq)
+{
+	struct ublk_device *ub = ubq->dev;
+	struct io_uring_cmd *claimed = NULL;
+	LIST_HEAD(fcmds);
+
+	/*
+	 * A queue which is not canceling any more was made ready by a new
+	 * server after the marking, leave it alone.  Decide that in the
+	 * cancel_mutex section which takes the commands, the fetch commands
+	 * of a batch queue too, and complete them after it.
+	 */
+	mutex_lock(&ub->cancel_mutex);
+	if (ubq->canceling) {
+		claimed = ublk_claim_queue_cmds(ubq, NULL);
+		if (ublk_support_batch_io(ubq))
+			ublk_batch_claim_fcmds(ubq, &fcmds);
+	}
+	mutex_unlock(&ub->cancel_mutex);
+	ublk_complete_claimed_cmds(claimed);
+	if (ublk_support_batch_io(ubq))
+		ublk_batch_complete_fcmds(ubq, &fcmds);
+}
+
+/*
+ * Complete the fetched commands of every queue which is still canceling,
+ * ublk_queue_rq() must not be able to dispatch to them: either
+ * del_gendisk() has returned or ->canceling is visible to it
+ */
 static void ublk_cancel_dev(struct ublk_device *ub)
 {
 	u16 i;
@@ -3078,10 +3149,32 @@ static void ublk_stop_dev_unlocked(struct ublk_device *ub)
 
 static void ublk_stop_dev(struct ublk_device *ub)
 {
+	struct io_uring_cmd *claimed = NULL;
+	u16 i;
+
 	mutex_lock(&ub->mutex);
 	ublk_stop_dev_unlocked(ub);
-	mutex_unlock(&ub->mutex);
+	/*
+	 * No disk is attached any more, ublk_queue_rq() can't be running and
+	 * nothing needs to be quiesced, but START_DEV may take ub->mutex as
+	 * soon as it is dropped.  Mark the queues and the commands before
+	 * that, so that a queue getting ready meantime stays canceling and
+	 * such a start sees it.
+	 */
+	mutex_lock(&ub->cancel_mutex);
+	ublk_set_canceling(ub, true);
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		claimed = ublk_claim_queue_cmds(ublk_get_queue(ub, i), claimed);
+	mutex_unlock(&ub->cancel_mutex);
+	/*
+	 * The disk is deleted already, so a partition scan work still
+	 * pending or running only finds it gone, and it is fine to wait for
+	 * it here.  Do that before START_DEV can add a new disk and schedule
+	 * a scan for it, which must not be canceled.
+	 */
 	cancel_work_sync(&ub->partition_scan_work);
+	mutex_unlock(&ub->mutex);
+	ublk_complete_claimed_cmds(claimed);
 	ublk_cancel_dev(ub);
 }
 

-- 
2.55.0

