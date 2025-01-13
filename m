Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A261CAA89
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770020; cv=none; b=XRINzlNevb7LOJObF69O9XZvGFdsYsautQ3edmFyQ4Ugw/TGWHshHdy9cyb8Zf+SoV47SDhJRaJ8Jb8q2CBbdJFE2xrrHY7xWIcESoWRKNBoYkz4Yi4W7KuWbBmJ8HM0dUOCcvlJH9rUEWzFowQzvmjFFcG56vWOmHm3eRHmwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770020; c=relaxed/simple;
	bh=r30vt+5OTMFPh/fF4H7OdSBQz/CZLVZrwGnm3KxYiWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDcmmykp/OzzxycyI8CRugVsGuWlaKEcCAu7xuhiCU/Cx1kMSvknMhdHjhYEMzqU1Sss8YapQjSd6Lsc1y4ok9Tv2VA46RKKmxDPv64FayMlRvpf2xg0ocEHAajj7J6rmteIGbTIZIUwmM87ANv1gkASe0V68f+U+S+J5Rr4aLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjWUDkPv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjWUDkPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736770016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ybAu5i+n18hZUZxjbZyBc8U2lbO2B4XwwyzHK8p6Qbo=;
	b=YjWUDkPvpgQqjI/3XAAhGPbaT5BW7BUSUCEK7aZsQUMnBHMTjVOddfJMhT1kMX3e4tIpGm
	kYOZSk3hQnjrP1AXBhacjdmHhKpA0AGQRJ+mwY3KKUy21spRDv+VtEfEkmd4bwpB3r13OW
	gbUGzHWPN0wWN+B+FF4eyhdaaMdpgUc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-f-ry0qUMMA-S2rUaRDS-JA-1; Mon,
 13 Jan 2025 07:06:55 -0500
X-MC-Unique: f-ry0qUMMA-S2rUaRDS-JA-1
X-Mimecast-MFC-AGG-ID: f-ry0qUMMA-S2rUaRDS-JA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A4481956065;
	Mon, 13 Jan 2025 12:06:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D70DD30001BE;
	Mon, 13 Jan 2025 12:06:50 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kun Hu <huk23@m.fudan.edu.cn>,
	Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: [PATCH] loop: move vfs_fsync() out of loop_update_dio()
Date: Mon, 13 Jan 2025 20:06:44 +0800
Message-ID: <20250113120644.811886-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

If vfs_flush() is called with queue frozen, the queue freeze lock may be
connected with FS internal lock, and lockdep warning can be triggered
because the queue freeze lock is connected with too many global or
sub-system locks.

Fix the warning by moving vfs_fsync() out of loop_update_dio():

- vfs_fsync() is only needed when switching to dio

- only loop_change_fd() and loop_configure() may switch from buffered
IO to direct IO, so call vfs_fsync() directly here. This way is safe
because either loop is in unbound, or new file isn't attached

- for the other two cases of set_status and set_block_size, direct IO
can only become off, so no need to call vfs_fsync()

Cc: Christoph Hellwig <hch@infradead.org>
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
Reported-by: Jiaji Qin <jjtan24@m.fudan.edu.cn>
Closes: https://lore.kernel.org/linux-block/359BC288-B0B1-4815-9F01-3A349B12E816@m.fudan.edu.cn/T/#u
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1ec7417c7f00..be7e20064427 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -205,8 +205,6 @@ static bool lo_can_use_dio(struct loop_device *lo)
  */
 static inline void loop_update_dio(struct loop_device *lo)
 {
-	bool dio_in_use = lo->lo_flags & LO_FLAGS_DIRECT_IO;
-
 	lockdep_assert_held(&lo->lo_mutex);
 	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
 		     lo->lo_queue->mq_freeze_depth == 0);
@@ -215,10 +213,6 @@ static inline void loop_update_dio(struct loop_device *lo)
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
 	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
-
-	/* flush dirty pages before starting to issue direct I/O */
-	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use)
-		vfs_fsync(lo->lo_backing_file, 0);
 }
 
 /**
@@ -621,6 +615,9 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
 		goto out_err;
 
+	/* may work in dio, so flush page cache for avoiding race */
+	vfs_fsync(file, 0);
+
 	/* and ... switch */
 	disk_force_media_change(lo->lo_disk);
 	blk_mq_freeze_queue(lo->lo_queue);
@@ -1098,6 +1095,9 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (error)
 		goto out_unlock;
 
+	/* may work in dio, so flush page cache for avoiding race */
+	vfs_fsync(file, 0);
+
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 
-- 
2.44.0

