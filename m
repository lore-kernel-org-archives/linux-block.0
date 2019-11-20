Return-Path: <SRS0=usZV=ZM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24CFC432C3
	for <linux-block@archiver.kernel.org>; Wed, 20 Nov 2019 19:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ABC20721
	for <linux-block@archiver.kernel.org>; Wed, 20 Nov 2019 19:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mPCKWx7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKTT0b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:26:31 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43360 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfKTT0a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Nov 2019 14:26:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id l14so455427lfh.10
        for <linux-block@vger.kernel.org>; Wed, 20 Nov 2019 11:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mw+/fineosuPJvDOnBDBPMogHWUzz9jTmRi29Rw+s8o=;
        b=mPCKWx7DB8WKiRCILkF/Vp93HtGJYEdHFGc3esVg4bfwz+9ufxMwG7XDtyzMmczsj9
         onbNWqBPFjCQ12S7lrtRI6fL0ibOD1rJ31/migziZy+08Jx8f3F53jnVZocTReJC6bD8
         2KZOIOhJBwNhU/+M1IuCWG2kr6yfT4oi5iN10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mw+/fineosuPJvDOnBDBPMogHWUzz9jTmRi29Rw+s8o=;
        b=XcAPpbY+9uZy6ODSGEEX+hf2LYzs+0O3AKeyGbASP6kAr90eFZDYkN1jRS43r5f4jt
         hJdKOkbQGPZ4mwSu/uHDMi/pbZaTYZrrnTB4/DQAMf0zL4hEdMj9JzVexfWi33x8pVbq
         T5vBqMHZqwdsJ7ovwp2/hI6nBlCKZqn9e7yk9wtyrwWApgMLBY7r4Atv8Ovwi84ohK8N
         A/Y4epPgZUf6kps89EgsDZ03jjtT/f08iHA8zCgefBz4uKm/+WybKV1kMN6rtbxehJa7
         m6sqixfD62gno2ngFOOGFylNQokpG+LX2bFIAAK4HMxhGJ/Q65S0zI5YpTQ+qouhlQCg
         rqqg==
X-Gm-Message-State: APjAAAWuoJr+1ybFzg5kqiuPTwK2CaVJeIcVxvHuL4qupb2vrr/4PFuk
        tBsjWTfplZ0yDNhkrniPBM9IdTcPuvw=
X-Google-Smtp-Source: APXvYqwIOVXk+2XwQKXrLhCmaj0ZwgDUfsZlp9G56EESha96EZA05xlWcVYoj15mgxCKRJYfLSCn8g==
X-Received: by 2002:a19:6b10:: with SMTP id d16mr4366621lfa.137.1574277986125;
        Wed, 20 Nov 2019 11:26:26 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f25sm31491ljp.100.2019.11.20.11.26.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 11:26:25 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id g3so374433ljl.11
        for <linux-block@vger.kernel.org>; Wed, 20 Nov 2019 11:26:25 -0800 (PST)
X-Received: by 2002:a2e:9208:: with SMTP id k8mr4368991ljg.14.1574277984775;
 Wed, 20 Nov 2019 11:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20191114235008.185111-1-evgreen@chromium.org> <20191114154903.v7.2.I4d476bddbf41a61422ad51502f4361e237d60ad4@changeid>
 <20191120022518.GU6235@magnolia> <CAE=gft4mjKc4QKFKxp2FX9G2rUMuE3_eDuW_3Oq7NqTYBQwEjg@mail.gmail.com>
 <20191120191302.GV6235@magnolia>
In-Reply-To: <20191120191302.GV6235@magnolia>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 20 Nov 2019 11:25:48 -0800
X-Gmail-Original-Message-ID: <CAE=gft6x1TmkkNTj+gktYMkHcysYyuYL50cavYusQ7hd9zChvA@mail.gmail.com>
Message-ID: <CAE=gft6x1TmkkNTj+gktYMkHcysYyuYL50cavYusQ7hd9zChvA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] loop: Better discard support for block devices
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 20, 2019 at 11:13 AM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Wed, Nov 20, 2019 at 10:56:30AM -0800, Evan Green wrote:
> > On Tue, Nov 19, 2019 at 6:25 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Thu, Nov 14, 2019 at 03:50:08PM -0800, Evan Green wrote:
> > > > If the backing device for a loop device is itself a block device,
> > > > then mirror the "write zeroes" capabilities of the underlying
> > > > block device into the loop device. Copy this capability into both
> > > > max_write_zeroes_sectors and max_discard_sectors of the loop device.
> > > >
> > > > The reason for this is that REQ_OP_DISCARD on a loop device translates
> > > > into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> > > > presents a consistent interface for loop devices (that discarded data
> > > > is zeroed), regardless of the backing device type of the loop device.
> > > > There should be no behavior change for loop devices backed by regular
> > > > files.

(marking this spot for below)

> > > >
> > > > This change fixes blktest block/003, and removes an extraneous
> > > > error print in block/013 when testing on a loop device backed
> > > > by a block device that does not support discard.
> > > >
> > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > > ---
> > > >
> > > > Changes in v7:
> > > > - Rebase on top of Darrick's patch
> > > > - Tweak opening line of commit description (Darrick)
> > > >
> > > > Changes in v6: None
> > > > Changes in v5:
> > > > - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
> > > >
> > > > Changes in v4:
> > > > - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
> > > >
> > > > Changes in v3:
> > > > - Updated commit description
> > > >
> > > > Changes in v2: None
> > > >
> > > >  drivers/block/loop.c | 40 +++++++++++++++++++++++++++++-----------
> > > >  1 file changed, 29 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > > index 6a9fe1f9fe84..e8f23e4b78f7 100644
> > > > --- a/drivers/block/loop.c
> > > > +++ b/drivers/block/loop.c
> > > > @@ -427,11 +427,12 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
> > > >        * information.
> > > >        */
> > > >       struct file *file = lo->lo_backing_file;
> > > > +     struct request_queue *q = lo->lo_queue;
> > > >       int ret;
> > > >
> > > >       mode |= FALLOC_FL_KEEP_SIZE;
> > > >
> > > > -     if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > > > +     if (!blk_queue_discard(q)) {
> > > >               ret = -EOPNOTSUPP;
> > > >               goto out;
> > > >       }
> > > > @@ -862,6 +863,21 @@ static void loop_config_discard(struct loop_device *lo)
> > > >       struct file *file = lo->lo_backing_file;
> > > >       struct inode *inode = file->f_mapping->host;
> > > >       struct request_queue *q = lo->lo_queue;
> > > > +     struct request_queue *backingq;
> > > > +
> > > > +     /*
> > > > +      * If the backing device is a block device, mirror its zeroing
> > > > +      * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> > > > +      * by block devices to keep consistent behavior with file-backed loop
> > > > +      * devices.
> > > > +      */
> > > > +     if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
> > > > +             backingq = bdev_get_queue(inode->i_bdev);
> > > > +             blk_queue_max_discard_sectors(q,
> > > > +                     backingq->limits.max_write_zeroes_sectors);
> > >
> > > max_discard_sectors?
> >
> > I didn't plumb max_discard_sectors because for my scenario it never
> > ends up hitting the block device that way.
> >
> > The loop device either uses FL_ZERO_RANGE or FL_PUNCH_HOLE. When
> > backed by a block device, that ends up in blkdev_fallocate(), which
> > always translates both of those into blkdev_issue_zeroout(), not
> > blkdev_issue_discard(). So it's really the zeroing capabilities of the
> > block device that matters, even for loop discard operations. It seems
> > weird, but I think this is the right thing because it presents a
> > consistent interface to loop device users whether backed by a file
> > system file, or directly by a block device. That is, a previously
> > discarded range will read back as zeroes.
>
> Ah, right.  Could you add this paragraph as a comment explaining why
> we're setting max_discard_sectors from max_write_zeroes_sectors?

Sure. I put an explanation in the commit description (see spot I
marked above), but I agree a comment is probably also worthwhile.

>
> --D
>
> > -Evan
