Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853624A058
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896249; cv=pass; b=psYBvSLHxtysZ8W01qn4hq50JPBfO7bpdrgtkRqZbVF1ZBUzZRmJs+1k7bM+lc2yC2y3pe8K38JQr+l6aJeAN0McoYU3fZh8DFM2y9R/CKhAst6sdDUX0AvAFPRsf+MXu8tJi65xKpmCqHoTPhEutDOr+NoLajNafeiYVa19ADY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896249; c=relaxed/simple;
	bh=x0AdhSYzLct9R1I+qn62qo/eNDqJHMCy3T9bnG16+yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qagpF6uYf1Z1FmKmQXPYCkyzqB1Si3wuAiiNnB4y+f4ONgufcSu8f8lAJhwOtt5K62qETzjdan2mvcxAngJEKz3sjCehvsXOjaqOkgk7GouIdXASaZcj1Dpyh4+KZ/3y6t/5FgFIQvjTQZJGDTES/pbJVF7tqjFpJxSTMnCQu4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofzzBd3L; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofzzBd3L"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d06cfa93so123205ad.1
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 06:44:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765896246; cv=none;
        d=google.com; s=arc-20240605;
        b=kZwpuwisHIdIqa1BcnxOjbOYO93xA6xL28jzJd5BoHbXjH9KRUfkvcWM1pPvX3HszH
         0vOTKe/h3By2ZQASJbh5bqIX10z4HnieXS0ochdM/f2klGO0bjHeWxRUUpysGBwFgUhl
         xmX+77JKv5Op6qsijHPk7B3Wi7WsVZMHxTAePQ4lMsHU6wS8X+LOxxc5JSAldLM7YZIY
         5N2RY75aTCsNluri4kJasRxRRIoieW7E8BYmBw6SfseWKReRMDx33EeB735qchuTjAnb
         qnNrcdIFtnmlk+mCw3PhYSXeoSi7/8HqffOm+toABVJH8y0qx0HY4Y5tg6NuV36LPyDz
         HpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KAmi/53GD4BVHhy6hIhjJyr/xMy23CdsxEuUrYlt9C4=;
        fh=Gko4a/DaAvNfKhXwrWCI5lTzvbuhZUeIQJO25C/hhGM=;
        b=dybV1gvtqGos5tLcpLAfD6mTAJpnx7zIrzqamioR6CIRbIe8bQR6I2BDrVe0Ii1vqm
         HF6gcnuUfg8vm7/xuhT2knBMH2B8QTTteoPFPfc1tgmSzpdq1314Wyuxiu/PQz9fiDVF
         yejphmcxFsjhxZm8amQKBjJNCu2j/nB7XAdzIDd1MD3UOfAe7SuoFsLqGQ3xKMrvYg9t
         0eeCmqncsKfryM5qieAx2fzdCFsvtvwEUwD4YDhvjJ52NSnb7qt8t/2Xi+guPSygCqJA
         H6yNIVT3BghnELOF/TvPgqndxs467JlCLNi81DGgJh5ap77NBBvZivoQ8RcyVwxhEv7D
         vAFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765896246; x=1766501046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAmi/53GD4BVHhy6hIhjJyr/xMy23CdsxEuUrYlt9C4=;
        b=ofzzBd3LTCQpkRVUW1pmtWLSenR302+UTtMbGyrA3WUJBXszElkSfnJM61O9ciQWtq
         Xm32XUYWhb4+YGEmEfN9+IVVvQ4xcqguSVXzuuPqYiPOxznFl18vggmaILlQiFEfzPEL
         d0P0/u4vProPXaw8X/omtDeHqnPXJjyLh1AUs+olz9OKQJt7N4Q2ls/trHVWWXjHla4i
         Jj0UH80clkzaGmL8bQe+dXuRgHA3qgEI8j2Gb88C6NWBghNlyF33CAK1IRF0+226WIB3
         Y3bSOR0OBFKiPJTcHRUGMvf0bz1ZEpmfdGp4bBq/24/eUDPHLOypQC/kAwq5ttsVTpeC
         GzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765896246; x=1766501046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KAmi/53GD4BVHhy6hIhjJyr/xMy23CdsxEuUrYlt9C4=;
        b=khNPZsMqQ1xG84uSzTzWrFNZNnGpMbTePd1Pyk2eZClMiLu2xpvQ5a3ggseerin8EV
         Wc5IDpkJP1Ww+I+HML1ipf0iT84OO7XuTQ0KonEHIl9YT9JAjcUsuzyDSWvk2uwWHWq7
         BXViMPJc4KMn1Mvb/ZMB7tVo4xaRhjs51ubw/zyS+2B8aHY0hnrn8mQtDrEEbArl9UYq
         hl/97IvMe47zYe//ry4NeFr70zcPFtd17Y23PyCy2x+k2UsIZ/NsJU9v7ZSanXNyiSvU
         zPqKKL8dfqD3Df7YY6retjtl2rHsy70usMMgPcJXon9iGxtVEtAKmzlYWuvsyFPWom5k
         MTIg==
X-Forwarded-Encrypted: i=1; AJvYcCXMo15SlGsAWMIO4lNdahnpeyBspi+6NlJRpKcXZWzvexmJpvPFkuM+ATa6ZOtqM7AfbSzejBoLLAKwEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPM9P/VhrNjVcLOO6iaEquR8gwN97RMzu2cAhO+/Hg8ouU6cnj
	4ePQIiigde7+YgCLhWq+6/0d5KkPh/fSB8hoYw8RAskej9cHtjbY53JxTUWa9ql4egryU/dm5Oj
	Skmj2fIC84e8pHluGk1HoONXKafXyORCf22TZ4m6h
X-Gm-Gg: AY/fxX6DvJTP5b1z7/wZ5aB0hZA8te3wA6Xxu27n/I0Gy9R55xN5PdcUsE4i3bZw2FJ
	6TDdN4TlK6RLhNujlFtmRKpJDyakhJRLt/FVsgIVnpUYTY4QG8zWBB9jqZqOW1OeyG7tCAMzqkJ
	jWcCgmJUnQbYhW74gblk9HcaXiOfuS8l9u1i/yXES55p7USaz83ogMd187MemKrZZlaYDqeBZBj
	U7DFEE0FPvWCL9vP1EyXzUgXB/uJoRr+Sx+e8swbBCe3Ssb/RByfMPy+PmhskqgO+CTMicc665I
	4So26bq38s9s2mgQYefqyGnbBu4J4ePhy8Cc9txgmn++LLA6lF18dLU=
X-Google-Smtp-Source: AGHT+IEiK8lrjUxMAkdhPuZBDUC8WfG1CK6GP/FrJkLfqWEXiBqNJySSdrcdekRlORQEPtUvpXfHdKBF+4spMZWn6is=
X-Received: by 2002:a17:903:4b2f:b0:297:f0aa:d466 with SMTP id
 d9443c01a7336-2a13e0e3be4mr1282645ad.8.1765896245495; Tue, 16 Dec 2025
 06:44:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216062223.647520-1-senozhatsky@chromium.org>
In-Reply-To: <20251216062223.647520-1-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Tue, 16 Dec 2025 09:43:29 -0500
X-Gm-Features: AQt7F2q7zRmUgCShM6gfRxNMMZTahWG7X3HrXL8-Yqad8hiy4OHSH28MaqpZh5Q
Message-ID: <CADyq12yidNfeoRtUONM9VkdXpzZVbKy2+VYSJJpGqZtd7BqD2Q@mail.gmail.com>
Subject: Re: [PATCH] zram: drop pp_in_progress
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 1:22=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> pp_in_progress makes sure that only one post-processing
> (writeback or recomrpession) is active at any given time.
> Functionality wise it, basically, shadows zram init_lock,
> when init_lock is acquired in writer mode.
>
> Switch recompress_store() and writeback_store() to take
> zram init_lock in writer mode, like all store() sysfs
> handlers should do, so that we can drop pp_in_progress.
> Recompression and writeback can be somewhat slow, so
> holding init_lock in writer mode can block zram attrs
> reads, but in reality the only zram attrs reads that
> take place are mm_stat reads, and usually it's the same
> process that reads mm_stat and does recompression or
> writeback.
>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 28 ++++++----------------------
>  drivers/block/zram/zram_drv.h |  1 -
>  2 files changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 634848f45e9b..47826d8ed376 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1264,24 +1264,16 @@ static ssize_t writeback_store(struct device *dev=
,
>         ssize_t ret =3D len;
>         int err, mode =3D 0;
>
> -       guard(rwsem_read)(&zram->init_lock);
> +       guard(rwsem_write)(&zram->init_lock);
>         if (!init_done(zram))
>                 return -EINVAL;
>
> -       /* Do not permit concurrent post-processing actions. */
> -       if (atomic_xchg(&zram->pp_in_progress, 1))
> -               return -EAGAIN;
> -
> -       if (!zram->backing_dev) {
> -               ret =3D -ENODEV;
> -               goto out;
> -       }
> +       if (!zram->backing_dev)
> +               return -ENODEV;
>
>         pp_ctl =3D init_pp_ctl();
> -       if (!pp_ctl) {
> -               ret =3D -ENOMEM;
> -               goto out;
> -       }
> +       if (!pp_ctl)
> +               return -ENOMEM;
>
>         wb_ctl =3D init_wb_ctl(zram);
>         if (!wb_ctl) {
> @@ -1358,7 +1350,6 @@ static ssize_t writeback_store(struct device *dev,
>  out:
>         release_pp_ctl(zram, pp_ctl);
>         release_wb_ctl(wb_ctl);
> -       atomic_set(&zram->pp_in_progress, 0);
>
>         return ret;
>  }
> @@ -2622,14 +2613,10 @@ static ssize_t recompress_store(struct device *de=
v,
>         if (threshold >=3D huge_class_size)
>                 return -EINVAL;
>
> -       guard(rwsem_read)(&zram->init_lock);
> +       guard(rwsem_write)(&zram->init_lock);
>         if (!init_done(zram))
>                 return -EINVAL;
>
> -       /* Do not permit concurrent post-processing actions. */
> -       if (atomic_xchg(&zram->pp_in_progress, 1))
> -               return -EAGAIN;
> -
>         if (algo) {
>                 bool found =3D false;
>
> @@ -2700,7 +2687,6 @@ static ssize_t recompress_store(struct device *dev,
>         if (page)
>                 __free_page(page);
>         release_pp_ctl(zram, ctl);
> -       atomic_set(&zram->pp_in_progress, 0);
>         return ret;
>  }
>  #endif
> @@ -2891,7 +2877,6 @@ static void zram_reset_device(struct zram *zram)
>         zram->disksize =3D 0;
>         zram_destroy_comps(zram);
>         memset(&zram->stats, 0, sizeof(zram->stats));
> -       atomic_set(&zram->pp_in_progress, 0);
>         reset_bdev(zram);
>
>         comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
> @@ -3127,7 +3112,6 @@ static int zram_add(void)
>         zram->disk->fops =3D &zram_devops;
>         zram->disk->private_data =3D zram;
>         snprintf(zram->disk->disk_name, 16, "zram%d", device_id);
> -       atomic_set(&zram->pp_in_progress, 0);
>         zram_comp_params_reset(zram);
>         comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
>
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.=
h
> index 48d6861c6647..469a3dab44ad 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -143,6 +143,5 @@ struct zram {
>  #ifdef CONFIG_ZRAM_MEMORY_TRACKING
>         struct dentry *debugfs_dir;
>  #endif
> -       atomic_t pp_in_progress;
>  };
>  #endif
> --
> 2.52.0.239.gd5f0c6e74e-goog
>
