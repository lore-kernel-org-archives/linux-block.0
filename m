Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48493207A25
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494704; cv=none; b=J3TYy2D/EWbTi7VYxkQP16RL3YB/sUVkx4LvOUTnLGEPtLE4tX9da0YqZY8RgSAng8wsIjw+JbWYlhl2RJelf2vDR7YpMWg8+9dLM1WvjMbu2EZo5YRzZ2aavkZxSOFjYhmOym1fJocQV9xwCK8aleB2Qj8+rj3c0lRMHLcNOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494704; c=relaxed/simple;
	bh=1nidxe83YlOVFnlUAhC/TWTuQm/ksSKIUHo5sDKV4X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3GU7rohikm9LbPSqp1jJwBfCXX4AktTlFp8DHpr3QdfbWX39e67PUcHZ2u2i/I6BV4bxvRqszuYCAzsi8T1uk6gojLoW/LStefLbeqJc+AOSIV6NRm0FQQ3NGS4gv/hazGB5UVsJ7kdHaP5MTnRAAI2yJ1LZcAotW3Nixfm0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YFwtpApL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YFwtpApL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mypScqCIyLbbV6jVQFhblmb33CqlnwMmBfpnCB8FigQ=; b=YFwtpApLGwGfBt9W2qPFEAhP9q
	U8nXlGRv4G7N29yk3Nt5IpEpfAvQAQtd/nMfnb6ZtYAGsLEYyqOqCdwQYBjLu27nHFsXunLtkuNuH
	MyNPQHMCmae7bss0McZ1OuCJJ/0jTM2mSzTXHhUSXrGar7pH1sktDalqPfy+W2srKHk7OcsTXwE53
	CzCxDBmxZ3lfpTMZUqx90P3BmJaNWHIwasdxr+hzpv0P88GB1YmgWggmDBeYUe1xGLwcjNWE3WxwD
	KcvCqL7aAwGl8G0HhceB1S7WuNeT/3Nbq6UQOc8dtHOpphyUN13npQ1PhHA0Iog00gwW3ciLLqrOy
	6POnrqIg==;
Received: from 2a02-8389-2341-5b80-76c3-a3dc-14f6-94e8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:76c3:a3dc:14f6:94e8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9b4-0000000EOZS-29ZG;
	Fri, 10 Jan 2025 07:38:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 8/8] loop: remove the use_dio field in struct loop_device
Date: Fri, 10 Jan 2025 08:37:38 +0100
Message-ID: <20250110073750.1582447-9-hch@lst.de>
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

This field duplicate the LO_FLAGS_DIRECT_IO flag in lo_flags.  Remove it
to have a single source of truth about using direct I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index acb1a0cdfb27..1ec7417c7f00 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -68,7 +68,6 @@ struct loop_device {
 	struct list_head        idle_worker_list;
 	struct rb_root          worker_tree;
 	struct timer_list       timer;
-	bool			use_dio;
 	bool			sysfs_inited;
 
 	struct request_queue	*lo_queue;
@@ -196,32 +195,30 @@ static bool lo_can_use_dio(struct loop_device *lo)
 	return true;
 }
 
+/*
+ * Direct I/O can be enabled either by using an O_DIRECT file descriptor, or by
+ * passing in the LO_FLAGS_DIRECT_IO flag from userspace.  It will be silently
+ * disabled when the device block size is too small or the offset is unaligned.
+ *
+ * loop_get_status will always report the effective LO_FLAGS_DIRECT_IO flag and
+ * not the originally passed in one.
+ */
 static inline void loop_update_dio(struct loop_device *lo)
 {
-	bool dio = lo->use_dio || (lo->lo_backing_file->f_flags & O_DIRECT);
-	bool use_dio = dio && lo_can_use_dio(lo);
+	bool dio_in_use = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 
 	lockdep_assert_held(&lo->lo_mutex);
 	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
 		     lo->lo_queue->mq_freeze_depth == 0);
 
-	if (lo->use_dio == use_dio)
-		return;
-
-	/* flush dirty pages before starting to use direct I/O */
-	if (use_dio)
-		vfs_fsync(lo->lo_backing_file, 0);
-
-	/*
-	 * The flag of LO_FLAGS_DIRECT_IO is handled similarly with
-	 * LO_FLAGS_READ_ONLY, both are set from kernel, and losetup
-	 * will get updated by ioctl(LOOP_GET_STATUS)
-	 */
-	lo->use_dio = use_dio;
-	if (use_dio)
+	if (lo->lo_backing_file->f_flags & O_DIRECT)
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
-	else
+	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
+
+	/* flush dirty pages before starting to issue direct I/O */
+	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use)
+		vfs_fsync(lo->lo_backing_file, 0);
 }
 
 /**
@@ -1089,7 +1086,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	disk_force_media_change(lo->lo_disk);
 	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
-	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
 	lo->lo_backing_file = file;
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
@@ -1454,7 +1450,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
-	if (use_dio == lo->use_dio)
+	if (use_dio == !!(lo->lo_flags & LO_FLAGS_DIRECT_IO))
 		return 0;
 
 	if (use_dio) {
@@ -1465,7 +1461,6 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 	}
 
 	blk_mq_freeze_queue(lo->lo_queue);
-	lo->use_dio = use_dio;
 	if (use_dio)
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
 	else
@@ -1876,7 +1871,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		cmd->use_aio = false;
 		break;
 	default:
-		cmd->use_aio = lo->use_dio;
+		cmd->use_aio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 		break;
 	}
 
-- 
2.45.2

