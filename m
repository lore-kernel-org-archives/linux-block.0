Return-Path: <SRS0=kKib=BC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA7C433E4
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 04:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2485207F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 04:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="g3GIbjHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgGWEyx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWEyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jul 2020 00:54:53 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43EDC0619DC
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 21:54:52 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i26so218622edv.4
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 21:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShajOwqOY5CvNYmSgW6m2GmWSAZafmOJXtFLB48nnaI=;
        b=g3GIbjHAi4ExXfdsytcqAqHhN+WEqHNQi/Nfo9g8Aq9qS1tmiveT4U/7jYncT4XOpI
         l0T5VgWxBX73/32/KjVf7/XmizzqCn0pfljwSjVyAdwo9CVWRT8xTOv73lnTpT/6IToD
         17xfbLctr6w4Uj3q7G15ja9b0nuRcHvanVZP80OQwFn44AUm4BxoH8VYKQioT3imq292
         Y/VNs//q9Qyf7YGv+y2uPAjfh9VogJW3kIZ1HXgVmaw1UoZvT+28h5/Tnf5AkokS6CXM
         Zu/WKxMKNmBXNZkTM7n6LcXVmxwKtAB1r5qWTrjgPph45BpYzSKnvQkoaBzdVlNGJvOS
         qWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShajOwqOY5CvNYmSgW6m2GmWSAZafmOJXtFLB48nnaI=;
        b=lvguaddLWt6EVXNdWshABFPOu2sfuNJ2fplyY/5jsvCJqyVm3/8A/Ovtk/2gSFz1bY
         4wwicmwebgQuWXCurbYYNtOJ+5T5bhlwbnIlOHPdupxxw+VpeJos/YR4ex/Hr0iZr+IF
         4R/NcSWG5qD3hmyzzxeEGQga5vAbKlL0NuD+SjCzvYFaV0mMAGoM+YgV3l9aPQm8cY57
         QQFZScv87nL516x3yLlfJ9r+HAo0uaTuPhq3r2fdIxtO7qsYUFWjo15a5fn5+9QN+CqK
         1rbZhVGQ6A4oq2GceiQTGMZZOpJtCoP+rhk9idTakv4ReKx3VI9Wf0Y4BS0tub9Den+u
         VHCg==
X-Gm-Message-State: AOAM53131WQI5PezNlJ/Heis6VxiRxdUjIFbSR5pjjq2a6+nAPwpyuCy
        xrek5mSoDgZD2FpyCE8TGxM4qdOdNr8IOslhWUoQCw==
X-Google-Smtp-Source: ABdhPJw1v78D7FN4IzHg/iniiOin2RvdI/yns5ufTQK7ga7R+riO8ZIVSnzEem3W+GRfA6pylgSmuGLaGp2TPsQl/5U=
X-Received: by 2002:a50:c88d:: with SMTP id d13mr2602896edh.104.1595480091181;
 Wed, 22 Jul 2020 21:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200722102653.19224-1-guoqing.jiang@cloud.ionos.com> <20200722102653.19224-2-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200722102653.19224-2-guoqing.jiang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 23 Jul 2020 06:54:40 +0200
Message-ID: <CAMGffEkQbjjyMYEQipi6RPdv0Og+Sn47sLh9TVaPCp7cUW65Jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rnbd: remove rnbd_dev_submit_io
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
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
Thanks!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
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
