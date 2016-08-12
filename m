Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64597 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630AbcHLSiy (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 12 Aug 2016 14:38:54 -0400
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
Subject: [PATCHv2 17/41] filemap: handle huge pages in filemap_fdatawait_range()
Date: Fri, 12 Aug 2016 21:38:00 +0300
Message-Id: <1471027104-115213-18-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1471027104-115213-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1471027104-115213-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We writeback whole huge page a time.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/filemap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 93fa97f143ab..429f9a0962b3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -372,9 +372,14 @@ static int __filemap_fdatawait_range(struct address_space *mapping,
 			if (page->index > end)
 				continue;
 
+			page = compound_head(page);
 			wait_on_page_writeback(page);
 			if (TestClearPageError(page))
 				ret = -EIO;
+			if (PageTransHuge(page)) {
+				index = page->index + HPAGE_PMD_NR;
+				i += index - pvec.pages[i]->index - 1;
+			}
 		}
 		pagevec_release(&pvec);
 		cond_resched();
-- 
2.8.1

