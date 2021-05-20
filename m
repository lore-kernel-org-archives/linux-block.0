Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CC8C43460
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25192611AE
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhETEX7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 00:23:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63405 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhETEX6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 00:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621484557; x=1653020557;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ig1LCLNVNN/TAqyjRgCT7Z4n/o7x3VRmirTRPRre1Dw=;
  b=YDGWb+2GDOSBqX6DJ7aXXZoQnHIvOLi1KGDnqbrt44lbBVdPxEX8ZabA
   R9iuFIXU+vYWTejyBM31+XIWTdSQWR0Cpw8fECtYXcstt2+H4AunpmQE9
   3A3ZKHVEv0fxLXKuQAdvI1bHvrg2plEWQeEhspiaigDyjz92XxvQNFnWQ
   waWjaY8dJp70D7hJB1u7ptCYsI+mBk4vt+bOkubK9XVWvMbc3PjWsa18p
   LhEqfBuoIJuSen0Pf6nHWdpWTm9skr5B+vh474zjDlh5SUwQkCdxHDrEu
   4Y+f+Qub+KYM++Z9LS17V7lHeD8oxUCKdMq+9s1kYXgpnlqsATMl3WF1a
   g==;
IronPort-SDR: H74MrWBf5jssPjDu0t3v+HLQTQcUG5WDA3LMH2tfnLIcZdgucc4eKegDpA7VocItdvqqweIhmk
 3howi17I9DY557ZZx4DbPF45lpoIKF9yzJI05gQ3ak6wUM2Z14cRkpCGK0s0sNPg1eNKINlWxA
 +e81rCeEjEBaYWehI8KkJ3FQzBmp0cEF8BP7dGdcTQ/FJxtNOUCBXz20/bE1I6KUdu2G9C2LxP
 ntqWkoPPsZGF1Q/m6vQE3cL5oUphIrH9vncJsFmE23B3Bh95bDPW6HGDNA5e9v4Vks/jfbr/bP
 uYQ=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168105845"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 12:22:37 +0800
IronPort-SDR: Q2euIYXnS2h9QpXspzlz9zaLgHhj6RWe6d5weExG3pDBrggqKP9ENRX25evZvUZ4ZHPeKRxjxF
 uulkCQwH09aNuPDZifG9qUfHZAqwaeRGVZ/1dr200gr/dCpH+icmMDuave2H+suHJrv2+fo0W0
 Qka774JTjcFItDJsaYOnjgkwXUUAzRXc1IKJs6XO+DKRITOSoAcXGrx5MEBxsbL3z9V4fSvPgr
 IjtEkb/eDxLCmmSGB9/ZXLUPdcRYNl2ojmEsrqdEikv85zTwqaFQMT5+/3mu9uqHj4EZ4fDPtt
 vowhyaaWJH/FAeoxD1usdObo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 21:02:14 -0700
IronPort-SDR: cG7vf1BhVMia8mihm4DOpw3HfRP7lqYzKMtAthqTj2Y3m04ur5pUNCGoLDYh08R4sAaL0RgXF+
 8NH9za11LIb/k5FgFpwqRXNZQylKfvu0UZtZYT4Hr7fZPuTRdWNIyPBZyTk0K+WWB7Oe6Ppi7U
 cO0bpkWBTUHuyoUPrFZsN5Dr3Vl1m82lOlZFqim2/NPPCbDhab+793byUy3KggVFhL81tOXoUR
 8wupFwd9HjtHPjuwTUDOF1ZZgrV6xxrvk/AqZt0hqOWyQ5EX8uNOKMcMPpzVoUlLRn7qCuITJI
 irk=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2021 21:22:37 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 07/11] dm: Introduce dm_report_zones()
Date:   Thu, 20 May 2021 13:22:24 +0900
Message-Id: <20210520042228.974083-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520042228.974083-1-damien.lemoal@wdc.com>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
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

