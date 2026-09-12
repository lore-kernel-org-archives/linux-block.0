Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927536EA93
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241472; cv=none; b=cTp/k4UBY0g39o01tOBWRtwz2G85xwOFZ5DzWwj3USLKaiyUfNg5YV12/nY9psryXpR3A+M5EXH4J2Y0czk1QIR52W2pbF+7CpP6mGcD/xQy9nElVwriIPtwJQ/twl3JUKrbLF+NPzzpX9IMDwQz5getZHH0+f5p2RONZzfpCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241472; c=relaxed/simple;
	bh=8lx6LVjmp56AOVJzWPzpXm0AcxXitfBUG6x5hr2rDNo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A2z0DxrujAM/xV+RdR5dWhyxAELTCy6Xn3gGRwcsiKyQe+gDZ2b+/ui0xFp+sv5g5qFHQNbbix2DhHBKJWKtvHpYHPJo33TZ4jIZgOg9mZmcF7A/bvkeAdxqfN+S263R3QHD9OwY0RKZNHwe13xtMse1oAx7vQiLveDnXNiMBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cASTkCIS; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cASTkCIS"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so5477875e9.2
        for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 12:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789241469; x=1789846269; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rLVkHvOWbB51eDgPhMWwdk82cYQfFBh7T+AR6YqhuhI=;
        b=cASTkCISqxn0Cm1ulRhj+JxX5QI4UA+ajahSea0+E4wUt4K1YH0Fo+gSIdyXMyIvN3
         ll4D0KqzN93TgixPbmfii2bxwxgBUX0DubiQH3bsycG5irRMHcFUrKemH7m0dOrmOvbd
         4TCd1gQEfWuerCZQHCBfxmqj7R7g8zC1G1u3+6DcLbB1LCGknkazwPLicdjCaqj1vjIF
         tKqsPKyTMS8hN2D0TO5dsOttMfbEaQNCDMz3EuSS0kfyq0Vb+Kunfu7dNrEudbWGG/7b
         ZImk6wNNGoz8LysdAh7Thizj6zfqkxY7yhnV+0z8aPcXHWAyhfPZ2ZEeA+CqzEgZlMvB
         YiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789241469; x=1789846269;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rLVkHvOWbB51eDgPhMWwdk82cYQfFBh7T+AR6YqhuhI=;
        b=tJsjyYAONhqe3YHAMt8KrenaZKuACp96KG8/nYal7pL74+WF46kXi3iQsuNWy5c7FO
         oy65WpJnyti1UpkVLyd7XGzGRmyncLh2g/5TSy+sRuAP7OdZQHixvgZwBPquaslYKtrq
         OXugfprfjmXOelsDKS1gd7+cca4OJQBCrEZYS7G+uKNii9m4zJ0GQzmEP+pxNEpIEGrk
         z2GNhXTZ9UhXcnb9gi/mWs65Ggfq0Da1j4tNRJIzieu557fg4uVP5Q6zLi9m1CWOcdbI
         FGmC989BSOa2tnOP7rHSDzAo0wJoyaG4kJjIWkIZZ5WeLNZw2tbxZUgfCfyGGbY697dS
         NGpA==
X-Forwarded-Encrypted: i=1; AKwUvBzw+X9ev3GxWTyCmvOhWtkEigeIFNQv1NUQyLq1vHTrPnlFK2E+do0UMFM/p/p8wKbcfyaBetPFAKV1EA==@vger.kernel.org
X-Gm-Message-State: AFuF++lUie2XDnzl+fHkJnNOF58vtUTCj6mNLrHqnC4XduFzaXx4f91b
	pUdmZxtn6OAVGOdN9jni/67LMqf6qrsmbsiOXfcrVVxDSaTEiWA/uixI5kI+8OlqYw==
X-Gm-Gg: AYBFou1YP3vigjpKSYkQAn1sZiAOQ8h2+48gQ5SeD769veedAKvAEUwBJLwlH5LAPky
	xdv3ikYd5bmxOt3nzHuXGpA3algFajFNYwh/3W2OH1PT+gGZukLywHybSTr9tF+ui2lzk9hfzTS
	8c8SBzRStGvZAvIbSSoJjnx/+WmySEa+TIM7+M0tm+eYddo4pNPdzqabX5JG7RWPxCa/xi24Ixj
	uyfDhibbubRQOI3IANzYNqrg4IgFJhYOP1o/aIHdnngr9F+GZE8TZfyjRoPMgyydVQ8w+3kHDkL
	cF5Epzvw0F64hxcTtldpcaC9STrQs34C1EIXWcWfbyjeZXbGP9QNoLKeQ7r+IELflctwerLIjMs
	Lpp5+Gs6MLt+ZS1u1aOIeW1T8B6e39hGeAYXCVCQUubu3Rn1uw1NOvi3q41N3MuSwAdiIuVOL+L
	4xqt52fiSeWQB4lMZHX8gimzRm5d+X3g3RqYlns3b4jCS1ZooSGCWkr7h517aEljCIKKYKccVZT
	J3dzX6iF3c5ZU1waH9v
X-Received: by 2002:a05:600c:540e:b0:49e:6692:27fd with SMTP id 5b1f17b1804b1-49e66922810mr158471375e9.2.1789241468146;
        Sat, 12 Sep 2026 12:31:08 -0700 (PDT)
Received: from darker.lan (104.157.125.91.dyn.plus.net. [91.125.157.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34f1f7sm14806240f8f.24.2026.09.12.12.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 12:31:06 -0700 (PDT)
Date: Sat, 12 Sep 2026 12:30:55 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 04/26] mm/fbatch: lru bit set, no extra ref, while
 folio on per-cpu fbatch
In-Reply-To: <296bf543-23e0-417a-a729-c222392a1777@kernel.org>
Message-ID: <3f712e41-78a8-5622-67dc-f462d2c97d11@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com> <61e15506-940f-3532-5fc9-4086f7612c10@google.com> <296bf543-23e0-417a-a729-c222392a1777@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Sep 2026, Vlastimil Babka (SUSE) wrote:
> On 9/9/26 11:49, Hugh Dickins wrote:
> > Treat folios on a per-cpu fbatch as if they were already on the lruvec:
> > with PG_lru set, without holding an extra reference. This will enable
> > the removal of most lru_add_drain() and lru_add_drain_all() calls soon.
> > 
> > Recognize such a folio by 0x02 set in the folio->lru.next pointer by
> > folio_add_lru(). Then lruvec_del_folio() (aided by "lru_add_del_folio")
> 
> I admit I find the name lru_add_del_folio() quite confusing. What it does is
> AFAIU try to delete from a folio_batch, which is not necessarily the lru_add
> one?

It is to delete from the lru_add fbatch: that's the one where a folio
is put into the LRU system initially, and it's the one which has this
special LRU_NEXT_BATCHED linkage to the fbatch, not any proper next,prev
linkage into a real LRU list.

Which is not to say that that folio could not also occur in some of the
other fbatches (for this or other CPUs) at the same time: it might,
because of the un-refcoount-raised folio getting freed and reused;
and it might, as the same instance of the folio, be acted upon by one
of the other LRU manipulation functions. Those latter tend to have
"!folio_test_lru" checks in, but now the lru_add ones do have lru set;
they tend to be reached through a real LRU list of folios (e.g. deciding
to deactivate something found on an active list), but I don't think that's
necessarily the case.

As to be name: I did try out several alternatives, but was most satisfied
by "lru_add_del_folio". I'll certainly grant that it's amusing, and maybe
too confusing if it were to be a widely-used API; but it mostly ends up
just nestling inside lruvec_del_folio().

> I don't have an alternative proposal ready though, naming is hard.
> 
> > can pretend to unlink it, and folio_batch_move_lru()'s lru_add case can
> > check whether one of the others has already moved it to lruvec.
> > 
> > (That bit is also used in a transient way by set_page_pfmemalloc(), to
> > inform interested callers whether page_is_pfmemalloc(): but those callers
> > are in networking, not putting folios on LRU; and accept that any use of
> > the page->lru field already erases page_is_pfmemalloc() information.)
> > 
> > Let folio->lru.next point to the lru_add fbatch entry, but this is now
> > just for debugging: it seemed to be important for folio_batch_move_lru()
> > to distinguish fresh from stale entries, but then it turned out that it
> > has to processs them identically.
> > 
> > Activate, deactivates and move_tail, holding no reference on the folio,
> > might come to act on a stale folio when the fbatch is drained: but it's
> > acquired by try_get and test_clear_lru, so safe even when suboptimal.
> > 
> > Reclaim is not an exact science, and there have been no complaints of
> > missed actions since 5.11 commit fc574c23558c ("mm/swap.c: serialize
> > memcg changes in pagevec_lru_move_fn") introduced the TestClearPageLRU
> > protocol: so don't expect complaints of a few surprisingly taken actions.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> Tricky, and I guess my questions below will betray I didn't grasp all the
> nuances...

Many thanks for looking: it is the core, and the hardest to review.
> 
> > ---
> >  include/linux/mm_inline.h |  25 ++++++++
> >  include/linux/mm_types.h  |   6 +-
> >  mm/folio.c                | 119 +++++++++++++-------------------------
> >  mm/huge_memory.c          |   6 +-
> >  4 files changed, 74 insertions(+), 82 deletions(-)
> > 
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 621c8653d8f7..8420b1276535 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -343,6 +343,29 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
> >  }
> >  #endif /* CONFIG_LRU_GEN */
> >  
> > +enum {
> > +	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
> > +	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
> > +	NR_LRU_NEXT_FLAGS
> > +};
> > +
> > +static __always_inline
> > +bool lru_add_del_folio(struct folio *folio)
> > +{
> > +	unsigned long lru_next = READ_ONCE(folio->lru_next);
> > +
> > +	/* BUG_ON(folio_test_lru(folio) && folio_ref_count(folio)); */
> 
> Maybe do it as VM_WARN_ON_ONCE() and then it's acceptable for mainline and
> gets excercised by bots?

All I want there is the comment; but I thought the most concise and
helpful way to write the comment would be to write it as a BUG_ON().
I'm not keen on bloating inlines with assertions, and _ONCEs have
their cost on top - all mitigated by the VM_, true. I can change
it if asked, but all I want to put there myself is the comment.

> 
> > +	if (!(lru_next & BIT(LRU_NEXT_BATCHED)))
> > +		return false;
> > +
> > +	WRITE_ONCE(folio->lru.next, LIST_POISON1);
> > +	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
> 
> Is this a test for unexpected LIST_POISON1 definitions (in which case
> BUILD_BUG_ON would work?) or a test for a race that should not happen,
> however with a very tiny detection window?

Again, it's just a comment, that things will go wrong if someone one
day decides to redefine LIST_POISON1 in a way which conflicts. Yes,
if it were uncommented, then I'd prefer to put a BUILD_BUG_ON instead.

> > --- a/mm/folio.c
> > +++ b/mm/folio.c
> > @@ -152,57 +152,34 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
> >  	int i;
> >  	struct lruvec *lruvec = NULL;
> >  	unsigned long flags = 0;
> > -	struct folio_batch free_fbatch;
> > -	bool is_lru_add = (move_fn == lru_add);
> > -
> > -	/*
> > -	 * If we're adding to the LRU, preemptively filter dead folios. Use
> > -	 * this dedicated folio batch for temp storage and deferred cleanup.
> > -	 */
> > -	if (is_lru_add)
> > -		folio_batch_init(&free_fbatch);
> >  
> >  	for (i = 0; i < folio_batch_count(fbatch); i++) {
> >  		struct folio *folio = fbatch->folios[i];
> >  
> > -		/* block memcg migration while the folio moves between lru */
> > -		if (!is_lru_add && !folio_test_clear_lru(folio))
> > -			continue;
> > -
> > -		/*
> > -		 * Filter dead folios by moving them from the add batch to the temp
> > -		 * batch for freeing after this loop.
> > -		 *
> > -		 * We're bypassing normal cleanup. Clear flags that are not
> > -		 * applicable to dead folios.
> > -		 *
> > -		 * Since the folio may be part of a huge page, unqueue from
> > -		 * deferred split list to avoid a dangling list entry.
> > -		 */
> > -		if (is_lru_add && folio_ref_freeze(folio, 1)) {
> > -			__folio_clear_active(folio);
> > -			__folio_clear_unevictable(folio);
> > -			folio_unqueue_deferred_split(folio);
> > +		if (!folio_try_get(folio)) {
> >  			fbatch->folios[i] = NULL;
> > -			folio_batch_add(&free_fbatch, folio);
> >  			continue;
> >  		}
> >  
> > +		if (!folio_test_clear_lru(folio))
> > +			continue;
> > +
> > +		/* Do not add to LRU if it has already been added */
> > +		if (move_fn == lru_add && !lru_add_del_folio(folio))
> > +			goto restore_lru;
> > +
> >  		folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
> >  		move_fn(lruvec, folio);
> >  
> > +		/* Do add to LRU if not already there (move_fn skipped) */
> > +		if (lru_add_del_folio(folio))
> > +			lruvec_add_folio(lruvec, folio);
> 
> AFAICS the previous code didn't do anything like this (and move_fn could
> skip or not all the same?) , and I wonder if it's now (sorry) load-bearing,
> or an optimization?

Good question, an optimization or essential? I'd have to ask for more
time, to give you a definitive answer on that. What I can easily do is
give the thinking behind it. We're the lucky one who got to clear lru
bit, it's conceivable that a racing task (particularly or necessarily?
when the folio has got freed and reused meanwhile) wanting to put this
folio on real LRU failed to clear lru bit and so skipped this entry,
and in that case it is our responsibilty to do so (usually the move_fn
does an lruvec del and add which accomplishes that, but not when it
skipped the folio as having unsuitable flags).

Those lines were not in my initial attempt, and I never noticed any
badness from not having them (folio unreclaimable and unmigratable
until freed, I presume); but when working on the mlock+munlock I
became more aware of this need for the lru-bit-clearer to do the
work others are expecting. (And I do not pretend that munlock is
complete in that respect yet: no more imperfect than before,
I think, but more work to do if perfection is needed.)

> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index afbb5974bd22..c7510d875433 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3995,8 +3995,12 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
> >  		}
> >  
> >  		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> > -		if (do_lru)
> > +		if (do_lru) {
> >  			lruvec = folio_lruvec_lock(folio);
> > +			/* Move from fbatch to lruvec before lru_add_split_folio()s */
> > +			if (lru_add_del_folio(folio))
> > +				lruvec_add_folio(lruvec, folio);
> 
> This is not mentioned in the changelog. Why is it necessary now?
> 
> > +		}
> >  
> >  		ret = __split_unmapped_folio(folio, new_order, split_at, xas,
> >  					     mapping, split_type);

It caught me by surprise too,
I was very lucky that our internal testing crashed without that, it's a
narrow race when we're not batching large folios. But you only have to
look at lru_add_split_folio() to see, that it does (very reasonably)
expect a folio with the lru bit set to have sensible next,prev.
(WHereas most others isolate a folio before working on it, hugepage
splitting is peculiar in having a mode where folio is left on lru,
but frozen to refcount zero while the work is done).

Thanks! More replies later...
Hugh
