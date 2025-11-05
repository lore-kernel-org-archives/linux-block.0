Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E972E541F
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362656; cv=none; b=dg+R9gf59vduBAa4OXty1pA8RuYK5FdrZYqNPAYlxfOSj33MEtpu2gWI+ONNBYR5Mzo0E3K/LzWPLFuyt6E5O3y5wfkTda7t5s0x4ISc5AzxkzKIIEjo3N6i/lWpSi50J6b/DiNQZ2f9aGNz8T5BsYEM8KOWnGYf5ecY0ZLIXrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362656; c=relaxed/simple;
	bh=qPV/w09JCjV/Ft5bIc3c+0VCoh2wOPiQ/KzXMdID1Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8bQyTlyhxBUsocNQ88h4gFEtkQ7AMqU0Jl12m+SdLpI+8R7e54TD5r3uqTu5y6mLL4MhX4/G14MdxTSsokyH5R8Zl7Ed1XosOuBPM5VFV6qbGQ66KpzgqICCt6g7pFOVKyz5jwRM2ePob4JpFXiE40hBebAlmHssm3Mg463nWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=T7/enu3R; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="T7/enu3R"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2951e58fa43so66415ad.1
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 09:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762362654; x=1762967454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8r8YRNzKuw0NkQeMuXs0kLpJhnGNfTo6Ot2ZhZ9K18=;
        b=T7/enu3R4im8rmF90zghFw4LEp/Dea1TyT3wkQvNCx2YAt1cdP8myy1KZ+5YSMyMln
         DkINrkkaKH8v1n5OxSetc31fzAkAxDHN7PzkgXJzllDB/1YQMPwj268SLHvfBiJWYZAn
         SSzxVLY8njmfw0sGS5QJjZ3Dp2/DlOyhl/xCLhWlLir7kz8UsHmL2wshFW2IlxvOM9Wi
         hgZsiWj4EGIG1ZHs3zvVfF+V5Kp4g6ysXKrw1eiFIIWtIeWxzK/fBr8yYIfN40cumBKz
         k9nTmSVchhGB/EcD49iUGr6KViUO6MNqZrKUtH7HkCfAT+uUpAUxk7q8mYFP3sylIzgC
         xBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362654; x=1762967454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8r8YRNzKuw0NkQeMuXs0kLpJhnGNfTo6Ot2ZhZ9K18=;
        b=mV0YOF+V7LLCb6MP3mQfTKpMUS3SBJHDKIITQBgfZVIc3uM24HwJxGwzVlZ4wYzSa3
         pPKMf3fPV4p2i0t14Dl3lY6qLfYE8omdyvUuH7kqM49nzWcaLslOIBsIIEEcpQLZ34qV
         SzS8Ee8dAokSUubyvmKNtsUa/rXqmf+pavRaWoenpOx03lKhREDLcGQVXIEsVRcOUeFu
         HVv4b2YrRbm5Dpffg6P03GWaev9LooXaRO2AUlpuOKTocZpXCno4vXcSdIxDWxCLtXvc
         L2xpX3wa2xjpHfNSB2E06w9rx3kzzgMCUbcVq0yeg7F7TBOKR4a59XbATP7Ppdlxi8eQ
         2gmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmAVvdfKgObi+qVE/T/LWa08PGxcvddhY+p4lDR3Q0GOzQ8bRQ6HDAdJuFMCLWjm+Q78bjqiZ04ixkfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqoWZgU8mE8RBzrZ+kcK43YrpVgZTTI6iW3kc5qwpchQNvGcZA
	Jpdpoac0nnRf7NUyme8UO2k7i97D3S3pzDkKn6WYvV1u5sUPa9mwh4c3Nm3xPPvfismT+lp9B7y
	Hi43TK8cWb9MeRMkeJgSLbOPbpvmrosTQvKTfFz978A==
X-Gm-Gg: ASbGncudu9Mp4PQqLEsfi+OTOmnQSOPYXnTCKKh0WwGfPGHtN+RMHXFlMeRUbd9sWPa
	Fc2oCzfNa7VDWaftXQK+MhstJMcZRS6XsueV3DG3O8siGkl+EfC8tyXj3nLULbf6+dhLcSuG2cL
	R5aAzoY59kelEIMdjbEOXvUzMNiU0gPPTVEgtdpT5YBFwESH5qntn7mv2B61cfyHESaEcbVaLsZ
	Q9Wp6fF3HHFh9s6lCgN7gI/yXQK7SQrXLLyQvR+DE/zUpFYRGptpGzxqu+lw/u8dqOJ61JBBl71
	e2a6izk2RQeqbTZnjs6r/KsC3q467Q==
X-Google-Smtp-Source: AGHT+IGoV/ylZSfFpRLhYc41dJLjjRkryt9A/HzTATgyvmsLaQip5/uWX977HiMeTccKVtdjo/ZyXIa60Rr2YwoecCs=
X-Received: by 2002:a17:902:daca:b0:290:c3a9:42b5 with SMTP id
 d9443c01a7336-2962adee35emr27729075ad.5.1762362653695; Wed, 05 Nov 2025
 09:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031010522.3509499-1-csander@purestorage.com>
 <aQQwy7l_OCzG430i@fedora> <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
 <aQVAVBGM7inQUa7z@fedora> <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
 <CADUfDZpb7QTTS6A6SV7zQVfG--Oke71Nqb5xBR2m65SoZczcTw@mail.gmail.com>
In-Reply-To: <CADUfDZpb7QTTS6A6SV7zQVfG--Oke71Nqb5xBR2m65SoZczcTw@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 5 Nov 2025 09:10:41 -0800
X-Gm-Features: AWmQ_bl8O6C7Hx2hop8_9BOT3UY_EgJ7nbDUZhf7rrBgOfPIPmhv1Uwab9jXVY4
Message-ID: <CADUfDZp+j+85zNiMvi0qDatzHqoDx2x8Ch48TLiF7umsCRSMuw@mail.gmail.com>
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:16=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Nov 3, 2025 at 8:40=E2=80=AFAM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Fri, Oct 31, 2025 at 4:04=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Fri, Oct 31, 2025 at 09:02:48AM -0700, Caleb Sander Mateos wrote:
> > > > On Thu, Oct 30, 2025 at 8:45=E2=80=AFPM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wro=
te:
> > > > > > ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> > > > > > iov_iter_get_pages2() to extract the pages from the iov_iter an=
d
> > > > > > memcpy()s between the bvec_iter and the iov_iter's pages one at=
 a time.
> > > > > > Switch to using copy_to_iter()/copy_from_iter() instead. This a=
voids the
> > > > > > user page reference count increments and decrements and needing=
 to split
> > > > > > the memcpy() at user page boundaries. It also simplifies the co=
de
> > > > > > considerably.
> > > > > >
> > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > > ---
> > > > > >  drivers/block/ublk_drv.c | 62 +++++++++-----------------------=
--------
> > > > > >  1 file changed, 14 insertions(+), 48 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.=
c
> > > > > > index 0c74a41a6753..852350e639d6 100644
> > > > > > --- a/drivers/block/ublk_drv.c
> > > > > > +++ b/drivers/block/ublk_drv.c
> > > > > > @@ -912,58 +912,47 @@ static const struct block_device_operatio=
ns ub_fops =3D {
> > > > > >       .open =3D         ublk_open,
> > > > > >       .free_disk =3D    ublk_free_disk,
> > > > > >       .report_zones =3D ublk_report_zones,
> > > > > >  };
> > > > > >
> > > > > > -#define UBLK_MAX_PIN_PAGES   32
> > > > > > -
> > > > > >  struct ublk_io_iter {
> > > > > > -     struct page *pages[UBLK_MAX_PIN_PAGES];
> > > > > >       struct bio *bio;
> > > > > >       struct bvec_iter iter;
> > > > > >  };
> > > > >
> > > > > ->pages[] is actually for pinning user io pages in batch, so kill=
ing it may cause
> > > > > perf drop.
> > > >
> > > > As far as I can tell, copy_to_iter()/copy_from_iter() avoids the pa=
ge
> > > > pinning entirely. It calls copy_to_user_iter() for each contiguous
> > > > user address range:
> > > >
> > > > size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_ite=
r *i)
> > > > {
> > > >         if (WARN_ON_ONCE(i->data_source))
> > > >                 return 0;
> > > >         if (user_backed_iter(i))
> > > >                 might_fault();
> > > >         return iterate_and_advance(i, bytes, (void *)addr,
> > > >                                    copy_to_user_iter, memcpy_to_ite=
r);
> > > > }
> > > >
> > > > Which just checks that the address range doesn't include any kernel
> > > > addresses and then memcpy()s directly via the userspace virtual
> > > > addresses:
> > > >
> > > > static __always_inline
> > > > size_t copy_to_user_iter(void __user *iter_to, size_t progress,
> > > >                          size_t len, void *from, void *priv2)
> > > > {
> > > >         if (should_fail_usercopy())
> > > >                 return len;
> > > >         if (access_ok(iter_to, len)) {
> > > >                 from +=3D progress;
> > > >                 instrument_copy_to_user(iter_to, from, len);
> > > >                 len =3D raw_copy_to_user(iter_to, from, len);
> > > >         }
> > > >         return len;
> > > > }
> > > >
> > > > static __always_inline __must_check unsigned long
> > > > raw_copy_to_user(void __user *dst, const void *src, unsigned long s=
ize)
> > > > {
> > > >         return copy_user_generic((__force void *)dst, src, size);
> > > > }
> > > >
> > > > static __always_inline __must_check unsigned long
> > > > copy_user_generic(void *to, const void *from, unsigned long len)
> > > > {
> > > >         stac();
> > > >         /*
> > > >          * If CPU has FSRM feature, use 'rep movs'.
> > > >          * Otherwise, use rep_movs_alternative.
> > > >          */
> > > >         asm volatile(
> > > >                 "1:\n\t"
> > > >                 ALTERNATIVE("rep movsb",
> > > >                             "call rep_movs_alternative",
> > > > ALT_NOT(X86_FEATURE_FSRM))
> > > >                 "2:\n"
> > > >                 _ASM_EXTABLE_UA(1b, 2b)
> > > >                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONST=
RAINT
> > > >                 : : "memory", "rax");
> > > >         clac();
> > > >         return len;
> > > > }
> > > >
> > > > Am I missing something?
> > >
> > > page is allocated & mapped in page fault handler.
> >
> > Right, physical pages certainly need to be allocated for the virtual
> > address range being copied to/from. But that would have happened
> > previously in iov_iter_get_pages2(), so this isn't a new cost. And as
> > you point out, in the common case that the virtual pages are already
> > mapped to physical pages, the copy won't cause any page faults.
> >
> > >
> > > However, in typical cases, pages in io buffer shouldn't be swapped ou=
t
> > > frequently, so this cleanup may be good, I will run some perf test.
> >
> > Thanks for testing.
> >
> > >
> > > Also copy_page_from_iter()/copy_page_to_iter() can be used for avoidi=
ng
> > > bvec_kmap_local(), and the two helper can handle one whole bvec inste=
ad
> > > of single page.
> >
> > Yes, that's a good idea. Thanks, I didn't know about that.
>
> Looking into this further, copy_page_{to,from}_iter() doesn't seem
> like an improvement. It still uses kmap_local_page() +
> copy_{to,from}_iter() + kunmap_local() internally, and it splits the
> copy at page boundaries instead of copying the whole bvec at once. I
> don't think it's worth switching just to hide the bvec_kmap_local() +
> kunmap_local() calls.

Maybe that's because bvec_kmap_local() only maps the first page of the
bvec even if it spans multiple pages? Seems like it may be an existing
bug that ublk_copy_io_pages() can copy past the end of the page
returned from bvec_kmap_local(). But given that kmap_local_page() is a
no-op when CONFIG_HIGHMEM is disabled, it's probably not visible in
typical configurations.

Best,
Caleb
