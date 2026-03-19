Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDEC1A9F86
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900181; cv=none; b=VMa8mtbZclbP3iTA2xpFqeS2M5ULbmdtN7vQq4GS5+fznXsyufwKzCMSa2fvUA5JAIuyC9G7uzm4c/OiBuHVnH9jghdBYyGx5NrMQkbVOPltIpe6VbRTGRrZh+ehjDuB8/03CAKYPEcJnosjELdG6d4+n1QzKNgSG+RmxgfQHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900181; c=relaxed/simple;
	bh=oesATi0hoNCHfqADaeauW0v8uGywVVtixUtBK1h1YtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwPs3amQOna4IqST0qx7Yf5RZ6qpvQQNjNNclMMVqSDvJ5LRfpnvBrmytT8dIHWDTMLDtMmYadL95z9v8ptc5gWD5RCFZaUDEEs735iC0dwqqiSDuQDXOZqo0Ri2XbmkMRqdkGUoYhBxw1Qpq9WRjoZXfzIJ00WlfCjL+4gsPYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TArtx8xu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TArtx8xu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=beBN8XBni5olKgvrQ1Huj3KymMFEXX4UQaXQ5e/UdUY=; b=TArtx8xukUCsV3b8M1rp8l3jrL
	HM3LU8IzS+nQYYdy74mGd5tPBF8vet8FKnMN/TYbhEO0LAFd9/pDAn5A7stZTsSvHb0RCLnFD2M6h
	eOhESNjjNAOF4vzq6szVKt/pHXa7lSXm39aNAI2LmdPuEIDQQwkOEwhfqL4dk1cFA4pAhfslwvi6s
	e0UaYd+wNg2CcpvIh7eyc9T0exFPvkOQ/yCI9SLMy2yYmSx+ExdYpTfyBkNkz/my69BqWCt+wJ4cB
	iXdLPMnaltDwK+M2nyScJV78n/DWE31tQy6G4wrzKs2FESXqg6/SdeoME0w8W38c+1FfBPqYYhhuN
	pUlIpDxA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w36TB-00000009yUQ-2j8M;
	Thu, 19 Mar 2026 06:02:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] zloop: forget write cache on force removal
Date: Thu, 19 Mar 2026 07:02:37 +0100
Message-ID: <20260319060246.2084931-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319060246.2084931-1-hch@lst.de>
References: <20260319060246.2084931-1-hch@lst.de>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 .../admin-guide/blockdev/zoned_loop.rst       |  5 +
 drivers/block/zloop.c                         | 97 +++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
index 6aa865424ac3..e72e56a9e772 100644
--- a/Documentation/admin-guide/blockdev/zoned_loop.rst
+++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
@@ -104,6 +104,11 @@ ordered_zone_append   Enable zloop mitigation of zone append reordering.
                       (extents), as when enabled, this can significantly reduce
                       the number of data extents needed to for a file data
                       mapping.
+discard_write_cache   Discard all data that was not explicitly persisted using a
+                      flush operation when the devie is removed by truncating
+                      each zone file to the size recorded during the last flush
+                      operation. This simulates power fail events where
+                      uncommitted data is lost.
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

