Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE934A78E
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 06:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844135; cv=none; b=itjz+JINhI3HQ+4X/FMkWCeuzEfTa7kpgivjnL+5pcIU95Z28jN5tZpPS2ot6BiBIpoZD/tRA//3CDvb2eQDzH2SsSXrzgKn3pTaCBEVeVWLy07BvejYX+I3PaMRYGsJ7QXOwSWpJjsbHR7ZO/COXxXqUZlKyWLhFcvoAAX5Hw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844135; c=relaxed/simple;
	bh=xauQNEksn+E18gtj10nmc1NmlofFOtfoloHsXkkrZYQ=;
	h=From:In-Reply-To:Mime-Version:References:Content-Type:To:Subject:
	 Message-Id:Cc:Date; b=p8eOrdoTFIdeEttpp/YE55pdK6bTLUsN96SzKJXyovwrDnt6yXysWmPpeQjmJF2frivwRpv9+s3KWT4wgEgIeOP+mawb8uGHq0aafFylRtwKc7GECWvm0tCZKS3EAeH6MIbfze151DpMx3le5/Z7osJjN7GQCbcJlFls6M+CC9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=Oe75B/fu; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="Oe75B/fu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762844116;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=uDc5GFGbB5ynMw+epoylzAiOIVJKwWBR97KH7FiOUlU=;
 b=Oe75B/fuSDcAsIEIxJpzM1ljQlvSKsDERsZQbMqkIbKQ88MCyxcnx7cu5JsBoY2SGpzxBt
 0YmEFOgeD9yldqZUUx7K8JHy2LrOUBn6erynre0SGztd+OD8a3GvUnI9ioc5LtEhTscK2v
 YZnr5n5Z04bcFtN5FUswo5dv8FyQ85CoCkSnKH+ZQjrA7SeSXhPNtuYtb4pme55Cr9OFhw
 aH7UwCCJLms/3ohXplvszGEYgH86DHzOoGWroB1SFy/c6ymWLCZMzKVcDWCqGcbfHGCiv4
 QNqv9XV3XoptxKm0f7TWrtRPeCH4mZxMEVojKonLs0LC7ILOXmedkVgsniy68Q==
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 14:55:13 +0800
From: "Yu Kuai" <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26912ddd2+21e247+vger.kernel.org+yukuai@fnnas.com>
In-Reply-To: <20251110081457.1006206-2-nilay@linux.ibm.com>
Reply-To: yukuai@fnnas.com
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110081457.1006206-1-nilay@linux.ibm.com> <20251110081457.1006206-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>
Subject: Re: [PATCHv4 1/5] block: unify elevator tags and type xarrays into struct elv_change_ctx
Message-Id: <c02eddd8-1776-4d1b-b5ef-c99a5fedc996@fnnas.com>
Cc: <ming.lei@redhat.com>, <hch@lst.de>, <axboe@kernel.dk>, 
	<yi.zhang@redhat.com>, <czhong@redhat.com>, <gjoyce@ibm.com>, 
	<yukuai@fnnas.com>
Date: Tue, 11 Nov 2025 14:55:11 +0800

Hi,

=E5=9C=A8 2025/11/10 16:14, Nilay Shroff =E5=86=99=E9=81=93:
> Currently, the nr_hw_queues update path manages two disjoint xarrays =E2=
=80=94
> one for elevator tags and another for elevator type =E2=80=94 both used d=
uring
> elevator switching. Maintaining these two parallel structures for the
> same purpose adds unnecessary complexity and potential for mismatched
> state.
>
> This patch unifies both xarrays into a single structure, struct
> elv_change_ctx, which holds all per-queue elevator change context. A
> single xarray, named elv_tbl, now maps each queue (q->id) in a tagset
> to its corresponding elv_change_ctx entry, encapsulating the elevator
> tags, type and name references.
>
> This unification simplifies the code, improves maintainability, and
> clarifies ownership of per-queue elevator state.
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-mq-sched.c | 76 +++++++++++++++++++++++++++++++++-----------
>   block/blk-mq-sched.h |  3 ++
>   block/blk-mq.c       | 50 +++++++++++++++++------------
>   block/blk.h          |  7 ++--
>   block/elevator.c     | 31 ++++--------------
>   block/elevator.h     | 15 +++++++++
>   6 files changed, 115 insertions(+), 67 deletions(-)
>
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index e0bed16485c3..3d9386555a50 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -427,11 +427,11 @@ void blk_mq_free_sched_tags(struct elevator_tags *e=
t,
>   	kfree(et);
>   }
>  =20
> -void blk_mq_free_sched_tags_batch(struct xarray *et_table,
> +void blk_mq_free_sched_tags_batch(struct xarray *elv_tbl,
>   		struct blk_mq_tag_set *set)
>   {
>   	struct request_queue *q;
> -	struct elevator_tags *et;
> +	struct elv_change_ctx *ctx;
>  =20
>   	lockdep_assert_held_write(&set->update_nr_hwq_lock);
>  =20
> @@ -444,13 +444,47 @@ void blk_mq_free_sched_tags_batch(struct xarray *et=
_table,
>   		 * concurrently.
>   		 */
>   		if (q->elevator) {
> -			et =3D xa_load(et_table, q->id);
> -			if (unlikely(!et))
> +			ctx =3D xa_load(elv_tbl, q->id);
> +			if (!ctx || !ctx->et) {
>   				WARN_ON_ONCE(1);
> -			else
> -				blk_mq_free_sched_tags(et, set);
> +				continue;
> +			}
> +			blk_mq_free_sched_tags(ctx->et, set);
> +			ctx->et =3D NULL;
> +		}
> +	}
> +}
> +
> +void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl)
> +{
> +	unsigned long i;
> +	struct elv_change_ctx *ctx;
> +
> +	xa_for_each(elv_tbl, i, ctx) {
> +		xa_erase(elv_tbl, i);
> +		kfree(ctx);
> +	}
> +}
> +
> +int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
> +		struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +	struct elv_change_ctx *ctx;
> +
> +	lockdep_assert_held_write(&set->update_nr_hwq_lock);
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		ctx =3D kzalloc(sizeof(struct elv_change_ctx), GFP_KERNEL);
> +		if (!ctx)
> +			return -ENOMEM;
> +
> +		if (xa_insert(elv_tbl, q->id, ctx, GFP_KERNEL)) {
> +			kfree(ctx);
> +			return -ENOMEM;
>   		}
>   	}
> +	return 0;
>   }
>  =20
>   struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *se=
t,
> @@ -498,12 +532,13 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struc=
t blk_mq_tag_set *set,
>   	return NULL;
>   }
>  =20
> -int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
> +int blk_mq_alloc_sched_tags_batch(struct xarray *elv_tbl,
>   		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
>   {
> +	struct elv_change_ctx *ctx;
>   	struct request_queue *q;
>   	struct elevator_tags *et;
> -	gfp_t gfp =3D GFP_NOIO | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
> +	int ret =3D -ENOMEM;
>  =20
>   	lockdep_assert_held_write(&set->update_nr_hwq_lock);
>  =20
> @@ -516,26 +551,31 @@ int blk_mq_alloc_sched_tags_batch(struct xarray *et=
_table,
>   		 * concurrently.
>   		 */
>   		if (q->elevator) {
> -			et =3D blk_mq_alloc_sched_tags(set, nr_hw_queues,
> +			ctx =3D xa_load(elv_tbl, q->id);
> +			if (WARN_ON_ONCE(!ctx)) {
> +				ret =3D -ENOENT;
> +				goto out_unwind;
> +			}
> +
> +			ctx->et =3D blk_mq_alloc_sched_tags(set, nr_hw_queues,
>   					blk_mq_default_nr_requests(set));
> -			if (!et)
> +			if (!ctx->et)
>   				goto out_unwind;
> -			if (xa_insert(et_table, q->id, et, gfp))
> -				goto out_free_tags;
> +
>   		}
>   	}
>   	return 0;
> -out_free_tags:
> -	blk_mq_free_sched_tags(et, set);
>   out_unwind:
>   	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) =
{
>   		if (q->elevator) {
> -			et =3D xa_load(et_table, q->id);
> -			if (et)
> -				blk_mq_free_sched_tags(et, set);
> +			ctx =3D xa_load(elv_tbl, q->id);
> +			if (ctx && ctx->et) {
> +				blk_mq_free_sched_tags(ctx->et, set);
> +				ctx->et =3D NULL;
> +			}
>   		}
>   	}
> -	return -ENOMEM;
> +	return ret;
>   }
>  =20
>   /* caller must have a reference to @e, will grab another one if success=
ful */
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 8e21a6b1415d..2fddbc91a235 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -27,6 +27,9 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct bl=
k_mq_tag_set *set,
>   		unsigned int nr_hw_queues, unsigned int nr_requests);
>   int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
>   		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
> +int blk_mq_alloc_sched_ctx_batch(struct xarray *elv_tbl,
> +		struct blk_mq_tag_set *set);
> +void blk_mq_free_sched_ctx_batch(struct xarray *elv_tbl);
>   void blk_mq_free_sched_tags(struct elevator_tags *et,
>   		struct blk_mq_tag_set *set);
>   void blk_mq_free_sched_tags_batch(struct xarray *et_table,
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d626d32f6e57..1f5ef7fc9cda 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4983,27 +4983,28 @@ struct elevator_tags *blk_mq_update_nr_requests(s=
truct request_queue *q,
>    * Switch back to the elevator type stored in the xarray.
>    */
>   static void blk_mq_elv_switch_back(struct request_queue *q,
> -		struct xarray *elv_tbl, struct xarray *et_tbl)
> +		struct xarray *elv_tbl)
>   {
> -	struct elevator_type *e =3D xa_load(elv_tbl, q->id);
> -	struct elevator_tags *t =3D xa_load(et_tbl, q->id);
> +	struct elv_change_ctx *ctx =3D xa_load(elv_tbl, q->id);
> +
> +	if (WARN_ON_ONCE(!ctx))
> +		return;
>  =20
>   	/* The elv_update_nr_hw_queues unfreezes the queue. */
> -	elv_update_nr_hw_queues(q, e, t);
> +	elv_update_nr_hw_queues(q, ctx);
>  =20
>   	/* Drop the reference acquired in blk_mq_elv_switch_none. */
> -	if (e)
> -		elevator_put(e);
> +	if (ctx->type)
> +		elevator_put(ctx->type);
>   }
>  =20
>   /*
> - * Stores elevator type in xarray and set current elevator to none. It u=
ses
> - * q->id as an index to store the elevator type into the xarray.
> + * Stores elevator name and type in ctx and set current elevator to none=
.
>    */
>   static int blk_mq_elv_switch_none(struct request_queue *q,
>   		struct xarray *elv_tbl)
>   {
> -	int ret =3D 0;
> +	struct elv_change_ctx *ctx;
>  =20
>   	lockdep_assert_held_write(&q->tag_set->update_nr_hwq_lock);
>  =20
> @@ -5015,10 +5016,11 @@ static int blk_mq_elv_switch_none(struct request_=
queue *q,
>   	 * can't run concurrently.
>   	 */
>   	if (q->elevator) {
> +		ctx =3D xa_load(elv_tbl, q->id);
> +		if (WARN_ON_ONCE(!ctx))
> +			return -ENOENT;
>  =20
> -		ret =3D xa_insert(elv_tbl, q->id, q->elevator->type, GFP_KERNEL);
> -		if (WARN_ON_ONCE(ret))
> -			return ret;
> +		ctx->name =3D q->elevator->type->elevator_name;
>  =20
>   		/*
>   		 * Before we switch elevator to 'none', take a reference to
> @@ -5029,9 +5031,14 @@ static int blk_mq_elv_switch_none(struct request_q=
ueue *q,
>   		 */
>   		__elevator_get(q->elevator->type);
>  =20
> +		/*
> +		 * Store elevator type so that we can release the reference
> +		 * taken above later.
> +		 */
> +		ctx->type =3D q->elevator->type;
>   		elevator_set_none(q);
>   	}
> -	return ret;
> +	return 0;
>   }
>  =20
>   static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> @@ -5041,7 +5048,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk=
_mq_tag_set *set,
>   	int prev_nr_hw_queues =3D set->nr_hw_queues;
>   	unsigned int memflags;
>   	int i;
> -	struct xarray elv_tbl, et_tbl;
> +	struct xarray elv_tbl;
>   	bool queues_frozen =3D false;
>  =20
>   	lockdep_assert_held(&set->tag_list_lock);
> @@ -5055,11 +5062,12 @@ static void __blk_mq_update_nr_hw_queues(struct b=
lk_mq_tag_set *set,
>  =20
>   	memflags =3D memalloc_noio_save();
>  =20
> -	xa_init(&et_tbl);
> -	if (blk_mq_alloc_sched_tags_batch(&et_tbl, set, nr_hw_queues) < 0)
> -		goto out_memalloc_restore;
> -
>   	xa_init(&elv_tbl);
> +	if (blk_mq_alloc_sched_ctx_batch(&elv_tbl, set) < 0)
> +		goto out_free_ctx;
> +
> +	if (blk_mq_alloc_sched_tags_batch(&elv_tbl, set, nr_hw_queues) < 0)
> +		goto out_free_ctx;

I fell it's not necessary to separate two helpers above, just fold
blk_mq_alloc_sched_tags_batch() into blk_mq_alloc_sched_ctx_batch(),
since blk_mq_alloc_sched_tags_batch() is never called separately in
following patches.

Others this patch LGTM.

Thanks,
Kuai

>  =20
>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>   		blk_mq_debugfs_unregister_hctxs(q);
> @@ -5105,7 +5113,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk=
_mq_tag_set *set,
>   		/* switch_back expects queue to be frozen */
>   		if (!queues_frozen)
>   			blk_mq_freeze_queue_nomemsave(q);
> -		blk_mq_elv_switch_back(q, &elv_tbl, &et_tbl);
> +		blk_mq_elv_switch_back(q, &elv_tbl);
>   	}
>  =20
>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> @@ -5116,9 +5124,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk=
_mq_tag_set *set,
>   		blk_mq_add_hw_queues_cpuhp(q);
>   	}
>  =20
> +out_free_ctx:
> +	blk_mq_free_sched_ctx_batch(&elv_tbl);
>   	xa_destroy(&elv_tbl);
> -	xa_destroy(&et_tbl);
> -out_memalloc_restore:
>   	memalloc_noio_restore(memflags);
>  =20
>   	/* Free the excess tags when nr_hw_queues shrink. */
> diff --git a/block/blk.h b/block/blk.h
> index 170794632135..a7992680f9e1 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -11,8 +11,7 @@
>   #include <xen/xen.h>
>   #include "blk-crypto-internal.h"
>  =20
> -struct elevator_type;
> -struct elevator_tags;
> +struct elv_change_ctx;
>  =20
>   /*
>    * Default upper limit for the software max_sectors limit used for regu=
lar I/Os.
> @@ -333,8 +332,8 @@ bool blk_bio_list_merge(struct request_queue *q, stru=
ct list_head *list,
>  =20
>   bool blk_insert_flush(struct request *rq);
>  =20
> -void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_ty=
pe *e,
> -		struct elevator_tags *t);
> +void elv_update_nr_hw_queues(struct request_queue *q,
> +		struct elv_change_ctx *ctx);
>   void elevator_set_default(struct request_queue *q);
>   void elevator_set_none(struct request_queue *q);
>  =20
> diff --git a/block/elevator.c b/block/elevator.c
> index e2ebfbf107b3..cd7bdff205c8 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -45,19 +45,6 @@
>   #include "blk-wbt.h"
>   #include "blk-cgroup.h"
>  =20
> -/* Holding context data for changing elevator */
> -struct elv_change_ctx {
> -	const char *name;
> -	bool no_uevent;
> -
> -	/* for unregistering old elevator */
> -	struct elevator_queue *old;
> -	/* for registering new elevator */
> -	struct elevator_queue *new;
> -	/* holds sched tags data */
> -	struct elevator_tags *et;
> -};
> -
>   static DEFINE_SPINLOCK(elv_list_lock);
>   static LIST_HEAD(elv_list);
>  =20
> @@ -706,32 +693,28 @@ static int elevator_change(struct request_queue *q,=
 struct elv_change_ctx *ctx)
>    * The I/O scheduler depends on the number of hardware queues, this for=
ces a
>    * reattachment when nr_hw_queues changes.
>    */
> -void elv_update_nr_hw_queues(struct request_queue *q, struct elevator_ty=
pe *e,
> -		struct elevator_tags *t)
> +void elv_update_nr_hw_queues(struct request_queue *q,
> +		struct elv_change_ctx *ctx)
>   {
>   	struct blk_mq_tag_set *set =3D q->tag_set;
> -	struct elv_change_ctx ctx =3D {};
>   	int ret =3D -ENODEV;
>  =20
>   	WARN_ON_ONCE(q->mq_freeze_depth =3D=3D 0);
>  =20
> -	if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
> -		ctx.name =3D e->elevator_name;
> -		ctx.et =3D t;
> -
> +	if (ctx->type && !blk_queue_dying(q) && blk_queue_registered(q)) {
>   		mutex_lock(&q->elevator_lock);
>   		/* force to reattach elevator after nr_hw_queue is updated */
> -		ret =3D elevator_switch(q, &ctx);
> +		ret =3D elevator_switch(q, ctx);
>   		mutex_unlock(&q->elevator_lock);
>   	}
>   	blk_mq_unfreeze_queue_nomemrestore(q);
>   	if (!ret)
> -		WARN_ON_ONCE(elevator_change_done(q, &ctx));
> +		WARN_ON_ONCE(elevator_change_done(q, ctx));
>   	/*
>   	 * Free sched tags if it's allocated but we couldn't switch elevator.
>   	 */
> -	if (t && !ctx.new)
> -		blk_mq_free_sched_tags(t, set);
> +	if (ctx->et && !ctx->new)
> +		blk_mq_free_sched_tags(ctx->et, set);
>   }
>  =20
>   /*
> diff --git a/block/elevator.h b/block/elevator.h
> index c4d20155065e..bad43182361e 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -32,6 +32,21 @@ struct elevator_tags {
>   	struct blk_mq_tags *tags[];
>   };
>  =20
> +/* Holding context data for changing elevator */
> +struct elv_change_ctx {
> +	const char *name;
> +	bool no_uevent;
> +
> +	/* for unregistering old elevator */
> +	struct elevator_queue *old;
> +	/* for registering new elevator */
> +	struct elevator_queue *new;
> +	/* store elevator type */
> +	struct elevator_type *type;
> +	/* holds sched tags data */
> +	struct elevator_tags *et;
> +};
> +
>   struct elevator_mq_ops {
>   	int (*init_sched)(struct request_queue *, struct elevator_queue *);
>   	void (*exit_sched)(struct elevator_queue *);
