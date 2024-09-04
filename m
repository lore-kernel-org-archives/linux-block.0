Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33626AED
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461274; cv=none; b=XVHvAVjhPM+R7EC1VMtF8VtpOAapEfmpFXuwyMRGR4DrzUWabVTEY0XSBC0grgCdWjNvvzDuYBdTTtemrx4PI0flE27ZVOyvZKQtq92e5fkql4PMPITg7GiiLabczs2Cf3TDS/5GAswhHA1Ri3DFgyFprtU299kfsxaSe+Rrha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461274; c=relaxed/simple;
	bh=yE98xFtsc3hjjGmDDq6gNwXjcN3RiEAtz9k/dCUgp2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHwJsnzZCQvvsIdcESTx0OEMtmKAp0UDaPnLId9dvVRjGphb0YKYsuwqrUfoq/acbb3WWGgqWHisT8M4bjOK5EYYRYdZDOSKQtP0PkuMawYu6n2Ad7GmfCqsmq+fqk3EsC+hIbbpZp9RbTJAbBTy/3+V42MHAEdncaftW4g79hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1SBXJ86; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1SBXJ86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC383C4CEC2;
	Wed,  4 Sep 2024 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725461274;
	bh=yE98xFtsc3hjjGmDDq6gNwXjcN3RiEAtz9k/dCUgp2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1SBXJ86TFbXhUHtdZNAe3/DwkdJzzp19mFxvKaO2hjl4k28lPX6oe56gJcncR41T
	 wnXrJealEDoO++Q/sdUkjlLCuNZ227QiVAsVoGdwWrGcRsG2G10qyRppS1ThKSv93T
	 ZRTLgqBiP/zckYGiBe9VDRnicTUelCqK0QY7WSQ5LFLRejeKiKYuJuOxI94LkMBMaK
	 kwMiAnu9lamYw3SQXOr0ppaDIEd43ComqMNJezerSxYmt8s7XazsLOCxMStfq5wSop
	 HJ7+B1QR32QhKHZWddiNqudp+dH8yRwWIFljSvA57XF4LJWePiizD8lJYTenzxWWf6
	 m/qipqRyVqJQg==
Date: Wed, 4 Sep 2024 08:47:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCHv2] blk-mq: set the nr_integrity_segments from bio
Message-ID: <ZthzF5Go69cdzeoM@kbusch-mbp>
References: <20240903191325.3642403-1-kbusch@meta.com>
 <Ztfjb8UlOfHYtMTT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztfjb8UlOfHYtMTT@infradead.org>

On Tue, Sep 03, 2024 at 09:34:55PM -0700, Christoph Hellwig wrote:
> On Tue, Sep 03, 2024 at 12:13:25PM -0700, Keith Busch wrote:
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2546,6 +2546,10 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
> >  	rq->__sector = bio->bi_iter.bi_sector;
> >  	rq->write_hint = bio->bi_write_hint;
> >  	blk_rq_bio_prep(rq, bio, nr_segs);
> > +#if defined(CONFIG_BLK_DEV_INTEGRITY)
> > +	if (bio->bi_opf & REQ_INTEGRITY)
> > +		rq->nr_integrity_segments = blk_rq_count_integrity_sg(rq->q, bio);
> 
> Hmm.  The current model is that drivers are supposed to
> clal this, which they should stop doing now that the block layer
> maintains this count.  So I think this needs a bit more work, after
> which blk_rq_count_integrity_sg is also unexported, nad preferably
> also has a name that drops the incorrect _sg.

Sure, I have a larger patch set in the works doing pretty much that.
I wanted the request's existing field to be accurate first because
inaccurate values break merging. But I can post the rest of series if
you prefer to see drivers rely on the existing field instead of
recounting the segments.
