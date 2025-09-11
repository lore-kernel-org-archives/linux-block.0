Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A98256C71
	for <linux-block@vger.kernel.org>; Thu, 11 Sep 2025 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571040; cv=none; b=XcmbuYDXyRa5viB1/c0/vrHsv1uCUm23o+Sa9FCQkgv4JVKSWQjj56L18aBY+80XF4r0KkDPBCIaKc7vK/G6rfZVMDYSfGQUgtQd5oqtYFswarrsW5cPjnWGc5rVn9KlDUd8DjVr3Shd1OD62iYDD38VlOtD3gCeQaQjWWkahjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571040; c=relaxed/simple;
	bh=qKMxI+LReNJMw5MaYezfP2ksKiFjhj/NGXtv3bZ+jYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bR3+pGwyQMOJUJoeex4TZLqVfWGq95J9Y/gJkZXPWQujkhjWy7Iv89w61uqrwMGdZEuBgTFNCyYkLZTJvvXG/sVSdgVPTzNc2yOon2JUKXQz8mIt0+Y6cK238ZvXGeaaZ/mAJ90/3I02D5ibjZtH14rwdTWB+e/l7ijIv4GVdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DCBA867373; Thu, 11 Sep 2025 08:10:33 +0200 (CEST)
Date: Thu, 11 Sep 2025 08:10:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: add a bio_init_inline helper
Message-ID: <20250911061033.GB12964@lst.de>
References: <20250908105653.4079264-1-hch@lst.de> <20250908105653.4079264-2-hch@lst.de> <b4b28858-0d55-4d98-99c8-d872e902515e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4b28858-0d55-4d98-99c8-d872e902515e@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 09, 2025 at 09:43:55AM +0100, John Garry wrote:
>> +static inline void bio_init_inline(struct bio *bio, struct block_device *bdev,
>> +	      unsigned short max_vecs, blk_opf_t opf)
>> +{
>
> I suppose that a WARN_ON(max_vecs > BIO_MAX_INLINE_VECS) could be added, 
> but I don't think that we generally protect against such self-inflicted 
> programming errors.

It's not needed because there isn't actually any such limit.
BIO_MAX_INLINE_VECS is misnamed and misguided.  Various places in the
block layer require non-passthrough bios to not have more vectors than
BIO_MAX_VECS, while BIO_MAX_INLINE_VECS is a random upper bound for
passthrough I/O without a deeper meaning.

