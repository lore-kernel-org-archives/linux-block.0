Return-Path: <BATV+58df4a3654e5af2e30cf+5310+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 7 Mar 2018 23:48:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: kbuild test robot <lkp@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, kbuild-all@01.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V2 3/5] genirq/affinity: move actual irq vector spread
 into one helper
Message-ID: <20180308074859.GA17098@infradead.org>
References: <20180305031357.23950-4-ming.lei@redhat.com>
 <201803060052.L1IpJHee%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201803060052.L1IpJHee%fengguang.wu@intel.com>
List-ID: <linux-block@vger.kernel.org>

Can you fix this up and resend?

On Tue, Mar 06, 2018 at 12:28:32AM +0800, kbuild test robot wrote:
> Hi Ming,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/irq/core]
> [also build test WARNING on v4.16-rc4 next-20180305]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Ming-Lei/genirq-affinity-irq-vector-spread-among-online-CPUs-as-far-as-possible/20180305-184912
> config: i386-randconfig-a1-201809 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/irq/affinity.c: In function 'irq_create_affinity_masks':
> >> kernel/irq/affinity.c:201:50: warning: passing argument 3 of 'irq_build_affinity_masks' from incompatible pointer type
>      curvec += irq_build_affinity_masks(nvecs, affd, node_to_cpumask,
>                                                      ^
>    kernel/irq/affinity.c:97:12: note: expected 'const struct cpumask (*)[1]' but argument is of type 'struct cpumask (*)[1]'
>     static int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
>                ^
> 
> vim +/irq_build_affinity_masks +201 kernel/irq/affinity.c
> 
>    161	
>    162	/**
>    163	 * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
>    164	 * @nvecs:	The total number of vectors
>    165	 * @affd:	Description of the affinity requirements
>    166	 *
>    167	 * Returns the masks pointer or NULL if allocation failed.
>    168	 */
>    169	struct cpumask *
>    170	irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>    171	{
>    172		int curvec;
>    173		struct cpumask *masks;
>    174		cpumask_var_t nmsk, *node_to_cpumask;
>    175	
>    176		/*
>    177		 * If there aren't any vectors left after applying the pre/post
>    178		 * vectors don't bother with assigning affinity.
>    179		 */
>    180		if (nvecs == affd->pre_vectors + affd->post_vectors)
>    181			return NULL;
>    182	
>    183		if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
>    184			return NULL;
>    185	
>    186		masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
>    187		if (!masks)
>    188			goto out;
>    189	
>    190		node_to_cpumask = alloc_node_to_cpumask();
>    191		if (!node_to_cpumask)
>    192			goto out;
>    193	
>    194		/* Fill out vectors at the beginning that don't need affinity */
>    195		for (curvec = 0; curvec < affd->pre_vectors; curvec++)
>    196			cpumask_copy(masks + curvec, irq_default_affinity);
>    197	
>    198		/* Stabilize the cpumasks */
>    199		get_online_cpus();
>    200		build_node_to_cpumask(node_to_cpumask);
>  > 201		curvec += irq_build_affinity_masks(nvecs, affd, node_to_cpumask,
>    202						   cpu_possible_mask, nmsk, masks);
>    203		put_online_cpus();
>    204	
>    205		/* Fill out vectors at the end that don't need affinity */
>    206		for (; curvec < nvecs; curvec++)
>    207			cpumask_copy(masks + curvec, irq_default_affinity);
>    208		free_node_to_cpumask(node_to_cpumask);
>    209	out:
>    210		free_cpumask_var(nmsk);
>    211		return masks;
>    212	}
>    213	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


---end quoted text---
