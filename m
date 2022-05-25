Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22118C43217
	for <linux-block@archiver.kernel.org>; Wed, 25 May 2022 15:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245345AbiEYPua (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 11:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245387AbiEYPuM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 11:50:12 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8A2AF32C
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 08:50:11 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220525155009euoutp02bfd0b150b8e4124577596de5322efca6~yY9wJ781_0326303263euoutp02L
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 15:50:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220525155009euoutp02bfd0b150b8e4124577596de5322efca6~yY9wJ781_0326303263euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653493809;
        bh=tYOWZPnjW65XI4l1LBGIm3u73JaE/GHPi+tZ/3A+qe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6Qu77Ihzkt1GlD+/w1r6xsFi0DjhWf0LS8zQ02zrZFUAQJQSkLNGON7uOAQkzL8Q
         D2u5pYxAI/iMQTb4XxWU9rhFAB89YAJnksRXjL7ogJ/A37COGSEge2szTP5PRYSVij
         AUlAa0yF2biAZ7CZqPWAoL8W9LB3wrQB4eFgW9f4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220525155008eucas1p21392109a809e41d5bb99c4abd0256de8~yY9uxB_mn0700707007eucas1p2J;
        Wed, 25 May 2022 15:50:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EF.FF.10260.0305E826; Wed, 25
        May 2022 16:50:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220525155007eucas1p1b7fc82f9e42be028e8f00109d55e6a62~yY9uK4vp20770307703eucas1p1D;
        Wed, 25 May 2022 15:50:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220525155007eusmtrp18bb3a95ccc378c2b11588ec51e84a10d~yY9uKGJTE1510315103eusmtrp1K;
        Wed, 25 May 2022 15:50:07 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-e4-628e503011b6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AF.17.09522.F205E826; Wed, 25
        May 2022 16:50:07 +0100 (BST)
Received: from localhost (unknown [106.210.248.20]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220525155007eusmtip1f0d8c7ef887e2d198cd3b081ecc69235~yY9t1swVE1835018350eusmtip1F;
        Wed, 25 May 2022 15:50:07 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        snitzer@redhat.com, Johannes.Thumshirn@wdc.com, hch@lst.de,
        hare@suse.de
Cc:     dsterba@suse.com, dm-devel@redhat.com, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
        gost.dev@samsung.com, Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v6 7/8] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Wed, 25 May 2022 17:49:56 +0200
Message-Id: <20220525154957.393656-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525154957.393656-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djPc7oGAX1JBk92C1qsvtvPZvH77Hlm
        i73vZrNaXPjRyGRx88BOJos9iyYxWaxcfZTJ4sn6WcwWPQc+sFj87brHZLH3lrbF5V1z2Czm
        L3vKbnFjwlNGi89LW9gt2jZ+ZXQQ8Ph3Yg2bx+WzpR6bVnWyeWxeUu+x+2YDm8fO1vusHu/3
        XWXz6NuyitFj/ZarLB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK2NJ1wuWgkeCFVfe
        r2JqYDzO18XIySEhYCKxY+k0ti5GLg4hgRWMEs+v74JyvjBK7Pq3iAnC+cwocXHia6AMB1jL
        /Y28EPHljBKLX+5ghXBeMEqs6gTp4OBgE9CSaOxkB4mLCDQySkx9eYIRxGEWmM0ksXfWXEaQ
        5cICgRJ3zq1iBbFZBFQlzqx8zAZi8wpYSdxfsIUR4kB5iZmXvrOD2JwC1hLz939mhqgRlDg5
        8wkLiM0MVNO8dTYzyAIJgfWcEk9mrIRqdpGYuH46M4QtLPHq+BZ2CFtG4vTkHhYIu1ri6Y3f
        UM0tjBL9O9dD/Wkt0XcmB8RkFtCUWL9LH6LcUeL/4V+MEBV8EjfeCkKcwCcxaRvIJpAwr0RH
        mxBEtZLEzp9PoJZKSFxumgO11EPi7aJPrBMYFWcheWYWkmdmIexdwMi8ilE8tbQ4Nz212Dgv
        tVyvODG3uDQvXS85P3cTIzAFnv53/OsOxhWvPuodYmTiYDzEKMHBrCTCe+Fpb5IQb0piZVVq
        UX58UWlOavEhRmkOFiVx3uTMDYlCAumJJanZqakFqUUwWSYOTqkGpmTbzsULTs6Xe//zsDCb
        WXZLpVZbhd4OoUxnE28VZzuLW3tuCD2M9j9b+bPrdcgnj0DfbLtN3ftE+RlcG4MnrdyjaHzf
        aMuRi2Inf+2beDd0q8R3oz+KzSJsk2M3Z/1grpZu9WNNqI/O+3Zgini30JnpLw3cNee/y90w
        bf02Xh2NNyev3644Okk4TWzJxDaFoBMzj8jG/XHxtoiTmyC8/kb23tKVTVoLfi7yuuu46dj+
        z7s60z5leq9eJZWvzRq5X63IyPbFJfZb/S8KH2bY2x7pb7pWHLH+Yu4Jw51f8jXkK1xy/h0+
        9ObWynreGzO5g27tcFrW/GdnscpRPwbrl/0V9Zzu4Qel1reypr88oMRSnJFoqMVcVJwIAIn8
        33HwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7r6AX1JBovmalmsvtvPZvH77Hlm
        i73vZrNaXPjRyGRx88BOJos9iyYxWaxcfZTJ4sn6WcwWPQc+sFj87brHZLH3lrbF5V1z2Czm
        L3vKbnFjwlNGi89LW9gt2jZ+ZXQQ8Ph3Yg2bx+WzpR6bVnWyeWxeUu+x+2YDm8fO1vusHu/3
        XWXz6NuyitFj/ZarLB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/I
        xFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2NJ1wuWgkeCFVfer2JqYDzO18XIwSEhYCJxfyNv
        FyMnh5DAUkaJtrUiILaEgITE7YVNjBC2sMSfa11sXYxcQDXPGCW6l/9kB+llE9CSaOxkB4mL
        CHQySszZ1wrmMAssZ5LYfLKPGaRbWMBfouXMMSYQm0VAVeLMysdsIDavgJXE/QVboDbIS8y8
        9J0dxOYUsJaYv/8zM8RFVhJf73xlhagXlDg58wkLiM0MVN+8dTbzBEaBWUhSs5CkFjAyrWIU
        SS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM1W3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeC887U0S
        4k1JrKxKLcqPLyrNSS0+xGgKdPdEZinR5HxgssgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJI
        TyxJzU5NLUgtgulj4uCUamDSKX5zfkJJl16syLXyyb5/dPxP9WltURf8sFly00HtcE/huJbe
        +p/1j1fVuOs8k3WafuvG7TuGXxUs79W8vOuoGrqVifenyTqNRwu7btx8Xh3ja/h5dkpDSu2T
        2xkhFcH/rN8xbds98+J0M+n8zGsnDQXD48L8+f/N6bnQ9VTx1t6VYqU1Hak/M/W53vB1/knf
        sfSlWNOz6OM9BySlegOf3/Ge8Dv5e3XRzvz8V5VS99/fC/ZbnPP7G69a1oeUVJ9+xhVi/ZVq
        iudvPGN59DQitSioIVqy/WTo9/71GiGvNdoy4jaKLn/m8tJvInvFmrWi6eeuZB1Z/T5dJ2VB
        ycp/anOknO4lL7gnsNlzSrcSS3FGoqEWc1FxIgBTZtA4XgMAAA==
X-CMS-MailID: 20220525155007eucas1p1b7fc82f9e42be028e8f00109d55e6a62
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220525155007eucas1p1b7fc82f9e42be028e8f00109d55e6a62
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220525155007eucas1p1b7fc82f9e42be028e8f00109d55e6a62
References: <20220525154957.393656-1-p.raghav@samsung.com>
        <CGME20220525155007eucas1p1b7fc82f9e42be028e8f00109d55e6a62@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Today dm-zoned relies on the assumption that you have a zone size
with a power of 2. Even though the block layer today enforces this
requirement, these devices do exist and so provide a stop-gap measure
to ensure these devices cannot be used by mistake

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-zone.c         | 10 ++++++++++
 drivers/md/dm-zoned-target.c |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 57daa86c19cf..41188091fe6b 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -231,6 +231,16 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
 	struct request_queue *q = md->queue;
 	unsigned int noio_flag;
 	int ret;
+	struct block_device *bdev = md->disk->part0;
+	sector_t zone_sectors;
+
+	zone_sectors = bdev_zone_sectors(bdev);
+
+	if (!is_power_of_2(zone_sectors)) {
+		DMWARN("%s: %pg only power of two zone size supported",
+		       dm_device_name(md), bdev);
+		return -EINVAL;
+	}
 
 	/*
 	 * Check if something changed. If yes, cleanup the current resources
diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index cac295cc8840..e4cef1b1b46c 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 				return -EINVAL;
 			}
 			zone_nr_sectors = blk_queue_zone_sectors(q);
+			if (!is_power_of_2(zone_nr_sectors)) {
+				ti->error = "Zone size not power of 2";
+				return -EINVAL;
+			}
 			zoned_dev->zone_nr_sectors = zone_nr_sectors;
 			zoned_dev->nr_zones =
 				blkdev_nr_zones(zoned_dev->bdev->bd_disk);
@@ -806,6 +810,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 		q = bdev_get_queue(zoned_dev->bdev);
 		zoned_dev->zone_nr_sectors = blk_queue_zone_sectors(q);
 		zoned_dev->nr_zones = blkdev_nr_zones(zoned_dev->bdev->bd_disk);
+		if (!is_power_of_2(zone_nr_sectors)) {
+			ti->error = "Zone size not power of 2";
+			return -EINVAL;
+		}
 	}
 
 	if (reg_dev) {
-- 
2.25.1

