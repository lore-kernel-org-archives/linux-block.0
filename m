Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83016C2D0EF
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 10:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5744B206DB
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 10:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="SiBhMQCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgCaKGS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:06:18 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35336 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbgCaKGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 06:06:18 -0400
Received: by mail-il1-f193.google.com with SMTP id 7so18835227ill.2
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/q0b7Kzx09DKHFVq7TZK24FeG5bPBt0tNn1Z3D6a7U=;
        b=SiBhMQCTaHeow+b9MjA7NpkwDE5wxE3JTXi9zvAi6wuMhyy1KDDLVusBE7kBd9MI7K
         eNw2p8xwTfkCdN26TMaUHgBwn0FEtT/PhKUHIPvnVEg+BT7ZLLgHFVcsYNZGcEFAsDqI
         Gtwr8647uU3xLUyuvNAdhaHKG+N/XXGhs/n6RzbMl0EeylLun1qeJZqpqLkqnIgr7wj3
         6IhaKBcCe8+L7q9Aa6mvS11ih5xs1y5OjAbyweLUkN/bOSMSfuoo/iAKzgThR3S+vPGA
         w/Wh8yIGuw6mxu2OMnaT5zYq2+zbLnJ2k8HhqasrTPE8BijyuhSEozDu1aohs4nLw7z8
         M7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/q0b7Kzx09DKHFVq7TZK24FeG5bPBt0tNn1Z3D6a7U=;
        b=s3rLpoaLbCJvTO0erIknJC2bevdqP8Lq0DW4mmstyHH+LsMSCm1hfdUj+ILY34lDJd
         OpLRaP/MQGvjeBpi+sHvaTpOwgJOEiCnupuhu7Bo9q2O9Fo8msuI/E/Elmgf2HXX9Icg
         Wt0pzAGJpGjMkGawuJprZ1qrIfukfp7rZfRIKTFrhy6SH4t5IE5cG6Y5v32MKi8eDvvE
         e5qYHj8B91Po0SBby39Tm+Nd9SOhFn8jhqxP+KQNeMlqernvSZd5Nk6HvjtgjpWDyCWI
         obAzu94EtvEM85vK/CqqYOQv8AHscysBnirVbPbG0RbV9CvnAtNS9zu4zhRdYAXCEDYL
         qr1Q==
X-Gm-Message-State: ANhLgQ0JUQZMSFKaO3JbTLafXgb4/1bYjNYHL0k7iWyWx3Y5ymAmdO6y
        5N2bQKEf+rp6ToOvWEEyZeejL/FQWl+P5BK0Dxpnvg==
X-Google-Smtp-Source: ADFU+vv6hKaEqso2DnDXTCXoa2/qNjMTc1trXWL3+hEyPk4kS0AY0QrP+wWr1rfIaIl7a2bDlUgRHYalMZB6f9W/lvo=
X-Received: by 2002:a92:ba01:: with SMTP id o1mr15181856ili.217.1585649176303;
 Tue, 31 Mar 2020 03:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-23-jinpu.wang@cloud.ionos.com> <cfe1dba2-04f7-f74d-af90-c70dce4d85cf@acm.org>
In-Reply-To: <cfe1dba2-04f7-f74d-af90-c70dce4d85cf@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 12:06:05 +0200
Message-ID: <CAMGffEkOM9k2A60OHPBbPqRPp09+D5DeThB3iMLFqnLjLc=QAg@mail.gmail.com>
Subject: Re: [PATCH v11 22/26] block/rnbd: server: functionality for IO
 submission to file or block dev
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 7:39 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > This provides helper functions for IO submission to file or block dev.
>
> Regarding the title of this patch: is file I/O still supported? Wasn't
> that support removed some time ago?
Sorry, we forget to update it, will fix.
>
> > +struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags,
> > +                            void (*io_cb)(void *priv, int error))
> > +{
> > +     struct rnbd_dev *dev;
> > +     int ret;
> > +
> > +     dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> > +     if (!dev)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     dev->blk_open_flags = flags;
> > +     dev->bdev = blkdev_get_by_path(path, flags, THIS_MODULE);
> > +     ret = PTR_ERR_OR_ZERO(dev->bdev);
> > +     if (ret)
> > +             goto err;
> > +
> > +     dev->blk_open_flags     = flags;
> > +     dev->io_cb              = io_cb;
> > +     bdevname(dev->bdev, dev->name);
> > +
> > +     return dev;
> > +
> > +err:
> > +     kfree(dev);
> > +     return ERR_PTR(ret);
> > +}
>
> This function only has one caller so io_cb is always equal to the
> argument passed by that single caller, namely rnbd_endio. If that
> argument and also dev->io_cb would be removed, would that make the hot
> path faster?
Sounds good, will do it.

>
> > +int rnbd_dev_submit_io(struct rnbd_dev *dev, sector_t sector, void *data,
> > +                     size_t len, u32 bi_size, enum rnbd_io_flags flags,
> > +                     short prio, void *priv)
> > +{
> > +     struct request_queue *q = bdev_get_queue(dev->bdev);
> > +     struct rnbd_dev_blk_io *io;
> > +     struct bio *bio;
> > +
> > +     /* check if the buffer is suitable for bdev */
> > +     if (WARN_ON(!blk_rq_aligned(q, (unsigned long)data, len)))
> > +             return -EINVAL;
>
> The blk_rq_aligned() check looks weird to me. bio_map_kern() can handle
> data buffers that do not match the DMA alignment requirements, so why to
> refuse data buffers that are not satisfy DMA alignment requirements?
We add the check since 2014 to make sure the data buffer is aligned.
AFAIR we nerver see the WARN triggered.
so will remove it.
>
> > +     /* Generate bio with pages pointing to the rdma buffer */
> > +     bio = bio_map_kern(q, data, len, GFP_KERNEL);
> > +     if (IS_ERR(bio))
> > +             return PTR_ERR(bio);
> > +
> > +     io = kmalloc(sizeof(*io), GFP_KERNEL);
> > +     if (unlikely(!io)) {
> > +             bio_put(bio);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     io->dev         = dev;
> > +     io->priv        = priv;
> > +
> > +     bio->bi_end_io          = rnbd_dev_bi_end_io;
> > +     bio->bi_private         = io;
> > +     bio->bi_opf             = rnbd_to_bio_flags(flags);
> > +     bio->bi_iter.bi_sector  = sector;
> > +     bio->bi_iter.bi_size    = bi_size;
> > +     bio_set_prio(bio, prio);
> > +     bio_set_dev(bio, dev->bdev);
>
> I think Jason strongly prefers to have a single space at the left of the
> assignment operator.
ok.
>
> Thanks,
>
> Bart.
Thanks!
