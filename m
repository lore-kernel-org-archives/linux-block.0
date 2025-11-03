Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F731DB12C
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177542; cv=none; b=qlwh7dHmr3UmsW7GEeNoH8zw5PH0OiL0mWSvRC0ciBfSrUHus64LXl0C7NkBhTPVDUEwgWE+hs87PI91pQaJkW2NHqKIEwC4eH+zNPSUKK8sFYetMpLUfFEm0bWQgaqfdrp99462I1alvw+4VjHTXxvrLBLV7Fkfpe5+gJFJrJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177542; c=relaxed/simple;
	bh=+ri+Hcw5jTi5qPt2S2YPmpHPZtdrgVdxRDCvDcwAKIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml0+UpwVXdBZADl5PPhceA1eZgFbhXe7Knnik+5ddHTDRjOLZN9MbBqnGSfzrSOs1RwSBt3Wo2H4rhrTJad1cafNn4lk3hBEYRtfiQCKnaAz2l84TJy8HocPD3gqhY8tvsBP8PEuJixtS2t4vAvPnd0M3yJkLG83UY/tTejqkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BEE1F227AAD; Mon,  3 Nov 2025 14:45:34 +0100 (CET)
Date: Mon, 3 Nov 2025 14:45:33 +0100
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: make bio auto-integrity deadlock safe
Message-ID: <20251103134533.GA23818@lst.de>
References: <20251103101653.2083310-1-hch@lst.de> <20251103101653.2083310-3-hch@lst.de> <bd4e2d68-bece-442a-8a00-4fe2d5e14645@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd4e2d68-bece-442a-8a00-4fe2d5e14645@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 03, 2025 at 01:40:10PM +0000, Johannes Thumshirn wrote:
> On 11/3/25 11:18 AM, Christoph Hellwig wrote:
> > +void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer)
> > +{
> > +	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> > +	struct bio_integrity_payload *bip = bio_integrity(bio);
> > +	unsigned int len = bio_integrity_bytes(bi, bio_sectors(bio));
> > +	gfp_t gfp = GFP_NOIO | (zero_buffer ? __GFP_ZERO : 0);
> > +	void *buf;
> > +
> > +	buf = kmalloc(len, (gfp & ~__GFP_DIRECT_RECLAIM) |
> > +			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN);
> 
> 
> Why can't we clear the flags when assigning gfp, or at least outside of 
> kmalloc()s parameter list?

We could, but what's the point?

> > +++ b/include/linux/bio-integrity.h
> > @@ -14,6 +14,8 @@ enum bip_flags {
> >   	BIP_CHECK_REFTAG	= 1 << 6, /* reftag check */
> >   	BIP_CHECK_APPTAG	= 1 << 7, /* apptag check */
> >   	BIP_P2P_DMA		= 1 << 8, /* using P2P address */
> > +
> > +	BIP_MEMPOOL		= 1 << 15, /* buffer backed by mempool */
> >   };
> >   
> 
> Any specific reason for the hole?

Because it's really just an internal flag.  (So is BIP_P2P_DMA, but
that should go away this merge window).

