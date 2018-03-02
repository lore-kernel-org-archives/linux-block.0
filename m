Return-Path: <hch@lst.de>
Date: Sat, 3 Mar 2018 00:07:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] genirq/affinity: move actual irq vector spread
	into one helper
Message-ID: <20180302230738.GB31468@lst.de>
References: <20180206121742.29336-1-ming.lei@redhat.com> <20180206121742.29336-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180206121742.29336-3-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 06, 2018 at 08:17:39PM +0800, Ming Lei wrote:
> No functional change, just prepare for converting to 2-stage
> irq vector spread.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  kernel/irq/affinity.c | 99 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 56 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 4b1c4763212d..6af3f6727f63 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -79,7 +79,7 @@ static void build_node_to_cpumask(cpumask_var_t *masks)
>  		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
>  }
>  
> -static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
> +static int get_nodes_in_cpumask(const cpumask_var_t *node_to_cpumask,
>  				const struct cpumask *mask, nodemask_t *nodemsk)

Maybe you can split all your constifications into a separate prep patch?

> +int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
> +			     const cpumask_var_t *node_to_cpumask,
> +			     const struct cpumask *cpu_mask,
> +			     struct cpumask *nmsk,
> +			     struct cpumask *masks)

static?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
