Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A49C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 13:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5710260F9B
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 13:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhJYNwi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJYNwh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 09:52:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53476C061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 06:50:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z20so20322289edc.13
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cDzkx7Mog2bcjq/Ff9eVSHoRPEhjrn1qj42xHeQO20=;
        b=dgoqMmcpzihzQusuIWjEBVTAp8PzcMO1dO0AS8puxucUfK7tMazVH6Lq3I9q9QbkBR
         ddrjgP8maKc3tEt02PWK2nfPLhFg6Q1gSMNH71y+ASW5ZbxGjY0xjHqPuqHZcO7vNR6A
         dN2G8F8acM24cLEvVJ5gWwX4oyvGtvn7Tv3UnkWNNM+KS3IGpgdr8BO7OzSgL8RVtD+E
         29zzAjQPMebMKFLazdFdbYlcs9Rtha8q6IsgfEwmHmcjzDUoat08fYJqbEuqDvwnozyD
         g/bR7gxei7p0KWoZni1hy3hQWI0GONPoM/u9dSnIq1wGT/Y9jg7tszM3ep1o9g9Uf/jq
         yZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cDzkx7Mog2bcjq/Ff9eVSHoRPEhjrn1qj42xHeQO20=;
        b=ZE9aRcYc8qNsm5zvuTE232sZ4fMPCwHIJfvHHcIA4zl48z5fIB3bIOqXPyQGRVOApD
         uygDtLtLNAEsnFVX/ohoBlHxnNVWIN6oEnsyF5OwxCTSj6U3W5J0FwFUzP3QTqDCDEUh
         r14dykkAg0pVyiQ85g2bBPqVXm1HpeEDidngU5+2/2y3IsJ4Oghzabdrtoxi3RT5LWTk
         Uh26tMwm47mhgX1BnixZpB+TE57xhT7auQa7FnwYIB0uWVppxF6e2Zy1+HkYVIboMnk9
         qzaLd5sFzATD9lyS4+6hP+cNOMkxNH9nBhg315WaeyxXP7sIIjCMu0pdYqZMXVQKalTi
         bDBg==
X-Gm-Message-State: AOAM533c+FSqdhiw83NPUPvyHMvajEdc2P7ZqHVa9d/qquOkpUl/gtjh
        9lPGTE8rgmEUxNnQO2SbN13JhU5byXTL4Ld17t8j
X-Google-Smtp-Source: ABdhPJwoeBOAXmtoULaPPWwcJoljbac0C8lx99jq/q8bkGQwOW6MpQG/JxfdVxrbboWXyXv00ApxPq0fb0fKtBIHI/M=
X-Received: by 2002:a17:906:6b18:: with SMTP id q24mr23083724ejr.281.1635169665275;
 Mon, 25 Oct 2021 06:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211025094306.97-1-xieyongji@bytedance.com> <20211025094306.97-5-xieyongji@bytedance.com>
 <20211025091911-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211025091911-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 25 Oct 2021 21:47:34 +0800
Message-ID: <CACycT3smA7sSdp-8BKUtN4OW7nkUX+NaW_x9JzfvVgUvM9Yh7A@mail.gmail.com>
Subject: Re: [PATCH 4/4] virtio-blk: Use blk_validate_block_size() to validate
 block size
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

On Mon, Oct 25, 2021 at 9:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 25, 2021 at 05:43:06PM +0800, Xie Yongji wrote:
> > The block layer can't support the block size larger than
> > page size yet. If an untrusted device presents an invalid
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
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/block/virtio_blk.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 303caf2d17d0..5bcacefe969e 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -815,9 +815,12 @@ static int virtblk_probe(struct virtio_device *vdev)
> >       err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> >                                  struct virtio_blk_config, blk_size,
> >                                  &blk_size);
> > -     if (!err)
> > +     if (!err) {
> > +             if (blk_validate_block_size(blk_size))
> > +                     goto out_cleanup_disk;
> > +
>
>
> Did you test this with an invalid blk size? It seems unlikely that it
> fails properly the way you'd expect.
>

Oops... Sorry, I just checked whether the block device is created with
invalid block size.

Will send v2 soon!

Thanks,
Yongji
