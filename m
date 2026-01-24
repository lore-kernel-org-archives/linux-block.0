Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9241C71
	for <linux-block@vger.kernel.org>; Sat, 24 Jan 2026 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769228852; cv=none; b=HjHVUTFHlNHtv/sOymiGvxMP0u3x4S2eo08MOzChy7od//QfU4VynzqsaJGd7tdHbTM0qUVSsrt1ZEnS0YLWkAwMZTRrc1OUG/8+GHDzSPKZHNXvrOD+LlPiCnyKq0HsKm/hQlM4QTOhFXG7qeYvyswGFu9hWquW3sIdJzY+itA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769228852; c=relaxed/simple;
	bh=HOJju+4AtcwM088MbqTfHnOa2O8cKksPoOR3ztigb/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a19c1n3nonCzgLVANk+M8KcOrGcK8lqf6/8dESNdiXs57CZ0CR25ONHNB49qxiC2LgPaxsvy7purLIM1Y1928FdqKe1nTRrR0Wr79RIYmgshHhEKueNvd4ZaDkvkog6DnFwlMw9sL36JmevhPxmRYpxVyWUvaYZjZ/D1wGzaaXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObHViSHC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObHViSHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769228849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5FcEPL2VGjfgAMi4PgE3MtQe1wcdrQmITZ2S/uSo6Xc=;
	b=ObHViSHC7vX+l+oR2GOLJjULvZdc6dwSx7FiZiCTKv9oWe9mlirryOdoyzHIkyNdft2AM/
	pkjmG4VyVOj7ZMtFsFISDwHM+iULaWBN87sCzjB6TV4Uo9tWb/O1LrHsRpGSmdCh1sHEbR
	k7HOHOv8ogOQTOMZhZ7G8lY8kjtx+UA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-sTK9WDVhPGq-IfLuJMTGPQ-1; Fri,
 23 Jan 2026 23:27:25 -0500
X-MC-Unique: sTK9WDVhPGq-IfLuJMTGPQ-1
X-Mimecast-MFC-AGG-ID: sTK9WDVhPGq-IfLuJMTGPQ_1769228844
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A480195608D;
	Sat, 24 Jan 2026 04:27:24 +0000 (UTC)
Received: from localhost (unknown [10.72.116.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50A7C1958DC4;
	Sat, 24 Jan 2026 04:27:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2] ublk: document IO reference counting design
Date: Sat, 24 Jan 2026 12:27:16 +0800
Message-ID: <20260124042716.2314690-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add comprehensive documentation for ublk's split reference counting
model (io->ref + io->task_registered_buffers) above ublk_init_req_ref()
given this model isn't very straightforward.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- clarify `both ref and task_registered_buffers are 0 before dispatch`
	  (Caleb Sander Mateos)
	- ublk_sub_req_ref() is the point for collapsing task_registered_buffers
	  into the atomic ref, optimization can only be used before this point
	  (Caleb Sander Mateos)
	- Both ref and task_registered_buffers becomes zero in ublk_check_and_reset_active_ref
	  (Caleb Sander Mateos)
	- add `zero copy with ublk server killed example`
	- document io->lock is for protecting task_registered_buffers in case of batch
	  io

 drivers/block/ublk_drv.c | 89 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7981decd1cee..8a5a6ba29a1d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -985,6 +985,95 @@ static inline bool ublk_dev_need_req_ref(const struct ublk_device *ub)
 	       ublk_dev_support_auto_buf_reg(ub);
 }
 
+/*
+ * ublk IO Reference Counting Design
+ * ==================================
+ *
+ * For user-copy and zero-copy modes, ublk uses a split reference model with
+ * two counters that together track IO lifetime:
+ *
+ *   - io->ref: refcount for off-task buffer registrations and user-copy ops
+ *   - io->task_registered_buffers: count of buffers registered on the IO task
+ *
+ * Key Invariant:
+ * --------------
+ * When IO is dispatched to the ublk server (UBLK_IO_FLAG_OWNED_BY_SRV set),
+ * the sum (io->ref + io->task_registered_buffers) must equal UBLK_REFCOUNT_INIT
+ * when no active references exist. After IO completion, both counters become
+ * zero. For I/Os not currently dispatched to the ublk server, both ref and
+ * task_registered_buffers are 0.
+ *
+ * This invariant is checked by ublk_check_and_reset_active_ref() during daemon
+ * exit to determine if all references have been released.
+ *
+ * Why Split Counters:
+ * -------------------
+ * Buffers registered on the IO daemon task can use the lightweight
+ * task_registered_buffers counter (simple increment/decrement) instead of
+ * atomic refcount operations. The ublk_io_release() callback checks if
+ * current == io->task to decide which counter to update.
+ *
+ * This optimization only applies before IO completion. At completion,
+ * ublk_sub_req_ref() collapses task_registered_buffers into the atomic ref.
+ * After that, all subsequent buffer unregistrations must use the atomic ref
+ * since they may be releasing the last reference.
+ *
+ * Reference Lifecycle:
+ * --------------------
+ * 1. ublk_init_req_ref(): Sets io->ref = UBLK_REFCOUNT_INIT at IO dispatch
+ *
+ * 2. During IO processing:
+ *    - On-task buffer reg: task_registered_buffers++ (no ref change)
+ *    - Off-task buffer reg: ref++ via ublk_get_req_ref()
+ *    - Buffer unregister callback (ublk_io_release):
+ *      * If on-task: task_registered_buffers--
+ *      * If off-task: ref-- via ublk_put_req_ref()
+ *
+ * 3. ublk_sub_req_ref() at IO completion:
+ *    - Computes: sub_refs = UBLK_REFCOUNT_INIT - task_registered_buffers
+ *    - Subtracts sub_refs from ref and zeroes task_registered_buffers
+ *    - This effectively collapses task_registered_buffers into the atomic ref,
+ *      accounting for the initial UBLK_REFCOUNT_INIT minus any on-task
+ *      buffers that were already counted
+ *
+ * Example (zero-copy, register on-task, unregister off-task):
+ *   - Dispatch: ref = UBLK_REFCOUNT_INIT, task_registered_buffers = 0
+ *   - Register buffer on-task: task_registered_buffers = 1
+ *   - Unregister off-task: ref-- (UBLK_REFCOUNT_INIT - 1), task_registered_buffers stays 1
+ *   - Completion via ublk_sub_req_ref():
+ *     sub_refs = UBLK_REFCOUNT_INIT - 1,
+ *     ref = (UBLK_REFCOUNT_INIT - 1) - (UBLK_REFCOUNT_INIT - 1) = 0
+ *
+ * Example (auto buffer registration):
+ *   Auto buffer registration sets task_registered_buffers = 1 at dispatch.
+ *
+ *   - Dispatch: ref = UBLK_REFCOUNT_INIT, task_registered_buffers = 1
+ *   - Buffer unregister: task_registered_buffers-- (becomes 0)
+ *   - Completion via ublk_sub_req_ref():
+ *     sub_refs = UBLK_REFCOUNT_INIT - 0, ref becomes 0
+ *
+ * Example (zero-copy, ublk server killed):
+ *   When daemon is killed, io_uring cleanup unregisters buffers off-task.
+ *   ublk_check_and_reset_active_ref() waits for the invariant to hold.
+ *
+ *   - Dispatch: ref = UBLK_REFCOUNT_INIT, task_registered_buffers = 0
+ *   - Register buffer on-task: task_registered_buffers = 1
+ *   - Daemon killed, io_uring cleanup unregisters buffer (off-task):
+ *     ref-- (UBLK_REFCOUNT_INIT - 1), task_registered_buffers stays 1
+ *   - Daemon exit check: sum = (UBLK_REFCOUNT_INIT - 1) + 1 = UBLK_REFCOUNT_INIT
+ *   - Sum equals UBLK_REFCOUNT_INIT, then both two counters are zeroed by
+ *     ublk_check_and_reset_active_ref(), so ublk_abort_queue() can proceed
+ *     and abort pending requests
+ *
+ * Batch IO Special Case:
+ * ----------------------
+ * In batch IO mode, io->task is NULL. This means ublk_io_release() always
+ * takes the off-task path (ublk_put_req_ref), decrementing io->ref. The
+ * task_registered_buffers counter still tracks registered buffers for the
+ * invariant check, even though the callback doesn't decrement it.
+ *
+ * Note: updating task_registered_buffers is protected by io->lock.
+ */
 static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
 		struct ublk_io *io)
 {
-- 
2.47.1

