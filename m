Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF070830
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745237178; cv=none; b=DQ1Ce2w1fZhFR1sv+sA4H8rM3Dz77bcvgt4d8r+HXymZM4loUSNl30HIda6K+JniyBYq4x1Na/tWCrM9aweTTglIuMKL1EWDOiCwBYpbNXcOTECLYF9tuJ5Ti97Rc8YADcah/0+XX0VM2vhV7zL++FXEMhnZ5k7RcvNL/qq3UtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745237178; c=relaxed/simple;
	bh=e7lxPoJ2207ODGnewMwlUHTRKRnJSTQm/YlEBTMVb64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGmysOTPiZZn1TbDoexAoYF6bkQVwgJLs0Y1YUcRHKjtn0+QdEoBLNeHoicuxTg6Qvj4Bf2pQ0ZS+xAZ5jEJap7qnGRknUrlBWOekIjnoax0l6kroGc+Xm193XFtlrcMc7kt7KatOG/x3uypSJfECOp7cGyutDovLEbC1JIgIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UKoVFQkP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UKoVFQkP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eYOxUnRI/9IJmYq7y6ham8CU7bq1EMiq083CsHSFh/g=; b=UKoVFQkPqbrysqM4tvcSabNLVv
	HvlE/7Vc4PDi+XL/PIG2xNB8odueP+Qj2QkTExJMJaYsZi13ueVd6c8Wxt4Ro/kk4KkxF6wwAGSwL
	6ssuueQMVGzeITpY0pKLXcw1GRPZwyPGzbyqxghWCk6+KwT9qFA9cQvqrjibV3H9d0r1nBFsHn+f4
	+1joCQIVfEFkm5rMrmUR10Odz3xYdk9XINWIBCyh99LNsyRvuTM4O2VnAfeCJo4zPel5X2zZ5VbOG
	DwkiT6Q2ILzqJEw2688aEcoXXo/paUFsfGYAFzzNDXswqsz+4CfbUAaS3iDDxjRzTYFZT3kgos4Z3
	zvZkPaOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6pui-00000004F18-0VKj;
	Mon, 21 Apr 2025 12:06:16 +0000
Date: Mon, 21 Apr 2025 05:06:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: integrity: Do not call set_page_dirty_lock()
Message-ID: <aAY0uKkZF254PYLE@infradead.org>
References: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
 <aAER-5JH38mYNMiu@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAER-5JH38mYNMiu@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 17, 2025 at 03:36:43PM +0100, Matthew Wilcox wrote:
> Let's suppose we're allocating the PI buffer in anonymous memory.
> Also, we're under memory pressure.  We've already swapped out the page
> containing the PI buffer once, so it's in the swap cache and marked
> as clean.  We do a READ from the device, and the new metadata is written
> to the page.  Then a new round of memory reclaim happens and this page
> is chosen.  If it's still clean, the new contents will not be written
> to swap and the page will simply be discarded.  When we go to validate
> the PI data, the page will be swapped back in, but it will have old PI
> information in it so the verification will fail.
> 
> What we need to do is mark the folio dirty at pin time.  I believe
> O_DIRECT does this properly, and I'm not sure whether this code does it
> properly or not.

O_DIRECT reads dirty right after pinning and then check if the dirty
bit has been cleared in the I/O completion handler and redirty from a
workqueue if so.  We're currently trying to figure out if we still need
that redirtying with proper pinning.

Either way metadata should follow the data behavior 1:1 here and
preferably also share the code for that as much as possible.

