Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36530C11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 10:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D5361481
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 10:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhGAKQZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 06:16:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3337 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhGAKQZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jul 2021 06:16:25 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GFv4D0CPwz6G8Y3;
        Thu,  1 Jul 2021 18:06:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 1 Jul 2021 12:13:52 +0200
Received: from [10.47.27.103] (10.47.27.103) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 1 Jul 2021
 11:13:52 +0100
Subject: Re: [PATCH] block: build default queue map via
 irq_create_affinity_masks
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
References: <20210630035153.2099975-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5164e557-25bd-377b-da95-ac4b87c99581@huawei.com>
Date:   Thu, 1 Jul 2021 11:06:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210630035153.2099975-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.103]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/06/2021 04:51, Ming Lei wrote:
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
>   block/blk-mq-cpumap.c | 60 +++++++++----------------------------------
>   1 file changed, 12 insertions(+), 48 deletions(-)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 3db84d3197f1..946e373296a3 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -10,67 +10,31 @@
>   #include <linux/mm.h>
>   #include <linux/smp.h>
>   #include <linux/cpu.h>
> +#include <linux/interrupt.h>

Similar to what Christoph mentioned, seems strange to be including 
interrupt.h

>   
>   #include <linux/blk-mq.h>
>   #include "blk.h"
>   #include "blk-mq.h"
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
>   int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
>   {
> +	struct irq_affinity_desc *masks = NULL;
> +	struct irq_affinity affd = {0};

should this be simply {}? I forget...

>   	unsigned int *map = qmap->mq_map;
>   	unsigned int nr_queues = qmap->nr_queues;
> -	unsigned int cpu, first_sibling, q = 0;
> +	unsigned int q;
>   
> -	for_each_possible_cpu(cpu)
> -		map[cpu] = -1;
> +	masks = irq_create_affinity_masks(nr_queues, &affd);
> +	if (!masks)
> +		return -ENOMEM;

should we fall back on something else here? Seems that this function 
does not fail just because out of memory.

Thanks,
John
