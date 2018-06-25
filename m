Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/15] memcontrol: schedule throttling if we are congested
Date: Mon, 25 Jun 2018 11:12:35 -0400
Message-Id: <20180625151243.2132-8-josef@toxicpanda.com>
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Tejun Heo <tj@kernel.org>

Memory allocations can induce swapping via kswapd or direct reclaim.  If
we are having IO done for us by kswapd and don't actually go into direct
reclaim we may never get scheduled for throttling.  So instead check to
see if our cgroup is congested, and if so schedule the throttling.
Before we return to user space the throttling stuff will only throttle
if we actually required it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 13 +++++++++++++
 include/linux/swap.h       | 11 ++++++++++-
 mm/huge_memory.c           |  6 +++---
 mm/memcontrol.c            | 13 +++++++++++++
 mm/memory.c                | 11 ++++++-----
 mm/shmem.c                 | 10 +++++-----
 mm/swapfile.c              | 31 +++++++++++++++++++++++++++++++
 7 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d99b71bc2c66..4d2e7f35f2dc 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -290,6 +290,9 @@ bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg);
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
 			  bool compound);
+int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
+			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
+			  bool compound);
 void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 			      bool lrucare, bool compound);
 void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
@@ -745,6 +748,16 @@ static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 	return 0;
 }
 
+static inline int mem_cgroup_try_charge_delay(struct page *page,
+					      struct mm_struct *mm,
+					      gfp_t gfp_mask,
+					      struct mem_cgroup **memcgp,
+					      bool compound)
+{
+	*memcgp = NULL;
+	return 0;
+}
+
 static inline void mem_cgroup_commit_charge(struct page *page,
 					    struct mem_cgroup *memcg,
 					    bool lrucare, bool compound)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2417d288e016..12725a4d82f0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -629,7 +629,6 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
 
 	return memcg->swappiness;
 }
-
 #else
 static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
 {
@@ -637,6 +636,16 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
 }
 #endif
 
+#if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
+extern void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
+					 gfp_t gfp_mask);
+#else
+static inline void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg,
+						int node, gfp_t gfp_mask)
+{
+}
+#endif
+
 #ifdef CONFIG_MEMCG_SWAP
 extern void mem_cgroup_swapout(struct page *page, swp_entry_t entry);
 extern int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a3a1815f8e11..9812ddad9961 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -555,7 +555,7 @@ static int __do_huge_pmd_anonymous_page(struct vm_fault *vmf, struct page *page,
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, gfp, &memcg, true)) {
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, gfp, &memcg, true)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
 		return VM_FAULT_FALLBACK;
@@ -1145,7 +1145,7 @@ static int do_huge_pmd_wp_page_fallback(struct vm_fault *vmf, pmd_t orig_pmd,
 		pages[i] = alloc_page_vma_node(GFP_HIGHUSER_MOVABLE, vma,
 					       vmf->address, page_to_nid(page));
 		if (unlikely(!pages[i] ||
-			     mem_cgroup_try_charge(pages[i], vma->vm_mm,
+			     mem_cgroup_try_charge_delay(pages[i], vma->vm_mm,
 				     GFP_KERNEL, &memcg, false))) {
 			if (pages[i])
 				put_page(pages[i]);
@@ -1315,7 +1315,7 @@ int do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_try_charge(new_page, vma->vm_mm,
+	if (unlikely(mem_cgroup_try_charge_delay(new_page, vma->vm_mm,
 					huge_gfp, &memcg, true))) {
 		put_page(new_page);
 		split_huge_pmd(vma, vmf->pmd, vmf->address);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2bd3df3d101a..5fffd28477c7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5458,6 +5458,19 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 	return ret;
 }
 
+int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
+			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
+			  bool compound)
+{
+	struct mem_cgroup *memcg;
+	int ret;
+
+	ret = mem_cgroup_try_charge(page, mm, gfp_mask, memcgp, compound);
+	memcg = *memcgp;
+	mem_cgroup_throttle_swaprate(memcg, page_to_nid(page), gfp_mask);
+	return ret;
+}
+
 /**
  * mem_cgroup_commit_charge - commit a page charge
  * @page: page to charge
diff --git a/mm/memory.c b/mm/memory.c
index 01f5464e0fd2..d0eea6d33b18 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2494,7 +2494,7 @@ static int wp_page_copy(struct vm_fault *vmf)
 		cow_user_page(new_page, old_page, vmf->address, vma);
 	}
 
-	if (mem_cgroup_try_charge(new_page, mm, GFP_KERNEL, &memcg, false))
+	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg, false))
 		goto oom_free_new;
 
 	__SetPageUptodate(new_page);
@@ -2994,8 +2994,8 @@ int do_swap_page(struct vm_fault *vmf)
 		goto out_page;
 	}
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL,
-				&memcg, false)) {
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL,
+					&memcg, false)) {
 		ret = VM_FAULT_OOM;
 		goto out_page;
 	}
@@ -3156,7 +3156,8 @@ static int do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL, &memcg, false))
+	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, GFP_KERNEL, &memcg,
+					false))
 		goto oom_free_page;
 
 	/*
@@ -3652,7 +3653,7 @@ static int do_cow_fault(struct vm_fault *vmf)
 	if (!vmf->cow_page)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_try_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL,
+	if (mem_cgroup_try_charge_delay(vmf->cow_page, vma->vm_mm, GFP_KERNEL,
 				&vmf->memcg, false)) {
 		put_page(vmf->cow_page);
 		return VM_FAULT_OOM;
diff --git a/mm/shmem.c b/mm/shmem.c
index 9d6c7e595415..a96af5690864 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1219,8 +1219,8 @@ int shmem_unuse(swp_entry_t swap, struct page *page)
 	 * the shmem_swaplist_mutex which might hold up shmem_writepage().
 	 * Charged back to the user (not to caller) when swap account is used.
 	 */
-	error = mem_cgroup_try_charge(page, current->mm, GFP_KERNEL, &memcg,
-			false);
+	error = mem_cgroup_try_charge_delay(page, current->mm, GFP_KERNEL,
+					    &memcg, false);
 	if (error)
 		goto out;
 	/* No radix_tree_preload: swap entry keeps a place for page in tree */
@@ -1697,7 +1697,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 				goto failed;
 		}
 
-		error = mem_cgroup_try_charge(page, charge_mm, gfp, &memcg,
+		error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
 				false);
 		if (!error) {
 			error = shmem_add_to_page_cache(page, mapping, index,
@@ -1803,7 +1803,7 @@ alloc_nohuge:		page = shmem_alloc_and_acct_page(gfp, inode,
 		if (sgp == SGP_WRITE)
 			__SetPageReferenced(page);
 
-		error = mem_cgroup_try_charge(page, charge_mm, gfp, &memcg,
+		error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
 				PageTransHuge(page));
 		if (error)
 			goto unacct;
@@ -2276,7 +2276,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	__SetPageSwapBacked(page);
 	__SetPageUptodate(page);
 
-	ret = mem_cgroup_try_charge(page, dst_mm, gfp, &memcg, false);
+	ret = mem_cgroup_try_charge_delay(page, dst_mm, gfp, &memcg, false);
 	if (ret)
 		goto out_release;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index cc2cf04d9018..2a74c76dec1f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3725,6 +3725,37 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
 	}
 }
 
+#if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
+void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
+				  gfp_t gfp_mask)
+{
+	struct swap_info_struct *si, *next;
+	if (!(gfp_mask & __GFP_IO) || !memcg)
+		return;
+
+	if (!blk_cgroup_congested())
+		return;
+
+	/*
+	 * We've already scheduled a throttle, avoid taking the global swap
+	 * lock.
+	 */
+	if (current->throttle_queue)
+		return;
+
+	spin_lock(&swap_avail_lock);
+	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
+				  avail_lists[node]) {
+		if (si->bdev) {
+			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
+						true);
+			break;
+		}
+	}
+	spin_unlock(&swap_avail_lock);
+}
+#endif
+
 static int __init swapfile_init(void)
 {
 	int nid;
-- 
2.14.3
