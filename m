Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42146C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 04:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F8961074
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 04:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhJZEoZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 00:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233481AbhJZEoY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 00:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635223321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqjO2zU/25UEIyy0nM2px/ntQerARAVZfBrLiW6eI5I=;
        b=Z5vv2pdnIAUdVHXwdhu5jieKnMoBWagp4/QzC3RECA3387u2hGlfn8lpoggYosZ06TFqWJ
        PERP/RL+x/QmZ7vg0u5XmROrO96LamzTCfdhDoSwCRceH017qNLxcnenaXz5SELMWX67Ea
        QcNWyz9pWhaaZecNy4D0ZCLxZVeRDao=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-CydXWfeUNaiA2SWlDX34fQ-1; Tue, 26 Oct 2021 00:41:59 -0400
X-MC-Unique: CydXWfeUNaiA2SWlDX34fQ-1
Received: by mail-lf1-f72.google.com with SMTP id x17-20020a0565123f9100b003ff593b7c65so5787516lfa.12
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 21:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqjO2zU/25UEIyy0nM2px/ntQerARAVZfBrLiW6eI5I=;
        b=gyohnAlZZ0dxrz3kSr95bpgZezptfK//M1TlJVZcf0RHboJ90XxrWaTkTaMscn7eKC
         1N34zNwBG5Ehzf0nGlpm7+Z3qUlyvZqgT/QB/gLjpxTMrWKVL3tkYabqF/s9w+9T3Hqo
         Tz/ZRtW8BqU0FSZOQ93fFGmMMhLL4NxcdtArDNt6jYRAKNjG46w2S607jX+DZibDQtnC
         FseRXmdEQBFK06Et5AoeI1f0bSoBwKvmTR4xVHWa30lWzmqps/OIpRdeWo9ZdIyG4IRy
         0JXBVLi6CunOLmNOsHjiGB7s7c6DXBgOEIW4A/OM3Ix8c5G9znMVS96nUh2P6CNqNOJT
         muBA==
X-Gm-Message-State: AOAM533hlbVJaPQkPazXg6w3TiY8DP6Yh/Ok5NU3LjBkhFTS8lTlRV10
        pgfb07Z2JiOe/xjVxmIem9jgtIkUcp/S6Y1dNG1mnQmcXquVVR9nQwxnnx1Xawp8DyefKv/DS9S
        LaofM0zK8o/uH7pc1BIrsEcGkBwmLwASbnvF/hZ4=
X-Received: by 2002:a2e:8605:: with SMTP id a5mr4832663lji.107.1635223318010;
        Mon, 25 Oct 2021 21:41:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhBUrLrGkrgB1yPRLALBD2sN4GQjQAwKYR9S4o58PDSHxoybsZIT8tkvnEx4edZQAzxkZe7XGOFh9gKFHWQ6Y=
X-Received: by 2002:a2e:8605:: with SMTP id a5mr4832648lji.107.1635223317869;
 Mon, 25 Oct 2021 21:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211025075825.1603118-1-mst@redhat.com>
In-Reply-To: <20211025075825.1603118-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Oct 2021 12:41:47 +0800
Message-ID: <CACGkMEucDHon_2uBqZpcSc8hNdOzJGRCz6U_ZmFaP6pbU5sBQw@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: corrent types for status handling
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Feng Li <lifeng1519@gmail.com>,
        Israel Rukshin <israelr@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 3:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> virtblk_setup_cmd returns blk_status_t in an int, callers then assign it
> back to a blk_status_t variable. blk_status_t is either u32 or (more
> typically) u8 so it works, but is inelegant and causes sparse warnings.
>
> Pass the status in blk_status_t in a consistent way.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c336d9bb9105..c7d05ff24084 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -208,8 +208,9 @@ static void virtblk_cleanup_cmd(struct request *req)
>                 kfree(bvec_virt(&req->special_vec));
>  }
>
> -static int virtblk_setup_cmd(struct virtio_device *vdev, struct request *req,
> -               struct virtblk_req *vbr)
> +static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
> +                                     struct request *req,
> +                                     struct virtblk_req *vbr)
>  {
>         bool unmap = false;
>         u32 type;
> @@ -317,14 +318,15 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>         unsigned long flags;
>         unsigned int num;
>         int qid = hctx->queue_num;
> -       int err;
>         bool notify = false;
> +       blk_status_t status;
> +       int err;
>
>         BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
>
> -       err = virtblk_setup_cmd(vblk->vdev, req, vbr);
> -       if (unlikely(err))
> -               return err;
> +       status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> +       if (unlikely(status))
> +               return status;
>
>         blk_mq_start_request(req);
>
> --
> MST
>

