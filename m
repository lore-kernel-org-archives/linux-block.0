Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9CA14E2D1
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576891; cv=none; b=tr/NWHY0Xgx0pED6k8LXL4C/bes1eNTVC/W6Uu5GQ/t1m3IiP/7SemO8SRDNalP7zlsq05hwicowo/u9zWkTrbkJeuyOjrr1iBCFMGW5ojaPrSmyMYFIKMFPBpHCh33CpasYF55UpbLzJv4cNtQU9rzpftZ1dRdSXd3r58gdpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576891; c=relaxed/simple;
	bh=ARdW1nLVanBddtHxs4iix2dQ/l1Fl3wH3aYZAdRsz2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbkU8gGO2Zy8GnNFLvUlBZsHhzYnotRsV1HIjhVBJtcD+GwRmFsznc+FV5tLA2+vfNBu2LwoLcjRGPYQVLnFBaGgnG8H4Rr2CMSekTD1wpeR+LrtIi3jm5YOk8JPHYzqn6fFvPA5FlYaEVroxqm4xRZ1uuW+GoVrtvHzCw7VQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxXYmpZ1; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxXYmpZ1"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4d43b3fc06cso127778e0c.3
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711576889; x=1712181689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gO+uqj4tHiYPc2Cj/4Z1s2m3uA/eGOrAMfakHkQ1wK4=;
        b=bxXYmpZ1hclqw0+OD5eaf+AGRAzW6ci9V125Iafzg+jeflvWV+UPtoHbBC1Ru+hPVz
         a/nxcjlQWfqUQUy6XNHix8NXjspXAl74Uf1tTIuUHuz9enu53N7FBBUMTOQGM2Xlqeoc
         uo5i3UiN1LaZBROcnsqupduXnunZj2C9h228zB6a3h9PH0gDC8TSRJ7ALtLKm887gA0k
         xgTlB1y1nucxQXT8nqfhJ6Tf9vZRtdYPEOI23c8oxlBuRwwy4oOX6cloFUc0Rh3GzKMo
         0KO+wMKI2Pgkp181nTZdOtT9FalZctvkt+OGzFLmZ2+pExj7lI8Cz/Y+lAGw6BVjK2YX
         Jp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711576889; x=1712181689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gO+uqj4tHiYPc2Cj/4Z1s2m3uA/eGOrAMfakHkQ1wK4=;
        b=NgW7RFyoiCT3GZBr/lVDFNonNRDYUo/hyZ2V3XwbDhkmOVIhEIxN3IW/0zGxYL9+ZL
         e5y8U0b4A2JMq7SRlzTDn07pMncFHBgkHU7UfABxhlUSS941utHbhMMHlqFOrkYpXff3
         ylH8bS6LCw5BT79/ZCs6FpXPPQRjUjbo9XuCZqEsqaHrzoMjagKoQkDmh4sonzt7tmVE
         XGmGgfPsCP+jpaJmXFW2NXqRYL1t1lPbddGmvPJBjGqk+sAh4vNYOJc3un7RHdth34Vs
         rjWvuKLHH+0ZT/Ewv4hX8fQPU3r6hEv9BFYWnLFyEyLGxehiyj2+y6jA3kaxOQhw+Kng
         cGnw==
X-Forwarded-Encrypted: i=1; AJvYcCUTQ5S0Fh2Mf6VfcanqQJRpYa70vJCZGOrO791WPyIG4F3gdTcemuNIY8GqpuvAoLYrZeWdTZX9PEG65RQptBFbqExwolZ5/Z5BBLY=
X-Gm-Message-State: AOJu0YxZZUFz43V/tWsyYEeGOUPKigZrLF7ruMVxgEFV1EmKUCDMhZtU
	mPe4nxw4MPiHE851DKQCz8QgpjnGCNhxD9awQ+xy2andQBhi9OyXuJMsOUKI3tlcWvLe31K0Jxr
	7EPh3Oq9rFYpAUK52Lb26RN8PM+U=
X-Google-Smtp-Source: AGHT+IFQUvgMytKC+vWXB0qLvgdx/jtYbnMLiY8JHYX1YYZh2TVEOWzRqlYGWZwqmbRM8CltR3qZPqKWQG/t0Cfy9Vk=
X-Received: by 2002:a05:6122:4695:b0:4c9:f704:38c with SMTP id
 di21-20020a056122469500b004c9f704038cmr776608vkb.11.1711576888772; Wed, 27
 Mar 2024 15:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327214816.31191-1-21cnbao@gmail.com>
In-Reply-To: <20240327214816.31191-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 28 Mar 2024 11:01:17 +1300
Message-ID: <CAGsJ_4y6xFXXUt78VLK1o_+AEMkf=NJEXuye0dtvGvk+i6xXRw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: akpm@linux-foundation.org, minchan@kernel.org, senozhatsky@chromium.org, 
	linux-block@vger.kernel.org, axboe@kernel.dk, linux-mm@kvack.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Cc: terrelln@fb.com, chrisl@kernel.org, david@redhat.com, kasong@tencent.com, 
	yuzhao@google.com, yosryahmed@google.com, nphamcs@gmail.com, 
	willy@infradead.org, hannes@cmpxchg.org, ying.huang@intel.com, 
	surenb@google.com, wajdi.k.feghali@intel.com, kanchana.p.sridhar@intel.com, 
	corbet@lwn.net, zhouchengming@bytedance.com, 
	Barry Song <v-songbaohua@oppo.com>, =?UTF-8?B?6YOR5aCC5p2DKEJsdWVzIFpoZW5nKQ==?= <zhengtangquan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the top posting.

+Ryan, I missed adding Ryan at the last moment :-)

On Thu, Mar 28, 2024 at 10:48=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> mTHP is generally considered to potentially waste memory due to fragmenta=
tion,
> but it may also serve as a source of memory savings.
> When large folios are compressed at a larger granularity, we observe a re=
markable
> decrease in CPU utilization and a significant improvement in compression =
ratios.
>
> The following data illustrates the time and compressed data for typical a=
nonymous
> pages gathered from Android phones.
>
> granularity   orig_data_size   compr_data_size   time(us)
> 4KiB-zstd      1048576000       246876055        50259962
> 64KiB-zstd     1048576000       199763892        18330605
>
> Due to mTHP's ability to be swapped out without splitting[1] and swapped =
in as a
> whole[2], it enables compression and decompression to be performed at lar=
ger
> granularities.
>
> This patchset enhances zsmalloc and zram by introducing support for divid=
ing large
> folios into multi-pages, typically configured with a 4-order granularity.=
 Here are
> concrete examples:
>
> * If a large folio's size is 32KiB, it will still be compressed and store=
d at a 4KiB
>   granularity.
> * If a large folio's size is 64KiB, it will be compressed and stored as a=
 single 64KiB
>   block.
> * If a large folio's size is 128KiB, it will be compressed and stored as =
two 64KiB
>   multi-pages.
>
> Without the patchset, a large folio is always divided into nr_pages 4KiB =
blocks.
>
> The granularity can be configured using the ZSMALLOC_MULTI_PAGES_ORDER se=
tting.
>
> [1] https://lore.kernel.org/linux-mm/20240327144537.4165578-1-ryan.robert=
s@arm.com/
> [2] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmai=
l.com/
>
> Tangquan Zheng (2):
>   mm: zsmalloc: support objects compressed based on multiple pages
>   zram: support compression at the granularity of multi-pages
>
>  drivers/block/zram/Kconfig    |   9 +
>  drivers/block/zram/zcomp.c    |  23 ++-
>  drivers/block/zram/zcomp.h    |  12 +-
>  drivers/block/zram/zram_drv.c | 372 +++++++++++++++++++++++++++++++---
>  drivers/block/zram/zram_drv.h |  21 ++
>  include/linux/zsmalloc.h      |  10 +-
>  mm/Kconfig                    |  18 ++
>  mm/zsmalloc.c                 | 215 +++++++++++++++-----
>  8 files changed, 586 insertions(+), 94 deletions(-)
>
> --
> 2.34.1
>
