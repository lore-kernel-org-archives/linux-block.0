Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D226ECAAD8
	for <linux-block@archiver.kernel.org>; Fri, 16 Sep 2022 09:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiIPJBV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Sep 2022 05:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiIPJAn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2022 05:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD2522B24
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2022 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663318814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lLH/LEsSkzxTPnGv0SBl8ZLaxFFcwRIGgBQsZxPo6Lw=;
        b=cQPjr+5LM5XfKP9x94TLa27t51U7oMFGsiGRVUa07vOcsGJ/PM8wwfDjZ9fHH4aSNZRw7o
        fW2Uu2hEj2mYXM2v5aFAVCtsm9GxAowff8fP8fKeccEQ9MZfQl6q6QklIrfdifX97zPaf/
        cRF6VuFCIOQZ6f5Q2vbSC5ikFvMCPEw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-GfUqP7EHO7enyhYwVmXelA-1; Fri, 16 Sep 2022 05:00:13 -0400
X-MC-Unique: GfUqP7EHO7enyhYwVmXelA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD8D6833949;
        Fri, 16 Sep 2022 09:00:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5ADB492B04;
        Fri, 16 Sep 2022 09:00:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28G90CT9000923;
        Fri, 16 Sep 2022 05:00:12 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28G90CAd000919;
        Fri, 16 Sep 2022 05:00:12 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 16 Sep 2022 05:00:12 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 3/4] brd: enable discard
In-Reply-To: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2209160459470.543@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch implements discard in the brd driver. We use RCU to free the
page, so that if there are any concurrent readers or writes, they won't
touch the page after it is freed.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c
+++ linux-2.6/drivers/block/brd.c
@@ -112,6 +112,25 @@ static bool brd_insert_page(struct brd_d
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
@@ -289,6 +308,23 @@ static void brd_submit_bio(struct bio *b
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
+	if (bio_op(bio) == REQ_OP_DISCARD) {
+		sector_t len = bio_sectors(bio);
+		sector_t front_pad = -sector & (PAGE_SECTORS - 1);
+		sector += front_pad;
+		if (unlikely(len <= front_pad))
+			goto endio;
+		len -= front_pad;
+		len = round_down(len, PAGE_SECTORS);
+		while (len) {
+			brd_free_page(brd, sector);
+			sector += PAGE_SECTORS;
+			len -= PAGE_SECTORS;
+			cond_resched();
+		}
+		goto endio;
+	}
+
 	bio_for_each_segment(bvec, bio, iter) {
 		unsigned int len = bvec.bv_len;
 		int err;
@@ -306,6 +342,7 @@ static void brd_submit_bio(struct bio *b
 		sector += len >> SECTOR_SHIFT;
 	}
 
+endio:
 	bio_endio(bio);
 }
 
@@ -409,6 +446,9 @@ static int brd_alloc(int i)
 	 */
 	blk_queue_physical_block_size(disk->queue, PAGE_SIZE);
 
+	disk->queue->limits.discard_granularity = PAGE_SIZE;
+	blk_queue_max_discard_sectors(disk->queue, UINT_MAX);
+
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);

