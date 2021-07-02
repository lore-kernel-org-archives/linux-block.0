Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBB8C11F69
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 01:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9206141A
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 01:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhGBBND (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 21:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230404AbhGBBND (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 21:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625188231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0g2+ZNRqPJ2Cy4D39UBIgFuYwfAxP5fijyj/DF3BoqE=;
        b=T/BNAIQj9e4GWxU66FrZlwAmCxi4dufsBUR69Oo1zhV3QtIi5aVieo16k5d0d8vL15IZa7
        ABzQ+g8mYoxVVd/qpnZMyIUGXfGNpCIhYC7GWqLzykkB1vJYW+yUhIJtj+DrY8ykb+hywZ
        GGpo08PcgQWN2dbUhX5SZBrG0+NL3ic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-YnjHJfoxPXuMkjJr8k5g_w-1; Thu, 01 Jul 2021 21:10:30 -0400
X-MC-Unique: YnjHJfoxPXuMkjJr8k5g_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD7B49126B;
        Fri,  2 Jul 2021 01:10:28 +0000 (UTC)
Received: from T590 (ovpn-12-65.pek2.redhat.com [10.72.12.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3BCB5C25D;
        Fri,  2 Jul 2021 01:10:20 +0000 (UTC)
Date:   Fri, 2 Jul 2021 09:10:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block: build default queue map via
 irq_create_affinity_masks
Message-ID: <YN5neLfU37WUwfcA@T590>
References: <20210630035153.2099975-1-ming.lei@redhat.com>
 <5164e557-25bd-377b-da95-ac4b87c99581@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5164e557-25bd-377b-da95-ac4b87c99581@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01, 2021 at 11:06:57AM +0100, John Garry wrote:
> On 30/06/2021 04:51, Ming Lei wrote:
> > The default queue mapping builder of blk_mq_map_queues doesn't take NUMA
> > topo into account, so the built mapping is pretty bad, since CPUs
> > belonging to different NUMA node are assigned to same queue. It is
> > observed that IOPS drops by ~30% when running two jobs on same hctx
> > of null_blk from two CPUs belonging to two NUMA nodes compared with
> > from same NUMA node.
> > 
> > Address the issue by reusing irq_create_affinity_masks() for building
> > the default queue mapping, so that we can re-use the mapping created
> > for managed irq.
> > 
> > Lots of drivers may benefit from the change, such as nvme pci poll,
> > nvme tcp, ...
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq-cpumap.c | 60 +++++++++----------------------------------
> >   1 file changed, 12 insertions(+), 48 deletions(-)
> > 
> > diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> > index 3db84d3197f1..946e373296a3 100644
> > --- a/block/blk-mq-cpumap.c
> > +++ b/block/blk-mq-cpumap.c
> > @@ -10,67 +10,31 @@
> >   #include <linux/mm.h>
> >   #include <linux/smp.h>
> >   #include <linux/cpu.h>
> > +#include <linux/interrupt.h>
> 
> Similar to what Christoph mentioned, seems strange to be including
> interrupt.h

The ideal way is to abstract & move the affinity building code into lib/,
but it needs to refactor kernel/irq/affinity.c a bit.

Also here each queue means one blk-mq hw queue, it is still not too
strange to associate it with interrupt and re-use the interrupt affinity
building code.

Let's see how Thomas thinks about this usage.

> 
> >   #include <linux/blk-mq.h>
> >   #include "blk.h"
> >   #include "blk-mq.h"
> > -static int queue_index(struct blk_mq_queue_map *qmap,
> > -		       unsigned int nr_queues, const int q)
> > -{
> > -	return qmap->queue_offset + (q % nr_queues);
> > -}
> > -
> > -static int get_first_sibling(unsigned int cpu)
> > -{
> > -	unsigned int ret;
> > -
> > -	ret = cpumask_first(topology_sibling_cpumask(cpu));
> > -	if (ret < nr_cpu_ids)
> > -		return ret;
> > -
> > -	return cpu;
> > -}
> > -
> >   int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
> >   {
> > +	struct irq_affinity_desc *masks = NULL;
> > +	struct irq_affinity affd = {0};
> 
> should this be simply {}? I forget...

I think both should be fine, and two usages can be found in kernel code.

> 
> >   	unsigned int *map = qmap->mq_map;
> >   	unsigned int nr_queues = qmap->nr_queues;
> > -	unsigned int cpu, first_sibling, q = 0;
> > +	unsigned int q;
> > -	for_each_possible_cpu(cpu)
> > -		map[cpu] = -1;
> > +	masks = irq_create_affinity_masks(nr_queues, &affd);
> > +	if (!masks)
> > +		return -ENOMEM;
> 
> should we fall back on something else here? Seems that this function does
> not fail just because out of memory.

The default case is nr_set == 1, so the only failure is out of
memory, and irq_create_affinity_masks() basically creates cpumask for
each vector/queue and assigns possible CPUs among these vector/queue.


Thanks,
Ming

