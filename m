Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CADD2EA172
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926752; cv=pass; b=GRAAytiJfRsPG+GAhRxAFS6jRD+9ueXLcJ099i9rMejX0laImbEf7M8FyCk/jPrne5QWt2hyjEWGeCssl15dtMRubrLBb3LAaxJYKZogkbhtRm/8uITVTdyzpZ8n9Y33sw0EQFV2zKmcnyA2ShvXvm45WYyDfOHp1GlllXmIZ4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926752; c=relaxed/simple;
	bh=VoW/jBNfb743v0Rg9HRnbEDd8rmyiFM2HQb/i/qQDkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMr5GJa4W9+4qisf+9jdfp0Y/clxAattgzsbwGIc9wUDG+f0LsaLDf/7i2yl++utwUNpb4hnaJ8NjM5+D5aGj8YNcAxTd8Ssby6SlDwezf5j+SOon/gpIFTG/XjWR+dMcLtpJIxJL/2r52XBZxA1tHL6zTiUCR+2NDtv2nLtOtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SzKTEfuc; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SzKTEfuc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so27939925e9.0
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 23:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776926749; cv=none;
        d=google.com; s=arc-20240605;
        b=KeyEWLwtI+zTtxHF13fX80UnHzwbj4/ZxG2OyLw7F/RHJmem4+pLl5+aONNZVGKytz
         SniEpvowXpiws++AueHdWW9Pz08Plt/mAAYISJMIrkJ+BDCslVBMH0VbxNUKQ00JkjRy
         B8FpfiVv5dx65Nm+o3M0lJN32wiO5TUJS0gaC8tfssKaTDIhl7+bQqzxMb7yxWTmpgW9
         tGLcHWgp+Ns/nAmp0NUui02rUhO4wfvJvuH/i+iWn250eHGoEibSmsmO+ZTUkTIbBihI
         bCzgebirQm/Vgr1owR2NXgDEryXsOkCZgVTGQudgXaaI9CLThCmD1Ujwxs3T+um8mufy
         +Pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VFx+EzwA27+TMrhv+NVPiNfgiU3/L9VD2VlgqAAxpWA=;
        fh=EISn12PAIZzDDrG/uxnfhKIt7k1mRieU4RpcJNaHSBI=;
        b=IvuMGGVZ4EsRoWfzEm5B9hXABjPfSCEcvcrf6M0WKQvbHyI4bCzRFcr/4LKE69mQ/Y
         TD0kVhkXvI+rDGBb5aAbQGNTl+KoWTRcl94Ka1I11VCli+/eYra/B9LBJpBNGRMISd+6
         AY/qL5Sm0qjC8Y+aqOkwGlBujJ+8GAgiiauOS7RvpXDk5xhC2hwLHRoHvqOp+QUmnmc8
         FZA6M/vMOO1WSW7lFYpGetAksDHGdN1cUxlo8WVFa9ok4YCH5fehDMPguXK8n6dfKL3S
         epdwHo2JBofAbg4RXlYY1qkUAD7MCdyYysjhoM5q4UyAvL+Pl+MaJ8B3vRf6Sk1l8vQN
         OIFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776926749; x=1777531549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VFx+EzwA27+TMrhv+NVPiNfgiU3/L9VD2VlgqAAxpWA=;
        b=SzKTEfuc5t7Yfm0cnYEKYxlnYEfVvHxu5qKAkZ3DPCnVsknAYgW4TurCBPDZzvXu/N
         XQvs5+VPDq1orOE5HecPECrpLY2//2RsDtvckuql3sjOyT3Ma5B/tkxf81dVrOap733M
         Jdr2Ec4qQH+wpEAn7/ZXnRfXAugH87Yi40LV94YgI/cWIu7GKZodhrodWh8ZmG/VaInS
         1ArSpjSaIJ0u1Z6hr4OlTOKLmqUCb7GQ1LHjXYp4F0hux8fvM9rBYaWzA/HkLmyTyYM1
         gKxpTtI5YBmL9qXkOyXbrGDBV/JUwHNscB/hKFgf37tnjy87zYLRWKehlIE+5HfA9FiX
         D1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776926749; x=1777531549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFx+EzwA27+TMrhv+NVPiNfgiU3/L9VD2VlgqAAxpWA=;
        b=LvWqpa7G1eXQb6mVGD2Xv73WXYg9CxTK45botMTJArbrgse3r8H4qYcbknjRi6ZR90
         xThEif0teCQcL5an7Qtpvw8c2aT121U37qaQhXoEPdtoTdFw8bph71fQrlIJMtOAEvd0
         iDalVCawoZXvGchtvKTUQPVHr2SDtIbIA/hC84rCWGv7qZdSzIqu4dMytXiSvwFfW8yD
         jkMhjOHWxca37TbwSqehGZWazO/x65NdHfgohm8NJu2sVMAODX2evDYFW5KZ7p9WVzTO
         J7CBsqyqh6pjOzkRWeTpSHvcWJrX5ZDoeXdXVoxCp8IWvKraCmrkVzyOSQedfpwUVYdl
         VNzA==
X-Forwarded-Encrypted: i=1; AFNElJ86V9LahO/XMpBvz86eknTktgRunqIG+Ho+bavzRC1yhf+zTRl9d+OwMD0bAwVJkgdaooqWfHXhOoB+sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsfiTMA/8zz9Yc1tzAOnTWPGz/buQIJOf8MIaZFMRv16JprFQT
	W52VWqQx8admNw+97MGQNi7RgHo61hk7a9wNn024mgrOAYlFIQoRnEnYRvvqvx9sxz1vd6mCfk4
	B+u5Lv8VpYlvHLYRYIssps1k3RIrVR3LxiqMzEYqUgA==
X-Gm-Gg: AeBDievneFjmKNzhsYr/BCrA33v4NZ8qO45RcXU/GJInNH+/C3zjbGLq55rP/cZKg9E
	E5Q5YD17nm0lZAC+rS6WhHnklmelz0DzrzfZ074r+sN9NDoB5DzYnZ9q/eJatUrKKPMac3pvF8C
	zQuVWw2tKlNnoAXguXR1aqPXRrJp2RTHf49oxsh6uJnmceea+ibBI05z5239x47FBo2cb9XQMED
	K47Ou1IcW3PDcNJendDdVDByykYGDHgZ4wPkdadz3zGAk18uZg0CrHCkoIQ5SVPAfLbTSFwK3xB
	ANFWk+HxQp3UQwRity9n/w/oh8VkanGMGRF8G+JG/ckxcNyvzsPyhUa/aaTOBs+we3l160cIN7u
	lxWtQosm+9dRentmJuO7EofOOJg==
X-Received: by 2002:a05:600c:2256:b0:489:1927:5c0 with SMTP id
 5b1f17b1804b1-48919270787mr172142805e9.0.1776926749488; Wed, 22 Apr 2026
 23:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-2-neelx@suse.com>
 <20260221221153.GA2123@quark> <CAPjX3FficsLf2QXFU70sR6PN7h8rj5opz_wntLm+Acd3YLvu+A@mail.gmail.com>
 <20260422225310.GB2226@sol>
In-Reply-To: <20260422225310.GB2226@sol>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 23 Apr 2026 08:45:38 +0200
X-Gm-Features: AQROBzBwq5ZRAPxV2aicYDXhz8eGzSNuCy0WrJTFESLNDvoGYhORBKakn6zpBls
Message-ID: <CAPjX3Fdg=4gMYZQcfmG00ucrtheUW-UKqR0yGwfJ=cA3BzrRWg@mail.gmail.com>
Subject: Re: [PATCH v6 01/43] fscrypt: add per-extent encryption support
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Apr 2026 at 00:54, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, Apr 22, 2026 at 10:17:40AM +0200, Daniel Vacek wrote:
> > > > +/**
> > > > + * fscrypt_mergeable_extent_bio() - test whether data can be added to a bio
> > > > + * @bio: the bio being built up
> > > > + * @ei: the fscrypt_extent_info for this extent
> > > > + * @next_lblk: the next file logical block number in the I/O
> > > > + *
> > > > + * When building a bio which may contain data which should undergo inline
> > > > + * encryption (or decryption) via fscrypt, filesystems should call this function
> > > > + * to ensure that the resulting bio contains only contiguous data unit numbers.
> > > > + * This will return false if the next part of the I/O cannot be merged with the
> > > > + * bio because either the encryption key would be different or the encryption
> > > > + * data unit numbers would be discontiguous.
> > > > + *
> > > > + * fscrypt_set_bio_crypt_ctx_from_extent() must have already been called on the
> > > > + * bio.
> > > > + *
> > > > + * This function isn't required in cases where crypto-mergeability is ensured in
> > > > + * another way, such as I/O targeting only a single file (and thus a single key)
> > > > + * combined with fscrypt_limit_io_blocks() to ensure DUN contiguity.
> > > > + *
> > > > + * Return: true iff the I/O is mergeable
> > > > + */
> > > > +bool fscrypt_mergeable_extent_bio(struct bio *bio,
> > > > +                               const struct fscrypt_extent_info *ei,
> > > > +                               u64 next_lblk)
> > > > +{
> > > > +     const struct bio_crypt_ctx *bc = bio->bi_crypt_context;
> > > > +     u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE] = { next_lblk };
> > > > +
> > > > +     if (!ei)
> > > > +             return true;
> > > > +     if (!bc)
> > > > +             return true;
> > > > +
> > > > +     /*
> > > > +      * Comparing the key pointers is good enough, as all I/O for each key
> > > > +      * uses the same pointer.  I.e., there's currently no need to support
> > > > +      * merging requests where the keys are the same but the pointers differ.
> > > > +      */
> > > > +     if (bc->bc_key != ei->prep_key.blk_key)
> > > > +             return false;
> > > > +
> > > > +     return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(fscrypt_mergeable_extent_bio);
> > >
> > > Similar to fscrypt_set_bio_crypt_ctx_from_extent().  The copy-pasted
> > > comment needs to be updated to remove no-longer-relevant information
> > > specific to per-file encryption and correctly reflect per-extent
> > > encryption.  The DUN needs to be calculated correctly for sub-block data
> > > units or else the combination of the two needs to be unsupported.
> >
> > The DUN is fixed as per above. Regarding the comment, it looks quite
> > valid to me. What exactly would you like to change?
>
> It's now been a while since I was looking at this, but looking at it
> again now, at least the following parts are incorrect:
>
>     "the next file logical block number in the I/O"
>
>     "I/O targeting only a single file (and thus a single key)"
>
> It's actually the block number in the *extent*.  And it's a single key
> only when the I/O targets a single *extent*.

Yeah, I fixed the block number comment with the change to the `pos`
offset. That one is clear.
I'll amend the rest.

Thank you very much, Eric.

--nX

> - Eric
