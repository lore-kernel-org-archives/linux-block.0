Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB62D29C8
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741453; cv=none; b=DrNfu1PIh2LhmaW8xMsiLmlA6kSCAPGOBqXpxliajT3TKemE2D+VjS8Nu8ngrBc5lRJbN3Phy/GKNeD8H3JVi8DNJ1Fz+suXja6O7XY48hxpwSbrcA9s1iGAgNFg+nz6Eo5PxSYjkKEdAKCpzGrWX5dQI1qUgWyXF/j5acXRYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741453; c=relaxed/simple;
	bh=u6QP0q4Pm7easOFpuu1jyJmPJ91tFSoY63m6b/xrEAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHfiARRHavNzAX7rgaTuUL4lMACKFc4aawtdvKZjlf/4H31VxKPGNZZuMur2mEBnbFz3l2OwOqgPRTPLpf3FMBgvkeo0wP7wdXnF5zRxyhHFggwPd9z2RyDQEc7R6x/MvLJ/SFR3HBSufKN9iCc2v665ig7htTzbj26cVxg7J7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYhkIkDo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYhkIkDo"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76af79f029so376579a12.3
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741452; x=1776346252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RfjnMCd/AF7bBdOrwDqyxNxMK9P28G5mGjUvtSq2DM=;
        b=EYhkIkDog8IYxUt/dtIs40HsMwGjttLz9dWChT+ejjhGzyuW/7bGavASJkZ8f+czwr
         5MbBVpDWkNN24tGFRqtXMHnpv7MaanHNTAmqo+m5YsVtT1a3B+0Nav33oZycqx61nDWx
         n4+MSrAK1UIXI4TfTtHrW+2rMOC93k2o0+76PUlee3HUrPLNC3bflrny9z3ZsPRByugq
         I1/gK0/7tnINmNn/tksGScvM8SMgZKDhYidiUwSClpqJhIcCTFbPClwm7sn1Z9jWfeFI
         gblYOMyTLMA1ivKmDG82PbTOdj1AhRIjyKta3AveLl6+0AXh6LxzS3rgsKGg5ZavnONI
         8c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741452; x=1776346252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RfjnMCd/AF7bBdOrwDqyxNxMK9P28G5mGjUvtSq2DM=;
        b=KdjW4o1A65TLD4IocnD8HDsgEosWX22bGRNQHL6nRKVuTiqyWf1tqyoWE/0XSagL/Q
         mRvZYTNg5CPp7GoYvtmdAQ5clBF/zN7Pb0B142XZ7CDMg1fQWgdQ8wNB/bUXa5TOyN78
         VexE7KhAx2ihMHZichk6T3Y/BRC3rBVjmd6RvlKKUT1EjRnwCZQkLrCSW0lcsArXnd1a
         /1hwi3r+mpxY7G4gU+HOnoevbKBp/+k2V6b5kLtwJ62+TiodYL1QmyKaGOJh5b1PQg/y
         GZFffs0JWDS4XbliPjDdmalIM5LVgZ3nDnpdTrP86g2zohPySwkT74SfoR6E6EksbmcK
         EBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZE1y/x2on2/xLEwltfZ78+D1inshtAQAFbqq5Wwizb+FRDdQDSWnaWPh2w/IxthsYZoFzb3Aj2LvnWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbbzZBLVIFmONYUxg/9JD3gAMB8eZ57wGHVSZNAyVb/RuF59FL
	d7iJbItDckjfkOLiJ2pZCMFRz136OA24s8SBdAdtAMRiiB6/6MlIY306NyGYGiXEvEXGxQ==
X-Gm-Gg: AeBDieuej2ZPxHI6ISwQ59LnUFl6A8DJ1U47aNljSibrXqAp5AEAOrMLrXPA+pgHGnZ
	1Z0zWTUOMNHDlPb2kK3VDqlOLidwKIVqYGHhuDmY77uzHZVSLUt+s9s7kZGJjG6/TwiW7KZorBH
	5vwZXXWCgBoORB+OHHQXYbTEZqKTQL2Rl7yCbCRC+q9wFrn/ES7f+XdhomzP9rQvP8Uq77u/2KV
	xM8xppMw0J8NqlXSvk1ImcRvGPm3jEldRqFtbPLd8Ci5GU6D88Be9KkfaeXuDcXzFLB0ofarv/Y
	bxwtHAmQVKCBCuEC6+BAOvmbaiXYu9OcnLRbtjDuhzv4qak5/PRdQJjSt/C0jvxTp7N1alj0n+2
	QEyqJdWvHijeU5f1eJKQrQp9rozxxFhXrGNge1F9fVLpOAuxVlaLGpJ+UVxR0DvkgyGTA8y1dqv
	Ti/EY0uCOcv+TAmBr08SvO6H3Z9PdEvJ+gRcBVipb9txpPrsn2a8hRaFkxXi/bLKK1Ww==
X-Received: by 2002:a05:6a20:a11a:b0:398:9301:b9ae with SMTP id adf61e73a8af0-39f2f11b8a1mr27001073637.52.1775741451877;
        Thu, 09 Apr 2026 06:30:51 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm21021166a12.24.2026.04.09.06.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:30:51 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 5/7] ublk: allow buffer registration before device is started
Date: Thu,  9 Apr 2026 21:30:17 +0800
Message-ID: <20260409133020.3780098-6-tom.leiming@gmail.com>
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

Before START_DEV, there is no disk, no queue, no I/O dispatch, so
the maple tree can be safely modified under ub->mutex alone without
freezing the queue.

Add ublk_lock_buf_tree()/ublk_unlock_buf_tree() helpers that take
ub->mutex first, then freeze the queue if device is started. This
ordering (mutex -> freeze) is safe because ublk_stop_dev_unlocked()
already holds ub->mutex when calling del_gendisk() which freezes
the queue.

Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 82 +++++++++++++---------------------------
 1 file changed, 27 insertions(+), 55 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8b686e70cf28..79178f13f198 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5233,30 +5233,31 @@ static int ublk_char_dev_permission(struct ublk_device *ub,
 }
 
 /*
- * Drain inflight I/O and quiesce the queue. Freeze drains all inflight
- * requests, quiesce_nowait marks the queue so no new requests dispatch,
- * then unfreeze allows new submissions (which won't dispatch due to
- * quiesce). This keeps freeze and ub->mutex non-nested.
+ * Lock for maple tree modification: acquire ub->mutex, then freeze queue
+ * if device is started. If device is not yet started, only mutex is
+ * needed since no I/O path can access the tree.
+ *
+ * This ordering (mutex -> freeze) is safe because ublk_stop_dev_unlocked()
+ * already holds ub->mutex when calling del_gendisk() which freezes the queue.
  */
-static void ublk_quiesce_and_release(struct gendisk *disk)
+static unsigned int ublk_lock_buf_tree(struct ublk_device *ub)
 {
-	unsigned int memflags;
+	unsigned int memflags = 0;
 
-	memflags = blk_mq_freeze_queue(disk->queue);
-	blk_mq_quiesce_queue_nowait(disk->queue);
-	blk_mq_unfreeze_queue(disk->queue, memflags);
+	mutex_lock(&ub->mutex);
+	if (ub->ub_disk)
+		memflags = blk_mq_freeze_queue(ub->ub_disk->queue);
+
+	return memflags;
 }
 
-static void ublk_unquiesce_and_resume(struct gendisk *disk)
+static void ublk_unlock_buf_tree(struct ublk_device *ub, unsigned int memflags)
 {
-	blk_mq_unquiesce_queue(disk->queue);
+	if (ub->ub_disk)
+		blk_mq_unfreeze_queue(ub->ub_disk->queue, memflags);
+	mutex_unlock(&ub->mutex);
 }
 
-/*
- * Insert PFN ranges of a registered buffer into the maple tree,
- * coalescing consecutive PFNs into single range entries.
- * Returns 0 on success, negative error with partial insertions unwound.
- */
 /* Erase coalesced PFN ranges from the maple tree matching buf_index */
 static void ublk_buf_erase_ranges(struct ublk_device *ub, int buf_index)
 {
@@ -5327,7 +5328,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	unsigned long addr, size, nr_pages;
 	struct page **pages = NULL;
 	unsigned int gup_flags;
-	struct gendisk *disk;
+	unsigned int memflags;
 	long pinned;
 	int index;
 	int ret;
@@ -5354,16 +5355,10 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 	    !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
 		return -EINVAL;
 
-	disk = ublk_get_disk(ub);
-	if (!disk)
-		return -ENODEV;
-
-	/* Pin pages before quiescing (may sleep) */
+	/* Pin pages before any locks (may sleep) */
 	pages = kvmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
-	if (!pages) {
-		ret = -ENOMEM;
-		goto put_disk;
-	}
+	if (!pages)
+		return -ENOMEM;
 
 	gup_flags = FOLL_LONGTERM;
 	if (!(buf_reg.flags & UBLK_SHMEM_BUF_READ_ONLY))
@@ -5379,14 +5374,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 		goto err_unpin;
 	}
 
-	/*
-	 * Drain inflight I/O and quiesce the queue so no new requests
-	 * are dispatched while we modify the maple tree. Keep freeze
-	 * and mutex non-nested to avoid lock dependency.
-	 */
-	ublk_quiesce_and_release(disk);
-
-	mutex_lock(&ub->mutex);
+	memflags = ublk_lock_buf_tree(ub);
 
 	index = ida_alloc_max(&ub->buf_ida, USHRT_MAX, GFP_KERNEL);
 	if (index < 0) {
@@ -5400,22 +5388,16 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
 		goto err_unlock;
 	}
 
-	mutex_unlock(&ub->mutex);
-
+	ublk_unlock_buf_tree(ub, memflags);
 	kvfree(pages);
-	ublk_unquiesce_and_resume(disk);
-	ublk_put_disk(disk);
 	return index;
 
 err_unlock:
-	mutex_unlock(&ub->mutex);
-	ublk_unquiesce_and_resume(disk);
+	ublk_unlock_buf_tree(ub, memflags);
 err_unpin:
 	unpin_user_pages(pages, pinned);
 err_free_pages:
 	kvfree(pages);
-put_disk:
-	ublk_put_disk(disk);
 	return ret;
 }
 
@@ -5459,7 +5441,7 @@ static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
 			       struct ublksrv_ctrl_cmd *header)
 {
 	int index = (int)header->data[0];
-	struct gendisk *disk;
+	unsigned int memflags;
 	int ret;
 
 	if (!ublk_dev_support_shmem_zc(ub))
@@ -5468,23 +5450,13 @@ static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
 	if (index < 0 || index > USHRT_MAX)
 		return -EINVAL;
 
-	disk = ublk_get_disk(ub);
-	if (!disk)
-		return -ENODEV;
-
-	/* Drain inflight I/O before modifying the maple tree */
-	ublk_quiesce_and_release(disk);
-
-	mutex_lock(&ub->mutex);
+	memflags = ublk_lock_buf_tree(ub);
 
 	ret = __ublk_ctrl_unreg_buf(ub, index);
 	if (!ret)
 		ida_free(&ub->buf_ida, index);
 
-	mutex_unlock(&ub->mutex);
-
-	ublk_unquiesce_and_resume(disk);
-	ublk_put_disk(disk);
+	ublk_unlock_buf_tree(ub, memflags);
 	return ret;
 }
 
-- 
2.53.0

