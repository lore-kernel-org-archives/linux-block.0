Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DB4C433DF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 10:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A80D2067D
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 10:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3SVj6Bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbgGOKeJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGOKeJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 06:34:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C43C061755;
        Wed, 15 Jul 2020 03:34:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so1992928wrl.8;
        Wed, 15 Jul 2020 03:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMUY6llyiVBHai5nrhOTf3JZHya8KtMcnB9MpKaEZPI=;
        b=o3SVj6BlSqIoxI/NdTPa8Rna1RspumQOntproHK00T8T/pG7cJIaYWI0Sp8ez2F8Tx
         mKAwnghTbCuPG6kgc3nedbXtGNrsg+CaO51/WYI8kUWOFv/ftCDl23egIkksWNFuD8bf
         QdPklSuM/NcikmyFKYr6f0GWhhvGAvZaeZNEBvGcPO/LWKWR3t37kDm02nAbwes/NF0g
         uZGbFvgg4ICoypiqeavzk+s8shdUUnLICqqLej68j/1cp/Ly85BbGYpWYKZxrcxOQhdM
         gzQ52xoNEl6mAyv0DbZePFoVA5ZjJgCUadRTzKAmFitC23HQPIweoc/OmKmwM6VnDyNC
         CP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMUY6llyiVBHai5nrhOTf3JZHya8KtMcnB9MpKaEZPI=;
        b=M+AMkYjd65a+TYKYodTia7Cgf9Qj14OjUBU6RkitzifVb9iBhdT0BQgqHd+lMHbtmv
         jQgsvbXGdlJrcdC/abYrYOoB4nLJR9CPtHCXG8KoUWEdVWl3/sSp/v4QmiiD9g8H0S7Y
         iNGqwJAy5coZtmCulsJ6ul7yX7acROEE5NQPVABPLGOvHRUh5XCNvz1AdGIYX2MYKMpg
         TWXdSZlmtN/MRgd2NMicCZtttKmkoauOMsfXI+9HHOQPr3ZSB5f/lX3NtaFv79MEwvzm
         X0iHF/yj2GgudPWkImTdxiRizSU6NjIOejEfmbZsvObTyjMzDXW0Ql3gXluhheurPWHS
         P45A==
X-Gm-Message-State: AOAM531QmAPEBO8dqJOIL31d2ltSp4hk6n/g1hpUwSmWo/61e89gqq0+
        b5Rc1t2dSPz0dmLhpirPR+P5yQisL4eBAHDYkPVccIjP
X-Google-Smtp-Source: ABdhPJzNsKouENzx8y2K6sU54DBiAnwG5Ytys1zlDwRBxHM5drfl4AvksrGrKDVYNADhYZxk72LP/kthmEg8yPavkfs=
X-Received: by 2002:adf:e850:: with SMTP id d16mr10941653wrn.426.1594809247738;
 Wed, 15 Jul 2020 03:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200715095518.3724-1-mlevitsk@redhat.com>
In-Reply-To: <20200715095518.3724-1-mlevitsk@redhat.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 15 Jul 2020 18:33:56 +0800
Message-ID: <CACVXFVNu+HjGJUvAEK96TB7pOC=k=p5f0Yg3K6t_13qudDAjjw@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: check host supplied logical block size
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 15, 2020 at 5:55 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> Linux kernel only supports logical block sizes which are power of two,
> at least 512 bytes and no more that PAGE_SIZE.
>
> Check this instead of crashing later on.
>
> Note that there is no need to check physical block size since it is
> only a hint, and virtio-blk already only supports power of two values.
>
> Bugzilla link: https://bugzilla.redhat.com/show_bug.cgi?id=1664619
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 980df853ee497..36dda31cc4e96 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -681,6 +681,12 @@ static const struct blk_mq_ops virtio_mq_ops = {
>  static unsigned int virtblk_queue_depth;
>  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>
> +
> +static bool virtblk_valid_block_size(unsigned int blksize)
> +{
> +       return blksize >= 512 && blksize <= PAGE_SIZE && is_power_of_2(blksize);
> +}
> +
>  static int virtblk_probe(struct virtio_device *vdev)
>  {
>         struct virtio_blk *vblk;
> @@ -809,9 +815,16 @@ static int virtblk_probe(struct virtio_device *vdev)
>         err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>                                    struct virtio_blk_config, blk_size,
>                                    &blk_size);
> -       if (!err)
> +       if (!err) {
> +               if (!virtblk_valid_block_size(blk_size)) {
> +                       dev_err(&vdev->dev,
> +                               "%s failure: unsupported logical block size %d\n",
> +                               __func__, blk_size);
> +                       err = -EINVAL;
> +                       goto out_cleanup_queue;
> +               }
>                 blk_queue_logical_block_size(q, blk_size);
> -       else
> +       } else
>                 blk_size = queue_logical_block_size(q);
>
>         /* Use topology information if available */
> @@ -872,6 +885,9 @@ static int virtblk_probe(struct virtio_device *vdev)
>         device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>         return 0;
>
> +out_cleanup_queue:
> +       blk_cleanup_queue(vblk->disk->queue);
> +       vblk->disk->queue = NULL;
>  out_free_tags:
>         blk_mq_free_tag_set(&vblk->tag_set);
>  out_put_disk:
> --
> 2.26.2
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
