Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D9261591
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559925; cv=none; b=pVHAFJM9DzWmql/vFxHxRBpWFiyjdoEY8sRiijlRQrXj2RyUL8j9wUbeySEb/KyUWXeQ0PHqXWTdhNT1DJaNCgnBvG+iU+aGL4xwyzUUuWeFMBD5LJCgUjkeObwnBOGKZuqi8B5fI/fjnVgxPB7IkZb7z9UICwZ/6lLNBZALdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559925; c=relaxed/simple;
	bh=ZeCqtmCgdwGhc95a1Y3E9AZHQAJDrN53w+Mqsyrheq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTprbEm3FmlV/grQyT/fc5NT3lMlRSRCBoaa7UcasQAxLThRDHPh1+pnjuN3OyWcctbrdkVcRZBSgVzpmCwUOVlT14fb9Bq/AFgr9KwzFzu7dVVn3jyuT3OZ2r7b4e8FFT2wzY2tukMoeFuFDnm5gMYLPnP50lsFY7kPB+ebx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqUlpKla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqUlpKla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBAEC4CEE3;
	Tue, 15 Jul 2025 06:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752559924;
	bh=ZeCqtmCgdwGhc95a1Y3E9AZHQAJDrN53w+Mqsyrheq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqUlpKlaxA288gL2lfN3NjmDw/M0MIeNcUHa2bRWth0IJFvFiWBtblqkqPR9CwzCV
	 1VXC4/Em16GxsRh+ITXVWPPy+t5Acwq21DBDrxuukHJFcznJBnyVcC5mWnUU33H1og
	 gtdQ3aOdpkIx9JDx5B8XHeXW19WWKSa3f5FJaJKbDAe3EFx2jNa/pgxG6S+h5A5BV5
	 B+Ktux3OB+jlZ5RHudLRRLyXnTWPkizJvYgBnZDD+MYzlkAcaxWIK0JkG2j/EbRUsc
	 QzG6pBpIWgA1cV5Qx4NTl6dyeQt64enXGVDYWukm5gGinx+dBWCkF0gKuQ9oERcnOG
	 FZi95Q3O49cow==
Date: Mon, 14 Jul 2025 23:11:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] block: Rework splitting of encrypted bios
Message-ID: <20250715061117.GA595531@sol>
References: <20250711171853.68596-1-bvanassche@acm.org>
 <20250711171853.68596-3-bvanassche@acm.org>
 <20250715021810.GA426229@google.com>
 <20250715053735.GA18120@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715053735.GA18120@lst.de>

On Tue, Jul 15, 2025 at 07:37:35AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 15, 2025 at 02:18:10AM +0000, Eric Biggers wrote:
> > On Fri, Jul 11, 2025 at 10:18:52AM -0700, Bart Van Assche wrote:
> > > @@ -124,9 +125,13 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
> > >  		trace_block_split(split, bio->bi_iter.bi_sector);
> > >  		WARN_ON_ONCE(bio_zone_write_plugging(bio));
> > >  		submit_bio_noacct(bio);
> > > -		return split;
> > > +
> > > +		bio = split;
> > >  	}
> > >  
> > > +	if (unlikely(!blk_crypto_bio_prep(&bio)))
> > > +		return NULL;
> > 
> > Is this reached for every bio for every block device?
> 
> No.
> 
> > If not, then this
> > patch causes data to sometimes be left unencrypted when the submitter of
> > the bio provided an encryption context, which isn't okay.
> 
> I agree, but I think the root problem is the blind assumption that
> everything can encrypt.  That is a huge mistake and really limits the
> block layer.  I think we need to fix that first and tell the upper
> layers what can encrypt, including using the fallback where we think
> it is suitable.

I've actually been thinking of going in the other direction: dropping
the support for fs-layer file contents encryption from ext4 and f2fs,
and instead just relying on blk-crypto.  That would simplify ext4 and
f2fs quite a bit, as they'd then have just one file contents encryption
code path to support.  Also, blk-crypto "just works" with large folios,
whereas the fs-layer code doesn't support large folios yet.

But that will only work if blk-crypto-fallback continues to support all
block devices.

So, effectively you are advocating for keeping the fs-layer file
contents encryption code in ext4 and f2fs forever?

- Eric
