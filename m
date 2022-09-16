Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64397C54EE9
	for <linux-block@archiver.kernel.org>; Fri, 16 Sep 2022 08:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiIPI7x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Sep 2022 04:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIPI7t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2022 04:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA7010543
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2022 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663318787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gLZ1ifzCMGqmdMekBa/cKQjbThmysWm3THwwlWh4QM4=;
        b=DEdAutHPqAZ1QwMGGMY516CiaA7+1Ibcr6dAcC9BgXtXRYc6ZL4EDKwgskt9CTHqgcfCLq
        C7NQ7tRoFRsEE2Z/aChLwSTiexdmnXX77qkSlE4dliD/CP91fn7CFbT7+8V6msR9G7hCYF
        QzE24d5fW+PQrC3gE2tGh60wiV12Hho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-0O-BKlJ0M32L7SZvehsyyw-1; Fri, 16 Sep 2022 04:59:44 -0400
X-MC-Unique: 0O-BKlJ0M32L7SZvehsyyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EB1C833949;
        Fri, 16 Sep 2022 08:59:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C3031121314;
        Fri, 16 Sep 2022 08:59:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28G8xhof000662;
        Fri, 16 Sep 2022 04:59:43 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28G8xhFV000659;
        Fri, 16 Sep 2022 04:59:43 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 16 Sep 2022 04:59:43 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 2/4] brd: extend the rcu regions to cover read and write
In-Reply-To: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2209160459250.543@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch extends the rcu regions, so that lookup followed by a read or
write of a page is done inside rcu read lock. This si be needed for the
following patch that enables discard.

Note that we also replace "BUG_ON(!page);" with "if (page) ..." in
copy_to_brd - the page may be NULL if write races with discard. In this
situation, the result is undefined, so we can actually skip the write
operation at all.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |   50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c
+++ linux-2.6/drivers/block/brd.c
@@ -50,29 +50,15 @@ struct brd_device {
 
 /*
  * Look up and return a brd's page for a given sector.
+ * This must be called with the rcu lock held.
  */
 static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
 	struct page *page;
 
-	/*
-	 * The page lifetime is protected by the fact that we have opened the
-	 * device node -- brd pages will never be deleted under us, so we
-	 * don't need any further locking or refcounting.
-	 *
-	 * This is strictly true for the radix-tree nodes as well (ie. we
-	 * don't actually need the rcu_read_lock()), however that is not a
-	 * documented feature of the radix-tree API so it is better to be
-	 * safe here (we don't have total exclusion from radix tree updates
-	 * here, only deletes).
-	 */
-	rcu_read_lock();
 	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
 	page = radix_tree_lookup(&brd->brd_pages, idx);
-	rcu_read_unlock();
-
-	BUG_ON(page && page->index != idx);
 
 	return page;
 }
@@ -88,7 +74,9 @@ static bool brd_insert_page(struct brd_d
 	struct page *page;
 	gfp_t gfp_flags;
 
+	rcu_read_lock();
 	page = brd_lookup_page(brd, sector);
+	rcu_read_unlock();
 	if (page)
 		return true;
 
@@ -198,23 +186,29 @@ static void copy_to_brd(struct brd_devic
 	size_t copy;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
-	page = brd_lookup_page(brd, sector);
-	BUG_ON(!page);
 
-	dst = kmap_atomic(page);
-	memcpy(dst + offset, src, copy);
-	kunmap_atomic(dst);
+	rcu_read_lock();
+	page = brd_lookup_page(brd, sector);
+	if (page) {
+		dst = kmap_atomic(page);
+		memcpy(dst + offset, src, copy);
+		kunmap_atomic(dst);
+	}
+	rcu_read_unlock();
 
 	if (copy < n) {
 		src += copy;
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
-		page = brd_lookup_page(brd, sector);
-		BUG_ON(!page);
 
-		dst = kmap_atomic(page);
-		memcpy(dst, src, copy);
-		kunmap_atomic(dst);
+		rcu_read_lock();
+		page = brd_lookup_page(brd, sector);
+		if (page) {
+			dst = kmap_atomic(page);
+			memcpy(dst, src, copy);
+			kunmap_atomic(dst);
+		}
+		rcu_read_unlock();
 	}
 }
 
@@ -230,6 +224,8 @@ static void copy_from_brd(void *dst, str
 	size_t copy;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
+
+	rcu_read_lock();
 	page = brd_lookup_page(brd, sector);
 	if (page) {
 		src = kmap_atomic(page);
@@ -237,11 +233,14 @@ static void copy_from_brd(void *dst, str
 		kunmap_atomic(src);
 	} else
 		memset(dst, 0, copy);
+	rcu_read_unlock();
 
 	if (copy < n) {
 		dst += copy;
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
+
+		rcu_read_lock();
 		page = brd_lookup_page(brd, sector);
 		if (page) {
 			src = kmap_atomic(page);
@@ -249,6 +248,7 @@ static void copy_from_brd(void *dst, str
 			kunmap_atomic(src);
 		} else
 			memset(dst, 0, copy);
+		rcu_read_unlock();
 	}
 }
 

