Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D4D318131;
	Wed, 25 Feb 2026 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009108; cv=none; b=WrObfz0YXey3aJ8tQm9Nn5bumHqRBfHn4Kl4gZDJ2+eJmw1VXq+PdgxGsxQ/rPKqKwsRmVPkm2Eq2gAmPDLMt53B8jjTN9eYZmTE/yYdLIe1zt2SXiIF3HF8btmeRSlUKrmJHU0OKM+IJd+U0TgaIf2GXuB9Q2cRzFAEg1WJaJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009108; c=relaxed/simple;
	bh=jzaWURpUIGyaa1hBlzWd/+9vleP5W6HeGo+lBuhWi14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMao4mmVzORFTtiLrAWP9tWgZHSOZLgz7NQXqXOINcdtOFzYRPGnAL9PUWbkJm/6nTH5BUBFUPJgX6OnHtrm8PzVjpTwqLt+mTzsIpYQxV9iUr2N9/JL0S0Ri/NuhZm6pFw4Tc2N9dlQ9mydIrx6svSFxOlriMIkUCBdYGgvzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R32xm9Mz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R32xm9Mz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A464C116D0;
	Wed, 25 Feb 2026 08:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772009108;
	bh=jzaWURpUIGyaa1hBlzWd/+9vleP5W6HeGo+lBuhWi14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R32xm9MzE8TxcoyKzFlaZmT+e50QdO9vFwHyumznycMPjMjPq6MmfR1bMYVUGVpWQ
	 /X7JULpk7l6XvPEDWYVefaDoqhK6EfH72qx6WHSI4EggY4ktKX/ogNyFKjGyYmZQDt
	 b6xDnS0BDXqluk9HNUh5PDqI6GDaOUqdMNzByh9H8KT+FR+aG6ALeBdd5PpZv0mUmJ
	 Ne+DyWdbj2Dyq2EKgK09VwGMFHsF4yZP96TUC0RqE9elf+B7aWEEmlBU7U8l+FUcYD
	 Sv61GxcUNmkhSgwdbiUAYZkw30l4YlqF6PxGgVODaba0m8fcNFMAQ9wL8t1k5W9D6h
	 gJRm5HFXsiOPQ==
Message-ID: <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org>
Date: Wed, 25 Feb 2026 09:45:03 +0100
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
To: Vlastimil Babka <vbabka@suse.cz>, Ming Lei <ming.lei@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>,
 Hao Li <hao.li@linux.dev>, Christoph Hellwig <hch@infradead.org>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/26 21:27, Vlastimil Babka wrote:
> 
> It made sense to me not to refill sheaves when we can't reclaim, but I
> didn't anticipate this interaction with mempools. We could change them
> but there might be others using a similar pattern. Maybe it would be for
> the best to just drop that heuristic from __pcs_replace_empty_main()
> (but carefully as some deadlock avoidance depends on it, we might need
> to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
> tomorrow to test this theory, unless someone beats me to it (feel free to).
Could you try this then, please? Thanks!

----8<----
From b04dad02eb72feb1736241518dd4d3dd64aadc0e Mon Sep 17 00:00:00 2001
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 25 Feb 2026 09:40:22 +0100
Subject: [PATCH] mm/slab: allow sheaf refill if blocking is not allowed

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/slub.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 862642c165ed..258307270442 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4526,7 +4526,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
-	bool can_alloc;
+	bool allow_spin;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
@@ -4547,8 +4547,9 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main,
-					gfpflags_allow_spinning(gfp));
+	allow_spin = gfpflags_allow_spinning(gfp);
+
+	full = barn_replace_empty_sheaf(barn, pcs->main, allow_spin);
 
 	if (full) {
 		stat(s, BARN_GET);
@@ -4558,9 +4559,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 
 	stat(s, BARN_GET_FAIL);
 
-	can_alloc = gfpflags_allow_blocking(gfp);
-
-	if (can_alloc) {
+	if (allow_spin) {
 		if (pcs->spare) {
 			empty = pcs->spare;
 			pcs->spare = NULL;
@@ -4571,7 +4570,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 
 	local_unlock(&s->cpu_sheaves->lock);
 
-	if (!can_alloc)
+	if (!allow_spin)
 		return NULL;
 
 	if (empty) {
@@ -4591,11 +4590,8 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	if (!full)
 		return NULL;
 
-	/*
-	 * we can reach here only when gfpflags_allow_blocking
-	 * so this must not be an irq
-	 */
-	local_lock(&s->cpu_sheaves->lock);
+	if (!local_trylock(&s->cpu_sheaves->lock))
+		goto barn_put;
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	/*
@@ -4626,6 +4622,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return pcs;
 	}
 
+barn_put:
 	barn_put_full_sheaf(barn, full);
 	stat(s, BARN_PUT);
 
-- 
2.53.0


