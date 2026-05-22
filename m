Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C503D4123
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450995; cv=none; b=WqLm2eanl08EglP9t+IGEGdEjO2R4Pfb0tyS+9TCpoK9KNis3HasS2GxWpEv6trqZ4NlNjtRXabau9b3Dn+YcHkuA0jnjf/ofB/Qt3EVVWnujWcZRTBsY4H1YBRKOmdvEXG8w3tnNsTphHGX/dTmt1KmCkh/lJV8VTY0b18FeI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450995; c=relaxed/simple;
	bh=Fk3qgyAHmBzcR7fpIPQakO2o6O665Xc5iWYHd2/iMYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXp8se0jJLd9TSUmyVj3OIFDmuLV4FKBrol6Lm/+5E6o1r8nyS1hltzs4Q5UcHfZOZamjBprVTVu5Rw90/Z3ydtZAYJRrQtUqcuyJaXemGeBj5pzgUmu/NAzAG9U8IPp+lJ0ZIPyMmt19pBCr3/HbpkFyllIS5Aag7t9Tzaz7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8PTH/yO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8PTH/yO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEA51F000E9;
	Fri, 22 May 2026 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779450994;
	bh=GJmb1vAo+JxSVqlwZ/Kgq9J0ql4R2W9Skw60lUsWmWc=;
	h=From:To:Cc:Subject:Date;
	b=K8PTH/yOe+4vVjqZzb6wN9XRAzMAXZzbbCVTIsuoVkvz6KUugkkPhK+/tx5kq8Wfr
	 b0RN6Kbhoy+1Wv1GtcWbw/15Pk8p4CisB9JYY3TkaDrR8xClk19ZAsyMhQmWUG3yuP
	 6iqFYeYxy59knOnHZ3Dptt1uDNsxiIGFAZ/IBe51WyTTGqZMDkt9MdDfFtFAyqe9jL
	 e7L2DZC4rdlcuvQ5KW3VPsUGCGWIRKZLvdcpwKKqJBtqfrGFoaC22qhqP7xz5nulWu
	 WK5GdR7Auo4SHD93XWDrQGDCKrDHW285J7vHWsk3XYUE5o4qwaErD3E4vaQ1VS0UiM
	 7uP9HPfLJMQ+g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: avoid use-after-free in disk_free_zone_resources()
Date: Fri, 22 May 2026 20:56:22 +0900
Message-ID: <20260522115622.588535-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function disk_update_zone_resources() may call
disk_free_zone_resources() in case of error, and following this,
blk_revalidate_disk_zones() will again calls disk_free_zone_resources() if
disk_update_zone_resources() failed. If a zone worker thread is being used
(which is the default for a rotational media zoned device),
disk_free_zone_resources() will try to stop the zone worker thread twice
because disk->zone_wplugs_worker is not reset to NULL when the worker
thread is stopped the first time.

In disk_free_zone_resources(), fix this by correctly clearing
disk->zone_wplugs_worker to NULL when the worker thread is stopped.

And while at it, since disk_free_zone_resources() is always called after a
failed call to disk_update_zone_resources(), remove the unnecessary call
to disk_free_zone_resources() in disk_update_zone_resources().

Fixes: 1365b6904fd0 ("block: allow submitting all zone writes from a single context")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 42ef830054dc..6a221c180889 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2001,8 +2001,10 @@ static void disk_set_zones_cond_array(struct gendisk *disk, u8 *zones_cond)
 
 void disk_free_zone_resources(struct gendisk *disk)
 {
-	if (disk->zone_wplugs_worker)
+	if (disk->zone_wplugs_worker) {
 		kthread_stop(disk->zone_wplugs_worker);
+		disk->zone_wplugs_worker = NULL;
+	}
 	WARN_ON_ONCE(!list_empty(&disk->zone_wplugs_list));
 
 	if (disk->zone_wplugs_wq) {
@@ -2135,9 +2137,6 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	ret = queue_limits_commit_update(q, &lim);
 
 unfreeze:
-	if (ret)
-		disk_free_zone_resources(disk);
-
 	blk_mq_unfreeze_queue(q, memflags);
 
 	return ret;
-- 
2.54.0

