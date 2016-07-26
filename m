Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14905 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290AbcGZAgA (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 25 Jul 2016 20:36:00 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Hugh Dickins <hughd@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv1, RFC 14/33] filemap: handle huge pages in do_generic_file_read()
Date: Tue, 26 Jul 2016 03:35:16 +0300
Message-Id: <1469493335-3622-15-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1469493335-3622-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1469493335-3622-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Most of work happans on head page. Only when we need to do copy data to
userspace we find relevant subpage.

We are still limited by PAGE_SIZE per iteration. Lifting this limitation
would require some more work.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/filemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a3183e688718..566c7e6ca423 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1819,6 +1819,7 @@ find_page:
 			if (unlikely(page == NULL))
 				goto no_cached_page;
 		}
+		page = compound_head(page);
 		if (PageReadahead(page)) {
 			page_cache_async_readahead(mapping,
 					ra, filp, page,
@@ -1895,7 +1896,8 @@ page_ok:
 		 * now we can copy it to user space...
 		 */
 
-		ret = copy_page_to_iter(page, offset, nr, iter);
+		ret = copy_page_to_iter(page + index - page->index, offset,
+				nr, iter);
 		offset += ret;
 		index += offset >> PAGE_SHIFT;
 		offset &= ~PAGE_MASK;
@@ -2315,6 +2317,7 @@ page_not_uptodate:
 	 * because there really aren't any performance issues here
 	 * and we need to check for errors.
 	 */
+	page = compound_head(page);
 	ClearPageError(page);
 	error = mapping->a_ops->readpage(file, page);
 	if (!error) {
-- 
2.8.1

