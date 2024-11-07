Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645D194ACA
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964060; cv=none; b=hgkQtr92V6aKq7CW9XB88FV68CPuUNG0dCxd7lGs7WHU49VA0stE9PCmkJht2pWVV2XszZlbyjB4Kq6c17j8nbknHNOjerfd0B8hOw8n6OLXFAP9dyVXagVEFsJYtX+LwFCkOV6qMGWr3TIh77+RAOnHd0rtsh8Dzr7srPYFP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964060; c=relaxed/simple;
	bh=DpgpWt9S84kaJbloqfXgqAYh3i/2DPTBLGseNGiZI7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLTtnoLVgeCbHN79uDQW6rjG/dZzwTT+GJkel9gnWLOm+W4BYGQ4Rf+DedT+Ex7i6+F8jSKUrZYdr7nyVXcfN7Cg6I4jZZEa3JuWnJtYeIRKqTGWCPS9qG8HFuFFVlZXkbdQ/9FF47lKjTt+XuREJcBB7nUWfhWf+HCD97vD3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2453B227A87; Thu,  7 Nov 2024 08:20:54 +0100 (CET)
Date: Thu, 7 Nov 2024 08:20:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: share more code for bio addition helpers
Message-ID: <20241107072053.GA4112@lst.de>
References: <20241105155235.460088-1-hch@lst.de> <20241105155235.460088-3-hch@lst.de> <CGME20241106101119epcas5p474ef1db0344f36c701535643af318f2a@epcas5p4.samsung.com> <20241106100338.35xxy2mcpp4u36xl@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106100338.35xxy2mcpp4u36xl@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 06, 2024 at 03:33:38PM +0530, Kundan Kumar wrote:
>> -int bio_add_page(struct bio *bio, struct page *page,
>> -		 unsigned int len, unsigned int offset)
>> +static int bio_do_add_page(struct bio *bio, struct page *page,
>> +		 unsigned int len, unsigned int offset, bool *same_page)
>
> As we are passing length within a folio, values will reach near UINT_MAX.
> It will be better to make len and offset as size_t, also to add a check like :
> if (len > UINT_MAX || offset > UINT_MAX)
> 		return 0;

Not sure what the point is.  IFF we get folio sizes overflowing an
unsigned int we'll have a massive problem as it will overflow the
bv_offset and bv_len fields.  So we'd need to address that first before
doing anything else.

>> {
>> -	bool same_page = false;
>
> nit: extra line got added

Yes, the previous code was missing the empty line after the variable
declaration, so this got fixed.

