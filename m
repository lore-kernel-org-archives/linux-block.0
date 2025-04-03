Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF052E3385
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743677669; cv=none; b=jvUmmT0n8pi0qLOCjJLQt2ILKfQvAGHaXUVLvrjVxMMMrqiTfnAVIEwR1CqtGFl+FCO3nrE+29DsASB5a3Vzb0DIXlla58un50nY4RhQZcxaXTkACGXwwv7WjGXCxsDGtl2ayZp3m/N9G8zLFcF/rfTslCpRap03KZnLtQ75yIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743677669; c=relaxed/simple;
	bh=IzcHht+XYLgR3notL+d/fmbgxuWYrIk5239kpeV0ywE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHlo6XDz1Vc/WcbHNBH9epP5xiDi72wDdEjDxkjOuXe5yO6ix+p3UUV77ZsWwLZyanw6oyR/R/6PzYSND/2JQtsCldL4cglNrHnZVywQ30gfNoR4pTPIjiksdCAtdQRf6BsfS/ljHpw6Bw8Z4preGZfiBaDbN5wm2xyLUQ+Iuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3zdKLcq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3zdKLcq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743677665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MPSKZ1qdhalqkp1+aOeiB5ogQSMlJaejnnHaoy/fEdA=;
	b=Q3zdKLcqS6arYfuLj4XAFyVUV+9fMpDl2Xh5f952LWsm+FeGXGj/EBwxfxcDp1MakDlZnV
	sfcuoqojy6I7W6stP/LDIHctGC0zrNVJHTbPEXMVaO4S4iNDtAR4M2vN+tqxRXJd8+vqfB
	CX9/LaNv7TR6WWShrC69FN3J3bQAXNE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-7ZtdeTJXNBaFYvuA4fmHGw-1; Thu,
 03 Apr 2025 06:54:22 -0400
X-MC-Unique: 7ZtdeTJXNBaFYvuA4fmHGw-1
X-Mimecast-MFC-AGG-ID: 7ZtdeTJXNBaFYvuA4fmHGw_1743677661
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E0E31955DDE;
	Thu,  3 Apr 2025 10:54:20 +0000 (UTC)
Received: from localhost (unknown [10.72.120.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D7BA19560AD;
	Thu,  3 Apr 2025 10:54:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
Subject: [PATCH] loop: replace freezing queue with quiesce when changing loop specific setting
Date: Thu,  3 Apr 2025 18:54:14 +0800
Message-ID: <20250403105414.1334254-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

freeze queue should be used for changing block layer generic setting, such
as logical block size, PI, ..., and it is enough to quiesce queue for
changing loop specific setting.

Remove the queue freeze warning in loop_update_dio(), since it is only
needed in loop_set_block_size(), where queue is froze obviously.

Fix reported lockdep by syszbot:

https://lore.kernel.org/linux-block/67ea99e0.050a0220.3c3d88.0042.GAE@google.com/

Reported-by: syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 674527d770dc..59886556f55c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -190,8 +190,6 @@ static bool lo_can_use_dio(struct loop_device *lo)
 static inline void loop_update_dio(struct loop_device *lo)
 {
 	lockdep_assert_held(&lo->lo_mutex);
-	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
-		     lo->lo_queue->mq_freeze_depth == 0);
 
 	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
@@ -595,7 +593,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 {
 	struct file *file = fget(arg);
 	struct file *old_file;
-	unsigned int memflags;
 	int error;
 	bool partscan;
 	bool is_loop;
@@ -640,11 +637,11 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	/* and ... switch */
 	disk_force_media_change(lo->lo_disk);
-	memflags = blk_mq_freeze_queue(lo->lo_queue);
+	blk_mq_quiesce_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	loop_assign_backing_file(lo, file);
 	loop_update_dio(lo);
-	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
+	blk_mq_unquiesce_queue(lo->lo_queue);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	loop_global_unlock(lo, is_loop);
 
@@ -1270,7 +1267,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	int err;
 	bool partscan = false;
 	bool size_changed = false;
-	unsigned int memflags;
 
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
@@ -1287,8 +1283,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		invalidate_bdev(lo->lo_device);
 	}
 
-	/* I/O needs to be drained before changing lo_offset or lo_sizelimit */
-	memflags = blk_mq_freeze_queue(lo->lo_queue);
+	/* queue needs to be quiesced before changing lo_offset or lo_sizelimit */
+	blk_mq_quiesce_queue(lo->lo_queue);
 
 	err = loop_set_status_from_info(lo, info);
 	if (err)
@@ -1310,7 +1306,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	loop_update_dio(lo);
 
 out_unfreeze:
-	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
+	blk_mq_unquiesce_queue(lo->lo_queue);
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 out_unlock:
-- 
2.47.0

