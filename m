Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D55C54EE9
	for <linux-block@archiver.kernel.org>; Fri, 16 Sep 2022 08:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiIPI7Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Sep 2022 04:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiIPI7W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2022 04:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A979AA8942
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2022 01:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663318760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pZYYV3Lko3mHTEp5cz3CxvuCyUYRPacIBzu5qyIc/4I=;
        b=f6bJvZ1F+e3y5+2KT1qaZ1b6dSzF/v4iugHgxUQlGkusCLrjUtdsXIkHp1U2mQxjaveyRF
        mqQnOUtc1imYS7uc2MIDn9JG40T4D8Pqdb8mOqlfG7cLZKor8NeeSIU1nLIR2Q9D/C38oG
        JoG5ZakWgXfirRZY62Y0b0PcbmLvWd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-z4fj9rQlPxWm5UsR2U-GxQ-1; Fri, 16 Sep 2022 04:59:19 -0400
X-MC-Unique: z4fj9rQlPxWm5UsR2U-GxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D2A4101E14C;
        Fri, 16 Sep 2022 08:59:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1362310EB8;
        Fri, 16 Sep 2022 08:59:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28G8xJWo000648;
        Fri, 16 Sep 2022 04:59:19 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28G8xJ63000645;
        Fri, 16 Sep 2022 04:59:19 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 16 Sep 2022 04:59:19 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 1/4] brd: make brd_insert_page return bool
In-Reply-To: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2209160458590.543@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

brd_insert_page returns a pointer to struct page, however the pointer is
never used (it is only compared against NULL), so to clean-up the code, we
make it return bool.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c
+++ linux-2.6/drivers/block/brd.c
@@ -78,11 +78,11 @@ static struct page *brd_lookup_page(stru
 }
 
 /*
- * Look up and return a brd's page for a given sector.
- * If one does not exist, allocate an empty page, and insert that. Then
- * return it.
+ * If the page exists, return true.
+ * If it does not exist, allocate an empty page, and insert that. Return true
+ * if the allocation was successful.
  */
-static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
+static bool brd_insert_page(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
 	struct page *page;
@@ -90,7 +90,7 @@ static struct page *brd_insert_page(stru
 
 	page = brd_lookup_page(brd, sector);
 	if (page)
-		return page;
+		return true;
 
 	/*
 	 * Must use NOIO because we don't want to recurse back into the
@@ -99,11 +99,11 @@ static struct page *brd_insert_page(stru
 	gfp_flags = GFP_NOIO | __GFP_ZERO | __GFP_HIGHMEM;
 	page = alloc_page(gfp_flags);
 	if (!page)
-		return NULL;
+		return false;
 
 	if (radix_tree_preload(GFP_NOIO)) {
 		__free_page(page);
-		return NULL;
+		return false;
 	}
 
 	spin_lock(&brd->brd_lock);
@@ -121,7 +121,7 @@ static struct page *brd_insert_page(stru
 
 	radix_tree_preload_end();
 
-	return page;
+	return true;
 }
 
 /*

