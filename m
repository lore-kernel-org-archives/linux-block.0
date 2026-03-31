Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8FF41B34D
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971167; cv=none; b=C+4bD0tVho9nfVAt0edpoqIi7mRXOquG8xaVxQZLA/RSBxpTNYQ19s0uEGRyeE3NdpbQWhS++5RSSYsXPUY291zHNwHoqhcgi7RJDgaEIrBi6X7kpY7BzbNY3zmW4f+OWZva41cUan1YeUKex+oczTFCeIyrWbs0PgIH+2RgZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971167; c=relaxed/simple;
	bh=Pfif4jG1m9ajtP/42U0oFCDOA+DmGN/q6LcynfQfVJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yn9FwZ5lw90gZ2sMNbK11G5zW5QcPT49YQDgbb7UVzmRtP822U7EgeriMNOFodL0foW1fnInJjODF+RjjPZ+qzxffsV9pRsm8Nc57NUcd/yg5H7oz2nBE9uxNTAwVpZIKUIY+r+UjWZv5xFShjW41xE4VpWteyKnvnDa5NR7M7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dg7ieMF3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dg7ieMF3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774971156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UflexKm9kogKFOGFBhQa2KEVRFuMmDuRm3sMiQboySE=;
	b=Dg7ieMF3VIT/vSBA528tkOFGnCRTbEnTXM8DOMNk2KmvMQAmB9YOfIKQ+Si6KWeu0DbjZm
	Fziy7IDP1FP41SHwE1jzW+9bkXVpnBC8TkZAu2UiN1ybYUKYNI2nnfTvMC1jJcG+sbctKE
	34H7y06+Z+AMqLaVKE98vef1NBrl+QM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-GSdDk7u6M7KcuEU5Ck9Pyw-1; Tue,
 31 Mar 2026 11:32:28 -0400
X-MC-Unique: GSdDk7u6M7KcuEU5Ck9Pyw-1
X-Mimecast-MFC-AGG-ID: GSdDk7u6M7KcuEU5Ck9Pyw_1774971147
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DF1D19560AA;
	Tue, 31 Mar 2026 15:32:27 +0000 (UTC)
Received: from localhost (unknown [10.72.116.55])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5246B30002C3;
	Tue, 31 Mar 2026 15:32:25 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 03/10] ublk: enable UBLK_F_SHMEM_ZC feature flag
Date: Tue, 31 Mar 2026 23:31:54 +0800
Message-ID: <20260331153207.3635125-4-ming.lei@redhat.com>
In-Reply-To: <20260331153207.3635125-1-ming.lei@redhat.com>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add UBLK_F_SHMEM_ZC (1ULL << 19) to the UAPI header and UBLK_F_ALL.
Switch ublk_support_shmem_zc() and ublk_dev_support_shmem_zc() from
returning false to checking the actual flag, enabling the shared
memory zero-copy feature for devices that request it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst  | 117 ++++++++++++++++++++++++++++++++++
 drivers/block/ublk_drv.c      |   7 +-
 include/uapi/linux/ublk_cmd.h |   7 ++
 3 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 6ad28039663d..a818e09a4b66 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -485,6 +485,123 @@ Limitations
   in case that too many ublk devices are handled by this single io_ring_ctx
   and each one has very large queue depth
 
+Shared Memory Zero Copy (UBLK_F_SHMEM_ZC)
+------------------------------------------
+
+The ``UBLK_F_SHMEM_ZC`` feature provides an alternative zero-copy path
+that works by sharing physical memory pages between the client application
+and the ublk server. Unlike the io_uring fixed buffer approach above,
+shared memory zero copy does not require io_uring buffer registration
+per I/O — instead, it relies on the kernel matching page frame numbers
+(PFNs) at I/O time. This allows the ublk server to access the shared
+buffer directly, which is unlikely for the io_uring fixed buffer
+approach.
+
+Motivation
+~~~~~~~~~~
+
+Shared memory zero copy takes a different approach: if the client
+application and the ublk server both map the same physical memory, there is
+nothing to copy. The kernel detects the shared pages automatically and
+tells the server where the data already lives.
+
+``UBLK_F_SHMEM_ZC`` can be thought of as a supplement for optimized client
+applications — when the client is willing to allocate I/O buffers from
+shared memory, the entire data path becomes zero-copy without any per-I/O
+overhead.
+
+Use Cases
+~~~~~~~~~
+
+This feature is useful when the client application can be configured to
+use a specific shared memory region for its I/O buffers:
+
+- **Custom storage clients** that allocate I/O buffers from shared memory
+  (memfd, hugetlbfs) and issue direct I/O to the ublk device
+- **Database engines** that use pre-allocated buffer pools with O_DIRECT
+
+How It Works
+~~~~~~~~~~~~
+
+1. The ublk server and client both ``mmap()`` the same file (memfd or
+   hugetlbfs) with ``MAP_SHARED``. This gives both processes access to the
+   same physical pages.
+
+2. The ublk server registers its mapping with the kernel::
+
+     struct ublk_buf_reg buf = { .addr = mmap_va, .len = size };
+     ublk_ctrl_cmd(UBLK_U_CMD_REG_BUF, .addr = &buf);
+
+   The kernel pins the pages and builds a PFN lookup tree.
+
+3. When the client issues direct I/O (``O_DIRECT``) to ``/dev/ublkb*``,
+   the kernel checks whether the I/O buffer pages match any registered
+   pages by comparing PFNs.
+
+4. On a match, the kernel sets ``UBLK_IO_F_SHMEM_ZC`` in the I/O
+   descriptor and encodes the buffer index and offset in ``addr``::
+
+     if (iod->op_flags & UBLK_IO_F_SHMEM_ZC) {
+         /* Data is already in our shared mapping — zero copy */
+         index  = ublk_shmem_zc_index(iod->addr);
+         offset = ublk_shmem_zc_offset(iod->addr);
+         buf = shmem_table[index].mmap_base + offset;
+     }
+
+5. If pages do not match (e.g., the client used a non-shared buffer),
+   the I/O falls back to the normal copy path silently.
+
+The shared memory can be set up via two methods:
+
+- **Socket-based**: the client sends a memfd to the ublk server via
+  ``SCM_RIGHTS`` on a unix socket. The server mmaps and registers it.
+- **Hugetlbfs-based**: both processes ``mmap(MAP_SHARED)`` the same
+  hugetlbfs file. No IPC needed — same file gives same physical pages.
+
+Advantages
+~~~~~~~~~~
+
+- **Simple**: no per-I/O buffer registration or unregistration commands.
+  Once the shared buffer is registered, all matching I/O is zero-copy
+  automatically.
+- **Direct buffer access**: the ublk server can read and write the shared
+  buffer directly via its own mmap, without going through io_uring fixed
+  buffer operations. This is more friendly for server implementations.
+- **Fast**: PFN matching is a single maple tree lookup per bvec. No
+  io_uring command round-trips for buffer management.
+- **Compatible**: non-matching I/O silently falls back to the copy path.
+  The device works normally for any client, with zero-copy as an
+  optimization when shared memory is available.
+
+Limitations
+~~~~~~~~~~~
+
+- **Requires client cooperation**: the client must allocate its I/O
+  buffers from the shared memory region. This requires a custom or
+  configured client — standard applications using their own buffers
+  will not benefit.
+- **Direct I/O only**: buffered I/O (without ``O_DIRECT``) goes through
+  the page cache, which allocates its own pages. These kernel-allocated
+  pages will never match the registered shared buffer. Only ``O_DIRECT``
+  puts the client's buffer pages directly into the block I/O.
+
+Control Commands
+~~~~~~~~~~~~~~~~
+
+- ``UBLK_U_CMD_REG_BUF``
+
+  Register a shared memory buffer. ``ctrl_cmd.addr`` points to a
+  ``struct ublk_buf_reg`` containing the buffer virtual address and size.
+  Returns the assigned buffer index (>= 0) on success. The kernel pins
+  pages and builds the PFN lookup tree. Queue freeze is handled
+  internally.
+
+- ``UBLK_U_CMD_UNREG_BUF``
+
+  Unregister a previously registered buffer. ``ctrl_cmd.data[0]`` is the
+  buffer index. Unpins pages and removes PFN entries from the lookup
+  tree.
+
 References
 ==========
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d53865437600..c2b9992503a4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -85,7 +85,8 @@
 		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
 		| UBLK_F_SAFE_STOP_DEV \
 		| UBLK_F_BATCH_IO \
-		| UBLK_F_NO_AUTO_PART_SCAN)
+		| UBLK_F_NO_AUTO_PART_SCAN \
+		| UBLK_F_SHMEM_ZC)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -425,7 +426,7 @@ static inline bool ublk_dev_support_zero_copy(const struct ublk_device *ub)
 
 static inline bool ublk_support_shmem_zc(const struct ublk_queue *ubq)
 {
-	return false;
+	return ubq->flags & UBLK_F_SHMEM_ZC;
 }
 
 static inline bool ublk_iod_is_shmem_zc(const struct ublk_queue *ubq,
@@ -436,7 +437,7 @@ static inline bool ublk_iod_is_shmem_zc(const struct ublk_queue *ubq,
 
 static inline bool ublk_dev_support_shmem_zc(const struct ublk_device *ub)
 {
-	return false;
+	return ub->dev_info.flags & UBLK_F_SHMEM_ZC;
 }
 
 static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 52bb9b843d73..ecd258847d3d 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -408,6 +408,13 @@ struct ublk_shmem_buf_reg {
 /* Disable automatic partition scanning when device is started */
 #define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
 
+/*
+ * Enable shared memory zero copy. When enabled, the server can register
+ * shared memory buffers via UBLK_U_CMD_REG_BUF. If a block request's
+ * pages match a registered buffer, UBLK_IO_F_SHMEM_ZC is set and addr
+ * encodes the buffer index + offset instead of a userspace buffer address.
+ */
+#define UBLK_F_SHMEM_ZC	(1ULL << 19)
 
 /* device state */
 #define UBLK_S_DEV_DEAD	0
-- 
2.53.0

