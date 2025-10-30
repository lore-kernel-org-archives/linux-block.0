Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1A325715
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 04:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761800070; cv=none; b=ANsZhiGqHXmoabdggE+3X4Kwmth/H9yEmm1LE0M8GXF7MbZhjInilpAlTmZAG9aysIuyfc2mVBEzAeof8+xiw6Jms4JSjs1H2Bt/7aX9klpNYEtkxiX80/WTRapzwmLWRmYe0d750hzcupX8OmAQkSvgSL5FvaItC20kvEtmzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761800070; c=relaxed/simple;
	bh=VxZENKZkB6Z+YZgyLavSwJWdOW+IEJ+F18A1MxXcN5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsG02ZNYVzVghmq6GIjnTjBhXH7e1Gp7eHvxDoCLnYZBO78Z6/R8yddYvTgYDvmUO23oFX6clLvE0J8F8gBiqvhe40SxmprVy28fYCfubur8qxrXrUwsi3sIoWIKgliNtPEVtrRZndNReWPMTZCWmPp5pOLxm5N8ejGuVGOvWnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tlgmo2/W; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tlgmo2/W"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27eeafd4882so93075ad.0
        for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 21:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761800068; x=1762404868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ej/auf+/EmPMyY6GqjKBQhQwJpW0Nqnj+K+f6BktHE0=;
        b=Tlgmo2/Wm9hutAIeSz4vU5YsTZNTyN3xDraA+m7VfEoqgfH3F38q2pD3IMe1HiaPLq
         kVM2q4++zCzHD4I1OHRRuKfZ8dlPMdqipeVzk9hyMMsv8n+VZ5dkwA32zp0l4+nMS50i
         laKQUIrUHXeqZkODCGEF7moR5hp4b2enn2mNyoLBRuSIikghXk9mbVfpcyaJHWYCX0BH
         Ru/b0BWyOmMOCVQe1GlArVfGajNy0aYi5WrIv//RyjOYClkZ1cdxD+NI10uTncx32WMY
         pCdf0105ls9dKoT6X0llI1lTvCzo9LTHh2d0QkDf5um89IHEfdFp0UXQMhjoyVHmzavT
         klFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761800068; x=1762404868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej/auf+/EmPMyY6GqjKBQhQwJpW0Nqnj+K+f6BktHE0=;
        b=podwkyL7NFAzxsSrCtfUx1z0bPTY8CwdtQcdq26GNSYj5aHFYo7hhx+whmaP49awCE
         dh5Z1mF3VaUEECnB7BI0/YwmzrMWckWgtouhA6UEUKs5juFjbq5dX/87JcnZmyLhodob
         91W9fmWvjYzi6lpfgxL3g3cSZTmrod7hRRyfVW8RGdSkFTA5cCAM/tAWNicRcZrkyZnD
         qAkiUZMATJiUv9WWrJNjXVSaTA9yvaw2cwas/weTij0mupN/Jc7abK5hqxjZc9B9jW1u
         AdA74NReZp3p5zTEu1o2fjZnHtpPaYP0/7XYlvFHMdfj3/MlwKQLP2UvOQ4FcTHkHeFZ
         7JnA==
X-Forwarded-Encrypted: i=1; AJvYcCXpxmEJtZwbpoRn6w+VqfRMJCO9or87ia35jUfNDikQ55AQH/RICsyvKLXLWf7uSmfvCGcnkl78wM9mMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkM527vsWLXZcbOEeuoARouVu/1SHhuLG0KPBrg/Y4pkr1IbfX
	8/eqqvBrmxgbzGm+mJiVKxbdOy8tFF+p2X/xrxMhGN+ssfss40nQIXKWoQ3EhGOlng==
X-Gm-Gg: ASbGncsKNdvjKUhPZANyMeqjQJOZpNxbu/2vPNRK/pDFsSZ84ToQAHlh8+Iy4EORBmt
	F+oALQXgVFnuRt/mewcDTVJWVniyltv5DvbjyjXlBz5oH7mAOxdrZlS9uZ0/NSYVKN0E+HbvvWg
	fZIml9Em03wPhX4hE3QHxvGkqIM4tPGEXH5FkEbpkRnpc8e9JB6HmfALpmYRzYQW5BIzi+gHLZ8
	HkP7ra5JQSQJ56PSDOFHfieD3xj7xkz7aPl9e6npnWTm9dhYu6+U1XXmvSle19IuhbWKdvYhNlz
	qaMZ8oFiYBGeL+JMpdzITas3RDW4o23XYNRcKQK3MVWvfakAM8sunu7OfSneLmIc1OS2OyKB+Q4
	63kUc7SzAz5lPAMekQ+oXABExEdfJeEuD7IZawbnpudEcYo9osz88TBh3AaDH0xEaSXvaWE6mcK
	AZwIl2LoG5vtemXWMmT5C5bmnCLWg+HhjOFJqCXdPOYtVVUuEQVQVysTzVKEEaWD/ySenyGDOTJ
	0g6Q007uqcIITb0dZTqRTqzHdcANFf588Q=
X-Google-Smtp-Source: AGHT+IF1aIVtDtqyINIaT4VsEA6+urTc/5YTHi0A6ZrXvPoa8CEW59KPabjqx3mO+bDkKlfEESX4Bg==
X-Received: by 2002:a17:903:22c4:b0:290:d7fd:6297 with SMTP id d9443c01a7336-294ee1aad86mr3315295ad.2.1761800067395;
        Wed, 29 Oct 2025 21:54:27 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm170936075ad.48.2025.10.29.21.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:54:26 -0700 (PDT)
Date: Thu, 30 Oct 2025 04:54:21 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <aQLvfayGPi1YezHV@google.com>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
 <aQFIGaA5M4kDrTlw@google.com>
 <20251028225648.GA1639650@google.com>
 <20251028230350.GB1639650@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028230350.GB1639650@google.com>

On Tue, Oct 28, 2025 at 11:03:50PM +0000, Eric Biggers wrote:
> On Tue, Oct 28, 2025 at 10:56:48PM +0000, Eric Biggers wrote:
> > On Tue, Oct 28, 2025 at 10:47:53PM +0000, Carlos Llamas wrote:
> > > Ok, I did a bit more digging. I'm using f2fs but the problem in this
> > > case is the blk_crypto layer. The OP_READ request goes through
> > > submit_bio() which then calls blk_crypto_bio_prep() and if the bio has
> > > crypto context then it checks for bio_crypt_check_alignment().
> > > 
> > > This is where the LTP tests fails the alignment. However, the propagated
> > > error goes through "bio->bi_status = BLK_STS_IOERR" which in bio_endio()
> > > get translates to EIO due to blk_status_to_errno().
> > > 
> > > I've verified this restores the original behavior matching the LTP test,
> > > so I'll write up a patch and send it a bit later.
> > > 
> > > diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> > > index 1336cbf5e3bd..a417843e7e4a 100644
> > > --- a/block/blk-crypto.c
> > > +++ b/block/blk-crypto.c
> > > @@ -293,7 +293,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
> > >  	}
> > >  
> > >  	if (!bio_crypt_check_alignment(bio)) {
> > > -		bio->bi_status = BLK_STS_IOERR;
> > > +		bio->bi_status = BLK_STS_INVAL;
> > >  		goto fail;
> > >  	}
> > 
> > That change looks fine, but I'm wondering how this case was reached in
> > the first place.  Upper layers aren't supposed to be submitting
> > misaligned bios like this.  For example, ext4 and f2fs require
> > filesystem logical block size alignment for direct I/O on encrypted
> > files.  They check for this early, before getting to the point of
> > submitting a bio, and fall back to buffered I/O if needed.
> 
> I suppose it's this code in f2fs_should_use_dio():
> 
> 	/*
> 	 * Direct I/O not aligned to the disk's logical_block_size will be
> 	 * attempted, but will fail with -EINVAL.
> 	 *
> 	 * f2fs additionally requires that direct I/O be aligned to the
> 	 * filesystem block size, which is often a stricter requirement.
> 	 * However, f2fs traditionally falls back to buffered I/O on requests
> 	 * that are logical_block_size-aligned but not fs-block aligned.
> 	 *
> 	 * The below logic implements this behavior.
> 	 */
> 	align = iocb->ki_pos | iov_iter_alignment(iter);
> 	if (!IS_ALIGNED(align, i_blocksize(inode)) &&
> 	    IS_ALIGNED(align, bdev_logical_block_size(inode->i_sb->s_bdev)))
> 		return false;
> 
> So it relies on the alignment check in iomap in the case where the
> request is neither logical_block_size nor filesystem_block_size aligned.
> 
> f2fs_should_use_dio() probably should just handle that case explicitly.
> 
> But making __blk_crypto_bio_prep() use a better error code sounds good
> too.

I realize this is a bit of a band-aid but here is the patch to fail the
bad alignment with EINVAL:
https://lore.kernel.org/all/20251030043919.2787231-1-cmllamas@google.com/

As for the more achitectural fix suggested by Christoph, I'm absolutely
out of my depth so I can't comment on that.

Cheers,
--
Carlos Llamas
