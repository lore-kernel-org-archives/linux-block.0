Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B375538D71
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693077; cv=none; b=l3zeuQ+QaZhQQnYyr2QavLigol3GPve9HQihIg/IiGUwYJp8r0KD/LVKvQKzET7shsoDozpjRXlLbuuAZegRjRp6xrfthO/qwQqj096BeX3LX6raEep2RKtOvDRkSHa/yinrTyhTkVCIwByRoG88cukQCGcmdPMCes5LcVr3RXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693077; c=relaxed/simple;
	bh=3I8q3l882JIcE1IgO5rz9dcJ+s4ewYhrblWApRnrtxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7MJCvSTQjrIjTpdXXU5Qa2cHWmCqxk35kGcNaMh5311e75qAOPisKm1lKZJbDyh/L5GMcTWF2TBcqDYsKt7C5Io+aVhUYsK36XnC6vtutmsL2c0urcreoVjym3Lw0FShouIf3by3oV7xb3Fl6Mf+ogfABlZoHIQZa2IqT4GBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bud9wY6a; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bud9wY6a"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2afd63c3e0so461643966b.0
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790693070; x=1791297870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cbyOdvEerjzfIl5xD+HOwuljaf5ylJgalA+Yv8hDp5o=;
        b=Bud9wY6aVzqyNF3k6K/5UotAIwvVdlZjxc5MB45H6dpiqzepda9NSO9Yzoi670dG8r
         HSC7gVELz9eikPCNq8E4jBUgnKlRwkOa4GUz4Ro8Oidipu9h7041TBausvTNKQlwr6Kl
         pJc8UdYWXfkiRabM5QEbq4E+JZyuyVvEm7H5m52fHOkPS3GArlfjPuCHS9uM8y86ET7/
         /jPVqLF620iCgJoiTiLT7JuGJ6TuUEzK8+1HDjOnepwDY92cJ+Gt29DcqcscQ1QXtKdK
         Dgo4CkpWphjvrWZ2o/Vc+yg86NYW72QDpE4/j9yoVe/O60qMPg3NDsnx4rtgHRAh1PyS
         nwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790693070; x=1791297870;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cbyOdvEerjzfIl5xD+HOwuljaf5ylJgalA+Yv8hDp5o=;
        b=pPikPazluNPR2tK9+Zj9J0qSrh7kRvklLxHXY5iS/2be4LSxVEOMONbc28krADX2cT
         FM8U25nV69BIrxME9Nyl8THomrLz+7yVw0D7mQhTFEazgY5S6GJvvYC1cqIMS+nDu1mt
         CIWa9i7whqJ56rZUVAesP6UJJ2gmhbk36GR9hKrBlWW9ty2JaNlvoSlBXLRVMbEHzO8C
         TBPAru1QjnWzZP7XAY0jx3w8cTghPSjfC3//6Ez9vdUpwgznluJZsZMb/QtSvbkE4H++
         wCKnPAK3Wgy1FJV66F8mZ5FnQrOioMBbLxLDcd7Si+UdTjVILgHAE5Xb8p/skCGR7aZf
         VSeQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2ZmHztRUIgcdLUXTvudHNrwH3uazD3VSHbhL/j+RAVBLMDc+IEEp68sf8iKROi9Wz6F8qs2yg5aNULg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIyU2NXV8JLQf6XlEP2W/z7+zr5twuHPoQiMSAB/liOLlhkjIdE
	zAbgTXU0cq2zJ/qeDAvMI/NWmp8RFBD1wWHETq6TOk5RJwTaWL7GaPwWEMak+g==
X-Gm-Gg: AYBFou3lRFCf+YJRA7UIG2PPnR0Zf0kteYM9vxzhQCFY7AIgE2JIPn0K6yuqBtceTIj
	UMvgc5h4g90tH0G28ykfVUaXfaejpwODG5rnJgA8ZQtv/gzQjWiSB9UDwu2AyTDc4H+SEOOdcXu
	dO51A6WVgqS33A76uq94Y8l/vp0JfATsZ+86U9jUTrPuTj9yuJSSh/yQfs+DO+obS6OLDH6ehGv
	Q8Sbzjqc+lcZ2kjxzjv282CvLqaVNj98/GB4I/ietwhhzw0JAE3EkLDCoxyd/P1F7+4tj+09PHH
	e17hMUvSwRcnzSZa+883gMX9XomrHMEpY+vJITnpSDaIDhXmlANEvF54t+dNKC/8qC/Ij6Lu8ko
	uvexjUL/UBRMo6IwPunBTN1CM2+th3c0g4AhMIQwmZQX3ZG3MxPndYmMekwNFbJRmQ3d8kZWn8T
	NHbL5akAhOzzb3pq5Gp9Ot4uWcjgRTGTdD1iedQfPC1IBWeixPzrFel1Gek23Mi7lXtgdpxyaQy
	DxvJijx/rU8SnJxmTpzvKBHJLdsE5p0QDlA2ruxFMUVuHVAHOoZjRyP/QiUJK+iun4pY9A01sgK
	t6A=
X-Received: by 2002:a17:907:e982:b0:c29:45f6:6a0b with SMTP id a640c23a62f3a-c2ac25d541fmr1412263166b.34.1790693069331;
        Tue, 29 Sep 2026 07:44:29 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae678bbb0sm651166266b.5.2026.09.29.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:44:28 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:44:16 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/9] ublk: fix dispatch to canceled io commands
Message-ID: <arvOwDHOgvpVW86j@fedora-laptop>
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>

Hi Josef,

On Mon, Sep 28, 2026 at 04:00:36PM +0000, Josef Bacik wrote:
> ublk can dispatch a block request to an io command which is completed
> already, and the kernel oopses in ublk_queue_rq() on a NULL io->cmd.
> Before commit f7700a4415af ("ublk: fix use-after-free in
> ublk_cancel_cmd()") it is a freed io_uring request instead. Commit
> 1133b93fc7f6 ("ublk: set canceling flag even when disk is not
> allocated") fixed the io_uring exit route before the first start.
> These are the routes next to it:
> 
>   1. STOP_DEV on a device which is ready but not started, then
>      START_DEV. ublk_stop_dev() cancels the fetched commands after
>      dropping ub->mutex, without marking the queues as canceling.

It looks two races: STOP_DEV vs. START_DEV, STOP_DEV vs. FETCH.

Looks fast io path shouldn't be touched for fixing the races.

>   2. A partial FETCH round whose task exits, once another task
>      completes the round.
>   3. During recovery, the task of a queue which is ready already
>      exiting before the last queue is ready.

2 and 3 could be solved in single simpler patch by making use of the
ub->canceling flag, and it is easier for backport.

From 83d95ff6f06ad71705e2432ffc58971bec0ec648 Mon Sep 17 00:00:00 2001
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 29 Sep 2026 08:25:05 -0500
Subject: [PATCH] ublk: keep a canceled FETCH round canceling until the server
 is gone

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

Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
Fixes: 3f3850785594 ("ublk: fix batch I/O recovery -ENODEV error")
Cc: stable@vger.kernel.org # v6.17+: needs cancel_mutex
Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/linux-block/20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com/
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Assisted-by: LLM
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




Thanks,
Ming
