Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE03570A5
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654299; cv=none; b=eSTW9rZCVIEicn0CegiznTrQw6e18PypULKNQPFn90Jw311txch7caTTTK/SSdK40uwslN0esGF9kImWOkKhQSpGz3MQ07U7regBKHjCvMQ+RmZqqmEh03rNkjg9WIjQxSFmK6zKZizkTdbfeUQlwEjnlQK00K6j+539EIMIouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654299; c=relaxed/simple;
	bh=1yTPLsSuIoA5w5GAb2TfPYu4qw+V1sm/wHXzyNjKbNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CO2fWjTWuiiWr6NXeNrvbsl/xqS/FEpC5Zq0tBRCtfFv+hTJ51aXrGiGSzo5gq7Kg3OuXTA4fJ+R4ziiziy/F6mC8zokXjLW+9W58cCzHDnF2nzRo90ad1PeLtCPKEukAfxT8fx0FE1JDqGTdM4qk4DRsesEznWTNyIsZegd9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W54x2TmL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W54x2TmL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2980343d9d1so173865ad.1
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 07:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763654296; x=1764259096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FM+Mb2yZG4S4vNNa7mZRT19UBjXjaSiTW+UNdByxGbk=;
        b=W54x2TmLxv6/vDsiiChqpdgv5sOfMNB+pLmuEe2hNE1GZ61k7jZiQFAdaOmk2gR/K+
         bG7EvPTt8ed420QS+NY9uBBMBETpUZUwwkxrLnOHYBAXEKlpVqa6SXAbaqUP3mayZVFF
         7z+xx+W303rayL5aZdE1HEWnjxC5Kp+fsJTqWXojrF+PXaIVQvCY4LoDVLJblP+yHGd7
         b6eEIiz/6B47wa6L4KfHyIcYwAkcKRHa/YkQRkyoUQ0Ah9qWG7BuICQvgxhna3kXLoux
         u1GV3mal6hHVjNEOKB9k0AwVllCbh3eVHbEn9zdAq0Rry7itfqCi8k1q+C7iXRFoIYFM
         7YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654296; x=1764259096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FM+Mb2yZG4S4vNNa7mZRT19UBjXjaSiTW+UNdByxGbk=;
        b=kPRx+rb0jPz46+6RPAePmnEN4Q/QeBzSU6d6mgl2vH16adm7VGJigs3kZTTlYOAT2T
         JpiCYfC9NkxIGFEsGhpv482m92Ui8EQpoKxIdlHFoQCFe4XLpgGOA822rnTrb+LBiU5s
         tUJuhmkzuGhtgLBsCGtazSwS8s3euuLGe0R+ILszDWNAvkRpdsEAwgEWdNAHGw1vOxYR
         5C5AjmSZcBEHkquzF+5Rext+dNY84xzn/4qhVkFjEkWaWFcukp4FO5/GKomfuyL4wfXq
         y3PN5DTvjDY8hGH3cQyzXEnIvfH+C6Kdtxi8j/vDAZ9epo6elikSzv6xeTUzrI/7sdC0
         PKRw==
X-Forwarded-Encrypted: i=1; AJvYcCXOVZUNZIDMKzC9driuNUiTCvElkHwyNYJvFVtNNZMQvwOas//mWjuR7yGqbV+FAku3GaHL0Xa2BpyE3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Cn03kxV/0tlulqzPbIAXcf8bZYqBUjooT5CsSDDoHz4kxzYj
	aBrwZhcD/dZXoNCx17r/ijNb+O4RxBWQRxwGJYCvMMzGEvC4Q03TvVloz4Jr3X1zRGKQA0QkgE9
	TcuX45ngZ9iesGSI7akO22JMfHcRb9GPYyWAG0d/Z
X-Gm-Gg: ASbGncuMgssUJ7AgHAU819TzBFCts1LieFeyNiCbX57eDv6hh00kCOvChsuNumhqV4C
	D3BfgoPTzQn4JGY0F+Ng3QN+DvCR6AqUzzPrAaGds525fYz5vrcFjYHZAM9OYnQW6G8JrYFlH1N
	ZeGj8Z4sA4x1JDYyOOg87NQPfDrKv5T8m26K1Hsa5xzmZp7SHG45gveFKQJCt+GrJZnIIFBtccp
	Uzas5xXO3R6S1Gys9Z8/XH6o4mcp+6nidJm3gRZpyYxccukDTjxUGsERyzdmZ8j1rdB69caPrfr
	3Fl57BU/sbQPTcPVqQ42K+biJdSceDQ8+S5xJTdWx0ammskeivBbJa4=
X-Google-Smtp-Source: AGHT+IEN0NULaP+VnPL1/fDLZYNjF8Hd/VUeot/flqRIzbz+bFM8hMgL+i6VUxvXySk8BrtVEFw6k33qRAE2TH0TEa4=
X-Received: by 2002:a17:903:2f81:b0:29a:7af:b3c9 with SMTP id
 d9443c01a7336-29b5c5951d8mr2842585ad.16.1763654296382; Thu, 20 Nov 2025
 07:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120152126.3126298-1-senozhatsky@chromium.org> <20251120152126.3126298-3-senozhatsky@chromium.org>
In-Reply-To: <20251120152126.3126298-3-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Thu, 20 Nov 2025 10:57:39 -0500
X-Gm-Features: AWmQ_bnVrwcH8-BKVi3_n9EW4M0i9C_Im6NDofM4Llka_8QMk4wUrZfCfTLCF0M
Message-ID: <CADyq12ypYai3Q2QntCjvp26U_J3xWpO4J_DSV+UwCqLFinkcGg@mail.gmail.com>
Subject: Re: [RFC PATCHv5 2/6] zram: add writeback batch size device attr
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
> Introduce writeback_batch_size device attribute so that
> the maximum number of in-flight writeback bio requests
> can be configured at run-time per-device.  This essentially
> enables batched bio writeback.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 48 ++++++++++++++++++++++++++++++-----
>  drivers/block/zram/zram_drv.h |  1 +
>  2 files changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 37c1416ac902..7904159e9226 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -588,6 +588,42 @@ static ssize_t writeback_limit_show(struct device *d=
ev,
>         return sysfs_emit(buf, "%llu\n", val);
>  }
>
> +static ssize_t writeback_batch_size_store(struct device *dev,
> +                                         struct device_attribute *attr,
> +                                         const char *buf, size_t len)
> +{
> +       struct zram *zram =3D dev_to_zram(dev);
> +       u32 val;
> +       ssize_t ret =3D -EINVAL;
> +
> +       if (kstrtouint(buf, 10, &val))
> +               return ret;
> +
> +       if (!val)
> +               val =3D 1;

IMO a value of 0 for the batch size doesn't make sense, -EINVAL?

> +
> +       down_read(&zram->init_lock);
> +       zram->wb_batch_size =3D val;
> +       up_read(&zram->init_lock);
> +       ret =3D len;
> +
> +       return ret;
> +}
> +
> +static ssize_t writeback_batch_size_show(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf)
> +{
> +       u32 val;
> +       struct zram *zram =3D dev_to_zram(dev);
> +
> +       down_read(&zram->init_lock);
> +       val =3D zram->wb_batch_size;
> +       up_read(&zram->init_lock);
> +
> +       return sysfs_emit(buf, "%u\n", val);
> +}
> +
>  static void reset_bdev(struct zram *zram)
>  {
>         if (!zram->backing_dev)
> @@ -779,10 +815,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ct=
l)
>         kfree(wb_ctl);
>  }
>
> -/* XXX: should be a per-device sysfs attr */
> -#define ZRAM_WB_REQ_CNT 32
> -
> -static struct zram_wb_ctl *init_wb_ctl(void)
> +static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
>  {
>         struct zram_wb_ctl *wb_ctl;
>         int i;
> @@ -797,7 +830,7 @@ static struct zram_wb_ctl *init_wb_ctl(void)
>         init_waitqueue_head(&wb_ctl->done_wait);
>         spin_lock_init(&wb_ctl->done_lock);
>
> -       for (i =3D 0; i < ZRAM_WB_REQ_CNT; i++) {
> +       for (i =3D 0; i < zram->wb_batch_size; i++) {
>                 struct zram_wb_req *req;
>
>                 /*
> @@ -1197,7 +1230,7 @@ static ssize_t writeback_store(struct device *dev,
>                 goto release_init_lock;
>         }
>
> -       wb_ctl =3D init_wb_ctl();
> +       wb_ctl =3D init_wb_ctl(zram);
>         if (!wb_ctl) {
>                 ret =3D -ENOMEM;
>                 goto release_init_lock;
> @@ -2840,6 +2873,7 @@ static DEVICE_ATTR_RW(backing_dev);
>  static DEVICE_ATTR_WO(writeback);
>  static DEVICE_ATTR_RW(writeback_limit);
>  static DEVICE_ATTR_RW(writeback_limit_enable);
> +static DEVICE_ATTR_RW(writeback_batch_size);
>  #endif
>  #ifdef CONFIG_ZRAM_MULTI_COMP
>  static DEVICE_ATTR_RW(recomp_algorithm);
> @@ -2861,6 +2895,7 @@ static struct attribute *zram_disk_attrs[] =3D {
>         &dev_attr_writeback.attr,
>         &dev_attr_writeback_limit.attr,
>         &dev_attr_writeback_limit_enable.attr,
> +       &dev_attr_writeback_batch_size.attr,
>  #endif
>         &dev_attr_io_stat.attr,
>         &dev_attr_mm_stat.attr,
> @@ -2922,6 +2957,7 @@ static int zram_add(void)
>
>         init_rwsem(&zram->init_lock);
>  #ifdef CONFIG_ZRAM_WRITEBACK
> +       zram->wb_batch_size =3D 32;
>         spin_lock_init(&zram->wb_limit_lock);
>  #endif
>
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.=
h
> index 6cee93f9c0d0..1a647f42c1a4 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -129,6 +129,7 @@ struct zram {
>         struct file *backing_dev;
>         spinlock_t wb_limit_lock;
>         bool wb_limit_enable;
> +       u32 wb_batch_size;
>         u64 bd_wb_limit;
>         struct block_device *bdev;
>         unsigned long *bitmap;
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
