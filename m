Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581437F32F
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417184; cv=none; b=NueRacbbERIkqiA9DYezT3xuIx2gnhPD3VjeqTkxVuaHkZQESxbpINPTBAsjuVIM0bFprUIvW5fJV1A9jQW4tpNSMOGt0YAhYDAQscvi08MmDGr+U20pDVF6g2J+kwwkDbNxmGg/ih1g2uw3uwgejq+oFVTaYbE99DimFX43tbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417184; c=relaxed/simple;
	bh=p8+U6K75MXs4kfewO0kP1AY2ISyxp8Vic4i2TpIJPuk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RHTsO+hB7OA06Hi9lHPF/a7by870HtW9cBioPQk7P+jIZbCLeaEG9PjJAS/NFyaAX7xJzduKsevJAFQgdD/1r9PKVSDf1VUGp9HhOZKMmbjM6rzglYSCDXWqsF2iOXf2AM88tb6VsF9SjLKq5Tg3BYl1FwcDPyzJpnaVsmuwGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LeXIHJ6o; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LeXIHJ6o"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633cd78so1257024f8f.1
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789417180; x=1790021980; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+AktPzAMD7v7+puIIygBX5NaQs925spQsBYks3yq6yc=;
        b=LeXIHJ6o73anPpgREHgQnQzC69Rfxz3ne8v556Q/80eOXn99Pie5/KYzleEmE62OO4
         0BcdfXsH73ziVPGRNTVTdBpXLDxeivYqLIwkpJ7PMV1RtY63jRStKs8cckbLtY0dmMVP
         S0BMNI51CsSNvrvGrBISuhz1DS6wXURVocK43+6kuN2s99DRM7dqD6rCvZ3BsduKD0FD
         EYNwUe6GTZ1fLvtjKBXr5rezjKZyrOI1TlhHL0O22InWKNx57dpY8QV6qhJAypp8qblo
         sKXJUCuprtd1TCED7USkr3CJF5ybLhny3dN44HyAOml+Jt3pNX+etPbJJhHJ7oMliWgL
         0HRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789417180; x=1790021980;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+AktPzAMD7v7+puIIygBX5NaQs925spQsBYks3yq6yc=;
        b=JXbBES7TJNwexejKlwKe3MLM8w2pApzcqd7WtbMNCuVyuznDF+FpMNSjRDtlVIbm7D
         IeBY5+GFpIvTrUj4EKCW7048LEtzV7wDkMGLlDh8CHTBw3GCkVPak/6mBEhKf7CIjJi0
         3JMYy6Q/dKNUkGcz7/qsI2b44A2u0Z6MFgSY91gJNAgkXWXWK+JEBv46yhxaJwKTkddE
         PTrRSa3pqeA460rZH6W0AAbF9q0N+PyJQpw3xg5PGqPNriC+GA4k9vCWbIdTWI0xaI8J
         a4NKHUy588ORutO14hBV6s1aC5BkyFhNVYwOvXNX7ZAMni3LcwAZf0gQ4S78t03r55+M
         dXLA==
X-Forwarded-Encrypted: i=1; AKwUvBzvz/aBav26OXCHNKyJRqLUijTLfOvgg4zHHOaB7dZhkXU+613ykXbLXfcHtr2/uEhE484Tc4789qkH5A==@vger.kernel.org
X-Gm-Message-State: AFuF++kJT8A7I7XVxWDDtBRbdBk5rxBrnhA4y1QdnQpGVlAj5h0+oaZH
	LsI41JD6vk5XR5rB8HTxQqYKkyXISmzkqeuCoV2ryef22eit9U9CA3m1a4qyRdQvKA==
X-Gm-Gg: AYBFou2+rdleGo5DDtdnOAMkJ0eCaut9jBzSu7fCCmGvstROr11jjEPzhHtsx+T7K4U
	8yyZrFtD9L4bMnXRw2Ectv0DqJLSe8265XAPAX48Z2r3oW265g8bcNGThmP1gituGl39SgpB8vE
	oA0PrNfGAml772VApw9D8BhFXk/623rTMl5CmOZXBRg1tlxmbdCV+yDsH2fXKuap3eYy1CcoUkO
	Lz24yzORbSjCSmf7+zleCvUENmY6o8JaQ1sf+lPQYzoEghT096EKQGm7AZYuq+ioJHAxuDvnrj5
	sV+F/bjjekqQIkt44Z0/YBT23jnsFFASnRrPOBw1dHdYcfu/THS9XXem8PDBGmwkjOPB3zAZscd
	bXnaI5Giom64w6Ut0vmfwyrXfJhyGkN82ap+NBWDAUDfr1wveHkyuuMgys9Vcm9mBOPBMgmThQi
	w8fzj/wKyIzM9TtzQVxC+wROB8GrZKbgABJGGhVK9DNUh8ViBFa1X5/ZjWLzur2vXmFTn6MvZMq
	mkf6uPXBkSO2iBBbGg6NA==
X-Received: by 2002:a05:6000:4b13:b0:485:4277:fbab with SMTP id ffacd0b85a97d-48702b3df5cmr4952883f8f.27.1789417179939;
        Mon, 14 Sep 2026 13:19:39 -0700 (PDT)
Received: from darker.lan (104.157.125.91.dyn.plus.net. [91.125.157.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32d3c7sm27112352f8f.10.2026.09.14.13.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:19:39 -0700 (PDT)
Date: Mon, 14 Sep 2026 13:19:37 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kas@kernel.org>
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
    Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>, 
    Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/26] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
In-Reply-To: <84fecd13-f1e4-7d40-94c9-963f5c2f7aee@google.com>
Message-ID: <5bd863e9-30a3-c01a-dc8c-c3802b864a6c@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com> <c44a34f8-ea3c-48cd-27d5-02df129be685@google.com> <aqLaa4QvXMbQaIWG@thinkstation> <84fecd13-f1e4-7d40-94c9-963f5c2f7aee@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 12 Sep 2026, Hugh Dickins wrote:
> On Thu, 10 Sep 2026, Kiryl Shutsemau wrote:
> > On Wed, Sep 09, 2026 at 02:55:41AM -0700, Hugh Dickins wrote:
...
> > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > index 8420b1276535..8f5efadf9c7c 100644
> > > --- a/include/linux/mm_inline.h
> > > +++ b/include/linux/mm_inline.h
> > > @@ -346,6 +346,7 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
> > >  enum {
> > >  	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
> > >  	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
> > > +	LRU_NEXT_ACTIVATE,
> > >  	NR_LRU_NEXT_FLAGS
> > >  };
> > >  
> > > @@ -358,6 +359,9 @@ bool lru_add_del_folio(struct folio *folio)
> > >  	if (!(lru_next & BIT(LRU_NEXT_BATCHED)))
> > >  		return false;
> > >  
> > > +	if (lru_next & BIT(LRU_NEXT_ACTIVATE))
> > > +		folio_set_active(folio);
> > > +
> > >  	WRITE_ONCE(folio->lru.next, LIST_POISON1);
> > >  	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
> > >  
> > > diff --git a/mm/folio.c b/mm/folio.c
> > > index a18d8ef6afd5..0b75c3b69d5a 100644
> > > --- a/mm/folio.c
> > > +++ b/mm/folio.c
> > > @@ -256,15 +256,32 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
> > >  
> > >  void folio_activate(struct folio *folio)
> > >  {
> > > +	unsigned long lru_next;
> > > +
> > >  	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
> > >  	    !folio_test_lru(folio))
> > >  		return;
> > >  
> > >  	/*
> > > -	 * XXX: It is curiously difficult to recreate safely the old
> > > -	 * __lru_cache_activate_folio() optimization (folio_set_active()
> > > -	 * directly if it's on the local lru_add fbatch): revisit later.
> > > +	 * This optimization is intended for the common case of folio
> > > +	 * having been recently added to this CPU's lru_add fbatch.
> > > +	 * But since other CPUs can now take it at any instant (after
> > > +	 * a folio_test_clear_lru()), and we may be migrated to another
> > > +	 * CPU, it is simplest just to extend the optimization to all CPUs.
> > > +	 *
> > > +	 * folio_set_active() would be unsafe without the lruvec lock, and
> > > +	 * a folio_test_clear_lru() here might cause a racing drain of the
> > > +	 * lru_add fbatch to skip its lru_add(): so use try_cmpxchg().
> > >  	 */
> > > +	lru_next = READ_ONCE(folio->lru_next);
> > > +	while (lru_next & BIT(LRU_NEXT_BATCHED)) {
> > > +		if (lru_next & BIT(LRU_NEXT_ACTIVATE))
> > > +			return;
> > > +		if (try_cmpxchg(&folio->lru_next, &lru_next,
> > > +				lru_next | BIT(LRU_NEXT_ACTIVATE)))
> > > +			return;
> > 
> > Hm. What prevents the folio from becoming unevictable under us here?
> > I don't see anything.
> > 
> > __folio_add_lru() wouldn't like it:
> > 
> > 	VM_BUG_ON_FOLIO(folio_test_active(folio) &&
> > 			folio_test_unevictable(folio), folio);
> > 
> > folio_lru_list() has the VM_BUG() too.
> 
> You're right, thank you. I thought I had deleted all such VM_BUG_ONs:
> and indeed I had, but only in a patch I later decided was too much for
> this series (removing PG_unevictable, using !folio_evictable() in some
> places, or folio_test_unevictable() testing another POISON in lru_next).
> 
> That excuse is not enough for this series! Yes, I must send a fixup,
> but not today.
> 
> > 
> > I am not sure what the right fix is.
> > 
> > Maybe lru_add_del_folio() should only call folio_set_active() on
> > !folio_test_unevictable() folios?

I was writing the commit message to a 7.1/26 fixup patch,
when I found I just could not describe any possible race here.

(And I was using your first suggestion, above: in the longer term I
prefer what I chose below, but decided it was better not to get into
that now: deleting various VM_BUG_ON_FOLIOs is better argued elsewhere.
There's another of them in folio_migrate_flags().)

folio_activate() has just checked !folio_test_unevictable(), so
it would have to be a race with something which sets the unevictable
flag on this folio at the same time as we find it's LRU_NEXT_BATCHED.

!folio_evictable() might become true at any instant,
but folio_test_unevictable()?

I cannot see what the racer could be: can you? I can see lru_add()
making it unevictable afterwards; and I can see folio migration
(successful or not) carrying unevictable forwards (or setting it
on a freshly allocated folio). But I cannot see any risky race
for folio_activate() or folio_mark_accessed() here.

Hugh

> > 
> > Or should we allow occasional active+unevictable
> 
> Yes, that's what I did, just removed the VM_BUG_ONs: but I'll need
> to check again whether that other patch also had to fix any ordering
> of checks. Offhand, probably not: once the "Unevictable LRU" became
> an oopsing fiction, it was important to check unevictable first:
> unevictable must take precedence, and then it really doesn't matter
> whether active is set or not.
> 
> > so if they are
> > munlocked, they will go directly to active list?
> 
> I didn't think of that, but I don't think that "active", set racily
> back when the folio was assigned "unevictable", bears much relation
> to whether it ought to be put on active or inactive list when later
> made evictable again. We should probably be consistent, and
> consistent with existing behaviour, that they go to inactive when
> made evictable. (I'm not looking at that other patch at present,
> I don't recall where active got cleared in it.)
> 
> Hugh
