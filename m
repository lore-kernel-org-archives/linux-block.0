Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0ADC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 08:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiFNIe7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 04:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiFNIe6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 04:34:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D13CA52
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 01:34:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ECEB168AA6; Tue, 14 Jun 2022 10:34:53 +0200 (CEST)
Date:   Tue, 14 Jun 2022 10:34:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/4] block: disable the elevator int del_gendisk
Message-ID: <20220614083453.GA6999@lst.de>
References: <20220614074827.458955-1-hch@lst.de> <20220614074827.458955-2-hch@lst.de> <YqhFiDx0/IW25bSp@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqhFiDx0/IW25bSp@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 04:23:36PM +0800, Ming Lei wrote:
> >  	blk_sync_queue(q);
> >  	blk_flush_integrity();
> > +	blk_mq_cancel_work_sync(q);
> > +
> > +	blk_mq_quiesce_queue(q);
> 
> quiesce queue adds a bit long delay in del_gendisk, not sure if this way may
> cause regression in big machines with lots of disks.

It does.  But at least we remove a freeze in the queue teardown path.
But either way I'd really like to get things correct first before
looking into optimizations.

> 
> > +	if (q->elevator) {
> > +		mutex_lock(&q->sysfs_lock);
> > +		elevator_exit(q);
> > +		mutex_unlock(&q->sysfs_lock);
> > +	}
> > +	rq_qos_exit(q);
> > +	blk_mq_unquiesce_queue(q);
> 
> Also tearing down elevator here has to be carefully, that means any
> elevator reference has to hold rcu read lock or .q_usage_counter,
> meantime it has to be checked, otherwise use-after-free may be caused.

This is not a new pattern.  We have the same locking here as a
sysfs-induced change of the elevator to none which also clears
q->elevator under a queue that is frozen and quiesced.

But unlike that path we do fail all requests that could have been
queued in the schedule before unfreezing here at least.
