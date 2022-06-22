Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3BAC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 10:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352295AbiFVK6u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 06:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353225AbiFVK6Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 06:58:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DC460CB
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 03:58:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ej4so19387108edb.7
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dkmBvntP1l9wOYMv4OLFMt0Ky2rpOIxDn1wxdTQNElI=;
        b=YBBuiSzn2wMeaAANbdgp+hrNuYxFy5hdoB98+EyahYq7b35g7CZINWFb1+YgVGkHFt
         2YFFk4d0E0AZ76U8dCq9yK8QP3IHe+DvdzRWiiTmYj0Eb9yKwW2lNuS30OpqdQ+MbOq/
         WHO11VVVBBzGY0Bx9L1lD4u/jC4y/F92htY79Tay4KkeoKHcEViDC+tHlsVxB1mEFE6y
         0I0E9geDJ1ROXwk5eEf3Q5O+fCLVEtFru741HgTwdQozVIuqhanvuz0clUboHGokuqR5
         ULz/d8CV7bE9VoefTJVtkOSa4NvFwW8kPHwfxprumCv9q3ah5OFA1T26XfUGVCeVSeK6
         UFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dkmBvntP1l9wOYMv4OLFMt0Ky2rpOIxDn1wxdTQNElI=;
        b=ASY/uQNsq0mW+hywJ5OE8VPvzA4BqpmZGlf2AOPvNlbLDDuMgTBlx/7dUZc9emd+v9
         MxzWtIdow5XiyPqGd1xqJibTWhX6m8sZhyZsOO8dscMleBTW+ycgwtMneLZ0COp41wrU
         CWLyIH7BrHS1c6d1n2NUUVzac4NCeIbCuKkPLVeVP+8WZyOm+98L6FOWcvNJqL7suTqY
         X6KHNeSVuCCc9ADLnfhNatE8ugI8S5BapWxK1AQIAhRGKwQIg0FleeTSr2QV+gaUnVe1
         QDzB8aAlXzYuRYTRzf9JZ9mn+yUMNy0k9yRKzeiA7mX8QFKHSwJIl8CsqGypOQk5wU98
         DjVg==
X-Gm-Message-State: AJIora8DRPKAOX+9b4e1HQAfCtDUIl3hrTK2ITeq0j4jUMYRQpLuJMIO
        mUfX6WcZA41LZuBu3i2bECYjNlJZzT6le85QQ9DHNg==
X-Google-Smtp-Source: AGRyM1ulpHDVLw+UhweS8Wr6LkuurAKYR+PQ88L+4xglcEkwY+Mo2YzyoNuWp9/8ZelYt5Id0PiIiiAPCjna6M1YiCg=
X-Received: by 2002:a05:6402:1bcb:b0:435:8ec1:a580 with SMTP id
 ch11-20020a0564021bcb00b004358ec1a580mr3560908edb.68.1655895492368; Wed, 22
 Jun 2022 03:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220620034923.35633-1-guoqing.jiang@linux.dev> <20220620034923.35633-5-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-5-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 22 Jun 2022 12:58:01 +0200
Message-ID: <CAMGffEk_YySNSEsJoriE-+mZEVrbWuNF3OdacvZgorsVtuWcDA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] rnbd-clt: reduce the size of struct rnbd_clt_dev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 20, 2022 at 5:50 AM Guoqing Jiang <guoqing.jiang@linux.dev> wro=
te:
>
> Previously, both map and remap trigger rnbd_clt_set_dev_attr to set
> some members in rnbd_clt_dev such as wc, fua and logical_block_size
> etc, but those members are only useful for map scenario given the
> setup_request_queue is only called from the path:
>
> rnbd_clt_map_device -> rnbd_client_setup_device
>
> Since rnbd_clt_map_device frees rsp after rnbd_client_setup_device,
> we can pass rsp to rnbd_client_setup_device and it's callees, which
> means queue's attributes can be set directly from relevant members
> of rsp instead from rnbd_clt_dev.
>
> After that, we can kill 11 members from rnbd_clt_dev, and we don't
> need rnbd_clt_set_dev_attr either.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
lgtm
Acked-by: Jack Wang <jinpu.wang@ionos.com>

> ---
>  drivers/block/rnbd/rnbd-clt.c | 118 ++++++++++++++++------------------
>  drivers/block/rnbd/rnbd-clt.h |  11 ----
>  2 files changed, 55 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index 0bade2680eb9..2c63cd5ac09d 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -68,38 +68,12 @@ static inline bool rnbd_clt_get_dev(struct rnbd_clt_d=
ev *dev)
>         return refcount_inc_not_zero(&dev->refcount);
>  }
>
> -static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
> -                                const struct rnbd_msg_open_rsp *rsp)
> -{
> -       struct rnbd_clt_session *sess =3D dev->sess;
> -
> -       if (!rsp->logical_block_size)
> -               return -EINVAL;
> -
> -       dev->device_id              =3D le32_to_cpu(rsp->device_id);
> -       dev->nsectors               =3D le64_to_cpu(rsp->nsectors);
> -       dev->logical_block_size     =3D le16_to_cpu(rsp->logical_block_si=
ze);
> -       dev->physical_block_size    =3D le16_to_cpu(rsp->physical_block_s=
ize);
> -       dev->max_discard_sectors    =3D le32_to_cpu(rsp->max_discard_sect=
ors);
> -       dev->discard_granularity    =3D le32_to_cpu(rsp->discard_granular=
ity);
> -       dev->discard_alignment      =3D le32_to_cpu(rsp->discard_alignmen=
t);
> -       dev->secure_discard         =3D le16_to_cpu(rsp->secure_discard);
> -       dev->wc                     =3D !!(rsp->cache_policy & RNBD_WRITE=
BACK);
> -       dev->fua                    =3D !!(rsp->cache_policy & RNBD_FUA);
> -
> -       dev->max_hw_sectors =3D sess->max_io_size / SECTOR_SIZE;
> -       dev->max_segments =3D sess->max_segments;
> -
> -       return 0;
> -}
> -
>  static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
>                                     size_t new_nsectors)
>  {
> -       rnbd_clt_info(dev, "Device size changed from %zu to %zu sectors\n=
",
> -                      dev->nsectors, new_nsectors);
> -       dev->nsectors =3D new_nsectors;
> -       set_capacity_and_notify(dev->gd, dev->nsectors);
> +       rnbd_clt_info(dev, "Device size changed from %llu to %zu sectors\=
n",
> +                     get_capacity(dev->gd), new_nsectors);
> +       set_capacity_and_notify(dev->gd, new_nsectors);
>         return 0;
>  }
>
> @@ -123,15 +97,17 @@ static int process_msg_open_rsp(struct rnbd_clt_dev =
*dev,
>                  * If the device was remapped and the size changed in the
>                  * meantime we need to revalidate it
>                  */
> -               if (dev->nsectors !=3D nsectors)
> +               if (get_capacity(dev->gd) !=3D nsectors)
>                         rnbd_clt_change_capacity(dev, nsectors);
>                 gd_kobj =3D &disk_to_dev(dev->gd)->kobj;
>                 kobject_uevent(gd_kobj, KOBJ_ONLINE);
>                 rnbd_clt_info(dev, "Device online, device remapped succes=
sfully\n");
>         }
> -       err =3D rnbd_clt_set_dev_attr(dev, rsp);
> -       if (err)
> +       if (!rsp->logical_block_size) {
> +               err =3D -EINVAL;
>                 goto out;
> +       }
> +       dev->device_id =3D le32_to_cpu(rsp->device_id);
>         dev->dev_state =3D DEV_STATE_MAPPED;
>
>  out:
> @@ -970,10 +946,10 @@ static int rnbd_client_getgeo(struct block_device *=
block_device,
>                               struct hd_geometry *geo)
>  {
>         u64 size;
> -       struct rnbd_clt_dev *dev;
> +       struct rnbd_clt_dev *dev =3D block_device->bd_disk->private_data;
> +       struct queue_limits *limit =3D &dev->queue->limits;
>
> -       dev =3D block_device->bd_disk->private_data;
> -       size =3D dev->size * (dev->logical_block_size / SECTOR_SIZE);
> +       size =3D dev->size * (limit->logical_block_size / SECTOR_SIZE);
>         geo->cylinders  =3D size >> 6;    /* size/64 */
>         geo->heads      =3D 4;
>         geo->sectors    =3D 16;
> @@ -1357,11 +1333,15 @@ static void rnbd_init_mq_hw_queues(struct rnbd_cl=
t_dev *dev)
>         }
>  }
>
> -static void setup_request_queue(struct rnbd_clt_dev *dev)
> +static void setup_request_queue(struct rnbd_clt_dev *dev,
> +                               struct rnbd_msg_open_rsp *rsp)
>  {
> -       blk_queue_logical_block_size(dev->queue, dev->logical_block_size)=
;
> -       blk_queue_physical_block_size(dev->queue, dev->physical_block_siz=
e);
> -       blk_queue_max_hw_sectors(dev->queue, dev->max_hw_sectors);
> +       blk_queue_logical_block_size(dev->queue,
> +                                    le16_to_cpu(rsp->logical_block_size)=
);
> +       blk_queue_physical_block_size(dev->queue,
> +                                     le16_to_cpu(rsp->physical_block_siz=
e));
> +       blk_queue_max_hw_sectors(dev->queue,
> +                                dev->sess->max_io_size / SECTOR_SIZE);
>
>         /*
>          * we don't support discards to "discontiguous" segments
> @@ -1369,21 +1349,27 @@ static void setup_request_queue(struct rnbd_clt_d=
ev *dev)
>          */
>         blk_queue_max_discard_segments(dev->queue, 1);
>
> -       blk_queue_max_discard_sectors(dev->queue, dev->max_discard_sector=
s);
> -       dev->queue->limits.discard_granularity  =3D dev->discard_granular=
ity;
> -       dev->queue->limits.discard_alignment    =3D dev->discard_alignmen=
t;
> -       if (dev->secure_discard)
> +       blk_queue_max_discard_sectors(dev->queue,
> +                                     le32_to_cpu(rsp->max_discard_sector=
s));
> +       dev->queue->limits.discard_granularity =3D
> +                                       le32_to_cpu(rsp->discard_granular=
ity);
> +       dev->queue->limits.discard_alignment =3D
> +                                       le32_to_cpu(rsp->discard_alignmen=
t);
> +       if (le16_to_cpu(rsp->secure_discard))
>                 blk_queue_max_secure_erase_sectors(dev->queue,
> -                               dev->max_discard_sectors);
> +                                       le32_to_cpu(rsp->max_discard_sect=
ors));
>         blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, dev->queue);
>         blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, dev->queue);
> -       blk_queue_max_segments(dev->queue, dev->max_segments);
> +       blk_queue_max_segments(dev->queue, dev->sess->max_segments);
>         blk_queue_io_opt(dev->queue, dev->sess->max_io_size);
>         blk_queue_virt_boundary(dev->queue, SZ_4K - 1);
> -       blk_queue_write_cache(dev->queue, dev->wc, dev->fua);
> +       blk_queue_write_cache(dev->queue,
> +                             !!(rsp->cache_policy & RNBD_WRITEBACK),
> +                             !!(rsp->cache_policy & RNBD_FUA));
>  }
>
> -static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
> +static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev,
> +                                  struct rnbd_msg_open_rsp *rsp, int idx=
)
>  {
>         int err;
>
> @@ -1395,12 +1381,12 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_cl=
t_dev *dev, int idx)
>         dev->gd->private_data   =3D dev;
>         snprintf(dev->gd->disk_name, sizeof(dev->gd->disk_name), "rnbd%d"=
,
>                  idx);
> -       pr_debug("disk_name=3D%s, capacity=3D%zu\n",
> +       pr_debug("disk_name=3D%s, capacity=3D%llu\n",
>                  dev->gd->disk_name,
> -                dev->nsectors * (dev->logical_block_size / SECTOR_SIZE)
> -                );
> +                le64_to_cpu(rsp->nsectors) *
> +                (le16_to_cpu(rsp->logical_block_size) / SECTOR_SIZE));
>
> -       set_capacity(dev->gd, dev->nsectors);
> +       set_capacity(dev->gd, le64_to_cpu(rsp->nsectors));
>
>         if (dev->access_mode =3D=3D RNBD_ACCESS_RO)
>                 set_disk_ro(dev->gd, true);
> @@ -1416,11 +1402,13 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_cl=
t_dev *dev, int idx)
>         return err;
>  }
>
> -static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
> +static int rnbd_client_setup_device(struct rnbd_clt_dev *dev,
> +                                   struct rnbd_msg_open_rsp *rsp)
>  {
>         int idx =3D dev->clt_device_id;
>
> -       dev->size =3D dev->nsectors * dev->logical_block_size;
> +       dev->size =3D le64_to_cpu(rsp->nsectors) *
> +                       le16_to_cpu(rsp->logical_block_size);
>
>         dev->gd =3D blk_mq_alloc_disk(&dev->sess->tag_set, dev);
>         if (IS_ERR(dev->gd))
> @@ -1428,8 +1416,8 @@ static int rnbd_client_setup_device(struct rnbd_clt=
_dev *dev)
>         dev->queue =3D dev->gd->queue;
>         rnbd_init_mq_hw_queues(dev);
>
> -       setup_request_queue(dev);
> -       return rnbd_clt_setup_gen_disk(dev, idx);
> +       setup_request_queue(dev, rsp);
> +       return rnbd_clt_setup_gen_disk(dev, rsp, idx);
>  }
>
>  static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
> @@ -1633,7 +1621,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char=
 *sessname,
>         mutex_lock(&dev->lock);
>         pr_debug("Opened remote device: session=3D%s, path=3D'%s'\n",
>                  sess->sessname, pathname);
> -       ret =3D rnbd_client_setup_device(dev);
> +       ret =3D rnbd_client_setup_device(dev, rsp);
>         if (ret) {
>                 rnbd_clt_err(dev,
>                               "map_device: Failed to configure device, er=
r: %d\n",
> @@ -1643,13 +1631,17 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const ch=
ar *sessname,
>         }
>
>         rnbd_clt_info(dev,
> -                      "map_device: Device mapped as %s (nsectors: %zu, l=
ogical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, di=
scard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segme=
nts: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
> -                      dev->gd->disk_name, dev->nsectors,
> -                      dev->logical_block_size, dev->physical_block_size,
> -                      dev->max_discard_sectors,
> -                      dev->discard_granularity, dev->discard_alignment,
> -                      dev->secure_discard, dev->max_segments,
> -                      dev->max_hw_sectors, dev->wc, dev->fua);
> +                      "map_device: Device mapped as %s (nsectors: %llu, =
logical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, d=
iscard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segm=
ents: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
> +                      dev->gd->disk_name, le64_to_cpu(rsp->nsectors),
> +                      le16_to_cpu(rsp->logical_block_size),
> +                      le16_to_cpu(rsp->physical_block_size),
> +                      le32_to_cpu(rsp->max_discard_sectors),
> +                      le32_to_cpu(rsp->discard_granularity),
> +                      le32_to_cpu(rsp->discard_alignment),
> +                      le16_to_cpu(rsp->secure_discard),
> +                      sess->max_segments, sess->max_io_size / SECTOR_SIZ=
E,
> +                      !!(rsp->cache_policy & RNBD_WRITEBACK),
> +                      !!(rsp->cache_policy & RNBD_FUA));
>
>         mutex_unlock(&dev->lock);
>         kfree(rsp);
> diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.=
h
> index 26fb91d800e3..7520272541b1 100644
> --- a/drivers/block/rnbd/rnbd-clt.h
> +++ b/drivers/block/rnbd/rnbd-clt.h
> @@ -117,17 +117,6 @@ struct rnbd_clt_dev {
>         char                    *pathname;
>         enum rnbd_access_mode   access_mode;
>         u32                     nr_poll_queues;
> -       bool                    wc;
> -       bool                    fua;
> -       u32                     max_hw_sectors;
> -       u32                     max_discard_sectors;
> -       u32                     discard_granularity;
> -       u32                     discard_alignment;
> -       u16                     secure_discard;
> -       u16                     physical_block_size;
> -       u16                     logical_block_size;
> -       u16                     max_segments;
> -       size_t                  nsectors;
>         u64                     size;           /* device size in bytes *=
/
>         struct list_head        list;
>         struct gendisk          *gd;
> --
> 2.34.1
>
