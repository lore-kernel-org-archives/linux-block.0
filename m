Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B995199EB2
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900614; cv=none; b=WLuuWkXDdHU4V/ojl9vscDH77ZmhLxT3SXNhiIsn7hAEG3Vm9Uhu27keOKvNJKF4bWbAeear8VzjjaPFZEboCmxbyUTfQb3DXrIQ0AMytlwoiisFo538EiBhbhgw+bVhbwDt+DJ25qoVT70Ea8aUKwHj4wUcjD2CqKH4AyhkuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900614; c=relaxed/simple;
	bh=2KWscpDpGf7IXTPTvjL9qu6WwV7FMOh1vwEHRZUaLdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaBlbWzUWnBMVCqOQ0Cz9l5Ql9se7QHy/Ebqekr0uYB940mIaF75boYFS46UK0uGf+QsvvDSp7b5uAytRJ3N45jKJ3uO1pHZsYzWxzGMra9IMlmEvCrYi5NaLi6lklUtcm9QgZc3/kmQd4eD2y4PvAOYrcgqwSjOIibLl7MaPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TQF/hZDu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TQF/hZDu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3fENVvO9sxtdImC8xafQ/9uCpwArv9kYQ3jgZPacHBU=; b=TQF/hZDu/aAtUZ1r+bwaznH1Gq
	L4oL56FdSPG/syVl2/oXupLNbN8LFufE7cZu4PN3q1pkDyqRgygghrxbSh78olYoY16DILMgnrqU1
	xOtNJCplp7yOTqrK1ELFw0iJpEQ1IncOsGAvkXsbpnfiD2dR6DLw2S4+8XkjbQJmcivgAbI6MQadd
	TTvXTJfroeNWi0m0LAzM4gq9HU6LjojFLECOhvYx2lA1xlkmRcq0KVu5nMkiJBxye4L0bq/mwkOfC
	HL3e54eKSdDf38in+Qt99eH7ODp8Z8ZCYjum9sMgUhu9nQbzG61+VE/aeR8X4yr5LgFrfc5Fn8Vei
	J99vkkew==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5QM7-0000000BXsK-0fzS;
	Thu, 17 Apr 2025 14:36:43 +0000
Date: Thu, 17 Apr 2025 15:36:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: integrity: Do not call set_page_dirty_lock()
Message-ID: <aAER-5JH38mYNMiu@casper.infradead.org>
References: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>

On Wed, Apr 16, 2025 at 04:04:10PM -0400, Martin K. Petersen wrote:
> Placing multiple protection information buffers inside the same page
> can lead to oopses because set_page_dirty_lock() can't be called from
> interrupt context.
> 
> Since a protection information buffer is not backed by a file there is
> no point in setting its page dirty, there is nothing to synchronize.
> Drop the call to set_page_dirty_lock() and remove the last argument to
> bio_integrity_unpin_bvec().

I think the patch is right, but the commit message is wrong.

Let's suppose we're allocating the PI buffer in anonymous memory.
Also, we're under memory pressure.  We've already swapped out the page
containing the PI buffer once, so it's in the swap cache and marked
as clean.  We do a READ from the device, and the new metadata is written
to the page.  Then a new round of memory reclaim happens and this page
is chosen.  If it's still clean, the new contents will not be written
to swap and the page will simply be discarded.  When we go to validate
the PI data, the page will be swapped back in, but it will have old PI
information in it so the verification will fail.

What we need to do is mark the folio dirty at pin time.  I believe
O_DIRECT does this properly, and I'm not sure whether this code does it
properly or not.
