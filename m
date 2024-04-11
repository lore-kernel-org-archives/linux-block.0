Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AA56217D
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712801041; cv=none; b=eKfanHs54jSirUPz/69E/Kr3U+3dBDhm53hEDxeSpR+a1yo9YUzkzeuiI5K4Ix3f96JcHrXWU3kiq3wewNt9+agvyExLZ6DKxRK8xZsCIHZ+w8/e3hd2yVCcgwW6hs022TNWn7KeUP8wt3Xka/4IGzSJvs7jycLGVRqFz3aSAeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712801041; c=relaxed/simple;
	bh=NnyUnYyTHr2sMYJQ2tM3Jzf7K0rEcDWlU2CKQRhTZa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaTHODaJEqgf2RTcyR8pBzW9fV27QyQsDT1b7CSsV7ioutdOC3goZQC63XSpfEYhJBlIPhmN9vRaRXHIu2BmLRw5/vM7KroKCK76MJUjtRGXpsiAvB4HkdlGdveoxDpyXYQ3tE1Fdqs9Q6Y/5uwFsh7qO8gmYtKm+XaltBGQCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr8RogW3; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr8RogW3"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7e328cd8e04so2989482241.0
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712801038; x=1713405838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9SFCjfw8oIFA8MLTpiWyALkIoIxQkZEh4iCJuRNDWY=;
        b=Mr8RogW3ZTQNXw7YAqjjyBE8/dQff0ru7VLNJJKIFLrTialmE1A1wu2ybvIRTd9OyD
         N1ibP3+2w6Nh1QT0pRPeMVPYj3f2X6OdTTYAeoFoG2C7x5fLE8ALJmcLuoLW42F2Xqoc
         dBES9ZHpPSH9J2kgeoU12XIZbuo3YRFdwxKMqPtY8ALmmJtP7qfdpGPptOHwQw2tQL4J
         cSWwt40Vx4wSbVPFrhXHT9GMSA1M0FhB7YxsfJIOEkp+6VGalfCHL+mKLTDrxEBuLYhe
         /dyoL8/f+Rr1nKVL4p4x7cXpneOcE8xv1D0Jk10zB9NxVeC8/7PLI//QNDwFPupHAMHy
         XS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712801038; x=1713405838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9SFCjfw8oIFA8MLTpiWyALkIoIxQkZEh4iCJuRNDWY=;
        b=DFmBb25qBvV16B2bndQtDcUu2L8xhXF9igYjubpHzdeUAsjsDADJjibUzOruB4OOuz
         mPSisKJ4t+/z7Dk6Fb+dxl0+NwDStRahA0LQYyekbEuN9W+etMfeT6qOL7y5RTde3vJ1
         iMoQYVvBnzvhZcX9x1KBPCwQE87JpPKZfhd1Mb9Fw51wfVEcBgC5Xj4Wt/X8zP7IqfJD
         8JUqM6UHY6OkR12CUCYnSkLdlLliE4giKifeaZgl9KslxTBzfIAJWrWnDnQyHUExldhr
         yGcSlfZ/rNxaw5vrWnOSDHe+KKP/UKzRk7iAM892ow/N7XQHtriDTePfRDvJFFDl8lvj
         Bp+g==
X-Forwarded-Encrypted: i=1; AJvYcCURuILys2QauQsNOO7riCpYQiwjMG+7/PZ/xEsYUF3UZhbxxE6zN/8nW2eQO7xakeQY+/Ci3UwMEOzT6HU4ZEfMbF+XruAPQZtaAC4=
X-Gm-Message-State: AOJu0YzcAER5oDJyoUpxjH6ax37V4rvyszUPPaSRRsPuYZJQVQmNc6Fb
	Q08HgyaXREkIGW8vX9ovp3f8eTA73aGzDtTf4+aAqjrAXhdm3iElHMN+Df+j8UUMKJGez0OuG7Z
	KIoDgcOTgfQdVMCzn/qUo/IL5yDc=
X-Google-Smtp-Source: AGHT+IGs5YjDMuq3uxEYMciqHhp2xdo7YnYO7u6J3RNNTSpRFbyqvTQmvevpZPzlTLzugoKJcWQ2qbLLKJCBkXD7WNU=
X-Received: by 2002:a05:6122:308e:b0:4d4:17c5:8605 with SMTP id
 cd14-20020a056122308e00b004d417c58605mr5106379vkb.7.1712801038248; Wed, 10
 Apr 2024 19:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327214816.31191-1-21cnbao@gmail.com> <20240327214816.31191-3-21cnbao@gmail.com>
 <20240411014237.GB8743@google.com>
In-Reply-To: <20240411014237.GB8743@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 11 Apr 2024 14:03:46 +1200
Message-ID: <CAGsJ_4yKjfr1kgFKufM68yJoTysgT_gri4Dbg-aghj70F0Zf0Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] zram: support compression at the granularity of multi-pages
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, linux-block@vger.kernel.org, 
	axboe@kernel.dk, linux-mm@kvack.org, terrelln@fb.com, chrisl@kernel.org, 
	david@redhat.com, kasong@tencent.com, yuzhao@google.com, 
	yosryahmed@google.com, nphamcs@gmail.com, willy@infradead.org, 
	hannes@cmpxchg.org, ying.huang@intel.com, surenb@google.com, 
	wajdi.k.feghali@intel.com, kanchana.p.sridhar@intel.com, corbet@lwn.net, 
	zhouchengming@bytedance.com, Tangquan Zheng <zhengtangquan@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:42=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/03/28 10:48), Barry Song wrote:
> [..]
> > +/*
> > + * Use a temporary buffer to decompress the page, as the decompressor
> > + * always expects a full page for the output.
> > + */
> > +static int zram_bvec_read_multi_pages_partial(struct zram *zram, struc=
t bio_vec *bvec,
> > +                               u32 index, int offset)
> > +{
> > +     struct page *page =3D alloc_pages(GFP_NOIO | __GFP_COMP, ZCOMP_MU=
LTI_PAGES_ORDER);
> > +     int ret;
> > +
> > +     if (!page)
> > +             return -ENOMEM;
> > +     ret =3D zram_read_multi_pages(zram, page, index, NULL);
> > +     if (likely(!ret)) {
> > +             atomic64_inc(&zram->stats.zram_bio_read_multi_pages_parti=
al_count);
> > +             void *dst =3D kmap_local_page(bvec->bv_page);
> > +             void *src =3D kmap_local_page(page);
> > +
> > +             memcpy(dst + bvec->bv_offset, src + offset, bvec->bv_len)=
;
> > +             kunmap_local(src);
> > +             kunmap_local(dst);
> > +     }
> > +     __free_pages(page, ZCOMP_MULTI_PAGES_ORDER);
> > +     return ret;
> > +}
>
> [..]
>
> > +static int zram_bvec_write_multi_pages_partial(struct zram *zram, stru=
ct bio_vec *bvec,
> > +                                u32 index, int offset, struct bio *bio=
)
> > +{
> > +     struct page *page =3D alloc_pages(GFP_NOIO | __GFP_COMP, ZCOMP_MU=
LTI_PAGES_ORDER);
> > +     int ret;
> > +     void *src, *dst;
> > +
> > +     if (!page)
> > +             return -ENOMEM;
> > +
> > +     ret =3D zram_read_multi_pages(zram, page, index, bio);
> > +     if (!ret) {
> > +             src =3D kmap_local_page(bvec->bv_page);
> > +             dst =3D kmap_local_page(page);
> > +             memcpy(dst + offset, src + bvec->bv_offset, bvec->bv_len)=
;
> > +             kunmap_local(dst);
> > +             kunmap_local(src);
> > +
> > +             atomic64_inc(&zram->stats.zram_bio_write_multi_pages_part=
ial_count);
> > +             ret =3D zram_write_page(zram, page, index);
> > +     }
> > +     __free_pages(page, ZCOMP_MULTI_PAGES_ORDER);
> > +     return ret;
> > +}
>
> What type of testing you run on it? How often do you see partial
> reads and writes? Because this looks concerning - zsmalloc memory
> usage reduction is one metrics, but this also can be achieved via
> recompression, writeback, or even a different compression algorithm,
> but higher CPU/power usage/higher requirements for physically contig
> pages cannot be offset easily. (Another corner case, assume we have
> partial read requests on every CPU simultaneously.)

This question brings up an interesting observation. In our actual product,
we've noticed a success rate of over 90% when allocating large folios in
do_swap_page, but occasionally, we encounter failures. In such cases,
instead of resorting to partial reads, we opt to allocate 16 small folios a=
nd
request zram to fill them all. This strategy effectively minimizes partial =
reads
to nearly zero. However, integrating this into the upstream codebase seems
like a considerable task, and for now, it remains part of our
out-of-tree code[1],
which is also open-source.
We're gradually sending patches for the swap-in process, systematically
cleaning up the product's code.

To enhance the success rate of large folio allocation, we've reserved some
page blocks for mTHP. This approach is currently absent from the mainline
codebase as well (Yu Zhao is trying to provide TAO [2]). Consequently, we
anticipate that partial reads may reach 50% or more until this method is
incorporated upstream.

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplu=
s/sm8550_u_14.0.0_oneplus11
[2] https://lore.kernel.org/linux-mm/20240229183436.4110845-1-yuzhao@google=
.com/

Thanks
Barry
