Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC05C433DF
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 10:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2325722268
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 10:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="usqFcIX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgJSKOC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 06:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJSKOC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 06:14:02 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B2AC0613CE;
        Mon, 19 Oct 2020 03:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ZUsuMrR+ngWpncutSCoMS/lWOgKT6Cj9cHkeDMetR0=; b=usqFcIX/i+y71mXlgiCmt07zPf
        3GhE+28+QPqGVJEeCsK6m/+gyJ2SoyTGn6vthGjNUeXDKMBvpztWgc6iZXcpYvzluOq5ZFdb1GpZF
        jeVyYJ78fusnRlk8MH7yyIeehMAolr8QLdll8bczFg7EW1AupGLl+Qv3r4H0/Qgmq/LOo7gUPJxpi
        h2ep0USqn2voW1yuaECtBbzehj6yAeWYqtbyC6Nkh0BP1NugiBOV/5buw1x97OU9Et3nvMoscX57L
        ZvS1/r8M5QLWM6cD4qEwb1tlDq0CmouxSIHCgn6hYxEzBC0qHRrUnPaZNodjwoGsv222RX5rh7epH
        wDakJl8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUSAt-0002S3-1F; Mon, 19 Oct 2020 10:13:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACA9A3035D4;
        Mon, 19 Oct 2020 12:13:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93F622B07595D; Mon, 19 Oct 2020 12:13:53 +0200 (CEST)
Date:   Mon, 19 Oct 2020 12:13:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Mike Galbraith <umgwanakikbuti@gmail.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, bigeasy@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] zram: Fix __zram_bvec_{read,write}() locking order
Message-ID: <20201019101353.GJ2628@hirez.programming.kicks-ass.net>
References: <CABXGCsOL0pW0Ghh-w5d12P75ve6FS9Rgmzm6DvsYbJY-jMTCdg@mail.gmail.com>
 <20201016124009.GQ2611@hirez.programming.kicks-ass.net>
 <20201016153324.GA1976566@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016153324.GA1976566@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Mikhail reported a lockdep spat detailing how __zram_bvec_read() and
__zram_bvec_write() use zstrm->lock and zspage->lock in opposite order.

Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/block/zram/zram_drv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9100ac36670a..c1e2c2e1cde8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1216,10 +1216,11 @@ static void zram_free_page(struct zram *zram, size_t index)
 static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 				struct bio *bio, bool partial_io)
 {
-	int ret;
+	struct zcomp_strm *zstrm;
 	unsigned long handle;
 	unsigned int size;
 	void *src, *dst;
+	int ret;
 
 	zram_slot_lock(zram, index);
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
@@ -1250,6 +1251,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 
 	size = zram_get_obj_size(zram, index);
 
+	if (size != PAGE_SIZE)
+		zstrm = zcomp_stream_get(zram->comp);
+
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
 		dst = kmap_atomic(page);
@@ -1257,8 +1261,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		kunmap_atomic(dst);
 		ret = 0;
 	} else {
-		struct zcomp_strm *zstrm = zcomp_stream_get(zram->comp);
-
 		dst = kmap_atomic(page);
 		ret = zcomp_decompress(zstrm, src, size, dst);
 		kunmap_atomic(dst);
