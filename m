Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FC4C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 17:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiITR64 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiITR6z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 13:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C2565540
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663696734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yo19XM/iIimPzZPnkTGgbhemyHu89K/JJjSJZr8d8Q8=;
        b=eXNhc28EHtJaa4g0YwLHxg2h3DGulBLnHQzAxTTmiKQ0f+JglQifZuiErPZCCwRb5Fzi8q
        LBu4gFgQGtuc2xQWdqHdP7ASrWqkMAPoEIV4mdG9/bBIwn8QjzHgXNXOeEod4b/DO8IOcE
        Q/URCWUfeokh+7eSUeAYVaS1MSkB4cw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-Px68ixthMYG57Tx4Eu3Gsw-1; Tue, 20 Sep 2022 13:58:52 -0400
X-MC-Unique: Px68ixthMYG57Tx4Eu3Gsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E7193C10682;
        Tue, 20 Sep 2022 17:58:51 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EE642027061;
        Tue, 20 Sep 2022 17:58:51 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28KHwp7U026565;
        Tue, 20 Sep 2022 13:58:51 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28KHwpHM026562;
        Tue, 20 Sep 2022 13:58:51 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 20 Sep 2022 13:58:51 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v2 3/4] brd: enable discard
In-Reply-To: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2209201358120.26535@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch implements discard in the brd driver. We use RCU to free the
page, so that if there are any concurrent readers or writes, they won't
touch the page after it is freed.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c
+++ linux-2.6/drivers/block/brd.c
@@ -48,6 +48,8 @@ struct brd_device {
 	u64			brd_nr_pages;
 };
 
+static bool discard;
+
 /*
  * Look up and return a brd's page for a given sector.
  * This must be called with the rcu lock held.
@@ -107,6 +109,25 @@ static bool brd_insert_page(struct brd_d
 	return true;
 }
 
+static void brd_free_page_rcu(struct rcu_head *head)
+{
+	struct page *page = container_of(head, struct page, rcu_head);
+	__free_page(page);
+}
+
+static void brd_free_page(struct brd_device *brd, sector_t sector)
+{
+	struct page *page;
+	pgoff_t idx;
+
+	spin_lock(&brd->brd_lock);
+	idx = sector >> PAGE_SECTORS_SHIFT;
+	page = radix_tree_delete(&brd->brd_pages, idx);
+	spin_unlock(&brd->brd_lock);
+	if (page)
+		call_rcu(&page->rcu_head, brd_free_page_rcu);
+}
+
 /*
  * Free all backing store pages and radix tree. This must only be called when
  * there are no other users of the device.
@@ -277,13 +298,44 @@ out:
 	return err;
 }
 
+void brd_do_discard(struct brd_device *brd, struct bio *bio)
+{
+	sector_t sector, len, front_pad;
+
+	if (unlikely(!discard)) {
+		bio->bi_status = BLK_STS_NOTSUPP;
+		return;
+	}
+
+	sector = bio->bi_iter.bi_sector;
+	len = bio_sectors(bio);
+	front_pad = -sector & (PAGE_SECTORS - 1);
+	sector += front_pad;
+	if (unlikely(len <= front_pad))
+		return;
+	len -= front_pad;
+	len = round_down(len, PAGE_SECTORS);
+	while (len) {
+		brd_free_page(brd, sector);
+		sector += PAGE_SECTORS;
+		len -= PAGE_SECTORS;
+		cond_resched();
+	}
+}
+
 static void brd_submit_bio(struct bio *bio)
 {
 	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
-	sector_t sector = bio->bi_iter.bi_sector;
+	sector_t sector;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
+	if (bio_op(bio) == REQ_OP_DISCARD) {
+		brd_do_discard(brd, bio);
+		goto endio;
+	}
+
+	sector = bio->bi_iter.bi_sector;
 	bio_for_each_segment(bvec, bio, iter) {
 		unsigned int len = bvec.bv_len;
 		int err;
@@ -301,6 +353,7 @@ static void brd_submit_bio(struct bio *b
 		sector += len >> SECTOR_SHIFT;
 	}
 
+endio:
 	bio_endio(bio);
 }
 
@@ -338,6 +391,10 @@ static int max_part = 1;
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
+static bool discard = false;
+module_param(discard, bool, 0444);
+MODULE_PARM_DESC(discard, "Support discard");
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");
@@ -404,6 +461,11 @@ static int brd_alloc(int i)
 	 */
 	blk_queue_physical_block_size(disk->queue, PAGE_SIZE);
 
+	if (discard) {
+		disk->queue->limits.discard_granularity = PAGE_SIZE;
+		blk_queue_max_discard_sectors(disk->queue, UINT_MAX);
+	}
+
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);

