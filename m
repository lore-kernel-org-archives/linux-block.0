Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D325BEB64DD
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 13:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbjFNNtW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 09:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245132AbjFNNtB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 09:49:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FA2211F;
        Wed, 14 Jun 2023 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=b3Y3/1awi/EIUtJLSYKdDfjVRJbSniVIB1Dlm1y0AL0=; b=uWEIEEbCH3UWnrZPe2J7cDmYLd
        O4Xj5AZCGsFXCimSKq5lz6aOuksqDgqazL9wSmVsHWLHLSk17R/3rs+QZzZZ7wbXMrjv2bTZxaXQa
        iWT86t8NpwX1P0IyfWfzBJJjCnm3uujbBGVJywSX1MdFgvgU7UAFJ8Q3acwQYGAz5bFiezYUr9JbX
        1bIXUbB3NisFfH4953N2bWGqYwBFv3EWV35lEsq9bZsBLQrV0bgDGbgLA77UOsxnk8yAcPuyS/0T2
        d6WlnfqURx8jDVpUxjxVBSCxnv0qwPLQuXM9kKcAUOFv6k9QrBRrYRrod/9pQBLUPdj6S+YkS219Z
        JswljtgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9Qrp-006Nnl-5o; Wed, 14 Jun 2023 13:48:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] highmem: Add memcpy_from_folio()
Date:   Wed, 14 Jun 2023 14:48:53 +0100
Message-Id: <20230614134853.1521439-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230614114637.89759-1-hare@suse.de>
References: <20230614114637.89759-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the folio equivalent of memcpy_from_page(), but it handles large
highmem folios.  It may be a little too big to inline on systems that
have CONFIG_HIGHMEM enabled but on systems we actually care about almost
all the code will be eliminated.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ec39f544113d..d47f4a09f2fa 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -536,6 +536,34 @@ static inline void memcpy_to_folio(struct folio *folio, size_t offset,
 	flush_dcache_folio(folio);
 }
 
+/**
+ * memcpy_from_folio - Copy a range of bytes from a folio
+ * @to: The memory to copy to.
+ * @folio: The folio to read from.
+ * @offset: The first byte in the folio to read.
+ * @len: The number of bytes to copy.
+ */
+static inline void memcpy_from_folio(char *to, struct folio *folio,
+		size_t offset, size_t len)
+{
+	size_t n = len;
+
+	VM_BUG_ON(offset + len > folio_size(folio));
+
+	if (folio_test_highmem(folio))
+		n = min(len, PAGE_SIZE - offset_in_page(offset));
+	for (;;) {
+		char *from = kmap_local_folio(folio, offset);
+		memcpy(to, from, n);
+		kunmap_local(from);
+		if (!folio_test_highmem(folio) || n == len)
+			break;
+		offset += n;
+		len -= n;
+		n = min(len, PAGE_SIZE);
+	}
+}
+
 static inline void put_and_unmap_page(struct page *page, void *addr)
 {
 	kunmap_local(addr);
-- 
2.39.2

