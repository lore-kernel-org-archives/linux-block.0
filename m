Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 01/14] block, bfq: introduce the BFQ-v0 I/O scheduler as an extra scheduler
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1D08B61A9CF0974AA09887BE32D889DA0DA145@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Date: Sat, 18 Mar 2017 08:08:12 -0400
Cc: Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>
Message-Id: <0B1F1CFD-C8AB-442D-B5C6-426D19B1FBA3@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <20170304160131.57366-2-paolo.valente@linaro.org> <1D08B61A9CF0974AA09887BE32D889DA0DA145@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 06 mar 2017, alle ore 14:40, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On 03/04/2017 08:01 AM, Paolo Valente wrote:
>> BFQ is a proportional-share I/O scheduler, whose general structure,
>> plus a lot of code, are borrowed from CFQ.
>> [ ... ]
>=20

Hi Bart,
I'll reply below only to the recommendations for which I have some
doubt/confusion, while I'll just apply all the others.

> This description is very useful. However, since it is identical to the
> description this patch adds to Documentation/block/bfq-iosched.txt I
> propose to leave it out from the patch description.
>=20

Actually I repeated this information just because avoidable
indirections are usually annoying for relatively small amount of
information of immediate interest.  I mean, isn't it annoying, for who
reads the log, to have to look for a documentation file, instead of
having all information ready?  Of course, you are the reader in this
case, so if you believe it is better to remove this information, I'll
just do it.

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

Here you are certainly referring to the tuning/debugging knobs that I
forgot to remove.  As for the other parameters, they are the same
long-standing parameters of cfq, plus one called strict_guarantees.
You set the latter if you do care only about latency and fairness, =
despite
any throughput loss.

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

Thanks for highlighting this interesting point.  The logical position
of the last request served is used only to boost throughput.  It has
worked with all the single-queue devices I have tested so far, for
evident locality.  I've never used BFQ with a multi-queue device, so
honestly I don't know how this would perform with such devices.  I
will check it when/if we'll consider BFQ for multi-queue devices too.
However, with those devices I expect many other important issues too.

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

Yes.  We wrapped them into functions, because writing mark_flag_name
seemed more readable than writing the implementation of the marking of =
the
flag.

>> +/* Maximum backwards seek, in KiB. */
>> +static const int bfq_back_max =3D 16 * 1024;
>=20
> Where does this constant come from? Should it depend on geometry data
> like e.g. the number of sectors in a cylinder?
>=20

Yes.  These constants are just taken from long-standing
(non-documented, if this is your main, right concern) code.  All I can
say is that, according to all tests done so far, they work, that is,
BFQ achieves peak throughput where these constants are concerned.

>> +#define for_each_entity(entity)	\
>> +	for (; entity ; entity =3D NULL)
>=20
> Why has this confusing #define been introduced? Shouldn't all
> occurrences of this macro be changed into the equivalent "if =
(entity)"?
> We don't want silly macros like this in the Linux kernel.
>=20

This sort of empty variant of the macro is for the case where
CONFIG_BFQ_GROUP_IOSCHED is not defined.  In that case, the loop does
perform just one iteration.  I will add a comment to make this clearer.

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

Same as above. I'll add a comment on that.

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

It's the scheduler lock.  Actually, probably 99% of the functions are
protected by that lock. I imagine that adding lockdep_assert_held()
everywhere would be absurd.  Is there a particular reason why you
would expect it used in some specific functions?

>> +	case (BFQ_RQ1_WRAP|BFQ_RQ2_WRAP): /* both rqs wrapped */
>=20
> Please don't use parentheses if no confusion is possible. =
Additionally,
> checkpatch should have requested you to insert a space before and =
after
> the logical or operator.
>=20

No complain from checkpatch actually, and also in this case
long-standing code, copied verbatim from CFQ.  I'll remove the
parentheses.

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

It has not, we've used no space for the multiplication, to make the
order of operations clearer.  I'll add that space.

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

No warning, I guess because the body of the else contains only a
simple instruction.  Just to learn for the future: what's the
rationale for adding braces here, but not imposing braces everywhere
for single-instruction bodies?

>=20
>> +static int __init bfq_init(void)
>> +{
>> +	int ret;
>> +	char msg[50] =3D "BFQ I/O-scheduler: v0";
>=20
> Please leave out "[50]" and use "static const char" instead of "char".
>=20

msg is not constant, and is larger that the string literal used to
initialize it, because another piece is appended to msg if cgroups
support is enabled.  Any better solution is of course welcome.

Thanks again for your thorough review,
Paolo=
