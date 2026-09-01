Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6747FAF9
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265133; cv=pass; b=p3YcsonZtOIUxLzupHHNqkH8oIWAkYZi9D4QxdHtxei43RPG3w8Z4wbV0QGfkV5DuMjAxrcVGGeEdKETJ/OzEo7qqU9CcjhMgCy6a7xdeo9VEOlNcwTq/2d5eePRgOr4PYSyLIL+dMn2IG2Z1sygNFSrK/SrSU8x6hOTO6jXcl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265133; c=relaxed/simple;
	bh=Es/cIjPUD1zzwXufbvKj4+Elkno+b+6GyubYx/khWOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrC8HxDVoGRx4rfcMszoYCd9KtWI+mqZ5KrezbBzD3QrJH3D3/3FyK3qmjt/LpN+w5Gc/jyosOqRGQfUUGCG1AJQS0gKiq6vZ0VjxDQVAugRI7zNSXSeVmy2EbLJULhC7FAI57ix/11Cclbt6MllXJgeK32py7Wm6+d5aZ+gnhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cu+sxr8M; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cu+sxr8M"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b0dbfbf7bso33726865e9.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 05:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788265130; cv=none;
        d=google.com; s=arc-20260327;
        b=d3MWhaE7I0kv/ERyLCfS5Vj2ueH0nAfDawUxNn053lrdURU0WOe//kzEyM2KmKYMsV
         805gp1cAaVJovBGIwEiEuDRqVoSBc/5Eb0UHW7fLmc0g8bn/1X71e/Zmiq+2gRFIydUS
         wfoxWTbfUwquBeiRzkXrPlPHZqMNWDb4xssGPkvq5YhsS3fTfNztcNkbBjSGv3oAfW8R
         Uprx70z8pcJ/inSar3uKQDxajNnL9ttsx0P/UA3IqcwRoVetvNKSapVx1+Y+2FldwG1m
         HjyQYjqSizYxCptXpt6jQq3JTh5ypQ/9UT2wJcx6mufxRWsBW2O4XL96Ib+ig4YJxKW6
         XIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UvAi+mvqn+hfoITwGygPm/YRj+YQGu0S7A55rivu94M=;
        fh=pHHRVpHiK4ASEYdp20P7LuUcQqzybOPyt5r5jJYHVeI=;
        b=GjVGun13Nt/dl1K+cegQvW3MFrher+cidZCXiC25ZlOo0jargMrtY93hib1qsk8WHC
         eK85Q/qmk+OQZtSJAhL7Az8zA6XVI1Ytxzvhw/d9CSWL4yheiabYubIFlnH4z7zmJJta
         JovxqL3oEupmCIl5PMmDnv4Cm6S3l9ZRPAGPedOEM00jZPiFYHV+8tdqMTmTR0KawL+H
         pPNj4//2sKYKLQwY2lLjd/Sq+Y7zj3eOIc32rMnUl9XWfbu0JXzBTN5QmZfS4Z7bMWWQ
         UE/6MxqCtYqxvpqk7ikW/05PjdGEzLZxGTkfKqE5JSqIStn+Wg7YAZaWCsbUvR7Q2Y6t
         E1Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788265130; x=1788869930; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UvAi+mvqn+hfoITwGygPm/YRj+YQGu0S7A55rivu94M=;
        b=cu+sxr8MK5sNC/uVsEzuQ15QB5fgL926vBMF3dm9MLyD0FjEmRuoRHqdEw9BqHWhye
         TBa1ExtRh8OOER2i74w5OILPqw3+MU4Kneja2YTshuGPesAeBzKlKZEA+4NbY/5uo52s
         RDr+jyzZQQCG6tHuikKqwWYYiwbpYYhMR6EbPHdhaZQl39yJH+6Ucx/k92aI0waI5QSl
         O6fMckPyqyodn5Dc8lzaFZj2I8G38EoFHu45F90amE/RCLIGCffXnCpC2dryp2Qwhlb4
         V10VFurB6/JJp3Fd+6q9Mu32cH5NG19cGUnMpuMfignb3pTXtybWNn1dMXKfukPyXipz
         0y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265130; x=1788869930;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UvAi+mvqn+hfoITwGygPm/YRj+YQGu0S7A55rivu94M=;
        b=lSkHGuEU+pQRmnQ/QExzG6mof2fl87rLi9q8WsUe/jteMZ/TelXkOiH5MOLenDXu00
         DiwFMJO+WOo3u5fg0NDlpXTBQavS4pfry+RBaoy7g3pLEKmg+LDOakBIEvE0c8X+nxPe
         YZZRiVgktVHm+/Qcrgi8ZDdbcUzGwBpsaSH/wMCALPHJ/iim0SFY4O5en0zaaNXSMsND
         bfexCVSogXOai0vUrauGf8ZG56MdjCKKtHg6Ppn43zYVzPF3Ul7CTgnI1UakYE9YdusC
         RnYqNg2cAaEkec8NzJ3UOCyic04KDzbOPeKRvkE/hHu8Im9O6UH0ZOcKzkh/iJd78dAH
         kU8g==
X-Forwarded-Encrypted: i=1; AHgh+RrEPAfDcBHEvb1PjK2n9XW9X6PnnP0/qMApk/oZ7M7oHP4Yb4LmU/TOICnqIiphUHdLsHCT0Ix8sHwKmw==@vger.kernel.org
X-Gm-Message-State: AFuF++kKlIB2v/S8bimChvz5Onyxo/dHso2XNNoLRAM1hm4qIKyTX/R/
	w8hHbyi/cZibZ26ZERmnApqUEWUZ0nI4ckU+6mwWWwwcPrCf/7KW81FcsoRROgwNJlaZGTnfnWJ
	uU6Ho/pSrUQozKgof2aauq0nPU7lKJPV5HiaILvJOQw==
X-Gm-Gg: AR+sD13WXYhk+D+VORZz83DtJGi4VNz1t9J/jTKZRPZ22wQkErGSXkpEoLkYigmR2C8
	0prBrmybfIkuxREZ/bh1AX7yCPJGa0h60dX8BeQNqwVUMZ7fBzleTDeEYV7EoqXGK6cCrq3HjRZ
	9B5Uzm6YitBObSR3GeaSgufxbePcaQ2mmfm5XZOsN6AaaommdBcsIApvZXg5vv1Cou1UsYCbkWJ
	SlN+Wl/aUQfbTkxzcDO81kxthWeg/1OV8N6g9SUgD20blgoXrHxFFRt9YbkjpxKCiPBsyEkVyQ6
	HMCnBj7M3mq9h+rdYxVETLHdm47WZB3A6UpBN4zLAdrL6DhoKd6qr1VCNkMq/hg9291vtRNZxdf
	Snvw29DWPkQr27Fd7VOelQeza9Omxas4/2qRhjKwTCQ==
X-Received: by 2002:a05:600c:3b13:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-49cdc4332d4mr140012115e9.7.1788265130443; Tue, 01 Sep 2026
 05:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-6-neelx@suse.com>
 <20260601230913.GD25574@quark>
In-Reply-To: <20260601230913.GD25574@quark>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 1 Sep 2026 14:18:39 +0200
X-Gm-Features: AcwNN1WZzfR7nMvK7wzsu0uw9g-Q6K8Z-mgC6-phqgqu2rO8TCpwPmWb_Vlt_uY
Message-ID: <CAPjX3FebVAj-U3s7nJiwu3D74p_nAGacYPJAX04TVXJBaievGg@mail.gmail.com>
Subject: Re: [PATCH v7 05/43] blk-crypto: add a process bio callback
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 01:09, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, May 13, 2026 at 10:52:39AM +0200, Daniel Vacek wrote:
> > @@ -330,6 +330,17 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
> >               }
> >       }
> >
> > +     /* Process the encrypted bio before we submit it. */
> > +     if (bc->bc_key->crypto_cfg.process_bio) {
> > +             blk_status_t status;
> > +
> > +             status = bc->bc_key->crypto_cfg.process_bio(src_bio, enc_bio);
> > +             if (status != BLK_STS_OK) {
> > +                     enc_bio->bi_status = status;
> > +                     goto out_free_enc_bio;
> > +             }
> > +     }
>
> This looks very out of place in this function, because this function
> potentially submits multiple encrypted bios whereas this code assumes
> there's just one.  I think we could at least use a comment here, as well
> as a WARN_ON_ONCE(!bc->bc_key->crypto_cfg.process_bio) in the case where
> an additional bio is being submitted.

While this funcion may submit multiple encrypted bios in general case,
the check below makes sure that in case of crypto_cfg.process_bio
callback splitting is not allowed and only single encrypted bio will
be submitted. The WARN_ON would be impossible to hit. That's why no
handling is implemented with the in-loop submit.

> > +     /*
> > +      * We cannot split bio's that have process_bio, as they require the original bio.
> > +      * The upper layer must make sure to limit the submitted bio's appropriately.
> > +      */
> > +     if (bio_segments(src_bio) > BIO_MAX_VECS && bc->bc_key->crypto_cfg.process_bio) {
>
> Checks should be reversed so that the expensive bio_segments() check
> only gets done if process_bio is non-NULL.
>
> (Sashiko spotted this too, by the way)

Yup, true.

> > + * @process_bio: the call back if the upper layer needs to process the encrypted
> > + *            bio
>
> or NULL if no such callback is needed.

I'll add this.

> > + * @proces_bio: optional callback to process encrypted bios.
>
> Typo.

Already fixed. Sashiko also noticed.

> By the way, after writing kerneldoc you should run the kerneldoc
> checker, as it will find things like this:
>
> $ scripts/kernel-doc -v -none include/linux/blk-crypto.h
> Info: include/linux/blk-crypto.h:79 Scanning doc for struct blk_crypto_config
> Warning: include/linux/blk-crypto.h:95 struct member 'process_bio' not described in 'blk_crypto_config'

Hey, this is a good hint. Thanks, I'll keep that in mind.

--nX
