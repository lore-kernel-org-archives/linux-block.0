Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737D248891
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545181; cv=none; b=i+1VH+bUb0p0paEk5nfIAaw+p2VWkaKMwziWRiEboqVn8wUX57Okp8C6hX6kt051qtpM1YczyAhuUSbsQnGtAJG81vRGALWYCKlffWMLTg1E/F7zmdPEEuTL4btOseXqaPB86uhcDKQpiwoyTnY0EuzSqsOne2x8SeqaJBQZ/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545181; c=relaxed/simple;
	bh=pJGRdc/yidzgt+J1ItkoWkHLZH4yZ6cs2A81oZjy6cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1O4pa/fsdMNhYJd3rYrTUO1ShU6fMfbZTt8PNy7t1uq7vxBjhtTTvnIwhGphopFRDwoPxg015xxZLzlXW7GabfJOS6WpkKfw/8PAuoGm+iZYdBq5F2Wh3vwSJd9i/gUg8alfcHRvePiddKRSkDigWqkOVQOSpC1Ye74WN4ehIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJCLTLmK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJCLTLmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763545178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGpYKdce/STz11xOFdKbTNhd7IWLHhV+9HmVc9QSEjY=;
	b=VJCLTLmKk+c6f3KPqr0XeriXciXrDgFK4qsA8OfD6+n5w6osgMmerzFJp9jjAUZTdB/Xfi
	RLyNtaacSwXFmNpDUe0ww3ePRSSKnedwPZYpmnEZz8FeQPZml2Dci8ebRdQgrEb+fEz/Fm
	tM25fzsz1qvtIs/5YF9u+JUE0cxxD+U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-woRfCEENObmqWsFuil0UEg-1; Wed,
 19 Nov 2025 04:39:37 -0500
X-MC-Unique: woRfCEENObmqWsFuil0UEg-1
X-Mimecast-MFC-AGG-ID: woRfCEENObmqWsFuil0UEg_1763545176
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1844518D95D1;
	Wed, 19 Nov 2025 09:39:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.74])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EA08300A88D;
	Wed, 19 Nov 2025 09:39:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] loop: disable writeback throttling and fix nowait support
Date: Wed, 19 Nov 2025 17:38:53 +0800
Message-ID: <20251119093855.3405421-4-ming.lei@redhat.com>
In-Reply-To: <20251119093855.3405421-1-ming.lei@redhat.com>
References: <20251119093855.3405421-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Disable writeback throttling by default for loop devices to avoid deadlock
scenarios when RQOS features are enabled. This way is fine for loop
because the backing device covers writeback throttle too.

Update lo_backfile_support_nowait() to check both backing file's
FMODE_NOWAIT support and the queue's QOS enablement status. This prevents
deadlocks in submit_bio() code path when RQOS takes online wait and blocks
backing file IOs.

Fixes: 0ba93a906dda ("loop: try to handle loop aio command via NOWAIT IO first")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c   | 13 ++++++++++++-
 include/linux/blkdev.h |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 705373b9668d..107760085ac5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -443,9 +443,18 @@ static int lo_submit_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	return ret;
 }
 
+/*
+ * Allow NOWAIT only if the backing file supports it, and loop disk's
+ * RQOS feature isn't enabled.
+ *
+ * RQOS takes online wait in submit_bio() code path, and IOs to backing
+ * file may be blocked, then deadlock is caused, see
+ * submit_bio_noacct_nocheck().
+ */
 static bool lo_backfile_support_nowait(const struct loop_device *lo)
 {
-	return lo->lo_backing_file->f_mode & FMODE_NOWAIT;
+	return (lo->lo_backing_file->f_mode & FMODE_NOWAIT) &&
+		!test_bit(QUEUE_FLAG_QOS_ENABLED, &lo->lo_queue->queue_flags);
 }
 
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
@@ -2250,6 +2259,8 @@ static int loop_add(int i)
 	lo->idr_visible = true;
 	mutex_unlock(&loop_ctl_mutex);
 
+	wbt_disable_default(disk);
+
 	return i;
 
 out_cleanup_disk:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index cb4ba09959ee..4ed2248c19ea 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -449,6 +449,8 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 		sector_t sectors, sector_t nr_sectors);
 int blk_revalidate_disk_zones(struct gendisk *disk);
 
+void wbt_disable_default(struct gendisk *disk);
+
 /*
  * Independent access ranges: struct blk_independent_access_range describes
  * a range of contiguous sectors that can be accessed using device command
-- 
2.47.0

