Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039B7C432C3
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 16:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C299D206BD
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 16:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bWoZXgu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKMQbD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:31:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33188 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKMQbD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 11:31:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id t5so3319004ljk.0
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2019 08:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpMKeUckTo+mfsqua8T2tEC8J4sPP/J5YMuHM55DNSM=;
        b=bWoZXgu3t+1SaWAtU/jwNH6U8Hy9gVJ4UfDZ4WN9XQD+J6nmExUtkhx8clPb0XjbQb
         l9vLEexE16IWscCaTnQlE93R3ISCrbrbSGamb30v1mOOPudEd4r3azFX65/7sdsXj8IT
         E8T0qreFlHxihurW82OzLaud6lFo2y8DauHD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpMKeUckTo+mfsqua8T2tEC8J4sPP/J5YMuHM55DNSM=;
        b=ReQKD3nryXuRWG8n48VoLYR7qavkdcdhlocX7YNv2Gx+KjnmgNzJf4+MN2JNpQ5TpN
         CqfEUnTojdKoKUuPdYoIpVq7y/Zm2FP60OxBGkFaST83dalAvOq0johWsMCxcdel19AF
         7Srp5gbm0BE44HrGCw0I+++cXTiSkcu3e1XBSsiR9JUG2+fS6v60IfphvFnWJhh+cKi2
         E9fVOt+r+qa0R3AmHiCqJm4lEAMv8tg1CTebwIzAxG6iEsLId2NQ0rVZi8YT9c0nGEjo
         QU0RbuwBT7GFFmonlkjy27B3Dg5gKvcF6lWolSuT2vKlf/w/3RIEDol/gLswOnLOxlKh
         r1Nw==
X-Gm-Message-State: APjAAAUmBtDDnXCUloQn6CfSiyLsaO2/7fgOl+ZoS7s7d8A/ZaRAKNPI
        eNJFFcQq6XKc6tF83Se+irqV5hBv1bE=
X-Google-Smtp-Source: APXvYqxvv0MPcPsdHmBeX7zQGrLB0P2mW1N8v7UsI1vRn1ujCPEDrNztZbweliJOHE11BBZRAXLP3Q==
X-Received: by 2002:a2e:7a07:: with SMTP id v7mr3390481ljc.208.1573662659350;
        Wed, 13 Nov 2019 08:30:59 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id k6sm1592316lfc.72.2019.11.13.08.30.57
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:30:58 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id q2so3281403ljg.7
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2019 08:30:57 -0800 (PST)
X-Received: by 2002:a2e:760d:: with SMTP id r13mr3194207ljc.15.1573662657118;
 Wed, 13 Nov 2019 08:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20191111185030.215451-1-evgreen@chromium.org> <20191111185030.215451-3-evgreen@chromium.org>
 <20191112013639.GE6235@magnolia> <CAE=gft4KDC0r3S-5p-oHz0cBiwpPqJ8mYVJ2JP7ghnPdaR_u6w@mail.gmail.com>
 <20191113003939.GG6235@magnolia>
In-Reply-To: <20191113003939.GG6235@magnolia>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 13 Nov 2019 08:30:19 -0800
X-Gmail-Original-Message-ID: <CAE=gft4JNKVaxiF26LV_Eqoofoy8yOEnAjm-+iDJL994R7rqsg@mail.gmail.com>
Message-ID: <CAE=gft4JNKVaxiF26LV_Eqoofoy8yOEnAjm-+iDJL994R7rqsg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] loop: Better discard support for block devices
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
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

On Tue, Nov 12, 2019 at 4:40 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, Nov 12, 2019 at 09:22:51AM -0800, Evan Green wrote:
> > Thanks for replying and taking a look Darrick. I didn't see your patch
> > in Jens tree when I looked just before sending it, but maybe I missed
> > it.
> >
> > On Mon, Nov 11, 2019 at 5:37 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Mon, Nov 11, 2019 at 10:50:30AM -0800, Evan Green wrote:
> > > > If the backing device for a loop device is a block device,
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
> > > >
> > > > While in there, differentiate between REQ_OP_DISCARD and
> > > > REQ_OP_WRITE_ZEROES, which are different for block devices,
> > > > but which the loop device had just been lumping together, since
> > > > they're largely the same for files.
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
> > > >  drivers/block/loop.c | 57 ++++++++++++++++++++++++++++----------------
> > > >  1 file changed, 37 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > > index d749156a3d88..236f6deb0772 100644
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
> > > > @@ -599,8 +594,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
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
> > >
> > > Yes, this more or less reimplements what's already in -next...
> >
> > Agree, this part would disappear if I rebased on top of your patch.
> > This series has been around for awhile, you see :)
>
> Oh.  Didn't quite realize that. :/
>
> > > > +
> > > >       case REQ_OP_WRITE:
> > > >               if (lo->transfer)
> > > >                       return lo_write_transfer(lo, rq, pos);
> > > > @@ -854,6 +854,21 @@ static void loop_config_discard(struct loop_device *lo)
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
> > >
> > > What happens if the inode is from a filesystem that can have multiple
> > > backing devices (like btrfs)?
> >
> > Then I would expect S_ISBLK(inode->i_mode) would not be true. This is
> > only for when you've created a loop device directly on top of a block
> > device (ie you pointed the loop device at /dev/sda). We use this in
> > our Chrome OS installer because it makes the logic simple whether
> > you're installing to a real disk or a file image.
>
> Heh, doh, that's right. :)
>
> Sorry, for some reason I misread that as "If the backing device of the
> filesystem from which the inode came is a block device..."
>
> Might I suggest rewording the first sentence of the comment to read "If
> the loop device's backing device is itself a block device" for oafs like
> me? :)

Sure, I'll do that. Another spin coming shortly...

-Evan
