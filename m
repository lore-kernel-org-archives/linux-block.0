Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46603328F8
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654664; cv=none; b=DpOggsjXZVMvUku406LA7nYOkUiPq21r5t158ySsvAFRoiCHkBiTuCf1+An2Ru2CKZ43G0L/zcKaf75OJIA+jwrs0xdNBOapU8yiKIMwP/mxU+cJud+cuM7ino9hKZfEVoSxt01cmixTdI+mTQslmy7n5P7PM8azjXvEWdqvhvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654664; c=relaxed/simple;
	bh=afN81rjdYEmblOEhDtwXQAQa9IiXOEiSFtKZPDBOoy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxrEdWEZfovJ8dTtmmvNflRicpcYoZO9Kxc9UKToGPeoK5LiCqHgsdJ6EMrjWoxPeCQSbLaneM3+7OhdrsuqiB618YsA6dmfTPTdsFCgXl5tD+T7r1SL9YfjyVYurEcUrIqzqm5DWnQRVsDV0pi1Ydzc5K/Y1rjZCwmO/Vg09G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35IJhw04; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35IJhw04"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297e13bf404so226515ad.0
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763654662; x=1764259462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tTnphYAjSEIlq29e/RZNkDqM0RoIUblA3M5I8Z71iM=;
        b=35IJhw04T2wLGCKRSZwHuIw6YWQuxmNzbz2GsMdnjM5DBOCkhhGDIMUgDYwlbCCB4i
         2AXdqw+ELvWMEF0L3JadDxnRsMpundRYVsS3HoJyMqMueU3KkgatKT3VTwZn1J3GNYkv
         ZU8zmqzJbnpz4Uj8Z1V2OLXobSk0etqjSY/+jpXyN4FIwQhYulk5Ot043d9vkRYEy1O3
         mNiSCCRYLY6wX6TdEvByZeMStVDtY1u5S8yuSug5ZzW4hX2jF7J7HexM1aQZm9S76CIf
         N2p6BmSUO+42l3hUiwmk4IK0+NAaWxxhMs1Bz0aUR37Lmd9QEXGmJ31wCgreKQ8iA4X5
         7TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654662; x=1764259462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9tTnphYAjSEIlq29e/RZNkDqM0RoIUblA3M5I8Z71iM=;
        b=g/WvI/EV6viLpZvEyxxr8DxUOmUa27m5OpOg4BFPGXmHWIZH+evNHXCJ8o2rAyEhTP
         gJ/Ctz+Fxu93G4Nc38u9ykXbzyvqvoD6bE5E5Fu5JPkQSiCdwoD6kyyTi6SMfs6OSFA/
         ihMH3WX/PfS7lx200ZRT8UstQQ4bzKmRkjnldgWS/6PcTayPM/gM3swoXq3o4nxSz7NG
         ZQk2wiSdd+xBi1hGXRfu/zLp19EIlA2LpWH5ajZB7hC4YefkSRLTsnjX28fWHO+ue3/X
         oXPQ+fHcsE/k5/F9gmGGPuH5P+esGdzc8camwJVjIEtPoDKIBVucmBeC71W7N+ddUmaz
         oKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkSH9Bg1LNyl597GBkznWt6CNNRyBuvwycRXRkyiAi4McerBJDNu0I1texDIpfaGfRT8YxoxBAHmPh7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yymy1N06Xsti2ud3qm/VPkm/+Dn3CwSQeWaPgXcS8cn9f6sCLTc
	iutBi8qVPJRac5IT/G4O3jGDLNKRGRS6ZZklydYl7QhBrGjDtT0Sb6M7YG55mKVUc8Qs3H0cZaR
	a8jHL64mKyGfyXch5U9iBB16c2IgQkPL9q7oQUy3l
X-Gm-Gg: ASbGncsZltLxNPfyZaAU02gM3Ngmjop5vuMi33jRtBKx7LlwouU4PNCJbNptnQrrxDK
	D/7tXRXM30q00fALNGB2q5FKtlyrhOOy8yQr6TZFts9SwPAov1Dqf5B1/brz2g0M1L4ef2vEXmU
	ENg8/mCbHdKdghqRIajTcoEQCC/Vc8aghG5eNVfdyy6UD9YKmDEvun0t5UstxR+4IN8mYzY8niu
	ROrTNzOSG+BvD25h0OfE0v8lvrAypeIkGKTYlsVHYzuMJN07M9g3/Pm1SmEltEWNhKN50MMW2Mv
	Y+rZR4VEdM2/dBudIhBdu/yH7lU9iVQh2hmqf5Sr7Vux2eXntNrnIgawLrkbq388nA==
X-Google-Smtp-Source: AGHT+IHynUK9sczZUoHA1q0ZmAGJEkBtS+4w0KysGJmGJqLQZwN0evaYPxUk6LKTwoHSjjG1XrM21cp8YOCaxEByK8w=
X-Received: by 2002:a17:902:ea0c:b0:29a:7af:b3e6 with SMTP id
 d9443c01a7336-29b5c57c4fbmr3798365ad.20.1763654661858; Thu, 20 Nov 2025
 08:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120152126.3126298-1-senozhatsky@chromium.org> <20251120152126.3126298-5-senozhatsky@chromium.org>
In-Reply-To: <20251120152126.3126298-5-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Thu, 20 Nov 2025 11:03:45 -0500
X-Gm-Features: AWmQ_bk3tvcnm3lpvg41Hc69Iz4axfRrW4CpsfaVs1tHFtQsZ0HV9ebluIJicUU
Message-ID: <CADyq12zxgAAHWn61wECEo=StOm2DAEFU_qUL83tv0aT5S9mb0w@mail.gmail.com>
Subject: Re: [RFC PATCHv5 4/6] zram: drop wb_limit_lock
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
> We don't need wb_limit_lock.  Writeback limit setters take an
> exclusive write zram init_lock, while wb_limit modifications
> happen only from a single task and under zram read init_lock.
> No concurrent wb_limit modifications are possible (we permit
> only one post-processing task at a time).  Add lockdep
> assertions to wb_limit mutators.
>
> While at it, fixup coding styles.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 22 +++++-----------------
>  drivers/block/zram/zram_drv.h |  1 -
>  2 files changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 71f37b960812..671ef2ec9b11 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -530,9 +530,7 @@ static ssize_t writeback_limit_enable_store(struct de=
vice *dev,
>                 return ret;
>
>         down_write(&zram->init_lock);
> -       spin_lock(&zram->wb_limit_lock);
>         zram->wb_limit_enable =3D val;
> -       spin_unlock(&zram->wb_limit_lock);
>         up_write(&zram->init_lock);
>         ret =3D len;
>
> @@ -547,9 +545,7 @@ static ssize_t writeback_limit_enable_show(struct dev=
ice *dev,
>         struct zram *zram =3D dev_to_zram(dev);
>
>         down_read(&zram->init_lock);
> -       spin_lock(&zram->wb_limit_lock);
>         val =3D zram->wb_limit_enable;
> -       spin_unlock(&zram->wb_limit_lock);
>         up_read(&zram->init_lock);
>
>         return sysfs_emit(buf, "%d\n", val);
> @@ -567,9 +563,7 @@ static ssize_t writeback_limit_store(struct device *d=
ev,
>                 return ret;
>
>         down_write(&zram->init_lock);
> -       spin_lock(&zram->wb_limit_lock);
>         zram->bd_wb_limit =3D val;
> -       spin_unlock(&zram->wb_limit_lock);
>         up_write(&zram->init_lock);
>         ret =3D len;
>
> @@ -577,15 +571,13 @@ static ssize_t writeback_limit_store(struct device =
*dev,
>  }
>
>  static ssize_t writeback_limit_show(struct device *dev,
> -               struct device_attribute *attr, char *buf)
> +                                   struct device_attribute *attr, char *=
buf)
>  {
>         u64 val;
>         struct zram *zram =3D dev_to_zram(dev);
>
>         down_read(&zram->init_lock);
> -       spin_lock(&zram->wb_limit_lock);
>         val =3D zram->bd_wb_limit;
> -       spin_unlock(&zram->wb_limit_lock);
>         up_read(&zram->init_lock);
>
>         return sysfs_emit(buf, "%llu\n", val);
> @@ -869,18 +861,18 @@ static struct zram_wb_ctl *init_wb_ctl(struct zram =
*zram)
>
>  static void zram_account_writeback_rollback(struct zram *zram)
>  {
> -       spin_lock(&zram->wb_limit_lock);
> +       lockdep_assert_held_read(&zram->init_lock);
> +
>         if (zram->wb_limit_enable)
>                 zram->bd_wb_limit +=3D  1UL << (PAGE_SHIFT - 12);
> -       spin_unlock(&zram->wb_limit_lock);
>  }
>
>  static void zram_account_writeback_submit(struct zram *zram)
>  {
> -       spin_lock(&zram->wb_limit_lock);
> +       lockdep_assert_held_read(&zram->init_lock);
> +
>         if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
>                 zram->bd_wb_limit -=3D  1UL << (PAGE_SHIFT - 12);
> -       spin_unlock(&zram->wb_limit_lock);
>  }
>
>  static int zram_writeback_complete(struct zram *zram, struct zram_wb_req=
 *req)
> @@ -1004,13 +996,10 @@ static int zram_writeback_slots(struct zram *zram,
>         u32 index =3D 0;
>
>         while ((pps =3D select_pp_slot(ctl))) {
> -               spin_lock(&zram->wb_limit_lock);
>                 if (zram->wb_limit_enable && !zram->bd_wb_limit) {
> -                       spin_unlock(&zram->wb_limit_lock);
>                         ret =3D -EIO;
>                         break;
>                 }
> -               spin_unlock(&zram->wb_limit_lock);
>
>                 while (!req) {
>                         req =3D zram_select_idle_req(wb_ctl);
> @@ -2961,7 +2950,6 @@ static int zram_add(void)
>         init_rwsem(&zram->init_lock);
>  #ifdef CONFIG_ZRAM_WRITEBACK
>         zram->wb_batch_size =3D 32;
> -       spin_lock_init(&zram->wb_limit_lock);
>  #endif
>
>         /* gendisk structure */
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.=
h
> index 1a647f42c1a4..c6d94501376c 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -127,7 +127,6 @@ struct zram {
>         bool claim; /* Protected by disk->open_mutex */
>  #ifdef CONFIG_ZRAM_WRITEBACK
>         struct file *backing_dev;
> -       spinlock_t wb_limit_lock;
>         bool wb_limit_enable;
>         u32 wb_batch_size;
>         u64 bd_wb_limit;
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
