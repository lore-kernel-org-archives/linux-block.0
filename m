Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA7DC43331
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 00:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD5B21D7F
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 00:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BFDjtyCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKMAkv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:40:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57268 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKMAkv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 19:40:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACNXgep107257;
        Wed, 13 Nov 2019 00:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=bedV+MqwCHfZf7jlrfj6nePEr8E8KstxND4hfkDdpbw=;
 b=BFDjtyCOnYzt+pbvWmT+gXd8pyCYaqd9L4GcNvEvPB9zExoh4HJZN0NLO9KaYvrLPLmP
 OdrublzVhGVaXhGoeYcXGNVOjC6uXyFnA0EXZmpHRxuiuNs5CY1ATTTVsln2llw26A7u
 2wXyfd2/Io01v4Lo8ZkqGDERO0cAnwM8MP/XdrGfNWCI08MHU8b4BQ4QKFmw/Iplq3W7
 LGWeoQcWx3bnzJDU801FHdtsTuVr8BGvIYViI9xRWScP50mIghHax8Agi2D2TN4ww9Bm
 CUNc3dH+Uusw/WRn66Tmi8iOPiWTIRIsiugSGhldtVucyM71kMSFm8Xgp8Rqe2vQh9uS qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w5p3qrf12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 00:39:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACNXexP105217;
        Wed, 13 Nov 2019 00:39:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2w7vbbumc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 00:39:42 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAD0dflZ027817;
        Wed, 13 Nov 2019 00:39:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 16:39:41 -0800
Date:   Tue, 12 Nov 2019 16:39:39 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Evan Green <evgreen@chromium.org>
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
Subject: Re: [PATCH v6 2/2] loop: Better discard support for block devices
Message-ID: <20191113003939.GG6235@magnolia>
References: <20191111185030.215451-1-evgreen@chromium.org>
 <20191111185030.215451-3-evgreen@chromium.org>
 <20191112013639.GE6235@magnolia>
 <CAE=gft4KDC0r3S-5p-oHz0cBiwpPqJ8mYVJ2JP7ghnPdaR_u6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft4KDC0r3S-5p-oHz0cBiwpPqJ8mYVJ2JP7ghnPdaR_u6w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120201
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 12, 2019 at 09:22:51AM -0800, Evan Green wrote:
> Thanks for replying and taking a look Darrick. I didn't see your patch
> in Jens tree when I looked just before sending it, but maybe I missed
> it.
> 
> On Mon, Nov 11, 2019 at 5:37 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Mon, Nov 11, 2019 at 10:50:30AM -0800, Evan Green wrote:
> > > If the backing device for a loop device is a block device,
> > > then mirror the "write zeroes" capabilities of the underlying
> > > block device into the loop device. Copy this capability into both
> > > max_write_zeroes_sectors and max_discard_sectors of the loop device.
> > >
> > > The reason for this is that REQ_OP_DISCARD on a loop device translates
> > > into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> > > presents a consistent interface for loop devices (that discarded data
> > > is zeroed), regardless of the backing device type of the loop device.
> > > There should be no behavior change for loop devices backed by regular
> > > files.
> > >
> > > While in there, differentiate between REQ_OP_DISCARD and
> > > REQ_OP_WRITE_ZEROES, which are different for block devices,
> > > but which the loop device had just been lumping together, since
> > > they're largely the same for files.
> > >
> > > This change fixes blktest block/003, and removes an extraneous
> > > error print in block/013 when testing on a loop device backed
> > > by a block device that does not support discard.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > ---
> > >
> > > Changes in v6: None
> > > Changes in v5:
> > > - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
> > >
> > > Changes in v4:
> > > - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
> > >
> > > Changes in v3:
> > > - Updated commit description
> > >
> > > Changes in v2: None
> > >
> > >  drivers/block/loop.c | 57 ++++++++++++++++++++++++++++----------------
> > >  1 file changed, 37 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > index d749156a3d88..236f6deb0772 100644
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
> > > @@ -599,8 +594,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
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
> >
> > Yes, this more or less reimplements what's already in -next...
> 
> Agree, this part would disappear if I rebased on top of your patch.
> This series has been around for awhile, you see :)

Oh.  Didn't quite realize that. :/

> > > +
> > >       case REQ_OP_WRITE:
> > >               if (lo->transfer)
> > >                       return lo_write_transfer(lo, rq, pos);
> > > @@ -854,6 +854,21 @@ static void loop_config_discard(struct loop_device *lo)
> > >       struct file *file = lo->lo_backing_file;
> > >       struct inode *inode = file->f_mapping->host;
> > >       struct request_queue *q = lo->lo_queue;
> > > +     struct request_queue *backingq;
> > > +
> > > +     /*
> > > +      * If the backing device is a block device, mirror its zeroing
> > > +      * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> > > +      * by block devices to keep consistent behavior with file-backed loop
> > > +      * devices.
> > > +      */
> > > +     if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
> > > +             backingq = bdev_get_queue(inode->i_bdev);
> >
> > What happens if the inode is from a filesystem that can have multiple
> > backing devices (like btrfs)?
> 
> Then I would expect S_ISBLK(inode->i_mode) would not be true. This is
> only for when you've created a loop device directly on top of a block
> device (ie you pointed the loop device at /dev/sda). We use this in
> our Chrome OS installer because it makes the logic simple whether
> you're installing to a real disk or a file image.

Heh, doh, that's right. :)

Sorry, for some reason I misread that as "If the backing device of the
filesystem from which the inode came is a block device..."

Might I suggest rewording the first sentence of the comment to read "If
the loop device's backing device is itself a block device" for oafs like
me? :)

--D

> >
> > > +             blk_queue_max_discard_sectors(q,
> > > +                     backingq->limits.max_write_zeroes_sectors);
> > > +
> > > +             blk_queue_max_write_zeroes_sectors(q,
> > > +                     backingq->limits.max_write_zeroes_sectors);
> >
> > Also, seeing as filesystems tend to implement PUNCH_HOLE and ZERO_RANGE
> > on their own independent of the hardware capabilities of the underlying
> > device, it doesn't make much sense to forward the blockdev limits to the
> > loop device.
> >
> > (Put another way, XFS's ZERO_RANGE implementation can zero hundreds of
> > gigabytes at a time even if the underlying device is a spinning rust.)
> 
> Hopefully my comment above addresses this too (there is no file system
> in the scenario I'm coding for).
