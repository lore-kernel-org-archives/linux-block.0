Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271AC3D9020
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859275; cv=none; b=LXtbfFS9BZMwIC19QJXJ/eLhw1Vz8rBPNL7z+cXB3/39knG5gS5xwJZNFIJfu8wj+Z9Je+6yUAnEDTZq4CkBJXglYScvrJ4/l9H0gj3KD/3LAzvWXTmxS7LSIMMLyfGD3iXelQutdStv8ltayuYTwIZMTM3FCeqnc/Afbq91Xfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859275; c=relaxed/simple;
	bh=rTgjMgqwtoKhvUttWqzYWgiAv08mraaeeQvXKyMz/68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCGZeVDFX/YRLQ1MRG4TkB7yQ9mdVV2VPcsyVNu3qy+plyXsBYBs1XEM7vk8QhsM/ycfYDSnGkHVaYbVXO4mjH7G0QAkJEC0f7W0RzvY7nSRuoirebM9YshwO1k9KDS/baSuhR6V/ywby4sq+0753SXfgqJMsBuDtpESiMBHGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSZzBMzH; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSZzBMzH"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-81ad35a4608so2111724a34.1
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790859273; x=1791464073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n4+6MM7pg7PBVKvde4n9pLkDBhuphLjtu79ta3cMaSM=;
        b=ZSZzBMzH6WXe9w4IfwUWDTSYqOgSGmEUUV0fih/MNbvMPlhIl1AlFGUr4A1FXb1Mon
         FLSu9m8lutCufS/s6oCeef1Bgk822lvpEXwV3VYKGMwgT5qt6OV6dLZJ+m5rxTPef+tj
         bmrbg36UEIOp7G++CoviksUlS7a7zXi6j2COGPH3/xzQ25a3jUq3juOFGziVrgz6fxRq
         he0CAQ4fcikimhPA75iAnVKI13K4uAmHdk9KCCbVq7DcTu7SyTRaexI4g6tOlx/WqisJ
         Fe8oPQevBlQv2+I6n7BJ1JE8JDliS2B3WNp5BuDOHdzmfgM5nlh3q46IwGTEEqkRT6JU
         GHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859273; x=1791464073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n4+6MM7pg7PBVKvde4n9pLkDBhuphLjtu79ta3cMaSM=;
        b=Eo57JFuM9OErbWFcymODZPhm2bGrKnFu8a5f+DO6M75e2UgWoSyGbEEAOU/uE3ossV
         6Nc+rVqw+sa7oPiCUO4GZ1klUNVHL6MlF4NDy3VRGwPW4i9JoqocOjRDiw7wj7T0LEZ2
         RP6PwyKXjq56tpJ+F1RownQMw/NkSICLFiHbr0Ye3dGsthJloOPRrc+AQhh7jwRNFsf4
         kGZ/bfacWbj/08P+0Up0luYqbFcNdoVXsQhjCS22QKAHRgh2EUI4v11FyWu/8da9tNY+
         pp9HEcSQBq4TKxjU9KmgczzoeCxl2G9swofhLeEU/vv3LvvZQgQdIXAv0hTrPNHnybqH
         G91Q==
X-Gm-Message-State: AFuF++k2SvHxZz2nSlAr/bjwHjJWTU+JBuRJ1OOQhFSFRtoPdPpee3+N
	CLPSqZNz1cyhuXabBHGvgXiUmUHR9Pu2wFY1XQfun4NrQCaR7TjVE5GCyPgRiw==
X-Gm-Gg: AYBFou226MTFQ+Lq/GNFa0ltxi+l1CgL+niouf3mtZWiIMXkVpMtAiEIyTYilk/vHcl
	CTKydRLivovbVqUhHT6pdAH9xGtN2j7UFDvPSk8fe93WI24MkF9V3/eeWjP3RVjDv0F3SYFhfwO
	LcA+56Rha0lpuwyQRan9CR/t3o+ruqgqUmq7+IepKNUOyGwMpc2KoDEVh4uCpN0vRUyXYSajb+m
	iyMaitVLAXoYoHkDw8p2yxFa6haBSIkjKOd4aX0LtyaT8Kw2WJwwFLpqGOv03IaNeDlYitzipzB
	oRqteM/aaWie6UYBBBV+UslKpKxgvfHHmQ3GkE0xBwH0mTOu0JW7Se3Blxnkxvj65oI7Tf9M985
	QYMDetoNvll2EwP7+yzqthGldSF66ybOxxab4qeEK4LpJb1pTF9OrAxZb8yGzodPZEAIaBXD7L0
	aX8b4QfedS5DZvTVK7hD2brFWjpvpIQp2PtG15XH6hMeDV/OTYfnFBmsRc0uqRSF9RMOkDfVh+i
	vvXsVMQCHriRRSflNf3J1pyyGa3DtezMAz8LkyHo6j7iaUjIQ+S8OE3ejqan2vQngC82KGzjg1F
	Wre6z6fDAmt9GW8kA/dk5ALIHeY=
X-Received: by 2002:a05:6830:a14e:20b0:821:7e64:e413 with SMTP id 46e09a7af769-8217e64e56dmr952397a34.28.1790859272658;
        Thu, 01 Oct 2026 05:54:32 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212b937bf2sm2504806a34.27.2026.10.01.05.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:54:32 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/8] ublk: keep a canceled FETCH round canceling until the server is gone
Date: Thu,  1 Oct 2026 07:54:15 -0500
Message-ID: <20261001125422.1364260-2-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001125422.1364260-1-tom.leiming@gmail.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
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

