Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1922CC11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E80EE61480
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 09:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhGAJUF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 05:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235586AbhGAJUE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 05:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625131054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IghnoIaxu7uJc3uM459no7BK5jxdTk+9l7LwiQZXGrs=;
        b=UzODH0L4kbw9TIcu/z2G5NG1Vnf6xx3dZUmC8JiHAa+bx3G2Xllu69p+6TS7l2V6VzD4xG
        /ww2FqQ4vnFx7ytVP6GomYpL6nwGziaoU4UhPu74n+e6J37pdKUiSSZ7J/r0Znk0RzRr13
        BAw+fmFzlvn9HITou5TRzOS7MOB2z3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-tuQoVjGENzCJSDBT93OWBw-1; Thu, 01 Jul 2021 05:17:33 -0400
X-MC-Unique: tuQoVjGENzCJSDBT93OWBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22F281084F40;
        Thu,  1 Jul 2021 09:17:32 +0000 (UTC)
Received: from T590 (ovpn-13-92.pek2.redhat.com [10.72.13.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77D955D6AB;
        Thu,  1 Jul 2021 09:17:26 +0000 (UTC)
Date:   Thu, 1 Jul 2021 17:17:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: grab a device refcount in disk_uevent
Message-ID: <YN2IIiKUvquxqx6k@T590>
References: <20210701081638.246552-1-hch@lst.de>
 <20210701081638.246552-2-hch@lst.de>
 <YN2CrbtFEKwDGff0@T590>
 <20210701090232.GA31321@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701090232.GA31321@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01, 2021 at 11:02:32AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 01, 2021 at 04:54:05PM +0800, Ming Lei wrote:
> > On Thu, Jul 01, 2021 at 10:16:37AM +0200, Christoph Hellwig wrote:
> > > Sending uevents requires the struct device to be alive.  To
> > > ensure that grab the device refcount instead of just an inode
> > > reference.
> > > 
> > > Fixes: bc359d03c7ec ("block: add a disk_uevent helper")
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  block/genhd.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/block/genhd.c b/block/genhd.c
> > > index 79aa40b4c39c..af4d2ab4a633 100644
> > > --- a/block/genhd.c
> > > +++ b/block/genhd.c
> > > @@ -365,12 +365,12 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action)
> > >  	xa_for_each(&disk->part_tbl, idx, part) {
> > >  		if (bdev_is_partition(part) && !bdev_nr_sectors(part))
> > >  			continue;
> > > -		if (!bdgrab(part))
> > > +		if (!kobject_get_unless_zero(&part->bd_device.kobj))
> > >  			continue;
> > 
> > ->bd_device is embedded in the block device, and it has same lifetime
> > with the block device, even part_release() calls bdput() to release this
> > device, so why doesn't work by holding a inode reference?
> 
> Because sending a uevent on a device that has device_del called on it
> is going to blow up.

But grabbing one reference can't prevent device_del() from being called.

IMO, if driver core doesn't allow to sending uevent on one deleted device,
it should return a failure instead of kernel panic.

Thanks,
Ming

