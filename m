Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E942F12BE;
	Thu, 30 Oct 2025 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844722; cv=none; b=JPJCRRwAepZGFxBOYwG2nNKkiEOP8wX2tK0Q4iz66xdUQK1bqWTTX+VBq95kAQ2v0PHsCSqSHSmwPZ8WtaqcFgB8TIgSnUXRL8Uh0YfU8Wx198bNOcgL8VOJKzRb0YYNj9MZFgOo7jEs0Q/6MF/38uQBb238U0pFp2jNaI2p2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844722; c=relaxed/simple;
	bh=4HVD2mzJb0EwIPrMPU2udxa5rE8BBJ+0mOdfTDb+LAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo9qbwRWFEmJdGuRDsp+yTeKyg3sWEwysxytq1w2ZjF8S6JUowdcZg4M8dlVxXelHS7xT7dSOzg2+eMxnJjZ6DNdynZ5Zml+mJZs/T0HCmitL26FnTRuQsBjqy3lNTbqXZAoZbUavRSBNqfUT4rvAgcMdxuL2yR4BLu0u8Xx6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SECaQofQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SECaQofQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E5DC4CEF1;
	Thu, 30 Oct 2025 17:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761844722;
	bh=4HVD2mzJb0EwIPrMPU2udxa5rE8BBJ+0mOdfTDb+LAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SECaQofQKaoKSOW6/4lBdYBO2ruHPjDmdH7kRs2B6ZjbMgwxjc+H/7VKXjGlWLf20
	 dzDyjWImn+KUT5tNu0KZt8DfPBPbU5zU7B0kUioqiquLtVmGULZfFMqU8kCEhYwOS5
	 g9rbSsJGqvcF11qv3zzRwxlj/6w1xZdbU8m1kgFPkfZ4ufZXDu4axcj4gs14Hr+4TX
	 xPcqefiScTXkvzfnRuN0fRnrspf3JheENEIiqFmoS6oW5wJok8L3KGt8BwMYsdxYYj
	 VXN0Fd/35wiYBiEG9Ofb4bsk5wmA7IqbEzrw35b9sXfSuTii0oubuhi/H2obQv0z14
	 7o2sWuZyINyPg==
Date: Thu, 30 Oct 2025 10:17:04 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Llamas <cmllamas@google.com>, Jens Axboe <axboe@kernel.dk>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-crypto: use BLK_STS_INVAL for alignment errors
Message-ID: <20251030171704.GB1624@sol>
References: <20251030043919.2787231-1-cmllamas@google.com>
 <20251030060303.GA12820@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030060303.GA12820@lst.de>

On Thu, Oct 30, 2025 at 07:03:03AM +0100, Christoph Hellwig wrote:
> On Thu, Oct 30, 2025 at 04:39:18AM +0000, Carlos Llamas wrote:
> > Make __blk_crypto_bio_prep() propagate BLK_STS_INVAL when IO segments
> > fail the data unit alignment check.
> > 
> > This was flagged by an LTP test that expects EINVAL when performing an
> > O_DIRECT read with a misaligned buffer [1].
> > 
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Link: https://lore.kernel.org/all/aP-c5gPjrpsn0vJA@google.com/ [1]
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  block/blk-crypto.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> > index 4b1ad84d1b5a..3e7bf1974cbd 100644
> > --- a/block/blk-crypto.c
> > +++ b/block/blk-crypto.c
> > @@ -292,7 +292,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
> >  	}
> >  
> >  	if (!bio_crypt_check_alignment(bio)) {
> > -		bio->bi_status = BLK_STS_IOERR;
> > +		bio->bi_status = BLK_STS_INVAL;
> >  		goto fail;
> 
> Note that the dio_mem_align reporting in ext4 and f2fs also need to
> be updated to account for this.

I'm not sure what you mean.  They already take encryption into account
and report dio_mem_align=filesystem_block_size on encrypted files.

- Eric
