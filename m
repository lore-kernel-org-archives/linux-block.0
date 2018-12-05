Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB1FC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 19:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68247208E7
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 19:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jpiR46sP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68247208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeLETgi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:36:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32940 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLETgi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 14:36:38 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so15650705lfc.0
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 11:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wl25pW0UogikxDz3M3IaFZP0bK3TQ70RK47pZt0qAzo=;
        b=jpiR46sPUcT7nkS8L15gaGJhynsHKwjpX5InANv45LcjnJ0Ao+UoOOFrJ0xsWj5NU4
         RabOR96CMpjS0LTyclZ1G2Mg/ecXQnqJGt0GOLccK0hYyTs3SGS87VlY5LMobs7tb242
         xSNeFaO96jnMuMS8IxY9avB7/Kt6fP9tS/L/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wl25pW0UogikxDz3M3IaFZP0bK3TQ70RK47pZt0qAzo=;
        b=lNbis5dqPCJcG9cwGuQHkRuIsX5lFZF7ytVAbnFet0eiC1fe2tv/EiXiSMer5UvvxT
         jKrIzKZbiCVjrqWwznCFEca7KTV6wm3WUfAMYzptNQOKajDqLk0GH9FRVYKcW3Pw8TgQ
         ZQ7wOl5mU3j+3C5UgsolxlAz6qa0kUMI9/k4ajvvbmd4H/pvF4/PzoXDTlq6O9DDPwUz
         C84be5fE04ElQLiqj0srI8tOSigH1acgg+zlwfcwLyp3NP3geE1EnubUez+5swRsiOIL
         7GoeHqehwZWG73C9D9mKdJAuBtX02+xTS/YRoIE5Cdn7Zx73f2lkxnHb6MubrfLJFDzV
         prUA==
X-Gm-Message-State: AA+aEWZ/58i2oBnoivSrPc77pfa4wBhX8j2vqI3ha2cqvA86awFPvZz4
        vqM+E2naVXIhfYRxEi+FXBAq8JfmwbQ=
X-Google-Smtp-Source: AFSGD/VnPFGDDtPHmWYiIit1MsCI6LnSRbacyiRwHRKl/YbSOGW2n6sze1s3PEbtcRwjPr2sq4TNgQ==
X-Received: by 2002:a19:a502:: with SMTP id o2mr14865682lfe.92.1544038595650;
        Wed, 05 Dec 2018 11:36:35 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p10-v6sm3915983ljg.19.2018.12.05.11.36.34
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:36:34 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id g11-v6so19449915ljk.3
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 11:36:34 -0800 (PST)
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr6944645lji.112.1544038594412;
 Wed, 05 Dec 2018 11:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <20181030230624.61834-3-evgreen@chromium.org>
 <20181128012624.GB11128@ming.t460p> <CAE=gft7Fyq+Jb3ZG3PSTR=C0Wjt3uu57+H2bshM6Gu=_0W0YQw@mail.gmail.com>
 <20181205011059.GA17845@ming.t460p>
In-Reply-To: <20181205011059.GA17845@ming.t460p>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 5 Dec 2018 11:35:57 -0800
X-Gmail-Original-Message-ID: <CAE=gft7K2OrN93c8TQ5ozOpXzXf5ZD-PNnVHWP9SbZXZqp2dHw@mail.gmail.com>
Message-ID: <CAE=gft7K2OrN93c8TQ5ozOpXzXf5ZD-PNnVHWP9SbZXZqp2dHw@mail.gmail.com>
Subject: Re: [PATCH 2/2] loop: Better discard support for block devices
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, Gwendal Grignou <gwendal@chromium.org>,
        asavery@chromium.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Tue, Dec 4, 2018 at 5:11 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Dec 04, 2018 at 02:19:46PM -0800, Evan Green wrote:
> > Hi Ming,
> >
> > On Tue, Nov 27, 2018 at 5:26 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Tue, Oct 30, 2018 at 04:06:24PM -0700, Evan Green wrote:
> > > > If the backing device for a loop device is a block device,
> > > > then mirror the discard properties of the underlying block
> > > > device into the loop device. While in there, differentiate
> > > > between REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES, which are
> > > > different for block devices, but which the loop device had
> > > > just been lumping together.
> > > >
> > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > ---
> > > >
> > > >  drivers/block/loop.c | 61 +++++++++++++++++++++++++++++++++++-----------------
> > > >  1 file changed, 41 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > > index 28990fc94841a..176e65101c4ef 100644
> > > > --- a/drivers/block/loop.c
> > > > +++ b/drivers/block/loop.c
> > > > @@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
> > > >       return ret;
> > > >  }
> > > >
> > > > -static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
> > > > +static int lo_discard(struct loop_device *lo, struct request *rq,
> > > > +             int mode, loff_t pos)
> > > >  {
> > > > -     /*
> > > > -      * We use punch hole to reclaim the free space used by the
> > > > -      * image a.k.a. discard. However we do not support discard if
> > > > -      * encryption is enabled, because it may give an attacker
> > > > -      * useful information.
> > > > -      */
> > > >       struct file *file = lo->lo_backing_file;
> > > > -     int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> > > > +     struct request_queue *q = lo->lo_queue;
> > > >       int ret;
> > > >
> > > > -     if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > > > +     if (!blk_queue_discard(q)) {
> > > >               ret = -EOPNOTSUPP;
> > > >               goto out;
> > > >       }
> > > > @@ -603,8 +598,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
> > > >       case REQ_OP_FLUSH:
> > > >               return lo_req_flush(lo, rq);
> > > >       case REQ_OP_DISCARD:
> > > > +             return lo_discard(lo, rq,
> > > > +                     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);
> > > > +
> > > >       case REQ_OP_WRITE_ZEROES:
> > > > -             return lo_discard(lo, rq, pos);
> > > > +             return lo_discard(lo, rq,
> > > > +                     FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);
> > > > +
> > > >       case REQ_OP_WRITE:
> > > >               if (lo->transfer)
> > > >                       return lo_write_transfer(lo, rq, pos);
> > > > @@ -859,6 +859,25 @@ static void loop_config_discard(struct loop_device *lo)
> > > >       struct file *file = lo->lo_backing_file;
> > > >       struct inode *inode = file->f_mapping->host;
> > > >       struct request_queue *q = lo->lo_queue;
> > > > +     struct request_queue *backingq;
> > > > +
> > > > +     /*
> > > > +      * If the backing device is a block device, mirror its discard
> > > > +      * capabilities.
> > > > +      */
> > > > +     if (S_ISBLK(inode->i_mode)) {
> > > > +             backingq = bdev_get_queue(inode->i_bdev);
> > > > +             blk_queue_max_discard_sectors(q,
> > > > +                     backingq->limits.max_discard_sectors);
> > > > +
> > > > +             blk_queue_max_write_zeroes_sectors(q,
> > > > +                     backingq->limits.max_write_zeroes_sectors);
> > > > +
> > > > +             q->limits.discard_granularity =
> > > > +                     backingq->limits.discard_granularity;
> > > > +
> > > > +             q->limits.discard_alignment =
> > > > +                     backingq->limits.discard_alignment;
> > >
> > > I think it isn't necessary to mirror backing queue's discard/write_zeros
> > > capabilities, given either fs of the underlying queue can deal with well.
> > >
> > > >
> > > >       /*
> > > >        * We use punch hole to reclaim the free space used by the
> > > > @@ -866,22 +885,24 @@ static void loop_config_discard(struct loop_device *lo)
> > > >        * encryption is enabled, because it may give an attacker
> > > >        * useful information.
> > > >        */
> > > > -     if ((!file->f_op->fallocate) ||
> > > > -         lo->lo_encrypt_key_size) {
> > > > +     } else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > > >               q->limits.discard_granularity = 0;
> > > >               q->limits.discard_alignment = 0;
> > > >               blk_queue_max_discard_sectors(q, 0);
> > > >               blk_queue_max_write_zeroes_sectors(q, 0);
> > > > -             blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> > > > -             return;
> > > > -     }
> > > >
> > > > -     q->limits.discard_granularity = inode->i_sb->s_blocksize;
> > > > -     q->limits.discard_alignment = 0;
> > > > +     } else {
> > > > +             q->limits.discard_granularity = inode->i_sb->s_blocksize;
> > > > +             q->limits.discard_alignment = 0;
> > > > +
> > > > +             blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> > > > +             blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> > > > +     }
> > > >
> > > > -     blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> > > > -     blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> > > > -     blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> > > > +     if (q->limits.max_discard_sectors || q->limits.max_write_zeroes_sectors)
> > > > +             blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> > > > +     else
> > > > +             blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> > > >  }
> > >
> > > Looks it should work just by mirroring backing queue's discard
> > > capability to loop queue in case that the loop is backed by
> > > block device, doesn't it? Meantime the unified discard limits &
> > > write_zeros limits can be kept.
> >
> > I tested this out, and you're right that I could just flip the
> > QUEUE_FLAG_DISCARD based on whether its a block device, and leave
>
> What I meant actually is to do the following discard config:
>
>         bool discard;
>         if (S_ISBLK(inode->i_mode)) {
>                 struct request_queue *backingq = bdev_get_queue(inode->i_bdev);
>                 discard = blk_queue_discard(backingq);
>         } else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size)
>                 discard = false;
>         else
>                 discard = true;
>
>         if (discard) {
>                 blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
>                 blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
>                 blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
>         } else {
>                 blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
>         }

Ah, I see. But I think it's useful to reflect max_discard_sectors,
max_write_zeroes_sectors, discard_granularity, and discard_alignment
from the block device to the loop device. With the exception of
discard_alignment, these parameters are visible via sysfs, so usermode
can actually use these to make more intelligent use of fallocate.
Without this part of it, I still see issues with GNU cp.

I'm not totally sure about discard_alignment, that seems to be useful
in cases of merging blk requests. So I can stop mirroring that one if
it's harmful or not helpful. But unless it's a nak, I'd really love to
keep most of the mirroring. In which case the bool doesn't do a whole
lot of simplifying.

>
> > everything else alone, to completely disable discard support for loop
> > devices backed by block devices. This seems to work for programs like
> > mkfs.ext4, but still leaves problems for coreutils cp.
> >
> > But is that really the right call? With this change, we're not only
> > able to use loop devices in this way, but we're able to use the
> > discard and zero functionality of the underlying block device by
> > simply passing it through. To me that seemed better than disabling all
> > discard support for block devices, which would severely slow us down
> > on some devices.
>
> I guess the above approach can do the same job with yours, but simpler.
>
> thanks,
> Ming
