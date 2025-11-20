Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27C224B04
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662446; cv=none; b=NrGywXRfBfgsZ1rv3j5uc7eVQT0Bie/3ZxURFFr6lT0iKi5ZXQfM8hkpqN0Csai/oye7qDb5XpNaj5BaRv79RGtu8TBD60kReltqG/AR6OJWRVmfED4Ft54tHaEwlrFOlk96QCgja2PtQ59Sk5R+wKPPUMMta5lobvIUwyVO2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662446; c=relaxed/simple;
	bh=ypMmf60cBj4WQcSI9KfUl7Er5f1ixoXnX0jlrFpr0x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nb0aXfwMa2xAFFdoW4MlmxpzjW5m2nc1m2/c6idCLsYJU1yFbACd2XkHAEIXCgjD25mSlbZ6Sq4p4IQQJkhl4SVuqmiz2gtQzgU7Zp7l9FVcrj4Shs6FamcLLqiPDfPtyMNz3cizxs4RFHTt/8kL8uZx8wCLC9MEVDXLIWrCNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Du2xO4Zw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Du2xO4Zw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297e13bf404so12395ad.0
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 10:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763662444; x=1764267244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnAwwRG1xi5brVg3f34AJJJ2ozsmQIQit6jyVLGvFj8=;
        b=Du2xO4ZwgTm5gWrmd6hAi66EboeGGng7saqzyZMX5/3DZQwxdyhyc4xMvjtFCDP6FY
         C4eE/eIXYWTVfRZfBtNFLKF4y8rFfFuBh3ZtSwF60sXwuFl0DklV+D28wYLb3m5X5+pz
         0hCj2e9yyITwRb+CUyZU1/fW2fIMq318nlS8O8KVD6NmSogrJRS0mv0q6XiUvx/ZZngB
         vGhtyK1p6Dj5Gq1n8yAA1iF4ay55ALZJiB6pygV4FsZuhYAibmOrg5QHSCd4QEoGv350
         sCIGBIRjMR9CAuRqGpWAtiBDkKW8pOdOTV6qRzgPuCkNKsufUFrlbpzYuECbPgi6fmJ5
         9J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763662444; x=1764267244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnAwwRG1xi5brVg3f34AJJJ2ozsmQIQit6jyVLGvFj8=;
        b=Ri8Q+NwPiaHm0gTd7udbm5vgW1QTw2sX22BPALeL40AY6XC1wXUDq7WLStYjUKxBJI
         GkFTRQz4JRWH7d7aA5xMxENosOD6IOyyevl5w52/wgHLASyTLl0o12Rr2jD3Bwhv2yDV
         u2hiXWkAXuuYUXUSYvugD+lEdGI4IubEMzkxJsSg/uDNMKermG9Lzk+JFCOsQAoHjIHk
         GkQczmymxowNsiomoLy/4qFKrjk3gcly7ENxtxgbhVtJpBvjYaBFBACVZHnAUSMfJZTN
         0c6c5C34Hw/cgGWt1nzW2K81pTKXQlq9xC25XQteTGV7TWo0nAGvMW+eQpfeOosXDpdU
         WbsA==
X-Forwarded-Encrypted: i=1; AJvYcCVhnlRIeQt3vtqY9Q9z6bAz3AQt1/KDHSetgAhB4pwk7U0zKU1fsY6uhblZfjUG5CuRg6W9TFEyY8PHfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/WQMyuvCLpRQwfvgPXj0HoVAy9PN5t3SSQYkVnBL4wELVw33
	CStqmUS73wdbiswSdoKeM0Q0S4xmwMNSiPHQ/pQoYDSZqk8nPDUMoprVvrWIZUQu03iW7SX4IaI
	2vCnd9XAnF8AcNxwY7+LJLYoq1eIzIlObSkRFUHIa
X-Gm-Gg: ASbGnct4Ca4Rt224KgSqRA6ldnj8T3Zj71IEtsHPEe9ID8vjhHxe78LtsQuXLQ15x1Z
	WDB9HffOYnYm6aT73++GmtuyrQv6Vehu6TPwYyEFupHLQc1Vi+bIeR6OX+LTk1XG11hBWIhC5ea
	lhK/97fP0CGwVDGinxiCIg9Lp9cqK59JIUcIUtBlZPuCqg22xSPX33AM/arIAyVUsywrSVTfzpQ
	XcGHZO3cfh0E+Ng78BVpSeqytpZPtl5TOZd21jq64sgWENXrLfFX6fJkxUH6WIBKj2SCqQFCURZ
	wdm6kRtr6zG7aO1A1CBDh6N0zz/Jg2gW9MqQyif/Nam1PZ3+90yOr0k=
X-Google-Smtp-Source: AGHT+IEJ6cqaG6MxrDd8DOBVpTVgsb8olGtjFPzybXpMgpdvGH1Vhu3k2CqvjEEfwDleme6JIj7dMMORoMIFPxwwh7Q=
X-Received: by 2002:a17:902:f68d:b0:295:1351:f63e with SMTP id
 d9443c01a7336-29b6a3ecb55mr12825ad.10.1763662443808; Thu, 20 Nov 2025
 10:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120152126.3126298-1-senozhatsky@chromium.org> <20251120152126.3126298-7-senozhatsky@chromium.org>
In-Reply-To: <20251120152126.3126298-7-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Thu, 20 Nov 2025 13:13:27 -0500
X-Gm-Features: AWmQ_bmSMHceSjxinDeE8mTZc06D2U4HleB3jocgu3xFUGTZUMDr9Qt-L6LI5Ok
Message-ID: <CADyq12xmCgX1_KA+bKt=r=MWRKSX6N3bsuxBn4LRy7M1K9=1mg@mail.gmail.com>
Subject: Re: [RFC PATCHv5 6/6] zram: read slot block idx under slot lock
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, Richard Chang <richardycc@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 10:22=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Read slot's block id under slot-lock.  We release the
> slot-lock for bdev read so, technically, slot still can
> get freed in the meantime, but at least we will read
> bdev block (page) that holds previous know slot data,
> not from slot->handle bdev block, which can be anything
> at that point.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index ecbd9b25dfed..1f2867cd587e 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1994,14 +1994,14 @@ static int zram_read_page(struct zram *zram, stru=
ct page *page, u32 index,
>                 ret =3D zram_read_from_zspool(zram, page, index);
>                 zram_slot_unlock(zram, index);
>         } else {
> +               unsigned long blk_idx =3D zram_get_handle(zram, index);
> +
>                 /*
>                  * The slot should be unlocked before reading from the ba=
cking
>                  * device.
>                  */
>                 zram_slot_unlock(zram, index);
> -
> -               ret =3D read_from_bdev(zram, page, zram_get_handle(zram, =
index),
> -                                    parent);
> +               ret =3D read_from_bdev(zram, page, blk_idx, parent);

This patch doesn't really change things in a meaningful way, wouldn't
it be more correct to take the slot lock again after the read and
confirm the handle is the same and it's still ZRAM_WB?

>         }
>
>         /* Should NEVER happen. Return bio error if it does. */
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
