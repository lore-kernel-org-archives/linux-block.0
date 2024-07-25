Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4AB13BAE2
	for <linux-block@vger.kernel.org>; Thu, 25 Jul 2024 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941037; cv=none; b=P8gwRn1/EHis3om6ALDNy403/113z6mo0mc1kD9tLU/5OxDY3VMWLgjiE+z4RZoVMfhufDT3kZNB0kB90ZKwED2i0+asvnAX5QfVL3FXxYkU7nRtUUSRiNsXHpnZby5j+UGxN3tcap4yBTYCBbQ1NJoEUnT39v/QYmfSQifS5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941037; c=relaxed/simple;
	bh=bdpORFrr/DDIn+Ww2/tGhBGeukDjwNsZ2ACcvoouJrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftMsAWHsYgi3iOTzAi0HbY4lxWfxTQONj0ib9g1nxarH+fiidghgHyyeTz9oMOrFhGwqy4VsWZ0xTmsRSn3veJY76oBIw84TvhFv/MEFz49vdVlo2mrWFp9TX7K/UXUbqeDObNg3WdToSJ/1TF9s54SN0lY2Q7zgDBi7cINebFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfWpeuVJ; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfWpeuVJ"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f52c326501so632733e0c.1
        for <linux-block@vger.kernel.org>; Thu, 25 Jul 2024 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721941035; x=1722545835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1Q4yA6necd9y2m0c1fJhCDV0Qk2/UQtnszg/rmCl30=;
        b=FfWpeuVJM6vdhHa27q3WeLQgvaVMb4Siz++uxNXnDjL1SE1g1q5BuqN5R8EPkLWJBx
         6SwMiy805VX3TnpWzPlJ4xC/wcf4iFp9q/v7Uhig4mjxbNnph20nkcbzhlJmyAU9RytJ
         0jAebOaC6uBOMi+DT2/tA3SKZaFtoIJaEb6VOHRsj+7J/iQGpgIKtZCEEjYSoYuROGbg
         tTHZJsun00oWuodp6K19PEdfYSOBCI5njcKO7BiUxRO+gNVanyU5qSqKnTD656leykIb
         FOvmiUOFAc5ePUQf/NRHerig6iZPdjw3llbsY9iKGzq0FpayiJiEEF3My1yJ19I8fTG/
         tkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721941035; x=1722545835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1Q4yA6necd9y2m0c1fJhCDV0Qk2/UQtnszg/rmCl30=;
        b=MnAotV1fLWDr9UnMKRQzKyx3TosnoRJK79q3aiiuCrKaibi9QV1GjJ/Xvk46L+R3H9
         2J0RlDiMFnr9Hzl2G/IpcmBOQ2HCzfhTNHKEcLNnVd0cHPm1rLsvtZlTrebCWjACKKkU
         aqYOkeZV4wURlFvPlKEK4FGG5ecZbzDzW3Opoo999JQVs5q0k+mSEDuyIt/4dWj1xHsn
         wEecyjVCwTXNkB4c+TNDHOmDc+LKpT7Qx9kfb8/VvfS62pz0USZh93vXeK8TnR+27ibL
         xlWM21bvkdn2DE+9E+cCDYfrgju3Vtn1Za1AlVWalgnWKXYmNmaP3kDsIItxSwp4uwS1
         hKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGbi3nJ+oXXOP/ZqJHFtiSgArtU4kc7YDeMpfxiEDbROY5YkVGlb/MWfciTupZo3cT3sRXQ6CHUomVdVEuXGhfdXdphdckFNFZ6CE=
X-Gm-Message-State: AOJu0YyPUGGR6zMybfCqAJVHVu2p9nYYBHS9GpdbFIsoNZJ8q69F/HcB
	QvpQpl60Fe12oy7R7iA4ybOCQ5BpfAx/p4nTzCxOOFmq15ms1WHs7dvw1ytNFcXfolt/lRKNTT9
	+9mo2dP4RDXvYB9bWUcL+1cXP+tMOXzFGvQ==
X-Google-Smtp-Source: AGHT+IENjaAMYg/ky5Wptxrd/e98cHVrx60KJhNForQy8pSXlDCcWoHAyg6eibTkIUeO8e4TczweT+QdHxMx7+Rxmso=
X-Received: by 2002:a05:6122:1d03:b0:4f6:b478:767c with SMTP id
 71dfb90a1353d-4f6ca2c72dcmr3441933e0c.6.1721941034696; Thu, 25 Jul 2024
 13:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240711051536epcas5p369e005a83fb16d9f6d9636585cc66e3b@epcas5p3.samsung.com>
 <20240711050750.17792-1-kundan.kumar@samsung.com> <20240711050750.17792-4-kundan.kumar@samsung.com>
In-Reply-To: <20240711050750.17792-4-kundan.kumar@samsung.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 26 Jul 2024 02:26:37 +0530
Message-ID: <CACzX3Av4jgwraGXWqQoZKCFkmOk-A7owTEXkZFgyxCa4GzOHWg@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] block: introduce folio awareness and add a bigger
 size from folio
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
> Using a helper function check if pages are contiguous and belong to same
> folio, this is done as a COW may happen and change contiguous mapping of
> pages of folio.
>
You can consider removing this part in the commit description, as the same
comment is present below in the code as well.

>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct p=
age *))
>
>  /**
> @@ -1298,9 +1329,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
>         unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
>         struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
>         struct page **pages =3D (struct page **)bv;
> -       ssize_t size, left;
> -       unsigned len, i =3D 0;
> -       size_t offset;
> +       ssize_t size;
> +       unsigned int i =3D 0, num_pages;
> +       size_t offset, folio_offset, left, len;
>         int ret =3D 0;
>
>         /*
> @@ -1342,15 +1373,29 @@ static int __bio_iov_iter_get_pages(struct bio *b=
io, struct iov_iter *iter)
>
>         for (left =3D size, i =3D 0; left > 0; left -=3D len, i++) {
Can we do a i+=3Dnum_pages here, given that you are incrementing i by 1 her=
e
and by (num_pages-1) at the end of the loop. This way you can get rid of
the increment that you are doing at the end of the loop.

>                 struct page *page =3D pages[i];
> +               struct folio *folio =3D page_folio(page);
> +
> +               folio_offset =3D ((size_t)folio_page_idx(folio, page) <<
> +                               PAGE_SHIFT) + offset;
> +
> +               len =3D min_t(size_t, (folio_size(folio) - folio_offset),=
 left);
> +
> +               num_pages =3D DIV_ROUND_UP(offset + len, PAGE_SIZE);
> +
> +               if (num_pages > 1)
> +                       len =3D get_contig_folio_len(&num_pages, pages, i=
,
> +                                                  folio, left, offset);
>
> -               len =3D min_t(size_t, PAGE_SIZE - offset, left);
>                 if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
> -                       ret =3D bio_iov_add_zone_append_page(bio, page, l=
en,
> -                                       offset);
> +                       ret =3D bio_iov_add_zone_append_folio(bio, folio,=
 len,
> +                                       folio_offset);
>                         if (ret)
>                                 break;
>                 } else
> -                       bio_iov_add_page(bio, page, len, offset);
> +                       bio_iov_add_folio(bio, folio, len, folio_offset);
> +
> +               /* Skip the pages which got added */
> +               i =3D i + (num_pages - 1);
>
>                 offset =3D 0;
>         }
> --
> 2.25.1
>
--
Anuj Gupta
