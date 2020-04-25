Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2473AC2BA1A
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3DB2076C
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 03:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aobbsTFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgDYDZV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:25:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53405 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgDYDZV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 23:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587785118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MStiXEta93seJi87BlpRbxyODpFIzbfptZksm5v6dVE=;
        b=aobbsTFeDJnQv6q4uo5keu0Te9srL4rdGUYGkmHMHPnFPx1HMZDHw4APHQqd5E6hPT8k0I
        ViwzlNOdVmeu5Px/VNCI+2Z5/4daoXp+R3g32zMCemNF++e8UMGwtavNp17y7y+IKvDQdf
        94W5Xux0E+vu5tdoYOSr0m9pNhy/OMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-L6dn99bEOzeC9ACNfUp6AQ-1; Fri, 24 Apr 2020 23:25:12 -0400
X-MC-Unique: L6dn99bEOzeC9ACNfUp6AQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5739A8014D5;
        Sat, 25 Apr 2020 03:25:10 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F33FD60F8A;
        Sat, 25 Apr 2020 03:24:59 +0000 (UTC)
Date:   Sat, 25 Apr 2020 11:24:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V8 06/11] blk-mq: prepare for draining IO when hctx's all
 CPUs are offline
Message-ID: <20200425032453.GD477579@T590>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-7-ming.lei@redhat.com>
 <adaaadf2-7b8e-e8a0-0cee-35b170d45c77@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaaadf2-7b8e-e8a0-0cee-35b170d45c77@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 24, 2020 at 03:23:08PM +0200, Hannes Reinecke wrote:
> On 4/24/20 12:23 PM, Ming Lei wrote:
> > Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
> > up queue mapping. Thomas mentioned the following point[1]:
> > 
> > "
> >   That was the constraint of managed interrupts from the very beginning:
> > 
> >    The driver/subsystem has to quiesce the interrupt line and the associated
> >    queue _before_ it gets shutdown in CPU unplug and not fiddle with it
> >    until it's restarted by the core when the CPU is plugged in again.
> > "
> > 
> > However, current blk-mq implementation doesn't quiesce hw queue before
> > the last CPU in the hctx is shutdown. Even worse, CPUHP_BLK_MQ_DEAD is
> > one cpuhp state handled after the CPU is down, so there isn't any chance
> > to quiesce hctx for blk-mq wrt. CPU hotplug.
> > 
> > Add new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE for blk-mq to stop queues
> > and wait for completion of in-flight requests.
> > 
> > We will stop hw queue and wait for completion of in-flight requests
> > when one hctx is becoming dead in the following patch. This way may
> > cause dead-lock for some stacking blk-mq drivers, such as dm-rq and
> > loop.
> > 
> > Add blk-mq flag of BLK_MQ_F_NO_MANAGED_IRQ and mark it for dm-rq and
> > loop, so we needn't to wait for completion of in-flight requests from
> > dm-rq & loop, then the potential dead-lock can be avoided.
> > 
> > [1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/
> > 
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq-debugfs.c     |  1 +
> >   block/blk-mq.c             | 19 +++++++++++++++++++
> >   drivers/block/loop.c       |  2 +-
> >   drivers/md/dm-rq.c         |  2 +-
> >   include/linux/blk-mq.h     |  3 +++
> >   include/linux/cpuhotplug.h |  1 +
> >   6 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index b3f2ba483992..8e745826eb86 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -239,6 +239,7 @@ static const char *const hctx_flag_name[] = {
> >   	HCTX_FLAG_NAME(TAG_SHARED),
> >   	HCTX_FLAG_NAME(BLOCKING),
> >   	HCTX_FLAG_NAME(NO_SCHED),
> > +	HCTX_FLAG_NAME(NO_MANAGED_IRQ),
> >   };
> >   #undef HCTX_FLAG_NAME
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 65f0aaed55ff..d432cc74ef78 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2261,6 +2261,16 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> >   	return -ENOMEM;
> >   }
> > +static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
> > +{
> > +	return 0;
> > +}
> > +
> >   /*
> >    * 'cpu' is going away. splice any existing rq_list entries from this
> >    * software queue to the hw queue dispatch list, and ensure that it
> > @@ -2297,6 +2307,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> >   static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
> >   {
> > +	if (!(hctx->flags & BLK_MQ_F_NO_MANAGED_IRQ))
> > +		cpuhp_state_remove_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
> > +						    &hctx->cpuhp_online);
> >   	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
> >   					    &hctx->cpuhp_dead);
> >   }
> > @@ -2356,6 +2369,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
> >   {
> >   	hctx->queue_num = hctx_idx;
> > +	if (!(hctx->flags & BLK_MQ_F_NO_MANAGED_IRQ))
> > +		cpuhp_state_add_instance_nocalls(CPUHP_AP_BLK_MQ_ONLINE,
> > +				&hctx->cpuhp_online);
> >   	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
> >   	hctx->tags = set->tags[hctx_idx];
> > @@ -3610,6 +3626,9 @@ static int __init blk_mq_init(void)
> >   {
> >   	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
> >   				blk_mq_hctx_notify_dead);
> > +	cpuhp_setup_state_multi(CPUHP_AP_BLK_MQ_ONLINE, "block/mq:online",
> > +				blk_mq_hctx_notify_online,
> > +				blk_mq_hctx_notify_offline);
> >   	return 0;
> >   }
> >   subsys_initcall(blk_mq_init);
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index da693e6a834e..784f2e038b55 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -2037,7 +2037,7 @@ static int loop_add(struct loop_device **l, int i)
> >   	lo->tag_set.queue_depth = 128;
> >   	lo->tag_set.numa_node = NUMA_NO_NODE;
> >   	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
> > -	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> > +	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_MANAGED_IRQ;
> >   	lo->tag_set.driver_data = lo;
> >   	err = blk_mq_alloc_tag_set(&lo->tag_set);
> > diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> > index 3f8577e2c13b..5f1ff70ac029 100644
> > --- a/drivers/md/dm-rq.c
> > +++ b/drivers/md/dm-rq.c
> > @@ -547,7 +547,7 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
> >   	md->tag_set->ops = &dm_mq_ops;
> >   	md->tag_set->queue_depth = dm_get_blk_mq_queue_depth();
> >   	md->tag_set->numa_node = md->numa_node_id;
> > -	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
> > +	md->tag_set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_MANAGED_IRQ;
> >   	md->tag_set->nr_hw_queues = dm_get_blk_mq_nr_hw_queues();
> >   	md->tag_set->driver_data = md;
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index b45148ba3291..f550b5274b8b 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -140,6 +140,8 @@ struct blk_mq_hw_ctx {
> >   	 */
> >   	atomic_t		nr_active;
> > +	/** @cpuhp_online: List to store request if CPU is going to die */
> > +	struct hlist_node	cpuhp_online;
> >   	/** @cpuhp_dead: List to store request if some CPU die. */
> >   	struct hlist_node	cpuhp_dead;
> >   	/** @kobj: Kernel object for sysfs. */
> > @@ -391,6 +393,7 @@ struct blk_mq_ops {
> >   enum {
> >   	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
> >   	BLK_MQ_F_TAG_SHARED	= 1 << 1,
> > +	BLK_MQ_F_NO_MANAGED_IRQ	= 1 << 2,
> >   	BLK_MQ_F_BLOCKING	= 1 << 5,
> >   	BLK_MQ_F_NO_SCHED	= 1 << 6,
> >   	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 77d70b633531..24b3a77810b6 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -152,6 +152,7 @@ enum cpuhp_state {
> >   	CPUHP_AP_SMPBOOT_THREADS,
> >   	CPUHP_AP_X86_VDSO_VMA_ONLINE,
> >   	CPUHP_AP_IRQ_AFFINITY_ONLINE,
> > +	CPUHP_AP_BLK_MQ_ONLINE,
> >   	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
> >   	CPUHP_AP_X86_INTEL_EPB_ONLINE,
> >   	CPUHP_AP_PERF_ONLINE,
> > 
> Ho-hum.
> 
> I do agree for the loop and the CPUHP part (not that I'm qualified to just
> the latter, but anyway).
> For the dm side I'm less certain.
> Thing is, we rarely get hardware interrupts directly to the device-mapper
> device, but rather to the underlying hardware LLD.
> I even not quite sure what exactly the implications of managed interrupts
> with dm are; after all, we're using softirqs here, don't we?
> 
> So for DM I'd rather wait for the I/O on the underlying devices' hctx to
> become quiesce, and not kill them ourselves.
> Not sure if the device-mapper framework _can_ do this right now, though.
> Mike?

The problem the patchset tries to address is drivers applying
managed interrupt. When all CPUs of one managed interrupt line are
offline, the IO interrupt may be never to trigger, so IO timeout may
be triggered or IO hang if no timeout handler is provided.

So any drivers which don't use managed interrupt can be marked as
BLK_MQ_F_NO_MANAGED_IRQ.

For dm-rq, request completion is always triggered by underlying request,
so once underlying request is guaranteed to be completed, dm-rq's
request can be completed too.


Thanks,
Ming

