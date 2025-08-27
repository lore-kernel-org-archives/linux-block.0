Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A33019B7
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296985; cv=none; b=AY6GmPWj5iHURzZ3OMcMzPZkMcBxGYYrd+JFlpZWoYp2IO30FA33IuktOQOxGq7gDDEht0PlNp1QmNt+enn0CH/x1wBdTeBpDEdd1nL/YpYJCSC5f/VP5T1uCYulZgo0yD9SOD3Niyf+RzyJlES7csI7bdLVNxkYjjWMS9tSK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296985; c=relaxed/simple;
	bh=M0M4Yb3k2+OXWsw5HaB1LZMA0SMkKlavjj37X5pLNTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzhovIjabefiTMiXcKMQNZUnAiN8pemunYVM+ZKYpkcAz1wGOQMYqLH8+YV9uN9uTTr5ZElMXpoNOspgN4vL7c/4/ZGXkx80HL0eyRxjwpf45AMpb+sfgVp/Kw802P9fJvXxHfAzIJeoQ2dXPJQqw13JbuOIetvc3UE5QIdAdwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXWRGQfI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXWRGQfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756296982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9EBz11u3KfSl/30PDyYjrDtgtThr9WX2dLRzieLrt8=;
	b=TXWRGQfIjJVyFkMn+9LCf5v1UjluYQXgQNC3JtuUCPc/PANFZOfdQdSUP3ua10kddFXPVg
	C95Q3+zZPQwkurOEzW3/43V7zb5iz4Ze1oQtGPSBmWocq7fjvcXIMTlskmMPn7DQRZp9pL
	Ac3qytFU596tS7hMaU3Y2r0Dt3RRZyE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-TtF2p0U9NwipozJxnGuc9w-1; Wed,
 27 Aug 2025 08:16:19 -0400
X-MC-Unique: TtF2p0U9NwipozJxnGuc9w-1
X-Mimecast-MFC-AGG-ID: TtF2p0U9NwipozJxnGuc9w_1756296978
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 296DC1800342;
	Wed, 27 Aug 2025 12:16:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E84BD30001A5;
	Wed, 27 Aug 2025 12:16:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/2] ublk: avoid ublk_io_release() called after ublk char dev is closed
Date: Wed, 27 Aug 2025 20:15:59 +0800
Message-ID: <20250827121602.2619736-2-ming.lei@redhat.com>
In-Reply-To: <20250827121602.2619736-1-ming.lei@redhat.com>
References: <20250827121602.2619736-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 drivers/block/ublk_drv.c | 72 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 99abd67b708b..67d4a867aec4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -239,6 +239,7 @@ struct ublk_device {
 	struct mutex cancel_mutex;
 	bool canceling;
 	pid_t 	ublksrv_tgid;
+	struct delayed_work	exit_work;
 };
 
 /* header of ublk_params */
@@ -1595,12 +1596,62 @@ static void ublk_set_canceling(struct ublk_device *ub, bool canceling)
 		ublk_get_queue(ub, i)->canceling = canceling;
 }
 
-static int ublk_ch_release(struct inode *inode, struct file *filp)
+static bool ublk_check_and_reset_active_ref(struct ublk_device *ub)
 {
-	struct ublk_device *ub = filp->private_data;
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
+
+			/* reset to zero if the io hasn't active references */
+			refcount_set(&io->ref, 0);
+			io->task_registered_buffers = 0;
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
+	if (ublk_check_and_reset_active_ref(ub)) {
+		schedule_delayed_work(&ub->exit_work, 1);
+		return;
+	}
+
 	/*
 	 * disk isn't attached yet, either device isn't live, or it has
 	 * been removed already, so we needn't to do anything
@@ -1673,6 +1724,23 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
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
+	ublk_get_device(ub);
+
+	INIT_DELAYED_WORK(&ub->exit_work, ublk_ch_release_work_fn);
+	schedule_delayed_work(&ub->exit_work, 0);
 	return 0;
 }
 
-- 
2.47.0

