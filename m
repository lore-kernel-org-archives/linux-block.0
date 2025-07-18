Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1218E20
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866865; cv=none; b=JdkjuJ3a0bUB9Vb6jIhQ5ChMO8Z59GdGwaD229u8JG9h+GMzDRWKoNUCSm7r8uj6LGIHIapqFtiSP89Usl1JmiB7Dk5u+Gu5qgVqVEhLQq2CvjYgyuQ0XXjafqmA5H7ZdbUPKSDXWC33zgTN+r956Eje2TZsESBqKYbvFH11APM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866865; c=relaxed/simple;
	bh=VgDFMe8hCuagg6/Wd6idGTtYRb9fgAPgSHhM/241Dyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4mze6FVXuQRiJnOygqNbl4qz6A6VYtAdKPwFrGplLVubOJRYYOR/7xcip+k2qrjUzGDfNIfG8T6CYBR6LtiZ0b6wWTwJr/ssvTL0u/xnU68sUCCobTgui++ZowrMjYFWotwSJ/tYjho2bphI2kD0q8ovgBwDWrwPdW1Otfd0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o3CrCEdq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o3CrCEdq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EvqBpoLmsLSyz4NmKIamQ+zo2ShkF+jwV3xDJuugUmE=; b=o3CrCEdqP7CkELGP7222UV0TEB
	F/IxpB8IifeXphusnrcriEnkE/cd1cF9ZlG0xFGO+lX7nQA3xKl13472N/qG6HuhGRJ0Z94dfX9RM
	eb933+RHWhEhBwmb+1KPX8NsSEoQcX7BhaAbl4pjO3Sxo5hI3JZbvnyq4OPlKBVP7GlKReJTzDdmY
	RuqKFK5dwy/9GJgLG4AIQwN42sn2M4XaoMArAB0Q64qrHQRBeRsoia/4adO2t3nhw04NWwuWg78G2
	0ictB70jSxwzAEZCaPYh+pqPW1OZw9tCw2tK0xJ/FuDeYZ1JkQ9d4iYZeeqldqhxrZU/ZHBQk4jub
	8vgS5HqQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucqk9-0000000DYbU-0S52;
	Fri, 18 Jul 2025 19:27:41 +0000
Date: Fri, 18 Jul 2025 20:27:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Subject: [RFC][PATCH 1/3] scsi: switch scsi_bios_ptable() and scsi_partsize()
 to gendisk
Message-ID: <20250718192741.GF2580412@ZenIV>
References: <20250718192642.GE2580412@ZenIV>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718192642.GE2580412@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Both helpers are reading the partition table of the disk specified
by block_device of some partition on it; result depends only upon
the disk in question, so we might as well pass the struct gendisk
instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/scsi/scsi_mid_low_api.rst |  4 ++--
 drivers/scsi/BusLogic.c                 |  2 +-
 drivers/scsi/aacraid/linit.c            |  2 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c      |  2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.c      |  2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c        |  2 +-
 drivers/scsi/fdomain.c                  |  2 +-
 drivers/scsi/megaraid.c                 |  2 +-
 drivers/scsi/scsicam.c                  | 12 ++++++------
 include/scsi/scsicam.h                  |  5 +++--
 10 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/scsi_mid_low_api.rst
index 3ac4c7fafb55..96c8230d638e 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -380,7 +380,7 @@ Details::
 
     /**
     * scsi_bios_ptable - return copy of block device's partition table
-    * @dev:        pointer to block device
+    * @dev:        pointer to gendisk
     *
     *      Returns pointer to partition table, or NULL for failure
     *
@@ -390,7 +390,7 @@ Details::
     *
     *      Defined in: drivers/scsi/scsicam.c
     **/
-    unsigned char *scsi_bios_ptable(struct block_device *dev)
+    unsigned char *scsi_bios_ptable(struct gendisk *dev)
 
 
     /**
diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 1f100270cd38..743be2ef6d1a 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3261,7 +3261,7 @@ static int blogic_diskparam(struct scsi_device *sdev, struct block_device *dev,
 		diskparam->sectors = 32;
 	}
 	diskparam->cylinders = (unsigned long) capacity / (diskparam->heads * diskparam->sectors);
-	buf = scsi_bios_ptable(dev);
+	buf = scsi_bios_ptable(dev->bd_disk);
 	if (buf == NULL)
 		return 0;
 	/*
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 4b12e6dd8f07..2264a97d91a0 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -324,7 +324,7 @@ static int aac_biosparm(struct scsi_device *sdev, struct block_device *bdev,
 	 *	entry whose end_head matches one of the standard geometry
 	 *	translations ( 64/32, 128/32, 255/63 ).
 	 */
-	buf = scsi_bios_ptable(bdev);
+	buf = scsi_bios_ptable(bdev->bd_disk);
 	if (!buf)
 		return 0;
 	if (*(__le16 *)(buf + 0x40) == cpu_to_le16(MSDOS_LABEL_MAGIC)) {
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 17dfc3c72110..2cff19e95fec 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -731,7 +731,7 @@ ahd_linux_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 
 	ahd = *((struct ahd_softc **)sdev->host->hostdata);
 
-	if (scsi_partsize(bdev, capacity, geom))
+	if (scsi_partsize(bdev->bd_disk, capacity, geom))
 		return 0;
 
 	heads = 64;
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index cebf8c5d0caf..05bdb73d1157 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -696,7 +696,7 @@ ahc_linux_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 	ahc = *((struct ahc_softc **)sdev->host->hostdata);
 	channel = sdev_channel(sdev);
 
-	if (scsi_partsize(bdev, capacity, geom))
+	if (scsi_partsize(bdev->bd_disk, capacity, geom))
 		return 0;
 
 	heads = 64;
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index fb57343a97bd..6968da9fb67c 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -381,7 +381,7 @@ static int arcmsr_bios_param(struct scsi_device *sdev,
 {
 	int heads, sectors, cylinders, total_capacity;
 
-	if (scsi_partsize(bdev, capacity, geom))
+	if (scsi_partsize(bdev->bd_disk, capacity, geom))
 		return 0;
 
 	total_capacity = capacity;
diff --git a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
index 504c4e0c5d17..4a3716dc644c 100644
--- a/drivers/scsi/fdomain.c
+++ b/drivers/scsi/fdomain.c
@@ -472,7 +472,7 @@ static int fdomain_biosparam(struct scsi_device *sdev,
 			     struct block_device *bdev,	sector_t capacity,
 			     int geom[])
 {
-	unsigned char *p = scsi_bios_ptable(bdev);
+	unsigned char *p = scsi_bios_ptable(bdev->bd_disk);
 
 	if (p && p[65] == 0xaa && p[64] == 0x55 /* Partition table valid */
 	    && p[4]) {	 /* Partition type */
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 2006094af418..c7581c7829af 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -2813,7 +2813,7 @@ megaraid_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 			geom[2] = cylinders;
 	}
 	else {
-		if (scsi_partsize(bdev, capacity, geom))
+		if (scsi_partsize(bdev->bd_disk, capacity, geom))
 			return 0;
 
 		dev_info(&adapter->dev->dev,
diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index 19e6c3852d50..3ff2cf51d5b0 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -30,9 +30,9 @@
  *              starting at offset %0x1be.
  * Returns: partition table in kmalloc(GFP_KERNEL) memory, or NULL on error.
  */
-unsigned char *scsi_bios_ptable(struct block_device *dev)
+unsigned char *scsi_bios_ptable(struct gendisk *dev)
 {
-	struct address_space *mapping = bdev_whole(dev)->bd_mapping;
+	struct address_space *mapping = dev->part0->bd_mapping;
 	unsigned char *res = NULL;
 	struct folio *folio;
 
@@ -48,7 +48,7 @@ EXPORT_SYMBOL(scsi_bios_ptable);
 
 /**
  * scsi_partsize - Parse cylinders/heads/sectors from PC partition table
- * @bdev: block device to parse
+ * @disk: gendisk of the disk to parse
  * @capacity: size of the disk in sectors
  * @geom: output in form of [hds, cylinders, sectors]
  *
@@ -57,7 +57,7 @@ EXPORT_SYMBOL(scsi_bios_ptable);
  *
  * Returns: %false on failure, %true on success.
  */
-bool scsi_partsize(struct block_device *bdev, sector_t capacity, int geom[3])
+bool scsi_partsize(struct gendisk *disk, sector_t capacity, int geom[3])
 {
 	int cyl, ext_cyl, end_head, end_cyl, end_sector;
 	unsigned int logical_end, physical_end, ext_physical_end;
@@ -65,7 +65,7 @@ bool scsi_partsize(struct block_device *bdev, sector_t capacity, int geom[3])
 	void *buf;
 	int ret = false;
 
-	buf = scsi_bios_ptable(bdev);
+	buf = scsi_bios_ptable(disk);
 	if (!buf)
 		return false;
 
@@ -221,7 +221,7 @@ int scsicam_bios_param(struct block_device *bdev, sector_t capacity, int *ip)
 	int ret = 0;
 
 	/* try to infer mapping from partition table */
-	if (scsi_partsize(bdev, capacity, ip))
+	if (scsi_partsize(bdev->bd_disk, capacity, ip))
 		return 0;
 
 	if (capacity64 < (1ULL << 32)) {
diff --git a/include/scsi/scsicam.h b/include/scsi/scsicam.h
index 08edd603e521..67f4e8835bc8 100644
--- a/include/scsi/scsicam.h
+++ b/include/scsi/scsicam.h
@@ -13,7 +13,8 @@
 
 #ifndef SCSICAM_H
 #define SCSICAM_H
+struct gendisk;
 int scsicam_bios_param(struct block_device *bdev, sector_t capacity, int *ip);
-bool scsi_partsize(struct block_device *bdev, sector_t capacity, int geom[3]);
-unsigned char *scsi_bios_ptable(struct block_device *bdev);
+bool scsi_partsize(struct gendisk *disk, sector_t capacity, int geom[3]);
+unsigned char *scsi_bios_ptable(struct gendisk *disk);
 #endif /* def SCSICAM_H */
-- 
2.39.5

