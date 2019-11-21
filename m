Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA362C432C0
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 21:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CBC206D7
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 21:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ndTjdExf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfKUVZr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:25:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUVZr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 16:25:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALLApfa106218;
        Thu, 21 Nov 2019 21:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=3q5ELNs+Kx+K1bHZZAOkyUkJbvtpFplQATZijNomOVc=;
 b=ndTjdExf13XL06VeZrCE8QoGVAmT1KzRkeWci8rsBiAYv4ExC3XTUgwREksXDJ5JJphG
 Gk6x8D1vU8ElScTr+fLHmiqaFKkgP+SgM+mtF182RpZ+r9wF7YGmVIUGBwB+V2CsPJ5y
 eWzIt0OMiC9xYqS2zWf3aEMizupJ4/vyZP5e51GuMCQMq8ZrBnwm5f7vKX4mMnQIJeYT
 7pBc5SLo91d1cXyak5d7hjRz216npkZEe/RJGHPp3bR9ARWcgym2b8FadYcnM56c+3Yy
 juxq3UaASc6Cz6xMjps/EioyTwndIVID91JEzhcfzLHZIzzps1+Yq6fiZSWXwPUGgPdl Vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wa9rqxycj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 21:25:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALLAd1b005329;
        Thu, 21 Nov 2019 21:25:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wdfrv2me3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 21:25:19 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xALLPExt009698;
        Thu, 21 Nov 2019 21:25:16 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 13:25:14 -0800
Date:   Thu, 21 Nov 2019 13:25:12 -0800
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
Message-ID: <20191121212512.GA2981917@magnolia>
References: <20191114235008.185111-1-evgreen@chromium.org>
 <20191114154903.v7.2.I4d476bddbf41a61422ad51502f4361e237d60ad4@changeid>
 <20191120022518.GU6235@magnolia>
 <CAE=gft4mjKc4QKFKxp2FX9G2rUMuE3_eDuW_3Oq7NqTYBQwEjg@mail.gmail.com>
 <20191120191302.GV6235@magnolia>
 <CAE=gft6x1TmkkNTj+gktYMkHcysYyuYL50cavYusQ7hd9zChvA@mail.gmail.com>
 <20191120194507.GW6235@magnolia>
 <CAE=gft4OcxPP7srBe_2bj8K_0jHGD8Ae_PbV1Rq-Nz4F8GtkQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft4OcxPP7srBe_2bj8K_0jHGD8Ae_PbV1Rq-Nz4F8GtkQA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210177
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 21, 2019 at 01:18:51PM -0800, Evan Green wrote:
> On Wed, Nov 20, 2019 at 11:45 AM Darrick J. Wong
> <darrick.wong@oracle.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 11:25:48AM -0800, Evan Green wrote:
> > > On Wed, Nov 20, 2019 at 11:13 AM Darrick J. Wong
> > > <darrick.wong@oracle.com> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 10:56:30AM -0800, Evan Green wrote:
> > > > > On Tue, Nov 19, 2019 at 6:25 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 14, 2019 at 03:50:08PM -0800, Evan Green wrote:
> > > > > > > If the backing device for a loop device is itself a block device,
> > > > > > > then mirror the "write zeroes" capabilities of the underlying
> > > > > > > block device into the loop device. Copy this capability into both
> > > > > > > max_write_zeroes_sectors and max_discard_sectors of the loop device.
> > > > > > >
> > > > > > > The reason for this is that REQ_OP_DISCARD on a loop device translates
> > > > > > > into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> > > > > > > presents a consistent interface for loop devices (that discarded data
> > > > > > > is zeroed), regardless of the backing device type of the loop device.
> > > > > > > There should be no behavior change for loop devices backed by regular
> > > > > > > files.
> > >
> > > (marking this spot for below)
> > >
> > > > > > >
> > > > > > > This change fixes blktest block/003, and removes an extraneous
> > > > > > > error print in block/013 when testing on a loop device backed
> > > > > > > by a block device that does not support discard.
> > > > > > >
> > > > > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > > > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v7:
> > > > > > > - Rebase on top of Darrick's patch
> > > > > > > - Tweak opening line of commit description (Darrick)
> > > > > > >
> > > > > > > Changes in v6: None
> > > > > > > Changes in v5:
> > > > > > > - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
> > > > > > >
> > > > > > > Changes in v4:
> > > > > > > - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Updated commit description
> > > > > > >
> > > > > > > Changes in v2: None
> > > > > > >
> > > > > > >  drivers/block/loop.c | 40 +++++++++++++++++++++++++++++-----------
> > > > > > >  1 file changed, 29 insertions(+), 11 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > > > > > index 6a9fe1f9fe84..e8f23e4b78f7 100644
> > > > > > > --- a/drivers/block/loop.c
> > > > > > > +++ b/drivers/block/loop.c
> > > > > > > @@ -427,11 +427,12 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
> > > > > > >        * information.
> > > > > > >        */
> > > > > > >       struct file *file = lo->lo_backing_file;
> > > > > > > +     struct request_queue *q = lo->lo_queue;
> > > > > > >       int ret;
> > > > > > >
> > > > > > >       mode |= FALLOC_FL_KEEP_SIZE;
> > > > > > >
> > > > > > > -     if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > > > > > > +     if (!blk_queue_discard(q)) {
> > > > > > >               ret = -EOPNOTSUPP;
> > > > > > >               goto out;
> > > > > > >       }
> > > > > > > @@ -862,6 +863,21 @@ static void loop_config_discard(struct loop_device *lo)
> > > > > > >       struct file *file = lo->lo_backing_file;
> > > > > > >       struct inode *inode = file->f_mapping->host;
> > > > > > >       struct request_queue *q = lo->lo_queue;
> > > > > > > +     struct request_queue *backingq;
> > > > > > > +
> > > > > > > +     /*
> > > > > > > +      * If the backing device is a block device, mirror its zeroing
> > > > > > > +      * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> > > > > > > +      * by block devices to keep consistent behavior with file-backed loop
> > > > > > > +      * devices.
> > > > > > > +      */
> 
> Wait, I went to make this change and realized there's already a comment here.
> 
> I can tweak the language a bit, but this is pretty much what you wanted, right?

Yep.

--D

> > > > > > > +     if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
> > > > > > > +             backingq = bdev_get_queue(inode->i_bdev);
> > > > > > > +             blk_queue_max_discard_sectors(q,
> > > > > > > +                     backingq->limits.max_write_zeroes_sectors);
> > > > > >
> > > > > > max_discard_sectors?
> > > > >
> > > > > I didn't plumb max_discard_sectors because for my scenario it never
> > > > > ends up hitting the block device that way.
> > > > >
> > > > > The loop device either uses FL_ZERO_RANGE or FL_PUNCH_HOLE. When
> > > > > backed by a block device, that ends up in blkdev_fallocate(), which
> > > > > always translates both of those into blkdev_issue_zeroout(), not
> > > > > blkdev_issue_discard(). So it's really the zeroing capabilities of the
> > > > > block device that matters, even for loop discard operations. It seems
> > > > > weird, but I think this is the right thing because it presents a
> > > > > consistent interface to loop device users whether backed by a file
> > > > > system file, or directly by a block device. That is, a previously
> > > > > discarded range will read back as zeroes.
> > > >
> > > > Ah, right.  Could you add this paragraph as a comment explaining why
> > > > we're setting max_discard_sectors from max_write_zeroes_sectors?
> > >
> > > Sure. I put an explanation in the commit description (see spot I
> > > marked above), but I agree a comment is probably also worthwhile.
> >
> > <nod> Sorry about the churn here.
> >
> > I have a strong preference towards documenting decisions like these
> > directly in the code because (a) I suck at reading patch prologues, (b)
> > someone reading the code after this gets committed will see it
> > immediately and right next to the relevant code, and (c) spelunking
> > through the git history of a file for commit messages is kind of clunky.
> >
> > Dunno if that's just my age showing (mmm, pre-bk linux) or what. :/
> >
> > --D
> >
> > > >
> > > > --D
> > > >
> > > > > -Evan
