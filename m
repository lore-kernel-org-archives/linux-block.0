Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017820E71F;
	Tue, 18 Mar 2025 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308668; cv=none; b=bnMLoEUA92jXxQ5LamO6E+3/xpHim37Ln9VJ9GbIRFfE3VmJeApXkTbuHEBeqNpgoR8aIMnB/6I+3bdEtlrDtrMBsqlpZEndcWLFdMwA88/9m6LOyMZsM5wCnxNw8jIXexhUuc8Q86PZqQFAu7OwgTjJvVqfNmQDeacWP6B4fnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308668; c=relaxed/simple;
	bh=S+SzAoV4VkJbQdrV5rI2W5YoxVeT10+1jkVRW/tgTNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD4Yry29eUt9gqCqh9jXWbhBKbMAHW+swCNHiU++FcYtvsg0ho0tgGpMWLhq1dBSlea+9TezJ5QegYowUDuVI9VJPioi6ys3CGCw0GvrSnmQ5jJi/aB7HdBxInlMPE551ZXXPyqemwBmbd+2ruFzTtnEu6WJOwycxIMVbPwFrqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dihRr+6G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dihRr+6G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=krQ2w5oa/13hMp5s6oxgij/ARPZRgCl2Yz1Oc/B1BiM=; b=dihRr+6GFa0fYkK/zEqisXpphV
	w20Af9RuL7TboUER/FV/IdfJaZ8Uj32O0DPAyNTbB4t739KOQ/+19zOR8+4VGmdtcet6MD5QimEFd
	JSDK8NR44hOStMM/yG9EkSHFYcDnLx+9fIVLXRhDE6koD5km4iuWm+KfrO62Sl3Rh06exJHle/8UM
	jF+Y5e9bQsf5mhZRe7dBLfVzxvMWefg2wmljqR8u/SKW4zSqtMUOBFRdKbXVksD8rEl/K4e4Xppjg
	dPjgsG8Hk8CI6TLB08JsS/MuCq83CrPOlVTrubGWhRnJdVasRZrK/qu1jw3CYee+YesBmdCobz79K
	fPDqTaYw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuY4Q-0000000FLpE-0DTl;
	Tue, 18 Mar 2025 14:37:30 +0000
Date: Tue, 18 Mar 2025 14:37:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Oliver Sang <oliver.sang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9krpfrKjnFs6mfE@bombadil.infradead.org>

On Tue, Mar 18, 2025 at 01:15:33AM -0700, Luis Chamberlain wrote:
> I also can't see how the patch ("("block/bdev: enable large folio
> support for large logical block sizes") would trigger this.

Easy enough to see by checking the backtrace.

> [  218.454517][   T51]  folio_mc_copy+0xca/0x1f0
> [  218.454532][   T51]  __migrate_folio+0x11a/0x2d0
> [  218.454541][   T51]  __buffer_migrate_folio+0x558/0x660

folio_mc_copy() calls cond_resched() for large folios only.
__buffer_migrate_folio() calls spin_lock(&mapping->i_private_lock)

so for folios without buffer heads attached, we never take the spinlock,
and for small folios we never call cond_resched().  It's only the
compaction path for large folios with buffer_heads attached that
calls cond_resched() while holding a spinlock.

Jan was the one who extended the spinlock to be held over the copy
in ebdf4de5642f so adding him for thoughts.

