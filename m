Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9959A334685;
	Mon, 16 Mar 2026 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701043; cv=none; b=CiaMTEClsFu0gmsiZAPDyxXeNqT1JeX14ZF4Bm40kxL38gojCXPX5qbYa3iGwf/p162lpZN5k0lmSQAQ/lhu8mNL1/lrOW/pt+btSXrf/FiReioDUVy4ymB4IhtZZBVaEMyu96ihpz47UGJvyrneUb0V8yspLjgS6tirzQjHKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701043; c=relaxed/simple;
	bh=rK99xjO97vLlnrpiCCJhU6xQmBcRpnOCdghKR35r3nE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Md78TLOGDKFxNnVQL6oI+Suh8KcOorjCBJoMAUBnpcLxI/BY8+qX3974cv15ntYzE1AoOIKtAHeAWYorHkCu46V/j+nNFWCIBPSdiPhqIcC/cFocjWdfxJfz2vMWnj8YzwVkP/2qIo+dEsNq0qJnVbVHpbeQrvTO8fecr8fTj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jeCWjYeP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jeCWjYeP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773701039;
	bh=rK99xjO97vLlnrpiCCJhU6xQmBcRpnOCdghKR35r3nE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jeCWjYePIETn8H4N0kboCT+HaNDfp0+pbwyJN3lQhOr2wWtB0G3c/V0XAxFWBw/Yj
	 IwzG+VKLQ4mpBk0RHCFDWfwcuAS9UkC9GBzaAZeSS0wy+N1dxdlkzDCqkACnB6gkg6
	 cZDsNv4pZ9sFMyfYoZViWwnuAA30cZe+nDQkTIco=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Mar 2026 23:43:51 +0100
Subject: [PATCH 1/4] block: make queue_sysfs_entry instances const
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260316-b4-sysfs-const-attr-block-v1-1-a35d73b986b0@weissschuh.net>
References: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
In-Reply-To: <20260316-b4-sysfs-const-attr-block-v1-0-a35d73b986b0@weissschuh.net>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773701039; l=4661;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rK99xjO97vLlnrpiCCJhU6xQmBcRpnOCdghKR35r3nE=;
 b=xqBiSVWU++aCYkyesbQyB4lWAycwnX/oKIU6sueT5af+NBFBl7bGXDn6b2yH9kLM2x6AkIiFQ
 nqF0E/EvJumD0ERSxNg/ZSgioAtu0NZ9AHTFD7kWfXCPzqmmC44iAZY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The queue_sysfs_entry structures are never modified, mark them as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/blk-sysfs.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 878b8a4b55bb..f22c1f253eb3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -581,27 +581,27 @@ static int queue_wc_store(struct gendisk *disk, const char *page,
 	return 0;
 }
 
-#define QUEUE_RO_ENTRY(_prefix, _name)			\
-static struct queue_sysfs_entry _prefix##_entry = {	\
-	.attr	= { .name = _name, .mode = 0444 },	\
-	.show	= _prefix##_show,			\
+#define QUEUE_RO_ENTRY(_prefix, _name)				\
+static const struct queue_sysfs_entry _prefix##_entry = {	\
+	.attr	= { .name = _name, .mode = 0444 },		\
+	.show	= _prefix##_show,				\
 };
 
-#define QUEUE_RW_ENTRY(_prefix, _name)			\
-static struct queue_sysfs_entry _prefix##_entry = {	\
-	.attr	= { .name = _name, .mode = 0644 },	\
-	.show	= _prefix##_show,			\
-	.store	= _prefix##_store,			\
+#define QUEUE_RW_ENTRY(_prefix, _name)				\
+static const struct queue_sysfs_entry _prefix##_entry = {	\
+	.attr	= { .name = _name, .mode = 0644 },		\
+	.show	= _prefix##_show,				\
+	.store	= _prefix##_store,				\
 };
 
 #define QUEUE_LIM_RO_ENTRY(_prefix, _name)			\
-static struct queue_sysfs_entry _prefix##_entry = {	\
+static const struct queue_sysfs_entry _prefix##_entry = {	\
 	.attr		= { .name = _name, .mode = 0444 },	\
 	.show_limit	= _prefix##_show,			\
 }
 
 #define QUEUE_LIM_RW_ENTRY(_prefix, _name)			\
-static struct queue_sysfs_entry _prefix##_entry = {	\
+static const struct queue_sysfs_entry _prefix##_entry = {	\
 	.attr		= { .name = _name, .mode = 0644 },	\
 	.show_limit	= _prefix##_show,			\
 	.store_limit	= _prefix##_store,			\
@@ -665,7 +665,7 @@ QUEUE_LIM_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
 QUEUE_LIM_RO_ENTRY(queue_dma_alignment, "dma_alignment");
 
 /* legacy alias for logical_block_size: */
-static struct queue_sysfs_entry queue_hw_sector_size_entry = {
+static const struct queue_sysfs_entry queue_hw_sector_size_entry = {
 	.attr		= {.name = "hw_sector_size", .mode = 0444 },
 	.show_limit	= queue_logical_block_size_show,
 };
@@ -731,7 +731,7 @@ QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 #endif
 
 /* Common attributes for bio-based and request-based queues. */
-static struct attribute *queue_attrs[] = {
+static const struct attribute *const queue_attrs[] = {
 	/*
 	 * Attributes which are protected with q->limits_lock.
 	 */
@@ -791,7 +791,7 @@ static struct attribute *queue_attrs[] = {
 };
 
 /* Request-based queue attributes that are not relevant for bio-based queues. */
-static struct attribute *blk_mq_queue_attrs[] = {
+static const struct attribute *const blk_mq_queue_attrs[] = {
 	/*
 	 * Attributes which require some form of locking other than
 	 * q->sysfs_lock.
@@ -811,7 +811,7 @@ static struct attribute *blk_mq_queue_attrs[] = {
 	NULL,
 };
 
-static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
+static umode_t queue_attr_visible(struct kobject *kobj, const struct attribute *attr,
 				int n)
 {
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
@@ -827,7 +827,7 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
 }
 
 static umode_t blk_mq_queue_attr_visible(struct kobject *kobj,
-					 struct attribute *attr, int n)
+					 const struct attribute *attr, int n)
 {
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	struct request_queue *q = disk->queue;
@@ -841,17 +841,17 @@ static umode_t blk_mq_queue_attr_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-static struct attribute_group queue_attr_group = {
-	.attrs = queue_attrs,
-	.is_visible = queue_attr_visible,
+static const struct attribute_group queue_attr_group = {
+	.attrs_const = queue_attrs,
+	.is_visible_const = queue_attr_visible,
 };
 
-static struct attribute_group blk_mq_queue_attr_group = {
-	.attrs = blk_mq_queue_attrs,
-	.is_visible = blk_mq_queue_attr_visible,
+static const struct attribute_group blk_mq_queue_attr_group = {
+	.attrs_const = blk_mq_queue_attrs,
+	.is_visible_const = blk_mq_queue_attr_visible,
 };
 
-#define to_queue(atr) container_of((atr), struct queue_sysfs_entry, attr)
+#define to_queue(atr) container_of_const((atr), struct queue_sysfs_entry, attr)
 
 static ssize_t
 queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)

-- 
2.53.0

