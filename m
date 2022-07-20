Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A582C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 10:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiGTKQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 06:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGTKQx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 06:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ADA99FD2
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 03:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658312211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HlHBrceygNZNAMTnUSt6v1ghPG59HU5Ffi+P7Vpk6L4=;
        b=gnD8wEuRqU7RxNHFYHiorXEAFYcTOEDgh/OoPQoLjP9eVul04bX/x2C6E6I/fpMq9IOn8l
        e05uac02GayaNzjJl0hJXu5pnCtNkCpX4ZFvYeVc4ZJpxWV8K2KuENrfnXsMcZ1+tqkBp4
        uyIo6/mabixZciaJwFweDG+q/Xo7i1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-Z5SJjagNMRKSeOdeYFobWA-1; Wed, 20 Jul 2022 06:16:50 -0400
X-MC-Unique: Z5SJjagNMRKSeOdeYFobWA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AA9B8037AF;
        Wed, 20 Jul 2022 10:16:50 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 260E8492C3B;
        Wed, 20 Jul 2022 10:16:46 +0000 (UTC)
Date:   Wed, 20 Jul 2022 18:16:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] Revert "ublk_drv: fix request queue leak"
Message-ID: <YtfWCl7+/N+50LNH@T590>
References: <20220718062928.335399-1-hch@lst.de>
 <20220718062928.335399-2-hch@lst.de>
 <YtalgzqC/q3JpYCR@T590>
 <20220720060705.GB6734@lst.de>
 <YtezD/apQ1dM0n33@T590>
 <20220720090040.GA18210@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720090040.GA18210@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 11:00:40AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 20, 2022 at 03:47:27PM +0800, Ming Lei wrote:
> > > What is broken in START_DEV/STOP_DEV?  Please explain the semantics you
> > > want and what doesn't work.  FYI, there is nothing in the test suite the
> > > complains.  And besides the obvious block layer bug that Jens found you
> > > seemed to be perfectly happy with the semantics.
> > 
> > START_DEV calls add_disk(), and STOP_DEV calls del_gendisk(), but if 
> > GD_OWNS_QUEUE is set, blk_mq_exit_queue() will be called in
> > del_gendisk(), then the following START_DEV will stuck.
> 
> Uh, yeah.  alloc_disk and add_disk are supposed to be paired and
> not split over different ioctls.  The lifetime rules here are
> rather broken.

Can you explain what this way breaks? And why can't one disk be
added/deleted multiple times?

> 
> > > > similar with scsi's, in which disk rebind needs to be supported
> > > > and GD_OWNS_QUEUE can't be set.
> > > 
> > > SCSI needs it because it needs the request_queue to probe for what ULP
> > > to bind to, and it allows to unbind the ULP.  None of that is the case
> > > here.  And managing the lifetimes separately is a complete mess, so
> > > don't do it.  Especially not in a virtual driver where you don't have
> > > to cater to a long set protocol like SCSI.
> > 
> > If blk_mq_exit_queue is called in del_gendisk() for scsi, how can
> > re-bind work as expected since it needs one completely workable
> > request queue instead of partial exited one?
> 
> For !GD_OWNS_QUEUE blk_mq_exit_queue is not called from del_gendisk().

That is why scsi can't set GD_OWNS_QUEUE, for any driver, if disk rebind
or similar behavior is needed, GD_OWNS_QUEUE can't be set. That is why
ublk_drv uses separated queue/disk.


thanks,
Ming

