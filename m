Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328C35972
	for <linux-block@vger.kernel.org>; Sat, 23 Aug 2025 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755917704; cv=none; b=MmMY0FPvBTBN2Yj4XtlkFo/+GEIprcr7jTGJgjW5ggSqBBwnBIBltSsFi2IvhlJdgl0Y62vTjesioc71jcNf+64ANfd8Jkl8KjaWp+BGsfANYObXnScv7wJmBi3TkXpoD/ID3EbzwSaN+EncLrNgyyNC1/txx5ShtWi6gwsVWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755917704; c=relaxed/simple;
	bh=8ABK28qQRCbBFwOTziZ5dFOXXrBXt+ovs795aaiF2OM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2sC6Y9H1bNrYwW3LC09FtwUH+WiJfLT2ZsCOhXrJE/uuCJZWsAeGViUXs1FhY7auEsNay57SNAZbh7K9tyOrcP9W/+PLamvEpHRDMVd8cyvAiPR+7296d90E/WUy9mheGu7HRCY9Ro7WgCKuxNmr0qJA2Gj+n3i8+3AJd2LnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Suy35bIE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Suy35bIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755917699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HDb+dPtMcvHqaFR1F+Id0+PvgTnpV0JjHDxo6RQIj40=;
	b=Suy35bIEoeDhVV0k0cNBnexpDEdtiA0O2mjmTIgn5Z5QbhGL0Kw0qVKbHaXJ9KdBlLL+44
	ukeeTLzrmLkX5uytAYHmnB6T5axBvPQLD41riGSlV9AvW4F1ETB8MzG7eTkak8KWKV10nd
	1ZQciOcQTatXns2I9Nq8BAh4QBjWCAc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-PCRs-ROvMqihxPp9HjJlzA-1; Fri,
 22 Aug 2025 22:54:55 -0400
X-MC-Unique: PCRs-ROvMqihxPp9HjJlzA-1
X-Mimecast-MFC-AGG-ID: PCRs-ROvMqihxPp9HjJlzA_1755917692
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 584BE180036E;
	Sat, 23 Aug 2025 02:54:52 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35ED9180044F;
	Sat, 23 Aug 2025 02:54:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: avoid ublk_io_release() called after ublk char dev is closed
Date: Sat, 23 Aug 2025 10:54:43 +0800
Message-ID: <20250823025443.2064668-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
- Waits for active I/O references dropped
- Reinitializes io->ref and io->task_registered_buffers to clean state

This way won't hang because releasing ublk char device doesn't depend on
unregistering sqe buffers in do_exit().

This ensures the reference count state is clean when ublk_queue_reinit()
is called, preventing the warning and potential use-after-free.

Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
Fixes: 1ceeedb59749 ("ublk: optimize UBLK_IO_UNREGISTER_IO_BUF on daemon task")
Fixes: 8a8fe42d765b ("ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 99abd67b708b..21a8f76e4685 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1595,6 +1595,48 @@ static void ublk_set_canceling(struct ublk_device *ub, bool canceling)
 		ublk_get_queue(ub, i)->canceling = canceling;
 }
 
+static bool has_io_with_active_ref(struct ublk_queue *ubq)
+{
+	int i;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		struct ublk_io *io = &ubq->ios[i];
+		unsigned int refs = refcount_read(&io->ref) +
+			io->task_registered_buffers;
+
+		/* UBLK_REFCOUNT_INIT or zero means no active reference */
+		if (refs != UBLK_REFCOUNT_INIT && refs != 0)
+			return true;
+	}
+	return false;
+}
+
+static void ublk_drain_io_references(struct ublk_device *ub)
+{
+	int i, j;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		if (!ublk_need_req_ref(ubq))
+			continue;
+
+		while (has_io_with_active_ref(ubq))
+			mdelay(3);
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
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
@@ -1609,6 +1651,20 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 	if (!disk)
 		goto out;
 
+	/*
+	 * For zero-copy and auto buffer register modes, I/O references
+	 * might not be dropped naturally when the daemon is killed, but
+	 * io_uring guarantees that registered bvec kernel buffers are
+	 * unregistered finally when freeing io_uring context, then the
+	 * active references are dropped.
+	 *
+	 * Wait until active references are dropped for avoiding use-after-free
+	 *
+	 * This way won't hang because releasing ublk char device doesn't
+	 * rely on unregistering sqe buffers in do_exit() path.
+	 */
+	ublk_drain_io_references(ub);
+
 	/*
 	 * All uring_cmd are done now, so abort any request outstanding to
 	 * the ublk server
-- 
2.47.0

