Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 25 Oct 2018 10:05:21 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org, bfq-iosched@googlegroups.com,
 Federico Motta <federico@willer.it>
Subject: Re: [PATCH BUGFIX] block, bfq: fix asymmetric scenarios detection
In-Reply-To: <20181024171325.7154-1-paolo.valente@linaro.org>
References: <20181024171325.7154-1-paolo.valente@linaro.org>
Message-ID: <b747250df5e1d93175ac0a56e697d611@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Hi.

On 24.10.2018 19:13, Paolo Valente wrote:
> From: Federico Motta <federico@willer.it>
> 
> Since commit 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios
> detection"), a scenario is defined asymmetric when one of the
> following conditions holds:
> - active bfq_queues have different weights
> - one or more group of entities (bfq_queue or other groups of entities)
>   are active
> bfq grants fairness and low latency also in such asymmetric scenarios,
> by plugging the dispatching of I/O if the bfq_queue in service happens
> to be temporarily idle. This plugging may lower throughput, so it is
> important to do it only when strictly needed.
> 
> By mystake, in commit '2d29c9f89fcd' ("block, bfq: improve asymmetric
> scenarios detection") the num_active_groups counter was firstly
> incremented and subsequently decremented at any entity (group or
> bfq_queue) weight change.
> 
> This is useless, because only transitions from active to inactive and
> vice versa matter for that counter. Unfortunately this is also
> incorrect in the following case: the entity at issue is a bfq_queue
> and it is under weight raising. In fact in this case there is a
> spurious increment of the num_active_groups counter.
> 
> This spurious increment may cause scenarios to be wrongly detected as
> asymmetric, thus causing useless plugging and loss of throughput.
> 
> This commit fixes this issue by simply removing the above useless and
> wrong increments and decrements.
> 
> Fixes: 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios 
> detection")
> Signed-off-by: Federico Motta <federico@willer.it>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-wf2q.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 476b5a90a5a4..4b0d5fb69160 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -792,24 +792,18 @@ __bfq_entity_update_weight_prio(struct
> bfq_service_tree *old_st,
>  		 * queue, remove the entity from its old weight counter (if
>  		 * there is a counter associated with the entity).
>  		 */
> -		if (prev_weight != new_weight) {
> -			if (bfqq) {
> -				root = &bfqd->queue_weights_tree;
> -				__bfq_weights_tree_remove(bfqd, bfqq, root);
> -			} else
> -				bfqd->num_active_groups--;
> +		if (prev_weight != new_weight && bfqq) {
> +			root = &bfqd->queue_weights_tree;
> +			__bfq_weights_tree_remove(bfqd, bfqq, root);
>  		}
>  		entity->weight = new_weight;
>  		/*
>  		 * Add the entity, if it is not a weight-raised queue,
>  		 * to the counter associated with its new weight.
>  		 */
> -		if (prev_weight != new_weight) {
> -			if (bfqq && bfqq->wr_coeff == 1) {
> -				/* If we get here, root has been initialized. */
> -				bfq_weights_tree_add(bfqd, bfqq, root);
> -			} else
> -				bfqd->num_active_groups++;
> +		if (prev_weight != new_weight && bfqq && bfqq->wr_coeff == 1) {
> +			/* If we get here, root has been initialized. */
> +			bfq_weights_tree_add(bfqd, bfqq, root);
>  		}
> 
>  		new_st->wsum += entity->weight;

I'm running this patch on 3 machines ATM with no visible smoke. I don't 
do performance comparison here, just checking that nothing is obviously 
broken.

With regard to that,

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
