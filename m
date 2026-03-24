Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FFB3DC4D9
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345022; cv=pass; b=etxtx/uFOds5b+I3Z9XiAT+QZdftfYgAUijjwD4eWHHPP4SwmImzCsybpJYbFvrC8WX+dryvqJeoiLMG63NoYqgnSxDSHFHZp4GrWF6fgX2ox2XuTBOC7WUwWutaJfAVBhOnePf/PgfdoVuhjelWH/s3WSscS4jcVS//bcLG+38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345022; c=relaxed/simple;
	bh=JV481TRX/Dx8xXrjNX9tltXZwt52q0seBxFVj0eKdEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9G5EI4++jGNi3eLQ50lMZW6AIjORqASM5oNdbeC+doU8Gd5XyYh/DgzdGlYIPkTSUlr4e3G9sI5juBcxv4TPGsy8gd9cqKxSqa963bxqUvdXTspvD5VtNQvxF1xbM5ZW5v8u4eCvL60wcMNWNubV0hS84CHeBhmZyhZbr5FAa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LR/xx7SI; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LR/xx7SI"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so1139189f8f.1
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 02:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774345017; cv=none;
        d=google.com; s=arc-20240605;
        b=LjyxEE4Gy5ePauWOWPvOmdOpviyUEkwYtadz3t0NROhte/3cLFK+t6AT7eHHdl6KiS
         k601bjkxsZl5pblKsmADKvPZPLOxR3tj42oXUIOU1/jkHP80WG49QYMC+ML29huQPZX7
         3kVg8Ge3iVGVASKj4Yfjnj3WZrNsEgr+Q2mjYMjp4xwFBL5dlWxLpZnsIN82q9RkUU6f
         T3sWGXTeN18+QxnPCumNXDOhuxPVoAOugwnmodDX0QFiTXyO57LMcxas0aXg6f3vtHC/
         itX00pEJqixIkOeTWQSf9O8r2LBCPCGvD6rRxXOSIFKYPuYjVyJyQdeo1FnyY507mkw7
         Xmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ub5wN9amaO/DAAvFXES2RrEzabJn769sowl2xsPaADQ=;
        fh=2pjpW8y8063Y/yDZ3LJlQZqSfjq5Wt5FEkRC9kUMN20=;
        b=jsrGqH+ZrKdmEWP8NKQCWyd2fWSzT08okBh/qjpylIV9HO3ueBWf6Ax8q72dFL70p1
         hHYY1+FUoXfYrNPujuBLPyZBdi1WYVDsjBXqf6BtXonehrhSi+AWUmjXwacADMvQDi5z
         h4+yPSJlMVY5JfRtkaUIQMICazcfY2PH46LgfT6dlzr0yIysf+MeH68yWDdRKcYSaEvx
         S12cX1z0TuAo8QDOkD/RccqYckTTg1Bz1AmvTrrsKo3NSpqGyPuVzu7D7e+PeBE4AaMp
         mldbdgKyIoSG5xFZYM2lr898+MUTs+ckDdmfDnPMCm9LKaTrLLpsfrqRG/tb1MH/s9Ao
         +QZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774345017; x=1774949817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ub5wN9amaO/DAAvFXES2RrEzabJn769sowl2xsPaADQ=;
        b=LR/xx7SI5kncamtwfDMCZsdLzL9v2Vv+1wsvvSda4nYW33Dgt20Mwkq1nG278aI1h3
         QfOJpdmD6BSzA3Oqrr3lvmc3YSishR6XKUjKNqErydpJB/08lKKtkRrR7fjOn+K20yA0
         f2mEuXbkDWSUeT+FDPsVFKUMP73alN7cNy8NHTMcCLqsrGqwrl6mvm8vZbYK+o4a/+wM
         pZF8CyL72yj0UlFTqcGIoq4aj2alY/7p46cWd+QrxCNXGrZjAoJ5kZDzZ94RZEocUmOM
         Qx86u2UQbXXm6eYKnp6FD9sf2RK4r9xew6NLUI2bkBgA5jHBRygvDTuFNmq4DGnlVjIy
         eCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774345017; x=1774949817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub5wN9amaO/DAAvFXES2RrEzabJn769sowl2xsPaADQ=;
        b=mAVC9QB8ci4zIeBOQHP7ckyeZ+C/l+oMOzKhBE5vrmv7FbMuS2OK+UKmnFrZ/0OTAc
         Yz/7eZxqCyNsKpY809A+hJx5EMXyMSLSlZcNLXDU/oDvuHqujo8hH1EwNZJSzFlVeisn
         YKHY4GwU0SP6pCjfFpltop3miz4sD9PNBLJfNMnUymwuOi1xlqMMCBpEQlNQDhGv+upH
         TsjIX+uERS/EdSxJ7BSdbiqIVheEzvYi7TYCE46ZpOEY0E2kIlRvOjIdc2Za+9gytjgE
         yhH+jsDIL/0jhzvcjfx7s57Z9CGL+p2DsPCfNYXz4/SO6fSd+BnGpDZnIqkA/HpcnDa0
         cExQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRCQRJNTQ9/glxD+XMJ+yzTWZSqmdUWcGasnQsSXkOCXYiWzzZzgkRWVFCNHrMHTlgx+9TRE33Lkgw9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+TwvUflSiAXEkJ5+LGrTNCW6Zu03Kc5ax1ySGPnLleoI9OJF
	ufZoLL143GEeVgZhzSBKrXAM/izFZgC7lCpRF8QpcUjhAbTiuacFE/8x9Qxy8RnN3TB8EOG9B9+
	P+XnpsAtbyvCeicdFD8VT/3aPzkRbBWzvlC10hZXZoA==
X-Gm-Gg: ATEYQzydHZjjz+pyp73P69NPuWSzRdXkADpcBg+SrJZLihMxoTHXR8D9fjBRH8RSStD
	9TmpMf1mmlfqaFOm+xNdj3qrCqKRQiaPTiM5kciBnig2fhM/6w2Mpek2XnSa8l13pHojQQbAP6z
	74m9OV0Sj5d80xSOldpXsvU1/com7YnWd1pxz6BSOykEHJv2u1VtDLXkwImUeDnONQ4E6tG2369
	ZPfahHBXJRyitEPHF16P4W1Z7x2RxhYJatnFMFDK2QBmCWHRKD8BPLHpiP/J7BRaq06o1PsK00+
	4M7Cxn63+MQpyo6WIiT2OEVBcv414hLVscguPuGFGciVh2eMG5fn0JVpkTA4+k8082j5FDUBjU2
	KsXE6
X-Received: by 2002:a05:6000:22c2:b0:43b:3caa:a20e with SMTP id
 ffacd0b85a97d-43b6426b68emr24185879f8f.32.1774345017497; Tue, 24 Mar 2026
 02:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-33-neelx@suse.com>
 <20260208151126.3129410-1-clm@meta.com>
In-Reply-To: <20260208151126.3129410-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 24 Mar 2026 10:36:46 +0100
X-Gm-Features: AQROBzAcrSb8NLZh900STza2vyMCNtV9c0i8E1h6tC3jXGjIJZj-4KJUOFxGeHU
Message-ID: <CAPjX3FchHbyQMUqogjyf4tUpT49HnO==_E6Uj=Zz7BXYUhJvsg@mail.gmail.com>
Subject: Re: [PATCH v6 32/43] btrfs: implement process_bio cb for fscrypt
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 16:12, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > We are going to be checksumming the encrypted data, so we have to
> > implement the ->process_bio fscrypt callback.  This will provide us with
> > the original bio and the encrypted bio to do work on.  For WRITE's this
> > will happen after the encrypted bio has been encrypted.  For READ's this
> > will happen after the read has completed and before the decryption step
> > is done.
> >
> > For write's this is straightforward, we can just pass in the encrypted
> > bio to btrfs_csum_one_bio and then the csums will be added to the bbio
> > as normal.
> >
> > For read's this is relatively straightforward, but requires some care.
> > We assume (because that's how it works currently) that the encrypted bio
> > match the original bio, this is important because we save the iter of
> > the bio before we submit.  If this changes in the future we'll need a
> > hook to give us the bi_iter of the decryption bio before it's submitted.
> > We check the csums before decryption.  If it doesn't match we simply
> > error out and we let the normal path handle the repair work.
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
> commit 2b25418669e46c939ff864b1144e2c27d618920c
> Author: Josef Bacik <josef@toxicpanda.com>
>
> btrfs: implement process_bio cb for fscrypt
>
> This commit implements the ->process_bio fscrypt callback for btrfs,
> enabling checksum verification of encrypted data before decryption and
> checksum generation after encryption.
>
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index 3b420866f3b82..c28f3f53bad28 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
> > @@ -300,6 +300,34 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
> >       return fbio;
> >  }
> >
> > +blk_status_t btrfs_check_encrypted_read_bio(struct btrfs_bio *bbio, struct bio *enc_bio)
> > +{
> > +     struct btrfs_inode *inode = bbio->inode;
> > +     struct btrfs_fs_info *fs_info = inode->root->fs_info;
> > +     struct bvec_iter iter = bbio->saved_iter;
> > +     struct btrfs_device *dev = bbio->bio.bi_private;
> > +     const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
> > +     const u32 nr_steps = iter.bi_size / step;
> > +     phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
>
> Can paddrs[] overflow here? BTRFS_MAX_BLOCKSIZE is 64KB, so the array
> has 16 elements (64KB / 4KB). However, nr_steps is calculated from
> iter.bi_size which can be much larger than 64KB for merged bios.
>
> If a bio has bi_size > 64KB, the loop below will write beyond the array
> bounds when filling paddrs[slot].

Indeed, that's very true and I can easily reproduce it.

> > +     phys_addr_t paddr;
> > +     unsigned int slot = 0;
> > +
> > +     /*
> > +      * We have to use a copy of iter in case there's an error,
> > +      * btrfs_check_read_bio will handle submitting the repair bios.
> > +      */
> > +     btrfs_bio_for_each_block(paddr, enc_bio, &iter, step) {
> > +             ASSERT(slot < nr_steps);
> > +             paddrs[slot] = paddr;
> > +             slot++;
> > +     }
> > +     if (!btrfs_data_csum_ok(bbio, dev, 0, paddrs))
>
> Does this verify checksums for all sectors in the bio? Looking at
> btrfs_data_csum_ok() in inode.c, it verifies one sector's worth of data
> (one blocksize). The function is called with bio_offset=0, meaning it
> only checksums the first sector.
>
> However, the bio can contain multiple sectors (iter.bi_size could be
> much larger than one sectorsize). If the bio has multiple sectors,
> shouldn't this call btrfs_data_csum_ok() for each sector, or pass the
> actual bio size so all sectors are verified?
>
> The existing btrfs_check_read_bio() function loops through all sectors
> and verifies each one individually.

This is also correct. Both points fixed this way:

--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -343,11 +343,13 @@ blk_status_t
btrfs_check_encrypted_read_bio(struct btrfs_bio *bbio, struct bio *
     struct btrfs_fs_info *fs_info = inode->root->fs_info;
     struct bvec_iter iter = bbio->saved_iter;
     struct btrfs_device *dev = bbio->bio.bi_private;
-    const u32 step = min(fs_info->sectorsize, PAGE_SIZE);
+    const u32 blocksize = fs_info->sectorsize;
+    const u32 step = min(blocksize, PAGE_SIZE);
     const u32 nr_steps = iter.bi_size / step;
     phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
     phys_addr_t paddr;
     unsigned int slot = 0;
+    u32 offset = 0;

     /*
      * We have to use a copy of iter in case there's an error,
@@ -357,9 +359,13 @@ blk_status_t
btrfs_check_encrypted_read_bio(struct btrfs_bio *bbio, struct bio *
         ASSERT(slot < nr_steps);
         paddrs[slot] = paddr;
         slot++;
+        offset += step;
+        if (IS_ALIGNED(offset, blocksize)) {
+            if (!btrfs_data_csum_ok(bbio, dev, offset - blocksize, paddrs))
+                return BLK_STS_IOERR;
+            slot = 0;
+        }
     }
-    if (!btrfs_data_csum_ok(bbio, dev, 0, paddrs))
-            return BLK_STS_IOERR;

     /*
      * Read repair is slightly different for encrypted bio's.  This

Thanks!

--nX


> > +                     return BLK_STS_IOERR;
> > +
> > +     bbio->csum_ok = true;
> > +     return BLK_STS_OK;
> > +}
>
> [ ... ]
>
>
