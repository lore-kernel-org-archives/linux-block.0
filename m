Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7130BBBC
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627816; cv=pass; b=AIzkeiK47zmXFxOs8I0tR/uCddXTWNDNL/vNLQtPGcD2Om4JBI8d1jjO2ynnwri0qexiPCkSb9MoT4wLI5s+gjHtHbixHw6B7fU5y1BhLpac95veCPzo3ClukzJoF+9hgMtyqSQLHPUA3XiIN2PILA2Z09axdQ+x9n36VYLJNk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627816; c=relaxed/simple;
	bh=brJlS+ev6IVoIeUgg0ezbYtFVtT61zmnhRsDBv+Ue8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTJiU1px/LeBNXtQDWB0D9VQYAoOaZHj25mPgNRZYBCDGUqSIadLXczK5Z8WSn6w/aDr63wFb96ZuE+LRow1WwmHSn1QJ9V5Rs4XteKhXHcnt82nZZCFMgz322B7b6/8AvTsDaTOCk4j2uLLxgx0UWoFVfhcXlyoy/fl1ZpF1h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnlajM6D; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnlajM6D"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-509062d829dso706631cf.1
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 19:23:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773627814; cv=none;
        d=google.com; s=arc-20240605;
        b=kwc0SMuo/vfDtS6xr8huGRRNsn+oxTn1U98p8Cvkj5jVv9Vb4rT8eTKHdWEjy0reS2
         +Q9z/MtQcq5Y7iGtJxo9QQm4ppHeZWhzRSRd3k/mD810+7lk7NGaFZ4FK+VY2i/CN9We
         ye6fVEblPsnb3O/7zWpo+/skRvuKb6tqvCslgQZGyyGqTBliT86xCSlFqGUAJPTwRWQZ
         EZ8b5WaaltqReno6lu6qcIhoLwuAAQYefM14vhWSZEE46Mj2hs5cYEwlACIQAKRmSM3l
         dKtXs0cJ3pHdVgS4n9xSvPHa07zKtF7M4/RqrGBA+zxUgFKtCTsSvGl5v3hKg7/BMDxK
         WLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sL9D+UNbJ7e4W6K6buLxChN3rfm9QdJVzjRxuDMxvi8=;
        fh=/kMfBSQMXmHgP6u6AVe2c9oKvvnIEpXxLrzverG2fQs=;
        b=GHe4m4W/PxqUm+aOrypa1dNGb31fJckGqDb2uQRcLJQi9oXo6NiLX7HXmAC3s8iAkX
         NEF/oXNdvLE72Ns91scilb8qSTMos5wirK71ZmwaFgWAX5QXfjsNakP3tZn6D/4iCAkM
         OrDOaE/wkToLKpw1GTtrOAYMKN1J6GAtNmIYgap2KRCNK+uvK8gvLdKggBxTZaxlEX2I
         TL7yz+K5saM2o6DztvTzytCcrT8RsUO18MJwDf0DYWuFSYenvgQQF9yLpjAQuGoyVhrf
         MlnpQ7KV9OgEAT+4XW5byPBJjsOwiuCm8JdZxiNIf3ALpIvqSHLLwIFFCkvrDJd++C4C
         AkuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773627814; x=1774232614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL9D+UNbJ7e4W6K6buLxChN3rfm9QdJVzjRxuDMxvi8=;
        b=EnlajM6Dft8s83JnEdAG0SLAX2gXWIKLbxhi3bqKL5fcEwOhh3xbKO8JY6Ocmuj9bY
         /fSjg7vyS6bYZmL8pG1qVnfaNyeMhZksiFAf2WflTihSfVfzSt84EDzT1xXhkduw+dnz
         fH9qE1Z+11viHxDTOkOBLtkUX5/rar81i43PTD8O+wkblaGi4Px1u1yxPSoq6XksB2ee
         1UH16zMeEZLNW8gtwhEFLJm7RtFf81IPNOW0ofAsDjNaWVWjgjT4qAlym51ARDrH4rZX
         ZRlkLBE8peJfkq7F0GNjI6LfZG0cO0Oj3Z+OmCyRVKQHfep8pHejdQOt4LqiJfUXA8U1
         tReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627814; x=1774232614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sL9D+UNbJ7e4W6K6buLxChN3rfm9QdJVzjRxuDMxvi8=;
        b=b7B3gnCCGqVJ2KNCBEFnscvMPHJQbxDrsOitNCCJIBOj+WKcpgAwNC6sEf2kSqLn4J
         U0lD/MKa27QS6MW8W7woIVpfSFQLt/3oNFbOd1LVpywqP2t5pM6RT0agi9FYDSn/UjaB
         0ieqbTWkIuNGxa716YTiP5EBiEkWtX0v8ka9rxXmm5hu+KuFXLt6OM6QPpAstW7fDRic
         nMYA2Y7ru1nRgsOeKz2eWZKTC6v+NBpY2NFcgaOKQkmoyXS6gHGABxy3J6cMC3M6XOnH
         X//gDaIlkrvCV2jDAGHKt0+seLWKa2Vp76mX9zDrnBTmK2mMQs9nM0biBG7WRwlQvcyQ
         CgPg==
X-Forwarded-Encrypted: i=1; AJvYcCVPmpeY64g4eHJq028ThggI76aZEHF+StQkIPn9quh8AHCq1/kKGuinX4Vu/G3X7cuVsz6ewrtPIqiGVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdF/LsGRCiKhE36UKHq/A9iJOlogVk169tg0RoRyqGtlZLWgdA
	xDt4dtPfPbhUAzjmyX9Pby27uHyEffz031DXWcrT3p2AoGApFcGulCfAJokYzUCmdOXUnfVsbD/
	6sBL0CYDix6vuUKJMdPtxy+sVzeHx/HsbZwGqiRGP
X-Gm-Gg: ATEYQzz5qRNkPdxJRqcThobGD4se3XpJqlJFlEw9f3K0snVh7RqKiMA7pdbIfjxESn5
	0BD85lV7PAFdRUJX5ketcf0aD7RkZG9WmL4oVSp2F16cCTtV5KEtgnKVmhqqDLYL/ZtGwFLUJBV
	Tq+n91Zx2PA0K9b5/uHKIW739UqeMKY5m0DDZTE340DoMkWI43FQcZj4hgzYHxAThaqNkPgHAGO
	NPzfSlHk/enq9JJR/CWWow+5b5TBohlZF7bqseV7gkbriHrxHWmx/WHMW/WVkFeFOsbyskuOTL4
	FL2UEGX3LlWSQsceRZHMnwlHZd5uwhl3fZmwB5bNufZXI+03ZGXrpus1zB5WktmQjrKOP+Jgj3b
	69K0IM3nosJb2sIow3Nyg765vBHsdUdbHxopMWqiv5+PXuUo/+R6CSF4=
X-Received: by 2002:ac8:5a10:0:b0:509:cd7:aa18 with SMTP id
 d75a77b69052e-5096946ba5cmr24153891cf.10.1773627813807; Sun, 15 Mar 2026
 19:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316015354.114465-1-senozhatsky@chromium.org>
In-Reply-To: <20260316015354.114465-1-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 16 Mar 2026 11:22:57 +0900
X-Gm-Features: AaiRm515kesiSneWsCz573dJ5nQbUd_phGn-T1G1RXtcvgFvDRcUXQGGWqhv_8E
Message-ID: <CADyq12xB7zpZq9xTe1sJa2O+dv1e3pbdJjWrTcpagRbGC1MfWQ@mail.gmail.com>
Subject: Re: [PATCH] zram: propagate read_from_bdev_async() errors
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:54=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> When read_from_bdev_async() fails to chain bio, for instance
> fails to allocate request or bio, we need to propagate the
> error condition so that upper layer is aware of it.  zram
> already does that by setting BLK_STS_IOERR ->bi_status,
> but only for sync reads.  Change async read path to return
> its error status so that async errors are also handled.
>
> Suggested-by: Brian Geffon <bgeffon@google.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 63f71371a7e9..b47cb1d99144 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1445,21 +1445,21 @@ static void zram_async_read_endio(struct bio *bio=
)
>         queue_work(system_highpri_wq, &req->work);
>  }
>
> -static void read_from_bdev_async(struct zram *zram, struct page *page,
> -                                u32 index, unsigned long blk_idx,
> -                                struct bio *parent)
> +static int read_from_bdev_async(struct zram *zram, struct page *page,
> +                               u32 index, unsigned long blk_idx,
> +                               struct bio *parent)
>  {
>         struct zram_rb_req *req;
>         struct bio *bio;
>
>         req =3D kmalloc_obj(*req, GFP_NOIO);
>         if (!req)
> -               return;
> +               return -ENOMEM;
>
>         bio =3D bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
>         if (!bio) {
>                 kfree(req);
> -               return;
> +               return -ENOMEM;
>         }
>
>         req->zram =3D zram;
> @@ -1475,6 +1475,8 @@ static void read_from_bdev_async(struct zram *zram,=
 struct page *page,
>         __bio_add_page(bio, page, PAGE_SIZE, 0);
>         bio_inc_remaining(parent);
>         submit_bio(bio);
> +
> +       return 0;
>  }
>
>  static void zram_sync_read(struct work_struct *w)
> @@ -1523,8 +1525,7 @@ static int read_from_bdev(struct zram *zram, struct=
 page *page, u32 index,
>                         return -EIO;
>                 return read_from_bdev_sync(zram, page, index, blk_idx);
>         }
> -       read_from_bdev_async(zram, page, index, blk_idx, parent);
> -       return 0;
> +       return read_from_bdev_async(zram, page, index, blk_idx, parent);
>  }
>  #else
>  static inline void reset_bdev(struct zram *zram) {};
> --
> 2.53.0.851.ga537e3e6e9-goog
>
