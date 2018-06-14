Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] brd: Allow ramdisk to be allocated on selected NUMA node
To: Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, Mel Gorman <mgorman@suse.com>,
 Hannes Reinecke <hare@suse.com>
References: <20180614133832.110947-1-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <08318d74-d81c-29e5-5350-525df96eaacb@kernel.dk>
Date: Thu, 14 Jun 2018 08:47:33 -0600
MIME-Version: 1.0
In-Reply-To: <20180614133832.110947-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/14/18 7:38 AM, Hannes Reinecke wrote:
> For performance reasons we should be able to allocate all memory
> from a given NUMA node, so this patch adds a new parameter
> 'rd_numa_node' to allow the user to specify the NUMA node id.
> When restricing fio to use the same NUMA node I'm seeing a performance
> boost of more than 200%.

Looks fine to me. One comment.

> @@ -342,6 +343,10 @@ static int max_part = 1;
>  module_param(max_part, int, 0444);
>  MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
>  
> +static int rd_numa_node = NUMA_NO_NODE;
> +module_param(rd_numa_node, int, 0444);
> +MODULE_PARM_DESC(rd_numa_node, "NUMA node number to allocate RAM disk on.");

This could feasibly be 0644, as there would be nothing wrong with altering
this at runtime.

-- 
Jens Axboe
