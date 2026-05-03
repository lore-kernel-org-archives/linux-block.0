Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A79382384;
	Sun,  3 May 2026 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777783505; cv=none; b=Z62IKuA5MocSRRwqYbVTCvXeRp8smuqzjIKHjg4Uu/GQ16CSsv1eZEd/ezctBVQ5Z13neYdr1p2/ewAGzk3yYivLZjMh1YEvfrBJ0FnsMYVsej5/ByuLU1aryMBej1x4tKQoywtwF5Smy5VWuN7xTODzsvKAnHhiaD2zckLYt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777783505; c=relaxed/simple;
	bh=8QD4Lwzvt8FNmmvFD0AeqMXq1xD7kBgIea+D6GZrNeU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jPAAZ6wX1RjY6fz7Qajyv/UCt0+UTjhBrhhlzyB6UGOK9UpJTXCuimldrZwCxlIg1oOVrUEvvxGzT9e9/dsX4LqnqQvvSfpMeZqLflsULTtZTS5C7mNZvt9vwdjLp7nD8X8bQiA/pgo2asf5ha+OZNUBTtZpwsPVMELgB6VlbOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tl7gFzts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl7gFzts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0274C2BCC4;
	Sun,  3 May 2026 04:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777783505;
	bh=8QD4Lwzvt8FNmmvFD0AeqMXq1xD7kBgIea+D6GZrNeU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tl7gFztst0qwOA+2BcsacRXN4ukmsrv/nQTeHYu2Whpifa2uAHzSJcogJdhQ5A4TG
	 6SbS6JusbHvi2pASSGYEycYgtpclXDRJn31h/DYiQvgEwHB8aAlcTqN/N08RBz9iRa
	 8H/yvGZmPe/d87d/2c1sBCtsj4f147DZobzi6Anjz1mkL3o+AQJsQA6d1iHdgBkwNS
	 59PJP+G/GxLg+rbNeTxGphThUCh/Cm7xYy7zhW2pOEV4tolgGb1gGHprIMREhqjall
	 98tDRmIH5ja137H6H4AbADWL4Vz1CXHmqFFy1kj6aCc/Q0GU80im+nvV9E9jjCWQiZ
	 TZSxM2S4mMTYg==
Content-Type: multipart/mixed; boundary="===============3913617580182485502=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <66924eebcf2a5bac23e4050d6a82a7ed75e89b935b9411d25789cfa575815577@mail.kernel.org>
In-Reply-To: <20260503035623.28771-3-kaitao.cheng@linux.dev>
References: <20260503035623.28771-3-kaitao.cheng@linux.dev>
Subject: Re: [RFC v2 2/3] block: Introduce the UFQ I/O scheduler
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,axboe@kernel.dk,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,linux-block@vger.kernel.org,linux-kernel@vger.kernel.org,chengkaitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  3 May 2026 04:45:02 +0000 (UTC)

--===============3913617580182485502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
> --- a/block/Kconfig.iosched
> +++ b/block/Kconfig.iosched
> @@ -44,4 +44,12 @@
>  	Enable some debugging help. Currently it exports additional stat
>  	files in a cgroup which can be useful for debugging.
>
> +config IOSCHED_UFQ
> +	tristate "UFQ I/O scheduler"
> +	default y
> +	help
> +	The UFQ I/O scheduler is a programmable I/O scheduler. When
> +	enabled, an out-of-kernel I/O scheduler based on eBPF can be
> +	designed to interact with it, leveraging its customizable
> +	hooks to redefine I/O scheduling policies.
>  endmenu
> diff --git a/block/Makefile b/block/Makefile
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -24,6 +24,7 @@
>  obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
>  bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
>  obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
> +obj-$(CONFIG_IOSCHED_UFQ)	+= ufq-iosched.o ufq-bpfops.o ufq-kfunc.o
>
>  obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o \
>  				   bio-integrity-fs.o
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -774,8 +774,8 @@
>   * For non-mq, this has to be called with the request spinlock acquired.
>   * For mq with scheduling, the appropriate queue wide lock should be held.
>   */
> -static struct request *attempt_merge(struct request_queue *q,
> -				     struct request *req, struct request *next)
> +static struct request *attempt_merge(struct request_queue *q, struct request *req,
> +				     struct request *next, bool nohash)
>  {
>  	if (!rq_mergeable(req) || !rq_mergeable(next))
>  		return NULL;
> @@ -842,7 +842,7 @@
>
>  	req->__data_len += blk_rq_bytes(next);
>
> -	if (!blk_discard_mergable(req))
> +	if (!nohash && !blk_discard_mergable(req))
>  		elv_merge_requests(q, req, next);
>
>  	blk_crypto_rq_put_keyslot(next);
> @@ -879,11 +879,17 @@
>  	struct request *prev = elv_former_request(q, rq);
>
>  	if (prev)
> -		return attempt_merge(q, prev, rq);
> +		return attempt_merge(q, prev, rq, false);
>
>  	return NULL;
>  }
>
> +struct request *bpf_attempt_merge(struct request_queue *q, struct request *rq,
> +				  struct request *next)
> +{
> +	return attempt_merge(q, rq, next, true);
> +}

CONFIG_IOSCHED_UFQ is a tristate option so the UFQ modules can be built
with CONFIG_IOSCHED_UFQ=m. However bpf_attempt_merge has no EXPORT_SYMBOL
or EXPORT_SYMBOL_GPL declaration. When built as a module,
ufq-iosched.ko calls this function in ufq_try_insert_merge and
ufq-kfunc.ko calls it in bpf_request_try_merge, causing a linker failure
("undefined reference to bpf_attempt_merge"). Should EXPORT_SYMBOL_GPL be
added here, or should CONFIG_IOSCHED_UFQ be changed to a bool?

>
>  /*
>   * Try to merge 'next' into 'rq'. Return true if the merge happened, false
> @@ -1035,11 +1041,11 @@
>  	return BIO_MERGE_FAILED;
>  }
>
> -static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
> -						   struct request *rq,
> -						   struct bio *bio,
> -						   unsigned int nr_segs,
> -						   bool sched_allow_merge)
> +enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
> +					    struct request *rq,
> +					    struct bio *bio,
> +					    unsigned int nr_segs,
> +					    bool sched_allow_merge)
>  {
>  	if (!blk_rq_merge_ok(rq, bio))
>  		return BIO_MERGE_NONE;

blk_attempt_bio_merge is changed from static to externally linked and is
called from ufq-iosched.c (ufq_bio_merge) and ufq-kfunc.c
(bpf_request_bio_try_merge). Since CONFIG_IOSCHED_UFQ is tristate, these
callers can be built as modules, but blk_attempt_bio_merge has no
EXPORT_SYMBOL or EXPORT_SYMBOL_GPL. When CONFIG_IOSCHED_UFQ=m, the
modules will fail to link with "undefined reference to
blk_attempt_bio_merge". Should EXPORT_SYMBOL_GPL be added, or should
CONFIG_IOSCHED_UFQ be restricted to bool?

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -796,7 +796,7 @@
>  	}
>  }
>
> -static void __blk_mq_free_request(struct request *rq)
> +void __blk_mq_free_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
>  	struct blk_mq_ctx *ctx = rq->mq_ctx;

__blk_mq_free_request is changed from static to externally linked and is
called from ufq-iosched.c (ufq_dispatch_request, ufq_try_insert_merge)
and ufq-kfunc.c (bpf_request_release). CONFIG_IOSCHED_UFQ is tristate so
these callers can be modules, but __blk_mq_free_request has no
EXPORT_SYMBOL declaration. With CONFIG_IOSCHED_UFQ=m the modules will
fail to link ("undefined reference to __blk_mq_free_request"). Should
EXPORT_SYMBOL_GPL be added here, or should CONFIG_IOSCHED_UFQ be
restricted to bool?

[ ... ]

> diff --git a/block/ufq-bpfops.c b/block/ufq-bpfops.c
> --- /dev/null
> +++ b/block/ufq-bpfops.c
> @@ -0,0 +1,241 @@

[ ... ]

> +static int bpf_ufq_enable(void *ops)
> +{
> +	ufq_ops = *(struct ufq_iosched_ops *)ops;
> +	atomic_set(&ufq_bpfops_enabled, 1);
> +	return 0;
> +}
> +
> +static void bpf_ufq_disable(struct ufq_iosched_ops *ops)
> +{
> +	atomic_set(&ufq_bpfops_enabled, 0);
> +	wait_event(ufq_bpfops_wq, !atomic_read(&ufq_bpfops_users));
> +	memset(&ufq_ops, 0, sizeof(ufq_ops));
> +}

Is a memory barrier needed between atomic_set(&ufq_bpfops_enabled, 0) and
the first atomic_read(&ufq_bpfops_users)?

Looking at ufq_bpfops_tryget:

  atomic_inc(&ufq_bpfops_users);
  smp_mb__after_atomic();
  if (unlikely(!atomic_read(&ufq_bpfops_enabled))) {
      if (atomic_dec_and_test(&ufq_bpfops_users))
          wake_up_all(&ufq_bpfops_wq);
      return NULL;
  }
  return &ufq_ops;

The inc/mb/read sequence on the reader side pairs with a store/mb/read
on the disable side. But bpf_ufq_disable only has:

  atomic_set(&ufq_bpfops_enabled, 0);
  wait_event(..., !atomic_read(&ufq_bpfops_users));

The wait_event macro expands to an immediate condition check before
acquiring the wait queue lock. Without a barrier between the store to
enabled and the first load of users, Store-Load reordering can allow the
disable path to observe users == 0 while a concurrent reader observes
enabled == 1 and returns &ufq_ops. This creates a window where the
disable path proceeds to memset(&ufq_ops, 0, ...) while a reader is
returning the pointer to a caller who will immediately dereference it,
resulting in a NULL function pointer dereference.

Should smp_mb__after_atomic() be added after the atomic_set in
bpf_ufq_disable?

> +static bool bpf_ufq_is_valid_access(int off, int size,
> +				    enum bpf_access_type type,
> +				    const struct bpf_prog *prog,
> +				    struct bpf_insn_access_aux *info)
> +{
> +	if (type != BPF_READ)
> +		return false;
> +	if (off < 0 || off >= sizeof(__u64) * MAX_BPF_FUNC_ARGS)
> +		return false;
> +	if (off % size != 0)
> +		return false;
> +
> +	/*
> +	 * btf_ctx_access() treats pointers that are not "pointer to struct"
> +	 * as scalars (no reg_type), so loading pointers like merge_req()'s
> +	 * int *type or merge_bio()'s bool *merged from ctx leaves a SCALAR
> +	 * and stores through them fail verification. Model both as writable
> +	 * buffers.
> +	 */
> +	if (size == sizeof(__u64) && prog->aux->attach_func_name &&
> +	    ((!strcmp(prog->aux->attach_func_name, "merge_req") && off == 16) ||
> +	     (!strcmp(prog->aux->attach_func_name, "merge_bio") && off == 24))) {
> +		if (!btf_ctx_access(off, size, type, prog, info))
> +			return false;
> +		info->reg_type = PTR_TO_BUF;
> +		return true;
> +	}

The merge_req and merge_bio ctx offsets at 16 and 24 are overridden to
PTR_TO_BUF so BPF programs can store through the int *type and bool
*merged pointers. However info->reg_type is set without populating any
size or range field (such as info->mem_size or a MEM_FIXED_SIZE marker).

The verifier's check_buffer_access only enforces off >= 0 and rejects
variable offsets; it does not clamp the access to any declared buffer
size. This allows a BPF program to compute ptr + K for large K and write
beyond the stack object.

The kernel callers pass real stack variables:

  ufq_try_insert_merge: &merge_type (4-byte int)
  ufq_bio_merge: &ret (1-byte bool)

A BPF program could issue *(type + 1024) = 0 which would be accepted by
the verifier (constant offset, non-negative, PTR_TO_BUF) but write to
stack memory beyond the local variable, corrupting saved registers or
frame pointers.

Other subsystems mark such buffers with PTR_TO_MEM | MEM_FIXED_SIZE and
set info->mem_size, or use kfuncs with explicit size arguments. Should a
declared size be added here, or should these be redesigned as kfunc
parameters?

[ ... ]

> diff --git a/block/ufq-iosched.c b/block/ufq-iosched.c
> --- /dev/null
> +++ b/block/ufq-iosched.c
> @@ -0,0 +1,640 @@

[ ... ]

> +static int ufq_init_sched(struct request_queue *q, struct elevator_queue *eq)
> +{
> +	const struct ufq_iosched_ops *ops;
> +	struct ufq_data *ufq;
> +
> +	ufq = kzalloc_node(sizeof(*ufq), GFP_KERNEL, q->node);
> +	if (!ufq)
> +		return -ENOMEM;
> +
> +	eq->elevator_data = ufq;
> +	ufq->q = q;
> +	INIT_LIST_HEAD(&ufq->active_node);
> +
> +	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
> +	q->elevator = eq;
> +
> +	q->async_depth = q->nr_requests;
> +	ufq->async_depth = q->nr_requests;
> +
> +	ops = ufq_bpfops_tryget();
> +	if (ops) {
> +		if (ops->init_sched)
> +			ops->init_sched(q);
> +		ufq_bpfops_put();
> +	}

The ops->init_sched(q) call here discards the return value. The
ufq_iosched_ops struct defines init_sched with signature 'int
(*init_sched)(struct request_queue *q)', intending it to signal errors.

If a BPF init_sched returns an error (for example -ENOMEM from a failed
per-queue allocation), ufq_init_sched continues, returns 0, and registers
the queue on ufq_active_queues with the BPF program in an inconsistent
state. The BPF program believes initialization failed while the kernel
believes the queue is active. Later ops->insert_req / ops->dispatch_req
calls will run against uninitialized BPF state.

Other block elevators (blk-mq-sched.c, blk_mq_init_sched) check the
return value and roll back on error (teardown tags, free structures,
clear q->elevator). Should the return value be checked here and the error
propagated?

[ ... ]

> diff --git a/block/ufq-kfunc.c b/block/ufq-kfunc.c
> --- /dev/null
> +++ b/block/ufq-kfunc.c
> @@ -0,0 +1,131 @@

[ ... ]

> +__bpf_kfunc struct request *bpf_request_try_merge(struct request *rq, struct request *next)
> +{
> +	struct blk_mq_ctx *ctx;
> +	struct ufq_data *ufq;
> +	struct request *free;
> +
> +	if (!rq || !next || !rq->q || rq->q != next->q)
> +		return NULL;
> +
> +	ufq = rq->q->elevator->elevator_data;
> +	if (!ufq)
> +		return NULL;
> +
> +	if (rq->mq_ctx != next->mq_ctx || rq->mq_hctx != next->mq_hctx)
> +		return NULL;
> +
> +	ctx = rq->mq_ctx;
> +	if (!ctx)
> +		return NULL;
> +
> +	spin_lock(&ctx->lock);
> +	free = bpf_attempt_merge(rq->q, rq, next);
> +	if (free) {
> +		if (rq->q->last_merge == free)
> +			rq->q->last_merge = NULL;
> +		list_del_init(&free->queuelist);
> +		atomic_dec(&ufq->rqs_count);
> +	}
> +	spin_unlock(&ctx->lock);
> +
> +	return free;
> +}

[ ... ]

> +BTF_KFUNCS_START(ufq_kfunc_set_ops)
> +BTF_ID_FLAGS(func, bpf_request_acquire, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_request_release, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_request_bio_try_merge, KF_SPIN_LOCK)
> +BTF_ID_FLAGS(func, bpf_request_try_merge, KF_SPIN_LOCK)
> +BTF_KFUNCS_END(ufq_kfunc_set_ops)

bpf_request_try_merge returns 'struct request *' and has multiple NULL
return paths (!rq, !next, !ufq, mq_ctx/mq_hctx mismatch, !ctx, merge
failure). The kfunc is annotated with KF_SPIN_LOCK but lacks KF_RET_NULL.

Without KF_RET_NULL the verifier treats the return value as a non-NULL
pointer and allows BPF programs to dereference it unconditionally. When
the kfunc returns NULL at runtime, the BPF program dereferences NULL and
causes a kernel crash.

bpf_request_acquire is correctly annotated with 'KF_ACQUIRE |
KF_RET_NULL'. Should bpf_request_try_merge also have KF_RET_NULL (or
'KF_SPIN_LOCK | KF_ACQUIRE | KF_RET_NULL')?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25269522212
--===============3913617580182485502==--
