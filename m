Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C433688A
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773813230; cv=none; b=hbpOYt4LOHUfJM9UD79N31ndX4+Bj/R5POWR+7+lafsiLyoAj9U7JQYg2gbWZ0PPxwYh8R/5AyhaeJxG308BoNsTcV6DgYYUn1uJ5agBKriRihA+LYh3vXuPD+mem4wVEspD24D+KoszNpBSn664LKh0L2wbPodsvAcTP8+GQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773813230; c=relaxed/simple;
	bh=FdtruKqjt6OsBCtltakWr8VGKeGfL6Grulf7LY3MGWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TltKesLEE1Ig9+5aZYMV7jPtaAbjXOvVwyxntZFX1Ub/xLgnmNMVKOn7dAuOZNQbfhjDzdNKkRb9MBTzPEKKpSN7lGqukzGsOVtPEERoMNn2FXA8ciZC8SJlWZ0VMAZjB8Umpj4JdPRRYKeVgKjUDyR8IXa1V5ebFiJrrYCyWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ev8WV+W/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ev8WV+W/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GILNakD2jJDz5w7uY/XFaC9xY9GqwSBRoSd5a2ZO9Mo=; b=Ev8WV+W/0gP9A7yjBnnARuCeIA
	f5/dpCyopWjIPU0G7gq2/kI/R6L7TztZaiWhErJZ/yTjz6Zl9m74kwN+7dhzkriYAJ4Mn9DBO6uVn
	K08CBtnf8Q7O8hxzg6OgV9VLRs9/dOQXQJ+AJqHRRiRxYzAtVegAc0AdQlqSxO2nZ82pzO20hqwlq
	X/4Zzw9ZtHUBIcke6ZAHQgO9F5fQxA8tj8VETyT+FQMPMY6j5c58k87KoD8IaMGFKGljopqsWgfDn
	/g/A7DAk1nw7iRS6n/ObjxrpI40Nz4iJPgkAEHqQ483hbRjU4Z5Kz0c/1s5Zw4hrHkYJ1Mv44WNrZ
	1/qr2HUw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2jqj-00000007oCU-3NQ0;
	Wed, 18 Mar 2026 05:53:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] zloop: forget write cache on force removal
Date: Wed, 18 Mar 2026 06:53:15 +0100
Message-ID: <20260318055331.1824108-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318055331.1824108-1-hch@lst.de>
References: <20260318055331.1824108-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a new options that causes zloop to truncate the zone files to the
write pointer value recorded at the last cache flush to simulate
unclean shutdowns.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../admin-guide/blockdev/zoned_loop.rst       |  5 +
 drivers/block/zloop.c                         | 97 +++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
index 6aa865424ac3..237ee2fccb82 100644
--- a/Documentation/admin-guide/blockdev/zoned_loop.rst
+++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
@@ -104,6 +104,11 @@ ordered_zone_append   Enable zloop mitigation of zone append reordering.
                       (extents), as when enabled, this can significantly reduce
                       the number of data extents needed to for a file data
                       mapping.
+discard_write_cache   Discard all data that was not explicitly persisted using a
+                      flush operation when removed by truncating each zone file
+                      to the size recorded during the last flush operation.
+                      This simulates power fail events where uncommitted data is
+                      lost.
 ===================   =========================================================
 
 3) Deleting a Zoned Device
diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 8ca37ca1935a..86a1324c27b3 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/xattr.h>
 
 /*
  * Options for adding (and removing) a device.
@@ -34,6 +35,7 @@ enum {
 	ZLOOP_OPT_BUFFERED_IO		= (1 << 8),
 	ZLOOP_OPT_ZONE_APPEND		= (1 << 9),
 	ZLOOP_OPT_ORDERED_ZONE_APPEND	= (1 << 10),
+	ZLOOP_OPT_DISCARD_WRITE_CACHE	= (1 << 11),
 };
 
 static const match_table_t zloop_opt_tokens = {
@@ -48,6 +50,7 @@ static const match_table_t zloop_opt_tokens = {
 	{ ZLOOP_OPT_BUFFERED_IO,	"buffered_io"		},
 	{ ZLOOP_OPT_ZONE_APPEND,	"zone_append=%u"	},
 	{ ZLOOP_OPT_ORDERED_ZONE_APPEND, "ordered_zone_append"	},
+	{ ZLOOP_OPT_DISCARD_WRITE_CACHE, "discard_write_cache" },
 	{ ZLOOP_OPT_ERR,		NULL			}
 };
 
@@ -79,6 +82,7 @@ struct zloop_options {
 	bool			buffered_io;
 	bool			zone_append;
 	bool			ordered_zone_append;
+	bool			discard_write_cache;
 };
 
 /*
@@ -119,6 +123,7 @@ struct zloop_device {
 	bool			buffered_io;
 	bool			zone_append;
 	bool			ordered_zone_append;
+	bool			discard_write_cache;
 
 	const char		*base_dir;
 	struct file		*data_dir;
@@ -550,6 +555,41 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	zloop_put_cmd(cmd);
 }
 
+static inline bool zloop_zone_is_active(struct zloop_zone *zone)
+{
+	switch (zone->cond) {
+	case BLK_ZONE_COND_EXP_OPEN:
+	case BLK_ZONE_COND_IMP_OPEN:
+	case BLK_ZONE_COND_CLOSED:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int zloop_record_safe_wps(struct zloop_device *zlo)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < zlo->nr_zones; i++) {
+		struct zloop_zone *zone = &zlo->zones[i];
+		struct file *file = zone->file;
+
+		if (!zloop_zone_is_active(zone))
+			continue;
+		ret = vfs_setxattr(file_mnt_idmap(file), file_dentry(file),
+				"user.zloop.wp", &zone->wp, sizeof(zone->wp), 0);
+		if (ret) {
+			pr_err("%pg: failed to record write pointer (%d)\n",
+				zlo->disk->part0, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Sync the entire FS containing the zone files instead of walking all files.
  */
@@ -558,6 +598,12 @@ static int zloop_flush(struct zloop_device *zlo)
 	struct super_block *sb = file_inode(zlo->data_dir)->i_sb;
 	int ret;
 
+	if (zlo->discard_write_cache) {
+		ret = zloop_record_safe_wps(zlo);
+		if (ret)
+			return ret;
+	}
+
 	down_read(&sb->s_umount);
 	ret = sync_filesystem(sb);
 	up_read(&sb->s_umount);
@@ -1054,6 +1100,7 @@ static int zloop_ctl_add(struct zloop_options *opts)
 	zlo->zone_append = opts->zone_append;
 	if (zlo->zone_append)
 		zlo->ordered_zone_append = opts->ordered_zone_append;
+	zlo->discard_write_cache = opts->discard_write_cache;
 
 	zlo->workqueue = alloc_workqueue("zloop%d", WQ_UNBOUND | WQ_FREEZABLE,
 				opts->nr_queues * opts->queue_depth, zlo->id);
@@ -1176,6 +1223,49 @@ static int zloop_ctl_add(struct zloop_options *opts)
 	return ret;
 }
 
+static void zloop_truncate(struct file *file, loff_t pos)
+{
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct dentry *dentry = file_dentry(file);
+	struct iattr newattrs;
+
+	newattrs.ia_size = pos;
+	newattrs.ia_valid = ATTR_SIZE;
+
+	inode_lock(dentry->d_inode);
+	notify_change(idmap, dentry, &newattrs, NULL);
+	inode_unlock(dentry->d_inode);
+}
+
+static void zloop_forget_cache(struct zloop_device *zlo)
+{
+	unsigned int i;
+	int ret;
+
+	pr_info("%pg: discarding volatile write cache\n", zlo->disk->part0);
+
+	for (i = 0; i < zlo->nr_zones; i++) {
+		struct zloop_zone *zone = &zlo->zones[i];
+		struct file *file = zone->file;
+		sector_t old_wp;
+
+		if (!zloop_zone_is_active(zone))
+			continue;
+
+		ret = vfs_getxattr(file_mnt_idmap(file), file_dentry(file),
+				"user.zloop.wp", &old_wp, sizeof(old_wp));
+		if (ret == -ENODATA) {
+			old_wp = 0;
+		} else if (ret != sizeof(old_wp)) {
+			pr_err("%pg: failed to retrieve write pointer (%d)\n",
+				zlo->disk->part0, ret);
+			continue;
+		}
+		if (old_wp < zone->wp)
+			zloop_truncate(file, old_wp);
+	}
+}
+
 static int zloop_ctl_remove(struct zloop_options *opts)
 {
 	struct zloop_device *zlo;
@@ -1210,6 +1300,10 @@ static int zloop_ctl_remove(struct zloop_options *opts)
 		return ret;
 
 	del_gendisk(zlo->disk);
+
+	if (zlo->discard_write_cache)
+		zloop_forget_cache(zlo);
+
 	put_disk(zlo->disk);
 
 	pr_info("Removed device %d\n", opts->id);
@@ -1361,6 +1455,9 @@ static int zloop_parse_options(struct zloop_options *opts, const char *buf)
 		case ZLOOP_OPT_ORDERED_ZONE_APPEND:
 			opts->ordered_zone_append = true;
 			break;
+		case ZLOOP_OPT_DISCARD_WRITE_CACHE:
+			opts->discard_write_cache = true;
+			break;
 		case ZLOOP_OPT_ERR:
 		default:
 			pr_warn("unknown parameter or missing value '%s'\n", p);
-- 
2.47.3

