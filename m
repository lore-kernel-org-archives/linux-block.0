Return-Path: <borntraeger@de.ibm.com>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <ba994ec6-8db6-f77e-ac73-92e3f6b0135a@de.ibm.com>
 <ae02b9c5-9a2e-cb8b-7828-475b3c0b1cb9@kernel.dk>
 <c438db5f-f4f1-69f8-37f3-e91eae29fa25@de.ibm.com>
 <d8dbde03-f528-1cac-03dd-bcc724fcd5c8@kernel.dk>
 <276625a9-44fb-719d-9281-caacefdbb99f@de.ibm.com>
 <eceae481-cf9a-0429-7a15-c363a8e7bc2a@kernel.dk>
 <1ddd1cd4-2862-849e-7849-82544bcb86be@de.ibm.com>
 <08e6f35a-4f49-973e-99f7-6087b44337c4@kernel.dk>
 <20171122072857.GA19338@lst.de>
 <a1d51b13-c034-e0c8-9428-e360b2c898c3@kernel.dk>
 <20171123143453.GA29715@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 23 Nov 2017 19:17:43 +0100
MIME-Version: 1.0
In-Reply-To: <20171123143453.GA29715@lst.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <cdca47a9-05cc-2676-57fe-904ce8ad5fbc@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 11/23/2017 03:34 PM, Christoph Hellwig wrote:
> FYI, the patch below changes both the irq and block mappings to
> always use the cpu possible map (should be split in two in due time).
> 
> I think this is the right way forward.  For every normal machine
> those two are the same, but for VMs with maxcpus above their normal
> count or some big iron that can grow more cpus it means we waster
> a few more resources for the not present but reserved cpus.  It
> fixes the reported issue for me:


While it fixes the hotplug issue under KVM, the same kernel no longers boots in the host, 
it seems stuck early at boot just before detecting the SCSI disks. I have not yet looked into
that.

Christian
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9f8cffc8a701..3eb169f15842 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -16,11 +16,6 @@
> 
>  static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
>  {
> -	/*
> -	 * Non present CPU will be mapped to queue index 0.
> -	 */
> -	if (!cpu_present(cpu))
> -		return 0;
>  	return cpu % nr_queues;
>  }
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 11097477eeab..612ce1fb7c4e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2114,16 +2114,11 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
>  		INIT_LIST_HEAD(&__ctx->rq_list);
>  		__ctx->queue = q;
> 
> -		/* If the cpu isn't present, the cpu is mapped to first hctx */
> -		if (!cpu_present(i))
> -			continue;
> -
> -		hctx = blk_mq_map_queue(q, i);
> -
>  		/*
>  		 * Set local node, IFF we have more than one hw queue. If
>  		 * not, we remain on the home node of the device
>  		 */
> +		hctx = blk_mq_map_queue(q, i);
>  		if (nr_hw_queues > 1 && hctx->numa_node == NUMA_NO_NODE)
>  			hctx->numa_node = local_memory_node(cpu_to_node(i));
>  	}
> @@ -2180,7 +2175,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>  	 *
>  	 * If the cpu isn't present, the cpu is mapped to first hctx.
>  	 */
> -	for_each_present_cpu(i) {
> +	for_each_possible_cpu(i) {
>  		hctx_idx = q->mq_map[i];
>  		/* unmapped hw queue can be remapped after CPU topo changed */
>  		if (!set->tags[hctx_idx] &&
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index e12d35108225..a37a3b4b6342 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -39,7 +39,7 @@ static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>  	}
>  }
> 
> -static cpumask_var_t *alloc_node_to_present_cpumask(void)
> +static cpumask_var_t *alloc_node_to_possible_cpumask(void)
>  {
>  	cpumask_var_t *masks;
>  	int node;
> @@ -62,7 +62,7 @@ static cpumask_var_t *alloc_node_to_present_cpumask(void)
>  	return NULL;
>  }
> 
> -static void free_node_to_present_cpumask(cpumask_var_t *masks)
> +static void free_node_to_possible_cpumask(cpumask_var_t *masks)
>  {
>  	int node;
> 
> @@ -71,22 +71,22 @@ static void free_node_to_present_cpumask(cpumask_var_t *masks)
>  	kfree(masks);
>  }
> 
> -static void build_node_to_present_cpumask(cpumask_var_t *masks)
> +static void build_node_to_possible_cpumask(cpumask_var_t *masks)
>  {
>  	int cpu;
> 
> -	for_each_present_cpu(cpu)
> +	for_each_possible_cpu(cpu)
>  		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
>  }
> 
> -static int get_nodes_in_cpumask(cpumask_var_t *node_to_present_cpumask,
> +static int get_nodes_in_cpumask(cpumask_var_t *node_to_possible_cpumask,
>  				const struct cpumask *mask, nodemask_t *nodemsk)
>  {
>  	int n, nodes = 0;
> 
>  	/* Calculate the number of nodes in the supplied affinity mask */
>  	for_each_node(n) {
> -		if (cpumask_intersects(mask, node_to_present_cpumask[n])) {
> +		if (cpumask_intersects(mask, node_to_possible_cpumask[n])) {
>  			node_set(n, *nodemsk);
>  			nodes++;
>  		}
> @@ -109,7 +109,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  	int last_affv = affv + affd->pre_vectors;
>  	nodemask_t nodemsk = NODE_MASK_NONE;
>  	struct cpumask *masks;
> -	cpumask_var_t nmsk, *node_to_present_cpumask;
> +	cpumask_var_t nmsk, *node_to_possible_cpumask;
> 
>  	/*
>  	 * If there aren't any vectors left after applying the pre/post
> @@ -125,8 +125,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  	if (!masks)
>  		goto out;
> 
> -	node_to_present_cpumask = alloc_node_to_present_cpumask();
> -	if (!node_to_present_cpumask)
> +	node_to_possible_cpumask = alloc_node_to_possible_cpumask();
> +	if (!node_to_possible_cpumask)
>  		goto out;
> 
>  	/* Fill out vectors at the beginning that don't need affinity */
> @@ -135,8 +135,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
> 
>  	/* Stabilize the cpumasks */
>  	get_online_cpus();
> -	build_node_to_present_cpumask(node_to_present_cpumask);
> -	nodes = get_nodes_in_cpumask(node_to_present_cpumask, cpu_present_mask,
> +	build_node_to_possible_cpumask(node_to_possible_cpumask);
> +	nodes = get_nodes_in_cpumask(node_to_possible_cpumask, cpu_possible_mask,
>  				     &nodemsk);
> 
>  	/*
> @@ -146,7 +146,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  	if (affv <= nodes) {
>  		for_each_node_mask(n, nodemsk) {
>  			cpumask_copy(masks + curvec,
> -				     node_to_present_cpumask[n]);
> +				     node_to_possible_cpumask[n]);
>  			if (++curvec == last_affv)
>  				break;
>  		}
> @@ -160,7 +160,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
> 
>  		/* Get the cpus on this node which are in the mask */
> -		cpumask_and(nmsk, cpu_present_mask, node_to_present_cpumask[n]);
> +		cpumask_and(nmsk, cpu_possible_mask, node_to_possible_cpumask[n]);
> 
>  		/* Calculate the number of cpus per vector */
>  		ncpus = cpumask_weight(nmsk);
> @@ -192,7 +192,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  	/* Fill out vectors at the end that don't need affinity */
>  	for (; curvec < nvecs; curvec++)
>  		cpumask_copy(masks + curvec, irq_default_affinity);
> -	free_node_to_present_cpumask(node_to_present_cpumask);
> +	free_node_to_possible_cpumask(node_to_possible_cpumask);
>  out:
>  	free_cpumask_var(nmsk);
>  	return masks;
> @@ -214,7 +214,7 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
>  		return 0;
> 
>  	get_online_cpus();
> -	ret = min_t(int, cpumask_weight(cpu_present_mask), vecs) + resv;
> +	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
>  	put_online_cpus();
>  	return ret;
>  }
> 
