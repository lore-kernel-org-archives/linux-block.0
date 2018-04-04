Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: jglisse@redhat.com
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 68/79] mm/vma_address: convert page's index lookup to be against specific mapping
Date: Wed,  4 Apr 2018 15:18:20 -0400
Message-Id: <20180404191831.5378-31-jglisse@redhat.com>
In-Reply-To: <20180404191831.5378-1-jglisse@redhat.com>
References: <20180404191831.5378-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

From: Jérôme Glisse <jglisse@redhat.com>

Pass down the mapping ...

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: linux-mm@kvack.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 mm/internal.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index e6bd35182dae..43e9ed27362f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -336,7 +336,9 @@ extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 static inline unsigned long
 __vma_address(struct page *page, struct vm_area_struct *vma)
 {
-	pgoff_t pgoff = page_to_pgoff(page);
+	struct address_space *mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
+
+	pgoff_t pgoff = _page_to_pgoff(page, mapping);
 	return vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 }
 
-- 
2.14.3
