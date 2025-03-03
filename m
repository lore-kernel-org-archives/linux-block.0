Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028FC12FF69
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012956; cv=none; b=nfak/ZksoY9pBDkCPql88gE33+phuUjsJGnuIrq7iH3I3K0WipoxaUO7cNzFZf7KvbbaDVBjEAiDES8X2HOZTSg2lHizZrt+mudFnmDRnpbZDvkDkLWA8KQAsERjg7XmN8Id8RvWcPhnyz+bElWNidVXTkFt9PopwxIh0lYlNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012956; c=relaxed/simple;
	bh=GAtBfGbRe0vlx1ClmGTe6PvSxknfLKHi0ccpACQXHf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjYjMSqD/ORAIOo0EMmdtcJTt54QHjPjGUupht5GGDZgTEyTVWTX46T6FvsZGBsicTUuuSuc9qPryFPuYwOKdvyR5hcYX4B/ZcB6xGwpHoyJTLw9sb1Q0YukpxfxKCBEdrYkoJKyxvZCuHVDuxDJoicUdiX76DjTPrcigCRYmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fMjtlw9/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fMjtlw9/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L74JSotHWDPUP5TBM0hQkEM8p8tPw00XqklUA9G8JwE=; b=fMjtlw9/24EtzGGZI9GLAsjmLW
	iinSMSOKeK8riTV5HUi8/78FGb99T3v4BDXSuHkLTUodOSGGz6ONIHOqYniE2FRj4/7HBDtdCZZFQ
	un91u5skTOYWJH4+Ac0FkXBskIxivhSrl5npbunuU9iJNbIH1HhOIs5S0/F26TkEeiZzDW53cUUy/
	0T2DC7YHeMmfGR9A147o3gPqBEgFfJBE90ooXKN9sMR9dT2QIUL6qADqjUKeoCPWPYMXaQzrB13j/
	XRjDDvdZDt6Ie7PBSKGblc5hELN6ISusevEEOHNK/mff5C0BBtQvuIDnt6MDy7J7/GKNBzuFvUcdO
	zjEgniGw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp703-0000000BlqL-0XV4;
	Mon, 03 Mar 2025 14:42:31 +0000
Date: Mon, 3 Mar 2025 14:42:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8W_1l7lCFqMiwXV@casper.infradead.org>
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <Z8W8OtJYFzr9OQac@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8W8OtJYFzr9OQac@casper.infradead.org>

On Mon, Mar 03, 2025 at 02:27:06PM +0000, Matthew Wilcox wrote:
> We have a _lot_ of page types available.  We should mark large kmallocs
> as such.  I'll send a patch to do that.

Can you try this?  It should fix the crash, at least.  Not sure why the
frozen patch triggered it.

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 36d283552f80..df9234e5f478 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -925,14 +925,15 @@ FOLIO_FLAG_FALSE(has_hwpoisoned)
 enum pagetype {
 	/* 0x00-0x7f are positive numbers, ie mapcount */
 	/* Reserve 0x80-0xef for mapcount overflow. */
-	PGTY_buddy	= 0xf0,
-	PGTY_offline	= 0xf1,
-	PGTY_table	= 0xf2,
-	PGTY_guard	= 0xf3,
-	PGTY_hugetlb	= 0xf4,
-	PGTY_slab	= 0xf5,
-	PGTY_zsmalloc	= 0xf6,
-	PGTY_unaccepted	= 0xf7,
+	PGTY_buddy		= 0xf0,
+	PGTY_offline		= 0xf1,
+	PGTY_table		= 0xf2,
+	PGTY_guard		= 0xf3,
+	PGTY_hugetlb		= 0xf4,
+	PGTY_slab		= 0xf5,
+	PGTY_zsmalloc		= 0xf6,
+	PGTY_unaccepted		= 0xf7,
+	PGTY_large_kmalloc	= 0xf8,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1075,6 +1076,7 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
  * Serialized with zone lock.
  */
 PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
+FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
 
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3..872e1bab3bd1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4241,6 +4241,7 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
 		ptr = folio_address(folio);
 		lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
 				      PAGE_SIZE << order);
+		__folio_set_large_kmalloc(folio);
 	}
 
 	ptr = kasan_kmalloc_large(ptr, size, flags);
@@ -4716,6 +4717,11 @@ static void free_large_kmalloc(struct folio *folio, void *object)
 {
 	unsigned int order = folio_order(folio);
 
+	if (WARN_ON_ONCE(!folio_test_large_kmalloc(folio))) {
+		dump_page(&folio->page, "Not a kmalloc allocation");
+		return;
+	}
+
 	if (WARN_ON_ONCE(order == 0))
 		pr_warn_once("object pointer: 0x%p\n", object);
 
@@ -4725,6 +4731,7 @@ static void free_large_kmalloc(struct folio *folio, void *object)
 
 	lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
 			      -(PAGE_SIZE << order));
+	__folio_clear_large_kmalloc(folio);
 	folio_put(folio);
 }
 
