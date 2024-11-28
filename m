Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED4E256D
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732764022; cv=none; b=epgT1LDFzAILvqa7YxWRg3yiQ1gXEb4giySJrl4PEeyfsltB0edTfzUuSaxipChOI1U/sM+rYbC0mwj4eIzBHQPRhcjr0KCb19khv/mc3/XfXdZYnEVa4lythQJUmRgGXC6F6ja33BexftGSysuljp7ZBqhQMvvIR4SzSP/uTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732764022; c=relaxed/simple;
	bh=x/fJks/YHODwav56/Z5h1Uc+GbnskjmlZ6NzyqVih/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPZNZvMRri9lULWpFgz110r9U/1eO1gwK2D9v3AAh6YytFM7psMQxMKBLfP4BvFRR60KJaLXRUTXo1M+uYjLlodXcNDnN84omVlLQxLs3qgicBSYBZ0UHZHzbaf/b6UZGg/pYXS2JTf0uUvME+082xCmejDhH4l21DEUQzhWXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X6d1+LeL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X6d1+LeL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xdgvfjgvDp8iNtxOmGJePWERetGZNVykVj+5nn9wvys=; b=X6d1+LeLQvJqKIN5ybiiJMM+3t
	pHEwrdcWFYAf3F5Q1IfsTiAgIBA6w4FcAUKreRGGTmi9SJGN/z2cLq2WCGF6CZCFw4futBU1C5CK4
	Vdh5EjmkpEdgFLbgSSXObDz+6jff9VgPLUv6Evt8J9yoTEouqh87yxr3FoTxcfDhgJS+o2gWXx2FB
	zyvFZHgL+6Yv4rpnKOja5fzjCgT7PB8ouDfQbsf2oYFCxR/Wyny2KOZ6ykbiGLWwgI7pUQv/pq5YK
	MBnzQJhyc8YBUXZ2Bxe7dZUyk00ZaaCTT5V7YT/SooJaJr6ygO0F7T5ew+sIRDzsglGYld8uVb0tV
	Lvig1gwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGV4l-0000000EbTr-1VA6;
	Thu, 28 Nov 2024 03:20:19 +0000
Date: Wed, 27 Nov 2024 19:20:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0fhc8i-IbxY6pQr@infradead.org>
References: <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
 <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
 <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
 <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
 <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 28, 2024 at 08:18:16AM +0900, Damien Le Moal wrote:
> The BIO that failed is not recovered. The user will see the failure. The error
> recovery report zones is all about avoiding more failures of plugged zone append
> BIOs behind that failed BIO. These can succeed with the error recovery.
> 
> So sure, we can fail all BIOs. The user will see more failures. If that is OK,
> that's easy to do. But in the end, that is not a solution because we still need

What is the scenario where only one I/O will fail?  The time of dust on
a sector failign writes to just sector are long gone these days.

So unless we can come up with a scenario where:

 - one I/O will fail, but others won't
 - this matters to the writer

optimizing for being able to just fail a single I/O seems like a
wasted effort.

> to get an updated zone write pointer to be able to restart zone append
> emulation. Otherwise, we are in the dark and will not know where to send the
> regular writes emulating zone append. That means that we still need to issue a
> zone report and that is racing with queue freeze and reception of a new BIO. We
> cannot have new BIOs "wait" for the zone report as that would create a hang
> situation again if a queue freeze is started between reception of the new BIO
> and the zone report. Do we fail these new BIOs too ? That seems extreme.

Just add a "need resync" flag and do the report zones before issuing the
next write?

