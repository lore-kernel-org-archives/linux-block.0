Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581C2DA76C
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380206; cv=none; b=C4+AxvqlUhHOk1cUqQAolvp5PnLmh1qpooZmDJpEHG1nwnm23HFDKoWoVKJQTkoUHHldogXunecl7cgV4LHZDIKAV9tfR4PdWHIvHcIP7/k3pjhDrrJFY0k08kXq04R0HOWQJiYN8cAQbPZ32JDV4ZPiKNBAc3QEiHKHR7SBQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380206; c=relaxed/simple;
	bh=/JRa57UzU9TMspp887d1swSAsmjE9w79TS18+HcV7u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l326WB2ULjiNKDtkcv8N/iQOoui2q8HoXlP/xbrR91CPXN/W0pHMpp55F89omIg0WxxorxYmL2M3INcIuyHJZ9e/sSXWGjGxUjoViujPDcsDYbnTA0xZD38jR/VsTz00dRtST1sMQtJ38n4KDeSSD1aDacZhrUkLRKAWnV6MuMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 85DB368BFE; Tue,  2 Jun 2026 08:03:20 +0200 (CEST)
Date: Tue, 2 Jun 2026 08:03:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: bio_copy_from_iter
Message-ID: <20260602060319.GA325@lst.de>
References: <ah28-oyillEaOrm1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah28-oyillEaOrm1@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 01, 2026 at 06:10:18PM +0100, Matthew Wilcox wrote:
> I'd like to remove copy_page_to_iter() (and only have
> copy_folio_to_iter()).  That led me to looking at bio_copy_to_iter().
> At first glance, switching it to bio_for_each_folio_all() makes a lot of
> sense -- if there are large folios involved, then we can copy an entire
> folio at a time instead of a page.
> 
> But what I can't prove to my satisfaction is that every bio passed to
> bio_copy_to_iter() necessarily contains folios.  That's not currently
> necessary, but will become necessary in the future. [1].

bio_copy_to_iter is only called from blk_rq_unmap_user, which is only
used for bios created blk_rq_map_user_iov and only used when they had to
be bounce buffer.  There's two sources of pages for the bounce buffering:
The allocation in bio_copy_user_iov using alloca_page, and whatever sg
and st pass in through struct rq_map_data.  A good step to be able
to validate this would be to kill the mess around struct rq_map_data,
as in removing that structure.  There's no good reason why these
drivers should do their own allocations, this has mostly been
grandfathered in.

> [1] I believe all these bvecs are constructed using
> blk_rq_map_user_iov() which can end up calling bio_add_vmalloc(),
> and vmalloc pages will not be folios.

blk_rq_map_user_iov can't call bio_add_vmalloc.  And if you want to make
the vmalloc backing not folios you will be in a huge world of pain
anyway, as we expect to back folios using vmap/vm_map_ram and treating
vmalloc different from this will be extremely messy and invasive.
