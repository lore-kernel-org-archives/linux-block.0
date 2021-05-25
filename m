Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D3AC2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140186141F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhEYC1S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 22:27:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34067 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhEYC1S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 22:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621909548; x=1653445548;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=shPpSeP296J2qygw6NO0KVC+guYs/L89/b5ZZys6J5g=;
  b=TxAGcljnegS3k47tWU2tWJYph7I70ow//e6rfwRjVdtDSSIFmqysmPrc
   Zhkl6Ic3Mw8JPo+tSzp/VDW7Jcye+EOUy5QormqltlfJBdEimH+dhb7TD
   xex+4lFEQ+TBhrDhXzpZ9RCxKyreKB6unnC0vrQot/ZJp52FmOu2abZJW
   W7AqOE1rgEuAPSD814r6ijyp+TQPh+lcl4JZ59rYhQDI1H15LnKilusrt
   QrOs+hsq639HfxOu8/RKf0qCAFt2YZ/X7HObLPbh4exYleAmftb+xiBNX
   F0AqAWrawJxO4isAz5vwwabbdPRQQMauEClBOTDImfiZrppPoTy0rpL2H
   g==;
IronPort-SDR: 7XeQaCEmAGxNviiD+CuVcqHX6Eh07b0t7CT/6b2dBOIeYoWhrXJgB6Twk96SCkxDexuYIRa+MH
 rf04TWhmOEo/9lo58g/DhSPW6hjzz2VtF5JBrGh6ctVz2y4PkrBq4ccXmNySUzOh/1kli4QsJx
 lh1hI1h/sv2J0onf81tE3HabVGMUw4xhbw6fKxF2KalZGgsF1AOKE13hA8l2vy1d1xV40W8NBb
 OA7hSp3FK7AYHJk38lGbEx8yDrMaPekXhDt2HneeNbNfK1dC9Gw4Bt63I525RKccj9YACEGxp+
 2YA=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="173981329"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 10:25:48 +0800
IronPort-SDR: 3lXmHsc8b7cWH/f1y1dM0XzSyI1WEHkVt1MsGrqb8uIkVbV68L0WdirmnQfOepoYZ/lhDA/aJp
 f1vTYKg9LGklxziDSlUXiBzhpbTIUB8amrOj5eruyTBZt2KAK8P2Hg/zJ4i+43GSx5VfEc5Y81
 CJDndpBYhp4NRTsLcjouzWlcBJvBHk6vDDg4UhRHD1QtvVPm34P6BTG+8XoZDjfgHeDbhqV++s
 xLU6ACuLrpHdhwLruRK8CFHGTMlxE3F4lXQbHs4BMoIxVkS073tCcPPWHbPm0vtKexbT0uQOLg
 kmzGT/c2l06gpFwF1Myb1gwY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:04:03 -0700
IronPort-SDR: dzJJNLoBfl9qS14i0lR8re+y9nHSoYR+22kidiqfEZxypouhLtrvoW+UAbuq/UfZsrAP1n8nkt
 R1sj7Ai7TXzcZuy/BarqRFpXbR/N1hmBA5P45hQycIVyX4rhrN/+Ou4lXOeM6DPhM7zJXPbYLy
 Y0a60NThhQWj6lrUKpA8tj0KhFcysy9ErpBLgaZyaNdxmog9B2mZNBqpbjUhzohSwIzr4nX5g9
 X3Rvxo9oQVsFEFrgMWKz15sOtXC7xkWydSWAZnGTwJIUGF14uuyXaO8ths5SEsNp405nmCjbUO
 2Pc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2021 19:25:48 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 07/11] dm: Introduce dm_report_zones()
Date:   Tue, 25 May 2021 11:25:35 +0900
Message-Id: <20210525022539.119661-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525022539.119661-1-damien.lemoal@wdc.com>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To simplify the implementation of the report_zones operation of a zoned
target, introduce the function dm_report_zones() to set a target
mapping start sector in struct dm_report_zones_args and call
blkdev_report_zones(). This new function is exported and the report
zones callback function dm_report_zones_cb() is not.

dm-linear, dm-flakey and dm-crypt are modified to use dm_report_zones().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/dm-crypt.c         |  7 +++----
 drivers/md/dm-flakey.c        |  7 +++----
 drivers/md/dm-linear.c        |  7 +++----
 drivers/md/dm-zone.c          | 23 ++++++++++++++++++++---
 include/linux/device-mapper.h |  3 ++-
 5 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index b0ab080f2567..f410ceee51d7 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3138,11 +3138,10 @@ static int crypt_report_zones(struct dm_target *ti,
 		struct dm_report_zones_args *args, unsigned int nr_zones)
 {
 	struct crypt_config *cc = ti->private;
-	sector_t sector = cc->start + dm_target_offset(ti, args->next_sector);
 
-	args->start = cc->start;
-	return blkdev_report_zones(cc->dev->bdev, sector, nr_zones,
-				   dm_report_zones_cb, args);
+	return dm_report_zones(cc->dev->bdev, cc->start,
+			cc->start + dm_target_offset(ti, args->next_sector),
+			args, nr_zones);
 }
 #else
 #define crypt_report_zones NULL
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index b7fee9936f05..5877220c01ed 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -463,11 +463,10 @@ static int flakey_report_zones(struct dm_target *ti,
 		struct dm_report_zones_args *args, unsigned int nr_zones)
 {
 	struct flakey_c *fc = ti->private;
-	sector_t sector = flakey_map_sector(ti, args->next_sector);
 
-	args->start = fc->start;
-	return blkdev_report_zones(fc->dev->bdev, sector, nr_zones,
-				   dm_report_zones_cb, args);
+	return dm_report_zones(fc->dev->bdev, fc->start,
+			       flakey_map_sector(ti, args->next_sector),
+			       args, nr_zones);
 }
 #else
 #define flakey_report_zones NULL
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 92db0f5e7f28..c91f1e2e2f65 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -140,11 +140,10 @@ static int linear_report_zones(struct dm_target *ti,
 		struct dm_report_zones_args *args, unsigned int nr_zones)
 {
 	struct linear_c *lc = ti->private;
-	sector_t sector = linear_map_sector(ti, args->next_sector);
 
-	args->start = lc->start;
-	return blkdev_report_zones(lc->dev->bdev, sector, nr_zones,
-				   dm_report_zones_cb, args);
+	return dm_report_zones(lc->dev->bdev, lc->start,
+			       linear_map_sector(ti, args->next_sector),
+			       args, nr_zones);
 }
 #else
 #define linear_report_zones NULL
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3243c42b7951..b42474043249 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -56,7 +56,8 @@ int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 	return ret;
 }
 
-int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data)
+static int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx,
+			      void *data)
 {
 	struct dm_report_zones_args *args = data;
 	sector_t sector_diff = args->tgt->begin - args->start;
@@ -84,7 +85,24 @@ int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data)
 	args->next_sector = zone->start + zone->len;
 	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
 }
-EXPORT_SYMBOL_GPL(dm_report_zones_cb);
+
+/*
+ * Helper for drivers of zoned targets to implement struct target_type
+ * report_zones operation.
+ */
+int dm_report_zones(struct block_device *bdev, sector_t start, sector_t sector,
+		    struct dm_report_zones_args *args, unsigned int nr_zones)
+{
+	/*
+	 * Set the target mapping start sector first so that
+	 * dm_report_zones_cb() can correctly remap zone information.
+	 */
+	args->start = start;
+
+	return blkdev_report_zones(bdev, sector, nr_zones,
+				   dm_report_zones_cb, args);
+}
+EXPORT_SYMBOL_GPL(dm_report_zones);
 
 void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
 {
@@ -99,4 +117,3 @@ void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
 	WARN_ON_ONCE(queue_is_mq(q));
 	q->nr_zones = blkdev_nr_zones(t->md->disk);
 }
-
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index ff700fb6ce1d..caea0a079d2d 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -478,7 +478,8 @@ struct dm_report_zones_args {
 	/* must be filled by ->report_zones before calling dm_report_zones_cb */
 	sector_t start;
 };
-int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx, void *data);
+int dm_report_zones(struct block_device *bdev, sector_t start, sector_t sector,
+		    struct dm_report_zones_args *args, unsigned int nr_zones);
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 /*
-- 
2.31.1

