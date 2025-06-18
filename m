Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B52BD580
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256319; cv=none; b=KoDwzZ2zYf9/WzOxg0ZDY5asdJWdy500A+pUVwSu4/AVb6qhQ/7F2IPX4gvrb7SixXmbv7hycubS/SjcNWcx2veBNhrRf7UL8OFF+AFk+kDLfbIfc5F0AMhNpmYrGnxxhmgR9/2h+ucX+TlnR4+HqkToK2rxeabKQ7XT0vxgBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256319; c=relaxed/simple;
	bh=H3lmWShr7l75psc+udLRWTXcvWz7kolTwlubFeIDUmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvpzfxRXPl8C65Ys5GDhfLcsmMUFUk+YKhIO3+49H5Gc4iETHTLDmt0+LYtNe9KpCiZnpWX9RBIi3H37SsQuLU7NHH83uj5KSnApTgdCA33pqLtyuVZF2WPHxYt3D4/j2omCxLEE4j6991n/fkTE41I1LBYzFqimbzLNECZWke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWzxqVki; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWzxqVki"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2348ac8e0b4so141585ad.1
        for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750256316; x=1750861116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C29alPvuWAsgWqNpFNVeU/U6thFp3MX+IU13i3y/+zY=;
        b=sWzxqVkiPUarH8v/rrwRW2EPqpW4wO9IpS1VdX7vgSC3m3m8ku5NnhbXAc0LPPsIw8
         kIFxz2sNrLAdjdR+7/jLvBD2bsAg05l1tojffsQggDTwMNG+uuc0HlRNMXLYeOOrINQY
         dBR7GW+17/tlI1NGHp5jr7R0EWLOXyYeh61WtsUJl+Dnu/XljYvYm04Q4Jp8j9MRgOcP
         Qr/OfSmWNjBpYsmiQo8bTlxIde30QhJOsNgRWek6T2p0jjdGOBrIYEEUC9s3lcA3wswQ
         F6njk11OM8mxhdfxRV3jO2jbVp+Qtk8maeDK2NxXOffTlmMmwGycYXlhQHP5J1hLgXbV
         ntow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750256316; x=1750861116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C29alPvuWAsgWqNpFNVeU/U6thFp3MX+IU13i3y/+zY=;
        b=M6P0rhFIlzspupEHt2LYoW07Xwmaw9TvY1w1/Nn20g6W8b3POPLElSosLYnWAjQfnj
         nLjO6EzLLE+srllP892d2CiZvvVAS2y2bCw/0qHpzzCRicu5Umzaeo7+/FAmspQ1XdRD
         Tn8MiYpn+7NsOWKSJZs7HSvgCPtg5bysBPeqVdKKLFbDqIxBib6bGBnR0DPYZAArk3kW
         MNjNu1ZEIO1HndWsdhTZRj88nr7zLwnMaTsTbIEI5x48yLLOpQbFk1+xAWu7V0Mpbq/Z
         8dpNbRCeRbyYWgWHCvypu9gVWHApP5iSvv9quyMz4qIa7qcu5j6KtLjeeEUJTLBGiDGU
         Y5mg==
X-Forwarded-Encrypted: i=1; AJvYcCUWrX0khthYk6PR80COwyzKXhWbLahbDYxumY+iByDe3Z2nFXKDcgshOcvKveYz6SWsCDhNfjNxwck1wA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7yiOexaaBz/AGk4Izjs+vxUtrG2yqPn2P1Sa3bI5dRnu5DHn
	HAZ7Qr8WLMGty4vmAZiImDxfMLXSy66yTMSfRAhemgajKPUox6Z9luIcMYsRbAI7BOgPn55zsdy
	h3KxxHlyEamfLfRLxZMCTzUp8FxAUOS3jq07ieOIV
X-Gm-Gg: ASbGnctGOO75VtPss3MN7kFbeb9qchMoFR7kaGr+4zwP9e/4qFbmBAz9d3GNZPnXzf1
	sRR4wlYSVjc1V1E1SUADEjrrfP1z7XbxjjvlEj7lPfV6sVum5/CZtSFjTzv2EHwIdMPpb/kgldB
	rtHi7neuOwxbVpilvvDNTYMbb+wxeqDdAIFoiK3DQ25g==
X-Google-Smtp-Source: AGHT+IGofuCzUMfCL28QQ0u79t8TUkraUVw2DxuR2W2rjWMvninI87ZKHcCtMZgvTmG8vjr3egi//++sjhIJDNBS9tk=
X-Received: by 2002:a17:903:19e4:b0:235:e1fa:1fbc with SMTP id
 d9443c01a7336-2366c4c2c44mr13624995ad.0.1750256315936; Wed, 18 Jun 2025
 07:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618132622.3730219-1-richardycc@google.com>
In-Reply-To: <20250618132622.3730219-1-richardycc@google.com>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 18 Jun 2025 10:17:58 -0400
X-Gm-Features: AX0GCFtis-kkFK1LNQ0bx-eYe2BKXBWowWxmquQswBqymBFk97gV1jRiPdiiZ1E
Message-ID: <CADyq12ycDZ8E+LNqoMScuCrUK-u4f6yXzxp6CLZCZQH+uk3-Kg@mail.gmail.com>
Subject: Re: [PATCH] zram: support asynchronous writeback
To: Richard Chang <richardycc@google.com>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please include linux-mm on future patches.

On Wed, Jun 18, 2025 at 9:26=E2=80=AFAM Richard Chang <richardycc@google.co=
m> wrote:
>
> This commit introduces asynchronous writeback to zram, improving the
> idle writeback speed.
>
> Key changes include:
>
> * Replacing `submit_bio_wait()` with `submit_bio()` to enable
>   non-blocking writeback operations.
> * Utilizing a dedicated kthread for post-writeback tasks, avoiding
>   potential lock contention in interrupt context.
> * Refactoring writeback-related code into a separate file `zram_wb.c`,
>   for better organization and maintainability.
>
> Signed-off-by: Richard Chang <richardycc@google.com>
> ---
>  drivers/block/zram/Makefile   |   1 +
>  drivers/block/zram/zram_drv.c | 142 ++++++++--------------
>  drivers/block/zram/zram_drv.h |  37 ++++++
>  drivers/block/zram/zram_wb.c  | 222 ++++++++++++++++++++++++++++++++++
>  drivers/block/zram/zram_wb.h  |  41 +++++++
>  5 files changed, 353 insertions(+), 90 deletions(-)
>  create mode 100644 drivers/block/zram/zram_wb.c
>  create mode 100644 drivers/block/zram/zram_wb.h
>
> diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
> index 0fdefd576691..31ee1ed34e17 100644
> --- a/drivers/block/zram/Makefile
> +++ b/drivers/block/zram/Makefile
> @@ -8,5 +8,6 @@ zram-$(CONFIG_ZRAM_BACKEND_LZ4HC)       +=3D backend_lz4h=
c.o
>  zram-$(CONFIG_ZRAM_BACKEND_ZSTD)       +=3D backend_zstd.o
>  zram-$(CONFIG_ZRAM_BACKEND_DEFLATE)    +=3D backend_deflate.o
>  zram-$(CONFIG_ZRAM_BACKEND_842)                +=3D backend_842.o
> +zram-$(CONFIG_ZRAM_WRITEBACK)          +=3D zram_wb.o
>
>  obj-$(CONFIG_ZRAM)     +=3D      zram.o
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 54c57103715f..1cdebff13049 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -36,6 +36,7 @@
>  #include <linux/kernel_read_file.h>
>
>  #include "zram_drv.h"
> +#include "zram_wb.h"
>
>  static DEFINE_IDR(zram_index_idr);
>  /* idr index must be protected */
> @@ -56,7 +57,6 @@ static size_t huge_class_size;
>
>  static const struct block_device_operations zram_devops;
>
> -static void zram_free_page(struct zram *zram, size_t index);
>  static int zram_read_from_zspool(struct zram *zram, struct page *page,
>                                  u32 index);
>
> @@ -95,7 +95,7 @@ static __must_check bool zram_slot_trylock(struct zram =
*zram, u32 index)
>         return false;
>  }
>
> -static void zram_slot_lock(struct zram *zram, u32 index)
> +void zram_slot_lock(struct zram *zram, u32 index)
>  {
>         unsigned long *lock =3D &zram->table[index].flags;
>
> @@ -104,7 +104,7 @@ static void zram_slot_lock(struct zram *zram, u32 ind=
ex)
>         lock_acquired(slot_dep_map(zram, index), _RET_IP_);
>  }
>
> -static void zram_slot_unlock(struct zram *zram, u32 index)
> +void zram_slot_unlock(struct zram *zram, u32 index)
>  {
>         unsigned long *lock =3D &zram->table[index].flags;
>
> @@ -127,19 +127,17 @@ static unsigned long zram_get_handle(struct zram *z=
ram, u32 index)
>         return zram->table[index].handle;
>  }
>
> -static void zram_set_handle(struct zram *zram, u32 index, unsigned long =
handle)
> +void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
>  {
>         zram->table[index].handle =3D handle;
>  }
>
> -static bool zram_test_flag(struct zram *zram, u32 index,
> -                       enum zram_pageflags flag)
> +bool zram_test_flag(struct zram *zram, u32 index, enum zram_pageflags fl=
ag)
>  {
>         return zram->table[index].flags & BIT(flag);
>  }
>
> -static void zram_set_flag(struct zram *zram, u32 index,
> -                       enum zram_pageflags flag)
> +void zram_set_flag(struct zram *zram, u32 index, enum zram_pageflags fla=
g)
>  {
>         zram->table[index].flags |=3D BIT(flag);
>  }
> @@ -233,22 +231,6 @@ static void zram_accessed(struct zram *zram, u32 ind=
ex)
>  }
>
>  #if defined CONFIG_ZRAM_WRITEBACK || defined CONFIG_ZRAM_MULTI_COMP
> -struct zram_pp_slot {
> -       unsigned long           index;
> -       struct list_head        entry;
> -};
> -
> -/*
> - * A post-processing bucket is, essentially, a size class, this defines
> - * the range (in bytes) of pp-slots sizes in particular bucket.
> - */
> -#define PP_BUCKET_SIZE_RANGE   64
> -#define NUM_PP_BUCKETS         ((PAGE_SIZE / PP_BUCKET_SIZE_RANGE) + 1)
> -
> -struct zram_pp_ctl {
> -       struct list_head        pp_buckets[NUM_PP_BUCKETS];
> -};
> -
>  static struct zram_pp_ctl *init_pp_ctl(void)
>  {
>         struct zram_pp_ctl *ctl;
> @@ -258,15 +240,20 @@ static struct zram_pp_ctl *init_pp_ctl(void)
>         if (!ctl)
>                 return NULL;
>
> +       init_completion(&ctl->all_done);
> +       atomic_set(&ctl->num_pp_slots, 0);
>         for (idx =3D 0; idx < NUM_PP_BUCKETS; idx++)
>                 INIT_LIST_HEAD(&ctl->pp_buckets[idx]);
>         return ctl;
>  }
>
> -static void release_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
> +static void remove_pp_slot_from_ctl(struct zram_pp_slot *pps)
>  {
>         list_del_init(&pps->entry);
> +}
>
> +void free_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
> +{
>         zram_slot_lock(zram, pps->index);
>         zram_clear_flag(zram, pps->index, ZRAM_PP_SLOT);
>         zram_slot_unlock(zram, pps->index);
> @@ -274,7 +261,13 @@ static void release_pp_slot(struct zram *zram, struc=
t zram_pp_slot *pps)
>         kfree(pps);
>  }
>
> -static void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl)
> +static void release_pp_slot(struct zram *zram, struct zram_pp_slot *pps)
> +{
> +       remove_pp_slot_from_ctl(pps);
> +       free_pp_slot(zram, pps);
> +}
> +
> +void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl)
>  {
>         u32 idx;
>
> @@ -312,6 +305,7 @@ static bool place_pp_slot(struct zram *zram, struct z=
ram_pp_ctl *ctl,
>         list_add(&pps->entry, &ctl->pp_buckets[bid]);
>
>         zram_set_flag(zram, pps->index, ZRAM_PP_SLOT);
> +       atomic_inc(&ctl->num_pp_slots);
>         return true;
>  }
>
> @@ -713,7 +707,7 @@ static unsigned long alloc_block_bdev(struct zram *zr=
am)
>         return blk_idx;
>  }
>
> -static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
> +void free_block_bdev(struct zram *zram, unsigned long blk_idx)
>  {
>         int was_set;
>
> @@ -737,18 +731,18 @@ static void read_from_bdev_async(struct zram *zram,=
 struct page *page,
>  static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *c=
tl)
>  {
>         unsigned long blk_idx =3D 0;
> -       struct page *page =3D NULL;
>         struct zram_pp_slot *pps;
> -       struct bio_vec bio_vec;
> -       struct bio bio;
> -       int ret =3D 0, err;
> +       int ret =3D 0;
>         u32 index;
> +       int nr_pps =3D atomic_read(&ctl->num_pp_slots);
>
> -       page =3D alloc_page(GFP_KERNEL);
> -       if (!page)
> -               return -ENOMEM;
> +       if (!nr_pps)
> +               return 0;
>
>         while ((pps =3D select_pp_slot(ctl))) {
> +               struct zram_wb_request *req;
> +               struct page *page;
> +
>                 spin_lock(&zram->wb_limit_lock);
>                 if (zram->wb_limit_enable && !zram->bd_wb_limit) {
>                         spin_unlock(&zram->wb_limit_lock);
> @@ -765,6 +759,13 @@ static int zram_writeback_slots(struct zram *zram, s=
truct zram_pp_ctl *ctl)
>                         }
>                 }
>
> +               req =3D alloc_wb_request(zram, pps, ctl, blk_idx);
> +               if (IS_ERR(req)) {
> +                       ret =3D PTR_ERR(req);
> +                       break;
> +               }
> +               page =3D bio_first_page_all(req->bio);
> +
>                 index =3D pps->index;
>                 zram_slot_lock(zram, index);
>                 /*
> @@ -779,63 +780,28 @@ static int zram_writeback_slots(struct zram *zram, =
struct zram_pp_ctl *ctl)
>                         goto next;
>                 zram_slot_unlock(zram, index);
>
> -               bio_init(&bio, zram->bdev, &bio_vec, 1,
> -                        REQ_OP_WRITE | REQ_SYNC);
> -               bio.bi_iter.bi_sector =3D blk_idx * (PAGE_SIZE >> 9);
> -               __bio_add_page(&bio, page, PAGE_SIZE, 0);
> -
> -               /*
> -                * XXX: A single page IO would be inefficient for write
> -                * but it would be not bad as starter.
> -                */
> -               err =3D submit_bio_wait(&bio);
> -               if (err) {
> -                       release_pp_slot(zram, pps);
> -                       /*
> -                        * BIO errors are not fatal, we continue and simp=
ly
> -                        * attempt to writeback the remaining objects (pa=
ges).
> -                        * At the same time we need to signal user-space =
that
> -                        * some writes (at least one, but also could be a=
ll of
> -                        * them) were not successful and we do so by retu=
rning
> -                        * the most recent BIO error.
> -                        */
> -                       ret =3D err;
> -                       continue;
> -               }
> -
> -               atomic64_inc(&zram->stats.bd_writes);
> -               zram_slot_lock(zram, index);
> -               /*
> -                * Same as above, we release slot lock during writeback s=
o
> -                * slot can change under us: slot_free() or slot_free() a=
nd
> -                * reallocation (zram_write_page()). In both cases slot l=
oses
> -                * ZRAM_PP_SLOT flag. No concurrent post-processing can s=
et
> -                * ZRAM_PP_SLOT on such slots until current post-processi=
ng
> -                * finishes.
> -                */
> -               if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
> -                       goto next;
> -
> -               zram_free_page(zram, index);
> -               zram_set_flag(zram, index, ZRAM_WB);
> -               zram_set_handle(zram, index, blk_idx);
> +               nr_pps--;
> +               remove_pp_slot_from_ctl(pps);
>                 blk_idx =3D 0;
> -               atomic64_inc(&zram->stats.pages_stored);
> -               spin_lock(&zram->wb_limit_lock);
> -               if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
> -                       zram->bd_wb_limit -=3D  1UL << (PAGE_SHIFT - 12);
> -               spin_unlock(&zram->wb_limit_lock);
> +               submit_bio(req->bio);
> +               continue;
> +
>  next:
>                 zram_slot_unlock(zram, index);
>                 release_pp_slot(zram, pps);
> +               free_wb_request(req);
>
>                 cond_resched();
>         }
>
>         if (blk_idx)
>                 free_block_bdev(zram, blk_idx);
> -       if (page)
> -               __free_page(page);
> +
> +       if (nr_pps && atomic_sub_and_test(nr_pps, &ctl->num_pp_slots))
> +               complete(&ctl->all_done);
> +
> +       /* wait until all async bios completed */
> +       wait_for_completion(&ctl->all_done);
>
>         return ret;
>  }
> @@ -1111,8 +1077,6 @@ static int read_from_bdev(struct zram *zram, struct=
 page *page,
>  {
>         return -EIO;
>  }
> -
> -static void free_block_bdev(struct zram *zram, unsigned long blk_idx) {}=
;
>  #endif
>
>  #ifdef CONFIG_ZRAM_MEMORY_TRACKING
> @@ -1620,7 +1584,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 =
disksize)
>         return true;
>  }
>
> -static void zram_free_page(struct zram *zram, size_t index)
> +void zram_free_page(struct zram *zram, size_t index)
>  {
>         unsigned long handle;
>
> @@ -2247,12 +2211,6 @@ static ssize_t recompress_store(struct device *dev=
,
>                 goto release_init_lock;
>         }
>
> -       page =3D alloc_page(GFP_KERNEL);
> -       if (!page) {
> -               ret =3D -ENOMEM;
> -               goto release_init_lock;
> -       }
> -
>         ctl =3D init_pp_ctl();
>         if (!ctl) {
>                 ret =3D -ENOMEM;
> @@ -2912,6 +2870,9 @@ static int __init zram_init(void)
>                 num_devices--;
>         }
>
> +       if (setup_zram_writeback())
> +               goto out_error;
> +
>         return 0;
>
>  out_error:
> @@ -2921,6 +2882,7 @@ static int __init zram_init(void)
>
>  static void __exit zram_exit(void)
>  {
> +       destroy_zram_writeback();
>         destroy_devices();
>  }
>
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.=
h
> index 6cee93f9c0d0..7d9081215668 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -139,4 +139,41 @@ struct zram {
>  #endif
>         atomic_t pp_in_progress;
>  };
> +
> +void zram_slot_lock(struct zram *zram, u32 index);
> +void zram_slot_unlock(struct zram *zram, u32 index);
> +void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)=
;
> +bool zram_test_flag(struct zram *zram, u32 index, enum zram_pageflags fl=
ag);
> +void zram_set_flag(struct zram *zram, u32 index, enum zram_pageflags fla=
g);
> +void zram_free_page(struct zram *zram, size_t index);
> +
> +#if defined CONFIG_ZRAM_WRITEBACK || defined CONFIG_ZRAM_MULTI_COMP
> +struct zram_pp_slot {
> +       unsigned long           index;
> +       struct list_head        entry;
> +};
> +
> +/*
> + * A post-processing bucket is, essentially, a size class, this defines
> + * the range (in bytes) of pp-slots sizes in particular bucket.
> + */
> +#define PP_BUCKET_SIZE_RANGE   64
> +#define NUM_PP_BUCKETS         ((PAGE_SIZE / PP_BUCKET_SIZE_RANGE) + 1)
> +
> +struct zram_pp_ctl {
> +       struct list_head        pp_buckets[NUM_PP_BUCKETS];
> +       struct completion       all_done;
> +       atomic_t                num_pp_slots;
> +};
> +
> +void free_pp_slot(struct zram *zram, struct zram_pp_slot *pps);
> +void release_pp_ctl(struct zram *zram, struct zram_pp_ctl *ctl);
> +#endif
> +
> +#if IS_ENABLED(CONFIG_ZRAM_WRITEBACK)
> +void free_block_bdev(struct zram *zram, unsigned long blk_idx);
> +#else
> +inline void free_block_bdev(struct zram *zram, unsigned long blk_idx) {}=
;
> +#endif
> +
>  #endif
> diff --git a/drivers/block/zram/zram_wb.c b/drivers/block/zram/zram_wb.c
> new file mode 100644
> index 000000000000..59f93b22d2bf
> --- /dev/null
> +++ b/drivers/block/zram/zram_wb.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define KMSG_COMPONENT "zram_wb"
> +#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/wait.h>
> +#include <linux/freezer.h>
> +
> +#include "zram_wb.h"
> +
> +static struct task_struct *wb_thread;
> +static DECLARE_WAIT_QUEUE_HEAD(wb_wq);
> +static struct zram_wb_request_list wb_req_list;
> +
> +static void complete_wb_request(struct zram_wb_request *req)
> +{
> +       struct zram *zram =3D req->zram;
> +       struct zram_pp_slot *pps =3D req->pps;
> +       struct zram_pp_ctl *ctl =3D req->ppctl;
> +       unsigned long index =3D pps->index;
> +       unsigned long blk_idx =3D req->blk_idx;
> +       struct bio *bio =3D req->bio;
> +
> +       if (bio->bi_status)
> +               goto out_err;
> +
> +       atomic64_inc(&zram->stats.bd_writes);
> +       zram_slot_lock(zram, index);
> +
> +       /*
> +        * Same as above, we release slot lock during writeback so
> +        * slot can change under us: slot_free() or slot_free() and
> +        * reallocation (zram_write_page()). In both cases slot loses
> +        * ZRAM_PP_SLOT flag. No concurrent post-processing can set
> +        * ZRAM_PP_SLOT on such slots until current post-processing
> +        * finishes.
> +        */
> +       if (!zram_test_flag(zram, index, ZRAM_PP_SLOT)) {
> +               zram_slot_unlock(zram, index);
> +               goto out_err;
> +       }
> +
> +       zram_free_page(zram, index);
> +       zram_set_flag(zram, index, ZRAM_WB);
> +       zram_set_handle(zram, index, blk_idx);
> +       atomic64_inc(&zram->stats.pages_stored);
> +       spin_lock(&zram->wb_limit_lock);
> +       if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
> +               zram->bd_wb_limit -=3D  1UL << (PAGE_SHIFT - 12);
> +       spin_unlock(&zram->wb_limit_lock);
> +       zram_slot_unlock(zram, index);
> +       goto end;
> +
> +out_err:
> +       free_block_bdev(zram, blk_idx);
> +end:
> +       free_pp_slot(zram, pps);
> +       free_wb_request(req);
> +
> +       if (atomic_dec_and_test(&ctl->num_pp_slots))
> +               complete(&ctl->all_done);
> +}
> +
> +static void enqueue_wb_request(struct zram_wb_request_list *req_list,
> +                              struct zram_wb_request *req)
> +{
> +       /*
> +        * The enqueue path comes from softirq context:
> +        * blk_done_softirq -> bio_endio -> zram_writeback_end_io
> +        * Use spin_lock_bh for locking.
> +        */
> +       spin_lock_bh(&req_list->lock);
> +       list_add_tail(&req->node, &req_list->head);
> +       req_list->count++;
> +       spin_unlock_bh(&req_list->lock);
> +}
> +
> +static struct zram_wb_request *dequeue_wb_request(
> +       struct zram_wb_request_list *req_list)
> +{
> +       struct zram_wb_request *req =3D NULL;
> +
> +       spin_lock_bh(&req_list->lock);
> +       if (!list_empty(&req_list->head)) {
> +               req =3D list_first_entry(&req_list->head,
> +                                      struct zram_wb_request,
> +                                      node);
> +               list_del(&req->node);
> +               req_list->count--;
> +       }
> +       spin_unlock_bh(&req_list->lock);
> +
> +       return req;
> +}
> +
> +static void destroy_wb_request_list(struct zram_wb_request_list *req_lis=
t)
> +{
> +       struct zram_wb_request *req;
> +
> +       while (!list_empty(&req_list->head)) {
> +               req =3D dequeue_wb_request(req_list);
> +               free_block_bdev(req->zram, req->blk_idx);
> +               free_wb_request(req);
> +       }
> +}
> +
> +static bool wb_ready_to_run(void)
> +{
> +       int count;
> +
> +       spin_lock_bh(&wb_req_list.lock);
> +       count =3D wb_req_list.count;
> +       spin_unlock_bh(&wb_req_list.lock);
> +
> +       return count > 0;
> +}
> +
> +static int wb_thread_func(void *data)
> +{
> +       set_freezable();
> +
> +       while (!kthread_should_stop()) {
> +               wait_event_freezable(wb_wq, wb_ready_to_run());
> +
> +               while (1) {
> +                       struct zram_wb_request *req;
> +
> +                       req =3D dequeue_wb_request(&wb_req_list);
> +                       if (!req)
> +                               break;
> +                       complete_wb_request(req);
> +               }
> +       }
> +       return 0;
> +}
> +
> +void zram_writeback_end_io(struct bio *bio)
> +{
> +       struct zram_wb_request *req =3D
> +               (struct zram_wb_request *)bio->bi_private;
> +
> +       enqueue_wb_request(&wb_req_list, req);
> +       wake_up(&wb_wq);
> +}
> +
> +struct zram_wb_request *alloc_wb_request(struct zram *zram,
> +                                        struct zram_pp_slot *pps,
> +                                        struct zram_pp_ctl *ppctl,
> +                                        unsigned long blk_idx)
> +{
> +       struct zram_wb_request *req;
> +       struct page *page;
> +       struct bio *bio;
> +       int err =3D 0;
> +
> +       page =3D alloc_page(GFP_NOIO | __GFP_NOWARN);
> +       if (!page)
> +               return ERR_PTR(-ENOMEM);
> +
> +       bio =3D bio_alloc(zram->bdev, 1, REQ_OP_WRITE, GFP_NOIO | __GFP_N=
OWARN);
> +       if (!bio) {
> +               err =3D -ENOMEM;
> +               goto out_free_page;
> +       }
> +
> +       req =3D kmalloc(sizeof(struct zram_wb_request), GFP_NOIO | __GFP_=
NOWARN);
> +       if (!req) {
> +               err =3D -ENOMEM;
> +               goto out_free_bio;
> +       }
> +       req->zram =3D zram;
> +       req->pps =3D pps;
> +       req->ppctl =3D ppctl;
> +       req->blk_idx =3D blk_idx;
> +       req->bio =3D bio;
> +
> +       bio->bi_iter.bi_sector =3D blk_idx * (PAGE_SIZE >> 9);
> +       __bio_add_page(bio, page, PAGE_SIZE, 0);
> +       bio->bi_private =3D req;
> +       bio->bi_end_io =3D zram_writeback_end_io;
> +       return req;
> +
> +out_free_bio:
> +       bio_put(bio);
> +out_free_page:
> +       __free_page(page);
> +       return ERR_PTR(err);
> +}
> +
> +void free_wb_request(struct zram_wb_request *req)
> +{
> +       struct bio *bio =3D req->bio;
> +       struct page *page =3D bio_first_page_all(bio);
> +
> +       __free_page(page);
> +       bio_put(bio);
> +       kfree(req);
> +}
> +
> +int setup_zram_writeback(void)
> +{
> +       spin_lock_init(&wb_req_list.lock);
> +       INIT_LIST_HEAD(&wb_req_list.head);
> +       wb_req_list.count =3D 0;
> +
> +       wb_thread =3D kthread_run(wb_thread_func, NULL, "zram_wb_thread")=
;
> +       if (IS_ERR(wb_thread)) {
> +               pr_err("Unable to create zram_wb_thread\n");
> +               return -1;
> +       }
> +       return 0;
> +}
> +
> +void destroy_zram_writeback(void)
> +{
> +       kthread_stop(wb_thread);
> +       destroy_wb_request_list(&wb_req_list);
> +}
> +
> diff --git a/drivers/block/zram/zram_wb.h b/drivers/block/zram/zram_wb.h
> new file mode 100644
> index 000000000000..e029b4de0de6
> --- /dev/null
> +++ b/drivers/block/zram/zram_wb.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef _ZRAM_WRITEBACK_H_
> +#define _ZRAM_WRITEBACK_H_
> +
> +#include <linux/bio.h>
> +#include "zram_drv.h"
> +
> +struct zram_wb_request;
> +
> +struct zram_wb_request {
> +       struct zram *zram;
> +       unsigned long blk_idx;
> +       struct zram_pp_slot *pps;
> +       struct zram_pp_ctl *ppctl;
> +       struct bio *bio;
> +       struct list_head node;
> +};
> +
> +struct zram_wb_request_list {
> +       struct list_head head;
> +       int count;
> +       spinlock_t lock;
> +};
> +
> +#if IS_ENABLED(CONFIG_ZRAM_WRITEBACK)
> +void zram_writeback_end_io(struct bio *bio);
> +int setup_zram_writeback(void);
> +void destroy_zram_writeback(void);
> +struct zram_wb_request *alloc_wb_request(struct zram *zram,
> +                                        struct zram_pp_slot *pps,
> +                                        struct zram_pp_ctl *ppctl,
> +                                        unsigned long blk_idx);
> +void free_wb_request(struct zram_wb_request *req);
> +#else
> +inline void zram_writeback_end_io(struct bio *bio) {}
> +inline int setup_zram_writeback(void) { return 0; }
> +inline void destroy_zram_writeback(void) {}
> +#endif
> +
> +#endif /* _ZRAM_WRITEBACK_H_ */
> --
> 2.50.0.rc2.696.g1fc2a0284f-goog
>
