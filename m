Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D906C6377E
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 22:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6F2611CE
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 22:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386177AbhGSVbu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 17:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383866AbhGSSOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 14:14:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D0EC061574;
        Mon, 19 Jul 2021 11:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3YXV7bsz65ycT7LtiOSUerTEWLmLCqMdPeOobe2FK+Y=; b=UeKoKZpAdOt2FXA5UVmWeuV+JS
        E5+Nzf8tps7DVB9p5CzJ9m5OGEWskLgO7tHg2xhOIZn/YV7sHZ0gxi1LfFbPtnIV2blAfPPT71NyX
        2sWzY7tqXADZrbsaNFe9BIXFTUE71I7ZPamuwrvi6fLupXw1ed+J5kzEddwIL0EAzMnC2Pbhm3nGA
        WklbdYhVnXiVG06pku0fzaPOu9RkUi3rVZJYmFWWBYaqio6IX6LEraTmEZgiogx9Yk/fVbdGIoxKe
        GDApKtwyUS2G8TGjGfEhC9AVpw6Ruqzvy4UB1zrxyN81qdRGgDft07zKziKhxEki3UOh/W/9ucFQ6
        8BuAskNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YO5-007MNU-AT; Mon, 19 Jul 2021 18:53:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v15 15/17] iomap: Convert iomap_write_end_inline to take a folio
Date:   Mon, 19 Jul 2021 19:39:59 +0100
Message-Id: <20210719184001.1750630-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inline data only occupies a single page, but using a folio means that
we don't need to call compound_head() in PageUptodate().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 23ee86aba9d6..f8ca307270e7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -664,18 +664,18 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	return copied;
 }
 
-static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
+static size_t iomap_write_end_inline(struct inode *inode, struct folio *folio,
 		struct iomap *iomap, loff_t pos, size_t copied)
 {
 	void *addr;
 
-	WARN_ON_ONCE(!PageUptodate(page));
+	WARN_ON_ONCE(!folio_test_uptodate(folio));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
-	flush_dcache_page(page);
-	addr = kmap_atomic(page);
+	flush_dcache_folio(folio);
+	addr = kmap_local_folio(folio, 0);
 	memcpy(iomap->inline_data + pos, addr + pos, copied);
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 
 	mark_inode_dirty(inode);
 	return copied;
@@ -692,7 +692,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	size_t ret;
 
 	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
+		ret = iomap_write_end_inline(inode, folio, iomap, pos, copied);
 	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
 				page, NULL);
-- 
2.30.2

