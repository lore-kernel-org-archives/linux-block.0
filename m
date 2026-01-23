Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AB2C0281
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176380; cv=none; b=jlgFpwt4pOp16kLM8HEBKV41gPw2YS+HQRIaDDYpFRenHUVSR8smpJfjpNLD5OnGVES5rEEqAoI8pfd0lX5Y8eAnAWT9rrLnUTEU0FfW5zYU6VY7YchdWKEbXKvrJM9SzVPkOSK8HnbgVJzc29uHIqJnZDm55rx6lu+tjvhWIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176380; c=relaxed/simple;
	bh=dyuql2PybBj0bTgfUdOUy7velWOUMq96azhEYHyLVwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YV0sI4nf17oStxTYo1WXw3EddjbNGMarjsc12C3+tI0DINsxtsKUvK1KED1tdgNc8cPDOVN1lzGvptpQsheYnSIDmE1n/pEeqLdmq70hQaRy689eh3C+y1X378C7vs2riWiKaJ3iG894SP5m2SoXC9MX74bT1EacSg4UahubpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBfbkvin; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBfbkvin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769176378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wa54EsOt3bQGiA1H/Z2Yf5CkiEQi4S3Ao7s5Hy9gwRI=;
	b=dBfbkvinxgKLSTVOdN7CaCLG+0xPHRzKvIlCoagl9McAMtugGYn2FfGqUuruzTKpmXiCg9
	u/vsJ282p6MX6Tn4h2QJ4Xg3c2P/Hz0VM8cdoUCziLogzUleC4JNrYCvcJ0v4RaOmpzGqy
	PSoL1J4U6qK6pyqUggruvVJ9DQmt7V4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-a9phO8MUN-KrBevMJ-mo8g-1; Fri,
 23 Jan 2026 08:52:50 -0500
X-MC-Unique: a9phO8MUN-KrBevMJ-mo8g-1
X-Mimecast-MFC-AGG-ID: a9phO8MUN-KrBevMJ-mo8g_1769176369
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68178182A13E;
	Fri, 23 Jan 2026 13:52:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 475F11954199;
	Fri, 23 Jan 2026 13:52:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] ublk: document IO reference counting design
Date: Fri, 23 Jan 2026 21:51:59 +0800
Message-ID: <20260123135205.2202474-3-ming.lei@redhat.com>
In-Reply-To: <20260123135205.2202474-1-ming.lei@redhat.com>
References: <20260123135205.2202474-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add comprehensive documentation for ublk's split reference counting
model (io->ref + io->task_registered_buffers) above ublk_init_req_ref()
given this model isn't very straightforward.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7981decd1cee..91218b78e711 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -985,6 +985,70 @@ static inline bool ublk_dev_need_req_ref(const struct ublk_device *ub)
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
+ * The sum (io->ref + io->task_registered_buffers) must equal UBLK_REFCOUNT_INIT
+ * when no active references exist. This invariant is checked by
+ * ublk_check_and_reset_active_ref() during daemon exit to determine if all
+ * references have been released.
+ *
+ * Why Split Counters:
+ * -------------------
+ * Buffers registered on the IO daemon task can use the lightweight
+ * task_registered_buffers counter (simple increment/decrement) instead of
+ * atomic refcount operations. The ublk_io_release() callback checks if
+ * current == io->task to decide which counter to update.
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
+ *    - Subtracts sub_refs from ref
+ *    - This accounts for the initial UBLK_REFCOUNT_INIT minus any on-task
+ *      buffers that were already counted in task_registered_buffers
+ *
+ * Example (zero-copy, register on-task, unregister off-task):
+ *   - Dispatch: ref = UBLK_REFCOUNT_INIT, task_registered_buffers = 0
+ *   - Register buffer on-task: task_registered_buffers = 1
+ *   - Unregister off-task: ref-- (UBLK_REFCOUNT_INIT - 1), task_registered_buffers stays 1
+ *   - Completion via ublk_sub_req_ref():
+ *     sub_refs = UBLK_REFCOUNT_INIT - 1, ref = (UBLK_REFCOUNT_INIT - 1) - (UBLK_REFCOUNT_INIT - 1) = 0
+ *
+ * Example (auto buffer registration):
+ *   Auto buffer registration sets task_registered_buffers = 1 at dispatch.
+ *
+ *   - Dispatch: ref = UBLK_REFCOUNT_INIT, task_registered_buffers = 1
+ *   - Buffer unregister: task_registered_buffers-- (becomes 0)
+ *   - Completion via ublk_sub_req_ref(): sub_refs = UBLK_REFCOUNT_INIT - 0, ref becomes 0
+ *   - Daemon exit check: sum = ref + task_registered_buffers = UBLK_REFCOUNT_INIT
+ *   - Sum equals UBLK_REFCOUNT_INIT, so no active reference exists
+ *
+ * Batch IO Special Case:
+ * ----------------------
+ * In batch IO mode, io->task is NULL. This means ublk_io_release() always
+ * takes the off-task path (ublk_put_req_ref), decrementing io->ref. The
+ * task_registered_buffers counter still tracks registered buffers for the
+ * invariant check, even though the callback doesn't decrement it.
+ */
 static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
 		struct ublk_io *io)
 {
-- 
2.47.0

