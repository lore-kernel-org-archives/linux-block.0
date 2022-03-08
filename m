Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9269C433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 16:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbiCHQzt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243190AbiCHQzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 11:55:47 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDEA4ECF9
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 08:54:50 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220308165449euoutp025a7ac19ed8e765f4609b0668df265c26~adh75WYcZ1933719337euoutp024
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 16:54:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220308165449euoutp025a7ac19ed8e765f4609b0668df265c26~adh75WYcZ1933719337euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646758489;
        bh=HGaWcY8n+4ocfWs62bYgL+CzDOaHpoifmYU74lyi9D0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JY+6bAwFmV7aQTkV1RzxWG2DYvZPwucXN1CviwF4wn5x6sHhZH7Ofv0xWTxitsgsu
         i5kq6z139csbCJmZMGhwq+OyW0wYmADYpqJLfoiey+kQyH9g2HRU12GTqrj7TePN7j
         y2oZ61CKzzIiyx5MX2p9VTrEAMjrcCuZpvit7j5A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220308165448eucas1p28317b6a694ac6d07bc5062ad11143436~adh7igDYk2414524145eucas1p2n;
        Tue,  8 Mar 2022 16:54:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6C.4B.10009.85A87226; Tue,  8
        Mar 2022 16:54:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220308165448eucas1p12c7c302a4b239db64b49d54cc3c1f0ac~adh67nP7W1394013940eucas1p1X;
        Tue,  8 Mar 2022 16:54:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220308165448eusmtrp2cfde600da3c75354119e07c3717512ea~adh663xTC0537605376eusmtrp2R;
        Tue,  8 Mar 2022 16:54:48 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-fa-62278a58eba5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.A6.09404.75A87226; Tue,  8
        Mar 2022 16:54:48 +0000 (GMT)
Received: from localhost (unknown [106.210.248.181]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220308165447eusmtip18f7edb07ec6dbb6febe5b28345ee9648~adh6lo8Rn3181531815eusmtip1Y;
        Tue,  8 Mar 2022 16:54:47 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        jiangbo.365@bytedance.com
Cc:     Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 6/6] null_blk: Add support for power_of_2 emulation to the
 null blk device
Date:   Tue,  8 Mar 2022 17:53:49 +0100
Message-Id: <20220308165349.231320-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308165349.231320-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djPc7oRXepJBlNPqFtMP6xosfpuP5vF
        77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
        eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
        ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEdx2aSk5mSWpRbp2yVwZfxr7WMrWJhV8eHoXZYGxgXh
        XYycHBICJhLnpq5j6mLk4hASWMEoMfPVKnYI5wujRPPEV4wQzmdGidWTlrLAtPzcdgYqsZxR
        YuXHLWwQzktGiX/33gEN4+BgE9CSaOxkB2kQEbjALPHjpiJIDbPAZkaJD5NWsIIkhAViJD7v
        /MMIYrMIqEo8OXKOCcTmFbCSmNhwnhFim7zEzEvfwQZxClhLPO2cyQZRIyhxcuYTsIuYgWqa
        t85mBlkgIbCYU+Ln5JdsEM0uEovWf4AaJCzx6vgWdghbRuL/zvlMEA39jBJTW/5AOTMYJXoO
        bwZ7QQJoXd+ZHBCTWUBTYv0ufYheR4ljB45CVfBJ3HgrCHEDn8SkbdOZIcK8Eh1tQhDVShI7
        fz6B2iohcblpDjQQPST2Pepnn8CoOAvJN7OQfDMLYe8CRuZVjOKppcW56anFhnmp5XrFibnF
        pXnpesn5uZsYganv9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRHe++dVkoR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzJmduSBQSSE8sSc1OTS1ILYLJMnFwSjUwTQp2N/IQi1X/XGBV/bLj2abVtz07
        +U/x6wi+dVtbY+BoFrD2qODWK/xax878a73eZa8yZZ4Lr9065tjVIm7t+ou41HxZxO+8/sp/
        1OjJfYOoafIRIgI/p/t9rja73P9own/pkx8SyqeUWE7x5Df4cdZT9KORtKLV7C9yTWn/e2p4
        rgo8rVn5emvt+cBLsS2nyhjqGCJUY5w3H4q+HnO2/bC+qb/aTD/DQp34WK/Fp1/5cApsMJ1l
        WJ/9Wsx6Ws/lOf+Yt3y6kFHLdb/z3GXPQxv505pVnhwJYr9Z27yt9Oz8hkkH7fbMXug2b867
        Ps7HoXk85m3TWTI3Tuv8v+Tx1dWb2V7aiTQYzF98TsNTiaU4I9FQi7moOBEA8jG4bOwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7oRXepJBm1TmSymH1a0WH23n83i
        99nzzBYrVx9lsnh85zO7Rc+BDywWR/+/ZbM4//Ywk8WkQ9cYLfbe0raYv+wpu8WEtq/MFjcm
        PGW0+Ly0hd1izc2nLBbrXr9ncRDw+HdiDZvHzll32T3O39vI4nH5bKnHplWdbB6bl9R77L7Z
        AJRrvc/q0bdlFaPH501yHu0HupkCuKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0Mv619rEVLMyq+HD0LksD44LwLkZODgkBE4mf284wgthCAksZ
        JXbfF4KIS0jcXtjECGELS/y51sXWxcgFVPOcUeL0z1Ygh4ODTUBLorGTHSQuInCDWWLZ1DZG
        EIdZYDujxIaVc9hAuoUFoiQOt/1jBrFZBFQlnhw5xwRi8wpYSUxsOA+1QV5i5qXv7CA2p4C1
        xNPOmWwQF1lJ/DrQClUvKHFy5hMWEJsZqL5562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2yk
        V5yYW1yal66XnJ+7iREYo9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8N4/r5IkxJuSWFmVWpQf
        X1Sak1p8iNEU6O6JzFKiyfnAJJFXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBa
        BNPHxMEp1cC0/onO7orq3qRjWU+LZqxiaF+S1r/wtC1D4Z5VwpKTEj0vqCxhujFzdeMHFsVE
        vogZP/Z0fVYrOnzE2ubq9CXtFpNY33fPX2Qovfv+sdtiO6s29VVGbq+a+2Zh46wWtXOTG5cK
        vvQxfr/lWVLSBytmUR6X6O0+R0V+7XuwR/PmI+euDds+n3TN11qdrZh967cAvzPr0+uvP3hG
        xvidSbNgWfxW5i3TMtlH+Qf+/77nN1NweWPhjamXFZ1m+kybVxccK2fMp14/86Ni4WNbx95n
        J7euccucfvqcJN/8qEnNid4buAS0Fr6zUJb/NFVjx2TutOyUewKnrzX/V3O/srb1uuG35ftu
        vfKqU9E3nbTHV4mlOCPRUIu5qDgRAKO4UtdaAwAA
X-CMS-MailID: 20220308165448eucas1p12c7c302a4b239db64b49d54cc3c1f0ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220308165448eucas1p12c7c302a4b239db64b49d54cc3c1f0ac
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165448eucas1p12c7c302a4b239db64b49d54cc3c1f0ac
References: <20220308165349.231320-1-p.raghav@samsung.com>
        <CGME20220308165448eucas1p12c7c302a4b239db64b49d54cc3c1f0ac@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

power_of_2(PO2) emulation support is added to the null blk device to
measure performance.

Callbacks are added in the hotpaths that require PO2 emulation specific
behaviour to reduce the impact on exisiting path.

The power_of_2 emulation support is wired up for both the request and
the bio queue mode and it is automatically enabled when the given zone
size is non-power_of_2.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/null_blk/main.c     |   8 +-
 drivers/block/null_blk/null_blk.h |  12 ++
 drivers/block/null_blk/zoned.c    | 203 ++++++++++++++++++++++++++----
 3 files changed, 196 insertions(+), 27 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 625a06bfa5ad..c926b59f2b17 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -210,7 +210,7 @@ MODULE_PARM_DESC(zoned, "Make device as a host-managed zoned block device. Defau
 
 static unsigned long g_zone_size = 256;
 module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);
-MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Must be power-of-two: Default: 256");
+MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Default: 256");
 
 static unsigned long g_zone_capacity;
 module_param_named(zone_capacity, g_zone_capacity, ulong, 0444);
@@ -1772,11 +1772,13 @@ static const struct block_device_operations null_bio_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= null_submit_bio,
 	.report_zones	= null_report_zones,
+	.npo2_zone_setup = null_po2_zone_emu_setup,
 };
 
 static const struct block_device_operations null_rq_ops = {
 	.owner		= THIS_MODULE,
 	.report_zones	= null_report_zones,
+	.npo2_zone_setup = null_po2_zone_emu_setup,
 };
 
 static int setup_commands(struct nullb_queue *nq)
@@ -1929,8 +1931,8 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->mbps = 0;
 
 	if (dev->zoned &&
-	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
-		pr_err("zone_size must be power-of-two\n");
+	    (!dev->zone_size)) {
+		pr_err("zone_size must be zero\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 78eb56b0ca55..34c1b7b2546b 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -74,6 +74,16 @@ struct nullb_device {
 	unsigned int imp_close_zone_no;
 	struct nullb_zone *zones;
 	sector_t zone_size_sects;
+	sector_t zone_size_po2_sects;
+	sector_t zone_size_diff_sects;
+	/* The callbacks below are used as hook to perform po2 emulation for a
+	 * zoned device.
+	 */
+	unsigned int (*zone_no)(struct nullb_device *dev,
+				sector_t sect);
+	sector_t (*zone_update_sector)(struct nullb_device *dev, sector_t sect);
+	sector_t (*zone_update_sector_append)(struct nullb_device *dev,
+					      sector_t sect);
 	bool need_zone_res_mgmt;
 	spinlock_t zone_res_lock;
 
@@ -137,6 +147,7 @@ int null_register_zoned_dev(struct nullb *nullb);
 void null_free_zoned_dev(struct nullb_device *dev);
 int null_report_zones(struct gendisk *disk, sector_t sector,
 		      unsigned int nr_zones, report_zones_cb cb, void *data);
+void null_po2_zone_emu_setup(struct gendisk *disk);
 blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd,
 				    enum req_opf op, sector_t sector,
 				    sector_t nr_sectors);
@@ -166,5 +177,6 @@ static inline size_t null_zone_valid_read_len(struct nullb *nullb,
 	return len;
 }
 #define null_report_zones	NULL
+#define null_po2_zone_emu_setup	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index dae54dd1aeac..3bb63c170149 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -16,6 +16,44 @@ static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 	return sect >> ilog2(dev->zone_size_sects);
 }
 
+static inline unsigned int null_npo2_zone_no(struct nullb_device *dev,
+					     sector_t sect)
+{
+	return sect / dev->zone_size_sects;
+}
+
+static inline bool null_is_po2_zone_emu(struct nullb_device *dev)
+{
+	return !!dev->zone_size_diff_sects;
+}
+
+static inline sector_t null_zone_update_sector_noop(struct nullb_device *dev,
+						    sector_t sect)
+{
+	return sect;
+}
+
+static inline sector_t null_zone_update_sector_po2_emu(struct nullb_device *dev,
+						       sector_t sect)
+{
+	sector_t zsze_po2 = dev->zone_size_po2_sects;
+	sector_t zsze_diff = dev->zone_size_diff_sects;
+	u32 zone_idx = sect >> ilog2(zsze_po2);
+
+	sect = sect - (zone_idx * zsze_diff);
+	return sect;
+}
+
+static inline sector_t
+null_zone_update_sector_append_po2_emu(struct nullb_device *dev, sector_t sect)
+{
+	/* Need to readjust the sector if po2 emulation is used. */
+	u32 zone_no = dev->zone_no(dev, sect);
+
+	sect += dev->zone_size_diff_sects * zone_no;
+	return sect;
+}
+
 static inline void null_lock_zone_res(struct nullb_device *dev)
 {
 	if (dev->need_zone_res_mgmt)
@@ -62,15 +100,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	sector_t sector = 0;
 	unsigned int i;
 
-	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
-		return -EINVAL;
-	}
 	if (dev->zone_size > dev->size) {
 		pr_err("Zone size larger than device capacity\n");
 		return -EINVAL;
 	}
 
+	if (!is_power_of_2(dev->zone_size))
+		pr_info("zone_size is not power-of-two. power-of-two emulation is enabled");
+
 	if (!dev->zone_capacity)
 		dev->zone_capacity = dev->zone_size;
 
@@ -83,8 +120,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
-	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
-		>> ilog2(dev->zone_size_sects);
+
+	dev->nr_zones = roundup(dev_capacity_sects, dev->zone_size_sects) /
+			dev->zone_size_sects;
+
+	dev->zone_no = null_zone_no;
+	dev->zone_update_sector = null_zone_update_sector_noop;
+	dev->zone_update_sector_append = null_zone_update_sector_noop;
+
 
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
 				    GFP_KERNEL | __GFP_ZERO);
@@ -166,7 +209,13 @@ int null_register_zoned_dev(struct nullb *nullb)
 		if (ret)
 			return ret;
 	} else {
-		blk_queue_chunk_sectors(q, dev->zone_size_sects);
+		nullb->disk->fops->npo2_zone_setup(nullb->disk);
+
+		if (null_is_po2_zone_emu(dev))
+			blk_queue_chunk_sectors(q, dev->zone_size_po2_sects);
+		else
+			blk_queue_chunk_sectors(q, dev->zone_size_sects);
+
 		q->nr_zones = blkdev_nr_zones(nullb->disk);
 	}
 
@@ -183,17 +232,49 @@ void null_free_zoned_dev(struct nullb_device *dev)
 	dev->zones = NULL;
 }
 
+static void null_update_zone_info(struct nullb *nullb, struct blk_zone *blkz,
+				  struct nullb_zone *zone)
+{
+	unsigned int zone_idx;
+	u64 zone_gap;
+	struct nullb_device *dev = nullb->dev;
+
+	if (null_is_po2_zone_emu(dev)) {
+		zone_idx = zone->start / zone->len;
+		zone_gap = zone_idx * dev->zone_size_diff_sects;
+
+		blkz->start = zone->start + zone_gap;
+		blkz->len = dev->zone_size_po2_sects;
+		blkz->wp = zone->wp + zone_gap;
+	} else {
+		blkz->start = zone->start;
+		blkz->len = zone->len;
+		blkz->wp = zone->wp;
+	}
+
+	blkz->type = zone->type;
+	blkz->cond = zone->cond;
+	blkz->capacity = zone->capacity;
+}
+
 int null_report_zones(struct gendisk *disk, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct nullb *nullb = disk->private_data;
 	struct nullb_device *dev = nullb->dev;
 	unsigned int first_zone, i;
+	sector_t zone_size;
 	struct nullb_zone *zone;
 	struct blk_zone blkz;
 	int error;
 
-	first_zone = null_zone_no(dev, sector);
+	if (null_is_po2_zone_emu(dev))
+		zone_size = dev->zone_size_po2_sects;
+	else
+		zone_size = dev->zone_size_sects;
+
+	first_zone = sector / zone_size;
+
 	if (first_zone >= dev->nr_zones)
 		return 0;
 
@@ -210,12 +291,7 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
 		 * array.
 		 */
 		null_lock_zone(dev, zone);
-		blkz.start = zone->start;
-		blkz.len = zone->len;
-		blkz.wp = zone->wp;
-		blkz.type = zone->type;
-		blkz.cond = zone->cond;
-		blkz.capacity = zone->capacity;
+		null_update_zone_info(nullb, &blkz, zone);
 		null_unlock_zone(dev, zone);
 
 		error = cb(&blkz, i, data);
@@ -226,6 +302,35 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
 	return nr_zones;
 }
 
+void null_po2_zone_emu_setup(struct gendisk *disk)
+{
+	struct nullb *nullb = disk->private_data;
+	struct nullb_device *dev = nullb->dev;
+	sector_t capacity;
+
+	if (is_power_of_2(dev->zone_size_sects))
+		return;
+
+	if (!get_capacity(disk))
+		return;
+
+	blk_mq_freeze_queue(disk->queue);
+
+	blk_queue_po2_zone_emu(disk->queue, 1);
+	dev->zone_size_po2_sects =
+		1 << get_count_order_long(dev->zone_size_sects);
+	dev->zone_size_diff_sects =
+		dev->zone_size_po2_sects - dev->zone_size_sects;
+	dev->zone_no = null_npo2_zone_no;
+	dev->zone_update_sector = null_zone_update_sector_po2_emu;
+	dev->zone_update_sector_append = null_zone_update_sector_append_po2_emu;
+
+	capacity = dev->nr_zones * dev->zone_size_po2_sects;
+	set_capacity(disk, capacity);
+
+	blk_mq_unfreeze_queue(disk->queue);
+}
+
 /*
  * This is called in the case of memory backing from null_process_cmd()
  * with the target zone already locked.
@@ -234,7 +339,7 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 				sector_t sector, unsigned int len)
 {
 	struct nullb_device *dev = nullb->dev;
-	struct nullb_zone *zone = &dev->zones[null_zone_no(dev, sector)];
+	struct nullb_zone *zone = &dev->zones[dev->zone_no(dev, sector)];
 	unsigned int nr_sectors = len >> SECTOR_SHIFT;
 
 	/* Read must be below the write pointer position */
@@ -363,11 +468,24 @@ static blk_status_t null_check_zone_resources(struct nullb_device *dev,
 	}
 }
 
+static void null_update_sector_append(struct nullb_cmd *cmd, sector_t sector)
+{
+	struct nullb_device *dev = cmd->nq->dev;
+
+	sector = dev->zone_update_sector_append(dev, sector);
+
+	if (cmd->bio) {
+		cmd->bio->bi_iter.bi_sector = sector;
+	} else {
+		cmd->rq->__sector = sector;
+	}
+}
+
 static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 				    unsigned int nr_sectors, bool append)
 {
 	struct nullb_device *dev = cmd->nq->dev;
-	unsigned int zno = null_zone_no(dev, sector);
+	unsigned int zno = dev->zone_no(dev, sector);
 	struct nullb_zone *zone = &dev->zones[zno];
 	blk_status_t ret;
 
@@ -395,10 +513,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	 */
 	if (append) {
 		sector = zone->wp;
-		if (cmd->bio)
-			cmd->bio->bi_iter.bi_sector = sector;
-		else
-			cmd->rq->__sector = sector;
+		null_update_sector_append(cmd, sector);
 	} else if (sector != zone->wp) {
 		ret = BLK_STS_IOERR;
 		goto unlock;
@@ -619,7 +734,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 		return BLK_STS_OK;
 	}
 
-	zone_no = null_zone_no(dev, sector);
+	zone_no = dev->zone_no(dev, sector);
 	zone = &dev->zones[zone_no];
 
 	null_lock_zone(dev, zone);
@@ -650,13 +765,54 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	return ret;
 }
 
+static blk_status_t null_handle_po2_zone_emu_violation(struct nullb_cmd *cmd,
+						       enum req_opf op)
+{
+	if (op == REQ_OP_READ) {
+		if (cmd->bio)
+			zero_fill_bio(cmd->bio);
+		else
+			zero_fill_bio(cmd->rq->bio);
+
+		return BLK_STS_OK;
+	} else {
+		return BLK_STS_IOERR;
+	}
+}
+
+static bool null_verify_sector_violation(struct nullb_device *dev,
+					 sector_t sector)
+{
+	if (unlikely(null_is_po2_zone_emu(dev))) {
+		/* The zone idx should be calculated based on the emulated
+		 * layout
+		 */
+		u32 zone_idx = sector >> ilog2(dev->zone_size_po2_sects);
+		sector_t zsze = dev->zone_size_sects;
+		sector_t sect = null_zone_update_sector_po2_emu(dev, sector);
+
+		if (sect - (zone_idx * zsze) > zsze)
+			return true;
+	}
+	return false;
+}
+
 blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
 				    sector_t sector, sector_t nr_sectors)
 {
-	struct nullb_device *dev;
+	struct nullb_device *dev = cmd->nq->dev;
 	struct nullb_zone *zone;
 	blk_status_t sts;
 
+	/* Handle when the sector falls in the emulated area */
+	if (unlikely(null_verify_sector_violation(dev, sector)))
+		return null_handle_po2_zone_emu_violation(cmd, op);
+
+	/* The sector value is updated if po2 emulation is enabled, else it
+	 * will have no effect on the value
+	 */
+	sector = dev->zone_update_sector(dev, sector);
+
 	switch (op) {
 	case REQ_OP_WRITE:
 		return null_zone_write(cmd, sector, nr_sectors, false);
@@ -669,8 +825,7 @@ blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
 	case REQ_OP_ZONE_FINISH:
 		return null_zone_mgmt(cmd, op, sector);
 	default:
-		dev = cmd->nq->dev;
-		zone = &dev->zones[null_zone_no(dev, sector)];
+		zone = &dev->zones[dev->zone_no(dev, sector)];
 
 		null_lock_zone(dev, zone);
 		sts = null_process_cmd(cmd, op, sector, nr_sectors);
-- 
2.25.1

