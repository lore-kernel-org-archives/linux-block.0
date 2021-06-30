Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2867BC11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 07:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F9661D03
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 07:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhF3Hkw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 03:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233010AbhF3Hkw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 03:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625038703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ygn53gMCPK5uQpNuDNfZ0SnQrRr47gyThM24mtG1Fpk=;
        b=RR/Er+82pnaVN1OUDR2ViXd8Q/8USn9pXeaEUH87VM6EfMvPdpuNSZXZ26D9HRxYHjOfbQ
        2tj5F2ze3oqi3cpQWu5w3MnDKayMjunz1Ztz2RRjrDhk7tcpNsgGru4LNrV29Cn0dlRpNO
        cAKK5OL0t4Hz7VNmwHLTF/qBLpZzqvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-0QjpzeVINYKczPN7d0kQQQ-1; Wed, 30 Jun 2021 03:38:21 -0400
X-MC-Unique: 0QjpzeVINYKczPN7d0kQQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A338E19200C5;
        Wed, 30 Jun 2021 07:38:20 +0000 (UTC)
Received: from T590 (ovpn-13-153.pek2.redhat.com [10.72.13.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F0F1E715;
        Wed, 30 Jun 2021 07:38:15 +0000 (UTC)
Date:   Wed, 30 Jun 2021 15:38:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] block: build default queue map via
 irq_create_affinity_masks
Message-ID: <YNwfY6kExqJM65+L@T590>
References: <20210630035153.2099975-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630035153.2099975-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

oops, the above line should have been:

			map[cpu] = qmap->queue_offset + q;

Thanks,
Ming

