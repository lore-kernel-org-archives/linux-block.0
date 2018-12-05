Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1957AC04EB8
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 01:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4FD20878
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 01:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4FD20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbeLEBLM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:11:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeLEBLM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 20:11:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58C7F8831E;
        Wed,  5 Dec 2018 01:11:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FB935D78C;
        Wed,  5 Dec 2018 01:11:04 +0000 (UTC)
Date:   Wed, 5 Dec 2018 09:10:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     axboe@kernel.dk, Gwendal Grignou <gwendal@chromium.org>,
        asavery@chromium.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] loop: Better discard support for block devices
Message-ID: <20181205011059.GA17845@ming.t460p>
References: <20181030230624.61834-1-evgreen@chromium.org>
 <20181030230624.61834-3-evgreen@chromium.org>
 <20181128012624.GB11128@ming.t460p>
 <CAE=gft7Fyq+Jb3ZG3PSTR=C0Wjt3uu57+H2bshM6Gu=_0W0YQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft7Fyq+Jb3ZG3PSTR=C0Wjt3uu57+H2bshM6Gu=_0W0YQw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 05 Dec 2018 01:11:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 02:19:46PM -0800, Evan Green wrote:
> Hi Ming,
> 
> On Tue, Nov 27, 2018 at 5:26 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Oct 30, 2018 at 04:06:24PM -0700, Evan Green wrote:
> > > If the backing device for a loop device is a block device,
> > > then mirror the discard properties of the underlying block
> > > device into the loop device. While in there, differentiate
> > > between REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES, which are
> > > different for block devices, but which the loop device had
> > > just been lumping together.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > ---
> > >
> > >  drivers/block/loop.c | 61 +++++++++++++++++++++++++++++++++++-----------------
> > >  1 file changed, 41 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > index 28990fc94841a..176e65101c4ef 100644
> > > --- a/drivers/block/loop.c
> > > +++ b/drivers/block/loop.c
> > > @@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
> > >       return ret;
> > >  }
> > >
> > > -static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
> > > +static int lo_discard(struct loop_device *lo, struct request *rq,
> > > +             int mode, loff_t pos)
> > >  {
> > > -     /*
> > > -      * We use punch hole to reclaim the free space used by the
> > > -      * image a.k.a. discard. However we do not support discard if
> > > -      * encryption is enabled, because it may give an attacker
> > > -      * useful information.
> > > -      */
> > >       struct file *file = lo->lo_backing_file;
> > > -     int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> > > +     struct request_queue *q = lo->lo_queue;
> > >       int ret;
> > >
> > > -     if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > > +     if (!blk_queue_discard(q)) {
> > >               ret = -EOPNOTSUPP;
> > >               goto out;
> > >       }
> > > @@ -603,8 +598,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
> > >       case REQ_OP_FLUSH:
> > >               return lo_req_flush(lo, rq);
> > >       case REQ_OP_DISCARD:
> > > +             return lo_discard(lo, rq,
> > > +                     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);
> > > +
> > >       case REQ_OP_WRITE_ZEROES:
> > > -             return lo_discard(lo, rq, pos);
> > > +             return lo_discard(lo, rq,
> > > +                     FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);
> > > +
> > >       case REQ_OP_WRITE:
> > >               if (lo->transfer)
> > >                       return lo_write_transfer(lo, rq, pos);
> > > @@ -859,6 +859,25 @@ static void loop_config_discard(struct loop_device *lo)
> > >       struct file *file = lo->lo_backing_file;
> > >       struct inode *inode = file->f_mapping->host;
> > >       struct request_queue *q = lo->lo_queue;
> > > +     struct request_queue *backingq;
> > > +
> > > +     /*
> > > +      * If the backing device is a block device, mirror its discard
> > > +      * capabilities.
> > > +      */
> > > +     if (S_ISBLK(inode->i_mode)) {
> > > +             backingq = bdev_get_queue(inode->i_bdev);
> > > +             blk_queue_max_discard_sectors(q,
> > > +                     backingq->limits.max_discard_sectors);
> > > +
> > > +             blk_queue_max_write_zeroes_sectors(q,
> > > +                     backingq->limits.max_write_zeroes_sectors);
> > > +
> > > +             q->limits.discard_granularity =
> > > +                     backingq->limits.discard_granularity;
> > > +
> > > +             q->limits.discard_alignment =
> > > +                     backingq->limits.discard_alignment;
> >
> > I think it isn't necessary to mirror backing queue's discard/write_zeros
> > capabilities, given either fs of the underlying queue can deal with well.
> >
> > >
> > >       /*
> > >        * We use punch hole to reclaim the free space used by the
> > > @@ -866,22 +885,24 @@ static void loop_config_discard(struct loop_device *lo)
> > >        * encryption is enabled, because it may give an attacker
> > >        * useful information.
> > >        */
> > > -     if ((!file->f_op->fallocate) ||
> > > -         lo->lo_encrypt_key_size) {
> > > +     } else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > >               q->limits.discard_granularity = 0;
> > >               q->limits.discard_alignment = 0;
> > >               blk_queue_max_discard_sectors(q, 0);
> > >               blk_queue_max_write_zeroes_sectors(q, 0);
> > > -             blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> > > -             return;
> > > -     }
> > >
> > > -     q->limits.discard_granularity = inode->i_sb->s_blocksize;
> > > -     q->limits.discard_alignment = 0;
> > > +     } else {
> > > +             q->limits.discard_granularity = inode->i_sb->s_blocksize;
> > > +             q->limits.discard_alignment = 0;
> > > +
> > > +             blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> > > +             blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> > > +     }
> > >
> > > -     blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> > > -     blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> > > -     blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> > > +     if (q->limits.max_discard_sectors || q->limits.max_write_zeroes_sectors)
> > > +             blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> > > +     else
> > > +             blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> > >  }
> >
> > Looks it should work just by mirroring backing queue's discard
> > capability to loop queue in case that the loop is backed by
> > block device, doesn't it? Meantime the unified discard limits &
> > write_zeros limits can be kept.
> 
> I tested this out, and you're right that I could just flip the
> QUEUE_FLAG_DISCARD based on whether its a block device, and leave

What I meant actually is to do the following discard config:

	bool discard;
	if (S_ISBLK(inode->i_mode)) {
		struct request_queue *backingq = bdev_get_queue(inode->i_bdev);
		discard = blk_queue_discard(backingq);
	} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size)
		discard = false;
	else
		discard = true;

	if (discard) {
		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
	} else {
		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
	}

> everything else alone, to completely disable discard support for loop
> devices backed by block devices. This seems to work for programs like
> mkfs.ext4, but still leaves problems for coreutils cp.
> 
> But is that really the right call? With this change, we're not only
> able to use loop devices in this way, but we're able to use the
> discard and zero functionality of the underlying block device by
> simply passing it through. To me that seemed better than disabling all
> discard support for block devices, which would severely slow us down
> on some devices.

I guess the above approach can do the same job with yours, but simpler.

thanks,
Ming
