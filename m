Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76072426684;
	Wed, 27 May 2026 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892418; cv=none; b=k/oZX9I74xAUZoiiW5dThHH1LU8S2a5/zsTdyF9RVZ9NI+BL9ov4QA6Ax0A3RbtIb9IUOpnu4MsTi/twnKVh9T+54EPoAJBPZ39trm1A9vDfn0sgiOT0YLF45lUTjMnim5eodeIDYEnnuKdGRl/geFBUMw61SM6Dj5P7KG1HZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892418; c=relaxed/simple;
	bh=0hd+ExkdSdfRfc5wQCtOqBHSzlBv8kE6KOclVpgUC34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oPa4hSuiXsA5r0lkz7ZJXdnQFRPsX41VhIWzh70bOwLRKF6id6Wc/hmxr8lw/fq1RoBW4OknoVME8ztNbGFvSzLvBBx7MuLHfSR070iAy6cAHPWHFKdVCso3KirFX41ASsgmkfKCsMI2LK5smlBpJ2t4GgvcqGpOdm3rJHNotkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtNMt3L4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtNMt3L4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D971F000E9;
	Wed, 27 May 2026 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779892415;
	bh=CCH92GDP8tW9/dATbIA2UouNp8bD0Ru0vl6CDadR+hw=;
	h=From:Date:Subject:To:Cc;
	b=RtNMt3L4OFETW8wZlDN0SQm263L9NzzgCNdvcUixzAdZDWmHLZjfaBAPVZYVWHZXi
	 y7BoY1Tw219sWyznVGwvws+pR6LlTmnIAg8IUqsm3QwPpPM4jU8RkQ4Do8kX6eVEnp
	 KTwJTWYZpTSRm1/3TgT6Mu1M5wr5ADIBsFp+8SD4iCY6AN8irero+AZCZEidSbqGtc
	 Irq22SF3xjwDmQqXuIj7pih9JsX7pl5MBpj1OkHauz+6j5+ysgxEPUP6NGCsTaEhcz
	 +dc/YwWqVnEHBEM4vdh7a4K68jij0T1Lp3dUO6tjVM8ngrXE2mt71eZpB8UDp8bQeN
	 3KKud0FF7fubg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 27 May 2026 17:33:28 +0300
Subject: [PATCH v2] block: partitions: replace __get_free_page() with
 kmalloc()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-block-v2-1-8e06f914c484@kernel.org>
X-B4-Tracking: v=1; b=H4sIALcAF2oC/12OwQ6CMAxAf4XsbHUUhsaT/2E4bKPABDeyIdEQ/
 t0Nbx5f8/ralQXyhgK7ZivztJhgnI2Ah4zpXtqOwDSRGXKsuEAOanR6ABTigmdRtE1xYdGdPLX
 mvXfu9Y/DSz1Iz2k5GUoGAuWl1X0ade0Es4PhKccYPO3VpPUmzM5/9n+WPOX+Ty855FCVVdFo1
 C0v8TaQtzQene9YvW3bFyGCHITUAAAA
X-Change-ID: 20260520-block-25582753fd38
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>, 
 Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
 Vlastimil Babka <vbabka@suse.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.15.2

check_partition() allocates a buffer to use as backing memory for
seq_buf.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

For a single allocation on the cold path the performance difference between
kmalloc() and __get_free_pages() is not measurable as both allocators take
an object/page from a per-CPU list for fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
This is a (tiny) part of larger work of replacing page allocator calls
with kmalloc:

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/block

Signed-off-by: Mike Rapoport <rppt@kernel.org>
---
v2 changes:
* reword changelog

To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
v1: https://patch.msgid.link/20260520-block-v1-1-6463dc2cf042@kernel.org
---
 block/partitions/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 5d5332ce586b..b5c59b79ca7c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -124,7 +124,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 	state = allocate_partitions(hd);
 	if (!state)
 		return NULL;
-	state->pp_buf.buffer = (char *)__get_free_page(GFP_KERNEL);
+	state->pp_buf.buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!state->pp_buf.buffer) {
 		free_partitions(state);
 		return NULL;
@@ -154,7 +154,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 	if (res > 0) {
 		printk(KERN_INFO "%s", seq_buf_str(&state->pp_buf));
 
-		free_page((unsigned long)state->pp_buf.buffer);
+		kfree(state->pp_buf.buffer);
 		return state;
 	}
 	if (state->access_beyond_eod)
@@ -170,7 +170,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 		printk(KERN_INFO "%s", seq_buf_str(&state->pp_buf));
 	}
 
-	free_page((unsigned long)state->pp_buf.buffer);
+	kfree(state->pp_buf.buffer);
 	free_partitions(state);
 	return ERR_PTR(res);
 }

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260520-block-25582753fd38

Best regards,
--  
Sincerely yours,
Mike.

