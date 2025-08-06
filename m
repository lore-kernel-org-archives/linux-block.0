Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2D2918EB
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493468; cv=none; b=mI8TwWsSDaWUt1GOqz9hkZl2okM8Fus1wrfyn7nTGYI6Bc5T5p3NrxkYdytbUXa1aXaoryYmumXi1jlAJToyy+A3xnU4sVWJuBfW+llKfWoJh/LEyCsYXf4F476yv1XX0azElupCh4ym9IWdzxkZgu/tyF/8ZMQYp3dEFl7eOE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493468; c=relaxed/simple;
	bh=055cYutF//gSOGKlpgY1emhdHH+SAYQKA84BfsmOBPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/g5/KozmCHe/0duxdy0cyU3SosLPdB/uxlwR21ikhRYU7DAZGDLswisJzqAsClKqnvIDmh97IBqy5DpP6WFaPPsr93my353CM9zYNODtenouhoj8rg17I3sMHlvrnnlt7GOs7OrrmrlxIxncXYAfXrcY0LaPLfzsUUhbECGjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEAEAklZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEAEAklZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E85AC4CEEB;
	Wed,  6 Aug 2025 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754493466;
	bh=055cYutF//gSOGKlpgY1emhdHH+SAYQKA84BfsmOBPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEAEAklZdtIb3rZXD2+57NUU+8kvotAAcckeFsWXkeUrCatVtQwFyvNFc4DNVHrLp
	 iTypXJ7zP5kgRcCbWf91DbgQRJ2/MGKj5A/Y2BvYkpCv+uGyakjDCTTGPrElMEjuiu
	 1Jz1ZsqavRRN6DiqPFW413WlQ++RfcLTeRX0owUsOBs6beP0hwx2SlHrQ0aMinttXr
	 gzyoqYwc9i5Z7vsDDt/FRvVc2Zl9Mr45S+RDO+wIOwxW4KbTCyxQO3AVbUZJ/KOClH
	 eU6iaeEvLU/oVcS3mMit6dgMmHDbpf1WFXj2PVkMGa8zietIG1x9FPdazFU0U+dbgD
	 yMBv2l7Fv2gow==
Date: Wed, 6 Aug 2025 09:17:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aJNyGArqwjujoouU@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <aJKLGy9UkVjJTIIQ@kbusch-mbp>
 <20250806145333.GA20102@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806145333.GA20102@lst.de>

On Wed, Aug 06, 2025 at 04:53:34PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 05, 2025 at 04:52:11PM -0600, Keith Busch wrote:
> > On Tue, Aug 05, 2025 at 12:56:07PM -0700, Keith Busch wrote:
> > > +	bv = next->bio->bi_io_vec[0];
> > > +	bvprv = req->biotail->bi_io_vec[req->biotail->bi_vcnt - 1];
> > 
> > Hm, commit 7bcd79ac50d9d8 suggests I missed something obvious about not
> > being allowed to use 'bi_vcnt - 1' for the tail bvec of the previous
> > bio. I guess it's some stacking thing.
> 
> It is bio cloning and splitting.  bi_io_vec is the original payload added
> to a bio, and directly accessing it is only allowed for the submitter,
> i.e. usually the file system.  The I/O stack always need to go through
> the bio_iter to deal with split/cloned/truncated/partially completed and
> resubmitted bios.

Yeah, I knew about the splitting, but I am only using this for merging,
and bio's split off the front can't merge, so thought I was okay.

But the cloning, yes, I messed that up. v2 is sent with a fix for it.
Sorry for the rapid fire versions; I realized you were travelling, so I
didn't expect more feedback on v1. But thank you for finding some time
to review anyway.
