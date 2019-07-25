Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B931C7618B
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 09:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65ADF2190F
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 09:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbfGYJS1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:18:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390290AbfGYJS1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 05:18:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2529E307D851;
        Thu, 25 Jul 2019 09:18:27 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44EF161F21;
        Thu, 25 Jul 2019 09:18:14 +0000 (UTC)
Date:   Thu, 25 Jul 2019 17:18:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bob Liu <bob.liu@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] blk-mq: balance mapping between CPUs and queues
Message-ID: <20190725091806.GA4159@ming.t460p>
References: <20190725075604.1106-1-ming.lei@redhat.com>
 <0225f4eb-364c-fa0c-5d72-e2a58bf9ae68@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0225f4eb-364c-fa0c-5d72-e2a58bf9ae68@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 25 Jul 2019 09:18:27 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 25, 2019 at 04:35:30PM +0800, Bob Liu wrote:
> On 7/25/19 4:26 PM, Ming Lei wrote:
> > Spread queues among present CPUs first, then building the mapping
> > on other non-present CPUs.
> > 
> > So we can minimize count of dead queues which are mapped by un-present
> > CPUs only. Then bad IO performance can be avoided by this unbalanced
> > mapping between CPUs and queues.
> > 
> > The similar policy has been applied on Managed IRQ affinity.
> > 
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Cc: Yi Zhang <yi.zhang@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-cpumap.c | 34 +++++++++++++++++++++++-----------
> >  1 file changed, 23 insertions(+), 11 deletions(-)
> > 
> > diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> > index f945621a0e8f..e217f3404dc7 100644
> > --- a/block/blk-mq-cpumap.c
> > +++ b/block/blk-mq-cpumap.c
> > @@ -15,10 +15,9 @@
> >  #include "blk.h"
> >  #include "blk-mq.h"
> >  
> > -static int cpu_to_queue_index(struct blk_mq_queue_map *qmap,
> > -			      unsigned int nr_queues, const int cpu)
> > +static int queue_index(struct blk_mq_queue_map *qmap, const int q)
> >  {
> > -	return qmap->queue_offset + (cpu % nr_queues);
> > +	return qmap->queue_offset + q;
> >  }
> >  
> >  static int get_first_sibling(unsigned int cpu)
> > @@ -36,23 +35,36 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
> >  {
> >  	unsigned int *map = qmap->mq_map;
> >  	unsigned int nr_queues = qmap->nr_queues;
> > -	unsigned int cpu, first_sibling;
> > +	unsigned int cpu, first_sibling, q = 0;
> > +
> > +	for_each_possible_cpu(cpu)
> > +		map[cpu] = -1;
> > +
> > +	/*
> > +	 * Spread queues among present CPUs first for minimizing
> > +	 * count of dead queues which are mapped by all un-present CPUs
> > +	 */
> > +	for_each_present_cpu(cpu) {
> > +		if (q >= nr_queues)
> > +			break;
> > +		map[cpu] = queue_index(qmap, q++);
> > +	}
> >  
> >  	for_each_possible_cpu(cpu) {
> > +		if (map[cpu] != -1)
> > +			continue;
> >  		/*
> >  		 * First do sequential mapping between CPUs and queues.
> >  		 * In case we still have CPUs to map, and we have some number of
> >  		 * threads per cores then map sibling threads to the same queue
> >  		 * for performance optimizations.
> >  		 */
> > -		if (cpu < nr_queues) {
> > -			map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
> 
> Why not keep this similarly? 

Because the sequential mapping has been done already among present CPUs.

> 
> > +		first_sibling = get_first_sibling(cpu);
> > +		if (first_sibling == cpu) {
> > +			map[cpu] = queue_index(qmap, q);
> > +			q = (q + 1) % nr_queues;
> >  		} else {
> > -			first_sibling = get_first_sibling(cpu);
> > -			if (first_sibling == cpu)
> > -				map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
> > -			else
> > -				map[cpu] = map[first_sibling];
> > +			map[cpu] = map[first_sibling];
> 
> Then no need to share queue if nr_queues is enough for all possible cpu.

I am not sure I follow your idea. There isn't 'enough' stuff wrt.
nr_queues, which is just usually <= nr_queues.

The valid mapping has to cover all possible CPUs, and each queue's
mapping can't be overlapped with others. That is exactly what
the patch is doing.

If you think somewhere is wrong or not good enough, please point it
out.


thanks, 
Ming
