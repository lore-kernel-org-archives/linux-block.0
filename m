Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684A499F04;
	Thu,  6 Aug 2026 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054278; cv=none; b=p4huW36YVKzIHZ4MQ5wv9BZir9OtEA/5YTk2IQ3FeJviIRNU9qNWfTEfV7SMnilm9L+oInPGOZ1U0w44/wYKQF7wsjaENpxc1gjklek4etTqTzMr2EjeyKaxMOThFRaZBPUH2e5KeNcbUEH608ct7sjt65Miy1G/OZj63JTi4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054278; c=relaxed/simple;
	bh=PaCvyeejmDewGRTU85xVmeascWSScxTIR/HR5uyXI+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbYrjoHtiy6NfRj2GstPOJ08s/qreg3OFFpW00D//DYoJ2PQbRfKYxuylBjE9cZaLNYVXDJ9O5gc8k8L/8fNbG5uXPu7JCblGOoeKafbcitcNDw4iAQQ/0d++QlzKuP7oWAP79XzgpMIAd/Is70dID6KQ4UVY/kUwKk1TSupbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhNgyyDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhNgyyDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42BD1F00A3A;
	Thu,  6 Aug 2026 22:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786054277;
	bh=ALqdWlhOmobFYoiIgybtTERTMEIMR50Vcx9ZTHxD4mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VhNgyyDzAnz16w2KjkGXFqJ4NevnTu0Hme24rsaD8WC6ilSlc7KfMrTNPwi1PAfRf
	 +5J+DbDttRI1C/Wy10u4XJFBRaVjum5vHND1qr4OhfWsIJ5Dy7vRADyTYiPaFxXyJe
	 hXo+slcmLXW4iLh/Jx7ahVIvtZ0OnbFcYjyITzt1d6Jc0/w5FIv7nCzUDtvbkgN7MD
	 2IujzTQpT1++BOithsvZdn3HMd3/4eKN2xdpQeT70iMTwqfgCGt1BXK6rRtpB1vNvX
	 +2g1tBY0QOaWU3K7uJd1d2wj60dcwPmVkyqu3WXyua5YYgZAxMW3W28OzOrZcQb4f5
	 gP+6TCoz1LNNg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-block@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 1/3] mm: make mempool_alloc_from_pool() return bool
Date: Thu,  6 Aug 2026 15:10:29 -0700
Message-ID: <20260806221031.79050-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806221031.79050-1-ebiggers@kernel.org>
References: <20260806221031.79050-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mempool_alloc_from_pool() is intentionally all-or-nothing, so make it
return a bool rather than the number of elements allocated.

Then make mempool_alloc_bulk() return right away if
mempool_alloc_from_pool() succeeds, rather than jumping back to the
retry_alloc label to allocate nothing and then returning.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 mm/mempool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 473a029fa31f..d454bc9f39e9 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -409,7 +409,7 @@ int mempool_resize(struct mempool *pool, int new_min_nr)
 }
 EXPORT_SYMBOL(mempool_resize);
 
-static unsigned int mempool_alloc_from_pool(struct mempool *pool, void **elems,
+static bool mempool_alloc_from_pool(struct mempool *pool, void **elems,
 		unsigned int count, unsigned int allocated,
 		gfp_t gfp_mask)
 {
@@ -432,7 +432,7 @@ static unsigned int mempool_alloc_from_pool(struct mempool *pool, void **elems,
 	 */
 	for (i = 0; i < count; i++)
 		kmemleak_update_trace(elems[i]);
-	return allocated;
+	return true;
 
 fail:
 	if (gfp_mask & __GFP_DIRECT_RECLAIM) {
@@ -454,7 +454,7 @@ static unsigned int mempool_alloc_from_pool(struct mempool *pool, void **elems,
 		spin_unlock_irqrestore(&pool->lock, flags);
 	}
 
-	return allocated;
+	return false;
 }
 
 /*
@@ -519,8 +519,8 @@ int mempool_alloc_bulk_noprof(struct mempool *pool, void **elems,
 	return 0;
 
 use_pool:
-	allocated = mempool_alloc_from_pool(pool, elems, count, allocated,
-			gfp_temp);
+	if (mempool_alloc_from_pool(pool, elems, count, allocated, gfp_temp))
+		return 0;
 	gfp_temp = gfp_mask;
 	goto repeat_alloc;
 }
-- 
2.55.0

