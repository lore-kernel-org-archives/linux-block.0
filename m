Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E881B376E0
	for <linux-block@vger.kernel.org>; Thu, 25 Jul 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940065; cv=none; b=sfq1qp6GiY38iFOaHyeaZ96BpUxi2jgwWMmHqNxesUcEdsf489buC6e+3xvAZSpb4UkkYk9vydG+zy4UAb0ZtGaQk3OLTRzM3oauHoAb7/4GlTLCcC3kmdNeFx1CwFA6bY2YjQsyMV9YQ9KF3mMo110QiNIdpt571RuoeiEh5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940065; c=relaxed/simple;
	bh=0K1ZuBg27fCGG1YL6PCQQr5J9nm+PFHlNtTK/B6czjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpRXRlvvWeVOBc/NZtqc6f9qOixudvspEiPrZ2gPlDFW9USsy0Lyz461xojcA0i6oWzgs+dTQ6oV/irmJ6JrQsQRauYEqsPD91NEsEAa0Y+4MuW1/WKU1052Bhxm+1Z5pJ24D2M3W+heFRy7zxPE8jbmy2juBgpTcjfoApWVS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmcSLJ+i; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmcSLJ+i"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f52c326501so625102e0c.1
        for <linux-block@vger.kernel.org>; Thu, 25 Jul 2024 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721940063; x=1722544863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRm4FmtR2qmDFfNNBtVfrM3O+fun4c+DuwgUlbPMbS8=;
        b=TmcSLJ+i8KZMKIuJrQOszPYRcnHXGZw/kYoPRCzU1JFHIZfXeT1+wL4lIb9wHvFDck
         6aUb2S3XXmIc8M5utiRv/6I1H/y5dGeCMkKZ0e9UAZDKJyiC22/oV4NICisJ7brTgkH5
         3E9oUaUrnna10g+yTfPjvJK+r83WzySyXSeONanlJWDD3xf5CZjuy2nfiKYMMj6eT2j2
         3gC68v6ZZ8SoO8eP2T8vMJ5xBTuos+FZn2plFIiZy/Y2Vek/rpaUW+53vmU0SUPgE5Aa
         UGkSP5svYE+kUmLyGBrPYUtKakbdVPOFAhlwxAapDXZs+yhBBKEXRqToWMRRMASK6Hb3
         skrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721940063; x=1722544863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRm4FmtR2qmDFfNNBtVfrM3O+fun4c+DuwgUlbPMbS8=;
        b=P3QjBr2iOzbrM7kGBntB1QFF/XCuCZ8YBRN2GzdU4Rtw0w2SL+aukXfI1R5dnDN9uk
         499gHlKYzHRrlrFCF7AkHzS8A8v3ErTwSsBC1V6qNsaVWo5zE6ZKYohSJ4+e6oRbXYsP
         DOK0IHK7tVSdf/6Mdnd5K6SYWJMgIpHNJkkJoMr5tBaRk5zezPI0EkpIzkf0DRbNiUoA
         /cYSKWGmTMGw7jklpRY9+e8NXXc6dpjnZeQgUNtjwUclAAzMNwxmpohZZa55dxeDY6BP
         y8+j8gzIAu21A4LmlhQo4lyscW7Ht4YaBuRPp5I9LFejzJ7YQK6+CNIMXQ3e2oJgL2zL
         WTnw==
X-Forwarded-Encrypted: i=1; AJvYcCX+vFV9r4CoNuiy+A8eHjP5XLj0D/wm3UvHfInS52VRNNSGpjvOkkBuyEUyxWBEFdAhVCP+wUHhj/MfsU4ciy1EHx9y9I5/1pUm4BE=
X-Gm-Message-State: AOJu0YygPwcx8gIQsEW7G8VRcBwor68lzaeT0Ah9PXoFNKn2IYJ1qW2Q
	qMudJNxch3vnfUHeuBvWwSf5B8bDopade76Z/6bdKJkVLu49dG/E9BlVYLgLghzjYZM61dFsnRh
	zD6nhOfy+nTjqdQ6nClD5Btd6zRTzYz706w==
X-Google-Smtp-Source: AGHT+IF00RwQk1BW0i12hmkzBYvF+O0rjqB5B7I1uJFA7l6Gx8QmuWpR56pmXs6/SocIMOuJkknpZkShe9gOI7V82F0=
X-Received: by 2002:a05:6122:2a48:b0:4eb:499a:2453 with SMTP id
 71dfb90a1353d-4f6ca2ea87bmr3639791e0c.8.1721940062757; Thu, 25 Jul 2024
 13:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240711051543epcas5p364f770974e2367d27c685a626cc9dbb5@epcas5p3.samsung.com>
 <20240711050750.17792-1-kundan.kumar@samsung.com> <20240711050750.17792-6-kundan.kumar@samsung.com>
In-Reply-To: <20240711050750.17792-6-kundan.kumar@samsung.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 26 Jul 2024 02:10:26 +0530
Message-ID: <CACzX3AsbqdMZVR0at-oZ=pNiwXJtLY5uh0NXqw18Y4ucbh75=A@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] block: unpin user pages belonging to a folio at once
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org, 
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org, 
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 10:50=E2=80=AFAM Kundan Kumar <kundan.kumar@samsung=
.com> wrote:
>
> @@ -1215,12 +1214,9 @@ void __bio_release_pages(struct bio *bio, bool mar=
k_dirty)
>                         folio_mark_dirty(fi.folio);
>                         folio_unlock(fi.folio);
>                 }
> -               page =3D folio_page(fi.folio, fi.offset / PAGE_SIZE);
>                 nr_pages =3D (fi.offset + fi.length - 1) / PAGE_SIZE -
>                            fi.offset / PAGE_SIZE + 1;
> -               do {
> -                       bio_release_page(bio, page++);
> -               } while (--nr_pages !=3D 0);
> +               bio_release_folio(bio, fi.folio, nr_pages);
Wouldn't it be better to use unpin_user_folio (introduced in the previous
patch) here, rather than using bio_release_folio.

>         }
>  }
>  EXPORT_SYMBOL_GPL(__bio_release_pages);
> diff --git a/block/blk.h b/block/blk.h
> index 777e1486f0de..8e266f0ace2b 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -558,6 +558,12 @@ static inline void bio_release_page(struct bio *bio,=
 struct page *page)
>                 unpin_user_page(page);
>  }
>
> +static inline void bio_release_folio(struct bio *bio, struct folio *foli=
o,
> +                                    unsigned long npages)
> +{
> +       unpin_user_folio(folio, npages);
> +}
> +
This function takes bio as a parameter but doesn't really use it. Also if
we use unpin_user_folio at the previous place, we wouldn't really need to
introduce this function.
.
>  struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node=
_id);
>
>  int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
> --
> 2.25.1
>
>
Could you give this series a respin against the latest for-next, some patch=
es
don't apply cleanly now.
--
Anuj Gupta
