Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C83A874B
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955621; cv=none; b=lasusS5JV3b5qE5pjmTrly/1j9OVj86Ws6sN1LyWyVeJLDTHnRA++WRcr5zIPZSJAOqQ7vyVn72Lt8bFtmZvo7f51DnA7HfAIntwu3vx/M9nfXHdzgqCf2TfmsB3mlsOY57Ft+8PO4sntTiOeZiYqIJyVnVkfTmdGrcnDpgd2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955621; c=relaxed/simple;
	bh=G+MobNW6sFYY1PlV2jcL6Xl7xdSNiLeQQpY4jB5oAx8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JTBCC3Pux4KaV6kk/lUbaeT1Texh9DXHmHpuJ8/p4xgbTXiOZQcqPvm0MhOS/OIOjqCsSKfT6wyqwwmkEuRjW4lULvOP7yFP8XuqyqyoCQ1chtlq8iXDMDef1OoXun/RRCPVNbzGApSPPt+E97qkpSkn+n2dD9zaydZGtCwHGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/YGTpYW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/YGTpYW"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-857ff9fef54so18489617b3.1
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787955618; x=1788560418; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b4S/8Koo0tWCwmsJIfU4dprBEqIORdY9GwO+Ne2fREg=;
        b=Q/YGTpYWHWhFhD6IbaJ8kiTbmq+3IGDvIXRTlOgh8B8pIYniN9uN6obNg7AgkXKaRM
         6vJOP7TtVmPnaELtdHuFMO3QYx/6xdTo/5E15gwV3xWRflO+YJoNj0yC4AlobCDynyZq
         ilTKuHFGYIBL0mVshIHBCZmtx1iy+JXtMTNSL6aHg5wFkHUZ08z/l3311kE3XCt/uAsZ
         FuWnt3eRLv5bfm7q1E2a+iqn74FNUlWgthHQUksBadNRHqAoVydeMOBHieAnO8i0zfWg
         C/l6thBRBFddTl/XmN+ZaqYP9hOnqSBJ+UYVzGL7kQ3FOXQgJgYzVDD8KY+SI7Ng05eo
         UKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787955618; x=1788560418;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4S/8Koo0tWCwmsJIfU4dprBEqIORdY9GwO+Ne2fREg=;
        b=NDueHDKm2zyaRTlyGA0GZidSlcsizd7zQBJ+GBfAPFVNrVV8xcYi1qz7QR7wH/g65Q
         vjT8zKtZ5Ip8TGyth9pmlySu3IxHho4GOohpezFtbk9TWWplQ3IPRs3Bt1c+r66sCwul
         Ze3yUnpY2p+dpGwE4TSfeQybEdvAtCYM72TgRVXUc/etsSjajvQH2jTyJkOQrD8vjz79
         cCcoTz8ibH7tmejzol/C/bL0Y2i9cE0pQ4p/PNRleRdxYPoywDPa/UPn5q68Y9fAUIOe
         gwETKO6lX7+D45+D4nKr5lYDd7U8GmgR2yXPWbn7RqVKMQEf9xI4x9hegzrW5Ca82gHf
         wLvg==
X-Forwarded-Encrypted: i=1; AKwUvBwafRSW49nha4TeOCF0hKXftFi8qnkD5/NBhvNxd/XAgzgYNLa5RV8CzYZgHzE9uGT9ghacFGSS3fWR4w==@vger.kernel.org
X-Gm-Message-State: AFuF++mGuKgPGIBu3iAViDSVKDOifPburYEH6KhqNr57cPYd233EAwST
	kuJPk/95szJcfC17maLS7simiuzMMS2Wj068Q17S6tyw574U6EMkXTQfhnrXLgnFfQ==
X-Gm-Gg: AYBFou0qTFnJixv+GjJ5TA56l/w9A7+MQOwAClSnUsT5C5NCka0J3yigOwE9dDZnMl3
	HLiVp2eyf5DblYFZqiix5kCo7sXAKigSKGwZ71cpJShZyTTqGimFunnabtzHndk2HxIlitcMMzw
	KDwU2/wxBIKoCqarBTlZ7h/pQzA3L+d6zpfIVtX9PQXFqSTvbveXyPd3WvaiUmjXK0kd3pH0J6B
	qpG7JOp/OTQJCwsGaNnlghc3YAIxgNFHQ5FIfp+H9OuoXXIdx2lQNRN8ZjRk8EE/tvv31ABjtRY
	M4tYK1XWoTJ1Q60FDvrsVS6bd+SS26/ypGaHoj8sssu6M9PLYd3/tAFhsqvYJt5BW7J0kH/+LY/
	fQJDzar1XWfM0QYszyib9XwTfwaUCIZdv/eRynIxwJtf7SRhPXsEhjSktBguPldqh4jw/5sKzhp
	1FiukGXHy1p7VbjtreHA+TiYxQDASqSI5du9/PJLDhc9dkBNtZfDfi8YL8C7e+zfUVIDdIddje7
	YCZ8jSB78i8k4gtuquowSUe0kWTyFdgfpwNFCfOGn7DpKFOIFyQ82C8JHQ=
X-Received: by 2002:a53:e884:0:b0:66d:2e51:5690 with SMTP id 956f58d0204a3-66e4c6242d9mr2552474d50.11.1787955617852;
        Fri, 28 Aug 2026 15:20:17 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed2c78esm1613351d50.19.2026.08.28.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 15:20:16 -0700 (PDT)
Date: Fri, 28 Aug 2026 15:20:11 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Matthew Wilcox <willy@infradead.org>
cc: Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kas@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
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
Subject: Re: [PATCH 04/25] mm/fbatch: lru bit set, no extra ref, while folio
 on per-cpu fbatch
In-Reply-To: <apGd6T84Zs1RgTVg@casper.infradead.org>
Message-ID: <d8834642-140a-0bc6-0b3b-abcfbb8ada6f@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <e0887417-85a7-453e-e733-561dc11db08f@google.com> <apAaWsWPV9QEeVwn@thinkstation> <3b8d9cc4-d6f9-6bd6-f774-34cfca9c48c9@google.com> <apGd6T84Zs1RgTVg@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Aug 2026, Matthew Wilcox wrote:
> On Fri, Aug 28, 2026 at 01:04:34AM -0700, Hugh Dickins wrote:
> > On Thu, 27 Aug 2026, Kiryl Shutsemau wrote:
> > > On Mon, Aug 24, 2026 at 07:01:20AM -0700, Hugh Dickins wrote:
> > > > Treat folios on a per-cpu fbatch as if they were already on the lruvec:
> > > > with PG_lru set, without holding an extra reference. This will enable
> > > > the removal of most lru_add_drain() and lru_add_drain_all() calls soon.
> > > > 
> > > > Recognize such a folio by 0x02 set in the folio->lru.next pointer by
> > > > folio_add_lru().
> > > 
> > > Hm. pfmemalloc (__GFP_MEMALLOC) thingy already claims the bit. Is it
> > > safe because such memory is never on LRU?
> > > 
> > > Are pfmemalloc and PG_lru mutually exclusive?
> > > 
> > > Do we want to be explicit about this? Like, folio/page_is_pfmemalloc()
> > > shouldn't return true for PG_lru folios/pages or something.
> > 
> > Gosh, thanks so much for pointing that out: I was completely ignorant
> > of the the pfmemalloc use, and a bit (bit 1!) shocked to learn of it
> > (why wouldn't they just reuse a pageflag, I wonder? but doesn't matter).
> 
> The idea is that it is used temporarily to communicate from the
> page allocator to the caller "This only succeeded because of
> PF_MEMALLOC".  Making it a page flag would require all callers be
> aware of it -- most simply do not care.  PF_MEMALLOC was set on
> their behalf and there is nothing they can usefully do with this
> information.
> 
> So we want to communicate it in a way that allows the unaware caller to
> discard the information, and I chose bit 1 of page->lru.next.  We
> used to use page->index == -1UL (which was also naturally overwritten by
> the unaware caller), but we needed to have it be part of PP_SIGNATURE
> and that needed to be not part of page->index ...
> 
> Commit dc8cf7550a70 if you want to read more about it.

Thanks for explaining, I had looked at some of the other commits
implicated, but not that one.

So, it's a special snowflake which can melt away before it interferes
with anyone not interested (which a page flag would not): yes, that
makes some sense.

> 
> We do use a page flag in slab; we check the pfmalloc bit and move it
> into a page flag (SL_pfmemalloc).  But we don't use it for folios.
> 
> While there is a folio_is_pfmemalloc(), I think that was a mistake
> and it should now be deleted.  It hasn't been used since slab was
> converted away from folios last November.
> 
> > Anyway, as you've rightly guessed, it's not a problem at all: these
> > mm/folio.c and mm/mlock.c per-cpu fbatches are entirely for folios;
> > and if any pfmemalloced page ever get used for a folio (dunno) and
> > put on an fbatch for LRU, then of course its use of lru.next is
> > immediately overwritten (first by what this patch writes in lru_next,
> > then later by the lru.next pointer for whatever LRU it goes on to -
> > just as before this patch).
> > 
> > If you were to tell me that some subsystem uses PG_lru for some
> > other purpose, then I would have to get more worried; but we can
> > be fairly sure that's not so, since mm/compaction.c for one relies
> > on konwing it's free to  play with PG_lru folios.
> > 
> > Whether a folio is ever allocated with __GFP_MEMALLOC, I'm not
> > certain (haven't looked), but there is no need to exclude that:
> > it simply would not retain that page_is_pfmemalloc() info across
> > folio_add_lru().
> 
> That's the correct thinking.
> 
> How about this patch?

Oh, when I said "This certainly deserves a comment somewhere",
I meant an acknowledgement somewhere in my series, not a complaint
that it had not been already commented.

Once Kiryl pointed me, I found the comment in page_is_pfmemalloc()
good enough: the problem is not the wording of the comment, but
knowing where and when to look for such a comment. We have many
header files, and understandably no registry of low bits in pointers.
Wherever you put a good comment, I'd have missed it.

So, I was okay with the original, but your longer explanation below
looks fine, and the removal of folio_is_pfmemalloc() good, but best of
all is the comment line (nit: wants a full stop) you add in mm_types.h.

Thanks,
Hugh

> 
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dd09c438fa23..fcefffb52d3e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3122,36 +3122,25 @@ static inline void *folio_address(const struct folio *folio)
>  	return page_address(&folio->page);
>  }
>  
> -/*
> - * Return true only if the page has been allocated with
> - * ALLOC_NO_WATERMARKS and the low watermark was not
> - * met implying that the system is under some pressure.
> +/**
> + * page_is_pfmemalloc - Page allocation should have failed
> + * @page: The just-allocated page
> + *
> + * Usually the page allocator keeps some memory in reserve.  If
> + * __GFP_MEMALLOC is used, the page allocator can dip into those
> + * reserves.  The caller can find out if the allocation came from
> + * the reservers by calling this function.
> + *
> + * If the caller does not care, it can simply use the page as
> + * normal.  The field that the information is stored in is usually
> + * overwritten by most uses of a page.  Nobody should call this for
> + * a page they did not allocate as it can easily have false positives.
>   */
>  static inline bool page_is_pfmemalloc(const struct page *page)
>  {
> -	/*
> -	 * lru.next has bit 1 set if the page is allocated from the
> -	 * pfmemalloc reserves.  Callers may simply overwrite it if
> -	 * they do not need to preserve that information.
> -	 */
>  	return (uintptr_t)page->lru.next & BIT(1);
>  }
>  
> -/*
> - * Return true only if the folio has been allocated with
> - * ALLOC_NO_WATERMARKS and the low watermark was not
> - * met implying that the system is under some pressure.
> - */
> -static inline bool folio_is_pfmemalloc(const struct folio *folio)
> -{
> -	/*
> -	 * lru.next has bit 1 set if the page is allocated from the
> -	 * pfmemalloc reserves.  Callers may simply overwrite it if
> -	 * they do not need to preserve that information.
> -	 */
> -	return (uintptr_t)folio->lru.next & BIT(1);
> -}
> -
>  /*
>   * Only to be called by the page allocator on a freshly allocated
>   * page.
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 09cb1e18bc16..9bcfc4213b91 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -85,6 +85,7 @@ struct page {
>  	 * WARNING: bit 0 of the first word is used for PageTail(). That
>  	 * means the other users of this union MUST NOT use the bit to
>  	 * avoid collision and false-positive PageTail().
> +	 * Bit 1 of the first word is used by page_is_pfmemalloc()
>  	 */
>  	union {
>  		struct {	/* Page cache and anonymous pages */
