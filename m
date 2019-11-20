Return-Path: <SRS0=usZV=ZM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF75C432C0
	for <linux-block@archiver.kernel.org>; Wed, 20 Nov 2019 19:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B08206DA
	for <linux-block@archiver.kernel.org>; Wed, 20 Nov 2019 19:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ETJOHKwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfKTTNW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:13:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54970 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfKTTNW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Nov 2019 14:13:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKJ94ne038965;
        Wed, 20 Nov 2019 19:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=BJ9TuYRhed6MdraJ+cnH/GOhJ7efteCehEFRJUo8k+Q=;
 b=ETJOHKwWn/zBc5i41vTRoSK/V9Hk6VD5vxE1gLn8N5qnjl/hR60wc3NYm6fzMk0KXrLe
 zN6NCeQM8jkoOvWguUXyt8H3P2daMIEhNCrSX3oIT0sTRUZgeJEYIMHUKac6V91rKAQZ
 EPnvanTgGx3YhUrZMAJSrewdyZLPy6SAnwY+nEWVcMfWtKfZrqTsXU3a63Vh1NKHnjL9
 oDLRGcHhklcfDigl2XCxaYctiExIIbGD1geQj1+74jq/x6vL1ZE6qsOqkI33qRmx0f0P
 n/Mo5416CO4m0vqDfJqebzdkN+prTv4pObrCu0MlyO7KKzjjjp9nDao2K2r0Q9mAE3MZ BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8htyn4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 19:13:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKJ4G6c031803;
        Wed, 20 Nov 2019 19:13:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wd46wxhdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 19:13:07 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAKJD478022716;
        Wed, 20 Nov 2019 19:13:04 GMT
Received: from localhost (/10.159.246.236)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Nov 2019 11:13:03 -0800
Date:   Wed, 20 Nov 2019 11:13:02 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Evan Green <evgreen@chromium.org>
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
Subject: Re: [PATCH v7 2/2] loop: Better discard support for block devices
Message-ID: <20191120191302.GV6235@magnolia>
References: <20191114235008.185111-1-evgreen@chromium.org>
 <20191114154903.v7.2.I4d476bddbf41a61422ad51502f4361e237d60ad4@changeid>
 <20191120022518.GU6235@magnolia>
 <CAE=gft4mjKc4QKFKxp2FX9G2rUMuE3_eDuW_3Oq7NqTYBQwEjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft4mjKc4QKFKxp2FX9G2rUMuE3_eDuW_3Oq7NqTYBQwEjg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200159
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 20, 2019 at 10:56:30AM -0800, Evan Green wrote:
> On Tue, Nov 19, 2019 at 6:25 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Thu, Nov 14, 2019 at 03:50:08PM -0800, Evan Green wrote:
> > > If the backing device for a loop device is itself a block device,
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
> > > This change fixes blktest block/003, and removes an extraneous
> > > error print in block/013 when testing on a loop device backed
> > > by a block device that does not support discard.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > ---
> > >
> > > Changes in v7:
> > > - Rebase on top of Darrick's patch
> > > - Tweak opening line of commit description (Darrick)
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
> > >  drivers/block/loop.c | 40 +++++++++++++++++++++++++++++-----------
> > >  1 file changed, 29 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > index 6a9fe1f9fe84..e8f23e4b78f7 100644
> > > --- a/drivers/block/loop.c
> > > +++ b/drivers/block/loop.c
> > > @@ -427,11 +427,12 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
> > >        * information.
> > >        */
> > >       struct file *file = lo->lo_backing_file;
> > > +     struct request_queue *q = lo->lo_queue;
> > >       int ret;
> > >
> > >       mode |= FALLOC_FL_KEEP_SIZE;
> > >
> > > -     if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > > +     if (!blk_queue_discard(q)) {
> > >               ret = -EOPNOTSUPP;
> > >               goto out;
> > >       }
> > > @@ -862,6 +863,21 @@ static void loop_config_discard(struct loop_device *lo)
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
> > > +             blk_queue_max_discard_sectors(q,
> > > +                     backingq->limits.max_write_zeroes_sectors);
> >
> > max_discard_sectors?
> 
> I didn't plumb max_discard_sectors because for my scenario it never
> ends up hitting the block device that way.
> 
> The loop device either uses FL_ZERO_RANGE or FL_PUNCH_HOLE. When
> backed by a block device, that ends up in blkdev_fallocate(), which
> always translates both of those into blkdev_issue_zeroout(), not
> blkdev_issue_discard(). So it's really the zeroing capabilities of the
> block device that matters, even for loop discard operations. It seems
> weird, but I think this is the right thing because it presents a
> consistent interface to loop device users whether backed by a file
> system file, or directly by a block device. That is, a previously
> discarded range will read back as zeroes.

Ah, right.  Could you add this paragraph as a comment explaining why
we're setting max_discard_sectors from max_write_zeroes_sectors?

--D

> -Evan
