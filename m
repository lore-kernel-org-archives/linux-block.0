Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597311878
	for <linux-block@vger.kernel.org>; Sat, 29 Jun 2024 05:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719637357; cv=none; b=k67/Qsw3oLvBTEjqPMUK5kMCCNb/iCcX4yppZRspvJ2+GpleQVaDq3HX4HDZzcRRCsPiDxBfK1vRwEbB85zviOBN9h+KeqJSE2FyY3R6lauRWf6uIWDuLhDupG9qwb55tj6mq7KPCdXPra5HNiqnzc2Suc00CVXqkKbp+vwuILk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719637357; c=relaxed/simple;
	bh=PB3tVZsvIqdQmcApQP6RcAI348crC878qw9JUVXtdMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYlnnUTo95qOs5K7I7JWckEtGBNtK8sWA5HRc/okOiZsP+qinUVu9I8FjLMCp0tgfqNxcWXMxeeRNn2XcJbPN+A0d+TLd4e7selhatavDOefDyc1y2nV8fBaqwipEr8nxnCKFPcS1Tj2HwmRswFDdZDqm86tBSCAjud/BB5QL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6968968BEB; Sat, 29 Jun 2024 07:02:30 +0200 (CEST)
Date: Sat, 29 Jun 2024 07:02:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: don't free submitter owned integrity
 payload on I/O completion
Message-ID: <20240629050229.GA14993@lst.de>
References: <20240628132736.668184-1-hch@lst.de> <CGME20240628132757epcas5p1760f53ce802e725626a37f9f1e4d8f2c@epcas5p1.samsung.com> <20240628132736.668184-4-hch@lst.de> <43ba3da2-8645-a255-0db8-c0352eb9d3d7@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ba3da2-8645-a255-0db8-c0352eb9d3d7@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 28, 2024 at 09:46:21PM +0530, Kanchan Joshi wrote:
> >   static inline bool bio_integrity_endio(struct bio *bio)
> >   {
> > -	if (bio_integrity(bio))
> > +	struct bio_integrity_payload *bip = bio_integrity(bio);
> > +
> > +	if (bip && (bip->bip_flags & BIP_BLOCK_INTEGRITY))
> >   		return __bio_integrity_endio(bio);
> 
> Seems we will need similar BIP_BLOCK_INTEGRITY check inside bio_uninit 
> too. At line 221 in below snippet [1].
> As that also frees integrity by calling bio_integrity_free. Earlier that 
> free was skipped due to BIP_INTEGRITY_USER flag. Now that flag has gone, 
> integrity will get freed and after that control may go back to 
> nvme-passthrough where it will try to unmap (and potentially copy back) 
> integrity.

bio_integrity_free clears the REQ_INTEGRITY flag and the bi_integrity
pointer, and bio_uninit checks for those using bio_integrity() first.
The check is alredy required for the existing code and that doesn't
change.

> Seems this patch is with "for-6.11/block".
> But with "for-next" you will see more places where this flag has been 
> used. And there will be conflicts because we have this patch there [1]. 
> Parts of this patch need changes to work with it. I can look more and 
> test next week.

Oh, the patch actually does part of what this one does, _and_ I've
reviewed it.  Jens, maybe just skip the patch we are replying to
(my one) for now, and I'll resend it for the next merge window
as the conflicts vs the 6.10 tree would be too annoying.

