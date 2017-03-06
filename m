Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
CC: Fabio Checconi <fchecconi@gmail.com>, Arianna Avanzini
	<avanzini.arianna@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH RFC 01/14] block, bfq: introduce the BFQ-v0 I/O
 scheduler as an extra scheduler
Date: Mon, 6 Mar 2017 19:40:15 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0DA145@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <20170304160131.57366-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 03/04/2017 08:01 AM, Paolo Valente wrote:=0A=
> BFQ is a proportional-share I/O scheduler, whose general structure,=0A=
> plus a lot of code, are borrowed from CFQ.=0A=
> [ ... ]=0A=
=0A=
This description is very useful. However, since it is identical to the=0A=
description this patch adds to Documentation/block/bfq-iosched.txt I=0A=
propose to leave it out from the patch description.=0A=
=0A=
What seems missing to me is an overview of the limitations of BFQ. Does=0A=
BFQ e.g. support multiple hardware queues?=0A=
=0A=
> +3. What are BFQ's tunable?=0A=
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=0A=
> +[ ... ]=0A=
=0A=
A thorough knowledge of BFQ is required to tune it properly. Users don't=0A=
want to tune I/O schedulers. Has it been considered to invent algorithms=0A=
to tune these parameters automatically?=0A=
=0A=
> + * Licensed under GPL-2.=0A=
=0A=
The COPYING file at the top of the tree mentions that GPL-v2 licensing=0A=
should be specified as follows close to the start of each source file:=0A=
=0A=
    This program is free software; you can redistribute it and/or modify=0A=
    it under the terms of the GNU General Public License as published by=0A=
    the Free Software Foundation; either version 2 of the License, or=0A=
    (at your option) any later version.=0A=
=0A=
    This program is distributed in the hope that it will be useful,=0A=
    but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
    GNU General Public License for more details.=0A=
=0A=
    You should have received a copy of the GNU General Public License=0A=
    along with this program; if not, write to the Free Software=0A=
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA=0A=
    02110-1301 USA=0A=
=0A=
> + * BFQ is a proportional-share I/O scheduler, with some extra=0A=
> + * low-latency capabilities. BFQ also supports full hierarchical=0A=
> + * scheduling through cgroups. Next paragraphs provide an introduction=
=0A=
> + * on BFQ inner workings. Details on BFQ benefits and usage can be=0A=
> + * found in Documentation/block/bfq-iosched.txt.=0A=
=0A=
That reference should be sufficient - please do not duplicate=0A=
Documentation/block/bfq-iosched.txt in block/bfq-iosched.c.=0A=
=0A=
> +/**=0A=
> + * struct bfq_service_tree - per ioprio_class service tree.=0A=
> + *=0A=
> + * Each service tree represents a B-WF2Q+ scheduler on its own.  Each=0A=
> + * ioprio_class has its own independent scheduler, and so its own=0A=
> + * bfq_service_tree.  All the fields are protected by the queue lock=0A=
> + * of the containing bfqd.=0A=
> + */=0A=
> +struct bfq_service_tree {=0A=
> +	/* tree for active entities (i.e., those backlogged) */=0A=
> +	struct rb_root active;=0A=
> +	/* tree for idle entities (i.e., not backlogged, with V <=3D F_i)*/=0A=
> +	struct rb_root idle;=0A=
> +=0A=
> +	struct bfq_entity *first_idle;	/* idle entity with minimum F_i */=0A=
> +	struct bfq_entity *last_idle;	/* idle entity with maximum F_i */=0A=
> +=0A=
> +	u64 vtime; /* scheduler virtual time */=0A=
> +	/* scheduler weight sum; active and idle entities contribute to it */=
=0A=
> +	unsigned long wsum;=0A=
> +};=0A=
=0A=
Inline comments next to structure members are ugly and make the=0A=
structure definition hard to read. Please follow the instructions in=0A=
Documentation/kernel-doc-nano-HOWTO.txt for documenting structure members.=
=0A=
=0A=
> +	u64 finish; /* B-WF2Q+ finish timestamp (aka F_i) */=0A=
> +	u64 start;  /* B-WF2Q+ start timestamp (aka S_i) */=0A=
=0A=
For all times and timestamps, please document the time unit (e.g. s, ms,=0A=
us, ns, jiffies, ...).=0A=
=0A=
> +enum bfq_device_speed {=0A=
> +	BFQ_BFQD_FAST,=0A=
> +	BFQ_BFQD_SLOW,=0A=
> +};=0A=
=0A=
What is the meaning of "fast" and "slow" devices in this context?=0A=
Anyway, since the first patch that uses this enum is patch 6, please=0A=
defer introduction of this enum until patch 6.=0A=
=0A=
> +=0A=
> +/**=0A=
> + * struct bfq_data - per-device data structure.=0A=
> + *=0A=
> + * All the fields are protected by @lock.=0A=
> + */=0A=
> +struct bfq_data {=0A=
> +	/* device request queue */=0A=
> +	struct request_queue *queue;=0A=
> +	[ ... ]=0A=
> +=0A=
> +	/* on-disk position of the last served request */=0A=
> +	sector_t last_position;=0A=
=0A=
What is the relevance of last_position if there are multiple hardware=0A=
queues? Will the BFQ algorithm fail to realize its guarantees in that case?=
=0A=
=0A=
What is the relevance of this structure member for block devices that=0A=
have multiple spindles, e.g. arrays of hard disks?=0A=
=0A=
> +enum bfqq_state_flags {=0A=
> +	BFQ_BFQQ_FLAG_busy =3D 0,		/* has requests or is in service */=0A=
> +	BFQ_BFQQ_FLAG_wait_request,	/* waiting for a request */=0A=
> +	BFQ_BFQQ_FLAG_non_blocking_wait_rq, /*=0A=
> +					     * waiting for a request=0A=
> +					     * without idling the device=0A=
> +					     */=0A=
> +	BFQ_BFQQ_FLAG_fifo_expire,	/* FIFO checked in this slice */=0A=
> +	BFQ_BFQQ_FLAG_idle_window,	/* slice idling enabled */=0A=
> +	BFQ_BFQQ_FLAG_sync,		/* synchronous queue */=0A=
> +	BFQ_BFQQ_FLAG_budget_new,	/* no completion with this budget */=0A=
> +	BFQ_BFQQ_FLAG_IO_bound,		/*=0A=
> +					 * bfqq has timed-out at least once=0A=
> +					 * having consumed at most 2/10 of=0A=
> +					 * its budget=0A=
> +					 */=0A=
> +};=0A=
=0A=
The "BFQ_BFQQ_FLAG_" prefix looks silly and too long to me. How about=0A=
e.g. using the prefix "BFQQF_" instead?=0A=
=0A=
> +#define BFQ_BFQQ_FNS(name)						\=0A=
> +static void bfq_mark_bfqq_##name(struct bfq_queue *bfqq)		\=0A=
> +{									\=0A=
> +	(bfqq)->flags |=3D (1 << BFQ_BFQQ_FLAG_##name);			\=0A=
> +}									\=0A=
> +static void bfq_clear_bfqq_##name(struct bfq_queue *bfqq)		\=0A=
> +{									\=0A=
> +	(bfqq)->flags &=3D ~(1 << BFQ_BFQQ_FLAG_##name);			\=0A=
> +}									\=0A=
> +static int bfq_bfqq_##name(const struct bfq_queue *bfqq)		\=0A=
> +{									\=0A=
> +	return ((bfqq)->flags & (1 << BFQ_BFQQ_FLAG_##name)) !=3D 0;	\=0A=
> +}=0A=
=0A=
Are the bodies of the above functions duplicates of __set_bit(),=0A=
__clear_bit() and test_bit()?=0A=
=0A=
> +/* Expiration reasons. */=0A=
> +enum bfqq_expiration {=0A=
> +	BFQ_BFQQ_TOO_IDLE =3D 0,		/*=0A=
> +					 * queue has been idling for=0A=
> +					 * too long=0A=
> +					 */=0A=
> +	BFQ_BFQQ_BUDGET_TIMEOUT,	/* budget took too long to be used */=0A=
> +	BFQ_BFQQ_BUDGET_EXHAUSTED,	/* budget consumed */=0A=
> +	BFQ_BFQQ_NO_MORE_REQUESTS,	/* the queue has no more requests */=0A=
> +	BFQ_BFQQ_PREEMPTED		/* preemption in progress */=0A=
> +};=0A=
=0A=
The prefix of these constants refers twice to "BFQ" and does not make it=0A=
clear that these constants are about expiration. How about using the=0A=
"BFQQE_" prefix instead?=0A=
=0A=
> +/* Maximum backwards seek, in KiB. */=0A=
> +static const int bfq_back_max =3D 16 * 1024;=0A=
=0A=
Where does this constant come from? Should it depend on geometry data=0A=
like e.g. the number of sectors in a cylinder?=0A=
=0A=
> +#define for_each_entity(entity)	\=0A=
> +	for (; entity ; entity =3D NULL)=0A=
=0A=
Why has this confusing #define been introduced? Shouldn't all=0A=
occurrences of this macro be changed into the equivalent "if (entity)"?=0A=
We don't want silly macros like this in the Linux kernel.=0A=
=0A=
> +#define for_each_entity_safe(entity, parent) \=0A=
> +	for (parent =3D NULL; entity ; entity =3D parent)=0A=
=0A=
Same question here - why has this macro been introduced and how has its=0A=
name been chosen? Since this macro is used only once and since no value=0A=
is assigned to 'parent' in the code controlled by this construct, please=0A=
remove this macro and use something that is less confusing than a "for"=0A=
loop for something that is not a loop.=0A=
=0A=
> +/**=0A=
> + * bfq_weight_to_ioprio - calc an ioprio from a weight.=0A=
> + * @weight: the weight value to convert.=0A=
> + *=0A=
> + * To preserve as much as possible the old only-ioprio user interface,=
=0A=
> + * 0 is used as an escape ioprio value for weights (numerically) equal o=
r=0A=
> + * larger than IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF.=0A=
> + */=0A=
> +static unsigned short bfq_weight_to_ioprio(int weight)=0A=
> +{=0A=
> +	return IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight < 0 ?=0A=
> +		0 : IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight;=0A=
> +}=0A=
=0A=
Please consider using max() or max_t() to make this function less verbose.=
=0A=
=0A=
> +=0A=
> +/**=0A=
> + * bfq_active_extract - remove an entity from the active tree.=0A=
> + * @st: the service_tree containing the tree.=0A=
> + * @entity: the entity being removed.=0A=
> + */=0A=
> +static void bfq_active_extract(struct bfq_service_tree *st,=0A=
> +			       struct bfq_entity *entity)=0A=
> +{=0A=
> +	struct bfq_queue *bfqq =3D bfq_entity_to_bfqq(entity);=0A=
> +	struct rb_node *node;=0A=
> +=0A=
> +	node =3D bfq_find_deepest(&entity->rb_node);=0A=
> +	bfq_extract(&st->active, entity);=0A=
> +=0A=
> +	if (node)=0A=
> +		bfq_update_active_tree(node);=0A=
> +=0A=
> +	if (bfqq)=0A=
> +		list_del(&bfqq->bfqq_list);=0A=
> +}=0A=
=0A=
Which locks protect the data structures manipulated by this and other=0A=
functions? Have you considered to use lockdep_assert_held() to document=0A=
these assumptions?=0A=
=0A=
> +	case (BFQ_RQ1_WRAP|BFQ_RQ2_WRAP): /* both rqs wrapped */=0A=
=0A=
Please don't use parentheses if no confusion is possible. Additionally,=0A=
checkpatch should have requested you to insert a space before and after=0A=
the logical or operator.=0A=
=0A=
> +static void __bfq_set_in_service_queue(struct bfq_data *bfqd,=0A=
> +				       struct bfq_queue *bfqq)=0A=
> +{=0A=
> +	if (bfqq) {=0A=
> +		bfq_mark_bfqq_budget_new(bfqq);=0A=
> +		bfq_clear_bfqq_fifo_expire(bfqq);=0A=
> +=0A=
> +		bfqd->budgets_assigned =3D (bfqd->budgets_assigned*7 + 256) / 8;=0A=
=0A=
Checkpatch should have asked you to insert spaces around the=0A=
multiplication operator.=0A=
=0A=
> +/*=0A=
> + * bfq_default_budget - return the default budget for @bfqq on @bfqd.=0A=
> + * @bfqd: the device descriptor.=0A=
> + * @bfqq: the queue to consider.=0A=
> + *=0A=
> + * We use 3/4 of the @bfqd maximum budget as the default value=0A=
> + * for the max_budget field of the queues.  This lets the feedback=0A=
> + * mechanism to start from some middle ground, then the behavior=0A=
> + * of the process will drive the heuristics towards high values, if=0A=
> + * it behaves as a greedy sequential reader, or towards small values=0A=
> + * if it shows a more intermittent behavior.=0A=
> + */=0A=
> +static unsigned long bfq_default_budget(struct bfq_data *bfqd,=0A=
> +					struct bfq_queue *bfqq)=0A=
> +{=0A=
> +	unsigned long budget;=0A=
> +=0A=
> +	/*=0A=
> +	 * When we need an estimate of the peak rate we need to avoid=0A=
> +	 * to give budgets that are too short due to previous measurements.=0A=
> +	 * So, in the first 10 assignments use a ``safe'' budget value.=0A=
> +	 */=0A=
> +	if (bfqd->budgets_assigned < 194 && bfqd->bfq_user_max_budget =3D=3D 0)=
=0A=
> +		budget =3D bfq_default_max_budget;=0A=
> +	else=0A=
> +		budget =3D bfqd->bfq_max_budget;=0A=
> +=0A=
> +	return budget - budget / 4;=0A=
> +}=0A=
=0A=
Where does the magic constant "194" come from?=0A=
=0A=
=0A=
> +	} else=0A=
> +		/*=0A=
> +		 * Async queues get always the maximum possible=0A=
> +		 * budget, as for them we do not care about latency=0A=
> +		 * (in addition, their ability to dispatch is limited=0A=
> +		 * by the charging factor).=0A=
> +		 */=0A=
> +		budget =3D bfqd->bfq_max_budget;=0A=
> +=0A=
=0A=
Please balance braces. Checkpatch should have warned about the use of "}=0A=
else" instead of "} else {".=0A=
=0A=
> +static unsigned long bfq_calc_max_budget(u64 peak_rate, u64 timeout)=0A=
> +{=0A=
> +	unsigned long max_budget;=0A=
> +=0A=
> +	/*=0A=
> +	 * The max_budget calculated when autotuning is equal to the=0A=
> +	 * amount of sectors transferred in timeout at the=0A=
> +	 * estimated peak rate.=0A=
> +	 */=0A=
> +	max_budget =3D (unsigned long)(peak_rate * 1000 *=0A=
> +				     timeout >> BFQ_RATE_SHIFT);=0A=
> +=0A=
> +	return max_budget;=0A=
> +}=0A=
=0A=
Where does the constant 1000 come from? What are the units of peak_rate=0A=
and timeout? What is the maximum value of peak_rate? Can the=0A=
multiplication overflow?=0A=
=0A=
> +/*=0A=
> + * In addition to updating the peak rate, checks whether the process=0A=
> + * is "slow", and returns 1 if so. This slow flag is used, in addition=
=0A=
> + * to the budget timeout, to reduce the amount of service provided to=0A=
> + * seeky processes, and hence reduce their chances to lower the=0A=
> + * throughput. See the code for more details.=0A=
> + */=0A=
> +static bool bfq_update_peak_rate(struct bfq_data *bfqd, struct bfq_queue=
 *bfqq,=0A=
> +				 bool compensate)=0A=
> +{=0A=
> +	u64 bw, usecs, expected, timeout;=0A=
> +	ktime_t delta;=0A=
> +	int update =3D 0;=0A=
> +=0A=
> +	if (!bfq_bfqq_sync(bfqq) || bfq_bfqq_budget_new(bfqq))=0A=
> +		return false;=0A=
> +=0A=
> +	if (compensate)=0A=
> +		delta =3D bfqd->last_idling_start;=0A=
> +	else=0A=
> +		delta =3D ktime_get();=0A=
> +	delta =3D ktime_sub(delta, bfqd->last_budget_start);=0A=
> +	usecs =3D ktime_to_us(delta);=0A=
> +=0A=
> +	/* Don't trust short/unrealistic values. */=0A=
> +	if (usecs < 100 || usecs >=3D LONG_MAX)=0A=
> +		return false;=0A=
=0A=
If usecs >=3D LONG_MAX that indicates a kernel bug. Please consider=0A=
triggering a kernel warning in that case.=0A=
=0A=
> +/*=0A=
> + * Budget timeout is not implemented through a dedicated timer, but=0A=
> + * just checked on request arrivals and completions, as well as on=0A=
> + * idle timer expirations.=0A=
> + */=0A=
> +static bool bfq_bfqq_budget_timeout(struct bfq_queue *bfqq)=0A=
> +{=0A=
> +	if (bfq_bfqq_budget_new(bfqq) ||=0A=
> +	    time_before(jiffies, bfqq->budget_timeout))=0A=
> +		return false;=0A=
> +	return true;=0A=
> +}=0A=
=0A=
Have you considered to use time_is_after_jiffies() instead of=0A=
time_before(jiffies, ...)?=0A=
=0A=
> +static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,=
=0A=
> +			  struct bfq_io_cq *bic, pid_t pid, int is_sync)=0A=
> +{=0A=
> +	RB_CLEAR_NODE(&bfqq->entity.rb_node);=0A=
> +	INIT_LIST_HEAD(&bfqq->fifo);=0A=
> +=0A=
> +	bfqq->ref =3D 0;=0A=
> +	bfqq->bfqd =3D bfqd;=0A=
> +=0A=
> +	if (bic)=0A=
> +		bfq_set_next_ioprio_data(bfqq, bic);=0A=
> +=0A=
> +	if (is_sync) {=0A=
> +		if (!bfq_class_idle(bfqq))=0A=
> +			bfq_mark_bfqq_idle_window(bfqq);=0A=
> +		bfq_mark_bfqq_sync(bfqq);=0A=
> +	} else=0A=
> +		bfq_clear_bfqq_sync(bfqq);=0A=
> +=0A=
> +	bfqq->ttime.last_end_request =3D ktime_get_ns() - (1ULL<<32);=0A=
> +=0A=
> +	bfq_mark_bfqq_IO_bound(bfqq);=0A=
> +=0A=
> +	bfqq->pid =3D pid;=0A=
> +=0A=
> +	/* Tentative initial value to trade off between thr and lat */=0A=
> +	bfqq->max_budget =3D bfq_default_budget(bfqd, bfqq);=0A=
> +	bfqq->budget_timeout =3D bfq_smallest_from_now();=0A=
> +	bfqq->pid =3D pid;=0A=
> +=0A=
> +	/* first request is almost certainly seeky */=0A=
> +	bfqq->seek_history =3D 1;=0A=
> +}=0A=
=0A=
What is the meaning of the 1ULL << 32 constant?=0A=
=0A=
> +static int __init bfq_init(void)=0A=
> +{=0A=
> +	int ret;=0A=
> +	char msg[50] =3D "BFQ I/O-scheduler: v0";=0A=
=0A=
Please leave out "[50]" and use "static const char" instead of "char".=0A=
=0A=
> diff --git a/block/elevator.c b/block/elevator.c=0A=
> index 01139f5..786fdcd 100644=0A=
> --- a/block/elevator.c=0A=
> +++ b/block/elevator.c=0A=
> @@ -221,14 +221,20 @@ int elevator_init(struct request_queue *q, char *na=
me)=0A=
>  =0A=
>  	if (!e) {=0A=
>  		/*=0A=
> -		 * For blk-mq devices, we default to using mq-deadline,=0A=
> -		 * if available, for single queue devices. If deadline=0A=
> -		 * isn't available OR we have multiple queues, default=0A=
> -		 * to "none".=0A=
> +		 * For blk-mq devices, we default to using bfq, if=0A=
> +		 * available, for single queue devices. If bfq isn't=0A=
> +		 * available, we try mq-deadline. If neither is=0A=
> +		 * available, OR we have multiple queues, default to=0A=
> +		 * "none".=0A=
>  		 */=0A=
>  		if (q->mq_ops) {=0A=
> +			if (q->nr_hw_queues =3D=3D 1) {=0A=
> +				e =3D elevator_get("bfq", false);=0A=
> +				if (!e)=0A=
> +					e =3D elevator_get("mq-deadline", false);=0A=
> +			}=0A=
>  			if (q->nr_hw_queues =3D=3D 1)=0A=
> -				e =3D elevator_get("mq-deadline", false);=0A=
> +				e =3D elevator_get("bfq", false);=0A=
>  			if (!e)=0A=
>  				return 0;=0A=
>  		} else=0A=
> =0A=
=0A=
As Jens wrote, it's way too early to make BFQ the default scheduler.=0A=
=0A=
Bart.=0A=
