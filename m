Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: jglisse@redhat.com
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 07/79] mm/page: add helpers to find mapping give a page and buffer head
Date: Wed,  4 Apr 2018 15:17:54 -0400
Message-Id: <20180404191831.5378-5-jglisse@redhat.com>
In-Reply-To: <20180404191831.5378-1-jglisse@redhat.com>
References: <20180404191831.5378-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

From: Jérôme Glisse <jglisse@redhat.com>

For now this simply use exist page_mapping() inline. Latter it will
use buffer head pointer as a key to lookup mapping for write protected
page.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org
CC: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mm-page.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mm-page.h b/include/linux/mm-page.h
index 2981db45eeef..647a8a8cf9ba 100644
--- a/include/linux/mm-page.h
+++ b/include/linux/mm-page.h
@@ -132,5 +132,17 @@ static inline unsigned long _page_file_offset(struct page *page,
 	return page->index << PAGE_SHIFT;
 }
 
+/*
+ * fs_page_mapping_get_with_bh() - page mapping knowing buffer_head
+ * @page: page struct pointer for which we want the mapping
+ * @bh: buffer_head associated with the page for the mapping
+ * Returns: page mapping for the given buffer head
+ */
+static inline struct address_space *fs_page_mapping_get_with_bh(
+		struct page *page, struct buffer_head *bh)
+{
+	return page_mapping(page);
+}
+
 #endif /* MM_PAGE_H */
 #endif /* DOT_NOT_INCLUDE___INSIDE_MM */
-- 
2.14.3
