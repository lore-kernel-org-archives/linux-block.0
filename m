Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791CDC433F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 14:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C02C61288
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 14:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344586AbhI2Ojc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 10:39:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3890 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344564AbhI2Ojc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 10:39:32 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HKJnF5lv1z67d0C;
        Wed, 29 Sep 2021 22:35:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 16:37:48 +0200
Received: from [10.47.26.77] (10.47.26.77) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 15:37:47 +0100
Subject: Re: [PATCH V3 5/7] genirq/affinity: move group_cpus_evenly() into
 lib/
To:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jens Axboe" <axboe@kernel.dk>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>
References: <20210928005558.243352-1-ming.lei@redhat.com>
 <20210928005558.243352-6-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <74bcc75e-0b68-1d6b-b7f6-4681ec754257@huawei.com>
Date:   Wed, 29 Sep 2021 15:40:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210928005558.243352-6-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.77]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> +/**
> + * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
> + * @numgrps: number of groups
> + *
> + * Return: cpumask array if successful, NULL otherwise. And each element
> + * includes CPUs assigned to this group
> + *
> + * Try to put close CPUs from viewpoint of CPU and NUMA locality into
> + * same group, and run two-stage grouping:
> + *	1) allocate present CPUs on these groups evenly first
> + *	2) allocate other possible CPUs on these groups evenly
> + *
> + * We guarantee in the resulted grouping that all CPUs are covered, and
> + * no same CPU is assigned to different groups

nit: I'd have "no same CPU is assigned to multiple groups"

> + */
> +struct cpumask *group_cpus_evenly(unsigned int numgrps)

nit: The name group_cpus_evenly() would imply an action on some cpus, 
when it's just calculating some masks - I think "masks" should be at 
least included in the name

> +{
> +	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
> +	cpumask_var_t *node_to_cpumask;
> +	cpumask_var_t nmsk, npresmsk;
> +	int ret = -ENOMEM;
> +	struct cpumask *masks = NULL;
> +
> +	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
> +		return NULL;
> +
> +	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
> +		goto fail_nmsk;
> +
> +	node_to_cpumask = alloc_node_to_cpumask();
> +	if (!node_to_cpumask)
> +		goto fail_npresmsk;
> +
> +	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
> +	if (!masks)
> +		goto fail_node_to_cpumask;
> +
> +	/* Stabilize the cpumasks */
> +	cpus_read_lock();
> +	build_node_to_cpumask(node_to_cpumask);
> +
> +	/* grouping present CPUs first */
> +	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> +				  cpu_present_mask, nmsk, masks);
> +	if (ret < 0)
> +		goto fail_build_affinity;
> +	nr_present = ret;
> +
> +	/*
> +	 * Allocate non present CPUs starting from the next group to be
> +	 * handled. If the grouping of present CPUs already exhausted the
> +	 * group space, assign the non present CPUs to the already
> +	 * allocated out groups.
> +	 */
> +	if (nr_present >= numgrps)
> +		curgrp = 0;
> +	else
> +		curgrp = nr_present;
> +	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> +	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> +				  npresmsk, nmsk, masks);
> +	if (ret >= 0)
> +		nr_others = ret;
> +
> + fail_build_affinity:

nit: Strange that success path goes through "fail" labels. Current code 
is this way, so feel free to ignore.

> +	cpus_read_unlock();
> +
> +	if (ret >= 0)
> +		WARN_ON(nr_present + nr_others < numgrps);
> +
> + fail_node_to_cpumask:
> +	free_node_to_cpumask(node_to_cpumask);
> +
> + fail_npresmsk:
> +	free_cpumask_var(npresmsk);
> +
> + fail_nmsk:
> +	free_cpumask_var(nmsk);
> +	if (ret < 0) {
> +		kfree(masks);
> +		return NULL;
> +	}
> +	return masks;
> +}
> +EXPORT_SYMBOL_GPL(group_cpus_evenly);

Are there any users which are available as modules? As I see, the only 
users are blk-mq-cpumap.c and irq/affinity.c, which I guess aren't 
available as modules.

> 

Thanks,
John

