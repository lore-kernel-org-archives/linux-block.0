Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B5274B2B
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369050; cv=none; b=Lixbz1nb1rmFMiBVlQToP5eZrwD30xq+lrX0pjziuULmzy1/5zOQqlMJNgmsKmAJqoWkWHIMJqvhfiAVbq1XGun7HyjrmeUCbr/JUgu2NWlwNNeDjmdvb3LFEQYD96YHYztJc8Dzsxkw5Jc+RRUEcC3RJ7jJ2YOMSxToUIBmOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369050; c=relaxed/simple;
	bh=ZeeJjv+/XZHhZgCp2FkIOniVysUKOSQDngzzrC/OCYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV2pmWS+T6mfyNoUGaANGwprm88iMSzUaHkTUBMyjXDveYSMLynrZRQ+qrwZkdtysGrck8yIHfBES2p8YsiV+U2B2evcgFF8CnVyj6elXyhlyYys81Gxed+rldIxZFIZDoh2eRU32+PFNVEOJjJLRLER+RteqAkPg7u41+8s+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnrL8f42; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnrL8f42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED54C4CEF5;
	Wed,  5 Nov 2025 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762369049;
	bh=ZeeJjv+/XZHhZgCp2FkIOniVysUKOSQDngzzrC/OCYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnrL8f42G/fnEQWL3w6/iZbTc8054qe+dvYuFsnoeltkJnEPj80EDgZTGdskfmqvd
	 SATIKe2gBJfG3zizTd9Z+OPBkvaCDX3rQwkRkStlBAASakwYV0iaXxahDHhzCBeiIO
	 PpjVzba3EK88t7EU9bAGKuH+iFLQEO5vvT7H9zx25Ijw/VSXzMpZjn0vj3oLAT7yQH
	 7eTmmSTRLD/2nrlhZ9XH4kJdoaLVXVgds/v+B3sYOJ4Jat8lDgamgV59un6KPdKY1s
	 CKltvFASX4t9G8oMVXrq//n9clPyJtm/on7eCU9LatrolUDDWkiNWcaTK7TcIE1ceV
	 j66lKNlpn32yQ==
Date: Wed, 5 Nov 2025 11:57:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, hans.holmberg@wdc.com
Subject: Re: [PATCH] null_blk: allow byte aligned memory offsets
Message-ID: <aQueFx0aVSih8fN8@kbusch-mbp>
References: <20251103172854.746263-1-kbusch@meta.com>
 <5d3b6e33-e22d-4388-910d-d58526c6fe6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d3b6e33-e22d-4388-910d-d58526c6fe6b@kernel.org>

On Tue, Nov 04, 2025 at 10:48:25AM +0900, Damien Le Moal wrote:
> >  		if (valid_len) {
> > -			err = copy_from_nullb(nullb, page, off,
> > -				sector, valid_len);
> > -			off += valid_len;
> > +			err = copy_from_nullb(nullb, p, pos, valid_len);
> 
> Not your fault, but if this fails, we will still do the nullb_fill_pattern()
> below which I do not think is correct... ? May be we should have:
> 
> 			if (err)
> 				return err;
> 
> here ? But not sure if we should still call flush_dcache_page() even on error
> though.

It does look odd. copy_from_nullb() only returns success though, so
maybe we just drop the return value entirely.

> > @@ -1276,25 +1275,26 @@ static blk_status_t null_handle_data_transfer(struct nullb_cmd *cmd,
> >  	struct nullb *nullb = cmd->nq->dev->nullb;
> >  	int err = 0;
> >  	unsigned int len;
> > -	sector_t sector = blk_rq_pos(rq);
> > -	unsigned int max_bytes = nr_sectors << SECTOR_SHIFT;
> > -	unsigned int transferred_bytes = 0;
> > +	loff_t pos = blk_rq_pos(rq) << SECTOR_SHIFT;
> > +	unsigned int nr_bytes = nr_sectors << SECTOR_SHIFT;
> 
> Overflow potential here ?

Should be okay: nr_sectors comes from blk_rq_sectors().

The same calculation already exist just above, I just changed the name.
Actually, I don't know why I changed it, so I'll leave it alone in the
next version.
