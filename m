Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126252066F2
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494680; cv=none; b=nJS1Xg9IUMHTa87CC8mW4dr0rRPpBuZ2oc3X7+QPsF85iLWpOEEXORfAdBdbDviwKueisGDGRlL9F8/On7dT6DAYWFDjczSxqPMwEptUMmWU7+JJDOv9KI4eNgmbgq/VD+XiI1+wxymFK9oGlLzmHm9JQ8Ng49j5qTYW+jeKxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494680; c=relaxed/simple;
	bh=48cEQwW1/AGHm12XJMHZEt6cXBbpFq/S1T2KgiTEjgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Je+ckbKw7dl+AgvZWgsMh7rnYrIRQf/M1Iu3Lts5xMQG1OEnuiJfEHUjDn6uAiyGrCpZAZfmYolQkWgaZgovptAzGmPDI/UBuzaS0NCsJZPtOhMl2I1z0ip5WDp3hFlsjajffMGGQ3zG93xh5hzvFFF4NsKoB3oU9V/g7lCDX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wEktJjJX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wEktJjJX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QVSgywGjeyHzIkGH0Hz4WNzrp+6FU5u/jaR6AJJSjVU=; b=wEktJjJXwLp7mAPr3GXKZKTQ52
	OPkYSDpR9Q3pfg22FUdnC6nCoEY/rhn7w1+qnEPbHeihHbsyYqfQ2ptrhg0d9kCz0lcWTThfzhK3b
	iw76nTHxaFUk0SOyrN4u+4NqQvPeFAblQwqoikq+L7kSc9e+YMOQE4FTH4DEfN1b3QBYEEr5VnRmP
	/GU9sZ+v6FHRO+eTeOD3SFOOcrR/i0sc4gHhf6QQ2asK6nXDL4x/OxLNLrCBDANaiUj7kFrXPKWA1
	wNjARvHk8KCiYh4tOZvbF6OQ3ied+KjC1mcO/+i7EjRFElL7AlpfJ7YFfLGFBdtgtGpkdHp4dVAg6
	oxMoWxOA==;
Received: from 2a02-8389-2341-5b80-76c3-a3dc-14f6-94e8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:76c3:a3dc:14f6:94e8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9ag-0000000EOPh-0noN;
	Fri, 10 Jan 2025 07:37:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/8] loop: move updating lo_flags out of loop_set_status_from_info
Date: Fri, 10 Jan 2025 08:37:31 +0100
Message-ID: <20250110073750.1582447-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110073750.1582447-1-hch@lst.de>
References: <20250110073750.1582447-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

While loop_configure simplify assigns the flags passed in by userspace,
loop_set_status only looks at the two changeable flags, and currently
has to do a complicate dance to implement that.

Move assign lo->lo_flags out of loop_set_status_from_info into the
callers and thus drastically simplify the lo_flags handling in
loop_set_status.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 15e486baa223..6ea729cdce71 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -971,7 +971,6 @@ loop_set_status_from_info(struct loop_device *lo,
 
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
-	lo->lo_flags = info->lo_flags;
 	return 0;
 }
 
@@ -1069,6 +1068,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	error = loop_set_status_from_info(lo, &config->info);
 	if (error)
 		goto out_unlock;
+	lo->lo_flags = config->info.lo_flags;
 
 	if (!(file->f_mode & FMODE_WRITE) || !(mode & BLK_OPEN_WRITE) ||
 	    !file->f_op->write_iter)
@@ -1258,7 +1258,6 @@ static int
 loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
 	int err;
-	int prev_lo_flags;
 	bool partscan = false;
 	bool size_changed = false;
 
@@ -1280,18 +1279,16 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
-	prev_lo_flags = lo->lo_flags;
-
 	err = loop_set_status_from_info(lo, info);
 	if (err)
 		goto out_unfreeze;
 
-	/* Mask out flags that can't be set using LOOP_SET_STATUS. */
-	lo->lo_flags &= LOOP_SET_STATUS_SETTABLE_FLAGS;
-	/* For those flags, use the previous values instead */
-	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_SETTABLE_FLAGS;
-	/* For flags that can't be cleared, use previous values too */
-	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_CLEARABLE_FLAGS;
+	partscan = !(lo->lo_flags & LO_FLAGS_PARTSCAN) &&
+		(info->lo_flags & LO_FLAGS_PARTSCAN);
+
+	lo->lo_flags &= ~(LOOP_SET_STATUS_SETTABLE_FLAGS |
+			  LOOP_SET_STATUS_CLEARABLE_FLAGS);
+	lo->lo_flags |= (info->lo_flags & LOOP_SET_STATUS_SETTABLE_FLAGS);
 
 	if (size_changed) {
 		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
@@ -1304,12 +1301,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
-
-	if (!err && (lo->lo_flags & LO_FLAGS_PARTSCAN) &&
-	     !(prev_lo_flags & LO_FLAGS_PARTSCAN)) {
+	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
-		partscan = true;
-	}
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 	if (partscan)
-- 
2.45.2

