Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF63C433E6
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 14:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E8720781
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 14:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="fPOOVigl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbgGVOcu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgGVOcu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 10:32:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18865C0619DC
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 07:32:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so2211235wmi.4
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqMRv6R7id+eyDXUL3yV2jYaLUCIdAlCUaj36ZwSpoY=;
        b=fPOOVigl30NCt3WY9wGVgO0aA+zo/jyfMV5EJjhKohfC79tS+N35V4QKb+xJ3+Pjcf
         p8zopB4pLOPiga0NzqBiF22ML1waSGfg0QjNj9MLfJamLpndqwPIhh6OVIkU/dHfoX35
         dg9jquFrbXKxVpNi0kYWfKUzDZdnypuMV1h9WjRcSKr2mWKqzTSogU2YDuWlLHV66AqO
         fFaRHFz2LBnHI+XEEkJJlK4Z2Umi+XluKrFts3Fw5oVBFnBzgOPwQMXuc3/auL8JgtL8
         KXhCc/PFJAarSnnEtGiwZdYqQyw8YrcPcFwPQp7sP5HwbKT3Ae1qzppl/mmsSrJF6rZX
         r/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqMRv6R7id+eyDXUL3yV2jYaLUCIdAlCUaj36ZwSpoY=;
        b=ASrnKUKVj1qmpK2LR0ovHQamAJmm4Rp1P5ZjIPvSv98sbU7o6Zqs1sXRaOfR8HbFUI
         kncVJifUG1xiBz/JeENyYj17yf+aPwUrLmGapWedWYoFQ4RtM1YPaSuYjkQT4PGwPrTh
         176Lazu6Vsn3n82MgegmGeutDkLJDgJoWPVt+m041jh1k4xptGFg+jjwv2Tt/BWOkYEY
         i1GnLp78BcEaiGNKnhBJ10fjAdYrMGe5gEQTvHaxBxG2pCeNXPXtRfSk8IvxrnHKLUrZ
         EEx7fDGwKwBSw8097fK6ovewKw98UaopAwZfHgpiFv4mHgN/Bus5o/BlrEwcNHCW/Om+
         7nHQ==
X-Gm-Message-State: AOAM532oIdVdPP9T01ZJSGhBSQYbvw6Yy1CO9flP6n7ueFjizGW1mSiP
        o5Xu2UKUDOrOfxQ5z+j/25Ln0yiWV1BFT3ZiEzDJ
X-Google-Smtp-Source: ABdhPJygFe93BMbhyPsWdLz4TFoKsmTCwgy/VPhs+mv7qzUtLtfaRo36VQcrweM0KnfPm8sqCiwp3TDsfeMARC70wiI=
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr4220903wmf.160.1595428368616;
 Wed, 22 Jul 2020 07:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200722102653.19224-1-guoqing.jiang@cloud.ionos.com> <20200722102653.19224-2-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200722102653.19224-2-guoqing.jiang@cloud.ionos.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 22 Jul 2020 16:32:37 +0200
Message-ID: <CAHg0Huw-spFy=H5PpvNJQwXrPSZZaERj-xjb3R99QUDAiVfbCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rnbd: remove rnbd_dev_submit_io
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 22, 2020 at 12:27 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> The function only has one caller, so let's open code it in process_rdma.
> Another bonus is we can avoid push/pop stack, since we need to pass 8
> arguments to rnbd_dev_submit_io.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv-dev.c | 36 +++----------------------------
>  drivers/block/rnbd/rnbd-srv-dev.h | 19 +++++-----------
>  drivers/block/rnbd/rnbd-srv.c     | 32 +++++++++++++++++++--------
>  3 files changed, 31 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
> index 5eddfd29ab64..49c62b506c9b 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.c
> +++ b/drivers/block/rnbd/rnbd-srv-dev.c
> @@ -45,7 +45,7 @@ void rnbd_dev_close(struct rnbd_dev *dev)
>         kfree(dev);
>  }
>
> -static void rnbd_dev_bi_end_io(struct bio *bio)
> +void rnbd_dev_bi_end_io(struct bio *bio)
>  {
>         struct rnbd_dev_blk_io *io = bio->bi_private;
>
> @@ -63,8 +63,8 @@ static void rnbd_dev_bi_end_io(struct bio *bio)
>   *     Map the kernel address into a bio suitable for io to a block
>   *     device. Returns an error pointer in case of error.
>   */
> -static struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
> -                                    unsigned int len, gfp_t gfp_mask)
> +struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
> +                             unsigned int len, gfp_t gfp_mask)
>  {
>         unsigned long kaddr = (unsigned long)data;
>         unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> @@ -102,33 +102,3 @@ static struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
>         bio->bi_end_io = bio_put;
>         return bio;
>  }
> -
> -int rnbd_dev_submit_io(struct rnbd_dev *dev, sector_t sector, void *data,
> -                      size_t len, u32 bi_size, enum rnbd_io_flags flags,
> -                      short prio, void *priv)
> -{
> -       struct rnbd_dev_blk_io *io;
> -       struct bio *bio;
> -
> -       /* Generate bio with pages pointing to the rdma buffer */
> -       bio = rnbd_bio_map_kern(data, dev->ibd_bio_set, len, GFP_KERNEL);
> -       if (IS_ERR(bio))
> -               return PTR_ERR(bio);
> -
> -       io = container_of(bio, struct rnbd_dev_blk_io, bio);
> -
> -       io->dev = dev;
> -       io->priv = priv;
> -
> -       bio->bi_end_io = rnbd_dev_bi_end_io;
> -       bio->bi_private = io;
> -       bio->bi_opf = rnbd_to_bio_flags(flags);
> -       bio->bi_iter.bi_sector = sector;
> -       bio->bi_iter.bi_size = bi_size;
> -       bio_set_prio(bio, prio);
> -       bio_set_dev(bio, dev->bdev);
> -
> -       submit_bio(bio);
> -
> -       return 0;
> -}
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
> index 0f65b09a270e..0eb23850afb9 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.h
> +++ b/drivers/block/rnbd/rnbd-srv-dev.h
> @@ -41,6 +41,11 @@ void rnbd_dev_close(struct rnbd_dev *dev);
>
>  void rnbd_endio(void *priv, int error);
>
> +void rnbd_dev_bi_end_io(struct bio *bio);
> +
> +struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
> +                             unsigned int len, gfp_t gfp_mask);
> +
>  static inline int rnbd_dev_get_max_segs(const struct rnbd_dev *dev)
>  {
>         return queue_max_segments(bdev_get_queue(dev->bdev));
> @@ -75,18 +80,4 @@ static inline int rnbd_dev_get_discard_alignment(const struct rnbd_dev *dev)
>         return bdev_get_queue(dev->bdev)->limits.discard_alignment;
>  }
>
> -/**
> - * rnbd_dev_submit_io() - Submit an I/O to the disk
> - * @dev:       device to that the I/O is submitted
> - * @sector:    address to read/write data to
> - * @data:      I/O data to write or buffer to read I/O date into
> - * @len:       length of @data
> - * @bi_size:   Amount of data that will be read/written
> - * @prio:       IO priority
> - * @priv:      private data passed to @io_fn
> - */
> -int rnbd_dev_submit_io(struct rnbd_dev *dev, sector_t sector, void *data,
> -                       size_t len, u32 bi_size, enum rnbd_io_flags flags,
> -                       short prio, void *priv);
> -
>  #endif /* RNBD_SRV_DEV_H */
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 86e61523907b..0fb94843a495 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -124,6 +124,9 @@ static int process_rdma(struct rtrs_srv *sess,
>         struct rnbd_srv_sess_dev *sess_dev;
>         u32 dev_id;
>         int err;
> +       struct rnbd_dev_blk_io *io;
> +       struct bio *bio;
> +       short prio;
>
>         priv = kmalloc(sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -142,18 +145,29 @@ static int process_rdma(struct rtrs_srv *sess,
>         priv->sess_dev = sess_dev;
>         priv->id = id;
>
> -       err = rnbd_dev_submit_io(sess_dev->rnbd_dev, le64_to_cpu(msg->sector),
> -                                 data, datalen, le32_to_cpu(msg->bi_size),
> -                                 le32_to_cpu(msg->rw),
> -                                 srv_sess->ver < RNBD_PROTO_VER_MAJOR ||
> -                                 usrlen < sizeof(*msg) ?
> -                                 0 : le16_to_cpu(msg->prio), priv);
> -       if (unlikely(err)) {
> -               rnbd_srv_err(sess_dev, "Submitting I/O to device failed, err: %d\n",
> -                             err);
> +       /* Generate bio with pages pointing to the rdma buffer */
> +       bio = rnbd_bio_map_kern(data, sess_dev->rnbd_dev->ibd_bio_set, datalen, GFP_KERNEL);
> +       if (IS_ERR(bio)) {
> +               rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", PTR_ERR(bio));
>                 goto sess_dev_put;
>         }
>
> +       io = container_of(bio, struct rnbd_dev_blk_io, bio);
> +       io->dev = sess_dev->rnbd_dev;
> +       io->priv = priv;
> +
> +       bio->bi_end_io = rnbd_dev_bi_end_io;
> +       bio->bi_private = io;
> +       bio->bi_opf = rnbd_to_bio_flags(le32_to_cpu(msg->rw));
> +       bio->bi_iter.bi_sector = le64_to_cpu(msg->sector);
> +       bio->bi_iter.bi_size = le32_to_cpu(msg->bi_size);
> +       prio = srv_sess->ver < RNBD_PROTO_VER_MAJOR ||
> +              usrlen < sizeof(*msg) ? 0 : le16_to_cpu(msg->prio);
> +       bio_set_prio(bio, prio);
> +       bio_set_dev(bio, sess_dev->rnbd_dev->bdev);
> +
> +       submit_bio(bio);
> +
>         return 0;
>
>  sess_dev_put:
> --
> 2.17.1
>

Looks good. Thank you!

Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
