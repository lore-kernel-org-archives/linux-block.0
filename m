Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEC4E77F7
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611598; cv=none; b=EikZPRR/ZBuOTT1xcA85QUJllIKFl2q7G3ssu6RoJ5X95An2uzn44pL9tHalPDYj8+sjdS9IkuO1NkkSaGvp8IPyATJ7m46IoDOI0FZkOqNz+PvhZGh4vU/Kn9K+IoDsSoGkWtYcx8F3jirSNZwsu7+OiAc2E1eAGi2bFJuOnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611598; c=relaxed/simple;
	bh=2CSyBJLnBQ9egi4b1L3g/oRU+jtPQOO8FS15QFnzYGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMq0Ifg2KLcsCD5TuazIvvCE7QEiVHdcn4inJhtMlDgRRlFt/xf0SP5vlr/zTIJASiE4vzobuNg+VI7Ob+0+0qBp9aNM0ABnZcmmondU25JZNjZGTJi6vo8ERYpbb9mSsNhDZBMnywegP1E5RwUVSRtMNoEDEeISRdwsROo9lKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=EVSlQvXr; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="EVSlQvXr"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-5332cd97dc9so15071461cf.2
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790611590; x=1791216390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5yDEa+qmbJcJyachLPJtnHNQFVXhnEpOITBm0Nx5uM=;
        b=EVSlQvXrO1sEM8uB0RYgysEF0Lkd8xo0+a0/5AbYYzca0o2lj0NZKZdzdRyfkdJ0Ck
         lW4TVGhFsqECTNlkfjH1dX6AQ4hzB6quLscbrehui0NUD7GWPhQdOHbFhyCFlaU7pCp4
         wuIV/vQz16drp38aQjgyvwTKZJghYmUqMr08i4+mOrkL1knhC4zhB2lkh7mFvOLFnP2T
         X2Dv67ethFS4a/PSIwgorDvKLp9A7of0V9Q7arc53Mc6pGDMtQc2hFxyaaMia+5eGbBl
         8A9HUYWHStZrhgriTgw7dnWdP+X8Y+JWmUZixs3Dy8kg6y/sdX0ocu6wWB6FBH6b/lb5
         +Tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611590; x=1791216390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5yDEa+qmbJcJyachLPJtnHNQFVXhnEpOITBm0Nx5uM=;
        b=qW/8HqSIAOA41koUHPhHX+y7VuCx+q3lOixoVEBLDvNKu/PF93gm82j7VO//234ThF
         SJUfIcf56T8LbSSB9224h8jtJHvBJ/eiCGwJNw9EhmASVTKBmF4rmH/fwmYeduVVvo8U
         q9FmzaTXoiY+dWPcvG906OhrruxV/dn3bvsiNCYBhiyBQy9PDqWlK4NwguoAuyX5XXj/
         Ww0SJEAAsNh1mRqoymlpphmGjNg7+dIRAdqLAqXIDey9QjNoHlu3OBsVm0Q1BvHS5LPi
         RRhKsXZi5QHdEUaxNa9IWW3w+h9WbDXCxg/2aK0YC7sPIMvmR8a+3d98AnNhffAbGWck
         pExw==
X-Gm-Message-State: AFuF++m3XOtupsMaUmi3KSaPSFqpwJyhyJk6mTbdr0Y0cPy5v08rlzfn
	UX6WUxNB91YaIldWFpyLzi0XHq9Few2Xtwjc+tQovVb5rnYJNiog+O4L030R8IaVC0A=
X-Gm-Gg: AYBFou2NZ/OyBY+5EbY3b0k+D3e6XYyxb0E42Yx3OxfnCgufT4yRSUPHGAyfRdnABVz
	HJRQCSeYCrRmdexYlT0Kaoj+BEFRL1CyrvW6MiVbZAEjnN6u8/x8WvjAD0k/IO4q4fL4MkGvDTE
	KkRspzVyc4X4Ru4RtNmYOU2V50fMc27r5c29DSsEJgyyFhg2zqy4GXHZEa0ijSaimkVQYCj/n9j
	8Db6zxgYWlBHPNG4Xa4JoshvOeyPC77uic5bg2T722afK/UAz5kvqy5dqGq38AL1jPVx9SIgjqf
	QhWG63wlHmtnvX6TR+W2e8JZWZvSEwR7aDv7tPxwyMqoiq0DvMOmeR6syY+P41+z+UbPrOyCi3I
	b5Q7UscwPYUjbDY/j9uTFdGZH4mbPu+zhBix4bxf7790fiYPHMjvSHLAiFhaKB2s+B6mKsSBRJH
	YJOqmiazY577VBDjfurett9W5grIRSxDYHXa0Dz3HJxTGCCqR6QnNKxdk+0UkU9duyR3LuvJI24
	Hw2BFoq1jQ4FkI=
X-Received: by 2002:a05:622a:4814:b0:52f:b9ad:9dad with SMTP id d75a77b69052e-5330b68c2cbmr215268241cf.36.1790611589603;
        Mon, 28 Sep 2026 09:06:29 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5332240fc16sm66398251cf.27.2026.09.28.09.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:06:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 28 Sep 2026 16:00:43 +0000
Subject: [PATCH 7/9] ublk: mark queues and command in one cancel_mutex hold
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-b4-ublk-cancel-stop-v1-7-4a4360232a46@toxicpanda.com>
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
In-Reply-To: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790611254; l=4510;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=2CSyBJLnBQ9egi4b1L3g/oRU+jtPQOO8FS15QFnzYGg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNrk8/Xv0BB8awotM3ZWJl80COQrBAS7HLpoXrEosgWgnjPvJXPANlN0swBi1IO/75Z3SsW7jQq
 LRtP5v80Ugg4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

ublk_queue_rq() dispatches a request to a NULL io->cmd and the kernel
oopses when the last FETCH of a queue runs in the middle of
ublk_uring_cmd_cancel_fn(), which drops cancel_mutex between marking
the queues and marking the command:

    cancel callback                 last FETCH of the queue
    ublk_start_cancel()
      queues marked canceling
      cancel_mutex dropped
                                    ublk_mark_io_ready()
                                      queue is ready
                                      no canceled command found
                                      ->canceling = false
    ublk_cancel_cmd()
      UBLK_IO_FLAG_CANCELED set
      io->cmd = NULL, command done

ublk_queue_reset_io_flags() takes cancel_mutex for the ready
transition, so once the callback holds it across both steps the
transition comes either before or after them.

Move the locking of cancel_mutex from ublk_start_cancel() to its two
callers, and have ublk_uring_cmd_cancel_fn() claim the command with
ublk_claim_cmd() before it drops the mutex. The command is completed
after the unlock.

ublk_start_cancel() holds a reference on the disk, and dropping it used
to come after the unlock. Keep it that way by returning the reference to
the caller, the last put runs disk_release() and that should not happen
under cancel_mutex.

Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/ublk_drv.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 99ac56d36dd0..18046e2bf753 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2748,11 +2748,15 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 		ublk_abort_batch_queue(ub, ubq);
 }
 
-static void ublk_start_cancel(struct ublk_device *ub)
+/*
+ * Returns the disk reference it took.  The caller drops it after
+ * cancel_mutex, the last put ends up in disk_release().
+ */
+static struct gendisk *ublk_start_cancel(struct ublk_device *ub)
+	__must_hold(&ub->cancel_mutex)
 {
 	struct gendisk *disk = ublk_get_disk(ub);
 
-	mutex_lock(&ub->cancel_mutex);
 	if (ub->canceling)
 		goto out;
 
@@ -2774,8 +2778,7 @@ static void ublk_start_cancel(struct ublk_device *ub)
 		ublk_set_canceling(ub, true);
 	}
 out:
-	mutex_unlock(&ub->cancel_mutex);
-	ublk_put_disk(disk);
+	return disk;
 }
 
 /*
@@ -2900,8 +2903,13 @@ static void ublk_batch_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_batch_fetch_cmd *fcmd = pdu->fcmd;
 	struct ublk_queue *ubq = pdu->ubq;
+	struct ublk_device *ub = ubq->dev;
+	struct gendisk *disk;
 
-	ublk_start_cancel(ubq->dev);
+	mutex_lock(&ub->cancel_mutex);
+	disk = ublk_start_cancel(ub);
+	mutex_unlock(&ub->cancel_mutex);
+	ublk_put_disk(disk);
 
 	ublk_batch_cancel_cmd(ubq, fcmd, issue_flags);
 }
@@ -2926,7 +2934,10 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
+	struct io_uring_cmd *claimed;
 	struct task_struct *task;
+	struct ublk_device *ub;
+	struct gendisk *disk;
 	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
@@ -2935,15 +2946,27 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (WARN_ON_ONCE(pdu->tag >= ubq->q_depth))
 		return;
 
+	ub = ubq->dev;
 	task = io_uring_cmd_get_task(cmd);
 	io = &ubq->ios[pdu->tag];
 	if (WARN_ON_ONCE(task && task != io->task))
 		return;
 
-	ublk_start_cancel(ubq->dev);
-
+	/*
+	 * Mark the queues and the command in one cancel_mutex section, so
+	 * that a queue getting ready meantime either finds the command
+	 * canceled or clears ->canceling first and gets marked again here.
+	 * Complete it outside, ublk_claim_cmd()'s other callers have to.
+	 */
+	mutex_lock(&ub->cancel_mutex);
+	disk = ublk_start_cancel(ub);
 	WARN_ON_ONCE(io->cmd != cmd);
-	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
+	claimed = ublk_claim_cmd(ubq, pdu->tag);
+	mutex_unlock(&ub->cancel_mutex);
+	ublk_put_disk(disk);
+
+	if (claimed)
+		io_uring_cmd_done(claimed, UBLK_IO_RES_ABORT, issue_flags);
 }
 
 static inline bool ublk_queue_ready(const struct ublk_queue *ubq)

-- 
2.55.0

