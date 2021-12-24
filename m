Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398BFC433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 06:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351437AbhLXGDO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Dec 2021 01:03:14 -0500
Received: from verein.lst.de ([213.95.11.211]:55697 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351445AbhLXGDN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Dec 2021 01:03:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6F8EE68AA6; Fri, 24 Dec 2021 07:03:11 +0100 (CET)
Date:   Fri, 24 Dec 2021 07:03:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] loop: use a global workqueue
Message-ID: <20211224060311.GC12234@lst.de>
References: <20211223112509.1116461-1-hch@lst.de> <20211223112509.1116461-2-hch@lst.de> <bb151d84-8a56-f6da-a5dd-b2d8d1fb6cdb@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb151d84-8a56-f6da-a5dd-b2d8d1fb6cdb@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 23, 2021 at 11:37:21PM +0900, Tetsuo Handa wrote:
> > @@ -1115,7 +1107,6 @@ static void __loop_clr_fd(struct loop_device *lo)
> >  	/* freeze request queue during the transition */
> >  	blk_mq_freeze_queue(lo->lo_queue);
> >  
> > -	destroy_workqueue(lo->workqueue);
> 
> is it safe to remove destroy_workqueue() call here?
> 
> >  	spin_lock_irq(&lo->lo_work_lock);
> >  	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> >  				idle_list) {
> 
> destroy_workqueue() implies flush_workqueue() which is creating the lock
> ordering problem. And I think that flush_workqueue() is required for making
> sure that there is no more work to process (i.e. loop_process_work() is
> no longer running) before start deleting idle workers.
> 
> My understanding is that the problem is not the use of a per-device workqueue
> but the need to call flush_workqueue() in order to make sure that all pending
> works are completed.

All the work items are for requests, and the blk_mq_freeze_queue should
take care of flushing them all out.
