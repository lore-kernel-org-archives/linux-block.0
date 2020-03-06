Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173CDC3F2D2
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D5120801
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8/TCtAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCFCqm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:46:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49077 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726243AbgCFCqm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Mar 2020 21:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583462800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UaaUR80LkzjgQWkTrSdoCDDo4I62lTIWIa7Y+uQpIYo=;
        b=X8/TCtAOYZxj9Uuhkz7oIsqKjYFP9N2SZQZjYzcxbjIjUgMrVj/nnE58bG0Yyn1kI1KX+g
        pGi7U3E6s88Cb1hJ4HgrvfhmZFb+mFgM91Pz6jZIPSa6bJSqt0qPP6cCQJgKb2WHEATZiS
        32FhdAUl5AX1TYZUM0RP6BdJAImdvvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-sCWmmjovOGCx6IvSDIb3gA-1; Thu, 05 Mar 2020 21:46:38 -0500
X-MC-Unique: sCWmmjovOGCx6IvSDIb3gA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 022DE107ACC9;
        Fri,  6 Mar 2020 02:46:37 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A5969A6A;
        Fri,  6 Mar 2020 02:46:29 +0000 (UTC)
Date:   Fri, 6 Mar 2020 10:46:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 2/8] blk-mq: Keep set->nr_hw_queues and
 set->map[].nr_queues in sync
Message-ID: <20200306024624.GC4552@ming.t460p>
References: <20200221032243.9708-1-bvanassche@acm.org>
 <20200221032243.9708-3-bvanassche@acm.org>
 <20200225004727.GA27445@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225004727.GA27445@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 25, 2020 at 08:47:27AM +0800, Ming Lei wrote:
> On Thu, Feb 20, 2020 at 07:22:37PM -0800, Bart Van Assche wrote:
> > blk_mq_map_queues() and multiple .map_queues() implementations expect that
> > set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the number of hardware
> > queues. Hence set .nr_queues before calling these functions. This patch
> > fixes the following kernel warning:
> > 
> > WARNING: CPU: 0 PID: 2501 at include/linux/cpumask.h:137
> > Call Trace:
> >  blk_mq_run_hw_queue+0x19d/0x350 block/blk-mq.c:1508
> >  blk_mq_run_hw_queues+0x112/0x1a0 block/blk-mq.c:1525
> >  blk_mq_requeue_work+0x502/0x780 block/blk-mq.c:775
> >  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
> >  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
> >  kthread+0x361/0x430 kernel/kthread.c:255
> > 
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Ming Lei <ming.lei@redhat.com>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Johannes Thumshirn <jth@kernel.org>
> > Reported-by: syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
> > Fixes: ed76e329d74a ("blk-mq: abstract out queue map") # v5.0
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> >  block/blk-mq.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index f298500e6dda..a92444c077bc 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -3023,6 +3023,14 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
> >  
> >  static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
> >  {
> > +	/*
> > +	 * blk_mq_map_queues() and multiple .map_queues() implementations
> > +	 * expect that set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the
> > +	 * number of hardware queues.
> > +	 */
> > +	if (set->nr_maps == 1)
> > +		set->map[HCTX_TYPE_DEFAULT].nr_queues = set->nr_hw_queues;
> > +
> >  	if (set->ops->map_queues && !is_kdump_kernel()) {
> >  		int i;
> >  
> > 
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 

Hi Jens,

This one and the 3rd patch may belong to 5.6, any chance to consider
them to 5.6?


Thanks,
Ming

