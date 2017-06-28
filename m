Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36597 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbdF1O7D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 10:59:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id y5so12010146wmh.3
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2017 07:58:57 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: map all HWQ also in hyperthreaded system
To: Max Gurtovoy <maxg@mellanox.com>, axboe@fb.com, hch@lst.de,
        bvanassche@acm.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc: vladimirk@mellanox.com
References: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e9cccad7-804a-f68b-b184-46cc5be2f01d@grimberg.me>
Date: Wed, 28 Jun 2017 17:58:53 +0300
MIME-Version: 1.0
In-Reply-To: <1498653880-29223-1-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> +static int cpu_to_queue_index(unsigned int nr_queues, const int cpu,
> +			      const struct cpumask *online_mask)
>   {
> -	return cpu * nr_queues / nr_cpus;
> +	/*
> +	 * Non online CPU will be mapped to queue index 0.
> +	 */
> +	if (!cpumask_test_cpu(cpu, online_mask))
> +		return 0;

Why not map offline cpus to what they would've map to if they were
online?

> +		if (cpu < nr_queues) {
> +			map[cpu] = cpu_to_queue_index(nr_queues, cpu, online_mask);
> +		} else {
> +			first_sibling = get_first_sibling(cpu);
> +			if (first_sibling == cpu)
> +				map[cpu] = cpu_to_queue_index(nr_queues, cpu, online_mask);

This seems to be the only reference to online_mask left (on each side of
the if statement. I think you can just not pass it and use
cpu_online_mask in cpu_to_queue_index.
