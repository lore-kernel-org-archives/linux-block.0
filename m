Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F165EC43334
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 09:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiGTJAp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 05:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiGTJAp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 05:00:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A928721
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 02:00:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 89D6568AFE; Wed, 20 Jul 2022 11:00:40 +0200 (CEST)
Date:   Wed, 20 Jul 2022 11:00:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "ublk_drv: fix request queue leak"
Message-ID: <20220720090040.GA18210@lst.de>
References: <20220718062928.335399-1-hch@lst.de> <20220718062928.335399-2-hch@lst.de> <YtalgzqC/q3JpYCR@T590> <20220720060705.GB6734@lst.de> <YtezD/apQ1dM0n33@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtezD/apQ1dM0n33@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 03:47:27PM +0800, Ming Lei wrote:
> > What is broken in START_DEV/STOP_DEV?  Please explain the semantics you
> > want and what doesn't work.  FYI, there is nothing in the test suite the
> > complains.  And besides the obvious block layer bug that Jens found you
> > seemed to be perfectly happy with the semantics.
> 
> START_DEV calls add_disk(), and STOP_DEV calls del_gendisk(), but if 
> GD_OWNS_QUEUE is set, blk_mq_exit_queue() will be called in
> del_gendisk(), then the following START_DEV will stuck.

Uh, yeah.  alloc_disk and add_disk are supposed to be paired and
not split over different ioctls.  The lifetime rules here are
rather broken.

> > > similar with scsi's, in which disk rebind needs to be supported
> > > and GD_OWNS_QUEUE can't be set.
> > 
> > SCSI needs it because it needs the request_queue to probe for what ULP
> > to bind to, and it allows to unbind the ULP.  None of that is the case
> > here.  And managing the lifetimes separately is a complete mess, so
> > don't do it.  Especially not in a virtual driver where you don't have
> > to cater to a long set protocol like SCSI.
> 
> If blk_mq_exit_queue is called in del_gendisk() for scsi, how can
> re-bind work as expected since it needs one completely workable
> request queue instead of partial exited one?

For !GD_OWNS_QUEUE blk_mq_exit_queue is not called from del_gendisk().
