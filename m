Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D4EC00523
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 07:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0071206DB
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 07:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgAHHMp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:12:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41190 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgAHHMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 02:12:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00878uAE156017;
        Wed, 8 Jan 2020 07:12:37 GMT
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xakbqsxkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 07:12:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00874I81057394;
        Wed, 8 Jan 2020 07:12:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xcpap8b1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 07:12:36 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0087CY6X003733;
        Wed, 8 Jan 2020 07:12:34 GMT
Received: from localhost.localdomain (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 23:12:33 -0800
From:   Nobody <Nobody@nobody.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, snitzer@redhat.com,
        dmitry.fomichev@wdc.com, martin.petersen@oracle.com,
        shirley.ma@oracle.com, Bob Liu <bob.liu@oracle.com>
Subject: [RFC PATCH] dm-zoned: extend the way of exposing zoned block device
Date:   Wed,  8 Jan 2020 15:12:12 +0800
Message-Id: <20200108071212.27230-1-Nobody@nobody.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=906
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=962 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080061
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bob Liu <bob.liu@oracle.com>

Motivation:
Now the dm-zoned device mapper target exposes a zoned block device(ZBC) as a
regular block device by storing metadata and buffering random writes in
conventional zones.
This way is not very flexible, there must be enough conventional zones and the
performance may be constrained.
By putting metadata(also buffering random writes) in separated device we can get
more flexibility and potential performance improvement e.g by storing metadata
in faster device like persistent memory.

This patch try to split the metadata of dm-zoned to an extra block
device instead of zoned block device itself.
(Buffering random writes also in the todo list.)

Patch is at the very early stage, just want to receive some feedback about
this extension.
Another option is to create an new md-zoned device with separated metadata
device based on md framework.

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 drivers/md/dm-zoned-metadata.c |  6 +++---
 drivers/md/dm-zoned-target.c   | 15 +++++++++++++--
 drivers/md/dm-zoned.h          |  1 +
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 22b3cb0..89cd554 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -439,7 +439,7 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
 
 	/* Submit read BIO */
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, zmd->dev->bdev);
+	bio_set_dev(bio, zmd->dev->meta_bdev);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
 	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META | REQ_PRIO);
@@ -593,7 +593,7 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
 	set_bit(DMZ_META_WRITING, &mblk->state);
 
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, zmd->dev->bdev);
+	bio_set_dev(bio, zmd->dev->meta_bdev);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
 	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_META | REQ_PRIO);
@@ -620,7 +620,7 @@ static int dmz_rdwr_block(struct dmz_metadata *zmd, int op, sector_t block,
 		return -ENOMEM;
 
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, zmd->dev->bdev);
+	bio_set_dev(bio, zmd->dev->meta_bdev);
 	bio_set_op_attrs(bio, op, REQ_SYNC | REQ_META | REQ_PRIO);
 	bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
 	ret = submit_bio_wait(bio);
diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 70a1063..55c64fe 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -39,6 +39,7 @@ struct dm_chunk_work {
  */
 struct dmz_target {
 	struct dm_dev		*ddev;
+	struct dm_dev           *metadata_dev;
 
 	unsigned long		flags;
 
@@ -701,6 +702,7 @@ static int dmz_get_zoned_device(struct dm_target *ti, char *path)
 		goto err;
 	}
 
+	dev->meta_bdev = dmz->metadata_dev->bdev;
 	dev->bdev = dmz->ddev->bdev;
 	(void)bdevname(dev->bdev, dev->name);
 
@@ -761,7 +763,7 @@ static int dmz_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	int ret;
 
 	/* Check arguments */
-	if (argc != 1) {
+	if (argc != 2) {
 		ti->error = "Invalid argument count";
 		return -EINVAL;
 	}
@@ -774,8 +776,16 @@ static int dmz_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 	ti->private = dmz;
 
+	/* Get the metadata block device */
+	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
+			&dmz->metadata_dev);
+	if (ret) {
+		dmz->metadata_dev = NULL;
+		goto err;
+	}
+
 	/* Get the target zoned block device */
-	ret = dmz_get_zoned_device(ti, argv[0]);
+	ret = dmz_get_zoned_device(ti, argv[1]);
 	if (ret) {
 		dmz->ddev = NULL;
 		goto err;
@@ -856,6 +866,7 @@ static int dmz_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 err_dev:
 	dmz_put_zoned_device(ti);
 err:
+	dm_put_device(ti, dmz->metadata_dev);
 	kfree(dmz);
 
 	return ret;
diff --git a/drivers/md/dm-zoned.h b/drivers/md/dm-zoned.h
index 5b5e493..e789ff5 100644
--- a/drivers/md/dm-zoned.h
+++ b/drivers/md/dm-zoned.h
@@ -50,6 +50,7 @@
  */
 struct dmz_dev {
 	struct block_device	*bdev;
+	struct block_device     *meta_bdev;
 
 	char			name[BDEVNAME_SIZE];
 
-- 
2.9.5

