Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56376 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753131AbdAZL66 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 06:58:58 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 15/37] thp: do not threat slab pages as huge in hpage_{nr_pages,size,mask}
Date: Thu, 26 Jan 2017 14:57:57 +0300
Message-Id: <20170126115819.58875-16-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170126115819.58875-1-kirill.shutemov@linux.intel.com>
References: <20170126115819.58875-1-kirill.shutemov@linux.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Slab pages can be compound, but we shouldn't threat them as THP for
pupose of hpage_* helpers, otherwise it would lead to confusing results.

For instance, ext4 uses slab pages for journal pages and we shouldn't
confuse them with THPs. The easiest way is to exclude them in hpage_*
helpers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/huge_mm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e5c9c26d2439..5e6c408f5b47 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -137,21 +137,21 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 }
 static inline int hpage_nr_pages(struct page *page)
 {
-	if (unlikely(PageTransHuge(page)))
+	if (unlikely(!PageSlab(page) && PageTransHuge(page)))
 		return HPAGE_PMD_NR;
 	return 1;
 }
 
 static inline int hpage_size(struct page *page)
 {
-	if (unlikely(PageTransHuge(page)))
+	if (unlikely(!PageSlab(page) && PageTransHuge(page)))
 		return HPAGE_PMD_SIZE;
 	return PAGE_SIZE;
 }
 
 static inline unsigned long hpage_mask(struct page *page)
 {
-	if (unlikely(PageTransHuge(page)))
+	if (unlikely(!PageSlab(page) && PageTransHuge(page)))
 		return HPAGE_PMD_MASK;
 	return PAGE_MASK;
 }
-- 
2.11.0

