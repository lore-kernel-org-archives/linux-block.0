Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445C8C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1303160F46
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhHPQOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHPQOs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:14:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBDEC061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=culPR0flerhA5KOWs29OcNom+4zzZb7+sa+sr6yhFns=; b=PxSHOT69U3HcE5UHg10vM4yxAR
        d3Y+q0dgdU66pqanJVkjecQuHFu2VCgmf/LYG5gqkRq8mmvOwx+ODmcVs+nSfCX1crtVn+DJbNlvD
        QCZprGTE/KebKbXsSnUdMd98KjMmkpFWzxmMclE3Xukf1czBAU9nNWtAy5l9Ed+/7qTMJ3/kqrhOd
        U0wnRp/oac3Bz8nhnxYgih8nn9kkl+tx27Net+rAh6uF1Hm9aI9j7euKXBs+aZ4xGEhWhjzosngrG
        NmL5Ltc9CiH8XCZv14SBxdUs8G4xr96EL0II4xNj3NgQrcACUxCltz9x2G3Ah32qnt8YsrXDU0gkN
        ogfaL5Dw==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFfEg-001ZD5-AN; Mon, 16 Aug 2021 16:13:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org
Subject: [PATCH 3/4] pf: cleanup initialization
Date:   Mon, 16 Aug 2021 18:11:09 +0200
Message-Id: <20210816161110.909076-4-hch@lst.de>
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
 drivers/block/paride/pf.c | 223 +++++++++++++++++---------------------
 1 file changed, 99 insertions(+), 124 deletions(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index d5b9c88ba76f..f471d48a87bc 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -214,7 +214,6 @@ static int pf_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
 static void pf_release(struct gendisk *disk, fmode_t mode);
 
-static int pf_detect(void);
 static void do_pf_read(void);
 static void do_pf_read_start(void);
 static void do_pf_write(void);
@@ -285,45 +284,6 @@ static const struct blk_mq_ops pf_mq_ops = {
 	.queue_rq	= pf_queue_rq,
 };
 
-static void __init pf_init_units(void)
-{
-	struct pf_unit *pf;
-	int unit;
-
-	pf_drive_count = 0;
-	for (unit = 0, pf = units; unit < PF_UNITS; unit++, pf++) {
-		struct gendisk *disk;
-
-		if (blk_mq_alloc_sq_tag_set(&pf->tag_set, &pf_mq_ops, 1,
-				BLK_MQ_F_SHOULD_MERGE))
-			continue;
-
-		disk = blk_mq_alloc_disk(&pf->tag_set, pf);
-		if (IS_ERR(disk)) {
-			blk_mq_free_tag_set(&pf->tag_set);
-			continue;
-		}
-
-		INIT_LIST_HEAD(&pf->rq_list);
-		blk_queue_max_segments(disk->queue, cluster);
-		blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
-		pf->disk = disk;
-		pf->pi = &pf->pia;
-		pf->media_status = PF_NM;
-		pf->drive = (*drives[unit])[D_SLV];
-		pf->lun = (*drives[unit])[D_LUN];
-		snprintf(pf->name, PF_NAMELEN, "%s%d", name, unit);
-		disk->major = major;
-		disk->first_minor = unit;
-		disk->minors = 1;
-		strcpy(disk->disk_name, pf->name);
-		disk->fops = &pf_fops;
-		disk->events = DISK_EVENT_MEDIA_CHANGE;
-		if (!(*drives[unit])[D_PRT])
-			pf_drive_count++;
-	}
-}
-
 static int pf_open(struct block_device *bdev, fmode_t mode)
 {
 	struct pf_unit *pf = bdev->bd_disk->private_data;
@@ -718,59 +678,6 @@ static int pf_probe(struct pf_unit *pf)
 	return -1;
 }
 
-static int pf_detect(void)
-{
-	struct pf_unit *pf = units;
-	int k, unit;
-
-	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
-	       name, name, PF_VERSION, major, cluster, nice);
-
-	par_drv = pi_register_driver(name);
-	if (!par_drv) {
-		pr_err("failed to register %s driver\n", name);
-		return -1;
-	}
-	k = 0;
-	if (pf_drive_count == 0) {
-		if (pi_init(pf->pi, 1, -1, -1, -1, -1, -1, pf_scratch, PI_PF,
-			    verbose, pf->name)) {
-			if (!pf_probe(pf) && pf->disk) {
-				pf->present = 1;
-				k++;
-			} else
-				pi_release(pf->pi);
-		}
-
-	} else
-		for (unit = 0; unit < PF_UNITS; unit++, pf++) {
-			int *conf = *drives[unit];
-			if (!conf[D_PRT])
-				continue;
-			if (pi_init(pf->pi, 0, conf[D_PRT], conf[D_MOD],
-				    conf[D_UNI], conf[D_PRO], conf[D_DLY],
-				    pf_scratch, PI_PF, verbose, pf->name)) {
-				if (pf->disk && !pf_probe(pf)) {
-					pf->present = 1;
-					k++;
-				} else
-					pi_release(pf->pi);
-			}
-		}
-	if (k)
-		return 0;
-
-	printk("%s: No ATAPI disk detected\n", name);
-	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-		if (!pf->disk)
-			continue;
-		blk_cleanup_disk(pf->disk);
-		blk_mq_free_tag_set(&pf->tag_set);
-	}
-	pi_unregister_driver(par_drv);
-	return -1;
-}
-
 /* The i/o request engine */
 
 static int pf_start(struct pf_unit *pf, int cmd, int b, int c)
@@ -1014,61 +921,129 @@ static void do_pf_write_done(void)
 	next_request(0);
 }
 
+static int __init pf_init_unit(struct pf_unit *pf, bool autoprobe, int port,
+		int mode, int unit, int protocol, int delay, int ms)
+{
+	struct gendisk *disk;
+	int ret;
+
+	ret = blk_mq_alloc_sq_tag_set(&pf->tag_set, &pf_mq_ops, 1,
+				      BLK_MQ_F_SHOULD_MERGE);
+	if (ret)
+		return ret;
+
+	disk = blk_mq_alloc_disk(&pf->tag_set, pf);
+	if (IS_ERR(disk)) {
+		ret = PTR_ERR(disk);
+		goto out_free_tag_set;
+	}
+	disk->major = major;
+	disk->first_minor = pf - units;
+	disk->minors = 1;
+	strcpy(disk->disk_name, pf->name);
+	disk->fops = &pf_fops;
+	disk->events = DISK_EVENT_MEDIA_CHANGE;
+	disk->private_data = pf;
+
+	blk_queue_max_segments(disk->queue, cluster);
+	blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
+
+	INIT_LIST_HEAD(&pf->rq_list);
+	pf->disk = disk;
+	pf->pi = &pf->pia;
+	pf->media_status = PF_NM;
+	pf->drive = (*drives[disk->first_minor])[D_SLV];
+	pf->lun = (*drives[disk->first_minor])[D_LUN];
+	snprintf(pf->name, PF_NAMELEN, "%s%d", name, disk->first_minor);
+
+	if (!pi_init(pf->pi, autoprobe, port, mode, unit, protocol, delay,
+			pf_scratch, PI_PF, verbose, pf->name))
+		goto out_free_disk;
+	if (pf_probe(pf))
+		goto out_pi_release;
+
+	add_disk(disk);
+	pf->present = 1;
+	return 0;
+
+out_pi_release:
+	pi_release(pf->pi);
+out_free_disk:
+	blk_cleanup_disk(pf->disk);
+out_free_tag_set:
+	blk_mq_free_tag_set(&pf->tag_set);
+	return ret;
+}
+
 static int __init pf_init(void)
 {				/* preliminary initialisation */
 	struct pf_unit *pf;
-	int unit;
+	int found = 0, unit;
 
 	if (disable)
 		return -EINVAL;
 
-	pf_init_units();
+	if (register_blkdev(major, name))
+		return -EBUSY;
 
-	if (pf_detect())
-		return -ENODEV;
-	pf_busy = 0;
+	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
+	       name, name, PF_VERSION, major, cluster, nice);
 
-	if (register_blkdev(major, name)) {
-		for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-			if (!pf->disk)
-				continue;
-			blk_cleanup_queue(pf->disk->queue);
-			blk_mq_free_tag_set(&pf->tag_set);
-			put_disk(pf->disk);
-		}
-		return -EBUSY;
+	par_drv = pi_register_driver(name);
+	if (!par_drv) {
+		pr_err("failed to register %s driver\n", name);
+		goto out_unregister_blkdev;
 	}
 
-	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-		struct gendisk *disk = pf->disk;
+	for (unit = 0; unit < PF_UNITS; unit++) {
+		if (!(*drives[unit])[D_PRT])
+			pf_drive_count++;
+	}
 
-		if (!pf->present)
-			continue;
-		disk->private_data = pf;
-		add_disk(disk);
+	pf = units;
+	if (pf_drive_count == 0) {
+		if (pf_init_unit(pf, 1, -1, -1, -1, -1, -1, verbose))
+			found++;
+	} else {
+		for (unit = 0; unit < PF_UNITS; unit++, pf++) {
+			int *conf = *drives[unit];
+			if (!conf[D_PRT])
+				continue;
+			if (pf_init_unit(pf, 0, conf[D_PRT], conf[D_MOD],
+				    conf[D_UNI], conf[D_PRO], conf[D_DLY],
+				    verbose))
+				found++;
+		}
+	}
+	if (!found) {
+		printk("%s: No ATAPI disk detected\n", name);
+		goto out_unregister_pi_driver;
 	}
+	pf_busy = 0;
 	return 0;
+
+out_unregister_pi_driver:
+	pi_unregister_driver(par_drv);
+out_unregister_blkdev:
+	unregister_blkdev(major, name);
+	return -ENODEV;
 }
 
 static void __exit pf_exit(void)
 {
 	struct pf_unit *pf;
 	int unit;
-	unregister_blkdev(major, name);
+
 	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-		if (!pf->disk)
+		if (!pf->present)
 			continue;
-
-		if (pf->present)
-			del_gendisk(pf->disk);
-
-		blk_cleanup_queue(pf->disk->queue);
+		del_gendisk(pf->disk);
+		blk_cleanup_disk(pf->disk);
 		blk_mq_free_tag_set(&pf->tag_set);
-		put_disk(pf->disk);
-
-		if (pf->present)
-			pi_release(pf->pi);
+		pi_release(pf->pi);
 	}
+
+	unregister_blkdev(major, name);
 }
 
 MODULE_LICENSE("GPL");
-- 
2.30.2

