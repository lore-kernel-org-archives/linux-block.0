Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BDD26E71C
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126151; cv=none; b=MHhwtpMk1x20rOrdjiVDLAoMp7/0nkpQbM8P42b5mtNdV2HxlSArVVmkKwopE++j8xbF9G5I+tHgyihL10HmSdxoui9F2M6Ys25F24pGAHNWtLzjsAIyURQQpZBfYznKonyKLy/akzeMGBwMZbXCC+3KFOSfFj2aZ+h1f2nOrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126151; c=relaxed/simple;
	bh=6cNcbP56c/g7M8BxOsHD8BbN0veJqHfg488YKTeo7ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhdUh2EOz5jpHMTWKEIM4YbtvQnxlU58syg8FNjj65cWVQfDv2Os8vSf6X14lXFnGiG0IZaG+eSPG2d+MGskkAKGbAC3A/SFO7nEkLOxrSnW23y4hn6atBFNuXS4OIZKkgk536GkYc3bfmXKohbSJmqh20PpVLBwSPndjxotykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJiAkX9r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJiAkX9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756126148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQg/tkYr0BiNa0lDbaGrLKBLewCMW3vBJJE79xb8SKQ=;
	b=QJiAkX9rL2PAnK1AFIFsJ+Xc0It3PcUzDhVyqIRjzEK1ob7rq2Vk0SMQpYvEzeYWzgWEPR
	p01yZfKxOM+c3q/ys2aTN5F4UeuK2GlvmduhhdQNzV/XywWECfmQJgyqRBxUGgDIyU9wXl
	9jaSoX2RKz6jOrPL2IdloJ4QeIM2KBQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-ctF7H7ekMBaehkEVVyLMOg-1; Mon,
 25 Aug 2025 08:49:05 -0400
X-MC-Unique: ctF7H7ekMBaehkEVVyLMOg-1
X-Mimecast-MFC-AGG-ID: ctF7H7ekMBaehkEVVyLMOg_1756126144
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CAF9180AC40;
	Mon, 25 Aug 2025 12:48:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86700180047F;
	Mon, 25 Aug 2025 12:48:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/2] ublk: avoid ublk_io_release() called after ublk char dev is closed
Date: Mon, 25 Aug 2025 20:48:24 +0800
Message-ID: <20250825124827.2391820-2-ming.lei@redhat.com>
In-Reply-To: <20250825124827.2391820-1-ming.lei@redhat.com>
References: <20250825124827.2391820-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When running test_stress_04.sh, the following warning is triggered:

WARNING: CPU: 1 PID: 135 at drivers/block/ublk_drv.c:1933 ublk_ch_release+0x423/0x4b0 [ublk_drv]

This happens when the daemon is abruptly killed:

- some references may still be held, because registering IO buffer
doesn't grab ublk char device reference

OR

- io->task_registered_buffers won't be cleared because io buffer is
released from non-daemon context

For zero-copy and auto buffer register modes, I/O reference crosses
syscalls, so IO reference may not be dropped naturally when ublk server is
killed abruptly. However, when releasing io_uring context, it is guaranteed
that the reference is dropped finally, see io_sqe_buffers_unregister() from
io_ring_ctx_free().

Fix this by adding ublk_drain_io_references() that:
- Waits for active I/O references dropped in async way by scheduling
  work function, for avoiding ublk dev and io_uring file's release
  dependency
- Reinitializes io->ref and io->task_registered_buffers to clean state

This ensures the reference count state is clean when ublk_queue_reinit()
is called, preventing the warning and potential use-after-free.

Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
Fixes: 1ceeedb59749 ("ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon task")
Fixes: 8a8fe42d765b ("ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 94 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 99abd67b708b..f608c7efdc05 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -239,6 +239,7 @@ struct ublk_device {
 	struct mutex cancel_mutex;
 	bool canceling;
 	pid_t 	ublksrv_tgid;
+	struct delayed_work	exit_work;
 };
 
 /* header of ublk_params */
@@ -1595,12 +1596,84 @@ static void ublk_set_canceling(struct ublk_device *ub, bool canceling)
 		ublk_get_queue(ub, i)->canceling = canceling;
 }
 
-static int ublk_ch_release(struct inode *inode, struct file *filp)
+static void ublk_reset_io_ref(struct ublk_device *ub)
 {
-	struct ublk_device *ub = filp->private_data;
+	int i, j;
+
+	if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
+					UBLK_F_AUTO_BUF_REG)))
+		return;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		for (j = 0; j < ubq->q_depth; j++) {
+			struct ublk_io *io = &ubq->ios[j];
+			/*
+			 * Reinitialize reference counting fields after
+			 * draining. This ensures clean state for queue
+			 * reinitialization.
+			 */
+			refcount_set(&io->ref, 0);
+			io->task_registered_buffers = 0;
+		}
+	}
+}
+
+static bool ublk_has_io_with_active_ref(struct ublk_device *ub)
+{
+	int i, j;
+
+	if (!(ub->dev_info.flags & (UBLK_F_SUPPORT_ZERO_COPY |
+					UBLK_F_AUTO_BUF_REG)))
+		return false;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		for (j = 0; j < ubq->q_depth; j++) {
+			struct ublk_io *io = &ubq->ios[j];
+			unsigned int refs = refcount_read(&io->ref) +
+				io->task_registered_buffers;
+
+			/*
+			 * UBLK_REFCOUNT_INIT or zero means no active
+			 * reference
+			 */
+			if (refs != UBLK_REFCOUNT_INIT && refs != 0)
+				return true;
+		}
+	}
+	return false;
+}
+
+static void ublk_ch_release_work_fn(struct work_struct *work)
+{
+	struct ublk_device *ub =
+		container_of(work, struct ublk_device, exit_work.work);
 	struct gendisk *disk;
 	int i;
 
+	/*
+	 * For zero-copy and auto buffer register modes, I/O references
+	 * might not be dropped naturally when the daemon is killed, but
+	 * io_uring guarantees that registered bvec kernel buffers are
+	 * unregistered finally when freeing io_uring context, then the
+	 * active references are dropped.
+	 *
+	 * Wait until active references are dropped for avoiding use-after-free
+	 *
+	 * registered buffer may be unregistered in io_ring's release hander,
+	 * so have to wait by scheduling work function for avoiding the two
+	 * file release dependency.
+	 */
+	if (ublk_has_io_with_active_ref(ub)) {
+		schedule_delayed_work(&ub->exit_work, 1);
+		return;
+	}
+
+	ublk_reset_io_ref(ub);
+
 	/*
 	 * disk isn't attached yet, either device isn't live, or it has
 	 * been removed already, so we needn't to do anything
@@ -1673,6 +1746,23 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 	ublk_reset_ch_dev(ub);
 out:
 	clear_bit(UB_STATE_OPEN, &ub->state);
+
+	/* put the reference grabbed in ublk_ch_release() */
+	ublk_put_device(ub);
+}
+
+static int ublk_ch_release(struct inode *inode, struct file *filp)
+{
+	struct ublk_device *ub = filp->private_data;
+
+	/*
+	 * Grab ublk device reference, so it won't be gone until we are
+	 * really released from work function.
+	 */
+	ub = ublk_get_device(ub);
+
+	INIT_DELAYED_WORK(&ub->exit_work, ublk_ch_release_work_fn);
+	schedule_delayed_work(&ub->exit_work, 0);
 	return 0;
 }
 
-- 
2.47.0

