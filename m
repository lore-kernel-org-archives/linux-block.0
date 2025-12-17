Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206251E1DE5
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949635; cv=none; b=sMlCc7BBsLVPn68+x+3jNVypQj6D67S4UJ1Q+neHpSoOOBRf0Mdlk9FdCAHMrDndWscT8PGhzCNRboeozC4Urf2uGZ/jgOi9OXJT/nfFs9+gbqpzHSBwIlkWD4sK2XcW8hcO44apAJwxFpHhueMQnrHNHASQMrsYwZD9Cva7S/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949635; c=relaxed/simple;
	bh=DST+x9LPybiYdj7182pyF4xlqv6OlY0U+zBHD+N19dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGtQBtinrMMwZM04woHRFNVgcrVLllmPmum+1jGwnmTpa94SIz+8bZmdlW/yqH3190V+c4Dgsv9IzAJJZm2Xn8Jpy83Z70xk3sGQm6oSlG0E6szl7PGxeLJ3oyL0NRiU+u5cwhFNom1F95kfROebuPGVJU/Nrlt6WtbDcGVEMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XBMpvLmz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XBMpvLmz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29f08b909aeso12046365ad.2
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949631; x=1766554431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7LVKUBAzho21lrKwJ0H+Rmeeg7N0ADHqxWDdZWfz8o=;
        b=XBMpvLmzc3N2ejBfS/ULEcyr+Brt3APyZXewQY8aYSS2mfB+EvTZ3CmRpThuPxb4pQ
         aMEl9UlAoDBuEpa3hwItY8N58mlETEVC10nkbfsAgWF6hSf+HxvzV/22Fnb3PDS1MV4X
         d3FvUhFBUD2N9GA79QtTf000xG44HmfAWCzcQ+SqDcba4AWEVn8zhi3PhIh9ucJqqlZO
         PgvcR++DVeLLozGc9o+qNfwMTq42jjAByWDPwnuqTWWGfuVKbLWjIZ/7PNBQQPEvafE8
         Y5RpY/JKyzBLf7mc9bi2++4MSd3w3AWoHdLi2XbJjjR67SGWB/oneKFlXTuorxSi2H+P
         b79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949631; x=1766554431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v7LVKUBAzho21lrKwJ0H+Rmeeg7N0ADHqxWDdZWfz8o=;
        b=lH6zd1HFmdWtpD1So5S6ElE4s1nGJxJM8gusFFkhtda94KZ65ugLtc/WP+dWJTk88M
         BNwI1Y6lt6h/p1qyF9o3eTWiIACcbyloobggiFVOJe8ZgtHEIK5DcpG8NwrM7M6h9L8g
         7xoCntvnOyBfvOeiG9mPp74hBoqN1yxp9oCOHS67HKaHNvhMzJXSaM+A+qTu4EI60zTP
         TtnmTLvZuQmLoSwtrB7CFDVxOwMDZQg45PQBe0QQO4PMhSP0wAdjEG+gNo1DkR/Tajkm
         fqihb3/wY6A4yzTKg3H1caipTBbuF3KtBhdacqki4FACK2IdtvHTsXpMJQju75XvFC4p
         ADgg==
X-Forwarded-Encrypted: i=1; AJvYcCVe1TEM90cbFVuRGQxc7e+j0A/NYiYsL/yuwmxE8Fqh2Ot5CfkI5kZVovCL5ik6WBI98eR+mGk0EmOJow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEMONJnk9kBWXnEQDMzoy1FqxkABH+ayi8L5Y9xA/afpZBVZbe
	OgQDAL1UgO4A+TuoILGybmKwpjEnMxbelq+ps4OrbYZy62YLJJF0JvXKwdZkZcagHkqVq5xkPC7
	HtSDd81Z5lT+EwxHKipiFnYjJ8VYm/Z7rLBrl6+CA+Q==
X-Gm-Gg: AY/fxX5xei1uCfkpyNyd+fodzokpAP7tUX2Y7fHTvicNPh+Ft+5o8zDopxvOMKOzWnx
	m7cI1p8ubrR5zVS0UEBIvqlKSDqgJ/iURCXU2eq3v+kaciH974GyOlKciIB6h7gSQQNDHh60FN9
	CcE05QhCF8voCKcztugsDo0XTLBRvbKyKRFI02jX41CZ8LaPhXDNlYt6sVtDK2v7Jii6UHU1CpE
	AWEIKUEJVTzO/SLBT8zcN5AZAuio7sUNT4inRUtLLPCFhCxwYgJdhe/UniTeSqgitxVr2BO
X-Google-Smtp-Source: AGHT+IEDO2e4oqrAW3KoaZ1ukW3upIm3Qu+OPoDqt5lM/D4B9Ky5jAWYkF2CMxiGU1tI8V1rbcoBu7nC6Xhwn32RySQ=
X-Received: by 2002:a05:7023:885:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-11f34c51e76mr6015410c88.6.1765949631005; Tue, 16 Dec 2025
 21:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217032617.162914-1-huang-jl@deepseek.com>
In-Reply-To: <20251217032617.162914-1-huang-jl@deepseek.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 16 Dec 2025 21:33:39 -0800
X-Gm-Features: AQt7F2oB4kiWmo0uN4dzTlsGChkwPe9sM_53Gw1Zzzrq0lueRxXLRiKCrhOb1Rc
Message-ID: <CADUfDZo4Kbkodz3w-BRsSOEwTGeEQeb-yppmMNY5-ipG33B2qg@mail.gmail.com>
Subject: Re: [PATCH 01/01] io_uring: fix nr_segs calculation in io_import_kbuf
To: huang-jl <huang-jl@deepseek.com>
Cc: io-uring@vger.kernel.org, axboe@kernel.dk, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 8:02=E2=80=AFPM huang-jl <huang-jl@deepseek.com> wr=
ote:
>
> io_import_kbuf() calculates nr_segs incorrectly when iov_offset is
> non-zero after iov_iter_advance(). It doesn't account for the partial
> consumption of the first bvec.
>
> The problem comes when meet the following conditions:
> 1. Use UBLK_F_AUTO_BUF_REG feature of ublk.
> 2. The kernel will help to register the buffer, into the io uring.
> 3. Later, the ublk server try to send IO request using the registered
>    buffer in the io uring, to read/write to fuse-based filesystem, with
> O_DIRECT.
>
> From a userspace perspective, the ublk server thread is blocked in the
> kernel, and will see "soft lockup" in the kernel dmesg.
>
> When ublk registers a buffer with mixed-size bvecs like [4K]*6 + [12K]
> and a request partially consumes a bvec, the next request's nr_segs
> calculation uses bvec->bv_len instead of (bv_len - iov_offset).
>
> This causes fuse_get_user_pages() to loop forever because nr_segs
> indicates fewer pages than actually needed.
>
> Specifically, the infinite loop happens at:
> fuse_get_user_pages()
>   -> iov_iter_extract_pages()
>     -> iov_iter_extract_bvec_pages()
> Since the nr_segs is miscalculated, the iov_iter_extract_bvec_pages
> returns when finding that i->nr_segs is zero. Then
> iov_iter_extract_pages returns zero. However, fuse_get_user_pages does
> still not get enough data/pages, causing infinite loop.
>
> Example:
>   - Bvecs: [4K, 4K, 4K, 4K, 4K, 4K, 12K, ...]
>   - Request 1: 32K at offset 0, uses 6*4K + 8K of the 12K bvec
>   - Request 2: 32K at offset 32K
>     - iov_offset =3D 8K (8K already consumed from 12K bvec)
>     - Bug: calculates using 12K, not (12K - 8K) =3D 4K
>     - Result: nr_segs too small, infinite loop in fuse_get_user_pages.
>
> Fix by accounting for iov_offset when calculating the first segment's
> available length.

Please add a Fixes tag

>
> Signed-off-by: huang-jl <huang-jl@deepseek.com>
> ---
>  io_uring/rsrc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index a63474b33..4eca0c18c 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -1058,6 +1058,14 @@ static int io_import_kbuf(int ddir, struct iov_ite=
r *iter,
>
>         if (count < imu->len) {
>                 const struct bio_vec *bvec =3D iter->bvec;
> +               size_t first_seg_len =3D bvec->bv_len - iter->iov_offset;
> +
> +               if (len <=3D first_seg_len) {
> +                       iter->nr_segs =3D 1;
> +                       return 0;
> +               }
> +               len -=3D first_seg_len;
> +               bvec++;

Would a simpler fix be just to add a len +=3D iter->iov_offset before the l=
oop?

Best,
Caleb

>
>                 while (len > bvec->bv_len) {
>                         len -=3D bvec->bv_len;
> --
> 2.43.0
>
>
