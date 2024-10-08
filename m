Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF01DA5F
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364129; cv=none; b=nUCPZLanOSgvtxJcjycq0vYc3UTHfb6NlTxnqVuvS9/tbD/R8S4Lgo6vqrxIJdsInIs82SyFWT8zPmdunlzkVmk73ve3lAOpZiwqtWoxbG6iboAWRUj86rXHL0sFOTL097cWFKLA8GMSG9YCRzRprG4DEyb1JKIyOX45lxfEoWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364129; c=relaxed/simple;
	bh=a6uWmXhYddVe2l586XFtgPbZ++Qnpc25jV2xo7SLzwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jyaCWoCtT04HwJrQ3mo3IMqr0cu4lMG9BxObvta381St9rKb+Nt3keeOBvQIE1/XFTI54Lm+LHEzaO7zKML9Qs139W4OfW6Enb6+k/4Xg00UVkpL8oN2iaH9LoeeUi7itOpHLPbeIj3PzQrLjuq8gLSrKg9jhZin+8sp8ERDUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VH91E72u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VH91E72u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=QY4wuyizDvNgtvjyCS0XcIKbsDcsvfS22PSSuc6zwGE=; b=VH91E72uLs8g118ftIzdxayeL8
	0TUoYECLIOU+hqGw/vRyFhsM/S6QEIEDRYtq07RUn705N+5PgOiQIWP5ssXN2nkSpUHf73NvXnIYL
	fOUYPM9VTPRpoOOZIn9rBh089IMsB1U50NX/4y+BeYVCrjOxOxzS6qDAXXDoSBe/V4KE3ULTGCIEr
	Ctk4bRovfW1TNmEOVj/48iH3ebLznpd3YiwYJnzjpRCsVEXxjPfuijvGBdDQI0MVYZa5bmyqutzqR
	meQf0n3p2u2gLJTnvCUtymNh+nBZQFuYdM3c7XNZO62fCunc2/Lp3HpsNDwJ6T8vNzWJT/OyvWV0E
	5YZaWciA==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy2Sj-00000004WoK-34Yq;
	Tue, 08 Oct 2024 05:08:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: return void from the queue_sysfs_entry load_module method
Date: Tue,  8 Oct 2024 07:08:41 +0200
Message-ID: <20241008050841.104602-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Requesting a module either succeeds or does nothing, return an error from
this method does not make sense.

Also move the load_module after the store method in the struct
declaration to keep the important show and store methods together.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 9 +++------
 block/elevator.c  | 7 ++-----
 block/elevator.h  | 4 ++--
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e85941bec857b6..8717d43e0792b0 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -23,8 +23,8 @@
 struct queue_sysfs_entry {
 	struct attribute attr;
 	ssize_t (*show)(struct gendisk *disk, char *page);
-	int (*load_module)(struct gendisk *disk, const char *page, size_t count);
 	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
+	void (*load_module)(struct gendisk *disk, const char *page, size_t count);
 };
 
 static ssize_t
@@ -684,11 +684,8 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 	 * queue to ensure that the module file can be read when the request
 	 * queue is the one for the device storing the module file.
 	 */
-	if (entry->load_module) {
-		res = entry->load_module(disk, page, length);
-		if (res)
-			return res;
-	}
+	if (entry->load_module)
+		entry->load_module(disk, page, length);
 
 	blk_mq_freeze_queue(q);
 	mutex_lock(&q->sysfs_lock);
diff --git a/block/elevator.c b/block/elevator.c
index 4122026b11f1a1..d6b4eb5443d97f 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -705,19 +705,16 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	return ret;
 }
 
-int elv_iosched_load_module(struct gendisk *disk, const char *buf,
+void elv_iosched_load_module(struct gendisk *disk, const char *buf,
 			    size_t count)
 {
 	char elevator_name[ELV_NAME_MAX];
 
 	if (!elv_support_iosched(disk->queue))
-		return -EOPNOTSUPP;
+		return;
 
 	strscpy(elevator_name, buf, sizeof(elevator_name));
-
 	request_module("%s-iosched", strstrip(elevator_name));
-
-	return 0;
 }
 
 ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
diff --git a/block/elevator.h b/block/elevator.h
index 2a78544bf20180..dbf357ef4fab93 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -148,8 +148,8 @@ extern void elv_unregister(struct elevator_type *);
  * io scheduler sysfs switching
  */
 ssize_t elv_iosched_show(struct gendisk *disk, char *page);
-int elv_iosched_load_module(struct gendisk *disk, const char *page,
-			    size_t count);
+void elv_iosched_load_module(struct gendisk *disk, const char *page,
+		size_t count);
 ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
 
 extern bool elv_bio_merge_ok(struct request *, struct bio *);
-- 
2.45.2

