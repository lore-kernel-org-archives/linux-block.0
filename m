Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35186 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754871AbdCaUbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2017 16:31:09 -0400
Received: by mail-pg0-f53.google.com with SMTP id 81so81027606pgh.2
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2017 13:31:09 -0700 (PDT)
Date: Fri, 31 Mar 2017 13:30:15 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Josef Bacik <jbacik@fb.com>,
        kernel-team@fb.com
Subject: Re: [PATCH] blk-mq: remap queues when adding/removing hardware queues
Message-ID: <20170331203015.GA11462@vader>
References: <52fb0623a8496808622c718f0f6372d37574dbe1.1490986618.git.osandov@fb.com>
 <20170331203044.GL20181@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170331203044.GL20181@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 31, 2017 at 04:30:44PM -0400, Keith Busch wrote:
> On Fri, Mar 31, 2017 at 11:59:24AM -0700, Omar Sandoval wrote:
> > @@ -2629,11 +2639,12 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
> >  	set->nr_hw_queues = nr_hw_queues;
> >  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> >  		blk_mq_realloc_hw_ctxs(set, q);
> > -		blk_mq_queue_reinit(q, cpu_online_mask);
> > +		blk_mq_queue_reinit(q, cpu_online_mask, true);
> 
> I think you want to call blk_mq_update_queue_map directly outside this
> loop rather than for each queue through blk_mq_queue_reinit. We only
> need to map the queues once per tagset rather than per queue.

Right, thanks, I'll do that. I figure you're the person to ask,
nvme_add_dev() does want the remap to happen, right?
