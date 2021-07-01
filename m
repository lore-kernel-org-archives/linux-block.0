Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B282C11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB5361493
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 09:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbhGAJ5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbhGAJ5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jul 2021 05:57:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008D6C0617A8
        for <linux-block@vger.kernel.org>; Thu,  1 Jul 2021 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KBnHe560xh+CEY6NJFxvxkBiqtB4lC8fH7s4U/6kLMU=; b=smqhioW249pHvhstEP02wv2suR
        XAAvB5UY8tUkWxi1lkSYpi8NWtOwO7mgde8+RsiN7EIVIQJaZnrpJcyXVMkghL1ofdHMnU0C7oZp8
        rPzvFflRMVSdGWp8sHV1EkmMSQz7Y+HdtjY+Fw4ayrgaMDdsXA2YuuLHuLbdJjmSldu+WAmf2bN9J
        tMXJVIJ6DGte2nHeEg6r28296muOlBZ1jvaibgIUjQUMKjd3WaP5J6Yq5YcSCFJUdYVYar/qtA5tD
        Fgd4MIK4UDtPivvOAFBmqlof+YM9te4WPF8o90wD6wEDdzIKcMSDfBuufHKD6NBdTP/DKAxkC5j93
        4l9X77/Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lytP3-006Q88-Jv; Thu, 01 Jul 2021 09:54:46 +0000
Date:   Thu, 1 Jul 2021 10:54:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] block: build default queue map via
 irq_create_affinity_masks
Message-ID: <YN2Q3XFSS7T23bih@infradead.org>
References: <20210630035153.2099975-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630035153.2099975-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 30, 2021 at 11:51:53AM +0800, Ming Lei wrote:
> The default queue mapping builder of blk_mq_map_queues doesn't take NUMA
> topo into account, so the built mapping is pretty bad, since CPUs
> belonging to different NUMA node are assigned to same queue. It is
> observed that IOPS drops by ~30% when running two jobs on same hctx
> of null_blk from two CPUs belonging to two NUMA nodes compared with
> from same NUMA node.
> 
> Address the issue by reusing irq_create_affinity_masks() for building
> the default queue mapping, so that we can re-use the mapping created
> for managed irq.

This looks sensible, but adding Thomas to see if he is fine with
using an irq function like this.  Maybe it needs to move out of the
irq code and grow a new name if we use it like this.

> 
> Lots of drivers may benefit from the change, such as nvme pci poll,
> nvme tcp, ...
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-cpumap.c | 60 +++++++++----------------------------------
>  1 file changed, 12 insertions(+), 48 deletions(-)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 3db84d3197f1..946e373296a3 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -10,67 +10,31 @@
>  #include <linux/mm.h>
>  #include <linux/smp.h>
>  #include <linux/cpu.h>
> +#include <linux/interrupt.h>
>  
>  #include <linux/blk-mq.h>
>  #include "blk.h"
>  #include "blk-mq.h"
>  
> -static int queue_index(struct blk_mq_queue_map *qmap,
> -		       unsigned int nr_queues, const int q)
> -{
> -	return qmap->queue_offset + (q % nr_queues);
> -}
> -
> -static int get_first_sibling(unsigned int cpu)
> -{
> -	unsigned int ret;
> -
> -	ret = cpumask_first(topology_sibling_cpumask(cpu));
> -	if (ret < nr_cpu_ids)
> -		return ret;
> -
> -	return cpu;
> -}
> -
>  int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
>  {
> +	struct irq_affinity_desc *masks = NULL;
> +	struct irq_affinity affd = {0};
>  	unsigned int *map = qmap->mq_map;
>  	unsigned int nr_queues = qmap->nr_queues;
> -	unsigned int cpu, first_sibling, q = 0;
> +	unsigned int q;
>  
> -	for_each_possible_cpu(cpu)
> -		map[cpu] = -1;
> +	masks = irq_create_affinity_masks(nr_queues, &affd);
> +	if (!masks)
> +		return -ENOMEM;
>  
> -	/*
> -	 * Spread queues among present CPUs first for minimizing
> -	 * count of dead queues which are mapped by all un-present CPUs
> -	 */
> -	for_each_present_cpu(cpu) {
> -		if (q >= nr_queues)
> -			break;
> -		map[cpu] = queue_index(qmap, nr_queues, q++);
> -	}
> +	for (q = 0; q < nr_queues; q++) {
> +		unsigned int cpu;
>  
> -	for_each_possible_cpu(cpu) {
> -		if (map[cpu] != -1)
> -			continue;
> -		/*
> -		 * First do sequential mapping between CPUs and queues.
> -		 * In case we still have CPUs to map, and we have some number of
> -		 * threads per cores then map sibling threads to the same queue
> -		 * for performance optimizations.
> -		 */
> -		if (q < nr_queues) {
> -			map[cpu] = queue_index(qmap, nr_queues, q++);
> -		} else {
> -			first_sibling = get_first_sibling(cpu);
> -			if (first_sibling == cpu)
> -				map[cpu] = queue_index(qmap, nr_queues, q++);
> -			else
> -				map[cpu] = map[first_sibling];
> -		}
> +		for_each_cpu(cpu, &masks[q].mask)
> +			map[cpu] = q;
>  	}
> -
> +	kfree(masks);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_map_queues);
> -- 
> 2.31.1
> 
---end quoted text---
