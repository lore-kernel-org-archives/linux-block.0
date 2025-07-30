Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB9296159
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885110; cv=none; b=OclyN42p/OmBA70n85H1S3WzGvMwxoNa2OJDhWNPc4uFZXcEYxG4FtrugRF0xZaqo3PEf9HuGhU2iJsmYJ6VmIa4X2t78fEFV6KBVupiQwqevHH57l6VO+R4bFqp5oxa9anDkMh1C64sSbz2vtm+s74Qhvr+WKlIZsBmkM8RDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885110; c=relaxed/simple;
	bh=5QG/cxwfN36EtLhLypaOb64DY9SBJPkXgy9O7I/pmU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0Xrf/QRO+o195KD/sheMKK0p3knNB9RIb75PCTBqKmhqDfwTHDb90FByouARzMGT9qvsSTcw261IdE9w9kep58hULCNtm9P4zgPc+rjXi5SO4+fIENrKDz3ERqFbm6uvRa3Qnw4kK89JUJ8d3ZNeCRS5GLudyGRpJQSLGPFRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUyG+PxC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUyG+PxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C90C4CEE3;
	Wed, 30 Jul 2025 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753885109;
	bh=5QG/cxwfN36EtLhLypaOb64DY9SBJPkXgy9O7I/pmU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUyG+PxCK7rXERFWp8Qs+h68JBAUb9gurZ52iqE26peUYzk4MKbt4owEdJqVsTFWv
	 OwIVtJ/HE0E9xzjUa5b9qRn7oGlQSbVebo9PFEUvetcMKc0iNE1iwdFBYZfhP3g/5d
	 W363sMgoRUevsds5lWlJXKghTgsqyQ75Kk0tLFT0unhOv4XN6mJnPpdxcnYT84DAwe
	 3MpeZdW/cRHdYN3m2Qlgu1xoLKwj0pfdufYx7fs5uZ13qogiH+3WGWvL2AyEaFayQb
	 yctoPwEfeGgJRXm0arZyw5zme7+E0FCoJIufJgpKtELogQcgEviVtM+UA1y+uqlvzT
	 XuXyyhJlsjyaQ==
Date: Wed, 30 Jul 2025 08:18:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	leonro@nvidia.com
Subject: Re: [PATCHv3 2/7] blk-mq-dma: provide the bio_vec list being iterated
Message-ID: <aIopsymJJaQ0AAZC@kbusch-mbp>
References: <20250729143442.2586575-1-kbusch@meta.com>
 <CGME20250729143610epcas5p12a897510ef6da6563d32c7a41ed21659@epcas5p1.samsung.com>
 <20250729143442.2586575-3-kbusch@meta.com>
 <8a4e7512-a997-4ff1-b465-2597bc6fa778@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4e7512-a997-4ff1-b465-2597bc6fa778@samsung.com>

On Wed, Jul 30, 2025 at 05:45:27PM +0530, Kanchan Joshi wrote:
> On 7/29/2025 8:04 PM, Keith Busch wrote:
> > @@ -151,6 +146,11 @@ bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
> >   	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
> >   	iter->status = BLK_STS_OK;
> >   
> > +	if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
> > +		iter->iter.bvec = &req->special_vec;
> 
> I am not certain yet, but thinking whether this is enough to handle 
> RQF_SPECIAL_PAYLOAD correctly.
> Maybe "req->special_vec.bv_len" also need to be included here to 
> initialize the iter.

Yeah, I think you're right. I had only tested 'discard' for the special
payload, and it appeared to be okay, but I suspect for the wrong
reasons. I'll fix it up.
