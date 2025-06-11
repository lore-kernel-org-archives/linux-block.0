Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42F226188
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631796; cv=none; b=QtSbEAyPpmzdom6H9LYOqlVqsHBhhO01A+r2A02U9zpjbQqy9m6BISRBXL3doj6+7zduRx4rvAvevC+TikRTNDdWvMiCt8DsOwDSuq2CALxOxRZzWKg72RLdgDH6XU3ruGifvXOdIuu2VAvBtyuAUMAHkicDBTI9ovq6eObFdGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631796; c=relaxed/simple;
	bh=3FGdm1Npd2kGKxy449lb+cMri5l9tzXCD+u7x6DsGfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHsF99dxTgeSCwvfEl1FEbhkShPI+AuIpAURsJvtBmKwZrOX6M4pfXVJcNUUXlE7+8/44N9fKpN3lNCUWQH+LeIkdzrk/Bk1uPDAPjLtRjVzXuU4LtX4dCgnvFobRpwLn8gCebJYlkLr0xaa+bQSpZhPfxGwOcx22wXIS6KoksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu1n3/1S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu1n3/1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749631792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7aMCzzoZL+yNRZZUhuTaD8/7HP1l9F35JSPnI4VwIl4=;
	b=Pu1n3/1S0KTXVsRsGXmV4WcE9/9VLPOZJOoasJvcFHvhMHWOeJQ9/6eiTuPQ+0zvCOGqFq
	E7yJ1ZtfB7+DjZnGPYLAXsAQyHkdT56XoZdC8rXHS7Qkm/RJlLdkIaY/VDzZbCPZ06v7TU
	DtiYWG00fSQTmO4SvSoff/FPI8iQKlc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-ooZpWp6NNt6Cm00yy4iAdw-1; Wed,
 11 Jun 2025 04:49:47 -0400
X-MC-Unique: ooZpWp6NNt6Cm00yy4iAdw-1
X-Mimecast-MFC-AGG-ID: ooZpWp6NNt6Cm00yy4iAdw_1749631786
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E98E195608C;
	Wed, 11 Jun 2025 08:49:45 +0000 (UTC)
Received: from localhost (unknown [10.72.116.142])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DBA519560A3;
	Wed, 11 Jun 2025 08:49:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
Subject: [PATCH] loop: move lo_set_size() out of queue freeze
Date: Wed, 11 Jun 2025 16:49:38 +0800
Message-ID: <20250611084938.108829-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

It isn't necessary to freeze queue for updating disk size given submit_bio()
doesn't grab queue usage counter for checking eod.

Also many driver won't freeze queue for calling set_capacity_and_notify().

Move lo_set_size() out of queue freeze for fixing many lockdep warning
report.

Link: https://lore.kernel.org/linux-block/67ea99e0.050a0220.3c3d88.0042.GAE@google.com/
Reported-by: syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f8d136684109..500840e4a74e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1248,12 +1248,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	lo->lo_flags &= ~LOOP_SET_STATUS_CLEARABLE_FLAGS;
 	lo->lo_flags |= (info->lo_flags & LOOP_SET_STATUS_SETTABLE_FLAGS);
 
-	if (size_changed) {
-		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
-					   lo->lo_backing_file);
-		loop_set_size(lo, new_size);
-	}
-
 	/* update the direct I/O flag if lo_offset changed */
 	loop_update_dio(lo);
 
@@ -1261,6 +1255,11 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
+	if (!err && size_changed) {
+		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
+					   lo->lo_backing_file);
+		loop_set_size(lo, new_size);
+	}
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 	if (partscan)
-- 
2.49.0

