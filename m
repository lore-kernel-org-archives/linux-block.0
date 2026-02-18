Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B624330330
	for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431087; cv=pass; b=jKzAogdA2Hk08m4hYKpy1ShNoDZc4LaeNIksM1St8X4vegpl/17vHFFuWCOlH2ugz8xRsrtU3CSAlFEG1Wrv3aTMMcLLO6StLu+0UrKq43e1vmQsUSxBO9PuUhHgB02IUf1722b88z/btzQOCbUnTyaMQAcp71TP4EeuO299XXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431087; c=relaxed/simple;
	bh=Dnfw3O7yWCnVIQEgDYrdHlr08rz6PxDdK3ndz6QSILY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoLOaCXS4FTLss/jMUyauOdBI6F9cKQcaOf1Sk36w8X0hj9uWy2m6k91Cd44bwxz15rKkDgh4kjUIVPcroxGgPEpZgLem5TD6hdl9yWfrNBbRap5DFAo64zOht6C85U4VgWY1VlNzSJumadDrV9Lh4WViKSN7t1dohPfmlBmSbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PfZdcMqY; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PfZdcMqY"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4362c635319so5389807f8f.2
        for <linux-block@vger.kernel.org>; Wed, 18 Feb 2026 08:11:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771431084; cv=none;
        d=google.com; s=arc-20240605;
        b=WBO/GRIjp0vYMazdwl/VXDv+CTeGGgeUkxzq3ikcESYk36wLwqEgWrl5o+wvnVOJ+f
         s83aX2vEFJ/vNa3sZDqorTaC/caitRKfh4/nDt5tyj4txnKR6nKWi4k/FzSMgDxAAe+C
         UuYOYXMuvXQcfo/NGu+K7qx5TyyE3nsLQ7gBmbVRMWQcZCbBNLP9pxCviRWNQwCBbudv
         RxKACywXWwpRZhLWwi7SVQXYqHsrRWUnPcYvY9ZooY9g/0fdl5jcxPyQLNT/WJsSMYaZ
         38sn5o00FLBmiQjMa1WJSwbB/6GXILjyKU5LX1se8XV8ZokzjlxJ3urdLJT1DsicZF+H
         pkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=npZADHZ7rRxwkGy8riawRonufvbdSCewmEnndlsCQtE=;
        fh=6jwvgJxG95TI12gIY3YhPEf7CVBud9uZbdCJBGNmOTA=;
        b=Pex+OyFoXQGVogh4R8LtFXmipZkxtvguhJUeV12hj4Dsar04Asfi5wHJfqbQ9muDW3
         EPqmmdOMlKspPe6EMHhmklxAlyGHGsmyyeSFUzXpg8iuh3oFeB95h2sV/PkVxH+H00TF
         vAnPzPSNdP9JwzjMDjRDFrusSza7IK54wqBq8BRRgrySyTK1pdRjn87lOUATHNVgz1pJ
         oEkWhRO3CiLyDY5q2po8OO6FTHlCCSKSdTz5w0mgoZRHfeyasYI1LhACMOUu1fI2qBAt
         gscqqCn8LMP8Ih40FR2PqC3reY6cQ1kiO15+UfL0BGBoUzeBD37sZ+Dwd5VBAG9Ld+gY
         C0KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771431084; x=1772035884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=npZADHZ7rRxwkGy8riawRonufvbdSCewmEnndlsCQtE=;
        b=PfZdcMqYwNT7onik+41pV0XW615Gz/ybTHKwKGbSkAOd6Mos1WFO7LFtssv3KsJMAR
         XO1TRVb6Qo9qvBRRnOAWBFni1s0Zr1eQu98HHdBJLIqTgYGHCQqJovzdZJXq5RY7WgBA
         KbyJMtBcWCKZLenWtLsvG4qStEZNU8jXJeRMurhR7RdIDttjb3aOAftogUIVGiwTD2ZU
         nRghyuIC+NU7OcJgVdDcGZ5i7lez+7EHPkSZypqLabQ+eMSL1t2/DOfNeqwydh729w4J
         vA4ZP+FZ3IjJp+guVfb6qPNiGwFesSdjS0Ey9sQ8kUrOWMHj0hurPFY7lF2535atr29C
         kOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771431084; x=1772035884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npZADHZ7rRxwkGy8riawRonufvbdSCewmEnndlsCQtE=;
        b=qBHHOsBY/MZJQlrevd3LrXbhPOXRM3koi1NKGH8/nsr3wkvBji5q37NRpObE5EukN3
         tOD6KG25Oq4TWcztFCcepWvjLqwrhFpVSVoO16U9xqTjgWuIgJ4xcMr25Vm7UoNINVN4
         YA1/FFrqeo3kp2UjMGkr2s6BuWN3jmfIK2vs8oZfyP0w+GIHOhseZbP5XOq5FRPeX8cp
         bCmzRYxzAbzATfUYvFx4bv+4cr/6Rf8CHlWFnQ2VyNDdhIWRhPFgdCcZEjXHwCAe9UtK
         FowJAWP8dI05lCN7H1USfoEi1Mz6KXIhReCF9EKGjc8zfC/7bRtes9J6fcAwGQERazep
         qhGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBC3YGBrAJnhAI5AEIVhDiqbXMlJhuTw/1+4PMKZRaTSrJuJ1imVEabQXKyIdSo0dMi66hGIBGI6jv0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7sOTIinsfKUhk3JgdmUP+HvMt4r7GsmxA1PIsokp0leR1kM7+
	hRCvahWLFSjuPUWGqk9wLCt0YMYI8EdSEyJaN1DcUktoajQDFjZvmukZqFkNXjyKkSYGL1kV0WT
	wKzK4rr2q7YleX3n/zlf40WSr2qiXHy7J9rVPBetN3g==
X-Gm-Gg: AZuq6aIV0i5jlmUPJJcih3GZyq+I9tlPcLSUnfS886bEHgZMEjdeG5a7a+4VlUpQuxJ
	tpOFL2/c+b04ECxZbyjyqruu2gGyaWUPvrKernkVZeI6QAMj1RDmsnbCELaf+QtjAnYYp46bCfi
	4QGXZ4Xc0d3dyEEdVyHyJQRtxaKeo9laC92KH/Jsux4fUGCDkplkE+pQ9leUww5iX0qHB17VVhF
	2txfRz1U0c0G8nitbTQosDxqOIZPFIfXYjI6XysNrSCIL5MOPH8hFUVdPLCD0E62dn9dg+vl4qf
	uvvMG1RVXLNb3zYA4fz8rMdKgESfPRi2GBNeeVFx/LtX5hkDVrDo4V+eZgqLrwzXW+49fsTyeuA
	miyFB
X-Received: by 2002:a05:6000:2dca:b0:437:6e63:9172 with SMTP id
 ffacd0b85a97d-43958df3516mr4465105f8f.4.1771431084459; Wed, 18 Feb 2026
 08:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-21-neelx@suse.com>
 <20260208151928.3245396-1-clm@meta.com> <CAPjX3FdiskLiELriX5gE2YEDMMwz5QQbNDnkAuFVov1a=WL_jQ@mail.gmail.com>
 <989433cb-4ab6-4a79-8dfc-9f5f542e2647@meta.com>
In-Reply-To: <989433cb-4ab6-4a79-8dfc-9f5f542e2647@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 18 Feb 2026 17:11:13 +0100
X-Gm-Features: AaiRm52H6a8Dx1S_J50i9RFK-wqtAs4pqoNkIHGApsZEVneSHeR9ZFaJMuu2lQI
Message-ID: <CAPjX3Ff3qBoBxWzZ+Tg5HgSSEPGrbmmGMmf5MtiE4iU8PtHUMw@mail.gmail.com>
Subject: Re: [PATCH v6 20/43] btrfs: add fscrypt_info and encryption_type to ordered_extent
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Feb 2026 at 16:50, Chris Mason <clm@meta.com> wrote:
> On 2/18/26 10:29 AM, Daniel Vacek wrote:
> > On Sun, 8 Feb 2026 at 16:20, Chris Mason <clm@meta.com> wrote:
> >> Daniel Vacek <neelx@suse.com> wrote:
> >>> From: Josef Bacik <josef@toxicpanda.com>
> >>>
> >>> We're going to need these to update the file extent items once the
> >>> writes are complete.  Add them and add the pieces necessary to assign
> >>> them and free everything.
> >>>
> >>
> >> Hi everyone,
> >>
> >> I'm running the btrfs for-next branch, along with the encryption patch set
> >> through my AI review prompts:
> >>
> >> https://github.com/masoncl/review-prompts
> >>
> >> I'm working on some btrfs specific instructions, but hopefully these reviews
> >> are already useful.  I've kept the headers to make it easier to double check
> >> that I'm actually replying to the right email, but please let me know if any
> >> parts of this are incorrect:
> >>
> >> commit 61cd57301840de69a3f6573374d41ad4b4bcf348
> >> Author: Josef Bacik <josef@toxicpanda.com>
> >>
> >> btrfs: add fscrypt_info and encryption_type to ordered_extent
> >>
> >> This commit adds encryption-related fields (encryption_type and
> >> fscrypt_info) to struct btrfs_ordered_extent to support fscrypt
> >> integration in btrfs.
> >>
> >>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> >>> index 5df02c707aee6..7a5701937184e 100644
> >>> --- a/fs/btrfs/ordered-data.c
> >>> +++ b/fs/btrfs/ordered-data.c
> >>> @@ -192,6 +192,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
> >>>       }
> >>>       entry->inode = inode;
> >>>       entry->compress_type = compress_type;
> >>> +     entry->encryption_type = BTRFS_ENCRYPTION_NONE;
> >>>       entry->truncated_len = (u64)-1;
> >>>       entry->qgroup_rsv = qgroup_rsv;
> >>
> >> This isn't a bug, but the fscrypt_info field isn't explicitly initialized
> >> to NULL here. While kmem_cache_zalloc() at line 175 does zero the memory,
> >> all the other important fields in this function are explicitly initialized
> >> (compress_type, encryption_type, truncated_len, qgroup_rsv, refs). Would
> >> adding an explicit 'entry->fscrypt_info = NULL;' improve consistency?
> >
> > `entry->fscrypt_info` is set in the very next patch "[21/43] btrfs:
> > plumb through setting the fscrypt_info for ordered extents". The
> > series is meant to be applied as a whole. It's just factored into
> > implementation steps.
>
> The prompts try to flag any patch series that don't follow best
> practices around bisectability.  There isn't a ton of instruction about
> what those best practices are beyond if commit A makes bug and then
> commit B fixes the bug, flag it.
>
> This patch set is pretty unusual because you're trying to preserve
> authorship for a number of people, and so there are a lot of small
> judgement calls about when to change patches and when to fix them up
> later.  I sent claude's comments to help highlight places we want to
> decide things, but I don't think there's really a wrong decision.

I understand that. I was checking every commit to ensure it builds
correctly. But not really testing for bugs or regressions.

> >
> >>>       entry->flags = flags;
> >>> @@ -630,6 +631,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
> >>>               btrfs_add_delayed_iput(entry->inode);
> >>>               list_for_each_entry_safe(sum, tmp, &entry->list, list)
> >>>                       kvfree(sum);
> >>> +             fscrypt_put_extent_info(entry->fscrypt_info);
> >>>               kmem_cache_free(btrfs_ordered_extent_cache, entry);
> >>>       }
> >>>  }
> >>> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> >>> index 1e6b0b182b295..ce19198e7f844 100644
> >>> --- a/fs/btrfs/ordered-data.h
> >>> +++ b/fs/btrfs/ordered-data.h
> >>> @@ -124,6 +124,9 @@ struct btrfs_ordered_extent {
> >>>       /* compression algorithm */
> >>>       int compress_type;
> >>>
> >>> +     /* encryption mode */
> >>> +     u8 encryption_type;
> >>> +
> >>
> >> This isn't a bug, but placing the u8 encryption_type field between two int
> >> fields creates 3 bytes of padding. This is minor, but in a filesystem with
> >> many ordered extents, it could add up. The current placement does have the
> >> advantage of grouping encryption-related fields together logically, though.
> >
> > This was actually changed from int (as Dave suggested, IIRC). But I
> > did not move it.
> > I guess we can do this:
> >
> > --- a/fs/btrfs/ordered-data.h
> > +++ b/fs/btrfs/ordered-data.h
> > @@ -127,18 +127,18 @@ struct btrfs_ordered_extent {
> >      /* flags (described above) */
> >      unsigned long flags;
> >
> > -    /* compression algorithm */
> > -    int compress_type;
> > -
> > -    /* encryption mode */
> > -    u8 encryption_type;
> > -
> >      /* Qgroup reserved space */
> >      int qgroup_rsv;
> >
> >      /* reference count */
> >      refcount_t refs;
> >
> > +    /* compression algorithm */
> > +    int compress_type;
> > +
> > +    /* encryption mode */
> > +    u8 encryption_type;
> > +
>
> Seems mostly the same?  I'd suggest paholing things to find a good spot.

Hmm, that's what I did. There was a 4 bytes hole.
Nah, I see. I just moved it. It's not a big deal then. The structure's
size remains unchanged in either case. Still plugging a hole. Or am I
missing something?

> >      /* the inode we belong to */
> >      struct btrfs_inode *inode;
> >
> >
> >>>       /* Qgroup reserved space */
> >>>       int qgroup_rsv;
> >>>
> >>> @@ -133,6 +136,9 @@ struct btrfs_ordered_extent {
> >>>       /* the inode we belong to */
> >>>       struct btrfs_inode *inode;
> >>>
> >>> +     /* the fscrypt_info for this extent, if necessary */
> >>> +     struct fscrypt_extent_info *fscrypt_info;
> >>> +
> >>>       /* list of checksums for insertion when the extent io is done */
> >>>       struct list_head list;
> >>
> >> How does btrfs_split_ordered_extent() handle the new fscrypt_info field?
> >> Looking at that function in ordered-data.c, it calls alloc_ordered_extent()
> >> which initializes encryption_type to BTRFS_ENCRYPTION_NONE and fscrypt_info
> >> to NULL. If the original ordered extent has encryption_type set to
> >
> > Ditto. This is changed in the next patch [21/43].
> > alloc_ordered_extent() correctly sets these fields.
>
> It seems unlikely that we're really going to maintain bisectability for
> encryption being on in the middle of this patchset.  So this seems fine
> to me as long as the bug doesn't impact encryption being off.

Yeah, I think it should not. (Famous last words...)

Thanks.

--nX

> -chris
>
