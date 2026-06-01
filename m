Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498EC198A17
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780277896; cv=pass; b=i5BaAlrg0t2d2h8Ol06wy47s2LCs9K/tYHEW0iSanOrtPvyqYyy0L4JVABhcaD9IcODtTK8ml9x8686k6zlNWnPD+k9NtsC2U+3EpGVrJjcgs/oCqmlIR41F2FIvwlWRc6lYIKHWt3pdYQnL1l+L9gjXAGUQ6NZXSqjdMi7ExgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780277896; c=relaxed/simple;
	bh=LQD3sW3zx2eBsQKW24Hy9Bk5p8ulCS0uME1hAGCpTlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tx0C3t/hlLvJyeD2URRlnm5s9gx/zxJoQRguy3WZp20EcYCAmCJA28AhY9VAqWbMA/OfbQ++a/ZPvso7pcMESHxl06tq6MT4FbTwv1lzngLfrsAXdaPNBDYman2bjC4uMS8kW0JeI46Ck9dGLuK0eXEy7IOPXbr67MCuuw1on34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDHkroL0; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDHkroL0"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa5e9a64b4so1829960e87.3
        for <linux-block@vger.kernel.org>; Sun, 31 May 2026 18:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780277893; cv=none;
        d=google.com; s=arc-20240605;
        b=exjA89YGvtNAIJrZX9uiBOyBSLtRsdPdz0r0rNf8rKP7OS3kYe7fUjAQNEkNXLIvB2
         zRRhQBouZa0y+KTtK+Z0Rmhjw5p2JThFisPoi/cj7N2Afy+dulc8G6gixLxjwzL1GfjB
         9RA3SmfxE76kEjUS5BP7BwmWYuwew/oIpfb5HKOtb6ld5jAAb1MX/slnuGL7davDCsSc
         hpla7yydndnz1FgL/ftDyPSVnVnvohlU+HETeHmld7MwdTGowq3ZCSOMszfIsVMHwg9v
         iuwTm1D/WJ8/ocVZi9ihP0hPnQtNBJEgrQpCU9ZrjkcCXF+XTBfq1pqJBNGoCZ5yfqEQ
         WJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NgYsJ4zwRmjUEPGslz88JKnXrEQneRt57PE56bneuCc=;
        fh=tbC4zMvtn5djXTeN63u9bu2fPI89qCVsoi3qvZGu7hU=;
        b=ShngBh0s1NVNh39Myv4BeZ2oi8z/Jy6T69MMxTP52s7YFx5o8sZojNeoPQre5wuMmO
         CgfppRC6iRRMMSnQZGsVQP3SNcSlYbPQ7ZfZRMcE8+sCjCbVVMYY6M6vqdiewoyKa4+S
         UoBnvhQLJrFvD74QcnwB5leX6Jn8iJbJ8mKqP84lWXXhomtWNMOY+1Vffdh5/t/VK1Xy
         X0Ja59NIWBd5qy+9NtpHnCOfaBOkr+VsJBi8MFwyJXKMTisiAInd18dmb5CabkdAkPTZ
         HK925P1EyW7Q902yoLKnSQD7sUEra5iY+Pljlvfsd2qHpfwrXNBgoN2F6mqW/E/46ZIp
         n7xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780277893; x=1780882693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgYsJ4zwRmjUEPGslz88JKnXrEQneRt57PE56bneuCc=;
        b=aDHkroL0DeLPuBlYz8Qe+2own/Px+4hhdNNJI/Z8tqBoB9m+fnQ7L3wqb+i6nNcsyo
         ngEQVUOmk2OwM/TtM9N1njnoP2FHtwaPe6u0uWlHGkkv9ppeQTPg2JB1ITUa6OLdMhrA
         AJgaNGosJiDrPG88gXbaZSdHylKoJXV3/rPAtaHJGlAmnATOQbW+GHE+mKqR0wY+uWIz
         vSRdG6f+DlNwWiAXE+f4iHFI1+vjcFbT3qhyKVA0tQnFRmEP6ii+wQDmPffvrdJ6vFe/
         v3wLzZHTJjPrHeZ9gSArmc0U38mFMZsg64lv8I8khkd3ecs60Il3troOkthXRjwi9KTZ
         mKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780277893; x=1780882693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NgYsJ4zwRmjUEPGslz88JKnXrEQneRt57PE56bneuCc=;
        b=Nf5+mmMpEQd6jmlf4s6+jmM5u0V8xeseLM+CYH6fGy3M5Tr6eVDdGl/cA8ySBi5cOP
         LIZoWqfpjTGX5sEPPL17gu8KjnVd8EvgU2JwgwsM+Uf4Fe75nxOgtdEmvM1qKBShFlMg
         JMa46/0NdttH1+hoQ+UNb4mXECqs2e8xUfAkfKWhVv7vFXBr9i9mBCgEkWQ3c4/Zzeq4
         bbVA/nSRtPgxgkIWGnNqqXm0mhDyocha0JXllP7ydLxhDiM+ihSTq2Cc/8kPBAVFi5tZ
         rThqFaw4LHOglNgNKECAcqRTthA693Kep87Vst7ANFE5TdqUPMSXDR2n/uKUqw9Xhklg
         rAiw==
X-Forwarded-Encrypted: i=1; AFNElJ/ujn+OoWbg3WvEaQERMltxpuJtA0o1x0lZTBANkMH3+19Xgq1gemXKTn+i8i7ehdgMADmURp2NxMkLwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrl8QagIy3Lx8c7B0zQL+2wBY90wB5Xqmt4wx839gYMsYMECxF
	CM3lgaGp8tjcoCBBGm8bxpEUmNZyC8d0d2ljh/nxP76LtcqcDJm4HANbfStTR0vMPWutY7DtXqt
	lCnCrTuGnQ4wWD+NqpdwuzjsCBexj2Bg=
X-Gm-Gg: Acq92OExuL0HpkqRhBZJJKvNAnRPWGOpW+jV7vZJ3/BFjZe7TpAqGunzfvt1DYPbA13
	60pzYGclGmJhHif/aXtURXJHzv5ITo4WNTjqzTzfu7IeWCdy5k1iAti3zILXTEE4YVDTftbUvxZ
	ZTqI8ZHqLqgvklefOJEZxI4ey9o3SdiW7GopQBYgKJbjrNFCnACc+xslWXSjQYV/m7JWGCNkEaR
	3nK3dOxj4bpQhCorRRgTbzrxme3jfPak5hOdru5/OhUA5EgCdw5kPgL/jzy1EraYA8YK5ZbTCeO
	qgonHghJ/cIsdK/2H8Tfs1jspj8hrqFn1NTZ407gc1vUwto=
X-Received: by 2002:a05:6512:3408:b0:5a8:6e64:a932 with SMTP id
 2adb3069b0e04-5aa6092a8b2mr2100999e87.32.1780277893226; Sun, 31 May 2026
 18:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531-zram-fix-partial-io-config-check-on-akpm-v1-1-eb085d98faea@gmail.com>
 <CAGsJ_4wB5XyUrPpg1O-pkySxo91RsHxaaUkR+Kt+heP4_OeeqA@mail.gmail.com>
 <CAJxJ_jgk8o12OYAi68JznpwKYTUJOUizp2PAZvNz2VdVGJWstw@mail.gmail.com> <ahzV6P4n2SICvh4R@MiWiFi-R3L-srv>
In-Reply-To: <ahzV6P4n2SICvh4R@MiWiFi-R3L-srv>
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Mon, 1 Jun 2026 09:38:00 +0800
X-Gm-Features: AVHnY4KBs5581g5vn-ERqwgr_hYZsffeSZxDAcGCqEpflBR6h0FqURrT08-iJQo
Message-ID: <CAJxJ_jgx7vJNNYX=Cqk_D=7Vy6=D0BOVyju+NeaCip5L2VJgJQ@mail.gmail.com>
Subject: Re: [PATCH] zram: fix partial I/O config check
To: Baoquan He <baoquan.he@linux.dev>
Cc: Barry Song <baohua@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 8:44=E2=80=AFAM Baoquan He <baoquan.he@linux.dev> wr=
ote:
>
> On 06/01/26 at 08:25am, Jianyue Wu wrote:
> > On Mon, Jun 1, 2026 at 5:38=E2=80=AFAM Barry Song <baohua@kernel.org> w=
rote:
> > > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zra=
m_drv.c
> > > > index 6e1330ce4bc1..72f89fd5572e 100644
> > > > --- a/drivers/block/zram/zram_drv.c
> > > > +++ b/drivers/block/zram/zram_drv.c
> > > > @@ -1510,7 +1510,7 @@ static int read_from_bdev(struct zram *zram, =
struct page *page, u32 index,
> > > >  {
> > > >         atomic64_inc(&zram->stats.bd_reads);
> > > >         if (!parent) {
> > > > -               if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
> > > > +               if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_ZRAM_PARTIAL_IO=
)))
> > >
> > > However, I don't see ZRAM_PARTIAL_IO defined as a Kconfig option.
> >
> > You are right. ZRAM_PARTIAL_IO is a local source-level define, not a
> > Kconfig symbol.
>
>
> How about removing ZRAM_PARTIAL_IO and use PAGE_SIZE to check?
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 07111455eecf..ca0c29482283 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -221,7 +221,6 @@ static inline bool is_partial_io(struct bio_vec *bvec=
)
>  {
>         return bvec->bv_len !=3D PAGE_SIZE;
>  }
> -#define ZRAM_PARTIAL_IO                1
>  #else
>  static inline bool is_partial_io(struct bio_vec *bvec)
>  {
> @@ -1507,7 +1506,7 @@ static int read_from_bdev(struct zram *zram, struct=
 page *page, u32 index,
>  {
>         atomic64_inc(&zram->stats.bd_reads);
>         if (!parent) {
> -               if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
> +               if (WARN_ON_ONCE(PAGE_SIZE =3D=3D 4096))
>                         return -EIO;
>                 return read_from_bdev_sync(zram, page, index, blk_idx);
>         }
>

Yes, that looks good. Thanks for the patch.
The synchronous backing-device read is only needed on PAGE_SIZE !=3D 4096
systems, where partial I/O can happen. On 4K systems is_partial_io()
always returns false, so this path should not be hit in normal operation.

Thanks,
Jianyue
