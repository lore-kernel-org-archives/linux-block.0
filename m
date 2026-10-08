Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CF8412BF8
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459558; cv=none; b=QZh5AcpRD6STf5py/3YZCTzsdBwi5m3pWnbOmcy4PcXT/T6OiCit6Om5Rep1C3AdA6mPkAYYNFznmAwy2HhZPS0l3g70qVo6EuzQd1Hvwck8gfSUlcUDvELZZAE7SVd4v7lNkdxFDbaivL/Yb3kmOmdk/bMiBxPf00/BIWp7FgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459558; c=relaxed/simple;
	bh=CcrcWucOSDEht0Fclqgf4A4ywl5KuhaDIHsJLeRjTZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCQCxYbRlDTiqPs/Yw+5UfWVZkIq05QNI7JfHIHYXK8KoaCDezk5S+LFuQdInZvSWETQa/1vdgoFn6MG+w7ie3TD5syJrNcXXgH03zYl/8f+ION7t+a5KzQU2YYaXNcePauuGUrgtdi4PHrwaekvaZfB/rdbr2l6gkGMqEENDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7KZJOus; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7KZJOus"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8245021651dso2188855a34.0
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791459556; x=1792064356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=az2QP/g0lcH9cQHCULlt1cTB9Re2amLAZWV9Fa6IjWM=;
        b=Z7KZJOusUbza/5e7rmrcUuPB4X5TzX2Smsho1NbDLnFhRaD4d94TRJmt+/cp/ymo8D
         g4IY5C+ZoeOAewd/MSSdryNS9tnEAiBsIdhoOf5ZBBO5p2e0rT3huXSN56THgfXcyFvh
         xAb5GwvGDFL5u0DpJdvvwEmz/CwIVyJVCNaQtHlrdZyIdDgZowQkfDhxAk6u+B3vaPJD
         BneTunti3hVKVxLTXPaImIe/W4Dz6ISpPNddgk/CWuLmTTOcTDFGFYizMAISvkfZR5wF
         n8lHxlYYO03Vbq/71x/WgSO/svTJPKlQEfLNA7Tx2+sNpe6ni1V+x2BvtYHjB/Ldl2kr
         oEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791459556; x=1792064356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=az2QP/g0lcH9cQHCULlt1cTB9Re2amLAZWV9Fa6IjWM=;
        b=jI/DufXpT6NNsVKmJ5cesNjhejoN9Un9C0fE8l2JPP6rWpOLRDe5MfyKAllJW4rh3i
         zWV8dP0G8eo/XSOsgCM6vS58EbdylLJFmPIBp02fJl/onVdmKe0Hlc4kGLbQABayEc7k
         B8QRtHso8AHM4xvW0zb4z2HI2nVogwcp1N6xVOhA0FSqw+RBIxMlED//d9Z1af6D+YVV
         3Dgybrr+yfHOivgqT4XesjYvxvGDZV8WAaLqnYL94V9oiIMTEN70nzt84JvTqi9bWpbL
         E0D3o7htRixHxRx8wL6wFx8MHzyIJJX9yNAKB2ewC00u4ANHfcJN7JUMtqEtYIjCvyT6
         34GQ==
X-Gm-Message-State: AFuF++nMugK9C6TNxFqMaZD3U1nNnvrxonAP7ckeeDm0EVPtrglc5kHo
	9Mu3yvz11dy36qN9Jw9Wg+ZQSvGKMjrqDdsW6N+uNNVePSUYHaqxzyE/vQg/Dkhh
X-Gm-Gg: AYBFou3Mw3ePfY5i0tBTu/uxTTZMGzLZN+ppm0Mg0dTuc9ebSIlIMBvm4fxlGDGco0/
	G7JUR8pfvpNMubOKFO1+nknlUfBJy+GYQsI9i+ELKsCuB1cQJqY9TZctBNoN4dT2yeL5G/zTGzF
	fNgMC4kxxThFt/OIVWVAIBsusqPK28IcOirNPzKMv8aK4R0MFF4zpWw2OMIm9SLYaxPjFcLiDZ6
	gS5qe8p033ffPUhVzFfsuq1f+1rq2x2rl833x/JhtRPfm2xMoTEX4T6rpT5woWqLMfXCCqdyo4J
	N/y2qady8Z26SQ6Qb70Qnqs3OVRQ1TGr3OVVyE7Ph6npZ1zkPRGMhxdJ3RcHtjCW9+Gvoor9mRl
	iVnWGJ5HPtsrF/z35qVGA1lMUXvvvb3gHqij/64BhmxodFHvuzUAkwEJPMUbPNt7B7QXw2hjlzG
	MRFyykJc+ks3H8zfJg6uF9E7vdOUCk90yiRvPsLKlGPGTmwV8uI8gBqgJkROTrok14xRm/4Y1i3
	bBKzXXSQlG8mCXfIPAkEYL7jpRgx8fEi1au2w0GwC0ycsuFZauRSkeEDN6AgMt1g8jNwmIiGyt2
	taUwAlA0YxlTaPcfrZkpIjt+ttw=
X-Received: by 2002:a05:6830:2aa4:b0:822:40fc:2eaa with SMTP id 46e09a7af769-82ad02b69e7mr5663711a34.27.1791459555894;
        Thu, 08 Oct 2026 04:39:15 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcb187c8sm6045154a34.22.2026.10.08.04.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:39:15 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 01/11] ublk: keep a canceled FETCH round canceling until the server is gone
Date: Thu,  8 Oct 2026 06:38:57 -0500
Message-ID: <20261008113907.4000838-2-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008113907.4000838-1-tom.leiming@gmail.com>
References: <20261008113907.4000838-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A cancel completes a fetched io command and sets io->cmd to NULL, but
the io still counts as ready. Only ubq->canceling stops ublk_queue_rq()
from using the NULL io->cmd. Two paths clear that flag too early:

  partial FETCH round                 recovery, two queues
  -------------------                 --------------------
  task A: FETCH tags 0-2              q0 ready: q0->canceling = false
  task A exits:                       q0 task exits:
    start_cancel(): mark queues         start_cancel(): ub->canceling
    tags 0-2: io->cmd = NULL              is still set -> q0 not marked
  task B: FETCH tag 3                   q0: io->cmd = NULL
    queue ready: canceling = false    q1 ready
  START_DEV                           END_USER_RECOVERY
  read -> ublk_queue_cmd(NULL)        read on q0 -> ublk_queue_cmd(NULL)

A FETCH round runs from the open of /dev/ublkcN until
ublk_reset_ch_dev() resets the queues. A canceled command can't be
fetched again in the same round. So the ready check only needs one
fact: did this round see a cancel? ub->canceling already records it:
ublk_start_cancel() sets it under cancel_mutex before any command is
taken. It is only cleared too early, when all queues are ready.

Fix:

 - clear ub->canceling only in ublk_reset_ch_dev()
 - when a queue gets ready, clear ubq->canceling only if ub->canceling
   is not set, and check it under cancel_mutex

The check and the marking are ordered by cancel_mutex:

  check first:   queue cleared -> start_cancel() marks it again
                 -> command taken
  cancel first:  check sees ub->canceling -> queue stays canceling

While ub->canceling is set, no queue clears its flag. So the "all
queues marked" shortcut in ublk_start_cancel() is correct again.

UBLK_F_BATCH_IO follows the same rule. It does not dispatch through
io->cmd, so it never hit the oops, but a round which lost a fetch
command is treated the same way: it has to start over.

Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
Fixes: 3f3850785594 ("ublk: fix batch I/O recovery -ENODEV error")
Cc: stable@vger.kernel.org # v6.17+: needs cancel_mutex
Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/linux-block/20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com/
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 54 ++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e7162e..38ed7d0e3979 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -334,6 +334,11 @@ struct ublk_device {
 	u16			nr_queue_ready;
 	bool 			unprivileged_daemons;
 	struct mutex cancel_mutex;
+	/*
+	 * A cancel started in this FETCH round. Set by ublk_set_canceling(),
+	 * cleared only by ublk_reset_ch_dev() when a new round starts. While
+	 * it is set, no queue clears its ->canceling.
+	 */
 	bool canceling;
 	pid_t 	ublksrv_tgid;
 	struct delayed_work	exit_work;
@@ -2415,6 +2420,11 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 		spin_unlock(&ubq->cancel_lock);
 	}
 
+	/* a new FETCH round starts, the queues stay canceling until ready */
+	mutex_lock(&ub->cancel_mutex);
+	ub->canceling = false;
+	mutex_unlock(&ub->cancel_mutex);
+
 	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_queue_ready = 0;
@@ -3024,11 +3034,19 @@ static void ublk_reset_io_flags(struct ublk_queue *ubq, struct ublk_io *io)
 }
 
 /* reset per-queue io flags */
-static void ublk_queue_reset_io_flags(struct ublk_queue *ubq)
+static void ublk_queue_reset_io_flags(struct ublk_device *ub,
+				      struct ublk_queue *ubq)
 {
-	spin_lock(&ubq->cancel_lock);
-	ubq->canceling = false;
-	spin_unlock(&ubq->cancel_lock);
+	/*
+	 * A cancel in this FETCH round took a command which still counts as
+	 * ready, so the queue has to stay canceling. ub->canceling is set
+	 * under cancel_mutex before any command is taken: either we see it
+	 * here, or the cancel marks this queue again later.
+	 */
+	mutex_lock(&ub->cancel_mutex);
+	if (!ub->canceling)
+		ubq->canceling = false;
+	mutex_unlock(&ub->cancel_mutex);
 	ubq->fail_io = false;
 	ubq->force_abort = false;
 }
@@ -3051,24 +3069,17 @@ static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id,
 		ub->nr_queue_ready++;
 
 		/*
-		 * Reset queue flags as soon as this queue is ready.
-		 * This clears the canceling flag, allowing batch FETCH commands
-		 * to succeed during recovery without waiting for all queues.
+		 * Reset queue flags as soon as this queue is ready. Unless
+		 * this round saw a cancel, this clears the canceling flag,
+		 * allowing batch FETCH commands to succeed during recovery
+		 * without waiting for all queues.
 		 */
-		ublk_queue_reset_io_flags(ubq);
+		ublk_queue_reset_io_flags(ub, ubq);
 	}
 
-	/* Check if all queues are ready */
-	if (ublk_dev_ready(ub)) {
-		/*
-		 * All queues ready - clear device-level canceling flag
-		 * and wake ublk_dev_ready() waiters.
-		 */
-		mutex_lock(&ub->cancel_mutex);
-		ub->canceling = false;
-		mutex_unlock(&ub->cancel_mutex);
+	/* All queues ready - wake ublk_dev_ready() waiters */
+	if (ublk_dev_ready(ub))
 		wake_up_var(&ub->nr_queue_ready);
-	}
 }
 
 static inline int ublk_check_cmd_op(u32 cmd_op)
@@ -4433,9 +4444,10 @@ static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
 
 /*
  * Wait until all queues have fetched their I/O commands, and return with
- * ub->mutex held and readiness guaranteed: then every queue's ->canceling
- * is cleared. Ready may regress between wakeup and mutex_lock() (F_BATCH
- * UNPREP, daemon death), so re-check it under the mutex and wait again.
+ * ub->mutex held and readiness guaranteed. The queues stay canceling if
+ * this round saw a cancel, see ublk_queue_reset_io_flags(). Ready may
+ * regress between wakeup and mutex_lock() (F_BATCH UNPREP, daemon death),
+ * so re-check it under the mutex and wait again.
  */
 static int ublk_wait_dev_ready_and_lock(struct ublk_device *ub)
 {
-- 
2.55.0

