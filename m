Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04091C433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 05:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCD861184
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 05:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbhDGFnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 01:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhDGFnW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Apr 2021 01:43:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40CF7610D0;
        Wed,  7 Apr 2021 05:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617774191;
        bh=E1AdJJuv6qohtYvGButFiib/HiQBnklU6WNRjFNV50k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnuQo2Ic9BtrG8CgitohlzV61GQcYEFAKie68LnwM1skObKLXHC7dv26wayM76902
         KXtaGNAV3eKpUehIycdH3gOx3HQaN1t1FScb6Xif9Sq/Xasy0mdf4dHCEuUsHc8WTH
         nFENttRRFtHwhLov7XfMzwLsjbubyAMtCHMTibjY=
Date:   Wed, 7 Apr 2021 07:43:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     bvanassche@acm.org, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@infradead.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: Re: [RESEND PATCH v5 2/2] bio: add limit_bio_size sysfs
Message-ID: <YG1GbFOqaq3wAnfZ@kroah.com>
References: <7c8d9787-f0eb-9ef1-6ebf-f383c27b599a@acm.org>
 <CGME20210407013850epcas1p2d305f138c9fa1431abba1ec44a382de9@epcas1p2.samsung.com>
 <20210407012117.21122-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407012117.21122-1-nanich.lee@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 07, 2021 at 10:21:17AM +0900, Changheun Lee wrote:
> > On 3/16/21 12:44 AM, Changheun Lee wrote:
> > > Add limit_bio_size block sysfs node to limit bio size.
> > > Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size is set.
> > > And bio max size will be limited by queue max sectors via
> > > QUEUE_FLAG_LIMIT_BIO_SIZE set.
> > > 
> > > Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-block | 10 ++++++++++
> > >  Documentation/block/queue-sysfs.rst   |  7 +++++++
> > >  block/blk-sysfs.c                     |  3 +++
> > >  3 files changed, 20 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
> > > index e34cdeeeb9d4..86a7b15410cf 100644
> > > --- a/Documentation/ABI/testing/sysfs-block
> > > +++ b/Documentation/ABI/testing/sysfs-block
> > > @@ -316,3 +316,13 @@ Description:
> > >  		does not complete in this time then the block driver timeout
> > >  		handler is invoked. That timeout handler can decide to retry
> > >  		the request, to fail it or to start a device recovery strategy.
> > > +
> > > +What:		/sys/block/<disk>/queue/limit_bio_size
> > > +Date:		Feb, 2021
> > > +Contact:	Changheun Lee <nanich.lee@samsung.com>
> > > +Description:
> > > +		(RW) Toggle for set/clear QUEUE_FLAG_LIMIT_BIO_SIZE queue flag.
> > > +		Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size
> > > +		is set. And bio max size will be limited by queue max sectors.
> > > +		QUEUE_FLAG_LIMIT_BIO_SIZE will be cleared if limit_bio_size is
> > > +		cleard. And limit of bio max size will be cleard.
> > > diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
> > > index 2638d3446b79..cd371a821855 100644
> > > --- a/Documentation/block/queue-sysfs.rst
> > > +++ b/Documentation/block/queue-sysfs.rst
> > > @@ -273,4 +273,11 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
> > >  do not support zone commands, they will be treated as regular block devices
> > >  and zoned will report "none".
> > >  
> > > +limit_bio_size (RW)
> > > +-------------------
> > > +This indicates QUEUE_FLAG_LIMIT_BIO_SIZE queue flag value. And
> > > +QUEUE_FLAG_LIMIT_BIO_SIZE can be changed via set(1)/clear(0) this node.
> > > +bio max size will be limited by queue max sectors via set this node. And
> > > +limit of bio max size will be cleard via clear this node.
> > > +
> > >  Jens Axboe <jens.axboe@oracle.com>, February 2009
> > > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > > index b513f1683af0..840d97f427e6 100644
> > > --- a/block/blk-sysfs.c
> > > +++ b/block/blk-sysfs.c
> > > @@ -288,6 +288,7 @@ QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
> > >  QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
> > >  QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
> > >  QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
> > > +QUEUE_SYSFS_BIT_FNS(limit_bio_size, LIMIT_BIO_SIZE, 0);
> > >  #undef QUEUE_SYSFS_BIT_FNS
> > >  
> > >  static ssize_t queue_zoned_show(struct request_queue *q, char *page)
> > > @@ -615,6 +616,7 @@ QUEUE_RW_ENTRY(queue_nonrot, "rotational");
> > >  QUEUE_RW_ENTRY(queue_iostats, "iostats");
> > >  QUEUE_RW_ENTRY(queue_random, "add_random");
> > >  QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
> > > +QUEUE_RW_ENTRY(queue_limit_bio_size, "limit_bio_size");
> > >  
> > >  static struct attribute *queue_attrs[] = {
> > >  	&queue_requests_entry.attr,
> > > @@ -648,6 +650,7 @@ static struct attribute *queue_attrs[] = {
> > >  	&queue_rq_affinity_entry.attr,
> > >  	&queue_iostats_entry.attr,
> > >  	&queue_stable_writes_entry.attr,
> > > +	&queue_limit_bio_size_entry.attr,
> > >  	&queue_random_entry.attr,
> > >  	&queue_poll_entry.attr,
> > >  	&queue_wc_entry.attr,
> > 
> > Has it been considered to introduce a function to set the BIO size limit
> > instead of introducing a new sysfs attribute? See also
> > blk_queue_max_hw_sectors().
> 
> A function to set has been not considered yet.
> But sysfs attribute should be supported I think. Because it can be
> different depending on each system environment including policy.

But what tool is now responsible for setting this new value?  Where will
it get that information from?  And why can't the kernel just
automatically set this correctly in the first place without any need for
userspace interaction?

thanks,

greg k-h
