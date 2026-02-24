Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690B339B4AF
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942915; cv=none; b=cMXcCoNhDrUwDwD9/9bgZHKqzSvWTCyUhlbFPs8aENXm1LAAN0gMuMNtX9Fug6pfsF5YtfZoiq3MXU6AgwzDLSLPnD9/797bdj/6dm5o65JfyoYAMOsIolyq4oiCG22sLvc7k6M8jDwGfNRFiwMiTltpb2ndp8jqjOeEBTq57VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942915; c=relaxed/simple;
	bh=C8UM3qXS+S3yvj9paaagf0byFJ0yQhYGGxMN2ig9pkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBFCvHWEBvpg8FmUQWn6xB9C1pFoUwoQsI+ZdgwL27Fh3697gUItloaKPVjw3aoFEDKM0EdIh7HHF6pl7zoiIA1BjfLCJLFPk+YCB65XVdXSUbAy6wxtuMvHjgBQTSslBUApjEtgsY+Bg2DiArU1pNZU60GOcNgyHS1CjVYr/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zKKJP6VL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zKKJP6VL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jttcMM+DmweCliLu8keNUjA/kfrtoIkY4XI7DVtil7s=; b=zKKJP6VLr66oPWiAUJ1YUGULhJ
	9tH+ZyVel96W24/QVksdflRnsAsbn49VUfj9cmIldPebbuLjwjKYIq9VnJmqG/xfS59tuqFEPkvv9
	ZOeIoQoGXALT73J4BLsZhml9nmK/BvtWBJT2jzzF9+VcYJDrtGDVvnu8G5nxdkh6HPnp4+HNywqE0
	9noPrqPNF5eGKKX6ZoXjGUxcm71bRJJM5g5kpzQwahfzr/xFqYk5xZg3aCEpfakEi0vrPjbfLWX7k
	odHkh7j0ColWkZ1vY7/UbKJP1RxDr6uDv+ICslOJRCUxMi5qkJ/qhHWycG0PjuaAv/LdMpjA0D5cn
	GvlAwCBA==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutIQ-00000002CXG-0Af5;
	Tue, 24 Feb 2026 14:21:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] zloop: advertise a volatile write cache
Date: Tue, 24 Feb 2026 06:21:44 -0800
Message-ID: <20260224142153.368472-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224142153.368472-1-hch@lst.de>
References: <20260224142153.368472-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Zloop is file system backed and thus needs to sync the underlying file
system to persist data.  Set BLK_FEAT_WRITE_CACHE so that the block
layer actually send flush commands, and fix the flush implementation
as sync_filesystem requires s_umount to be held and the code currently
misses that.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 65a40266437c..56e54d9791f1 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -542,6 +542,21 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	zloop_put_cmd(cmd);
 }
 
+/*
+ * Sync the entire FS containing the zone files instead of walking all files.
+ */
+static int zloop_flush(struct zloop_device *zlo)
+{
+	struct super_block *sb = file_inode(zlo->data_dir)->i_sb;
+	int ret;
+
+	down_read(&sb->s_umount);
+	ret = sync_filesystem(sb);
+	up_read(&sb->s_umount);
+
+	return ret;
+}
+
 static void zloop_handle_cmd(struct zloop_cmd *cmd)
 {
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
@@ -562,11 +577,7 @@ static void zloop_handle_cmd(struct zloop_cmd *cmd)
 		zloop_rw(cmd);
 		return;
 	case REQ_OP_FLUSH:
-		/*
-		 * Sync the entire FS containing the zone files instead of
-		 * walking all files
-		 */
-		cmd->ret = sync_filesystem(file_inode(zlo->data_dir)->i_sb);
+		cmd->ret = zloop_flush(zlo);
 		break;
 	case REQ_OP_ZONE_RESET:
 		cmd->ret = zloop_reset_zone(zlo, rq_zone_no(rq));
@@ -981,7 +992,8 @@ static int zloop_ctl_add(struct zloop_options *opts)
 	struct queue_limits lim = {
 		.max_hw_sectors		= SZ_1M >> SECTOR_SHIFT,
 		.chunk_sectors		= opts->zone_size,
-		.features		= BLK_FEAT_ZONED,
+		.features		= BLK_FEAT_ZONED | BLK_FEAT_WRITE_CACHE,
+
 	};
 	unsigned int nr_zones, i, j;
 	struct zloop_device *zlo;
-- 
2.47.3

