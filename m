Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05FEC3A5A1
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 01:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF46D23402
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 01:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbfHWBIU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:08:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387455AbfHWBIT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 21:08:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56F8330044EF;
        Fri, 23 Aug 2019 01:08:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C3671001B12;
        Fri, 23 Aug 2019 01:08:09 +0000 (UTC)
Date:   Fri, 23 Aug 2019 09:08:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH V2 6/6] block: split .sysfs_lock into two locks
Message-ID: <20190823010804.GA16810@ming.t460p>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-7-ming.lei@redhat.com>
 <6d97a960-52b5-5134-5382-dff73be00722@acm.org>
 <20190822012839.GB28635@ming.t460p>
 <04b567f5-df49-3d44-1707-14fe8445843e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b567f5-df49-3d44-1707-14fe8445843e@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 23 Aug 2019 01:08:19 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 22, 2019 at 12:52:54PM -0700, Bart Van Assche wrote:
> On 8/21/19 6:28 PM, Ming Lei wrote:
> > On Wed, Aug 21, 2019 at 09:18:08AM -0700, Bart Van Assche wrote:
> > > On 8/21/19 2:15 AM, Ming Lei wrote:
> > > > diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> > > > index 31bbf10d8149..a4cc40ddda86 100644
> > > > --- a/block/blk-mq-sysfs.c
> > > > +++ b/block/blk-mq-sysfs.c
> > > > @@ -247,7 +247,7 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
> > > >    	struct blk_mq_hw_ctx *hctx;
> > > >    	int i;
> > > > -	lockdep_assert_held(&q->sysfs_lock);
> > > > +	lockdep_assert_held(&q->sysfs_dir_lock);
> > > >    	queue_for_each_hw_ctx(q, hctx, i)
> > > >    		blk_mq_unregister_hctx(hctx);
> > > > @@ -297,7 +297,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
> > > >    	int ret, i;
> > > >    	WARN_ON_ONCE(!q->kobj.parent);
> > > > -	lockdep_assert_held(&q->sysfs_lock);
> > > > +	lockdep_assert_held(&q->sysfs_dir_lock);
> > > >    	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
> > > >    	if (ret < 0)
> > > 
> > > blk_mq_unregister_dev and __blk_mq_register_dev() are only used by
> > > blk_register_queue() and blk_unregister_queue(). It is the responsibility of
> > > the callers of these function to serialize request queue registration and
> > > unregistration. Is it really necessary to hold a mutex around the
> > > blk_mq_unregister_dev and __blk_mq_register_dev() calls? Or in other words,
> > > can it ever happen that multiple threads invoke one or both functions
> > > concurrently?
> > 
> > hctx kobjects can be removed and re-added via blk_mq_update_nr_hw_queues()
> > which may be called at the same time when queue is registering or
> > un-registering.
> 
> Shouldn't blk_register_queue() and blk_unregister_queue() be serialized
> against blk_mq_update_nr_hw_queues()? Allowing these calls to proceed

It can be easy to say than done. We depends on users for sync
between blk_register_queue() and blk_unregister_queue(), also
there are several locks involved in blk_mq_update_nr_hw_queues().

Now, the sync is done via .sysfs_lock, and so far not see issues in this
area. This patch just converts the .sysfs_lock into .sysfs_dir_lock for
same purpose.

If you have simple and workable patch to serialize blk_register_queue() and
blk_unregister_queue() against blk_mq_update_nr_hw_queues(), I am happy to
review. Otherwise please consider to do it in future, and it shouldn't a
blocker for fixing this deadlock, should it?


Thanks,
Ming
