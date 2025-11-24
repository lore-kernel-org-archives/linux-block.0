Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445F314A7B
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999447; cv=none; b=Q2Qj+YN509eW/Ntt9wGVb9N+jeamooQhRr9KCm5NMpEU1QvKMTN3rxA6AWZYslJQr3AtS09G5uQLZXEEFZkvnU6L7bbt6JDnKEIg1PmDYAkKFWnGm4kuGUWOp03H5QQK65EfYtXX5CfV/46olRyhhnw5/57/mSVFQs5fTstjyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999447; c=relaxed/simple;
	bh=kpIziwM6fc35ywrlgO1hCEEaSZA0AfjA9qspEpbc+VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4j9qeMgxN5VKqs241Goh8jGZs7pofXDUhW02B51WRPqX4CXxprb50ecUhBnt45xK0kEZrqnYOSKs9WK01w2IlWudgwDFksAf/sckJhoxoZK3lC8vhKzg2S22LjYm2rCN7GQyce+Kz5Aullc9Wc4r+Hw2MvTJwXZ+6Ih7j0VZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBxVN8WF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBxVN8WF"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-295c64cb951so390175ad.0
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 07:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763999445; x=1764604245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daIbgNggw5+RIWaqSAyn3PLOejh0silfLJm2gZrCAxI=;
        b=aBxVN8WFZAAT6Cr8UML6VsaiePXVtQ02jcHHxL6nQ1VDPb4PDkCJ+FRC22GEhEmjmM
         y11/98U/BsLYo+43qLUzQYmFLkI1OWEBxpYFtQ7PFcuC+Ci848zWB72SGtaUN7w/M9w1
         ogzHOmUQRH8sF6FOBawYEyPeQFJzrIvdmJILDKmayb4VTBDmTmoPXZ/jNcVChuJv2fy2
         MgzaOADMoVtk/1ScHs6WlZDulDIPEZVTgHfHYG1mPIP9xT7zu0ZWpSbqiPDbAXmSW1iq
         ItqWPqUIJSgqiEfqb+rtzD6Em7Lf9mErrj3orpxo3sa5TLO5ofObiNKBi9HWtvClRxrq
         cWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763999445; x=1764604245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=daIbgNggw5+RIWaqSAyn3PLOejh0silfLJm2gZrCAxI=;
        b=DJ0lmeo6VX5Amq2o6nEXAPUkRgF7gB6ds/Px5GjWKkQkPR/T6hY8rMwiTorjR8hFRA
         wS5jsGJBHX1RKUD8iUfJMG2jZQ/zimb3myP/gggBDSZq/9QMFGMcs6MNWHqAlWCWYQIa
         CWMxfQMpdO0vbSPkofR7Q1V4/aInj8/PgmmGkCIOzSCFHoGEhcyygaBkKayjjr3iII1n
         QReQN7mvU96GyK6QxZOm14Irz6hgQ3EJuvdB53SmvrhEPLYHdc5EU6qO2uQE7Tjz5nRV
         kL8d8T0VV4oPkIWdPd1W6wTfhm4wckAQ0OVRpcjgxobh5qmgohANCkLTGdel/dAxkFL5
         Kapg==
X-Forwarded-Encrypted: i=1; AJvYcCVJJszqXu2+1s1yay91KAjNeRELgK4PZfehN4CeMwlabJmFVqA3NWMqVxNVAn1PkRMI1nbQ/Mnl/TN+/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqaDfPLcyTOZPDaArSALBv9q+dpv8anlps2F+6Aj1rLDI1lC8U
	GdqqycrLitmjI+6KrXt9U48YbmzoSxB2NFbBK1rtx+TjnrfCqDcrr82pnV+Cik78vBGkjojLoeR
	r1ZWeBv19+N4KnTJtFPBUz/PlqQrfm4/ozAuooyVg
X-Gm-Gg: ASbGncuo8+EB8wPrNhhhgcicDul6oB9TGjWC47ZmWzkSCCrmQ0T9Co35jmk3HaaT3VI
	1Xi9enVUutpyt4nMsm5nLDAPSXhH683FHm9liJD+jytqnbssR/1STG9VBzNIPHZ7V/zAQciqZUU
	oGGcG/nG9w593//SuV18G1wmPnR4lYb07Wuk1NKXPLeQppYAiM5+75CDaIFTW3OZLSDnxLGY30H
	Zd/cJhVRBMOMgfctZ0VEllxJ2ZKnmuYt0MfPrGtYcbNSB70oa1VhJRrU9uYtXO3XAFG4phrHPC1
	XXxndIMQMI2WoQIi+TPn+nk68wxHQ0EAxy/YWNXDPv0HjFQ84QKS+VE=
X-Google-Smtp-Source: AGHT+IEy/LSMFk8iYVjgbAAJEenGWYAnGVnyxU/V1Cyq6eFwuiYf/UkhIX/FxJSWiRguk8dihSpeKWklTDThpq99c2g=
X-Received: by 2002:a17:903:2307:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-29b7b0e360cmr4771155ad.6.1763999444236; Mon, 24 Nov 2025
 07:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122074029.3948921-1-senozhatsky@chromium.org> <20251122074029.3948921-3-senozhatsky@chromium.org>
In-Reply-To: <20251122074029.3948921-3-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 24 Nov 2025 10:50:07 -0500
X-Gm-Features: AWmQ_bnhIJCH4WCGbQ-G4XcJu6360z_7NhMLl3znPaAnQ2dVfHn7kg9jFhMwxaQ
Message-ID: <CADyq12wLaGjbPqpXbWOsiAD3SUD1NKZvzZayFYx3TPECptXC8A@mail.gmail.com>
Subject: Re: [PATCHv6 2/6] zram: add writeback batch size device attr
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, Richard Chang <richardycc@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 2:40=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Introduce writeback_batch_size device attribute so that
> the maximum number of in-flight writeback bio requests
> can be configured at run-time per-device.  This essentially
> enables batched bio writeback.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 46 ++++++++++++++++++++++++++++++-----
>  drivers/block/zram/zram_drv.h |  1 +
>  2 files changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 06ea56f0a00f..5906ba061165 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -590,6 +590,40 @@ static ssize_t writeback_limit_show(struct device *d=
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
> +
> +       if (kstrtouint(buf, 10, &val))
> +               return -EINVAL;
> +
> +       if (!val)
> +               return -EINVAL;
> +
> +       down_write(&zram->init_lock);
> +       zram->wb_batch_size =3D val;
> +       up_write(&zram->init_lock);
> +
> +       return len;
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
> @@ -781,10 +815,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ct=
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
> @@ -799,7 +830,7 @@ static struct zram_wb_ctl *init_wb_ctl(void)
>         init_waitqueue_head(&wb_ctl->done_wait);
>         spin_lock_init(&wb_ctl->done_lock);
>
> -       for (i =3D 0; i < ZRAM_WB_REQ_CNT; i++) {
> +       for (i =3D 0; i < zram->wb_batch_size; i++) {
>                 struct zram_wb_req *req;
>
>                 /*
> @@ -1200,7 +1231,7 @@ static ssize_t writeback_store(struct device *dev,
>                 goto release_init_lock;
>         }
>
> -       wb_ctl =3D init_wb_ctl();
> +       wb_ctl =3D init_wb_ctl(zram);
>         if (!wb_ctl) {
>                 ret =3D -ENOMEM;
>                 goto release_init_lock;
> @@ -2843,6 +2874,7 @@ static DEVICE_ATTR_RW(backing_dev);
>  static DEVICE_ATTR_WO(writeback);
>  static DEVICE_ATTR_RW(writeback_limit);
>  static DEVICE_ATTR_RW(writeback_limit_enable);
> +static DEVICE_ATTR_RW(writeback_batch_size);
>  #endif
>  #ifdef CONFIG_ZRAM_MULTI_COMP
>  static DEVICE_ATTR_RW(recomp_algorithm);
> @@ -2864,6 +2896,7 @@ static struct attribute *zram_disk_attrs[] =3D {
>         &dev_attr_writeback.attr,
>         &dev_attr_writeback_limit.attr,
>         &dev_attr_writeback_limit_enable.attr,
> +       &dev_attr_writeback_batch_size.attr,
>  #endif
>         &dev_attr_io_stat.attr,
>         &dev_attr_mm_stat.attr,
> @@ -2925,6 +2958,7 @@ static int zram_add(void)
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
> 2.52.0.460.gd25c4c69ec-goog
>
