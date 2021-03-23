Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71BAC433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 00:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F3D619A0
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 00:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCWAtm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 20:49:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:54568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhCWAtQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64E64AC1D;
        Tue, 23 Mar 2021 00:49:15 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] block/umem: convert tasklet to threaded irq
Date:   Mon, 22 Mar 2021 17:48:56 -0700
Message-Id: <20210323004856.10206-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tasklets have long been deprecated as being too heavy on the system
by running in irq context - and this is not a performance critical
path. If a higher priority process wants to run, it must wait for
the tasklet to finish before doing so. A more suitable equivalent
is to converted to threaded irq instead and deal with the async
processing in task context.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/block/umem.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 982732dbe82e..6b0a110f9233 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -120,7 +120,6 @@ struct cardinfo {
 
 	int  Active, Ready;
 
-	struct tasklet_struct	tasklet;
 	unsigned int dma_status;
 
 	struct {
@@ -243,7 +242,7 @@ static void dump_dmastat(struct cardinfo *card, unsigned int dmastat)
  * overloaded to record whether it was a read or a write.
  *
  * The interrupt handler only polls the device to clear the interrupt.
- * The processing of the result is done in a tasklet.
+ * The processing of the result is done in threaded irq.
  */
 
 static void mm_start_io(struct cardinfo *card)
@@ -405,7 +404,7 @@ static int add_bio(struct cardinfo *card)
 	return 1;
 }
 
-static void process_page(unsigned long data)
+static irqreturn_t process_page(int irq, void *__card)
 {
 	/* check if any of the requests in the page are DMA_COMPLETE,
 	 * and deal with them appropriately.
@@ -415,10 +414,10 @@ static void process_page(unsigned long data)
 	 */
 	struct mm_page *page;
 	struct bio *return_bio = NULL;
-	struct cardinfo *card = (struct cardinfo *)data;
+	struct cardinfo *card = (struct cardinfo *)__card;
 	unsigned int dma_status = card->dma_status;
 
-	spin_lock(&card->lock);
+	spin_lock_bh(&card->lock);
 	if (card->Active < 0)
 		goto out_unlock;
 	page = &card->mm_pages[card->Active];
@@ -493,7 +492,7 @@ static void process_page(unsigned long data)
 		mm_start_io(card);
 	}
  out_unlock:
-	spin_unlock(&card->lock);
+	spin_unlock_bh(&card->lock);
 
 	while (return_bio) {
 		struct bio *bio = return_bio;
@@ -502,6 +501,8 @@ static void process_page(unsigned long data)
 		bio->bi_next = NULL;
 		bio_endio(bio);
 	}
+
+	return IRQ_HANDLED;
 }
 
 static void mm_unplug(struct blk_plug_cb *cb, bool from_schedule)
@@ -637,11 +638,10 @@ HW_TRACE(0x30);
 
 	/* and process the DMA descriptors */
 	card->dma_status = dma_status;
-	tasklet_schedule(&card->tasklet);
 
 HW_TRACE(0x36);
 
-	return IRQ_HANDLED;
+	return IRQ_WAKE_THREAD;
 }
 
 /*
@@ -891,8 +891,6 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!card->queue)
 		goto failed_alloc;
 
-	tasklet_init(&card->tasklet, process_page, (unsigned long)card);
-
 	card->check_batteries = 0;
 
 	mem_present = readb(card->csr_remap + MEMCTRLSTATUS_MEMORY);
@@ -951,8 +949,8 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	data = ~data;
 	data += 1;
 
-	if (request_irq(dev->irq, mm_interrupt, IRQF_SHARED, DRIVER_NAME,
-			card)) {
+	if (request_threaded_irq(dev->irq, mm_interrupt, process_page,
+				 IRQF_SHARED, DRIVER_NAME, card)) {
 		dev_printk(KERN_ERR, &card->dev->dev,
 			"Unable to allocate IRQ\n");
 		ret = -ENODEV;
@@ -1015,7 +1013,6 @@ static void mm_pci_remove(struct pci_dev *dev)
 {
 	struct cardinfo *card = pci_get_drvdata(dev);
 
-	tasklet_kill(&card->tasklet);
 	free_irq(dev->irq, card);
 	iounmap(card->csr_remap);
 
-- 
2.26.2

