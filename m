Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA57C8300B
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 11:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A6D207DD
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 11:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgD3LSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:18:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726413AbgD3LSF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 07:18:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UB2fhZ069832;
        Thu, 30 Apr 2020 07:18:01 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhc3gvdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 07:18:00 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UBGAwe011885;
        Thu, 30 Apr 2020 11:17:58 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 30mcu52kpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 11:17:58 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UBHt0h62652488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 11:17:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DC454C044;
        Thu, 30 Apr 2020 11:17:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 027C64C052;
        Thu, 30 Apr 2020 11:17:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Apr 2020 11:17:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id B40BFE02BB; Thu, 30 Apr 2020 13:17:54 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] s390/dasd: remove ioctl_by_bdev from DASD driver
Date:   Thu, 30 Apr 2020 13:17:54 +0200
Message-Id: <20200430111754.98508-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430111754.98508-1-sth@linux.ibm.com>
References: <20200430111754.98508-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_07:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004300087
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the calls to ioctl_by_bdev from the DASD partition detection code
to enable the removal of the specific code.

To do so reuse the gendisk private_data pointer and not only provide a
pointer to the devmap but provide a new structure containing a pointer
to the devmap as well as all required information for the partition
detection. This makes it independent from the dasd_information2_t
structure.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 block/partitions/ibm.c           | 67 ++++++++++++++++++--------------
 drivers/s390/block/dasd_devmap.c | 17 +++++++-
 drivers/s390/block/dasd_diag.c   | 10 +++++
 drivers/s390/block/dasd_eckd.c   | 10 +++++
 drivers/s390/block/dasd_fba.c    |  8 ++++
 drivers/s390/block/dasd_genhd.c  |  1 +
 drivers/s390/block/dasd_int.h    | 10 +++++
 7 files changed, 91 insertions(+), 32 deletions(-)

diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index 073faa6a69b8..da72a990418d 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -23,6 +23,15 @@ union label_t {
 	struct vtoc_cms_label cms;
 };
 
+struct dasd_gd_private {
+	void *devmap;
+	unsigned int cu_type;
+	unsigned int dev_type;
+	unsigned int label_block;
+	unsigned int format;
+	char type[4];
+};
+
 /*
  * compute the block number from a
  * cyl-cyl-head-head structure
@@ -61,7 +70,7 @@ static sector_t cchhb2blk(struct vtoc_cchhb *ptr, struct hd_geometry *geo)
 }
 
 static int find_label(struct parsed_partitions *state,
-		      dasd_information2_t *info,
+		      struct dasd_gd_private *gd_priv,
 		      struct hd_geometry *geo,
 		      int blocksize,
 		      sector_t *labelsect,
@@ -81,15 +90,16 @@ static int find_label(struct parsed_partitions *state,
 	 * - on an FBA disk it's block 1
 	 * - on an CMS formatted FBA disk it is sector 1, even if the block size
 	 *   is larger than 512 bytes (possible if the DIAG discipline is used)
-	 * If we have a valid info structure, then we know exactly which case we
-	 * have, otherwise we just search through all possebilities.
+	 * If we have a valid dasd_gd_private structure, then we know exactly
+	 * which case we have, otherwise we just search through all
+	 * possibilities.
 	 */
-	if (info) {
-		if ((info->cu_type == 0x6310 && info->dev_type == 0x9336) ||
-		    (info->cu_type == 0x3880 && info->dev_type == 0x3370))
-			testsect[0] = info->label_block;
+	if (gd_priv) {
+		if ((gd_priv->cu_type == 0x6310 && gd_priv->dev_type == 0x9336) ||
+		    (gd_priv->cu_type == 0x3880 && gd_priv->dev_type == 0x3370))
+			testsect[0] = gd_priv->label_block;
 		else
-			testsect[0] = info->label_block * (blocksize >> 9);
+			testsect[0] = gd_priv->label_block * (blocksize >> 9);
 		testcount = 1;
 	} else {
 		testsect[0] = 1;
@@ -198,7 +208,7 @@ static int find_lnx1_partitions(struct parsed_partitions *state,
 				union label_t *label,
 				sector_t labelsect,
 				loff_t i_size,
-				dasd_information2_t *info)
+				struct dasd_gd_private *gd_priv)
 {
 	loff_t offset, geo_size, size;
 	char tmp[64];
@@ -221,11 +231,11 @@ static int find_lnx1_partitions(struct parsed_partitions *state,
 			* geo->sectors * secperblk;
 		size = i_size >> 9;
 		if (size != geo_size) {
-			if (!info) {
+			if (!gd_priv) {
 				strlcat(state->pp_buf, "\n", PAGE_SIZE);
 				return 1;
 			}
-			if (!strcmp(info->type, "ECKD"))
+			if (!strcmp(gd_priv->type, "ECKD"))
 				if (geo_size < size)
 					size = geo_size;
 			/* else keep size based on i_size */
@@ -289,9 +299,10 @@ static int find_cms1_partitions(struct parsed_partitions *state,
 int ibm_partition(struct parsed_partitions *state)
 {
 	struct block_device *bdev = state->bdev;
+	struct dasd_gd_private *gd_priv = NULL;
+	struct gendisk *disk = bdev->bd_disk;
 	int blocksize, res;
 	loff_t i_size, offset, size;
-	dasd_information2_t *info;
 	struct hd_geometry *geo;
 	char type[5] = {0,};
 	char name[7] = {0,};
@@ -305,23 +316,21 @@ int ibm_partition(struct parsed_partitions *state)
 	i_size = i_size_read(bdev->bd_inode);
 	if (i_size == 0)
 		goto out_exit;
-	info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
-	if (info == NULL)
-		goto out_exit;
-	geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL);
+	geo = kzalloc(sizeof(struct hd_geometry), GFP_KERNEL);
 	if (geo == NULL)
-		goto out_nogeo;
+		goto out_exit;
 	label = kmalloc(sizeof(union label_t), GFP_KERNEL);
 	if (label == NULL)
 		goto out_nolab;
-	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
+	geo->start = get_start_sect(bdev);
+	if (!disk->fops->getgeo || disk->fops->getgeo(bdev, geo))
 		goto out_freeall;
-	if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0) {
-		kfree(info);
-		info = NULL;
-	}
 
-	if (find_label(state, info, geo, blocksize, &labelsect, name, type,
+	/* gd_priv pointer is only valid for DASD devices */
+	if (disk && disk->major == DASD_MAJOR)
+		gd_priv = disk->private_data;
+
+	if (find_label(state, gd_priv, geo, blocksize, &labelsect, name, type,
 		       label)) {
 		if (!strncmp(type, "VOL1", 4)) {
 			res = find_vol1_partitions(state, geo, blocksize, name,
@@ -329,24 +338,24 @@ int ibm_partition(struct parsed_partitions *state)
 		} else if (!strncmp(type, "LNX1", 4)) {
 			res = find_lnx1_partitions(state, geo, blocksize, name,
 						   label, labelsect, i_size,
-						   info);
+						   gd_priv);
 		} else if (!strncmp(type, "CMS1", 4)) {
 			res = find_cms1_partitions(state, geo, blocksize, name,
 						   label, labelsect);
 		}
-	} else if (info) {
+	} else if (gd_priv) {
 		/*
 		 * ugly but needed for backward compatibility:
-		 * If the block device is a DASD (i.e. BIODASDINFO2 works),
+		 * If the block device is a DASD (i.e. valid gd_priv),
 		 * then we claim it in any case, even though it has no valid
 		 * label. If it has the LDL format, then we simply define a
 		 * partition as if it had an LNX1 label.
 		 */
 		res = 1;
-		if (info->format == DASD_FORMAT_LDL) {
+		if (gd_priv->format == DASD_FORMAT_LDL) {
 			strlcat(state->pp_buf, "(nonl)", PAGE_SIZE);
 			size = i_size >> 9;
-			offset = (info->label_block + 1) * (blocksize >> 9);
+			offset = (gd_priv->label_block + 1) * (blocksize >> 9);
 			put_partition(state, 1, offset, size-offset);
 			strlcat(state->pp_buf, "\n", PAGE_SIZE);
 		}
@@ -357,8 +366,6 @@ int ibm_partition(struct parsed_partitions *state)
 	kfree(label);
 out_nolab:
 	kfree(geo);
-out_nogeo:
-	kfree(info);
 out_exit:
 	return res;
 }
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 32fc51341d99..63e48bf9cadc 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -677,18 +677,30 @@ dasd_device_from_cdev(struct ccw_device *cdev)
 
 void dasd_add_link_to_gendisk(struct gendisk *gdp, struct dasd_device *device)
 {
+	struct dasd_gd_private *gd_priv;
 	struct dasd_devmap *devmap;
+	struct ccw_device *cdev;
 
+	gd_priv = kzalloc(sizeof(struct dasd_gd_private), GFP_KERNEL);
+	if (!gd_priv)
+		return;
 	devmap = dasd_find_busid(dev_name(&device->cdev->dev));
 	if (IS_ERR(devmap))
 		return;
+	cdev = device->cdev;
 	spin_lock(&dasd_devmap_lock);
-	gdp->private_data = devmap;
+	gd_priv->devmap = devmap;
+	gd_priv->cu_type = cdev->id.cu_type;
+	gd_priv->dev_type = cdev->id.dev_type;
+	memcpy(gd_priv->type, device->discipline->name, sizeof(gd_priv->type));
+	device->discipline->fill_gd_priv(gd_priv, device);
+	gdp->private_data = gd_priv;
 	spin_unlock(&dasd_devmap_lock);
 }
 
 struct dasd_device *dasd_device_from_gendisk(struct gendisk *gdp)
 {
+	struct dasd_gd_private *gd_priv;
 	struct dasd_device *device;
 	struct dasd_devmap *devmap;
 
@@ -696,7 +708,8 @@ struct dasd_device *dasd_device_from_gendisk(struct gendisk *gdp)
 		return NULL;
 	device = NULL;
 	spin_lock(&dasd_devmap_lock);
-	devmap = gdp->private_data;
+	gd_priv = gdp->private_data;
+	devmap = gd_priv->devmap;
 	if (devmap && devmap->device) {
 		device = devmap->device;
 		dasd_get_device(device);
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index facb588d09e4..38d20744df26 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -607,6 +607,15 @@ dasd_diag_fill_info(struct dasd_device * device,
 	return 0;
 }
 
+static void dasd_diag_fill_gd_priv(struct dasd_gd_private *gd_priv,
+				   struct dasd_device *device)
+{
+	struct dasd_diag_private *private = device->private;
+
+	gd_priv->label_block = (unsigned int) private->pt_block;
+	gd_priv->format = DASD_FORMAT_LDL;
+}
+
 static void
 dasd_diag_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		     struct irb *stat)
@@ -652,6 +661,7 @@ static struct dasd_discipline dasd_diag_discipline = {
 	.free_cp = dasd_diag_free_cp,
 	.dump_sense = dasd_diag_dump_sense,
 	.fill_info = dasd_diag_fill_info,
+	.fill_gd_priv = dasd_diag_fill_gd_priv,
 };
 
 static int __init
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index ad44d22e8859..edaa7d1577a9 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4901,6 +4901,15 @@ dasd_eckd_fill_info(struct dasd_device * device,
 	return 0;
 }
 
+static void dasd_eckd_fill_gd_priv(struct dasd_gd_private *gd_priv,
+				  struct dasd_device *device)
+{
+	struct dasd_eckd_private *private = device->private;
+
+	gd_priv->label_block = 2;
+	gd_priv->format = private->uses_cdl ? DASD_FORMAT_CDL : DASD_FORMAT_LDL;
+}
+
 /*
  * SECTION: ioctl functions for eckd devices.
  */
@@ -6727,6 +6736,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.ext_pool_exhaust = dasd_eckd_ext_pool_exhaust,
 	.ese_format = dasd_eckd_ese_format,
 	.ese_read = dasd_eckd_ese_read,
+	.fill_gd_priv = dasd_eckd_fill_gd_priv,
 };
 
 static int __init
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index cbb770824226..6abbffdffb5f 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -642,6 +642,13 @@ dasd_fba_fill_info(struct dasd_device * device,
 	return 0;
 }
 
+static void dasd_fba_fill_gd_priv(struct dasd_gd_private *gd_priv,
+				   struct dasd_device *device)
+{
+	gd_priv->label_block = 1;
+	gd_priv->format = DASD_FORMAT_LDL;
+}
+
 static void
 dasd_fba_dump_sense_dbf(struct dasd_device *device, struct irb *irb,
 			char *reason)
@@ -822,6 +829,7 @@ static struct dasd_discipline dasd_fba_discipline = {
 	.dump_sense = dasd_fba_dump_sense,
 	.dump_sense_dbf = dasd_fba_dump_sense_dbf,
 	.fill_info = dasd_fba_fill_info,
+	.fill_gd_priv = dasd_fba_fill_gd_priv,
 };
 
 static int __init
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index af5b0ecb8f89..d6ef85936526 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -87,6 +87,7 @@ void dasd_gendisk_free(struct dasd_block *block)
 {
 	if (block->gdp) {
 		del_gendisk(block->gdp);
+		kfree(block->gdp->private_data);
 		block->gdp->private_data = NULL;
 		put_disk(block->gdp);
 		block->gdp = NULL;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index fa552f9f1666..31d12a62b28b 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -259,6 +259,15 @@ struct dasd_uid {
 	char vduit[33];
 };
 
+struct dasd_gd_private {
+	struct dasd_devmap *devmap;
+	unsigned int cu_type;
+	unsigned int dev_type;
+	unsigned int label_block;
+	unsigned int format;
+	char type[4];
+};
+
 /*
  * the struct dasd_discipline is
  * sth like a table of virtual functions, if you think of dasd_eckd
@@ -391,6 +400,7 @@ struct dasd_discipline {
 	struct dasd_ccw_req *(*ese_format)(struct dasd_device *,
 					   struct dasd_ccw_req *, struct irb *);
 	int (*ese_read)(struct dasd_ccw_req *, struct irb *);
+	void (*fill_gd_priv)(struct dasd_gd_private *, struct dasd_device *);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
-- 
2.17.1

