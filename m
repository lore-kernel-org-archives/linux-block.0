Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5813C433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6396115B
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhJZOhP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbhJZOhO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 10:37:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DCDC061745
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:34:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u13so15287218edy.10
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuKKrs3Ow3IzVDLkYw3gFWO+/+kch1/KKYE/ao6tW2s=;
        b=Zl/HCXuVH7d6Jzj17Og8z9qCUApZRl7V9dWdkie82j4G2U/fyzlyIoI5vwhJzeHUcX
         uDlvgg3TaDvFeqnfPwRJA5jhAfTsVxPCJszL3qyp6CMPkPcihfKAY2gMP+5y+/VmlxW2
         RAs37w/Ng4GR3Ti4dc+zxXivtDOWXfMGBRiimm76v2Va6vfWkAa3XrTEp/yU9XWZ5Ctc
         R5phtqwTy9nVLETqS0t0Ui5LW176CHkVY+o2jIzL8ZfonbZT98j8ov2IrySZHPY19vtO
         Fkb+OPJIVvhEcSW4u8tCZy3qxHMsHX8betQwfJEyz5HMB7EMAxnhA4UC7JTwU88jE1dp
         BSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuKKrs3Ow3IzVDLkYw3gFWO+/+kch1/KKYE/ao6tW2s=;
        b=VszZ5tWTPNPF1KZxH9mmNhDovCJHk9rC44fcx54c03ee0pkAMkTCmtCaRd/Nq3YgdF
         UZKeVfe9j3ci9/7NuHvOSLtu5WQdrstVx68fmeGMcq55SDmUBWNLR9qLQ+SHcJwEPTeY
         /H6dszTXldAscjpK9A7IqziqYlSUIYYsdxXV9Msj4NSvM4d6YylBflK5G8Ap1heS5PBk
         5zGBL6nobxXUYt/KUu24A7lBrdyPhrMDWykYuEIkQyfmn++zBE8+4Rg0OveY5Y4pX04r
         SJcFF2cfAbDMOfF1tzrPtTF/j5rTL7A/6HKKRUy9wM7ZvZmR6qOMRCv2I5sbaoUS//09
         J0Zw==
X-Gm-Message-State: AOAM530adkM3wBK87Ivl13smCrvuLkXSHOqgasfw9lFa4a95+NF0PNk2
        q3i9MlgL19727oygCLm3nn9+BkEcu2ZAgzjREVVU
X-Google-Smtp-Source: ABdhPJyxwCqIZqFlRbbAb7FssVXpXGzZlP1I23ozElL7KvX0vbsOIlAPJAlhbN8sudLr99TaTyFSGb3AloToGe/oLFk=
X-Received: by 2002:a05:6402:1693:: with SMTP id a19mr22301422edv.231.1635258787541;
 Tue, 26 Oct 2021 07:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211025142506.167-1-xieyongji@bytedance.com> <20211025142506.167-5-xieyongji@bytedance.com>
 <20211025130321-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211025130321-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 26 Oct 2021 22:32:56 +0800
Message-ID: <CACycT3ustr9ddcXJQ6Y6kbVLtkZkvRdJXoPe5zOkSfi_KzaD2w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] virtio-blk: Use blk_validate_block_size() to
 validate block size
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 26, 2021 at 1:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 25, 2021 at 10:25:06PM +0800, Xie Yongji wrote:
> > The block layer can't support the block size larger than
>
> the block size -> block sizes, or a block size
>
> > page size yet.
>
> And to add to that, a block size that's too small or
> not a power of two won't work either, right?
> Mention that too.
>

OK.

>
> > If an untrusted device
>
> nothing to do with trust. A misconfigured device.
>

I see.

> > presents an invalid
> > block size in configuration space, it will result in the
> > kernel crash something like below:
> >
> > [  506.154324] BUG: kernel NULL pointer dereference, address: 0000000000000008
> > [  506.160416] RIP: 0010:create_empty_buffers+0x24/0x100
> > [  506.174302] Call Trace:
> > [  506.174651]  create_page_buffers+0x4d/0x60
> > [  506.175207]  block_read_full_page+0x50/0x380
> > [  506.175798]  ? __mod_lruvec_page_state+0x60/0xa0
> > [  506.176412]  ? __add_to_page_cache_locked+0x1b2/0x390
> > [  506.177085]  ? blkdev_direct_IO+0x4a0/0x4a0
> > [  506.177644]  ? scan_shadow_nodes+0x30/0x30
> > [  506.178206]  ? lru_cache_add+0x42/0x60
> > [  506.178716]  do_read_cache_page+0x695/0x740
> > [  506.179278]  ? read_part_sector+0xe0/0xe0
> > [  506.179821]  read_part_sector+0x36/0xe0
> > [  506.180337]  adfspart_check_ICS+0x32/0x320
> > [  506.180890]  ? snprintf+0x45/0x70
> > [  506.181350]  ? read_part_sector+0xe0/0xe0
> > [  506.181906]  bdev_disk_changed+0x229/0x5c0
> > [  506.182483]  blkdev_get_whole+0x6d/0x90
> > [  506.183013]  blkdev_get_by_dev+0x122/0x2d0
> > [  506.183562]  device_add_disk+0x39e/0x3c0
> > [  506.184472]  virtblk_probe+0x3f8/0x79b [virtio_blk]
> > [  506.185461]  virtio_dev_probe+0x15e/0x1d0 [virtio]
> >
> > So this patch tries to use the block layer helper to
> > validate the block size.
>
> I know you are trying to be polite but it's misplaced here.
> Just say what it is:
>
> Use a block layer helper to validate the block size.
>

OK.

> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/block/virtio_blk.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 303caf2d17d0..8b5833997f8e 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -815,9 +815,16 @@ static int virtblk_probe(struct virtio_device *vdev)
> >       err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> >                                  struct virtio_blk_config, blk_size,
> >                                  &blk_size);
> > -     if (!err)
> > +     if (!err) {
> > +             err = blk_validate_block_size(blk_size);
> > +             if (err) {
> > +                     dev_err(&vdev->dev,
> > +                             "get invalid block size: %u\n", blk_size);
>
> Probably hex. Add virtio_blk: and drop "get" here - it's ungrammatical.
>         "virtio_blk: invalid block size: 0x%x\n", blk_size.
>

Will do it.

Thanks,
Yongji
