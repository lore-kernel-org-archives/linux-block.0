Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: jglisse@redhat.com
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [RFC PATCH 77/79] mm/ksm: hide set_page_stable_node() and page_stable_node()
Date: Wed,  4 Apr 2018 15:18:29 -0400
Message-Id: <20180404191831.5378-40-jglisse@redhat.com>
In-Reply-To: <20180404191831.5378-1-jglisse@redhat.com>
References: <20180404191831.5378-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

From: Jérôme Glisse <jglisse@redhat.com>

Hiding this 2 functions as preparatory step for generalizing ksm
write protection to other users. Moreover those two helpers can
not be use meaningfully outside ksm.c as the struct they deal with
is defined inside ksm.c.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
---
 include/linux/ksm.h | 12 ------------
 mm/ksm.c            | 11 +++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 44368b19b27e..83c664080798 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 #include <linux/sched/coredump.h>
 
-struct stable_node;
 struct mem_cgroup;
 
 #ifdef CONFIG_KSM
@@ -37,17 +36,6 @@ static inline void ksm_exit(struct mm_struct *mm)
 		__ksm_exit(mm);
 }
 
-static inline struct stable_node *page_stable_node(struct page *page)
-{
-	return PageKsm(page) ? page_rmapping(page) : NULL;
-}
-
-static inline void set_page_stable_node(struct page *page,
-					struct stable_node *stable_node)
-{
-	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
-}
-
 /*
  * When do_swap_page() first faults in from swap what used to be a KSM page,
  * no problem, it will be assigned to this vma's anon_vma; but thereafter,
diff --git a/mm/ksm.c b/mm/ksm.c
index 1c16a4309c1d..f9bd1251c288 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -316,6 +316,17 @@ static void __init ksm_slab_free(void)
 	mm_slot_cache = NULL;
 }
 
+static inline struct stable_node *page_stable_node(struct page *page)
+{
+	return PageKsm(page) ? page_rmapping(page) : NULL;
+}
+
+static inline void set_page_stable_node(struct page *page,
+					struct stable_node *stable_node)
+{
+	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
+}
+
 static __always_inline bool is_stable_node_chain(struct stable_node *chain)
 {
 	return chain->rmap_hlist_len == STABLE_NODE_CHAIN;
-- 
2.14.3
