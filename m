Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AA463B85;
	Fri, 28 Aug 2026 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928078; cv=none; b=lZGqhOnjGX0WP1v/eYzdmbHPRaNXTIhEvQ0tpQnWZT/PbVKrNvaRvROwhT+J/WfPFLY+vEj6XSHJ3AJY7dmUWYT8uvLL6VAPOlRKhm1nUZqJnyKIB4CjP2m6AX7ToWjTDiwyxrR29yG/NG6f3jTwt7gMA9bl+qlTpvRTXSiUoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928078; c=relaxed/simple;
	bh=Zk2lLawAVtiA5kIDVK7dR8UmSrPGPvhMa8loRHiylXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxnXHIGCWj4rQQg8mcqVVa6EGmKGJaY0wrQuXEHtQChuluWlpxt5B4XtlbfO8SC5tSnEaHedIwMdkqpgqGJhINJAVe+m3sWlyDlAlPWerPZ58kpIoC9wBXAJySrqB0ZoEx1f9yUL8CEG6BPLiNRh5SuHzekSyWgMGw8MFYLdAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=panAWlyH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="panAWlyH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dMVNde2wkTvg21HA6gMMmOc6O33QVmC43CxfG7wt05E=; b=panAWlyHZ294r8CVUs1Mm0l75I
	Fqt6DYaJvW4Q2ZEsuTzJV+rrIZ/kMojDsSLozPad5UdoK1OegnDlPFX6SavtvreoybTU4bYeYvAzH
	DYJJ5pzY3rY3zoX9Q6zxpJI8tj6rB+OlMdAKOTts4anffWRGrqrjTCaUF+R6Kg52sZBl9qSKoALPR
	8t6sTZhlF8WOnLwzCXUmtqKz3ZtvfwgtYOQJx9aKgPMZ/50LvwONfzYIvWzmxC2ohjzZSCDfPkw8w
	ipxGVHtu3VTsMJV0czrZ188J1wwRIMXKLGIDYQQIxhkZ927L1IaULYL+JNI1M2QOnK6aU7/E3I2zL
	NwjsEWmw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzxl4-0000000Eq6F-0ksv;
	Fri, 28 Aug 2026 14:40:42 +0000
Date: Fri, 28 Aug 2026 15:40:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Christoph Lameter <cl@gentwo.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <ryncsn@gmail.com>, Lance Yang <lance.yang@linux.dev>,
	Leonardo Bras <leobras.c@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <apGd6T84Zs1RgTVg@casper.infradead.org>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
 <e0887417-85a7-453e-e733-561dc11db08f@google.com>
 <apAaWsWPV9QEeVwn@thinkstation>
 <3b8d9cc4-d6f9-6bd6-f774-34cfca9c48c9@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8d9cc4-d6f9-6bd6-f774-34cfca9c48c9@google.com>

On Fri, Aug 28, 2026 at 01:04:34AM -0700, Hugh Dickins wrote:
> On Thu, 27 Aug 2026, Kiryl Shutsemau wrote:
> > On Mon, Aug 24, 2026 at 07:01:20AM -0700, Hugh Dickins wrote:
> > > Treat folios on a per-cpu fbatch as if they were already on the lruvec:
> > > with PG_lru set, without holding an extra reference. This will enable
> > > the removal of most lru_add_drain() and lru_add_drain_all() calls soon.
> > > 
> > > Recognize such a folio by 0x02 set in the folio->lru.next pointer by
> > > folio_add_lru().
> > 
> > Hm. pfmemalloc (__GFP_MEMALLOC) thingy already claims the bit. Is it
> > safe because such memory is never on LRU?
> > 
> > Are pfmemalloc and PG_lru mutually exclusive?
> > 
> > Do we want to be explicit about this? Like, folio/page_is_pfmemalloc()
> > shouldn't return true for PG_lru folios/pages or something.
> 
> Gosh, thanks so much for pointing that out: I was completely ignorant
> of the the pfmemalloc use, and a bit (bit 1!) shocked to learn of it
> (why wouldn't they just reuse a pageflag, I wonder? but doesn't matter).

The idea is that it is used temporarily to communicate from the
page allocator to the caller "This only succeeded because of
PF_MEMALLOC".  Making it a page flag would require all callers be
aware of it -- most simply do not care.  PF_MEMALLOC was set on
their behalf and there is nothing they can usefully do with this
information.

So we want to communicate it in a way that allows the unaware caller to
discard the information, and I chose bit 1 of page->lru.next.  We
used to use page->index == -1UL (which was also naturally overwritten by
the unaware caller), but we needed to have it be part of PP_SIGNATURE
and that needed to be not part of page->index ...

Commit dc8cf7550a70 if you want to read more about it.

We do use a page flag in slab; we check the pfmalloc bit and move it
into a page flag (SL_pfmemalloc).  But we don't use it for folios.

While there is a folio_is_pfmemalloc(), I think that was a mistake
and it should now be deleted.  It hasn't been used since slab was
converted away from folios last November.

> Anyway, as you've rightly guessed, it's not a problem at all: these
> mm/folio.c and mm/mlock.c per-cpu fbatches are entirely for folios;
> and if any pfmemalloced page ever get used for a folio (dunno) and
> put on an fbatch for LRU, then of course its use of lru.next is
> immediately overwritten (first by what this patch writes in lru_next,
> then later by the lru.next pointer for whatever LRU it goes on to -
> just as before this patch).
> 
> If you were to tell me that some subsystem uses PG_lru for some
> other purpose, then I would have to get more worried; but we can
> be fairly sure that's not so, since mm/compaction.c for one relies
> on konwing it's free to  play with PG_lru folios.
> 
> Whether a folio is ever allocated with __GFP_MEMALLOC, I'm not
> certain (haven't looked), but there is no need to exclude that:
> it simply would not retain that page_is_pfmemalloc() info across
> folio_add_lru().

That's the correct thinking.

How about this patch?


diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd09c438fa23..fcefffb52d3e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3122,36 +3122,25 @@ static inline void *folio_address(const struct folio *folio)
 	return page_address(&folio->page);
 }
 
-/*
- * Return true only if the page has been allocated with
- * ALLOC_NO_WATERMARKS and the low watermark was not
- * met implying that the system is under some pressure.
+/**
+ * page_is_pfmemalloc - Page allocation should have failed
+ * @page: The just-allocated page
+ *
+ * Usually the page allocator keeps some memory in reserve.  If
+ * __GFP_MEMALLOC is used, the page allocator can dip into those
+ * reserves.  The caller can find out if the allocation came from
+ * the reservers by calling this function.
+ *
+ * If the caller does not care, it can simply use the page as
+ * normal.  The field that the information is stored in is usually
+ * overwritten by most uses of a page.  Nobody should call this for
+ * a page they did not allocate as it can easily have false positives.
  */
 static inline bool page_is_pfmemalloc(const struct page *page)
 {
-	/*
-	 * lru.next has bit 1 set if the page is allocated from the
-	 * pfmemalloc reserves.  Callers may simply overwrite it if
-	 * they do not need to preserve that information.
-	 */
 	return (uintptr_t)page->lru.next & BIT(1);
 }
 
-/*
- * Return true only if the folio has been allocated with
- * ALLOC_NO_WATERMARKS and the low watermark was not
- * met implying that the system is under some pressure.
- */
-static inline bool folio_is_pfmemalloc(const struct folio *folio)
-{
-	/*
-	 * lru.next has bit 1 set if the page is allocated from the
-	 * pfmemalloc reserves.  Callers may simply overwrite it if
-	 * they do not need to preserve that information.
-	 */
-	return (uintptr_t)folio->lru.next & BIT(1);
-}
-
 /*
  * Only to be called by the page allocator on a freshly allocated
  * page.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 09cb1e18bc16..9bcfc4213b91 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -85,6 +85,7 @@ struct page {
 	 * WARNING: bit 0 of the first word is used for PageTail(). That
 	 * means the other users of this union MUST NOT use the bit to
 	 * avoid collision and false-positive PageTail().
+	 * Bit 1 of the first word is used by page_is_pfmemalloc()
 	 */
 	union {
 		struct {	/* Page cache and anonymous pages */


