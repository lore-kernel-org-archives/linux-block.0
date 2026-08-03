Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB3A426430
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791691; cv=none; b=o7gZGkPtZfoiTi4gkNlSBiXaeSx0EVBF8qVaaXq/PdQ+tp463eqIoqB7B7dghi2zAAEeos6LRnpO4jF0KQr8ERZHBFFdYhpS/CBeDgWI255YA/6OgloMtiloJulmrxlM1VkrySY1qKec84DW8dxzMSdwQGOZ8j1fioHZKYqMXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791691; c=relaxed/simple;
	bh=1X0HeOzb3YZwsssSB/FHvZUDgTOczA79yfrgodBT3l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdtJYg+vx6zkQdEtVryuKRXYVNd/fUhRjiN9QfbCL8R8URVwD+t+ne6nkz1Gra0Hpsebk2mLILVjA1ym8CRelwDiruSJjJudB2k2yXn6OGu4rvdfH4LgknLVXfh8s6x7rlHS6i2Na3Gm6YF+Rs6nY+7zoS0l3FpaBr6lPAEi4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fmjqFU/c; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fmjqFU/c"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-660a40aac63so537983d50.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785791686; x=1786396486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9JxpJkklZFmCfZG7kvSXRiUJwuxf74cgBgaZj0atTg=;
        b=fmjqFU/cZxpuza1Emuv2boJXtnXomz5sgIkdAC4qaJIt0JoN31dHYo26Z8DyBbtPFU
         YWUz2l0ECD9qIG8v90ne9piB2rDwnpfIn4gnPAXSqHAj7J3/5vCv+Orr0CL58GSET2zF
         R1IFXV6wnkInjF4B1rrFWKKEE/5nG19Cp0hUZyI9YOZOJpGcrnYxJDi+bmaOzEUeascN
         E0QfK/KT4Fp0G7wQM3N4zS5CQWrn1jzTtcw/+Gcr0j8s8Wg3xuOtZhQmpm/j+L615wXn
         sKTKFd07Mhadi/frBUGX9tBuK0p/zg39XXZlD8jQk5WjlcEa7EI28WpyjSXibPvy6+xC
         ipLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785791686; x=1786396486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z9JxpJkklZFmCfZG7kvSXRiUJwuxf74cgBgaZj0atTg=;
        b=mLqdiyHH/HEj02cPY9zolog29rszCaX3ggoWOwY7YMHssvEHmroHKTuGRvFRSHxRMs
         ItNbiCxKzF4ZzXjEnmyybhwb4ZvGqBZXiGG5u6fBcc83gR8BFLZbJVchI26P3+erZl9o
         QIsYD9xVjIh7gO1hwsVJBBfFDaINpGoDJyIsRdGOsG2IXIh8PiTr5LV5HbKxB6jy/cgg
         acDqSDMj8EUaMlSdk6eatEUxJf48eMYWbuKVB9iLXt/62rANoK1n20FemlHuNjcuSj9t
         xysur/Q9suEmaVvm2rluJ2hFzZQDr9BxGp4atDfsvnr6SUsIkpLNbvuzDUNlN48XudPX
         eA2w==
X-Gm-Message-State: AOJu0YxfULk1VPY3wiMBRBsmB1ixAW5BEqCROlDYYBjKyK/gSR9a8beI
	Xt/8/s5RYp0LMu4lFn+44Q1wQmBHyfSuY5bsQKOd3/AStm46xBixDKAA6YlXUixmvNfFA2NDj4i
	KPRjQNn0pMzoLChJCGitoAPrvjiJTDxY5uxkX
X-Gm-Gg: AR+sD13VysMWeeDY7yu3NuN3YzeLUh8YJ9SNbsUWSLkXKLO/+iPCCqNgwLCoIpvmD4e
	1JnV1+GhElpluzcO5c7ZtZTGYVLK9L7L8flzDCuXDFaKIH9ZYm11tsSXatA6KmTJKojvjRQlHUX
	Trx2U4APSS3t28bCeUO1KdDNH2Zg5sM/lBlxICije689DeIFhYjJI9tHs87LM11ESY9mP09ZFLr
	LIFaHZcmEYX/D7PEBqNQljXqFGrqMWl0fDGJtgwsSGUrGU9xKmtRrfIK6U5ES5WZMABL/2+GkJE
	fqhBrJdBbHQ6Mtc7PUA7mhgCAp2rAAYBo6Hr7S0HQnVWt40AxFakkyPxRx1a0ZIBK98iJ/4wksz
	/oitCITNV0Syjvwy/XF84yIVz+ILCg2sM
X-Received: by 2002:a05:690e:4550:10b0:664:b979:5d89 with SMTP id 956f58d0204a3-6694f28f39fmr8654072d50.4.1785791685871;
        Mon, 03 Aug 2026 14:14:45 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6694908a946sm445440d50.23.2026.08.03.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:14:45 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 5DDBA402A0;
	Mon,  3 Aug 2026 15:14:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5B57CE4041D; Mon,  3 Aug 2026 15:14:45 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 5/8] ublk: add UBLK_F_IO_DESC_SIZE
Date: Mon,  3 Aug 2026 15:14:37 -0600
Message-ID: <20260803211441.2538144-6-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803211441.2538144-1-csander@purestorage.com>
References: <20260803211441.2538144-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk passes the parameters of incoming I/O in memory shared between the
kernel ublk driver and userspace ublk server in struct ublksrv_io_desc.
The size of this struct is currently fixed to 24 bytes, which has been
an obstacle to extending it with additional fields [1]. Additionally,
with multiple ublk server threads handling I/Os from the same ublk queue
(possible with UBLK_F_PER_IO_DAEMON or UBLK_F_BATCH_IO), false sharing
results from adjacent io_descs sharing the same cache line.

Add a ublk feature UBLK_F_IO_DESC_SIZE to allow a ublk server to
override the size of each io_desc. The size must be at least 24 and a
multiple of 8 to store a properly-aligned struct ublksrv_io_desc. It's
also limited to a maximum of 256, though this bound could be lifted in
the future.

The struct ublksrv_io_desc is located at the beginning of each io_desc
and the remainder is padding. The mmap() performed for each queue must
have a length of queue_depth * io_desc_size rounded up to the page size.
The mmap() offset must be q_id * UBLK_MAX_QUEUE_DEPTH * io_desc_size,
also rounded up to the page size.

[1]: https://lore.kernel.org/linux-block/aV8QfvaNO5P6vOs6@fedora/

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c             | 38 ++++++++++++++++++++--------
 include/uapi/linux/ublk_cmd.h        |  5 +++-
 tools/testing/selftests/ublk/kublk.c |  1 +
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 291461e1b236..2f5de735b2d2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -87,11 +87,12 @@
 		| UBLK_F_BUF_REG_OFF_DAEMON \
 		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
 		| UBLK_F_SAFE_STOP_DEV \
 		| UBLK_F_BATCH_IO \
 		| UBLK_F_NO_AUTO_PART_SCAN \
-		| UBLK_F_SHMEM_ZC)
+		| UBLK_F_SHMEM_ZC \
+		| UBLK_F_IO_DESC_SIZE)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
 		| UBLK_F_USER_RECOVERY_FAIL_IO)
 
@@ -105,10 +106,12 @@
 #define UBLK_BATCH_F_ALL  \
 	(UBLK_BATCH_F_HAS_ZONE_LBA | \
 	 UBLK_BATCH_F_HAS_BUF_ADDR | \
 	 UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
 
+#define UBLK_MAX_IO_DESC_SIZE 256
+
 /* ublk batch fetch uring_cmd */
 struct ublk_batch_fetch_cmd {
 	struct list_head node;
 	struct io_uring_cmd *cmd;
 	unsigned short buf_group;
@@ -237,10 +240,11 @@ struct ublk_io {
 } ____cacheline_aligned_in_smp;
 
 struct ublk_queue {
 	u16 q_id;
 	u16 q_depth;
+	u16 io_desc_size;
 
 	unsigned long flags;
 	struct ublksrv_io_desc *io_cmd_buf;
 
 	bool force_abort;
@@ -403,11 +407,11 @@ static inline void ublk_io_evts_deinit(struct ublk_queue *q)
 }
 
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, u16 tag)
 {
-	return &ubq->io_cmd_buf[tag];
+	return (void *)ubq->io_cmd_buf + tag * (size_t)ubq->io_desc_size;
 }
 
 static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
@@ -1246,23 +1250,24 @@ static inline struct ublksrv_io_desc *
 ublk_queue_cmd_buf(struct ublk_device *ub, u16 q_id)
 {
 	return ublk_get_queue(ub, q_id)->io_cmd_buf;
 }
 
-static inline int __ublk_queue_cmd_buf_size(u16 depth)
+static inline size_t __ublk_queue_cmd_buf_size(const struct ublk_device *ub,
+					       u16 depth)
 {
-	return round_up(depth * sizeof(struct ublksrv_io_desc), PAGE_SIZE);
+	return round_up(depth * (size_t)ub->dev_info.io_desc_size, PAGE_SIZE);
 }
 
-static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub)
+static inline size_t ublk_queue_cmd_buf_size(const struct ublk_device *ub)
 {
-	return __ublk_queue_cmd_buf_size(ub->dev_info.queue_depth);
+	return __ublk_queue_cmd_buf_size(ub, ub->dev_info.queue_depth);
 }
 
-static int ublk_max_cmd_buf_size(void)
+static size_t ublk_max_cmd_buf_size(const struct ublk_device *ub)
 {
-	return __ublk_queue_cmd_buf_size(UBLK_MAX_QUEUE_DEPTH);
+	return __ublk_queue_cmd_buf_size(ub, UBLK_MAX_QUEUE_DEPTH);
 }
 
 /*
  * Should I/O outstanding to the ublk server when it exits be reissued?
  * If not, outstanding I/O will get errors.
@@ -2660,11 +2665,11 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 /* map pre-allocated per-queue cmd buffer to ublksrv daemon */
 static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct ublk_device *ub = filp->private_data;
 	size_t sz = vma->vm_end - vma->vm_start;
-	unsigned max_sz = ublk_max_cmd_buf_size();
+	size_t max_sz = ublk_max_cmd_buf_size(ub);
 	unsigned long pfn, end, phys_off = vma->vm_pgoff << PAGE_SHIFT;
 	int ret = 0;
 	u16 q_id;
 
 	spin_lock(&ub->lock);
@@ -4186,11 +4191,11 @@ static const struct file_operations ublk_ch_batch_io_fops = {
 	.mmap = ublk_ch_mmap,
 };
 
 static void __ublk_deinit_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
-	int size;
+	size_t size;
 	u16 i;
 
 	size = ublk_queue_cmd_buf_size(ub);
 
 	for (i = 0; i < ubq->q_depth; i++) {
@@ -4239,11 +4244,12 @@ static int ublk_init_queue(struct ublk_device *ub, u16 q_id)
 	u16 depth = ub->dev_info.queue_depth;
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
 	struct ublk_queue *ubq;
 	struct page *page;
 	int numa_node;
-	int size, ret;
+	size_t size;
+	int ret;
 	u16 i;
 
 	/* Determine NUMA node based on queue's CPU affinity */
 	numa_node = ublk_get_queue_numa_node(ub, q_id);
 
@@ -4264,10 +4270,11 @@ static int ublk_init_queue(struct ublk_device *ub, u16 q_id)
 	if (!page) {
 		kvfree(ubq);
 		return -ENOMEM;
 	}
 	ubq->io_cmd_buf = page_address(page);
+	ubq->io_desc_size = ub->dev_info.io_desc_size;
 
 	for (i = 0; i < ubq->q_depth; i++)
 		spin_lock_init(&ubq->ios[i].lock);
 
 	if (ublk_dev_support_batch_io(ub)) {
@@ -4748,10 +4755,19 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 
 	/* User copy is required to access integrity buffer */
 	if (info.flags & UBLK_F_INTEGRITY && !(info.flags & UBLK_F_USER_COPY))
 		return -EINVAL;
 
+	if (info.flags & UBLK_F_IO_DESC_SIZE) {
+		if (info.io_desc_size < sizeof(struct ublksrv_io_desc) ||
+		    info.io_desc_size % _Alignof(struct ublksrv_io_desc) ||
+		    info.io_desc_size > UBLK_MAX_IO_DESC_SIZE)
+			return -EINVAL;
+	} else {
+		info.io_desc_size = sizeof(struct ublksrv_io_desc);
+	}
+
 	/* the created device is always owned by current user */
 	ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
 
 	if (header->dev_id != info.dev_id) {
 		pr_warn("%s: dev id not match %u %u\n",
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 6991370a72ce..33b25dd13965 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -415,10 +415,13 @@ struct ublk_shmem_buf_reg {
  * pages match a registered buffer, UBLK_IO_F_SHMEM_ZC is set and addr
  * encodes the buffer index + offset instead of a userspace buffer address.
  */
 #define UBLK_F_SHMEM_ZC	(1ULL << 19)
 
+/* ublksrv_io_desc size is specified by ublksrv_ctrl_dev_info's io_desc_size */
+#define UBLK_F_IO_DESC_SIZE (1ULL << 20)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
 #define UBLK_S_DEV_QUIESCED	2
 #define UBLK_S_DEV_FAIL_IO 	3
@@ -450,11 +453,11 @@ struct ublksrv_ctrl_cmd {
 
 struct ublksrv_ctrl_dev_info {
 	__u16	nr_hw_queues;
 	__u16	queue_depth;
 	__u16	state;
-	__u16	pad0;
+	__u16	io_desc_size;
 
 	__u32	max_io_buf_bytes;
 	__u32	dev_id;
 
 	__s32	ublksrv_pid;
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 0b23c09daea5..5c4a1f18d0a3 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1968,10 +1968,11 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_INTEGRITY),
 		FEAT_NAME(UBLK_F_SAFE_STOP_DEV),
 		FEAT_NAME(UBLK_F_BATCH_IO),
 		FEAT_NAME(UBLK_F_NO_AUTO_PART_SCAN),
 		FEAT_NAME(UBLK_F_SHMEM_ZC),
+		FEAT_NAME(UBLK_F_IO_DESC_SIZE),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
 	int ret;
 
-- 
2.54.0

