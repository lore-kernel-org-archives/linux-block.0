Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE780603
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975491; cv=none; b=hfNsOVTsVWKjTZIPrxlb0OUrQM8V41WbBHVeXGTWIxk7NTkuwgDG94jC+kyPVBDYCC/biDHP0flvqLWgTwWP4S6gnELi0K5juHq0uY4Z6fBYBSC5+/jgafdixvtBnvjB3YCcAxPUSw1SBa6EqbR327geGcfhUA54uzKzCppdqo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975491; c=relaxed/simple;
	bh=RNNQDvbm+hol1uICW/enZLqUVsODFb+0O75GfweatQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpFPTji1YIKxlxWapsTs61b+qv/KkmIOSYC3Vg6coMbpXYU5XrVBIgMHWuoOsRZaoSSyYGgv4gPcPMuC3A39pv+tPJtKRJVp0NeVRaR9BkpvYjQw/dqGWV0GXY3YB1vFedgmaEFxLrKx8asLEOlxb6XrXuYemNiqPxk4Hie00PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJz17b5r; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJz17b5r"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-851d2a36e6dso1528424241.0
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 02:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730975489; x=1731580289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Dyvdn7v6d2yb2MZ3QqXkCPigg64Kr5P4VoPbiykLqU=;
        b=ZJz17b5rhA1oH9ImO+1YHyYm5QdDTJ27fRsZhULLA/KdWgeEAhiKwH4tffKjcOrAk6
         HM8tXCm22SxgqK4gWteOXzbr6+NfFqGE6xkRgixUXz1adA1d5/B1R2jezwXC5ti+XAd2
         2eRy35ONO2VZRiNZzD+qINnu0xNYCoxUiF7rVzXBoFljAkoYBQr0jbSxZnYmZfEiimPC
         j5UykKIcSrOO/MzXJt2cg8sIb/J+7rhAFpGpiLOaXrwf2tajzEoeo6h4c7wfl0ih9pjg
         z7ra0CCoim1z6pWhOm6hJWOybefHtUkdzsaaSFsspoY8q51ptcWTsTYMKyVmAHwx+uV6
         EK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975489; x=1731580289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Dyvdn7v6d2yb2MZ3QqXkCPigg64Kr5P4VoPbiykLqU=;
        b=HXQFnq/jK3EXbSOkNSi6vSzplXE5CxLtJvxPWPCIc84t825TDZ+38btYZ8UzHOLrdO
         N28N30W7UnsvkiD2A0+BVp9/SsYUsspnmMqOIrOngrWzN66rhjNbGhjnolz0BSOT0bKE
         Zrf97fWx1rxDKgbWW6NV+w+L706iiMTN5hhdLaJM9v7CL0v2DB3mI3oiRFFd8ypOk2R6
         sK4DHfhSo3676amg5cCjv1Pu+osRc9LWIyb71KHD3Nf2h9Td7C8VUziIOsUUWewthnwH
         wrLIMVWWjeKx+/jQLr3o76zJS5tfnldmewAaHmMFM/wIVqAvLTJEEsep/xhf+IR5c+/D
         7ltw==
X-Forwarded-Encrypted: i=1; AJvYcCWmNSX8ybhlY75EKsOqNMgM2/wyT47mgxtpCDfBA8mui3H+Hiif6Cm5V6CGlN0M7kw3+ZvhM4uB01z34g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEEXUJ+0SPKTmjuwpDdUBNRtAcTkDv3KdQ7DJiRYGQLFT9bQa
	pI4BaiQ8NZN7E69Z4lpdQ2W9AfRM8QxyilbqtFnQ8SEexatbs/P31HKCKT9wGSrX8bvLdIlL2hG
	JCuks2t7BSJqCK9lQeVKvQ2+0q9g=
X-Google-Smtp-Source: AGHT+IHXxHgQoO0T1ANwNe77Lg1V1lKG8mCpZrsgd8dhpfSaj1b+fp5W7LT2yYIqTxTcfQ32fnCI1QjD5Er7neBJuFE=
X-Received: by 2002:a05:6102:d8c:b0:4a4:8a3a:4539 with SMTP id
 ada2fe7eead31-4aada7cd05dmr155741137.8.1730975488561; Thu, 07 Nov 2024
 02:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327214816.31191-3-21cnbao@gmail.com> <20241021232852.4061-1-21cnbao@gmail.com>
 <eabf4f2c-4192-42d5-b6cc-f36a3c7ad0f2@gmail.com> <CAGsJ_4w0f_eqHvmAr59FRNCsydjc2EQu4eHhSGFvurJn=TuvJA@mail.gmail.com>
In-Reply-To: <CAGsJ_4w0f_eqHvmAr59FRNCsydjc2EQu4eHhSGFvurJn=TuvJA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 7 Nov 2024 23:31:17 +1300
Message-ID: <CAGsJ_4yrsCSyZpjtv7+bKN3TuLFaQ86v_zx9HtNQKtVhve0zDA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] zram: support compression at the granularity of multi-pages
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, chrisl@kernel.org, 
	corbet@lwn.net, david@redhat.com, kanchana.p.sridhar@intel.com, 
	kasong@tencent.com, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	minchan@kernel.org, nphamcs@gmail.com, senozhatsky@chromium.org, 
	surenb@google.com, terrelln@fb.com, v-songbaohua@oppo.com, 
	wajdi.k.feghali@intel.com, willy@infradead.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, zhengtangquan@oppo.com, 
	zhouchengming@bytedance.com, bala.seshasayee@linux.intel.com, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:25=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Nov 7, 2024 at 5:23=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
> >
> >
> >
> > On 22/10/2024 00:28, Barry Song wrote:
> > >> From: Tangquan Zheng <zhengtangquan@oppo.com>
> > >>
> > >> +static int zram_bvec_write_multi_pages(struct zram *zram, struct bi=
o_vec *bvec,
> > >> +                       u32 index, int offset, struct bio *bio)
> > >> +{
> > >> +    if (is_multi_pages_partial_io(bvec))
> > >> +            return zram_bvec_write_multi_pages_partial(zram, bvec, =
index, offset, bio);
> > >> +    return zram_write_page(zram, bvec->bv_page, index);
> > >> +}
> > >> +
> >
> > Hi Barry,
> >
> > I started reviewing this series just to get a better idea if we can do =
something
> > similar for zswap. I haven't looked at zram code before so this might b=
e a basic
> > question:
> > How would you end up in zram_bvec_write_multi_pages_partial if using zr=
am for swap?
>
> Hi Usama,
>
> There=E2=80=99s a corner case where, for instance, a 32KiB mTHP is swappe=
d
> out. Then, if userspace
> performs a MADV_DONTNEED on the 0~16KiB portion of this original mTHP,
> it now consists
> of 8 swap entries(mTHP has been released and unmapped). With
> swap0-swap3 released
> due to DONTNEED, they become available for reallocation, and other
> folios may be swapped
> out to those entries. Then it is a combination of the new smaller
> folios with the original 32KiB
> mTHP.

Sorry, I forgot to mention that the assumption is ZSMALLOC_MULTI_PAGES_ORDE=
R=3D3,
so data is compressed in 32KiB blocks.

With Chris' and Kairui's new swap optimization, this should be minor,
as each cluster has
its own order. However, I recall that order-0 can still steal swap
slots from other orders'
clusters when swap space is limited by scanning all slots? Please
correct me if I'm
wrong, Kairui and Chris.

>
> >
> > We only swapout whole folios. If ZCOMP_MULTI_PAGES_SIZE=3D64K, any foli=
o smaller
> > than 64K will end up in zram_bio_write_page. Folios greater than or equ=
al to 64K
> > would be dispatched by zram_bio_write_multi_pages to zram_bvec_write_mu=
lti_pages
> > in 64K chunks. So for e.g. 128K folio would end up calling zram_bvec_wr=
ite_multi_pages
> > twice.
>
> In v2, I changed the default order to 2, allowing all anonymous mTHP
> to benefit from this
> feature.
>
> >
> > Or is this for the case when you are using zram not for swap? In that c=
ase, I probably
> > dont need to consider zram_bvec_write_multi_pages_partial write case fo=
r zswap.
> >
> > Thanks,
> > Usama
>

Thanks
barry
