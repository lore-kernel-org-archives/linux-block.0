Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469EE256C6D
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557860; cv=none; b=ki9bSCK/QRd4KPk33i2eBzyBmwRwtqPSxjSt8q+BghFvUM1Kp2ASUM3n5flRogVw0K4TCuVZSGZ65ik3Pl93F/ERauqmfOq6J8ggfgBA9ZOXCHfUX+w6lZPFpl4WBCh03iW1QJi0xnFX6huf/dztrvj5wbSecUFqAZJueiy8H/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557860; c=relaxed/simple;
	bh=dq6YwyrHU2wjltakeZxIoT3O0fEXotwJW4Tc7KBdkkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRi5MDQn+xyQu9Av+7k37RRjzeeKXVSmeVyr6ClYtvBMLy2Mcoe+gA5x3OZrJm01EFSC0184Epu1dcHis/vvLJaImk2Hm+R2iW8CfVHIZeMGtRl+Clm5ge6r39MJMXmNT2QrZzFQyYNybH63l46h4m+duWuPRqo75rNSBa9txKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 739F6227AAE; Tue, 15 Jul 2025 07:37:35 +0200 (CEST)
Date: Tue, 15 Jul 2025 07:37:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/2] block: Rework splitting of encrypted bios
Message-ID: <20250715053735.GA18120@lst.de>
References: <20250711171853.68596-1-bvanassche@acm.org> <20250711171853.68596-3-bvanassche@acm.org> <20250715021810.GA426229@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715021810.GA426229@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 15, 2025 at 02:18:10AM +0000, Eric Biggers wrote:
> On Fri, Jul 11, 2025 at 10:18:52AM -0700, Bart Van Assche wrote:
> > @@ -124,9 +125,13 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
> >  		trace_block_split(split, bio->bi_iter.bi_sector);
> >  		WARN_ON_ONCE(bio_zone_write_plugging(bio));
> >  		submit_bio_noacct(bio);
> > -		return split;
> > +
> > +		bio = split;
> >  	}
> >  
> > +	if (unlikely(!blk_crypto_bio_prep(&bio)))
> > +		return NULL;
> 
> Is this reached for every bio for every block device?

No.

> If not, then this
> patch causes data to sometimes be left unencrypted when the submitter of
> the bio provided an encryption context, which isn't okay.

I agree, but I think the root problem is the blind assumption that
everything can encrypt.  That is a huge mistake and really limits the
block layer.  I think we need to fix that first and tell the upper
layers what can encrypt, including using the fallback where we think
it is suitable.

