Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF799C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8592B60FC3
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhHPQPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHPQPU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:15:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765D8C061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qySWOLEb8ooS+qz0JoO67xh3RyRjz+xgTEiGa+XS90Q=; b=VVWyypmw72S8f1siMxfJcD8CZK
        O7Urq6ygvDjPwUN/OLsvL2cUw3C1HXB48APvUsQ1ggsWXTLkXBRkPuoIDaC4nTB576SeafbqFUh+S
        zLWWKgHYpu4n6PHZnXs1RjVsP+g8TaGqSPdNFaFDeGJvsVe/hCCB30n8xW6VECHSXFN+SFZIYSzWJ
        e58ACMkqVhE/dCsYZbTNZulTGej40IMQq8ASB1IetDj8QPf1I29w+t6FODhaB+HbD2MU4tT7YSmWk
        S2ykXpDv8rMqlBeve/BsECL2vsfGbCRUYBug7anGnpl1lEYXBarzK1JCSBK8vnhAY3QOKhc2G2Nw/
        84cSpmVA==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFfFP-001ZF9-RK; Mon, 16 Aug 2021 16:14:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org
Subject: [PATCH 4/4] pd: cleanup initialization
Date:   Mon, 16 Aug 2021 18:11:10 +0200
Message-Id: <20210816161110.909076-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816161110.909076-1-hch@lst.de>
References: <20210816161110.909076-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Refactor the pf initialization to have a dedicated helper to initialize
a single disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/paride/pd.c | 142 +++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 9b3298926356..500b89a4bdaf 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -875,9 +875,27 @@ static const struct blk_mq_ops pd_mq_ops = {
 	.queue_rq	= pd_queue_rq,
 };
 
-static void pd_probe_drive(struct pd_unit *disk)
+static int pd_probe_drive(struct pd_unit *disk, int autoprobe, int port,
+		int mode, int unit, int protocol, int delay)
 {
+	int index = disk - pd;
+	int *parm = *drives[index];
 	struct gendisk *p;
+	int ret;
+
+	disk->pi = &disk->pia;
+	disk->access = 0;
+	disk->changed = 1;
+	disk->capacity = 0;
+	disk->drive = parm[D_SLV];
+	snprintf(disk->name, PD_NAMELEN, "%s%c", name, 'a' + index);
+	disk->alt_geom = parm[D_GEO];
+	disk->standby = parm[D_SBY];
+	INIT_LIST_HEAD(&disk->rq_list);
+
+	if (!pi_init(disk->pi, autoprobe, port, mode, unit, protocol, delay,
+			pd_scratch, PI_PD, verbose, disk->name))
+		return -ENXIO;
 
 	memset(&disk->tag_set, 0, sizeof(disk->tag_set));
 	disk->tag_set.ops = &pd_mq_ops;
@@ -887,14 +905,14 @@ static void pd_probe_drive(struct pd_unit *disk)
 	disk->tag_set.queue_depth = 2;
 	disk->tag_set.numa_node = NUMA_NO_NODE;
 	disk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
-
-	if (blk_mq_alloc_tag_set(&disk->tag_set))
-		return;
+	ret = blk_mq_alloc_tag_set(&disk->tag_set);
+	if (ret)
+		goto pi_release;
 
 	p = blk_mq_alloc_disk(&disk->tag_set, disk);
-	if (!p) {
-		blk_mq_free_tag_set(&disk->tag_set);
-		return;
+	if (IS_ERR(p)) {
+		ret = PTR_ERR(p);
+		goto free_tag_set;
 	}
 	disk->gd = p;
 
@@ -905,102 +923,84 @@ static void pd_probe_drive(struct pd_unit *disk)
 	p->minors = 1 << PD_BITS;
 	p->events = DISK_EVENT_MEDIA_CHANGE;
 	p->private_data = disk;
-
 	blk_queue_max_hw_sectors(p->queue, cluster);
 	blk_queue_bounce_limit(p->queue, BLK_BOUNCE_HIGH);
 
 	if (disk->drive == -1) {
-		for (disk->drive = 0; disk->drive <= 1; disk->drive++)
-			if (pd_special_command(disk, pd_identify) == 0)
-				return;
-	} else if (pd_special_command(disk, pd_identify) == 0)
-		return;
-	disk->gd = NULL;
+		for (disk->drive = 0; disk->drive <= 1; disk->drive++) {
+			ret = pd_special_command(disk, pd_identify);
+			if (ret == 0)
+				break;
+		}
+	} else {
+		ret = pd_special_command(disk, pd_identify);
+	}
+	if (ret)
+		goto put_disk;
+	set_capacity(disk->gd, disk->capacity);
+	add_disk(disk->gd);
+	return 0;
+put_disk:
 	put_disk(p);
+	disk->gd = NULL;
+free_tag_set:
+	blk_mq_free_tag_set(&disk->tag_set);
+pi_release:
+	pi_release(disk->pi);
+	return ret;
 }
 
-static int pd_detect(void)
+static int __init pd_init(void)
 {
 	int found = 0, unit, pd_drive_count = 0;
 	struct pd_unit *disk;
 
-	for (unit = 0; unit < PD_UNITS; unit++) {
-		int *parm = *drives[unit];
-		struct pd_unit *disk = pd + unit;
-		disk->pi = &disk->pia;
-		disk->access = 0;
-		disk->changed = 1;
-		disk->capacity = 0;
-		disk->drive = parm[D_SLV];
-		snprintf(disk->name, PD_NAMELEN, "%s%c", name, 'a'+unit);
-		disk->alt_geom = parm[D_GEO];
-		disk->standby = parm[D_SBY];
-		if (parm[D_PRT])
-			pd_drive_count++;
-		INIT_LIST_HEAD(&disk->rq_list);
-	}
+	if (disable)
+		return -ENODEV;
+
+	if (register_blkdev(major, name))
+		return -ENODEV;
+
+	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
+	       name, name, PD_VERSION, major, cluster, nice);
 
 	par_drv = pi_register_driver(name);
 	if (!par_drv) {
 		pr_err("failed to register %s driver\n", name);
-		return -1;
+		goto out_unregister_blkdev;
 	}
 
-	if (pd_drive_count == 0) { /* nothing spec'd - so autoprobe for 1 */
-		disk = pd;
-		if (pi_init(disk->pi, 1, -1, -1, -1, -1, -1, pd_scratch,
-			    PI_PD, verbose, disk->name)) {
-			pd_probe_drive(disk);
-			if (!disk->gd)
-				pi_release(disk->pi);
-		}
+	for (unit = 0; unit < PD_UNITS; unit++) {
+		int *parm = *drives[unit];
 
+		if (parm[D_PRT])
+			pd_drive_count++;
+	}
+
+	if (pd_drive_count == 0) { /* nothing spec'd - so autoprobe for 1 */
+		if (!pd_probe_drive(pd, 1, -1, -1, -1, -1, -1))
+			found++;
 	} else {
 		for (unit = 0, disk = pd; unit < PD_UNITS; unit++, disk++) {
 			int *parm = *drives[unit];
 			if (!parm[D_PRT])
 				continue;
-			if (pi_init(disk->pi, 0, parm[D_PRT], parm[D_MOD],
-				     parm[D_UNI], parm[D_PRO], parm[D_DLY],
-				     pd_scratch, PI_PD, verbose, disk->name)) {
-				pd_probe_drive(disk);
-				if (!disk->gd)
-					pi_release(disk->pi);
-			}
-		}
-	}
-	for (unit = 0, disk = pd; unit < PD_UNITS; unit++, disk++) {
-		if (disk->gd) {
-			set_capacity(disk->gd, disk->capacity);
-			add_disk(disk->gd);
-			found = 1;
+			if (!pd_probe_drive(disk, 0, parm[D_PRT], parm[D_MOD],
+					parm[D_UNI], parm[D_PRO], parm[D_DLY]))
+				found++;
 		}
 	}
 	if (!found) {
 		printk("%s: no valid drive found\n", name);
-		pi_unregister_driver(par_drv);
+		goto out_pi_unregister_driver;
 	}
-	return found;
-}
-
-static int __init pd_init(void)
-{
-	if (disable)
-		goto out1;
-
-	if (register_blkdev(major, name))
-		goto out1;
-
-	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
-	       name, name, PD_VERSION, major, cluster, nice);
-	if (!pd_detect())
-		goto out2;
 
 	return 0;
 
-out2:
+out_pi_unregister_driver:
+	pi_unregister_driver(par_drv);
+out_unregister_blkdev:
 	unregister_blkdev(major, name);
-out1:
 	return -ENODEV;
 }
 
-- 
2.30.2

