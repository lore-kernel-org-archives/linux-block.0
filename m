Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E26C19759
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 00:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A362133F
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 00:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfHEA5d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Aug 2019 20:57:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbfHEA5c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 4 Aug 2019 20:57:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3755188311;
        Mon,  5 Aug 2019 00:57:32 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2B4E5D6B0;
        Mon,  5 Aug 2019 00:57:23 +0000 (UTC)
Date:   Mon, 5 Aug 2019 08:57:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        Bob Liu <bob.liu@oracle.com>
Subject: Re: [PATCH V2] blk-mq: balance mapping between present CPUs and
 queues
Message-ID: <20190805005717.GB3449@ming.t460p>
References: <20190725094146.18560-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725094146.18560-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 05 Aug 2019 00:57:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 25, 2019 at 05:41:46PM +0800, Ming Lei wrote:
> Spread queues among present CPUs first, then building mapping on other
> non-present CPUs.
> 
> So we can minimize count of dead queues which are mapped by un-present
> CPUs only. Then bad IO performance can be avoided by unbalanced mapping
> between present CPUs and queues.
> 
> The similar policy has been applied on Managed IRQ affinity.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: Bob Liu <bob.liu@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> 
> V2:
> 	- make sure that sequential mapping can be done
> 
>  block/blk-mq-cpumap.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index f945621a0e8f..0157f2b3485a 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -15,10 +15,10 @@
>  #include "blk.h"
>  #include "blk-mq.h"
>  
> -static int cpu_to_queue_index(struct blk_mq_queue_map *qmap,
> -			      unsigned int nr_queues, const int cpu)
> +static int queue_index(struct blk_mq_queue_map *qmap,
> +		       unsigned int nr_queues, const int q)
>  {
> -	return qmap->queue_offset + (cpu % nr_queues);
> +	return qmap->queue_offset + (q % nr_queues);
>  }
>  
>  static int get_first_sibling(unsigned int cpu)
> @@ -36,21 +36,36 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
>  {
>  	unsigned int *map = qmap->mq_map;
>  	unsigned int nr_queues = qmap->nr_queues;
> -	unsigned int cpu, first_sibling;
> +	unsigned int cpu, first_sibling, q = 0;
> +
> +	for_each_possible_cpu(cpu)
> +		map[cpu] = -1;
> +
> +	/*
> +	 * Spread queues among present CPUs first for minimizing
> +	 * count of dead queues which are mapped by all un-present CPUs
> +	 */
> +	for_each_present_cpu(cpu) {
> +		if (q >= nr_queues)
> +			break;
> +		map[cpu] = queue_index(qmap, nr_queues, q++);
> +	}
>  
>  	for_each_possible_cpu(cpu) {
> +		if (map[cpu] != -1)
> +			continue;
>  		/*
>  		 * First do sequential mapping between CPUs and queues.
>  		 * In case we still have CPUs to map, and we have some number of
>  		 * threads per cores then map sibling threads to the same queue
>  		 * for performance optimizations.
>  		 */
> -		if (cpu < nr_queues) {
> -			map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
> +		if (q < nr_queues) {
> +			map[cpu] = queue_index(qmap, nr_queues, q++);
>  		} else {
>  			first_sibling = get_first_sibling(cpu);
>  			if (first_sibling == cpu)
> -				map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
> +				map[cpu] = queue_index(qmap, nr_queues, q++);
>  			else
>  				map[cpu] = map[first_sibling];
>  		}

Hi Jens,

Could you consider to merge this patch to 5.4?

Thanks,
Ming
