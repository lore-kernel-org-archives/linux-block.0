Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F1D1DFE30
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975132; cv=none; b=ZcLPbU88pvy3O5+vPhdlcbiK079YKT7ead6uBG8ETWcSWgv5Fov3kYxz4Na5UvcSm5ldOmQnqBlT7zRHqJfDb1nHgSIlVnogxKMrDgSCWO14/IQboVhJhnrcfLVDKlxhwWcOr62lfJxQVP8dKYU9zGnncXsv2ESAanDtawD/y5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975132; c=relaxed/simple;
	bh=dKndKrspftKV3VngkRplVJDYwIdyVTMop7NnigkuVvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDycRQocnPt7y5nRcUtCUC3xxu1E6xbyoXyoc64Xydi/hQY84awZyeGtu0HlOEPpcEewkkjtfGpV5ZyYkV+tXuD9UY3w7vahIawIVagSVkTqAtUe70/CyLv/FKTOF3XgC5chVuEA7wlGeeEXQA7u7FeT0+t8XINV7A61nVwxbsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpyevKXg; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpyevKXg"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84fc7b58d4dso318424241.0
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 02:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730975130; x=1731579930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ccQ0JGMmaRz0ISvLwVvpBELeQXDyDw0Yq7aAtCpTuE=;
        b=UpyevKXgUU2b2gz0abdPS0/PAOQFmCgsdA0VvOfUbywwye3U7Z4M5S2pg9h/oA7+Ka
         w4AS0EjR8N5TcOjSIfS4MwcveSndZXeE2CUIiPQXUrnjYro8HtZtXpA066VbUWpspsLQ
         1w1E3awV6j/ovFFZoiVxDrs7/QvEHlB0s85v4Fj//QUmSynaqSodKX1v+o/6nusC3rFt
         gwywlYjpa02qlYSC3jOM35MgY8WJuAjZDOe0aMYO7jQvYjk3FHSXK2BYoqHs21tJKdgh
         v+M5vAQV75ueMiUioVbCTNU5hTSUMx1U3QFjGD+ttoZEQm3LJouzzBtn2sl2JDAQYvl0
         syEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975130; x=1731579930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ccQ0JGMmaRz0ISvLwVvpBELeQXDyDw0Yq7aAtCpTuE=;
        b=LYTF1WK8Kosl8zSDg5iYflXkQ6Ed6k1Sh2CHc2MkQnr3kNv53cwqqgCDTmx7rTnQCN
         rhTMU6+ocEUAEbWtWwKZFHo9KlfYxbEzi8vlcrNr4vyLoLlTZLg5nG9BYJ0dgHQBx4xd
         ImDuAR6Tib6cis5LEpQn0jMCn8DcnMPXYV5cJ4ZqnKDd15tbqxwhfiuo91N/UuIqneJR
         C99pylMyQG5McqlnodAW+iagKngDPA/D63jJxA6I2JxY81/Aw2BYTUllRvYkCgXmwNYa
         CY65Wj/SLXlAVTJUj7t/XDpqOBQHTnH8IP8RnVweEG6eGTqntpV6yQD/CpOjwNozX6wn
         Ntow==
X-Forwarded-Encrypted: i=1; AJvYcCX88lAcvsPa5zyHEj4qhkMOqHojI+ar63uni3rrqMEVSzhN3EN0088kecYah+EgtoXNr/4CMOqEaQAlJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkubD/BRRnofQYpqXfFz0limYbrJEOhbSetahMoL+PMIyJOaRG
	wGJ5hDq3TlEZr4yDp0rSM0/QaZLuz5MiK+QZSGtgyV3HxZhQdFI3vWroiuP8uhAlouv7JHuSkgn
	XdqXiKkG9ZvjY+Ux/SG0GGlGE0qg=
X-Google-Smtp-Source: AGHT+IHXK9nQ9QtWcoKL6O6kNc6crcuq/kVTfgAMJ5oBd7mzsQSHHnIINf8SoFEiOfTqM7iDoA4H0nwzBGX/oWz+iIo=
X-Received: by 2002:a05:6102:1609:b0:4a4:8651:3c46 with SMTP id
 ada2fe7eead31-4aada3ab046mr476016137.18.1730975129947; Thu, 07 Nov 2024
 02:25:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327214816.31191-3-21cnbao@gmail.com> <20241021232852.4061-1-21cnbao@gmail.com>
 <eabf4f2c-4192-42d5-b6cc-f36a3c7ad0f2@gmail.com>
In-Reply-To: <eabf4f2c-4192-42d5-b6cc-f36a3c7ad0f2@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 7 Nov 2024 23:25:18 +1300
Message-ID: <CAGsJ_4w0f_eqHvmAr59FRNCsydjc2EQu4eHhSGFvurJn=TuvJA@mail.gmail.com>
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

On Thu, Nov 7, 2024 at 5:23=E2=80=AFAM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
>
>
> On 22/10/2024 00:28, Barry Song wrote:
> >> From: Tangquan Zheng <zhengtangquan@oppo.com>
> >>
> >> +static int zram_bvec_write_multi_pages(struct zram *zram, struct bio_=
vec *bvec,
> >> +                       u32 index, int offset, struct bio *bio)
> >> +{
> >> +    if (is_multi_pages_partial_io(bvec))
> >> +            return zram_bvec_write_multi_pages_partial(zram, bvec, in=
dex, offset, bio);
> >> +    return zram_write_page(zram, bvec->bv_page, index);
> >> +}
> >> +
>
> Hi Barry,
>
> I started reviewing this series just to get a better idea if we can do so=
mething
> similar for zswap. I haven't looked at zram code before so this might be =
a basic
> question:
> How would you end up in zram_bvec_write_multi_pages_partial if using zram=
 for swap?

Hi Usama,

There=E2=80=99s a corner case where, for instance, a 32KiB mTHP is swapped
out. Then, if userspace
performs a MADV_DONTNEED on the 0~16KiB portion of this original mTHP,
it now consists
of 8 swap entries(mTHP has been released and unmapped). With
swap0-swap3 released
due to DONTNEED, they become available for reallocation, and other
folios may be swapped
out to those entries. Then it is a combination of the new smaller
folios with the original 32KiB
mTHP.

>
> We only swapout whole folios. If ZCOMP_MULTI_PAGES_SIZE=3D64K, any folio =
smaller
> than 64K will end up in zram_bio_write_page. Folios greater than or equal=
 to 64K
> would be dispatched by zram_bio_write_multi_pages to zram_bvec_write_mult=
i_pages
> in 64K chunks. So for e.g. 128K folio would end up calling zram_bvec_writ=
e_multi_pages
> twice.

In v2, I changed the default order to 2, allowing all anonymous mTHP
to benefit from this
feature.

>
> Or is this for the case when you are using zram not for swap? In that cas=
e, I probably
> dont need to consider zram_bvec_write_multi_pages_partial write case for =
zswap.
>
> Thanks,
> Usama

Thanks
barry
