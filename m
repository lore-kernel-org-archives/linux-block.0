Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9C368947;
	Thu, 26 Feb 2026 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128935; cv=none; b=BSiYzaHc8Wt2wBPdtGBW6qmq0DPTLN+w7YnRuAulUELsIJKZdcdBL36B2exdnkUDNMlqPu95NT2EUxKJpYciem7XeVwliqXYcrfkzFCs7RHxoZ8Rzn1sb6Mn3kF8Fk2fvrHKIueXUMwcmtUDRzMMSMPCa/acDOHqeE1CUe/Ocmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128935; c=relaxed/simple;
	bh=zQHqTkrow2e/qB8SQ2FiRt3OzJM5ES1xW6nnz1Mp58A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvHmw/16WGGFyBgLUV+OQ1PSkoFur+KFgSo/KvPXQCj575VUYx3vTV0LePPtNmh/Qu5eiP7ATlYCG/s475iei1SMJsiwaFfMx8cK7Q0S0R1Tvo6PM2orDcbDNXm/v/NzR7pTdsAU9zaxuHxsM9OB2U/kaYZ/1jmH2uzPgQBX4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCmASTZT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCmASTZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D544C116C6;
	Thu, 26 Feb 2026 18:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772128935;
	bh=zQHqTkrow2e/qB8SQ2FiRt3OzJM5ES1xW6nnz1Mp58A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rCmASTZTAEGlHobwizKE7wFmQaZpy1abiwHYQqU0sOHQkSTHw6J+hdY3VdzVYnuP6
	 yhQDN2ia1OKsV6ulo5NsxvYXQUH5x0WLPZ5J2YSvTunCF56rd/OBjgCtdOrnFBf921
	 QVRWHmFMD6jX2DjsYqtPHl1tPfg2uflvoiexCo+rBnS35nD6EvyZ0waJbn93xk0r51
	 bCTTiiyyvryigMAKQoPA4O/PxFApi7r4PqQLfPI1PM0Wv4Xj8UySpwCCOETD0UlazY
	 WFf7UjLnKwaQl/h2VNmGkhNNIVMnNWrABysHm9cSfiZf2bo0p4LXCVMh19VEjmpNmr
	 tXg0B7sViv01w==
Message-ID: <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org>
Date: Thu, 26 Feb 2026 19:02:11 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Harry Yoo <harry.yoo@oracle.com>, Hao Li <hao.li@linux.dev>,
 Christoph Hellwig <hch@infradead.org>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org> <aZ7BbosIr2FvZFAe@fedora>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <aZ7BbosIr2FvZFAe@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/26 10:31, Ming Lei wrote:
> Hi Vlastimil,
> 
> On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUSE) wrote:
>> On 2/24/26 21:27, Vlastimil Babka wrote:
>> > 
>> > It made sense to me not to refill sheaves when we can't reclaim, but I
>> > didn't anticipate this interaction with mempools. We could change them
>> > but there might be others using a similar pattern. Maybe it would be for
>> > the best to just drop that heuristic from __pcs_replace_empty_main()
>> > (but carefully as some deadlock avoidance depends on it, we might need
>> > to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
>> > tomorrow to test this theory, unless someone beats me to it (feel free to).
>> Could you try this then, please? Thanks!
> 
> Thanks for working on this issue!
> 
> Unfortunately the patch doesn't make a difference on IOPS in the perf test,
> follows the collected perf profile on linus tree(basically 7.0-rc1 with your patch):

what about this patch in addition to the previous one? Thanks.

----8<----
From d3e8118c078996d1372a9f89285179d93971fdb2 Mon Sep 17 00:00:00 2001
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Thu, 26 Feb 2026 18:59:56 +0100
Subject: [PATCH] mm/slab: put barn on every online node

Including memoryless nodes.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slab.h |   7 ++-
 mm/slub.c | 146 ++++++++++++++++++++++++++++++++----------------------
 2 files changed, 94 insertions(+), 59 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 71c7261bf822..5b5e3ed6adae 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -191,6 +191,11 @@ struct kmem_cache_order_objects {
 	unsigned int x;
 };
 
+struct kmem_cache_per_node_ptrs {
+	struct node_barn *barn;
+	struct kmem_cache_node *node;
+};
+
 /*
  * Slab cache management.
  */
@@ -247,7 +252,7 @@ struct kmem_cache {
 	struct kmem_cache_stats __percpu *cpu_stats;
 #endif
 
-	struct kmem_cache_node *node[MAX_NUMNODES];
+	struct kmem_cache_per_node_ptrs per_node[MAX_NUMNODES];
 };
 
 /*
diff --git a/mm/slub.c b/mm/slub.c
index 258307270442..24f1f12d6a37 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -59,7 +59,7 @@
  *   0.  cpu_hotplug_lock
  *   1.  slab_mutex (Global Mutex)
  *   2a. kmem_cache->cpu_sheaves->lock (Local trylock)
- *   2b. node->barn->lock (Spinlock)
+ *   2b. barn->lock (Spinlock)
  *   2c. node->list_lock (Spinlock)
  *   3.  slab_lock(slab) (Only on some arches)
  *   4.  object_map_lock (Only for debugging)
@@ -136,7 +136,7 @@
  *   or spare sheaf can handle the allocation or free, there is no other
  *   overhead.
  *
- *   node->barn->lock (spinlock)
+ *   barn->lock (spinlock)
  *
  *   This lock protects the operations on per-NUMA-node barn. It can quickly
  *   serve an empty or full sheaf if available, and avoid more expensive refill
@@ -436,26 +436,24 @@ struct kmem_cache_node {
 	atomic_long_t total_objects;
 	struct list_head full;
 #endif
-	struct node_barn *barn;
 };
 
 static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 {
-	return s->node[node];
+	return s->per_node[node].node;
+}
+
+static inline struct node_barn *get_barn_node(struct kmem_cache *s, int node)
+{
+	return s->per_node[node].barn;
 }
 
 /*
- * Get the barn of the current cpu's closest memory node. It may not exist on
- * systems with memoryless nodes but without CONFIG_HAVE_MEMORYLESS_NODES
+ * Get the barn of the current cpu's memory node. It may be a memoryless node.
  */
 static inline struct node_barn *get_barn(struct kmem_cache *s)
 {
-	struct kmem_cache_node *n = get_node(s, numa_mem_id());
-
-	if (!n)
-		return NULL;
-
-	return n->barn;
+	return get_barn_node(s, numa_node_id());
 }
 
 /*
@@ -474,6 +472,12 @@ static inline struct node_barn *get_barn(struct kmem_cache *s)
  */
 static nodemask_t slab_nodes;
 
+/*
+ * Similar to slab_nodes but for where we have node_barn allocated.
+ * Corresponds to N_ONLINE nodes.
+ */
+static nodemask_t slab_barn_nodes;
+
 /*
  * Workqueue used for flushing cpu and kfree_rcu sheaves.
  */
@@ -5744,7 +5748,6 @@ bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
 
 static void rcu_free_sheaf(struct rcu_head *head)
 {
-	struct kmem_cache_node *n;
 	struct slab_sheaf *sheaf;
 	struct node_barn *barn = NULL;
 	struct kmem_cache *s;
@@ -5767,12 +5770,10 @@ static void rcu_free_sheaf(struct rcu_head *head)
 	if (__rcu_free_sheaf_prepare(s, sheaf))
 		goto flush;
 
-	n = get_node(s, sheaf->node);
-	if (!n)
+	barn = get_barn_node(s, sheaf->node);
+	if (!barn)
 		goto flush;
 
-	barn = n->barn;
-
 	/* due to slab_free_hook() */
 	if (unlikely(sheaf->size == 0))
 		goto empty;
@@ -5894,7 +5895,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 		rcu_sheaf = NULL;
 	} else {
 		pcs->rcu_free = NULL;
-		rcu_sheaf->node = numa_mem_id();
+		rcu_sheaf->node = numa_node_id();
 	}
 
 	/*
@@ -6121,7 +6122,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
 		return;
 
-	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
+	if (likely(!IS_ENABLED(CONFIG_NUMA) || (slab_nid(slab) == numa_mem_id())
+			|| !node_isset(slab_nid(slab), slab_nodes))
 	    && likely(!slab_test_pfmemalloc(slab))) {
 		if (likely(free_to_pcs(s, object, true)))
 			return;
@@ -7383,7 +7385,7 @@ static inline int calculate_order(unsigned int size)
 }
 
 static void
-init_kmem_cache_node(struct kmem_cache_node *n, struct node_barn *barn)
+init_kmem_cache_node(struct kmem_cache_node *n)
 {
 	n->nr_partial = 0;
 	spin_lock_init(&n->list_lock);
@@ -7393,9 +7395,6 @@ init_kmem_cache_node(struct kmem_cache_node *n, struct node_barn *barn)
 	atomic_long_set(&n->total_objects, 0);
 	INIT_LIST_HEAD(&n->full);
 #endif
-	n->barn = barn;
-	if (barn)
-		barn_init(barn);
 }
 
 #ifdef CONFIG_SLUB_STATS
@@ -7490,8 +7489,8 @@ static void early_kmem_cache_node_alloc(int node)
 	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL, false);
 	slab->freelist = get_freepointer(kmem_cache_node, n);
 	slab->inuse = 1;
-	kmem_cache_node->node[node] = n;
-	init_kmem_cache_node(n, NULL);
+	kmem_cache_node->per_node[node].node = n;
+	init_kmem_cache_node(n);
 	inc_slabs_node(kmem_cache_node, node, slab->objects);
 
 	/*
@@ -7506,15 +7505,20 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
 	int node;
 	struct kmem_cache_node *n;
 
-	for_each_kmem_cache_node(s, node, n) {
-		if (n->barn) {
-			WARN_ON(n->barn->nr_full);
-			WARN_ON(n->barn->nr_empty);
-			kfree(n->barn);
-			n->barn = NULL;
-		}
+	for_each_node(node) {
+		struct node_barn *barn = get_barn_node(s, node);
+
+		if (!barn)
+			continue;
 
-		s->node[node] = NULL;
+		WARN_ON(barn->nr_full);
+		WARN_ON(barn->nr_empty);
+		kfree(barn);
+		s->per_node[node].barn = NULL;
+	}
+
+	for_each_kmem_cache_node(s, node, n) {
+		s->per_node[node].node = NULL;
 		kmem_cache_free(kmem_cache_node, n);
 	}
 }
@@ -7535,31 +7539,36 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 
 	for_each_node_mask(node, slab_nodes) {
 		struct kmem_cache_node *n;
-		struct node_barn *barn = NULL;
 
 		if (slab_state == DOWN) {
 			early_kmem_cache_node_alloc(node);
 			continue;
 		}
 
-		if (cache_has_sheaves(s)) {
-			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, node);
-
-			if (!barn)
-				return 0;
-		}
-
 		n = kmem_cache_alloc_node(kmem_cache_node,
 						GFP_KERNEL, node);
-		if (!n) {
-			kfree(barn);
+		if (!n)
 			return 0;
-		}
 
-		init_kmem_cache_node(n, barn);
+		init_kmem_cache_node(n);
+		s->per_node[node].node = n;
+	}
+
+	if (slab_state == DOWN || !cache_has_sheaves(s))
+		return 1;
+
+	for_each_node_mask(node, slab_barn_nodes) {
+		struct node_barn *barn;
+
+		barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, node);
+
+		if (!barn)
+			return 0;
 
-		s->node[node] = n;
+		barn_init(barn);
+		s->per_node[node].barn = barn;
 	}
+
 	return 1;
 }
 
@@ -7848,10 +7857,15 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	if (cache_has_sheaves(s))
 		rcu_barrier();
 
+	for_each_node(node) {
+		struct node_barn *barn = get_barn_node(s, node);
+
+		if (barn)
+			barn_shrink(s, barn);
+	}
+
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
-		if (n->barn)
-			barn_shrink(s, n->barn);
 		free_partial(s, n);
 		if (n->nr_partial || node_nr_slabs(n))
 			return 1;
@@ -8061,14 +8075,18 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 	unsigned long flags;
 	int ret = 0;
 
+	for_each_node(node) {
+		struct node_barn *barn = get_barn_node(s, node);
+
+		if (barn)
+			barn_shrink(s, barn);
+	}
+
 	for_each_kmem_cache_node(s, node, n) {
 		INIT_LIST_HEAD(&discard);
 		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
 			INIT_LIST_HEAD(promote + i);
 
-		if (n->barn)
-			barn_shrink(s, n->barn);
-
 		spin_lock_irqsave(&n->list_lock, flags);
 
 		/*
@@ -8157,7 +8175,11 @@ static int slab_mem_going_online_callback(int nid)
 		if (get_node(s, nid))
 			continue;
 
-		if (cache_has_sheaves(s)) {
+		/*
+		 * barn might already exist if the node was online but
+		 * memoryless
+		 */
+		if (cache_has_sheaves(s) && !node_isset(nid, slab_barn_nodes)) {
 			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, nid);
 
 			if (!barn) {
@@ -8178,15 +8200,20 @@ static int slab_mem_going_online_callback(int nid)
 			goto out;
 		}
 
-		init_kmem_cache_node(n, barn);
+		init_kmem_cache_node(n);
+		s->per_node[nid].node = n;
 
-		s->node[nid] = n;
+		if (barn) {
+			barn_init(barn);
+			s->per_node[nid].barn = barn;
+		}
 	}
 	/*
 	 * Any cache created after this point will also have kmem_cache_node
 	 * initialized for the new node.
 	 */
 	node_set(nid, slab_nodes);
+	node_set(nid, slab_barn_nodes);
 out:
 	mutex_unlock(&slab_mutex);
 	return ret;
@@ -8265,7 +8292,7 @@ static void __init bootstrap_cache_sheaves(struct kmem_cache *s)
 	if (!capacity)
 		return;
 
-	for_each_node_mask(node, slab_nodes) {
+	for_each_node_mask(node, slab_barn_nodes) {
 		struct node_barn *barn;
 
 		barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, node);
@@ -8276,7 +8303,7 @@ static void __init bootstrap_cache_sheaves(struct kmem_cache *s)
 		}
 
 		barn_init(barn);
-		get_node(s, node)->barn = barn;
+		s->per_node[node].barn = barn;
 	}
 
 	for_each_possible_cpu(cpu) {
@@ -8337,6 +8364,9 @@ void __init kmem_cache_init(void)
 	for_each_node_state(node, N_MEMORY)
 		node_set(node, slab_nodes);
 
+	for_each_online_node(node)
+		node_set(node, slab_barn_nodes);
+
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
 			sizeof(struct kmem_cache_node),
 			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
@@ -8347,8 +8377,8 @@ void __init kmem_cache_init(void)
 	slab_state = PARTIAL;
 
 	create_boot_cache(kmem_cache, "kmem_cache",
-			offsetof(struct kmem_cache, node) +
-				nr_node_ids * sizeof(struct kmem_cache_node *),
+			offsetof(struct kmem_cache, per_node) +
+				nr_node_ids * sizeof(struct kmem_cache_per_node_ptrs),
 			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
 
 	kmem_cache = bootstrap(&boot_kmem_cache);
-- 
2.53.0


