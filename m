Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA0DC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CCD2081C
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 22:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nkosIL2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CCD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeLDWU2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:20:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38844 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDWU2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 17:20:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so16445001lja.5
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 14:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jwe+zDt4TyymF+1abHkOl8SqwTYhQigmQtHko4l6pPI=;
        b=nkosIL2r2ygtW2ChGC1EDQTCagzbDGGnJaH+Qh4qrTdZxj3r9T4yaDqkNuk4Z/IYbs
         Qd2iHsMs/VdD3Jxn5ZeegV7lr+PP+A3rxii6XxMFfrC+8MOEdCFmSfd2W+G/bgUEbiGN
         V2bEO6JKF22/s3BLOfHrugr3bcMRi3XuRIob8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jwe+zDt4TyymF+1abHkOl8SqwTYhQigmQtHko4l6pPI=;
        b=Kc5Embdo41EV0stx9n2rVfgUhoT4eWmc7BUtDzjb3PZkV2qQbihwEnyY1khdVIIsaG
         5/tOts8yksY+UCzP1pzbfP9z8Ls4atcPF1JDqLYCt5tDgEDviYPYD7Jm1UKDaFBllKwf
         FB53wOkiO2V+v/3345XVT3WIgMdlF4aZRQJdfPBA3FpgBujhA/QhdQmbjDPjlSF5wyaO
         fCeZbVVDaIEbNTMUhqpQJifEdES9ev0kJaRDmAkK/qPwcEI58z15ckTqFPe/5weH4Bh1
         GMUvnTAB2POQXI2hjVGWxt+Xf7woPKcoNacI0DW16rEIJ4w0OC7i+O/9lfUuOuO4Lk3J
         BOUQ==
X-Gm-Message-State: AA+aEWbJu0Fevk2MqeXnQZQIWDzu6MLD8yFCUNk3/pUpLZuLO/iUfhid
        5XDXcaiG8UORdey7DjeqQGiRIzJX6Vo=
X-Google-Smtp-Source: AFSGD/WgzZfI8LlAiEwrYG3QFT1j6fMHH0RpwIE9RX2rpWXlfk2127IRG81IRALx7Am4W3AKvBCJ9g==
X-Received: by 2002:a2e:1603:: with SMTP id w3-v6mr13967592ljd.33.1543962025702;
        Tue, 04 Dec 2018 14:20:25 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id d23sm3228001lfc.11.2018.12.04.14.20.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:20:25 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id s5-v6so16419717ljd.12
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 14:20:24 -0800 (PST)
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr13915697lji.57.1543962024012;
 Tue, 04 Dec 2018 14:20:24 -0800 (PST)
MIME-Version: 1.0
References: <20181030230624.61834-1-evgreen@chromium.org> <20181030230624.61834-3-evgreen@chromium.org>
 <20181128012624.GB11128@ming.t460p>
In-Reply-To: <20181128012624.GB11128@ming.t460p>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 4 Dec 2018 14:19:46 -0800
X-Gmail-Original-Message-ID: <CAE=gft7Fyq+Jb3ZG3PSTR=C0Wjt3uu57+H2bshM6Gu=_0W0YQw@mail.gmail.com>
Message-ID: <CAE=gft7Fyq+Jb3ZG3PSTR=C0Wjt3uu57+H2bshM6Gu=_0W0YQw@mail.gmail.com>
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

On Tue, Nov 27, 2018 at 5:26 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Oct 30, 2018 at 04:06:24PM -0700, Evan Green wrote:
> > If the backing device for a loop device is a block device,
> > then mirror the discard properties of the underlying block
> > device into the loop device. While in there, differentiate
> > between REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES, which are
> > different for block devices, but which the loop device had
> > just been lumping together.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> >  drivers/block/loop.c | 61 +++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 41 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 28990fc94841a..176e65101c4ef 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
> >       return ret;
> >  }
> >
> > -static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
> > +static int lo_discard(struct loop_device *lo, struct request *rq,
> > +             int mode, loff_t pos)
> >  {
> > -     /*
> > -      * We use punch hole to reclaim the free space used by the
> > -      * image a.k.a. discard. However we do not support discard if
> > -      * encryption is enabled, because it may give an attacker
> > -      * useful information.
> > -      */
> >       struct file *file = lo->lo_backing_file;
> > -     int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> > +     struct request_queue *q = lo->lo_queue;
> >       int ret;
> >
> > -     if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > +     if (!blk_queue_discard(q)) {
> >               ret = -EOPNOTSUPP;
> >               goto out;
> >       }
> > @@ -603,8 +598,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
> >       case REQ_OP_FLUSH:
> >               return lo_req_flush(lo, rq);
> >       case REQ_OP_DISCARD:
> > +             return lo_discard(lo, rq,
> > +                     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);
> > +
> >       case REQ_OP_WRITE_ZEROES:
> > -             return lo_discard(lo, rq, pos);
> > +             return lo_discard(lo, rq,
> > +                     FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);
> > +
> >       case REQ_OP_WRITE:
> >               if (lo->transfer)
> >                       return lo_write_transfer(lo, rq, pos);
> > @@ -859,6 +859,25 @@ static void loop_config_discard(struct loop_device *lo)
> >       struct file *file = lo->lo_backing_file;
> >       struct inode *inode = file->f_mapping->host;
> >       struct request_queue *q = lo->lo_queue;
> > +     struct request_queue *backingq;
> > +
> > +     /*
> > +      * If the backing device is a block device, mirror its discard
> > +      * capabilities.
> > +      */
> > +     if (S_ISBLK(inode->i_mode)) {
> > +             backingq = bdev_get_queue(inode->i_bdev);
> > +             blk_queue_max_discard_sectors(q,
> > +                     backingq->limits.max_discard_sectors);
> > +
> > +             blk_queue_max_write_zeroes_sectors(q,
> > +                     backingq->limits.max_write_zeroes_sectors);
> > +
> > +             q->limits.discard_granularity =
> > +                     backingq->limits.discard_granularity;
> > +
> > +             q->limits.discard_alignment =
> > +                     backingq->limits.discard_alignment;
>
> I think it isn't necessary to mirror backing queue's discard/write_zeros
> capabilities, given either fs of the underlying queue can deal with well.
>
> >
> >       /*
> >        * We use punch hole to reclaim the free space used by the
> > @@ -866,22 +885,24 @@ static void loop_config_discard(struct loop_device *lo)
> >        * encryption is enabled, because it may give an attacker
> >        * useful information.
> >        */
> > -     if ((!file->f_op->fallocate) ||
> > -         lo->lo_encrypt_key_size) {
> > +     } else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> >               q->limits.discard_granularity = 0;
> >               q->limits.discard_alignment = 0;
> >               blk_queue_max_discard_sectors(q, 0);
> >               blk_queue_max_write_zeroes_sectors(q, 0);
> > -             blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> > -             return;
> > -     }
> >
> > -     q->limits.discard_granularity = inode->i_sb->s_blocksize;
> > -     q->limits.discard_alignment = 0;
> > +     } else {
> > +             q->limits.discard_granularity = inode->i_sb->s_blocksize;
> > +             q->limits.discard_alignment = 0;
> > +
> > +             blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> > +             blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> > +     }
> >
> > -     blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> > -     blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> > -     blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> > +     if (q->limits.max_discard_sectors || q->limits.max_write_zeroes_sectors)
> > +             blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> > +     else
> > +             blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> >  }
>
> Looks it should work just by mirroring backing queue's discard
> capability to loop queue in case that the loop is backed by
> block device, doesn't it? Meantime the unified discard limits &
> write_zeros limits can be kept.

I tested this out, and you're right that I could just flip the
QUEUE_FLAG_DISCARD based on whether its a block device, and leave
everything else alone, to completely disable discard support for loop
devices backed by block devices. This seems to work for programs like
mkfs.ext4, but still leaves problems for coreutils cp.

But is that really the right call? With this change, we're not only
able to use loop devices in this way, but we're able to use the
discard and zero functionality of the underlying block device by
simply passing it through. To me that seemed better than disabling all
discard support for block devices, which would severely slow us down
on some devices.
-Evan
