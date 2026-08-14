Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CEE35E944
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689513; cv=none; b=KoM9df/azZ/CNq2j2EvuuDA1CVseWQo0JE73BnfU1vu4kEP/Deo2aF7wy2pT2JyqxoQvTB5mOxdU0pe9JptJS3m2OIuAyT288o/b2xPlYogBWF1y1Sy8Y9V8WVP552gW3gSVj0AbqqF0/jE7nLlmtZLuFdK3B7XO1WynGZkhX/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689513; c=relaxed/simple;
	bh=+/m8L+Wn4sOZ1lsfUvwrealyzwKXpVBI0An3cd9GCKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvbkT1iwdS4KX7tOCH+5Ohp7kv+cWXh7tYdQooIuLNRwesc5qCd5p9sKGaxaFZF4EANFTbgnPfQmMfvhRmQYiusRCYyfEFxqABo7sQdAG/7tjB8MJZKEFwmV/qjdTOtXJLmb0+CbrbxKr6+GlQhH4Zfmy+NFyBTOKVflYQG4z7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SHEoe3/V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SHEoe3/V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x4CEmQJ+1unlCnPFvvKSl8ucafgqrF8+bHZM5boKh6E=; b=SHEoe3/VgeazPuljobYrSMihvy
	y5TfzbNAU71GXNjDcX835dMWxMsIfsQk60mt4iF9QZeKCV9lsedFJeNwoW01Migq5LTMjsK3uALxy
	a2Hq+j62vetVrHyAJAr/RfDt7X63iWivhe7jHnvQhzVlmM8c2ASpUqVT2UvxRG+w8tHSHlK+7DOsG
	3+9jgSy77G50Ed9C/EOpJYhPGFEi3Ln/gSOT/NdtdS9zB9YqfnW5jI+FqGCB/bJKDflf0k5OFOomU
	SqeaOGryl6XXaKUesNpaKPraxKBC/9+D0mJArgYPA6AHKx8QAp3MQbnZgmPHlL7ZSe+1fR7tOCacY
	rlb6FxGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wulYl-00000002369-18Zy;
	Fri, 14 Aug 2026 06:38:31 +0000
Date: Thu, 13 Aug 2026 23:38:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ricardo AlgRicSpain <algricspain@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org
Subject: Re: block/t10-pi.c: blk_integrity_interval() prot_iter misalignment
 with extended metadata
Message-ID: <an6359QSC05yHdZg@infradead.org>
References: <CAOeC6wqyPMoUohXg9v=BxHYWmPncR_243CC2P=bptAaPvQXp+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOeC6wqyPMoUohXg9v=BxHYWmPncR_243CC2P=bptAaPvQXp+Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 12, 2026 at 02:37:28PM +0200, Ricardo AlgRicSpain wrote:
> Hi,
> 
> blk_integrity_interval() (block/t10-pi.c:270-305) advances prot_iter
> inconsistently:
> 
> - fast path (t10-pi.c:282): advances metadata_size - pi_offset bytes
> - split-tuple path (t10-pi.c:285-287, 296-299): advances only
>   pi_tuple_size bytes via blk_integrity_copy_to_tuple/copy_from_tuple
> 
> When metadata_size - pi_offset > pi_tuple_size (e.g. NVMe extended
> metadata) and the tuple splits across bvec segments, prot_iter
> under-advances by the trailing opaque bytes, and the offset accumulates
> across subsequent intervals, breaking guard/data correspondence on
> verify and generate.
> 
> Suggested fix: after copy_to_tuple/copy_from_tuple, advance the
> remaining bytes:
> 
>     bvec_iter_advance(iter->bip->bip_vec, &iter->prot_iter,
>             iter->bi->metadata_size - iter->bi->pi_offset -
>             iter->bi->pi_tuple_size);
> 
> ...matching what blk_tuple_remap_end() already does (t10-pi.c:426-436).
> 
> Standalone C PoC reproducing the misalignment attached (poc.c).

Please send a patch with your proposed fix.  Wiring up your reproducer
in blktests would also be very helpful.

