Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 01/14] block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1D08B61A9CF0974AA09887BE32D889DA0DA145@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Date: Tue, 14 Mar 2017 15:18:08 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>
Message-Id: <0720F2E9-FCCB-491B-8EBD-725346847436@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <20170304160131.57366-2-paolo.valente@linaro.org> <1D08B61A9CF0974AA09887BE32D889DA0DA145@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 06 mar 2017, alle ore 20:40, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20

Hi Bart,
thanks for such an accurate review.  I'm addressing the issues you
raised, and I'll get back in touch as soon as I have finished.

Paolo

> On 03/04/2017 08:01 AM, Paolo Valente wrote:
>> BFQ is a proportional-share I/O scheduler, whose general structure,
>> plus a lot of code, are borrowed from CFQ.
>> [ ... ]
>=20
> This description is very useful. However, since it is identical to the
> description this patch adds to Documentation/block/bfq-iosched.txt I
> propose to leave it out from the patch description.
>=20
> What seems missing to me is an overview of the limitations of BFQ. =
Does
> BFQ e.g. support multiple hardware queues?
>=20
>> +3. What are BFQ's tunable?
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> +[ ... ]
>=20
> A thorough knowledge of BFQ is required to tune it properly. Users =
don't
> want to tune I/O schedulers. Has it been considered to invent =
algorithms
> to tune these parameters automatically?
>=20
>> + * Licensed under GPL-2.
>=20
> The COPYING file at the top of the tree mentions that GPL-v2 licensing
> should be specified as follows close to the start of each source file:
>=20
>    This program is free software; you can redistribute it and/or =
modify
>    it under the terms of the GNU General Public License as published =
by
>    the Free Software Foundation; either version 2 of the License, or
>    (at your option) any later version.
>=20
>    This program is distributed in the hope that it will be useful,
>    but WITHOUT ANY WARRANTY; without even the implied warranty of
>    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>    GNU General Public License for more details.
>=20
>    You should have received a copy of the GNU General Public License
>    along with this program; if not, write to the Free Software
>    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>    02110-1301 USA
>=20
>> + * BFQ is a proportional-share I/O scheduler, with some extra
>> + * low-latency capabilities. BFQ also supports full hierarchical
>> + * scheduling through cgroups. Next paragraphs provide an =
introduction
>> + * on BFQ inner workings. Details on BFQ benefits and usage can be
>> + * found in Documentation/block/bfq-iosched.txt.
>=20
> That reference should be sufficient - please do not duplicate
> Documentation/block/bfq-iosched.txt in block/bfq-iosched.c.
>=20
>> +/**
>> + * struct bfq_service_tree - per ioprio_class service tree.
>> + *
>> + * Each service tree represents a B-WF2Q+ scheduler on its own.  =
Each
>> + * ioprio_class has its own independent scheduler, and so its own
>> + * bfq_service_tree.  All the fields are protected by the queue lock
>> + * of the containing bfqd.
>> + */
>> +struct bfq_service_tree {
>> +	/* tree for active entities (i.e., those backlogged) */
>> +	struct rb_root active;
>> +	/* tree for idle entities (i.e., not backlogged, with V <=3D =
F_i)*/
>> +	struct rb_root idle;
>> +
>> +	struct bfq_entity *first_idle;	/* idle entity with minimum F_i =
*/
>> +	struct bfq_entity *last_idle;	/* idle entity with maximum F_i =
*/
>> +
>> +	u64 vtime; /* scheduler virtual time */
>> +	/* scheduler weight sum; active and idle entities contribute to =
it */
>> +	unsigned long wsum;
>> +};
>=20
> Inline comments next to structure members are ugly and make the
> structure definition hard to read. Please follow the instructions in
> Documentation/kernel-doc-nano-HOWTO.txt for documenting structure =
members.
>=20
>> +	u64 finish; /* B-WF2Q+ finish timestamp (aka F_i) */
>> +	u64 start;  /* B-WF2Q+ start timestamp (aka S_i) */
>=20
> For all times and timestamps, please document the time unit (e.g. s, =
ms,
> us, ns, jiffies, ...).
>=20
>> +enum bfq_device_speed {
>> +	BFQ_BFQD_FAST,
>> +	BFQ_BFQD_SLOW,
>> +};
>=20
> What is the meaning of "fast" and "slow" devices in this context?
> Anyway, since the first patch that uses this enum is patch 6, please
> defer introduction of this enum until patch 6.
>=20
>> +
>> +/**
>> + * struct bfq_data - per-device data structure.
>> + *
>> + * All the fields are protected by @lock.
>> + */
>> +struct bfq_data {
>> +	/* device request queue */
>> +	struct request_queue *queue;
>> +	[ ... ]
>> +
>> +	/* on-disk position of the last served request */
>> +	sector_t last_position;
>=20
> What is the relevance of last_position if there are multiple hardware
> queues? Will the BFQ algorithm fail to realize its guarantees in that =
case?
>=20
> What is the relevance of this structure member for block devices that
> have multiple spindles, e.g. arrays of hard disks?
>=20
>> +enum bfqq_state_flags {
>> +	BFQ_BFQQ_FLAG_busy =3D 0,		/* has requests or is in =
service */
>> +	BFQ_BFQQ_FLAG_wait_request,	/* waiting for a request */
>> +	BFQ_BFQQ_FLAG_non_blocking_wait_rq, /*
>> +					     * waiting for a request
>> +					     * without idling the device
>> +					     */
>> +	BFQ_BFQQ_FLAG_fifo_expire,	/* FIFO checked in this slice */
>> +	BFQ_BFQQ_FLAG_idle_window,	/* slice idling enabled */
>> +	BFQ_BFQQ_FLAG_sync,		/* synchronous queue */
>> +	BFQ_BFQQ_FLAG_budget_new,	/* no completion with this =
budget */
>> +	BFQ_BFQQ_FLAG_IO_bound,		/*
>> +					 * bfqq has timed-out at least =
once
>> +					 * having consumed at most 2/10 =
of
>> +					 * its budget
>> +					 */
>> +};
>=20
> The "BFQ_BFQQ_FLAG_" prefix looks silly and too long to me. How about
> e.g. using the prefix "BFQQF_" instead?
>=20
>> +#define BFQ_BFQQ_FNS(name)						=
\
>> +static void bfq_mark_bfqq_##name(struct bfq_queue *bfqq)		=
\
>> +{									=
\
>> +	(bfqq)->flags |=3D (1 << BFQ_BFQQ_FLAG_##name);			=
\
>> +}									=
\
>> +static void bfq_clear_bfqq_##name(struct bfq_queue *bfqq)		=
\
>> +{									=
\
>> +	(bfqq)->flags &=3D ~(1 << BFQ_BFQQ_FLAG_##name);			=
\
>> +}									=
\
>> +static int bfq_bfqq_##name(const struct bfq_queue *bfqq)		=
\
>> +{									=
\
>> +	return ((bfqq)->flags & (1 << BFQ_BFQQ_FLAG_##name)) !=3D 0;	=
\
>> +}
>=20
> Are the bodies of the above functions duplicates of __set_bit(),
> __clear_bit() and test_bit()?
>=20
>> +/* Expiration reasons. */
>> +enum bfqq_expiration {
>> +	BFQ_BFQQ_TOO_IDLE =3D 0,		/*
>> +					 * queue has been idling for
>> +					 * too long
>> +					 */
>> +	BFQ_BFQQ_BUDGET_TIMEOUT,	/* budget took too long to be =
used */
>> +	BFQ_BFQQ_BUDGET_EXHAUSTED,	/* budget consumed */
>> +	BFQ_BFQQ_NO_MORE_REQUESTS,	/* the queue has no more =
requests */
>> +	BFQ_BFQQ_PREEMPTED		/* preemption in progress */
>> +};
>=20
> The prefix of these constants refers twice to "BFQ" and does not make =
it
> clear that these constants are about expiration. How about using the
> "BFQQE_" prefix instead?
>=20
>> +/* Maximum backwards seek, in KiB. */
>> +static const int bfq_back_max =3D 16 * 1024;
>=20
> Where does this constant come from? Should it depend on geometry data
> like e.g. the number of sectors in a cylinder?
>=20
>> +#define for_each_entity(entity)	\
>> +	for (; entity ; entity =3D NULL)
>=20
> Why has this confusing #define been introduced? Shouldn't all
> occurrences of this macro be changed into the equivalent "if =
(entity)"?
> We don't want silly macros like this in the Linux kernel.
>=20
>> +#define for_each_entity_safe(entity, parent) \
>> +	for (parent =3D NULL; entity ; entity =3D parent)
>=20
> Same question here - why has this macro been introduced and how has =
its
> name been chosen? Since this macro is used only once and since no =
value
> is assigned to 'parent' in the code controlled by this construct, =
please
> remove this macro and use something that is less confusing than a =
"for"
> loop for something that is not a loop.
>=20
>> +/**
>> + * bfq_weight_to_ioprio - calc an ioprio from a weight.
>> + * @weight: the weight value to convert.
>> + *
>> + * To preserve as much as possible the old only-ioprio user =
interface,
>> + * 0 is used as an escape ioprio value for weights (numerically) =
equal or
>> + * larger than IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF.
>> + */
>> +static unsigned short bfq_weight_to_ioprio(int weight)
>> +{
>> +	return IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight < 0 ?
>> +		0 : IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight;
>> +}
>=20
> Please consider using max() or max_t() to make this function less =
verbose.
>=20
>> +
>> +/**
>> + * bfq_active_extract - remove an entity from the active tree.
>> + * @st: the service_tree containing the tree.
>> + * @entity: the entity being removed.
>> + */
>> +static void bfq_active_extract(struct bfq_service_tree *st,
>> +			       struct bfq_entity *entity)
>> +{
>> +	struct bfq_queue *bfqq =3D bfq_entity_to_bfqq(entity);
>> +	struct rb_node *node;
>> +
>> +	node =3D bfq_find_deepest(&entity->rb_node);
>> +	bfq_extract(&st->active, entity);
>> +
>> +	if (node)
>> +		bfq_update_active_tree(node);
>> +
>> +	if (bfqq)
>> +		list_del(&bfqq->bfqq_list);
>> +}
>=20
> Which locks protect the data structures manipulated by this and other
> functions? Have you considered to use lockdep_assert_held() to =
document
> these assumptions?
>=20
>> +	case (BFQ_RQ1_WRAP|BFQ_RQ2_WRAP): /* both rqs wrapped */
>=20
> Please don't use parentheses if no confusion is possible. =
Additionally,
> checkpatch should have requested you to insert a space before and =
after
> the logical or operator.
>=20
>> +static void __bfq_set_in_service_queue(struct bfq_data *bfqd,
>> +				       struct bfq_queue *bfqq)
>> +{
>> +	if (bfqq) {
>> +		bfq_mark_bfqq_budget_new(bfqq);
>> +		bfq_clear_bfqq_fifo_expire(bfqq);
>> +
>> +		bfqd->budgets_assigned =3D (bfqd->budgets_assigned*7 + =
256) / 8;
>=20
> Checkpatch should have asked you to insert spaces around the
> multiplication operator.
>=20
>> +/*
>> + * bfq_default_budget - return the default budget for @bfqq on =
@bfqd.
>> + * @bfqd: the device descriptor.
>> + * @bfqq: the queue to consider.
>> + *
>> + * We use 3/4 of the @bfqd maximum budget as the default value
>> + * for the max_budget field of the queues.  This lets the feedback
>> + * mechanism to start from some middle ground, then the behavior
>> + * of the process will drive the heuristics towards high values, if
>> + * it behaves as a greedy sequential reader, or towards small values
>> + * if it shows a more intermittent behavior.
>> + */
>> +static unsigned long bfq_default_budget(struct bfq_data *bfqd,
>> +					struct bfq_queue *bfqq)
>> +{
>> +	unsigned long budget;
>> +
>> +	/*
>> +	 * When we need an estimate of the peak rate we need to avoid
>> +	 * to give budgets that are too short due to previous =
measurements.
>> +	 * So, in the first 10 assignments use a ``safe'' budget value.
>> +	 */
>> +	if (bfqd->budgets_assigned < 194 && bfqd->bfq_user_max_budget =3D=3D=
 0)
>> +		budget =3D bfq_default_max_budget;
>> +	else
>> +		budget =3D bfqd->bfq_max_budget;
>> +
>> +	return budget - budget / 4;
>> +}
>=20
> Where does the magic constant "194" come from?
>=20
>=20
>> +	} else
>> +		/*
>> +		 * Async queues get always the maximum possible
>> +		 * budget, as for them we do not care about latency
>> +		 * (in addition, their ability to dispatch is limited
>> +		 * by the charging factor).
>> +		 */
>> +		budget =3D bfqd->bfq_max_budget;
>> +
>=20
> Please balance braces. Checkpatch should have warned about the use of =
"}
> else" instead of "} else {".
>=20
>> +static unsigned long bfq_calc_max_budget(u64 peak_rate, u64 timeout)
>> +{
>> +	unsigned long max_budget;
>> +
>> +	/*
>> +	 * The max_budget calculated when autotuning is equal to the
>> +	 * amount of sectors transferred in timeout at the
>> +	 * estimated peak rate.
>> +	 */
>> +	max_budget =3D (unsigned long)(peak_rate * 1000 *
>> +				     timeout >> BFQ_RATE_SHIFT);
>> +
>> +	return max_budget;
>> +}
>=20
> Where does the constant 1000 come from? What are the units of =
peak_rate
> and timeout? What is the maximum value of peak_rate? Can the
> multiplication overflow?
>=20
>> +/*
>> + * In addition to updating the peak rate, checks whether the process
>> + * is "slow", and returns 1 if so. This slow flag is used, in =
addition
>> + * to the budget timeout, to reduce the amount of service provided =
to
>> + * seeky processes, and hence reduce their chances to lower the
>> + * throughput. See the code for more details.
>> + */
>> +static bool bfq_update_peak_rate(struct bfq_data *bfqd, struct =
bfq_queue *bfqq,
>> +				 bool compensate)
>> +{
>> +	u64 bw, usecs, expected, timeout;
>> +	ktime_t delta;
>> +	int update =3D 0;
>> +
>> +	if (!bfq_bfqq_sync(bfqq) || bfq_bfqq_budget_new(bfqq))
>> +		return false;
>> +
>> +	if (compensate)
>> +		delta =3D bfqd->last_idling_start;
>> +	else
>> +		delta =3D ktime_get();
>> +	delta =3D ktime_sub(delta, bfqd->last_budget_start);
>> +	usecs =3D ktime_to_us(delta);
>> +
>> +	/* Don't trust short/unrealistic values. */
>> +	if (usecs < 100 || usecs >=3D LONG_MAX)
>> +		return false;
>=20
> If usecs >=3D LONG_MAX that indicates a kernel bug. Please consider
> triggering a kernel warning in that case.
>=20
>> +/*
>> + * Budget timeout is not implemented through a dedicated timer, but
>> + * just checked on request arrivals and completions, as well as on
>> + * idle timer expirations.
>> + */
>> +static bool bfq_bfqq_budget_timeout(struct bfq_queue *bfqq)
>> +{
>> +	if (bfq_bfqq_budget_new(bfqq) ||
>> +	    time_before(jiffies, bfqq->budget_timeout))
>> +		return false;
>> +	return true;
>> +}
>=20
> Have you considered to use time_is_after_jiffies() instead of
> time_before(jiffies, ...)?
>=20
>> +static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue =
*bfqq,
>> +			  struct bfq_io_cq *bic, pid_t pid, int is_sync)
>> +{
>> +	RB_CLEAR_NODE(&bfqq->entity.rb_node);
>> +	INIT_LIST_HEAD(&bfqq->fifo);
>> +
>> +	bfqq->ref =3D 0;
>> +	bfqq->bfqd =3D bfqd;
>> +
>> +	if (bic)
>> +		bfq_set_next_ioprio_data(bfqq, bic);
>> +
>> +	if (is_sync) {
>> +		if (!bfq_class_idle(bfqq))
>> +			bfq_mark_bfqq_idle_window(bfqq);
>> +		bfq_mark_bfqq_sync(bfqq);
>> +	} else
>> +		bfq_clear_bfqq_sync(bfqq);
>> +
>> +	bfqq->ttime.last_end_request =3D ktime_get_ns() - (1ULL<<32);
>> +
>> +	bfq_mark_bfqq_IO_bound(bfqq);
>> +
>> +	bfqq->pid =3D pid;
>> +
>> +	/* Tentative initial value to trade off between thr and lat */
>> +	bfqq->max_budget =3D bfq_default_budget(bfqd, bfqq);
>> +	bfqq->budget_timeout =3D bfq_smallest_from_now();
>> +	bfqq->pid =3D pid;
>> +
>> +	/* first request is almost certainly seeky */
>> +	bfqq->seek_history =3D 1;
>> +}
>=20
> What is the meaning of the 1ULL << 32 constant?
>=20
>> +static int __init bfq_init(void)
>> +{
>> +	int ret;
>> +	char msg[50] =3D "BFQ I/O-scheduler: v0";
>=20
> Please leave out "[50]" and use "static const char" instead of "char".
>=20
>> diff --git a/block/elevator.c b/block/elevator.c
>> index 01139f5..786fdcd 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -221,14 +221,20 @@ int elevator_init(struct request_queue *q, char =
*name)
>>=20
>> 	if (!e) {
>> 		/*
>> -		 * For blk-mq devices, we default to using mq-deadline,
>> -		 * if available, for single queue devices. If deadline
>> -		 * isn't available OR we have multiple queues, default
>> -		 * to "none".
>> +		 * For blk-mq devices, we default to using bfq, if
>> +		 * available, for single queue devices. If bfq isn't
>> +		 * available, we try mq-deadline. If neither is
>> +		 * available, OR we have multiple queues, default to
>> +		 * "none".
>> 		 */
>> 		if (q->mq_ops) {
>> +			if (q->nr_hw_queues =3D=3D 1) {
>> +				e =3D elevator_get("bfq", false);
>> +				if (!e)
>> +					e =3D =
elevator_get("mq-deadline", false);
>> +			}
>> 			if (q->nr_hw_queues =3D=3D 1)
>> -				e =3D elevator_get("mq-deadline", =
false);
>> +				e =3D elevator_get("bfq", false);
>> 			if (!e)
>> 				return 0;
>> 		} else
>>=20
>=20
> As Jens wrote, it's way too early to make BFQ the default scheduler.
>=20
> Bart.
