Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE488F7D
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735082; cv=none; b=B7UI6DjYHXYvwJeJMygJxf8cjJESJ9DHbfDcqeW0IPyw9UX6gr8+Ai4qRl6UgAaUrG3ogl18ggspKa4SH0Pioj8p6BhYHZBiGDjLOd5FyMf/P4ZYgrplTuuQLJULwIko3bQWNgvys32VbuAvTAURWg5zQyiPul7MKnEtP1TdJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735082; c=relaxed/simple;
	bh=qk/2j3llk/eYkog6UXNOQq5XIxGOc4pUo/9C/tPtaLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+jvADgtEM1kfyJto3v1HpruaM/HcnS5LQyihzn8UWpqc2KvIHyBfN8YdIWmQ/vXKQBbGPWBiYdbYCJ3Jv0782wYh6FK/IsFHHkIqYEMxohJuNJDdgZFuhLT1g/DEjdZlpTFUj45m0D0+SMavEUTvyL2aeeKld5iJSzL2ez296A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcinPiPW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcinPiPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736735077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NRM1WhMmmYx3tHFT1bKd+6OiMlTGYfQVwYtxcgI/Bls=;
	b=bcinPiPW4Gh7MA2pycvzlmMMPAfxABRdCceRL/E5jqcH1Fz2cID1+OqRyHfwLkcgooFNlB
	AfiE5O+ipqrYhGQoCuMJmc7avmwiDmyP2CCQHfBBnjCX+Q14Xt1o2/HAO5oZNHaNDxObgw
	QPQ3PZHfc9dozzcG0gxTkXI1wb6I1is=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-l2Y9udwWNsGeGxFwNfbP4g-1; Sun,
 12 Jan 2025 21:24:34 -0500
X-MC-Unique: l2Y9udwWNsGeGxFwNfbP4g-1
X-Mimecast-MFC-AGG-ID: l2Y9udwWNsGeGxFwNfbP4g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6D8D1955DCC;
	Mon, 13 Jan 2025 02:24:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCB77195E3D9;
	Mon, 13 Jan 2025 02:24:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Kun Hu <huk23@m.fudan.edu.cn>,
	Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: [PATCH] loop: don't call vfs_flush() with queue frozen
Date: Mon, 13 Jan 2025 10:24:26 +0800
Message-ID: <20250113022426.703537-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

If vfs_flush() is called with queue frozen, the queue freeze lock may be
connected with FS internal lock, and potential deadlock could be
triggered.

Fix it by moving vfs_flush() out of queue freezing.

Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
Reported-by: Jiaji Qin <jjtan24@m.fudan.edu.cn>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1ec7417c7f00..9adf496b3f93 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -203,7 +203,7 @@ static bool lo_can_use_dio(struct loop_device *lo)
  * loop_get_status will always report the effective LO_FLAGS_DIRECT_IO flag and
  * not the originally passed in one.
  */
-static inline void loop_update_dio(struct loop_device *lo)
+static inline bool loop_update_dio(struct loop_device *lo)
 {
 	bool dio_in_use = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 
@@ -217,8 +217,7 @@ static inline void loop_update_dio(struct loop_device *lo)
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
 
 	/* flush dirty pages before starting to issue direct I/O */
-	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use)
-		vfs_fsync(lo->lo_backing_file, 0);
+	return (lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use;
 }
 
 /**
@@ -589,6 +588,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	int error;
 	bool partscan;
 	bool is_loop;
+	bool flush;
 
 	if (!file)
 		return -EBADF;
@@ -629,11 +629,14 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
 	mapping_set_gfp_mask(file->f_mapping,
 			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
-	loop_update_dio(lo);
+	flush = loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	loop_global_unlock(lo, is_loop);
 
+	if (flush)
+		vfs_fsync(lo->lo_backing_file, 0);
+
 	/*
 	 * Flush loop_validate_file() before fput(), for l->lo_backing_file
 	 * might be pointing at old_file which might be the last reference.
@@ -1255,6 +1258,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	int err;
 	bool partscan = false;
 	bool size_changed = false;
+	bool flush = false;
 
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
@@ -1292,7 +1296,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	}
 
 	/* update the direct I/O flag if lo_offset changed */
-	loop_update_dio(lo);
+	flush = loop_update_dio(lo);
 
 out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
@@ -1302,6 +1306,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	mutex_unlock(&lo->lo_mutex);
 	if (partscan)
 		loop_reread_partitions(lo);
+	if (flush)
+		vfs_fsync(lo->lo_backing_file, 0);
 
 	return err;
 }
@@ -1473,6 +1479,7 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
 	struct queue_limits lim;
 	int err = 0;
+	bool flush;
 
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
@@ -1488,8 +1495,10 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 
 	blk_mq_freeze_queue(lo->lo_queue);
 	err = queue_limits_commit_update(lo->lo_queue, &lim);
-	loop_update_dio(lo);
+	flush = loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
+	if (flush)
+		vfs_fsync(lo->lo_backing_file, 0);
 
 	return err;
 }
-- 
2.44.0

