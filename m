Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26139C433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112E76124C
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbhJEPyp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhJEPyp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 11:54:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A56DC061749
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 08:52:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v18so635099edc.11
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dXyl9BceujwYzogeGTibLEBZvmr3QCvyeq/VeaRGAgg=;
        b=UI16SmGn97PHHzn1MxCVt5FRbAiL4fXsikPtQ37muytiaAjA2cIA4JxK08XuRt9LwP
         30cz0UzYfqAAInTw8bz3j0GP3MY7z9bUzLRBLYEHbrRbU7I/CcG2s3aZ75YaTYtMmYSa
         o1gOvG3kSR8o3vCdVE/V9oC2zxZblOPHOPD1x8Tdjx4lFkLhNKQ4OyF9yd22YYMS73Dk
         95yYZYEel+N3qTw0/uZkbe/+8/SFt4N73XIZBpad/JiSPDEdb9vz+BOkpU1YEyOe53N4
         XjG1m54SzS0Ni08adDKWhKQC6Su0RL4pBz6MPt0wqsSQuOIsW+M8Gh7IArAJTDoahKWz
         smAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXyl9BceujwYzogeGTibLEBZvmr3QCvyeq/VeaRGAgg=;
        b=P0Jvci3extrsJ3tHUKC1XHkweOOBJOJOPzqM8CFVB+WmBBcMS4KqQkVBFc4QZVsWW1
         ekqMZe/sS7dGYgB+EM1L2Oz+Vwjsf4+vNge9C9ZMM987wJHzfBc9lYKxT8hn4NtwJTkB
         1xL85JwgFcyAXPm2GnZBj55CrkODbO3WG3aDk948YFbu9DndHa9tOLeXxUolxOEjUYAA
         3kFJXrOZ8Klywz7ZlDb4CD5LLpW4EVjASNJk/RwuCg0gBJGmOr8NmHowMLmT68h8IRx6
         tpJIp8ZiK5zZenoyPA4NvfH5c6xbbDrd+4eFfEmYgtx6Mc97aTVNf2Jx/v8JKECXJDc4
         1jnQ==
X-Gm-Message-State: AOAM531NH0vo1djfqL/2ij8w11L+hMctmTLcFf7kc7pguuusYuhOiLvq
        zyY2MmlsXqNfDCiBJmWVunyAFmg7BHvq9bS/tRcl
X-Google-Smtp-Source: ABdhPJzFJ7aUdOwJceyjrtRj7e4UxqEH5REF2lcO/D+P+FBqRlZ0neUrpwwCLWCrIVLf7MIuu8V2a1PP488fash8UQg=
X-Received: by 2002:a50:9d42:: with SMTP id j2mr27303824edk.7.1633449172818;
 Tue, 05 Oct 2021 08:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <20211004112623-mutt-send-email-mst@kernel.org>
 <20211004113722-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211004113722-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 5 Oct 2021 23:52:52 +0800
Message-ID: <CACycT3v+9sKxj_6sSWzudDSpD0isJK6ZR=7gEbW-AbCmT-GL6A@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 4, 2021 at 11:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 04, 2021 at 11:27:29AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 09, 2021 at 06:16:09PM +0800, Xie Yongji wrote:
> > > An untrusted device might presents an invalid block size
> > > in configuration space. This tries to add validation for it
> > > in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> > > feature bit if the value is out of the supported range.
> > >
> > > And we also double check the value in virtblk_probe() in
> > > case that it's changed after the validation.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> >
> > So I had to revert this due basically bugs in QEMU.
> >
> > My suggestion at this point is to try and update
> > blk_queue_logical_block_size to BUG_ON when the size
> > is out of a reasonable range.
> >
> > This has the advantage of fixing more hardware, not just virtio.
> >
> >
> >
> > > ---
> > >  drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
> > >  1 file changed, 33 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 4b49df2dfd23..afb37aac09e8 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
> > >  static unsigned int virtblk_queue_depth;
> > >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> > >
> > > +static int virtblk_validate(struct virtio_device *vdev)
> > > +{
> > > +   u32 blk_size;
> > > +
> > > +   if (!vdev->config->get) {
> > > +           dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > > +                   __func__);
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> > > +           return 0;
> > > +
> > > +   blk_size = virtio_cread32(vdev,
> > > +                   offsetof(struct virtio_blk_config, blk_size));
> > > +
> > > +   if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> > > +           __virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >  static int virtblk_probe(struct virtio_device *vdev)
> > >  {
> > >     struct virtio_blk *vblk;
>
> I started wondering about this. So let's assume is
> PAGE_SIZE < blk_size (after all it's up to guest at many platforms).
>
> Will using the device even work given blk size is less than what
> is can support?
>
> And what exactly happens today if blk_size is out of this range?
>

Now the block layer can't support the block size larger than the page
size. Otherwise, it would cause a random crash, e.g. in
block_read_full_page().

Thanks,
Yongji
