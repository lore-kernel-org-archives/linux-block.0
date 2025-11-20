Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE201351FDB
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654623; cv=none; b=Oel0+qV35OJkt7+euo6V3/MK6Fgb/9JJrYl/FIT7dEegD/xcgQ5nc1ZPURKnbyS9pjYp+1t5yoYplT/CSCh8ROeLfN8aA5Ncs5/EQsPQ7IVjQcGY4gGo1MJ9EtYEJwOwV0cR83y8ECLZyj70CJrdpMFkX3TGaIjlgfaUxoq2eGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654623; c=relaxed/simple;
	bh=cG/szksZMK3/qUmHh0BLsP1xvN4DM1w7cRtZWEpDzVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMprRZyqV0jt0NneKaZjvbVRC1UKLeNpmY1GYLDJyStDgrST3YcwX8GIYZTDGGD++JtKbQKROzQQZh7jGPO799KSaaDjCIcQxa5u+uN1l0HoAy4mLWf4Iy3nhxoJ2jeWYqqyxZLG8KdlE3GH8wNYA4rfQ+ZaA7TE4ZmiponSJMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPsa/4Nc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPsa/4Nc"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2980343d9d1so175145ad.1
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 08:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763654621; x=1764259421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZoJ5T7qCxoqJ0PzPFIxBpO8OSKGlINQNrAGkZu6Ryk=;
        b=BPsa/4Ncy5EOC/6Qqs3+Wb+RiVngUII5/LWrGHKtHrWy5fv4IKKwbtamXkxbaLoPe/
         frt4Eh0u2Fih6yY6Fwi4Y7GMLEAHTdzG4zvDDhlg88MuLeBzjgnyOvYCli7gb89zXk2V
         F1832BDau6whBXCLrVR2Bcwwh9BaVqlXSaAEHHnpO3/ur1aAyotMoFXbKgDDcPvB0W1s
         Vj2adciFxcLO39FOgUvBAcKCKcy31rstqlgcf/+ZqKaGyv83UC+9ZLgGUOgQvIWeCzAM
         gtQ9Gpct+mmdWvMP6K9iuVRuvf16zi2GtQf2H7xZDHQJzAmdOtnx/sB/iu/5aYZ3ulrA
         IMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654621; x=1764259421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aZoJ5T7qCxoqJ0PzPFIxBpO8OSKGlINQNrAGkZu6Ryk=;
        b=nzPI9Opc6tf4DlQUpsG9Rj6Y2RIowpGUTWbr7CoXvqxt0VFLGCMYRm3QNPFoiV62ya
         dYvCZMNEHU+BgeTAnjep1kQ8siUtVVtAeKgNS3Eed605qTRy4UWYNFKHdUVSCziKgbz/
         la2Zc5rM8t5lZwzIrtIINvnk7tzwNJWJUZ/k0x6L5XXIOZQAa1KmtzCL760YYJA8AJZa
         1SujKUIsOUq2hD0ErL7FsYNuwBgEggohT0a3yPDdgOqX2j6i/E+9oR5hdmp4JAqYzXSw
         AjLrE0LX/2bX8TbIaUrxPGpMD4/6D3XTWdZ2qpSDCkn756hUQowUu4P5wm5m/WccHgYB
         3zuA==
X-Forwarded-Encrypted: i=1; AJvYcCUhV6MZ2AdLJxY5Pk9G5k8a17n+3g/ipPfQ9jj4pGg+BLtnuaqtzqZKlweDx5dIrduGcDsLK9d5eiPqTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1sfyqIogbDUeYTMSTLTFU7HNqYfa5J5EclbsJwe8se9Utw2G
	uQpWhEymj70N1ONTbKgZnmDpGNzAQxlmrBX5/N8d077dap11PsdqyFEL71tRVgYFP7sC77Kc27D
	NRAUBv6a4qPl+a5oEG7AsyN0K+4aP46aPV3K3rxAO
X-Gm-Gg: ASbGncs5qMA5QWoLPQJP9KNowFdOMqik4uKWGkVFZiLi9aVlKQ6M7HLs/6f6VQe2Myy
	y4cDuEeaEcj+O2iq2720iP/GUKY13WJskK6yMJ6Lta8dGaiV23VgAwf1vNNn7Djh0iMYdRDwZJC
	x/YYdrbDNCvonV8bD724cPn8HTvRz4bnx7mLk3tyEOCJ2sQZvLJkFFPCitJm/ssy7gTrez48hID
	hi0FoVuFGig0mwgbocmA7pjBLdu1ILadKwgJq4+5ViELNuqmG0PSnWF/hPw9u75bns7ji0ng0JP
	LjXDhrTshEwX1+Q0Z8z9Z1kDBzhTWNnpCojtO5yl4Ry+O4ZFy/NAJKM=
X-Google-Smtp-Source: AGHT+IF7lqOPqoBO+y+4EA6lJ6hn3ZHzn/3In/H2O8AR7c1Wu4vPP8NEpom98N1Q146cEr1Yqb+p7fQVYifcTojWkAI=
X-Received: by 2002:a17:902:c94c:b0:290:dd42:eb5f with SMTP id
 d9443c01a7336-29b5c597629mr3075335ad.12.1763654620864; Thu, 20 Nov 2025
 08:03:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120152126.3126298-1-senozhatsky@chromium.org> <20251120152126.3126298-4-senozhatsky@chromium.org>
In-Reply-To: <20251120152126.3126298-4-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Thu, 20 Nov 2025 11:03:04 -0500
X-Gm-Features: AWmQ_blfFP1VArS6ZsRCtg105hCt75V1EorH-fow_aw4WlQEnVbTUnPSVIx7GRw
Message-ID: <CADyq12zV=HkDOzvfngY_5yCCavdq4n-k6XeVFJBKkVSX_eP8yw@mail.gmail.com>
Subject: Re: [RFC PATCHv5 3/6] zram: take write lock in wb limit store handlers
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
> Write device attrs handlers should take write zram init_lock.
> While at it, fixup coding styles.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 7904159e9226..71f37b960812 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -519,7 +519,8 @@ struct zram_wb_req {
>  };
>
>  static ssize_t writeback_limit_enable_store(struct device *dev,
> -               struct device_attribute *attr, const char *buf, size_t le=
n)
> +                                           struct device_attribute *attr=
,
> +                                           const char *buf, size_t len)
>  {
>         struct zram *zram =3D dev_to_zram(dev);
>         u64 val;
> @@ -528,18 +529,19 @@ static ssize_t writeback_limit_enable_store(struct =
device *dev,
>         if (kstrtoull(buf, 10, &val))
>                 return ret;
>
> -       down_read(&zram->init_lock);
> +       down_write(&zram->init_lock);
>         spin_lock(&zram->wb_limit_lock);
>         zram->wb_limit_enable =3D val;
>         spin_unlock(&zram->wb_limit_lock);
> -       up_read(&zram->init_lock);
> +       up_write(&zram->init_lock);
>         ret =3D len;
>
>         return ret;
>  }
>
>  static ssize_t writeback_limit_enable_show(struct device *dev,
> -               struct device_attribute *attr, char *buf)
> +                                          struct device_attribute *attr,
> +                                          char *buf)
>  {
>         bool val;
>         struct zram *zram =3D dev_to_zram(dev);
> @@ -554,7 +556,8 @@ static ssize_t writeback_limit_enable_show(struct dev=
ice *dev,
>  }
>
>  static ssize_t writeback_limit_store(struct device *dev,
> -               struct device_attribute *attr, const char *buf, size_t le=
n)
> +                                    struct device_attribute *attr,
> +                                    const char *buf, size_t len)
>  {
>         struct zram *zram =3D dev_to_zram(dev);
>         u64 val;
> @@ -563,11 +566,11 @@ static ssize_t writeback_limit_store(struct device =
*dev,
>         if (kstrtoull(buf, 10, &val))
>                 return ret;
>
> -       down_read(&zram->init_lock);
> +       down_write(&zram->init_lock);
>         spin_lock(&zram->wb_limit_lock);
>         zram->bd_wb_limit =3D val;
>         spin_unlock(&zram->wb_limit_lock);
> -       up_read(&zram->init_lock);
> +       up_write(&zram->init_lock);
>         ret =3D len;
>
>         return ret;
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
