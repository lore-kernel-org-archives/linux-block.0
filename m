Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475524E50D5
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611329; cv=none; b=YxyagEQcVOcORyhwRSKNbaKMheJ2RUlMiAtxr5r702JSBdqAD75BdfqH3q9lFDJWXfZmUieeQ2FMVthPDMDVmYOV5jS+hLqYvhVh0vHZyctuP22++DdIrqPCvrILFymGx4526xW8pObipdwB6tieyrTozW/pByZzhb2Xt25E+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611329; c=relaxed/simple;
	bh=73MGnpW2ieFcj+uF2YtDviAE85P/tXgPYLJC2bt+zfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVqarW1rCNKRxTJOE1B5n2/zVwW2QXSKM1WbfU3SGpX2yvOBYJBZ0OLpGByFpA6QU4lyhsIDGQYLOdOBv5cmhiIMLzGFVyBwoH4fHQJn7Y5PQKp2eVo24+iGQ+ko9IF8B0z16htPuGLRnEqy62FyS7yUgrgZ5xU7TlbBdWEb5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=L2E1jlz9; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="L2E1jlz9"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320dc09fcso17874891cf.0
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790611326; x=1791216126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yOR/7ZSeKreos8H7lYmMhOMWjlsRJzWvEJBuLJrOJv0=;
        b=L2E1jlz9EiDSmIqhqprP+fxhaQveTrJjokHbK6S3mWT0mHI8qWRR9OFRVQLaCZxUT5
         LMPy8867HFuJOFJhpr0j8tL7xCyyyd6ZF2nedX5RciCxwW4YDI/KH8srqxtYtita91XG
         ZLNWWViW353EZasWgqF2teGF3T5jnaSs5WNzVBfufqAbD/Wh9Ry2OuYvz5UaJkP6GfrR
         8IZ4KasSPx6kxnY5MXYFONUgC4UrbT8kDmz+5vZ3AsmE0//3I9CwNrVCambLzMb0H8MS
         aPKxKmtxgfSuYbFMyfqFDITEzay2jgbDGbD+vc+m/iBbbmpuXvkz1Rh+QpFKFns1tF9x
         ApXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611326; x=1791216126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yOR/7ZSeKreos8H7lYmMhOMWjlsRJzWvEJBuLJrOJv0=;
        b=2IgOiU6LK/zSLL8UP4XLOeJ2YtDJ2VP3/i8AwbWQ/7hSgVTBpImEyLHJynzEKutRfA
         TFOP4KNCntqe6WhV2vsY4DeHWaxQ63feHy1PPuYBS4qHP0RLhdvdjoNwFeSUOgcjfvgP
         SAx0jORH4umrjF3p+yNodPRHmujElc7lJmdSOhqV63+r2xL3L0r5TyMy984fVuOkuBeT
         i5aFjebhhr465AHcZm2KPQcaJ+VlDvvNO1CYXBBCv++HDALdzHJ5AiNKRnCevnVjhzrO
         n1KFdv39hb1cWmoOx3dKsg6dZvDdEFeDJXJDmkKgYFjwE7QP0ycJGdE1ZHiZYmFybkEa
         MFFA==
X-Gm-Message-State: AFuF++lvYicXkjyRuZ8a5l8lTmRfGVnG0iDYV5rNtlA6G3RrKwDVWvEY
	OFwZjV6imQJABZcGbDJU23FVrKHacqD3WNE5BKvCiDBuO3SNAJyrZJrIPC/3sNPlU+s=
X-Gm-Gg: AYBFou2m6qjudN8kFhtJtKTX8iHidluMKV44pLT2ImT+Zz+vq8XU31Ft41Xpq2tjusg
	FQJu+1v4kQcUinl9N6VMw0KR3cY8Y47nqQIXC3A5IrTKaqLRp3iQGQVxuY8whFHTqSuU9hO32x7
	BTC/4U/gPVF16Pz54nl6bKz9fyQk+79x7iz09xhQKOrUyJISpV2Wz4pF02hgqzdV7e+jXE3TpBl
	ra32GDTGpVodYFKJl2ZL0YDqSujkgNPMxNbZZzX8TJnt7ZAkg6BxI4LZ3w45442qAJF3OLI04bg
	bLnzVFMNNtcaU8d1GocSOqUygnNRwmWTWJzzE6wI5h7D6Lcz52Ru7c4LVfLkIGgZh58N6ilelLb
	cYB8T5evLKfGrw8x5jAGAN+5a/wi89g0MzMDfzEp4S0nN/9Mg86VKurGcSMuju4yX1BDeBgbydl
	4nGXaCez5OSookChg8CYNzv0mhaLwh6y8C9sBloX+qCCzUtv5ZnqBuPdsw9iocy1lnCsimy+aWe
	p1wV76+XnVOt8g=
X-Received: by 2002:a05:622a:1393:b0:530:faa8:a51c with SMTP id d75a77b69052e-5330b68e2bamr204863121cf.34.1790611325711;
        Mon, 28 Sep 2026 09:02:05 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53322132696sm67048711cf.9.2026.09.28.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:02:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 28 Sep 2026 16:00:37 +0000
Subject: [PATCH 1/9] ublk: keep queue canceling over canceled commands
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-ublk-cancel-stop-v1-1-4a4360232a46@toxicpanda.com>
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
In-Reply-To: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790611253; l=6903;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=73MGnpW2ieFcj+uF2YtDviAE85P/tXgPYLJC2bt+zfk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOOdBKQ97O44K8Ny2WCuJDHgD27SGq0h6IagqYgCGbR8yWxIRLgqtAvh84jBZ8SPnVyIKjL1XSO
 TuwFgY2JgaAM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

ublk_queue_rq() dispatches a request to a NULL io->cmd and the kernel
oopses when a queue got ready over commands which were canceled after
being fetched. ublk_mark_io_ready() clears the queue's ->canceling once
q_depth commands got fetched, and that count does not go down when a
fetched command is canceled:

    task A                          task B
    FETCH part of the queue
    exits, its commands get
    canceled
    ublk_uring_cmd_cancel_fn()
      queues marked canceling
      io->cmd = NULL, command done
                                    FETCH the rest of the queue
                                    ublk_mark_io_ready()
                                      queue is ready
                                      ->canceling = false

During recovery the disk is attached at that point. Before the first
start START_DEV adds it afterwards.

The UBLK_IO_FLAG_CANCELED left from an earlier round is dropped after
the command is published, and ublk_cancel_dev() does not hold
ub->mutex, so a cancel coming in between loses its flag again.

A UBLK_F_BATCH_IO queue has no per-io flag for this, but STOP_DEV and
QUIESCE_DEV set its ->force_abort when they cancel its fetch commands,
so key on that for such a queue. ->force_abort is only cleared once the
queue is ready again, by ublk_queue_reset_io_flags() after this check
has read it, so one left set by the quiesce of a server which is gone
would keep the queue of the next server canceling. Clear it in
ublk_ch_release_work_fn() once the old server is gone, under ub->mutex
since ublk_stop_dev_unlocked() sets the flag under that mutex and needs
it set until del_gendisk() returns. From then on until the queue is
ready again, requests for a UBLK_F_USER_RECOVERY device are requeued
through ->canceling instead of failed through ->force_abort, as they
are on a queue without UBLK_F_BATCH_IO.

Fix by keeping ->canceling at the ready transition while a command of
the queue carries UBLK_IO_FLAG_CANCELED, or while ->force_abort is set
on a UBLK_F_BATCH_IO queue, and by dropping the stale flag and
publishing a fetched command in one cancel_lock section.

Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/ublk_drv.c | 59 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e7162e..183de080e008 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2603,6 +2603,16 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 		}
 	}
 unlock:
+	/*
+	 * A ->force_abort left set here was set against the server which is
+	 * gone, clear it so that ublk_queue_reset_io_flags() does not count
+	 * it against the next one, whose requests ->canceling holds back
+	 * until its queues are ready.  Do it under ub->mutex, under which
+	 * ublk_stop_dev_unlocked() sets the flag and relies on it until
+	 * del_gendisk() returns.
+	 */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		WRITE_ONCE(ublk_get_queue(ub, i)->force_abort, false);
 	mutex_unlock(&ub->mutex);
 	ublk_put_disk(disk);
 
@@ -3015,27 +3025,44 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	ublk_cancel_dev(ub);
 }
 
-static void ublk_reset_io_flags(struct ublk_queue *ubq, struct ublk_io *io)
+static bool ublk_queue_has_canceled_io(const struct ublk_queue *ubq)
+	__must_hold(&ubq->cancel_lock)
 {
-	/* UBLK_IO_FLAG_CANCELED can be cleared now */
-	spin_lock(&ubq->cancel_lock);
-	io->flags &= ~UBLK_IO_FLAG_CANCELED;
-	spin_unlock(&ubq->cancel_lock);
+	u16 i;
+
+	/*
+	 * The ios of a UBLK_F_BATCH_IO queue are not canceled one by one,
+	 * canceling the queue sets ->force_abort instead.
+	 * ublk_ch_release_work_fn() clears the flag when a server goes away,
+	 * so one seen here was not left behind by an earlier server.
+	 */
+	if (ublk_support_batch_io(ubq))
+		return READ_ONCE(ubq->force_abort);
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		if (ubq->ios[i].flags & UBLK_IO_FLAG_CANCELED)
+			return true;
+	}
+	return false;
 }
 
 /* reset per-queue io flags */
 static void ublk_queue_reset_io_flags(struct ublk_queue *ubq)
 {
 	spin_lock(&ubq->cancel_lock);
-	ubq->canceling = false;
+	/*
+	 * A command canceled after being fetched is still counted as ready
+	 * but can't take requests, so the queue has to stay canceling.
+	 */
+	if (!ublk_queue_has_canceled_io(ubq))
+		ubq->canceling = false;
 	spin_unlock(&ubq->cancel_lock);
 	ubq->fail_io = false;
 	ubq->force_abort = false;
 }
 
 /* device can only be started after all IOs are ready */
-static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id,
-	struct ublk_io *io)
+static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id)
 	__must_hold(&ub->mutex)
 {
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
@@ -3044,7 +3071,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id,
 		ub->unprivileged_daemons = true;
 
 	ubq->nr_io_ready++;
-	ublk_reset_io_flags(ubq, io);
 
 	/* Check if this specific queue is now fully ready */
 	if (ublk_queue_ready(ubq)) {
@@ -3269,6 +3295,8 @@ static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
 static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 			struct ublk_io *io, u16 q_id)
 {
+	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
+
 	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
 	if (ublk_dev_ready(ub))
 		return -EBUSY;
@@ -3279,7 +3307,16 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
 
+	/*
+	 * ublk_cancel_dev() runs without ub->mutex, publish the command under
+	 * cancel_lock so that a cancel either misses the io or finds it whole,
+	 * and drop a stale UBLK_IO_FLAG_CANCELED in the same section first so
+	 * that one set from now on stays.
+	 */
+	spin_lock(&ubq->cancel_lock);
+	io->flags &= ~UBLK_IO_FLAG_CANCELED;
 	ublk_fill_io_cmd(io, cmd);
+	spin_unlock(&ubq->cancel_lock);
 
 	if (ublk_dev_support_batch_io(ub))
 		WRITE_ONCE(io->task, NULL);
@@ -3306,7 +3343,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 		ret = __ublk_fetch(cmd, ub, io, q_id);
 	if (!ret) {
 		ublk_apply_io_buf(ub, io, cmd, buf_addr, &auto_buf, NULL);
-		ublk_mark_io_ready(ub, q_id, io);
+		ublk_mark_io_ready(ub, q_id);
 	}
 	mutex_unlock(&ub->mutex);
 	return ret;
@@ -3723,7 +3760,7 @@ static int ublk_batch_prep_io(struct ublk_queue *ubq,
 	ublk_io_unlock(io);
 
 	if (!ret)
-		ublk_mark_io_ready(data->ub, ubq->q_id, io);
+		ublk_mark_io_ready(data->ub, ubq->q_id);
 
 	return ret;
 }

-- 
2.55.0

