Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976EA20B810
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951320; cv=none; b=FMT04JuG0Lcu52oUuh7JfhAfsaN3uti03RI15SYq6riJYOGqkc3i8cl6W7NI4MGhaztIj+4ZhPqwhkYjJmshO/wS2jS+4xoeBOzanJXARyKWDHdEJgjc42JPPgdZITdHe3i3314ZgQUD8K5nMFPk/dcKE1Dg1C9WkxkV2PUEXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951320; c=relaxed/simple;
	bh=Is5KFFqvRaJakK5EnaX0115dGfTLs0q9QT/WFjoiAsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=argmtgSsCDSksmp79h/F3lRurbPzNj04XR8JSnqWcN9mn+gP9xFnrh7EDLkvePf6IkdRLdjIElpORak6TE6ew1vS9eG5hOINiHzQW5DKmA0SX5obmaKLVXo1M61kKsYPzsIYFOUu/bZlUThrNwz+czT5OPkdyRfAd7OZ4oipRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dAKEDR5E; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dAKEDR5E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774951316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9DwzIL+nIBKJisjB0kEuqC9izIb8aPOSRPGcH/OulXI=;
	b=dAKEDR5EktehXgZRCKslPFZU/jHmII8np3Kn4BiaIYcLWWn6LfXdltODGsiA/DzbmbK+Q3
	theGmdgrc7ALOuE0KKXoluztXmvG++3MHN7WQLvlYS2W3sJ9dum10+pa7y4WOCAEN+bzS2
	WiTHigIYqsWeYgr+/6yrj2BMl7xGowo=
From: Jackie Liu <liu.yun@linux.dev>
To: dlemoal@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH v2] block: fix zones_cond memory leak in blk_revalidate_disk_zones()
Date: Tue, 31 Mar 2026 18:01:03 +0800
Message-ID: <20260331100103.82085-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

Fix memory leaks of args.zones_cond allocated in
disk_revalidate_zone_resources() on multiple error paths:

1) When disk_revalidate_zone_resources() itself fails (e.g.
   disk_alloc_zone_resources() returns an error), blk_revalidate_disk_zones()
   returns directly without freeing args.zones_cond.

2) When report_zones() fails or the capacity check fails,
   disk_free_zone_resources() only frees the old disk->zones_cond, not
   the newly allocated args.zones_cond.

3) When the nr_conv_zones validation fails in disk_update_zone_resources(),
   the code jumps to unfreeze before disk_set_zones_cond_array() transfers
   ownership of args->zones_cond to disk->zones_cond.

Fix this by freeing args->zones_cond at each error site: in
blk_revalidate_disk_zones() when disk_revalidate_zone_resources() or zone
reporting fails, and in disk_update_zone_resources() before jumping to
the unfreeze label.

Fixes: 6e945ffb6555 ("block: use zone condition to determine conventional zones")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/blk-zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9d1dd6ccfad7..be99ab785dcd 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1960,6 +1960,7 @@ static int disk_update_zone_resources(struct gendisk *disk,
 		queue_limits_cancel_update(q);
 		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
 			disk->disk_name, args->nr_conv_zones, disk->nr_zones);
+		kfree(args->zones_cond);
 		ret = -ENODEV;
 		goto unfreeze;
 	}
@@ -2239,6 +2240,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	ret = disk_revalidate_zone_resources(disk, &args);
 	if (ret) {
 		memalloc_noio_restore(noio_flag);
+		kfree(args.zones_cond);
 		return ret;
 	}
 
@@ -2264,6 +2266,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 
 	pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
 
+	kfree(args.zones_cond);
 	memflags = blk_mq_freeze_queue(q);
 	disk_free_zone_resources(disk);
 	blk_mq_unfreeze_queue(q, memflags);
-- 
2.51.1

