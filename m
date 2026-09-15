Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA073B8BA4
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477702; cv=none; b=Yf4PQtvq5P0X+07KXM/7YavUDLBPsO+LZt34lS1SkQVQ3sokTsXxLIxTltK3c8QNVng+oOjKVfn5obf1AfJTuJ1uCMFLETWsupYQ7pWE4qkvkBY0XiosbViJUAzXFr01dWwsz/LVWCZvDDEqegZ0/cjtrNLbzI/h3nKY5pjfY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477702; c=relaxed/simple;
	bh=XU+2dnON3tB/nnqmlBy7PP4DEKnLSGjRoJgv0p+i0e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cj0TtLRQz2bTpdk1IP19OyEPT+w4uFZYXCPBnci7KZTGW4ZGpb6sGkZdEw5z8cItj5/dPxoKsEPzpj6bxlp6E7Cuq8Ti2XmM/hH7KIzgUa7xwBE1KdvcINhCk6KWpnH8wZzgkO+3pDIPCNUGJxDGTfjzKyT3f0q5i+EjtsfkndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAGtosHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAGtosHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ED61F00893;
	Tue, 15 Sep 2026 13:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789477700;
	bh=tjgLUop72ZMvf0h92huxyx+PE6o+OUOeA3B67aAkAJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lAGtosHPT8bQQHdHedEA82sBRcvEs3tM49nVDjy5CxbMGop9XwEdcCFmAHewy8xhV
	 lqHD9QgMJBJOLy9oduSs5wDkeZpMoeT7EIjwx8dqetXoXZoRD4qM0a6nTeisgAh/7a
	 WdTzRDf2r28CVnki9XxnCTOwZtG8LLs5gXKofrjfKIcTUOANxwfM+wdSRr4gnFl3YF
	 aOJGlp4IxJ8QzGFKjExM1LsD2tXaWO7XUKVLHDzL59aPewyIoVR9WZBisBBgJjFR2O
	 oC+FxcHlcIUXuhLLA28EIG7QAI1Vd+JB66hLEaiz7QGm9xpKgNKLLn+vgKroUvjgvf
	 d4EI3K3ex5MfA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id A9902198003A;
	Tue, 15 Sep 2026 09:08:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 15 Sep 2026 09:08:16 -0400
X-ME-Sender: <xms:OUOpaoohDrvyZdMAv3BPSTqKZ3EwSFK1v6xeT7Fhr2cOPnwI3EaXDw>
    <xme:OUOpatVAjgiVezhqwjrruUmqPHwzpXybZ8aBoNe6d0UDW2E1u1WP4HMNS74KzkTBo
    VpKdcBI_BdlNUGUp1c886jmRowZ3Sajf0h_qn_ccoZHG14sa-mU4w9c>
X-ME-Received: <xmr:OUOpagIOMzypL5NqY7x1Isf-AbgluKlNv1fFYR052KcVUr5cPKdSdsvWVrI>
X-ME-Proxy-Cause: dmFkZTGBwKK+2xwAnE7Nssghb1/SceAcmQ+4ywIAoFrTlislToHtIv8OmG+4NsbsKAXvcf
    UX6cRBjc80nWIknxGObjdDxbScPZQabPCAe3OX00a7onnc54qK4hOE8AR/EWB4wi/Nye97
    OvMk7+uHW6ShYCAo0+Ba7DJ7JC4XBBW4+UFWxhrsQbs9OTmsUcfqOGJZj2WMC2dVv6zq0s
    J6y7i24qWBikceH5CMyBGbLKiFXaff8mNpAp9X4rOSZM6nNOGc7G4i2DST4cL9UnmXg22A
    cZl+hrpQH8Uao3fk9/rsQQ4MR8GopSdsyVdAlO4o00a8fAIgChTEjjeAF43IoApGnFvCjc
    NmPXJJKhd9vSE/abZ8epf9nO345U38qzMWorDQY75NAOI/pCRfxGb/0kw/Ed4sTjhwqk7j
    7eUGmH9xej+bNAkAJbCp/3BqMox7rHVFOaxBHh6o15OTTQZPRzCHIdbgVTwbpffP2953Su
    X4peartElqpBPur1xD6G+uCr2JFQuvqa390Z8csCX3cJbf8Ak8sYGcv5lCRbxWONdVMNKl
    NqtP8tih8iA3fhvMBNUpOoDOVUEx/C6o/NNjJN0qIEnrmrQ0KUq401HM56Hss9U4JbXwSn
    qMUv76AlYpWq9JIeqKXGd83ecti/2bF/6ZtkFn7+bkZCMPOwRHr4d5VK+IgA
X-ME-Proxy: <xmx:OUOpagiKiXANC8dYaGhAfZLjTQ4zfKJ3v5KjBZNHA7h-wUgVEvbadg>
    <xmx:OUOpaom746o2T__gb-FYFjQ56UeeBfnHp3-sDK9BMv2soZ-0JeRypg>
    <xmx:OUOparHPrELkf3NiInnlkfUl51_6S-QUsZKTMTEnRGPkmI663w8ltA>
    <xmx:OUOpatRqm-PJBL36gxjY6GjwgsjdVCOuJoeY4MtKlJq6gA9rUpyodw>
    <xmx:OUOpan43kOMGLJ9R5slFZzX9DAK82GGV_4MhasX0GL5dyiIx4BZoqRmV>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 09:08:07 -0400 (EDT)
Date: Tue, 15 Sep 2026 14:08:06 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 	Ackerley Tng <ackerleytng@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 	Alexandre Ghiti <alex@ghiti.fr>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 	Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
 	Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
 	Christoph Lameter <cl@gentwo.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 	David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>,
 Jan Kara <jack@suse.cz>, 	Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, 	Kairui Song <ryncsn@gmail.com>,
 Lance Yang <lance.yang@linux.dev>, 	Leonardo Bras <leobras.c@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, 	Marcelo Tosatti <mtosatti@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 	Mel Gorman <mgorman@techsingularity.net>,
 Miaohe Lin <linmiaohe@huawei.com>, 	Michal Hocko <mhocko@suse.com>,
 Minchan Kim <minchan@kernel.org>, 	Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 	Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 	Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 	Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>,
 Zach O'Keefe <zokeefe@google.com>, 	Zi Yan <ziy@nvidia.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/26] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
Message-ID: <aqk7PbBfhO1GV2sa@thinkstation>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
 <c44a34f8-ea3c-48cd-27d5-02df129be685@google.com>
 <aqLaa4QvXMbQaIWG@thinkstation>
 <84fecd13-f1e4-7d40-94c9-963f5c2f7aee@google.com>
 <5bd863e9-30a3-c01a-dc8c-c3802b864a6c@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd863e9-30a3-c01a-dc8c-c3802b864a6c@google.com>

On Mon, Sep 14, 2026 at 01:19:37PM -0700, Hugh Dickins wrote:
> On Sat, 12 Sep 2026, Hugh Dickins wrote:
> > On Thu, 10 Sep 2026, Kiryl Shutsemau wrote:
> > > On Wed, Sep 09, 2026 at 02:55:41AM -0700, Hugh Dickins wrote:
> ...
> > > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > > index 8420b1276535..8f5efadf9c7c 100644
> > > > --- a/include/linux/mm_inline.h
> > > > +++ b/include/linux/mm_inline.h
> > > > @@ -346,6 +346,7 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
> > > >  enum {
> > > >  	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
> > > >  	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
> > > > +	LRU_NEXT_ACTIVATE,
> > > >  	NR_LRU_NEXT_FLAGS
> > > >  };
> > > >  
> > > > @@ -358,6 +359,9 @@ bool lru_add_del_folio(struct folio *folio)
> > > >  	if (!(lru_next & BIT(LRU_NEXT_BATCHED)))
> > > >  		return false;
> > > >  
> > > > +	if (lru_next & BIT(LRU_NEXT_ACTIVATE))
> > > > +		folio_set_active(folio);
> > > > +
> > > >  	WRITE_ONCE(folio->lru.next, LIST_POISON1);
> > > >  	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
> > > >  
> > > > diff --git a/mm/folio.c b/mm/folio.c
> > > > index a18d8ef6afd5..0b75c3b69d5a 100644
> > > > --- a/mm/folio.c
> > > > +++ b/mm/folio.c
> > > > @@ -256,15 +256,32 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
> > > >  
> > > >  void folio_activate(struct folio *folio)
> > > >  {
> > > > +	unsigned long lru_next;
> > > > +
> > > >  	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
> > > >  	    !folio_test_lru(folio))
> > > >  		return;
> > > >  
> > > >  	/*
> > > > -	 * XXX: It is curiously difficult to recreate safely the old
> > > > -	 * __lru_cache_activate_folio() optimization (folio_set_active()
> > > > -	 * directly if it's on the local lru_add fbatch): revisit later.
> > > > +	 * This optimization is intended for the common case of folio
> > > > +	 * having been recently added to this CPU's lru_add fbatch.
> > > > +	 * But since other CPUs can now take it at any instant (after
> > > > +	 * a folio_test_clear_lru()), and we may be migrated to another
> > > > +	 * CPU, it is simplest just to extend the optimization to all CPUs.
> > > > +	 *
> > > > +	 * folio_set_active() would be unsafe without the lruvec lock, and
> > > > +	 * a folio_test_clear_lru() here might cause a racing drain of the
> > > > +	 * lru_add fbatch to skip its lru_add(): so use try_cmpxchg().
> > > >  	 */
> > > > +	lru_next = READ_ONCE(folio->lru_next);
> > > > +	while (lru_next & BIT(LRU_NEXT_BATCHED)) {
> > > > +		if (lru_next & BIT(LRU_NEXT_ACTIVATE))
> > > > +			return;
> > > > +		if (try_cmpxchg(&folio->lru_next, &lru_next,
> > > > +				lru_next | BIT(LRU_NEXT_ACTIVATE)))
> > > > +			return;
> > > 
> > > Hm. What prevents the folio from becoming unevictable under us here?
> > > I don't see anything.
> > > 
> > > __folio_add_lru() wouldn't like it:
> > > 
> > > 	VM_BUG_ON_FOLIO(folio_test_active(folio) &&
> > > 			folio_test_unevictable(folio), folio);
> > > 
> > > folio_lru_list() has the VM_BUG() too.
> > 
> > You're right, thank you. I thought I had deleted all such VM_BUG_ONs:
> > and indeed I had, but only in a patch I later decided was too much for
> > this series (removing PG_unevictable, using !folio_evictable() in some
> > places, or folio_test_unevictable() testing another POISON in lru_next).
> > 
> > That excuse is not enough for this series! Yes, I must send a fixup,
> > but not today.
> > 
> > > 
> > > I am not sure what the right fix is.
> > > 
> > > Maybe lru_add_del_folio() should only call folio_set_active() on
> > > !folio_test_unevictable() folios?
> 
> I was writing the commit message to a 7.1/26 fixup patch,
> when I found I just could not describe any possible race here.
> 
> (And I was using your first suggestion, above: in the longer term I
> prefer what I chose below, but decided it was better not to get into
> that now: deleting various VM_BUG_ON_FOLIOs is better argued elsewhere.
> There's another of them in folio_migrate_flags().)
> 
> folio_activate() has just checked !folio_test_unevictable(), so
> it would have to be a race with something which sets the unevictable
> flag on this folio at the same time as we find it's LRU_NEXT_BATCHED.
> 
> !folio_evictable() might become true at any instant,
> but folio_test_unevictable()?
> 
> I cannot see what the racer could be: can you? I can see lru_add()
> making it unevictable afterwards; and I can see folio migration
> (successful or not) carrying unevictable forwards (or setting it
> on a freshly allocated folio). But I cannot see any risky race
> for folio_activate() or folio_mark_accessed() here.

I was thinking of race with mlock() plus a failed compaction (assuming
compact_unevictable_allowed is 1):

	CPU0						CPU1
folio_activate()
  folio_test_unevictable() == false
  folio_test_lru() == true
						__mlock_folio()
						  folio_set_unevictable()
						  <moves to LRU_UNEVICTABLE>
						...
						compact_zone()
						  isolate_migratepages()
						    isolate_migratepages_block()
						      folio_test_clear_lru()
						      lruvec_del_folio()
						  <migration fails>
						  putback_movable_pages()
						    folio_putback_lru()
						      __folio_add_lru() // !active, unevictable
						        lru_next |= BIT(LRU_NEXT_BATCHED);
						        folio_set_lru()
  lru_next = READ_ONCE(lru_next)
  // lru_next has LRU_NEXT_BATCHED
  try_cmpxchg(lru_next | LRU_NEXT_ACTIVATE) == true

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
