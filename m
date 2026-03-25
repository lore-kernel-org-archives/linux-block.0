Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C73CF678
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448276; cv=pass; b=QUOfUVkdxT2uI2eQr1kDWgQ0UibjjQADyvxxhPSdMF1/E3wXigzYx4OdIZe0E6WV4Oifxbqb6nQ1n+IrFQYnN9WhgSnEL/U+hgj/630jkm/y3lvS2M4pDHA1bFQIvcjGxPkdTAnrdbHVXmIbefWFlFx5lDnh7faPrA4Z6MFSUWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448276; c=relaxed/simple;
	bh=JI+TEE49zQK3cKPmCz6svi6GFaT2s7u6w0MtCQyVKb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyOwyeTtns5XSCP8AgC0xyaF7pGCvfeKp+Et8yhRGhUtVNrBzWDSL8ba7Fio1fd0ydkiN0YGMh1fueV349tq4tB3CW4KwH8OmkuiqEnKGIywT76hKcsxGGAasv+6lLGWKUO02nNjU2Mh53UDubEZtnaIhoF0rOPRLEH6ilioIKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=He8b1eWY; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="He8b1eWY"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so2827291f8f.0
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 07:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774448273; cv=none;
        d=google.com; s=arc-20240605;
        b=Oby6yUsgyl0Q4TTeFcAVjdA9+KMY3XN9NMmRnCyZNK18k/y54v03pbGY7WAe5yo2Vz
         rEm7bOLZJY5986/YnuK1G84JL4kUvSxKHaV4z/hL7v3MScp98sAwzvN+z9ZnhXCFo0Hn
         YM91WAPQDth1D75vwc9ggMCmvNB9PmL7pmWnbIKWDfC6rHjoxv+vra+1gM+sKfaePYqq
         4dTWqXVUGsFjjcgSm7675h2TVLZr4KxDJ8KLBFfNC8qspWcUfYsZnySbtU8dZ8uNc7dB
         Y8DZiOBYItZXOK4GgM1iF0zyRihPRR8SJCpGJ8fsn1wavm5XiA7M/KkYQuiXPHhmGjY6
         +inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5n8QXWW6p9E8l82xzEfoMSbTtP2cvmaz+gb8I7NDwzo=;
        fh=q2I1VM9qePZLSKAUk5ngMVsm5q5To3ioXVvJSIEv3bQ=;
        b=GsoiWc5dxDm260tG1U6edhl3Z3FGXCdBhxRWXyz8pThdPx0Bnyc7XzZkjAGPkvNURn
         HQWOAHi6pTicP6w8ugrsKyAz5VvP6WUB7RtIOEZMHoQb/OyXGGT0CtR8c7U2iVvqsAmL
         iqfZFcdwE1upPcKdb1uFnm4aJ37RwNOniOkQ9hU7wrmx5b1e546e+C/2buT4HYHTvlUp
         /rsL1e8Dwf3/LIyQmeMz6aVG2aYd1/0lSYykxGcOzp532iQkgOE0ggXAKkeSoLGnrZLn
         nYcUlCTyFlsqiKUJkGl4PcJ3PWv7UCrvA5dR/45SAn+bpkBJdLlzJmWC2B/pvyoLxqw3
         5qwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774448273; x=1775053073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5n8QXWW6p9E8l82xzEfoMSbTtP2cvmaz+gb8I7NDwzo=;
        b=He8b1eWY0jASt4uLuF6oCfL1o9EBtkcoL/seGoFNRov2X0T2vI57qN9LsdTbolUsjd
         gGdJf7M7Cpzy7/8lRIQmGMlPM2n4D4RRRn4dG8mSEv5WcDNj4ZfrnXfpo7TPheCsTLrn
         cSiDQVqBLIgxCq/4ndiP4aSrw98h3YOalF/b0D+DhCJEN+2J/w0VCt+5dT6x4xohB+We
         zeoYEQSoVE4z691qKVDVObHLbxFHW/zIyXLK4VQGTLMTG2oqrSfBjJt/34V4HaUAoxOl
         8SYfF9tJnyLr9uxo/Ifuhy5V7mCUdhCpy1Lod4EBRcutAx/cEtrAP29TMps1udKBPcR5
         NilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774448273; x=1775053073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n8QXWW6p9E8l82xzEfoMSbTtP2cvmaz+gb8I7NDwzo=;
        b=GpwluAfloZM/5TbFG5+BaP49iF3guGKKbhNCjJFWqxJPxeX0ftSo74sJhVRCL5n/ON
         svxpL9uhfz3Mmky7Q8W8fZOC5YyZ/V+ARFgDe/mqErKlQARj23aHtDYdPlstV+ydpI6F
         VsvTRGTVkZqqDXqhf7/sAeyG7hquw1mQolw//XZW1RvaWTX1GdczRpLJxH/CrzTuUiJ4
         9OPn1AfSAIfupoULzHgBRiazIN/v4RbBpOOLYKSDjV692thzUWkt9/3M+BH2TBOiRzcK
         y/LT0YBkk/GF1tKe9lYqb80wQxHyx1QD5oLvX8dczCD60U8wyYzUYBHvR3n5Vt0Xk5AX
         FNlg==
X-Forwarded-Encrypted: i=1; AJvYcCUQQellp60UW59FLR2A/QefCil1pNzQWvphq8WSGBvCIVewo/XisYXS04SC8AwBEiu+PXoRvyMzCIPvjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+u7RXlWyGSnAHkUmSQe5vicDgaaeKMK2/0IPoxIrMCJWS/X+x
	EE7xdZbNXQYeNMsC3jNtW4bb0NRi19RBSRwKytmF6DxzLoUy+w6PdDEmwHaakBUhLHV3qvb7ovK
	h4bwsNJy3v0zOsCHbHGlCZ7EggXBehDDGu3ayAA5Uuw==
X-Gm-Gg: ATEYQzxjtczp7O8BwUvYDO4wyUhTPw4NIF6AwjeMqsicXekoNDcLWMKnyxyZJeFKtsK
	odbYBGLXhF+aR1Z+bx9oMJ8KSU9XhEvE040RL1qeDtRczCwD/hAEzjw89dADm06xE3E6CQSIY9S
	BSUc4jmVF0iMmLjpCYE1PUq7IOEtdH/tjFjGSGr1c36iTvTQJMvbNNEjed3A2cJzHuVacrVe2aT
	qqfd0yEcxI3RyV6Ne2xExAD8sNGkyY2Uuhpqb6qcoAjtHedpQ92Sph+zxd8cwAQLXrjFejy888I
	yYp/IqlE89NSU8k9dxKH27a4q0YQdBUhr26n5JsUUUD1bR73BYIrw9u0PU+yf1bkCSr1psJ3imW
	FswMK
X-Received: by 2002:a05:6000:2084:b0:43b:3f2d:7d3c with SMTP id
 ffacd0b85a97d-43b88a21758mr5567679f8f.2.1774448273072; Wed, 25 Mar 2026
 07:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-34-neelx@suse.com>
 <20260208150854.3090411-1-clm@meta.com>
In-Reply-To: <20260208150854.3090411-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 25 Mar 2026 15:17:41 +0100
X-Gm-Features: AQROBzCA2SzXEdLH4PwF7MzsDSpXTmv7zxyVpq6_W8dQnpHa9Q-YU8fXQyJUEFs
Message-ID: <CAPjX3Fc28BffC9C2Fbd7S_+4Ch7xvX18k6MpehPy_fm+02cA8w@mail.gmail.com>
Subject: Re: [PATCH v6 33/43] btrfs: implement read repair for encryption
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 16:09, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > In order to do read repair we will allocate sectorsize bio's and read
> > them one at a time, repairing any sectors that don't match their csum.
> > In order to do this we re-submit the IO's after it's failed, and at this
> > point we still need the fscrypt_extent_info for these new bio's.
> >
> > Add the fscrypt_extent_info to the read part of the union in the
> > btrfs_bio, and then pass this through all the places where we do reads.
> > Additionally add the orig_start, because we need to be able to put the
> > correct extent offset for the encryption context.
> >
> > With these in place we can utilize the normal read repair path.  The
> > only exception is that the actual repair of the bad copies has to be
> > triggered from the ->process_bio callback, because this is the encrypted
> > data.  If we waited until the end_io we would have the decrypted data
> > and we don't want to write that to the disk.  This is the only change to
> > the normal read repair path, we trigger the fixup of the broken sectors
> > in ->process_bio, and then we skip that part if we successfully repair
> > the sector in ->process_bio once we get to the endio.
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
>
> commit 096c17a6a951ed0c1100e863c4ee3a95bab0ad51
> Author: Josef Bacik <josef@toxicpanda.com>
>
> btrfs: implement read repair for encryption
>
> This commit implements read repair functionality for encrypted btrfs
> files by adding fscrypt_extent_info tracking to the btrfs_bio structure
> and handling repair operations before decryption occurs.
>
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index c28f3f53bad28..e82de96b533cb 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
>
> [ ... ]
>
> > @@ -293,6 +323,13 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
> >       repair_bbio = btrfs_bio(repair_bio);
> >       btrfs_bio_init(repair_bbio, failed_bbio->inode, failed_bbio->file_offset + bio_offset,
> >                      NULL, fbio);
> > +     repair_bbio->fscrypt_info = fscrypt_get_extent_info(failed_bbio->fscrypt_info);
> > +     repair_bbio->orig_start = failed_bbio->orig_start;
> > +
> > +     btrfs_set_bio_crypt_ctx_from_extent(repair_bio, repair_bbio->inode,
> > +                                         failed_bbio->fscrypt_info,
> > +                                         repair_bbio->file_offset -
> > +                                         failed_bbio->orig_start);
> >
> >       mirror = next_repair_mirror(fbio, failed_bbio->mirror_num);
> >       btrfs_debug(fs_info, "submitting repair read to mirror %d", mirror);
>
> [ ... ]
>
> > @@ -214,17 +244,17 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
> >                       goto done;
> >               }
> >
> > +             btrfs_set_bio_crypt_ctx_from_extent(&repair_bbio->bio,
> > +                                                 repair_bbio->inode,
> > +                                                 repair_bbio->fscrypt_info,
> > +                                                 repair_bbio->file_offset -
> > +                                                 repair_bbio->orig_start);
> > +
> >               btrfs_submit_bbio(repair_bbio, mirror);
> >               return;
> >       }
> >
> > -     do {
> > -             mirror = prev_repair_mirror(fbio, mirror);
> > -             btrfs_repair_io_failure(fs_info, btrfs_ino(inode),
> > -                               repair_bbio->file_offset, fs_info->sectorsize,
> > -                               logical, paddrs, step, mirror);
> > -     } while (mirror != fbio->bbio->mirror_num);
> > -
> > +     handle_repair(repair_bbio, paddrs);
> >  done:
> >       btrfs_repair_done(fbio);
> >       bio_put(&repair_bbio->bio);
>
> Does this leak the fscrypt_extent_info reference acquired at line 326?
> In repair_one_sector(), repair_bbio->fscrypt_info is set via
> fscrypt_get_extent_info(failed_bbio->fscrypt_info), but when
> btrfs_end_repair_bio() completes at the done label, it calls
> bio_put(&repair_bbio->bio) without calling
> fscrypt_put_extent_info(repair_bbio->fscrypt_info) first.

repair_one_sector() is called from btrfs_check_read_bio() which always
has (bbio a.k.a. failed_bbio)->fscrypt_info NULL. So there is no
object which could leak due to refcounting imbalance. Encrypted read
bbio passes through btrfs_check_encrypted_read_bio() instead which
does not yet implement repair.

Moreover btrfs_end_repair_bio() is called before repair_one_sector().
And when it is called btrfs_check_read_bio() returns and no
repair_one_sector() is caled at all.
The fscrypt_put_extent_info() is eventually called from
btrfs_simple_end_io() => simple_end_io_work() => btrfs_bio_end_io().
So this looks clean, unless I missed something.

> > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > index 456d32db9e9e9..7a8ff4378cba0 100644
> > --- a/fs/btrfs/bio.h
> > +++ b/fs/btrfs/bio.h
>
> [ ... ]
>
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index 5a39f707c2933..afc461d7642e4 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -562,6 +562,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
> >       cb->compress_type = btrfs_extent_map_compression(em);
> >       cb->orig_bbio = bbio;
> >       cb->bbio.csum_search_commit_root = bbio->csum_search_commit_root;
> > +     cb->bbio.fscrypt_info = fscrypt_get_extent_info(em->fscrypt_info);
> > +     cb->bbio.orig_start = 0;
> >
> >       btrfs_set_bio_crypt_ctx_from_extent(&cb->bbio.bio, inode, em->fscrypt_info, 0);
> >       btrfs_free_extent_map(em);
>
> Does this leak the fscrypt_extent_info reference in the compressed read
> path? At line 565, fscrypt_get_extent_info() acquires a reference and
> stores it in cb->bbio.fscrypt_info. Looking at end_bbio_compressed_read()
> in compression.c, it calls btrfs_bio_end_io(cb->orig_bbio, status) which
> releases the ORIGINAL bbio's fscrypt_info, but then calls bio_put(cb_bio)
> without calling fscrypt_put_extent_info(cb->bbio.fscrypt_info). The error
> path in cleanup_compressed_bio() also calls bio_put() without releasing
> the cb->bbio.fscrypt_info reference.

IIUC, the fscrypt_info is put in btrfs_bio_end_io() before calling
end_bbio_compressed_read(). So again, this looks clean to me.

--nX

> [ ... ]
>
>
