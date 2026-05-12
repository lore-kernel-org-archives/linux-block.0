Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4F20ED
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613675; cv=pass; b=uTulmthmWkdcgJwtqqfs6mmA8wB5B2tPPfD24KsJZiXTmAs/5Al/3SOTTuWfL+i/07OrcGkCqYuafH6IAzGu0ezgxKOtoBHBUMlZ6HLvrvz0E2kQ1Yt0FGcyIOjea5zM5gg/EZK4rPKFzLr7bNQFZ5gmCWkO2+6VDxl0XqW3uI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613675; c=relaxed/simple;
	bh=nll91ULm6w2aHk9Z18ZnaI6Kevm+cuOw6+VQhhfKLeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpfF6AQynnfKolePJm5ISZOUMTaH0IV7rfasAzRDBfxXrj6HRS0JmXX1m8OjKSEfMx8tqeiUZN+GvYjfM0Si0kzpSvhY5Yil9fiQWnOhAoHUdDVNHUa5VrWgvEt69UZC6sdGfmPk2jMig3sNJ/X3IksEbuDlfGF4i78lBjFKhv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W4HnrVJK; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W4HnrVJK"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69491071fc6so418809eaf.2
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 12:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778613673; cv=none;
        d=google.com; s=arc-20240605;
        b=ISmQhEgkfhEcFosnn7VyMAD3IcWuvB7ZGl0cNro5kl3iWrClSpGSiJBVZuuDpf4q2A
         Ppy74BZmJdSstkxV/sprFDqC6yjUZB+ekNNYp72mHWU/exgZ6ovXettAy5GpJwkqtXSq
         0+IAchQhzqxoDuxu8y2o73MTsoDadPwDhmE3aydfudaGzqFYEFGcDmRRLp7W17WrAWkw
         HXEs9nmLzl38tHPRxNgC91hPhUVdGeqKqhP0eFYZJrWnZF2COt0Ic1qQY6EqasRh8sM8
         w5u71yxhHfZv4Bwjw/jDJjn7ymd9redxlSYKgcAVXhCAhdWnAZ0TJoXzdZ97UY7ERX+T
         XOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nO3qnWfhbRxzX+PzpSpdWAjHeYnC8LurbOKJOZKk+Lg=;
        fh=7U+fd9HPELE/UyCQ/Ax98vyT4PEUmwuCHESd7fvfdFw=;
        b=MONlB2LPEJojphnmW+ko0p8QKJlFyGiT1xOeud1C+ldbvHwpBEfhdGguNVXdO8Tffz
         uoHM2FcAwKNWU1nM7XzSZvzCSkVkn1LKDA7S+N3S7FZ1bxam9IizV007QYWyDlar8ATe
         L28VcNuSn/gTWgbtM7kXfUGAw4t71UlvjUVVj+jKEYGz8dMDLBS9s3s8+eL4sKJ6/wnb
         fsenZsUo56lwqTkbT6Gi3ixKdOrZhvoA/HsM6+3H6d1xgFw8C9FetHkU0k2T5y2j8l7K
         2zsuD824KR+ljtF5WFN1SsqWOrb6SisWoLCCZgdjrGxsXjQIpxgxuXw4GGv0xYTu2jun
         +npg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778613673; x=1779218473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO3qnWfhbRxzX+PzpSpdWAjHeYnC8LurbOKJOZKk+Lg=;
        b=W4HnrVJKCyu4I17/DkGo2/lcuHGcx2K4xJeeHUcDkBp71WiAhIhH6SlSJNNLhMcYNs
         JhZZZLajy9pexHsnycEMKlPTtAiCO8qQo40AVelIpf12hbBTLGZtjgr59jdicq6pL3MG
         gkthr01U20Lwve6ZM0mKyEgXxdO9Sp72XLlhss54KRfpFFbMBQ4r4E0E1AwB95g3docw
         zaLn0hXN6Hktfbj/RVg2NP/U26KdZlQk2rcYKus2RbdMkir2X3LLK1T1iNOofFpwlcg3
         Xo46vGFXAeibumYie/Rvq/nD9GbwGNcQWh9r8gS7RcgGSkuZSI3Pwt6kTCLukU1bZcbo
         okZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613673; x=1779218473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nO3qnWfhbRxzX+PzpSpdWAjHeYnC8LurbOKJOZKk+Lg=;
        b=OwTF9QUYNU6mxoiWUghwjtmP4Ty7IosWu1kqfEGoEVWMmlqodgWGi9Dyi0Mjg+iUt4
         x28uWQUWe1IvB/ONODdVtFkO2W8vWb2AubC/SnhVStiIvR6xftnIPrNH5qh5xvrHZilB
         tA32dn5bWlUvZhm5PQjkuK3xBCWGa/snMnmvSfNJ/Ozik7jkdTFTwPi2agCcyPaT+poZ
         qzmlvTS8IaF/8rquoDIXswusjRg1F9AmoF4cXcQJYZyx8kQkcaaED21BY/pzC4+Z75Hk
         rzoc19ZsMwWDCcjnzx3pfVKumP+Oxrze9yPMNMmYacVcdQcfEOjRR5yx6YPXqpYQ7NT7
         djrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Fh+sNbIgGSgQw9hB8ak+Db0ilk4akKMcStAJ6r2Mf+TyKlB9w5OAua/Vg9viF02hNLLQXUzrfIE0fqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lM98gPVev+Q6HuRWumkiAohgIijBK4kC0zDc1OBe7JHUHpZ5
	jTQqExU6QzFP8M3JZEwDtE2etwkG13hxRF67hxjf0ceb+NXHOxlwNR9UA1RJNEa2gDDym4sjxzE
	TkP+ZzdxuTuN0pSNV/o05TgNyQNe6b58PAo7DY+vzDwXNa7Z/1PqO3vQtOQ==
X-Gm-Gg: Acq92OHDRkn66Q/5bvPjFVkRKWBtTUXOPcFIu5S9vDibrnmCu4r9zUSa1zJXzQrpghV
	ghUgSDB/aEnfD5kQKVR6pCme47f2uiFgox942Q8swvJtCmpWLyS7hyMTLfy3io0AOXb4fhGmt2R
	x1E8c0NhaJd6mjrLqBeaCvFW1Ad8yzKXGaZfD9Ti+fAx9zIEt6m+ACj1/C9OnUfuzbiHwuJgEU3
	9M9THaIAVX8W/OUYyy8/bPl0WlY64RFmNhzUGgnjByorpR/vRNrlS+f4qUVvRwmerVLI/PKWqnA
	xN5xY5ABp+KWfsUGTKA=
X-Received: by 2002:a05:6820:55d2:10b0:694:8ed2:9bbf with SMTP id
 006d021491bc7-69b78d98e1fmr26675eaf.2.1778613673210; Tue, 12 May 2026
 12:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512170525.357573-1-dmantipov@yandex.ru> <CADUfDZqnV5BRwZq3c3Atu8w3gOm87AbmtexL=MenWcSbTVOgvw@mail.gmail.com>
 <26c1f22358ca894945dbfb8b7b6376a8a59229c7.camel@yandex.ru>
In-Reply-To: <26c1f22358ca894945dbfb8b7b6376a8a59229c7.camel@yandex.ru>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 12 May 2026 12:20:59 -0700
X-Gm-Features: AVHnY4KR8wr161beKIFztTVzYdNB9ClF9w_gJXdqgle_01-EMcDGH2azbqJmguw
Message-ID: <CADUfDZrmXfHFV3k=m0+0Jmpd3dtx=pmsEefwkAunQt1JbQnG0g@mail.gmail.com>
Subject: Re: [PATCH v2] lib: free pagelist on error in iov_iter_extract_pages()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, 
	Sungwoo Kim <iam@sung-woo.kim>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 11:45=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> On Tue, 2026-05-12 at 10:46 -0700, Caleb Sander Mateos wrote:
>
> > The mismatch between ret <=3D 0 here and ret < 0 in
> > bio_integrity_map_user() would result in a use-after-free in the ret
> > =3D=3D 0 case, no? I guess this should be fixed by the "block:
> > bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()" patch
> > that landed today.
>
> Not sure about null-ptr-deref but IIUC this patch fixes memory leak
> at [2] but not at [1]:

Yes, and I think your patch would fix the leak of pages in the ret < 0
case. With both patches, ret =3D=3D 0 would result in calls to
kvfree(pages) from both iov_iter_extract_pages() and
bio_integrity_map_user(), but the value of pages in
bio_integrity_map_user() should stay as NULL, so the second call
should be a no-op.

>
>         ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs,
>                                         extraction_flags, &offset);
>         if (unlikely(ret < 0))
>                 goto free_bvec;                                 [1]
>
>         /*
>          * Handle partial pinning. This can happen when pin_user_pages_fa=
st()
>          * returns fewer pages than requested.
>          */
>         if (user_backed_iter(iter) && unlikely(ret !=3D bytes)) {
>                 if (ret > 0) {
>                         int npinned =3D DIV_ROUND_UP(offset + ret, PAGE_S=
IZE);
>                         int i;
>
>                         for (i =3D 0; i < npinned; i++)
>                                 unpin_user_page(pages[i]);
>                 }
>                 if (pages !=3D stack_pages)
>                         kvfree(pages);                          [2]
>                 ret =3D -EFAULT;
>                 goto free_bvec;
>         }
>
> Dmitry
