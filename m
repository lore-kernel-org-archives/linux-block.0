Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com [209.85.208.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D2306768
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288623; cv=none; b=XCIrdE2tSHsgCvhug9YYn/gdnRLNZ2tHPgpWtz4K6ga0ixi15khG1U3G0c8uoDvPhugxZnOZh5AxZWtvfjvyC8wQ1k/GBQG6tgUq3XU0/Y8vKuoZyyW5P/d05oOmSAzmJT26f4upL/iPutRMX4DmZ7zGEaRb6eFgF7kW1Oqf0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288623; c=relaxed/simple;
	bh=3XmpiYqtQePoFtLlsV+dW3kwr9XGE6IpPNZj0jj1gps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvQuLFvgKxess2gzI9CM/U4fVJlQhdUaVxLoYpfOPsoAQvkrNN+pFMVhIRTD9Qxl/jq2qinwZUg7TCZl5CeA05rM24FiTRr19UL192G4/7gUSiI9B3KTo3P6KY3rVGC8r5aT3Sd7qKFmo8qa0L/yTxBC5ZN8w2+jl0ra4Cf05dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Hel3EamT; arc=none smtp.client-ip=209.85.208.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Hel3EamT"
Received: by mail-ed1-f97.google.com with SMTP id 4fb4d7f45d1cf-698bf274b3fso63477a12.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 18:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785288607; x=1785893407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6zb8gE9x4tjQG/nkOB2ESY9bcJR4R2qgzQP3OQEU7nY=;
        b=Hel3EamTDfPCVc6LAs5jE8CFIGH510grXQIqGoeRDx1yz8QjYQxoXoirDkVPOlVYeQ
         FU1ttgdpbqHM2d0tcW7nBQWCK9I2ORjtwHGrOfAbq0Mx7/rMy2ftz4VBia4VgtCpTrX7
         fWV/GZBe9JS++EuLDjlelAOq8rGVBVaNexoAu5eoXZLZXaf8m1FFtPJRmosbe1O+flgB
         TZ5iC/Fl0n5XuccGOgZc9ICFh9GslKwvDU1C10yB0uq49kvnmlg28rbW8C6h+IRatANk
         0z5ztNzxNT/7i+kWQrs02MwtAAayIRkJ4ZwpW1Swerc5VlUrh4Q8jRqSbpDaSYW6kLt6
         MTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785288607; x=1785893407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6zb8gE9x4tjQG/nkOB2ESY9bcJR4R2qgzQP3OQEU7nY=;
        b=VLULQ0zpbJegf3jqnpPDLE/gVcB6NLgBpkbYm79MkZT7TYmx/7Vb8bkx9rSUvsqy5M
         XuZargxRmmyqGhVE2KEklssRSVsD+Yzaxmd0O/T4tYL4fHN2hGoiw2l4ZgtUvvXpSEql
         5T1RDTif4/0FxKs14eh4DmxD7KLFpvuV02XxvrjpxsFQtI58S/DXcZ1jlP+xvw9+PBLo
         /lrMo+Tb7sn7IObhNaap+d9Sdyg9Q5/FYCT0OcEv/OSLSB8f4wWlS8XUDKWiCD53vrbN
         yEahYc+j1zykDhrRutEiH5jJHvnve2ofgs2QelTcrcUkREI0AYVNr0cIf8MC+PbEl1iz
         ZsGA==
X-Gm-Message-State: AOJu0YzHdiWJIvDqsntml9P6Xr1xgb/irSILylP1OtSYQGRG++cBRcEq
	/O1ALtfE5y8Pv9BdhwlR64Rhc8aBt3VYc8I0i1Eh4wEMsvoSJv3Qxp+dptROjeCD1udW4qEsgio
	/gEDFzkfBjvxNN8RTu2FVnGb3MdLf72TkEmeu
X-Gm-Gg: AR+sD11RYxfG0JYaj1Ghg/PErLE6P1uajLBWBaGdA15lvuZ6WV4hIZBl40GVb8Z9gJ6
	WlgRHLZNMyjIMqvrKugR4G2DnO2XxsItN3v48MDyTRP6O2dOzcWJnKCdvuTcAQ8J3NTxddAp6w2
	PYqTuoigpV0DibV2ivfJ33EmstrWUhe5Mdz1xrIHKBxp+cGGd09fOiUkTnJbglbPfOhs38OI2o6
	8pP8+KXAUtyq9aDS+dRsu62U7SvRDGrCFKmz2zu1vnHEaAC/gmScfNCOiJPR0blg2365N2FY2N1
	Gq4wOKs+ynfLTpRelZ1AhE2W/gOGnSF72fBYuxtNxDIgwAAiVMQEQX/w/wAxFctWXx6k9hAK/MV
	7iUBZpL8iVxeL8B5sSdyGj6hunbEWi0CN
X-Received: by 2002:a17:906:9fca:b0:c15:9f0c:8d31 with SMTP id a640c23a62f3a-c1f720a3969mr154102466b.2.1785288607024;
        Tue, 28 Jul 2026 18:30:07 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-c1f83cde5a7sm9080966b.20.2026.07.28.18.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:30:07 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id C2E7E40441;
	Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BFFDBE40442; Tue, 28 Jul 2026 19:30:04 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 5/6] ublk: add UBLK_F_IO_DESC_SIZE
Date: Tue, 28 Jul 2026 19:29:50 -0600
Message-ID: <20260729012951.3744582-6-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729012951.3744582-1-csander@purestorage.com>
References: <20260729012951.3744582-1-csander@purestorage.com>
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
multiple of 8 to store a properly-aligned struct ublksrv_io_desc. The
struct ublksrv_io_desc is located at the beginning of each io_desc and
the remainder is padding. The mmap() performed for each queue must have
a length of queue_depth * io_desc_size, rounded up to the page size. The
mmap() offset must be q_id * UBLK_MAX_QUEUE_DEPTH * io_desc_size, also
rounded up to the page size.

[1]: https://lore.kernel.org/linux-block/aV8QfvaNO5P6vOs6@fedora/

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c      | 35 ++++++++++++++++++++++++-----------
 include/uapi/linux/ublk_cmd.h |  5 ++++-
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 46f5ab13f87e..1da45e382253 100644
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
 
@@ -237,10 +238,11 @@ struct ublk_io {
 } ____cacheline_aligned_in_smp;
 
 struct ublk_queue {
 	u16 q_id;
 	u16 q_depth;
+	u16 io_desc_size;
 
 	unsigned long flags;
 	struct ublksrv_io_desc *io_cmd_buf;
 
 	bool force_abort;
@@ -403,11 +405,11 @@ static inline void ublk_io_evts_deinit(struct ublk_queue *q)
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
@@ -1246,23 +1248,24 @@ static inline struct ublksrv_io_desc *
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
@@ -2648,11 +2651,11 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
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
@@ -4174,11 +4177,11 @@ static const struct file_operations ublk_ch_batch_io_fops = {
 	.mmap = ublk_ch_mmap,
 };
 
 static void __ublk_deinit_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
-	int size;
+	size_t size;
 	u16 i;
 
 	size = ublk_queue_cmd_buf_size(ub);
 
 	for (i = 0; i < ubq->q_depth; i++) {
@@ -4227,11 +4230,12 @@ static int ublk_init_queue(struct ublk_device *ub, u16 q_id)
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
 
@@ -4252,10 +4256,11 @@ static int ublk_init_queue(struct ublk_device *ub, u16 q_id)
 	if (!page) {
 		kvfree(ubq);
 		return -ENOMEM;
 	}
 	ubq->io_cmd_buf = page_address(page);
+	ubq->io_desc_size = ub->dev_info.io_desc_size;
 
 	for (i = 0; i < ubq->q_depth; i++)
 		spin_lock_init(&ubq->ios[i].lock);
 
 	if (ublk_dev_support_batch_io(ub)) {
@@ -4736,10 +4741,18 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 
 	/* User copy is required to access integrity buffer */
 	if (info.flags & UBLK_F_INTEGRITY && !(info.flags & UBLK_F_USER_COPY))
 		return -EINVAL;
 
+	if (info.flags & UBLK_F_IO_DESC_SIZE) {
+		if (info.io_desc_size < sizeof(struct ublksrv_io_desc) ||
+		    info.io_desc_size % _Alignof(struct ublksrv_io_desc))
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
-- 
2.54.0

