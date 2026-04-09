Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9CF2C21DD
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741451; cv=none; b=ZgDMUkriFlW8BsjyMpWmVj2JeXTfvfjwU9bR5C9laxaXSqTV9msVVP0AlmY2/3KZMDGidnPKPDsAlH2mwB+lCOGuzpwWareE5XDXFv8iGL8Znufb+L4Ey89nF3nl2pAC38Rh1XrfbeJQe3Hzuc2OVkPFQvTSmS0FxR6VUw2or7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741451; c=relaxed/simple;
	bh=uoBokHy8pk8sBfhJ74h7PBVf2ICF6CeuxMxjDnnSHt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNzfxgi8CSJl/jWZP2+ZrllcNX3wlYDRKI6hc3cGT6wMPQe1PERceDn4Y+T9QQoYr0tknz8ZaoijyJXLBqnSdjavQEIDEINecv4YgJTByQLBbwc7rVkaQXLt5z0Y3a4B+KLqZ7WrNxvYiESS4On2kPKrL3gyxcsdhuXPNGtJOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhkimeBN; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhkimeBN"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c76d797b180so441688a12.2
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741449; x=1776346249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXdVhWK6ZkFpMh17g5RRD/prbc/+uR0BFH2zEbbEkN0=;
        b=HhkimeBNjXAYvwFniDW66bMkI0rskKa77F4QMLTJTB7E+32kYekNP5A1J4Wozlo+to
         nrj2sbjyZBpPkTVs1qLYgHjgq5kx85QPBJcToo1ZqhGE12Vr2LQqGU17hkTT1FxUXmps
         FPKsjeX09tstAe5OW7B3ATbJ8APZxYiThO036LupkoLgTkPWpUry2N/lj8DnkZh2NAt5
         sdHYt424xbuwuGsksAk3mfrFmgYQMR2hG9X/KNNVWs6FxA/frMck4Z7d0Oiht+4E2FX+
         jSkqTOFbWI7SBTX/DZq0cM8855Q78zN5/sgS7K2rdQCSGdFHvYhBVz7goofz1/0t+BBP
         5stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741449; x=1776346249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXdVhWK6ZkFpMh17g5RRD/prbc/+uR0BFH2zEbbEkN0=;
        b=VRZjoZ/QgvC0HR7DXvv6h/J1gSDlZAcG7nJ6+l2bk04b99UL2bMVWqRyP0OZqsYK8n
         RvUg5DiC0jGCh8rQwTbwcthiJJUHrXZI0tq65KbBS5MtNvHKuhfEHfkrUmYY/RunwKMu
         v/2bju+gDX7lPRKa7VHFcgBK4+56a1DqB0MqDStetJ26z/zsvjl+fZi4rqDcs43y5cyT
         PkdNf/79rx5ggqn4blv7FFuZVD7t1pvCUI3iWianrg9U8tFb+qiJCNkT7TN974oOpHkf
         dQ2vzS0boo3DW5xzT1mrRdLntdxSrTNfO17pMop3yX4SJkv5ep+dt9YwZ73L5N0hVd88
         NoOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIMh8zaTmFNSGyxdb/HizTmXAKoaLOvwvN2Qjo5Wlvot5P3b9nI8awFBM2mG0oKnhhEnB1wFF7+QHIFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkyKKfx708akJVsKeipJ+DtRQjkUOdab6uUKzVIjQnOyETtXfc
	m58xWeBbmNX3BGhTBYVEvlKXlZ7A+DPYwTOfHiSmovOPR9dqr9u/f7PK3FVQPKln6u2CqQ==
X-Gm-Gg: AeBDietzxEjaNYZuMrPKG8QHT17tPtkGkAGWCL/ZcQGboc4qrIMEZT0ji3HPut8Sj2T
	luDbvJrc8edDIGw1J94P+KNTzAwnGrJfWZ4G2XfJuNQbH51lKYkpzC5+i/9id9iDpOxBIy1R9Bd
	pyqetDgE3X4P4IIcAcM/kov2JzmB4lHEnfEBmHtZrl0S4hkbpT5fb8NAWi43NuwgKkZ1h35voPJ
	cNmlxaLMilsrmYPXV2EzCzDOQ06Dr/pDLjaWyttLKmyaq7CEBPIjSl7pS0kJ2kLYerxN2w45XSF
	HN47+wCV9yCedZVYaaQ84SB3jfL/t1Rrhoyg1T68T2z4rrN7mX4eJvSAQX/2xaWrPmA2CP7nH4u
	CGutIwumgsqzvQ/mqaaLzCllHsRHUoLk5eE1OQsOIt4/C8c+qJTogaclpH6i+3kiEc0Wta67NKG
	EM+7BvmmbRKpsN+XBuYJvu1u+Tu/DCv4a/XS9Kt8jyPKv1gKspyLxiw6rV874zSxprhSJb0DGNJ
	fn8
X-Received: by 2002:a05:6a20:12cd:b0:39f:a42:9251 with SMTP id adf61e73a8af0-39fc8149691mr4233912637.22.1775741448852;
        Thu, 09 Apr 2026 06:30:48 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm21021166a12.24.2026.04.09.06.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:30:48 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 4/7] ublk: replace xarray with IDA for shmem buffer index allocation
Date: Thu,  9 Apr 2026 21:30:16 +0800
Message-ID: <20260409133020.3780098-5-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409133020.3780098-1-tom.leiming@gmail.com>
References: <20260409133020.3780098-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove struct ublk_buf which only contained nr_pages that was never
read after registration. Use IDA for pure index allocation instead
of xarray. Make __ublk_ctrl_unreg_buf() return int so the caller
can detect invalid index without a separate lookup.

Simplify ublk_buf_cleanup() to walk the maple tree directly and
unpin all pages in one pass, instead of iterating the xarray by
buffer index.

Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 92 ++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index efbb22fe481c..8b686e70cf28 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -297,11 +297,6 @@ struct ublk_queue {
 	struct ublk_io ios[] __counted_by(q_depth);
 };
 
-/* Per-registered shared memory buffer */
-struct ublk_buf {
-	unsigned int nr_pages;
-};
-
 /* Maple tree value: maps a PFN range to buffer location */
 struct ublk_buf_range {
 	unsigned short buf_index;
@@ -345,7 +340,7 @@ struct ublk_device {
 
 	/* shared memory zero copy */
 	struct maple_tree	buf_tree;
-	struct xarray		bufs_xa;
+	struct ida		buf_ida;
 
 	struct ublk_queue       *queues[];
 };
@@ -4693,7 +4688,7 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
 	spin_lock_init(&ub->lock);
 	mutex_init(&ub->cancel_mutex);
 	mt_init(&ub->buf_tree);
-	xa_init_flags(&ub->bufs_xa, XA_FLAGS_ALLOC);
+	ida_init(&ub->buf_ida);
 	INIT_WORK(&ub->partition_scan_work, ublk_partition_scan_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
@@ -5279,11 +5274,9 @@ static void ublk_buf_erase_ranges(struct ublk_device *ub, int buf_index)
 }
 
 static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
-			       struct ublk_buf *ubuf,
-			       struct page **pages, int index,
-			       unsigned short flags)
+			       struct page **pages, unsigned long nr_pages,
+			       int index, unsigned short flags)
 {
-	unsigned long nr_pages = ubuf->nr_pages;
 	unsigned long i;
 	int ret;
 
@@ -5335,9 +5328,8 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	struct page **pages = NULL;
 	unsigned int gup_flags;
 	struct gendisk *disk;
-	struct ublk_buf *ubuf;
 	long pinned;
-	u32 index;
+	int index;
 	int ret;
 
 	if (!ublk_dev_support_shmem_zc(ub))
@@ -5367,16 +5359,10 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 		return -ENODEV;
 
 	/* Pin pages before quiescing (may sleep) */
-	ubuf = kzalloc(sizeof(*ubuf), GFP_KERNEL);
-	if (!ubuf) {
-		ret = -ENOMEM;
-		goto put_disk;
-	}
-
 	pages = kvmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
 	if (!pages) {
 		ret = -ENOMEM;
-		goto err_free;
+		goto put_disk;
 	}
 
 	gup_flags = FOLL_LONGTERM;
@@ -5392,7 +5378,6 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 		ret = -EFAULT;
 		goto err_unpin;
 	}
-	ubuf->nr_pages = nr_pages;
 
 	/*
 	 * Drain inflight I/O and quiesce the queue so no new requests
@@ -5403,13 +5388,15 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 
 	mutex_lock(&ub->mutex);
 
-	ret = xa_alloc(&ub->bufs_xa, &index, ubuf, xa_limit_16b, GFP_KERNEL);
-	if (ret)
+	index = ida_alloc_max(&ub->buf_ida, USHRT_MAX, GFP_KERNEL);
+	if (index < 0) {
+		ret = index;
 		goto err_unlock;
+	}
 
-	ret = __ublk_ctrl_reg_buf(ub, ubuf, pages, index, buf_reg.flags);
+	ret = __ublk_ctrl_reg_buf(ub, pages, nr_pages, index, buf_reg.flags);
 	if (ret) {
-		xa_erase(&ub->bufs_xa, index);
+		ida_free(&ub->buf_ida, index);
 		goto err_unlock;
 	}
 
@@ -5427,19 +5414,17 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	unpin_user_pages(pages, pinned);
 err_free_pages:
 	kvfree(pages);
-err_free:
-	kfree(ubuf);
 put_disk:
 	ublk_put_disk(disk);
 	return ret;
 }
 
-static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
-				  struct ublk_buf *ubuf, int buf_index)
+static int __ublk_ctrl_unreg_buf(struct ublk_device *ub, int buf_index)
 {
 	MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
 	struct ublk_buf_range *range;
 	struct page *pages[32];
+	int ret = -ENOENT;
 
 	mas_lock(&mas);
 	mas_for_each(&mas, range, ULONG_MAX) {
@@ -5448,6 +5433,7 @@ static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
 		if (range->buf_index != buf_index)
 			continue;
 
+		ret = 0;
 		base = mas.index;
 		nr = mas.last - base + 1;
 		mas_erase(&mas);
@@ -5465,7 +5451,8 @@ static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
 		kfree(range);
 	}
 	mas_unlock(&mas);
-	kfree(ubuf);
+
+	return ret;
 }
 
 static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
@@ -5473,11 +5460,14 @@ static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
 {
 	int index = (int)header->data[0];
 	struct gendisk *disk;
-	struct ublk_buf *ubuf;
+	int ret;
 
 	if (!ublk_dev_support_shmem_zc(ub))
 		return -EOPNOTSUPP;
 
+	if (index < 0 || index > USHRT_MAX)
+		return -EINVAL;
+
 	disk = ublk_get_disk(ub);
 	if (!disk)
 		return -ENODEV;
@@ -5487,32 +5477,42 @@ static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
 
 	mutex_lock(&ub->mutex);
 
-	ubuf = xa_erase(&ub->bufs_xa, index);
-	if (!ubuf) {
-		mutex_unlock(&ub->mutex);
-		ublk_unquiesce_and_resume(disk);
-		ublk_put_disk(disk);
-		return -ENOENT;
-	}
-
-	__ublk_ctrl_unreg_buf(ub, ubuf, index);
+	ret = __ublk_ctrl_unreg_buf(ub, index);
+	if (!ret)
+		ida_free(&ub->buf_ida, index);
 
 	mutex_unlock(&ub->mutex);
 
 	ublk_unquiesce_and_resume(disk);
 	ublk_put_disk(disk);
-	return 0;
+	return ret;
 }
 
 static void ublk_buf_cleanup(struct ublk_device *ub)
 {
-	struct ublk_buf *ubuf;
-	unsigned long index;
+	MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
+	struct ublk_buf_range *range;
+	struct page *pages[32];
+
+	mas_for_each(&mas, range, ULONG_MAX) {
+		unsigned long base = mas.index;
+		unsigned long nr = mas.last - base + 1;
+		unsigned long off;
 
-	xa_for_each(&ub->bufs_xa, index, ubuf)
-		__ublk_ctrl_unreg_buf(ub, ubuf, index);
-	xa_destroy(&ub->bufs_xa);
+		for (off = 0; off < nr; ) {
+			unsigned int batch = min_t(unsigned long,
+						   nr - off, 32);
+			unsigned int j;
+
+			for (j = 0; j < batch; j++)
+				pages[j] = pfn_to_page(base + off + j);
+			unpin_user_pages(pages, batch);
+			off += batch;
+		}
+		kfree(range);
+	}
 	mtree_destroy(&ub->buf_tree);
+	ida_destroy(&ub->buf_ida);
 }
 
 /* Check if request pages match a registered shared memory buffer */
-- 
2.53.0

