Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751231AbeDDTTE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Apr 2018 15:19:04 -0400
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
Subject: [RFC PATCH 08/79] mm/page: add helpers to find page mapping and private given a bio
Date: Wed,  4 Apr 2018 15:17:55 -0400
Message-Id: <20180404191831.5378-6-jglisse@redhat.com>
In-Reply-To: <20180404191831.5378-1-jglisse@redhat.com>
References: <20180404191831.5378-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

When page undergo io it is associated with a unique bio and thus we can
use it to lookup other page fields which are relevant only for the bio
under consideration.

Note this only apply when page is special ie page->mapping is pointing
to some special structure which is not a valid struct address_space.

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
 include/linux/mm-page.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/mm-page.h b/include/linux/mm-page.h
index 647a8a8cf9ba..6ec3ba19b1a4 100644
--- a/include/linux/mm-page.h
+++ b/include/linux/mm-page.h
@@ -24,6 +24,7 @@
 
 /* External struct dependencies: */
 struct address_space;
+struct bio;
 
 /* External function dependencies: */
 extern pgoff_t __page_file_index(struct page *page);
@@ -144,5 +145,13 @@ static inline struct address_space *fs_page_mapping_get_with_bh(
 	return page_mapping(page);
 }
 
+static inline void bio_page_mapping_and_private(struct page *page,
+		struct bio *bio, struct address_space **mappingp,
+		unsigned long *privatep)
+{
+	*mappingp = page->mapping;
+	*privatep = page_private(page);
+}
+
 #endif /* MM_PAGE_H */
 #endif /* DOT_NOT_INCLUDE___INSIDE_MM */
-- 
2.14.3
