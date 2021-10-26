Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74F8C433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A9660FC2
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 14:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhJZOmJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbhJZOmJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 10:42:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E67BC061745
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:39:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w12so8869340edd.11
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mSWtXB/10GYg5/lRngbyvlgP7+kkTOIJMv08dtSqWY=;
        b=eJEMdhGlzbxrvPkG51t2L6/lbCk8t9PSZmMk+f9ViSwcgzlCVVAz5mbCaRclMhNggL
         a8xYdbIF8ou8U32fm+vMNLs6HOvTnS6WksdDLsQjq3IMlEXqlM8N2n0+gmHafC+8vxv+
         s3M4LE6av2otywq8PNGrLPcCtgm+TKAuJQg5cNf2r1FLDgjSy8LEV7WV7LZ6s6IKlmIa
         f1oQbs/aKfBHOreUGDrIeD3AXKwmpLGkmJvH8fXD35W35sH8H+Z5is/g1Qe0GlLfMQXw
         siII96vMuH5up5xagav0Md5B6jjeC65c3iENti1FEIAMmg0UPEVX0ZStWxUsQ8ATzhvM
         ALvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mSWtXB/10GYg5/lRngbyvlgP7+kkTOIJMv08dtSqWY=;
        b=sbO+nLkGYqC1H2pm1R1fwb0jtDZMCAbOzliOgbqOV0Eh4Ybu3Wi6lWOWzGhr+q80my
         dRKt/5WcKyZxAmfdqSqUkv9fiO+5eco9tC31xmTAhkxjuK3SwioPCUaS7lMhfMApE0yA
         7t0TnBMsq38BX1ud6oLqXyXxvePdW/SbTlwK5y57BMkX1A72j8fJgFZuAfpnOTM5cgrr
         93hF7nrY4z2iN8RZSORuBG2pP5XDrDs8gYIopA0XB6sZMcHDLyeUVref9qkYDOpW1KZg
         dTxaCMXji51wU3VtqRcHCHCggNVYpz94L7txfu7cNjpOB4t1WE8TisU+8TJ58dX50Y/b
         abZQ==
X-Gm-Message-State: AOAM532UaZZGMgFKvHMyOiJoAUVW8KsMkdCfFf4zk4FhBZoib96S4+4o
        jsZsXBA+dwJonbjqwHcb0L8nGSRImmG4Zh3IDlZD
X-Google-Smtp-Source: ABdhPJwC2mO/DHhzRxd0j68YA7cEFFZK7MWq+wg8I7WRAMG7QURblQaS53IPnniBipj2UOYi3DcXnmNJbrUReXKL7l8=
X-Received: by 2002:a17:907:9803:: with SMTP id ji3mr15415555ejc.286.1635259049989;
 Tue, 26 Oct 2021 07:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211025094306.97-1-xieyongji@bytedance.com> <20211025094306.97-5-xieyongji@bytedance.com>
 <20211025091911-mutt-send-email-mst@kernel.org> <CACycT3smA7sSdp-8BKUtN4OW7nkUX+NaW_x9JzfvVgUvM9Yh7A@mail.gmail.com>
 <20211025131446-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211025131446-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 26 Oct 2021 22:37:19 +0800
Message-ID: <CACycT3uay=DAdwD-TbH4B6Z5SmuC2P1zvjW5wTzKroCw=NqVKA@mail.gmail.com>
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

On Tue, Oct 26, 2021 at 1:21 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 25, 2021 at 09:47:34PM +0800, Yongji Xie wrote:
> > On Mon, Oct 25, 2021 at 9:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Oct 25, 2021 at 05:43:06PM +0800, Xie Yongji wrote:
> > > > The block layer can't support the block size larger than
> > > > page size yet. If an untrusted device presents an invalid
> > > > block size in configuration space, it will result in the
> > > > kernel crash something like below:
> > > >
> > > > [  506.154324] BUG: kernel NULL pointer dereference, address: 0000000000000008
> > > > [  506.160416] RIP: 0010:create_empty_buffers+0x24/0x100
> > > > [  506.174302] Call Trace:
> > > > [  506.174651]  create_page_buffers+0x4d/0x60
> > > > [  506.175207]  block_read_full_page+0x50/0x380
> > > > [  506.175798]  ? __mod_lruvec_page_state+0x60/0xa0
> > > > [  506.176412]  ? __add_to_page_cache_locked+0x1b2/0x390
> > > > [  506.177085]  ? blkdev_direct_IO+0x4a0/0x4a0
> > > > [  506.177644]  ? scan_shadow_nodes+0x30/0x30
> > > > [  506.178206]  ? lru_cache_add+0x42/0x60
> > > > [  506.178716]  do_read_cache_page+0x695/0x740
> > > > [  506.179278]  ? read_part_sector+0xe0/0xe0
> > > > [  506.179821]  read_part_sector+0x36/0xe0
> > > > [  506.180337]  adfspart_check_ICS+0x32/0x320
> > > > [  506.180890]  ? snprintf+0x45/0x70
> > > > [  506.181350]  ? read_part_sector+0xe0/0xe0
> > > > [  506.181906]  bdev_disk_changed+0x229/0x5c0
> > > > [  506.182483]  blkdev_get_whole+0x6d/0x90
> > > > [  506.183013]  blkdev_get_by_dev+0x122/0x2d0
> > > > [  506.183562]  device_add_disk+0x39e/0x3c0
> > > > [  506.184472]  virtblk_probe+0x3f8/0x79b [virtio_blk]
> > > > [  506.185461]  virtio_dev_probe+0x15e/0x1d0 [virtio]
> > > >
> > > > So this patch tries to use the block layer helper to
> > > > validate the block size.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > ---
> > > >  drivers/block/virtio_blk.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 303caf2d17d0..5bcacefe969e 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -815,9 +815,12 @@ static int virtblk_probe(struct virtio_device *vdev)
> > > >       err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> > > >                                  struct virtio_blk_config, blk_size,
> > > >                                  &blk_size);
> > > > -     if (!err)
> > > > +     if (!err) {
> > > > +             if (blk_validate_block_size(blk_size))
> > > > +                     goto out_cleanup_disk;
> > > > +
> > >
> > >
> > > Did you test this with an invalid blk size? It seems unlikely that it
> > > fails properly the way you'd expect.
> > >
> >
> > Oops... Sorry, I just checked whether the block device is created with
> > invalid block size.
> >
> > Will send v2 soon!
> >
> > Thanks,
> > Yongji
>
> Please avoid doing that in the future. Posting untested patches is only
> acceptable if you make it abundantly clear that they are untested.
>

Certainly

Thanks,
Yongji
