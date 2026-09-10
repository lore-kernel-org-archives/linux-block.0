Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430724746D4;
	Thu, 10 Sep 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058581; cv=none; b=SdrHRTUafQkTV4r4sd39jXrKLxXbHEDriwfLH0MB2XqZfzPm8gH1wBT3X6t9ELyUbYiPhPlC9wooZ0k6ztdnpFQ1L8jMbKH9x8wswvtbULKT6QFFcx9iWX2qetwPOEOmraFgBDsfjyhEn9cAml0nqvIF5l988fIfRtXEGgILfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058581; c=relaxed/simple;
	bh=8Ri/Spiu7X3VxJRCZ/3Kkau/nCdLiYyhq30upHZz5ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na8GSRraqjkhn+F5Wh+UcHLoOdFn10D1c4Q+XrsFjN9+DLMM9wCkB4rDfpMGdusBA/6ArNEtK8sL7FqL4Y57hC1DiAG2UcjqYDR2izGZm4sgarTdwmUpdCXLe+AxUPZ9N8SEl7SkAaTccCnb+Rb7z6yPMjBW6TBSBqLWesiJwls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx6t+Yj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx6t+Yj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40211F000FF;
	Thu, 10 Sep 2026 16:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058578;
	bh=u+08F42gZ1mjtG948ilU+qH+waoqzEUJrlsSmxp12pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mx6t+Yj0PeebzMuIJqPgec3En+yEc3jysRhyQVcO/3xYfd6qRuj4KeQqGVNCzS2eL
	 tCtcfzvlsBuCl4wxQp6RjOgXiieppplEvlrHF+GHBK62/oFrGU48yOaMvfA3o8/DKl
	 lp6zHFol4XfSS/1l/cU6JxsVOB1VRQHK9uwzb3UaviBuy4O13O//74V+0i7C/ekLSM
	 xY/O3Idda5zMFFYFFSaqcOcGCxMfdZ0Giof01bXvDxALY83lMxS2B1Z6K0pJsE++qd
	 8ttfLDK+ZFgQeeUlUGkjRs+XrSEr2l8SmGBsKMUNs/VdxT4ev53Rb0h/F/7fMsBQj5
	 lpuAfGS8Cb3Sg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 5C10C198003A;
	Thu, 10 Sep 2026 12:42:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 10 Sep 2026 12:42:53 -0400
X-ME-Sender: <xms:Bd6iagPViEKcMUR9L2vFUVYNdprlzxw9XOLW44LJ6W1KhqtQxQnhvA>
    <xme:Bd6iattXOdK7DFkC0F0nDe7b7nzqRN_1slYG7pnn2eTjabVH1i1lJVoXBOTnkDcYD
    yQHBBQge5ZmMFR65IoCw_QeLeGdvdGeOn7HeFsJIZo_eBj7htu3DsCO>
X-ME-Received: <xmr:Bd6ialInbQnB2AqOShml-Iu32fBNfjpfNiHw8KMCpB9T_FsL6DAUsXfgPRE>
X-ME-Proxy-Cause: dmFkZTE6jQ7+ezdJvg0JCOHdeYm98uh8QoD3ppKlDCRkHPBf90NB4jh+ryx62TK4xbeazW
    OjmkN5eot9viRbZ00CYgDBHT2oH+RH5aQCFDDcusEjlg36Fb5ctpKOdLx985wH/FQip39p
    T7ct56TymSBRJpKxvgkeX9MwBtQkzBLcy1It/iWo2GFSKP14EPKpuBcDC6NZBPjPGuOYSt
    gDaf9qR90/vzX/n4LPNTXJAoXyXdh9FPu33aE25/XhViK2AK9AjkA9McfHxKUYwZZ4cNQy
    L9J1ZGy+68s9a/50qhSiH99Xat/XVOrftxEw7V9RkHk0x0GqdIBAFNnw6YCfe96nIenPCV
    unI4se8nbIGD4Kq9IYLNhYyv87qSPRhN+Krgj6j273FqV5FEWJwwMlgm5Sz+45zLTVppmx
    gHvNV0/P+4vzXnfFkqMihWIDJuG3ZV6EBEqsa8ZNbqO6blwIo2VGujQcKnZ0KB8O1A4cZh
    9aVyRAJDPIwz5b4tC125/MeGSy186XR8QU31P4geQmSY4nJzZjY/iH6DhjfNoFwbPWMawa
    e5jKQkqOdLGPlpHmn82M4fAZGG4IXR1RdfGZek9O9ES1ZEMAINtyHU1UsXLyrbltnxGrWV
    KMFv8bBZJLT//oUQTE/4JmHaZi+S9YjPBcCpBWE6Rkuxj00ZtgLEzvfdjpDQ
X-ME-Proxy: <xmx:Bd6iajt_a78yf2WByZxPGLwSXjlyfvmDfqklZ3D-bRcriVOd6tjAiw>
    <xmx:Bd6iak311tPhcHMu11wJQRGm-Fk6zSP8hp2lUqWvrnseo5WM6kic7Q>
    <xmx:Bd6iaupl1jqCNcNt6L9n9QuK98czBLyQ7VsDoSscYztatIFYfsUShA>
    <xmx:Bd6iav6AfsE1iY-2vTfH3cPqIiNOLEowj4RO_MWGwntIFX9Y4OIZvA>
    <xmx:Bd6iap0WK4EpvFtPf4iclLgLtn-EIP7kOOwcSnxor8OGyZNXXiZYHcGf>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 12:42:44 -0400 (EDT)
Date: Thu, 10 Sep 2026 17:42:43 +0100
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
Message-ID: <aqLaa4QvXMbQaIWG@thinkstation>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
 <c44a34f8-ea3c-48cd-27d5-02df129be685@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44a34f8-ea3c-48cd-27d5-02df129be685@google.com>

On Wed, Sep 09, 2026 at 02:55:41AM -0700, Hugh Dickins wrote:
> Implement an equivalent to the old __lru_cache_activate_folio()
> optimization, to activate a folio recently put in the lru_add fbatch,
> without having to put it through the lru_activate fbatch too. Neither
> lruvec lock nor lru bit can guard this safely and efficiently, so resort
> to try_cmpxchg() on a further, LRU_NEXT_ACTIVATE bit in folio->lru_next.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  include/linux/mm_inline.h |  4 ++++
>  mm/folio.c                | 23 ++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 8420b1276535..8f5efadf9c7c 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -346,6 +346,7 @@ static inline void folio_migrate_refs(struct folio *new, const struct folio *old
>  enum {
>  	LRU_NEXT_NEVER_TAIL = 0,	/* Used by a tail's compound_head */
>  	LRU_NEXT_BATCHED = 1,		/* Not used by any aligned pointer */
> +	LRU_NEXT_ACTIVATE,
>  	NR_LRU_NEXT_FLAGS
>  };
>  
> @@ -358,6 +359,9 @@ bool lru_add_del_folio(struct folio *folio)
>  	if (!(lru_next & BIT(LRU_NEXT_BATCHED)))
>  		return false;
>  
> +	if (lru_next & BIT(LRU_NEXT_ACTIVATE))
> +		folio_set_active(folio);
> +
>  	WRITE_ONCE(folio->lru.next, LIST_POISON1);
>  	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
>  
> diff --git a/mm/folio.c b/mm/folio.c
> index a18d8ef6afd5..0b75c3b69d5a 100644
> --- a/mm/folio.c
> +++ b/mm/folio.c
> @@ -256,15 +256,32 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
>  
>  void folio_activate(struct folio *folio)
>  {
> +	unsigned long lru_next;
> +
>  	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
>  	    !folio_test_lru(folio))
>  		return;
>  
>  	/*
> -	 * XXX: It is curiously difficult to recreate safely the old
> -	 * __lru_cache_activate_folio() optimization (folio_set_active()
> -	 * directly if it's on the local lru_add fbatch): revisit later.
> +	 * This optimization is intended for the common case of folio
> +	 * having been recently added to this CPU's lru_add fbatch.
> +	 * But since other CPUs can now take it at any instant (after
> +	 * a folio_test_clear_lru()), and we may be migrated to another
> +	 * CPU, it is simplest just to extend the optimization to all CPUs.
> +	 *
> +	 * folio_set_active() would be unsafe without the lruvec lock, and
> +	 * a folio_test_clear_lru() here might cause a racing drain of the
> +	 * lru_add fbatch to skip its lru_add(): so use try_cmpxchg().
>  	 */
> +	lru_next = READ_ONCE(folio->lru_next);
> +	while (lru_next & BIT(LRU_NEXT_BATCHED)) {
> +		if (lru_next & BIT(LRU_NEXT_ACTIVATE))
> +			return;
> +		if (try_cmpxchg(&folio->lru_next, &lru_next,
> +				lru_next | BIT(LRU_NEXT_ACTIVATE)))
> +			return;

Hm. What prevents the folio from becoming unevictable under us here?
I don't see anything.

__folio_add_lru() wouldn't like it:

	VM_BUG_ON_FOLIO(folio_test_active(folio) &&
			folio_test_unevictable(folio), folio);

folio_lru_list() has the VM_BUG() too.

I am not sure what the right fix is.

Maybe lru_add_del_folio() should only call folio_set_active() on
!folio_test_unevictable() folios?

Or should we allow occasional active+unevictable so if they are
munlocked, they will go directly to active list?

> +	}
> +
>  	folio_batch_add_and_move(folio, lru_activate);
>  }
>  
> -- 
> 2.51.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
