Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399828;
	b=xSytSVuKn8iMCwXUyM3Qg+DZC1Zsxoc733Uy4nfAfCwDKL8LGcd0kofWqfBhDh8GAGr/
	 ItGg6dVvR0Z54QMlbWAm1bfjl14MUvj8Y8+Gy0cKa8WicdoEbzEaQ0CgymVepVrM4k5fw
	 fkekL5lHu5kIzXIvJ8xj8RgSvGdJcOBkwW8gEqoAIuFi2jYWmOdVt4ucn/eQKxrr9UiCP
	 PkduxaSufJ3tRTIy9Cg+JMc2kmITZ8mboXXSNQlS7R02YtubFPo6ebRKMcO07ofaoBfV6
	 8TXlhdM7cK83kYlGl6Rq9qNn+Qfuj6IZnfinIgDG3ITB6bGhkHvn38/2Gk7pM6FIPEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399828;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RkoYuIpO5ZyNXzjyfSBwMyetr5alXERaPYaFe+X3yZs=;
	b=xiTtYdRj4cCsYsmqrYtSjuuWm1LDwh0p05hywmQv43jbL9inhbW8oAlrr89HD4HJGnfW
	 iLm5Rb6igNwHhoZ4NL+Ux3EArHuC85VPPr0jlMvHTTxUSytUEQ5Wz8DL6rA0SCCjSnxwj
	 3DGHtj3tlXEu9Da3A/KlAOo+qT4/QWpkDQQ9bW61pMvwllayNR9IZc/9prhSxSWAV4zjT
	 SWApgPchZ7KcmvpSlb7/NszLu8e6bDWHJpE0rGUPtdfq7+06tqICJ+qKO9Ye/Gilt1RYG
	 I2jCrdjeZA0hlerjDHX/YdDk2XLeV94+Ri+1a5Zfx9ZFevq+A4rIyFR+aG5zgXt8XTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H427OIZe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6DB606A32A;
	Fri, 30 Oct 2026 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H427OIZe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1171F00A25;
	Fri, 30 Oct 2026 22:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793399827;
	bh=RkoYuIpO5ZyNXzjyfSBwMyetr5alXERaPYaFe+X3yZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H427OIZeJwhZTrU4SfeqfFv8tCK6FRRFbogROiDXifnMPtQ4GvDgzKOsYUhMb8Ydy
	 p6VZpmiTJ+IBAjDZyJe0YcHMB4bLiKhCmzbLQT+fmcY9748PFEKv8x4+57dPDaFlf2
	 Ap5f9jEp+V8eZb/nnNwkdeUat9X5sMP1a3T3K8dDog67cHqVICouBjj2KzcM+ZV1zB
	 zacSwJ7ZwndiUXqfKXDhG8KVTazEGM1Wu4525TsVzFDm09PgfyYzT+qFjid5co7Fdn
	 xnfwWJQaVujhf4k1e9g/BF6MvTiwFfzugCto1Lfbhgy3F3gqWntxvWBLQggKWdW7He
	 YRHWjuvGsAbFg==
Date: Fri, 30 Oct 2026 15:37:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 36/98] blk-mq: quiesce a queue that joins a quiesced tag
 set
Message-ID: <20261030223702.GA1673281@ax162>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-37-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-37-axboe@kernel.dk>

Hi Rust for Linux folks,

I only added a small subset of you plus the mailing list, if I missed
anybody, please bring them in as necessary.

On Wed, Oct 28, 2026 at 10:41:39AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> blk_mq_quiesce_tagset() only quiesces the queues on the list at that
> moment. A queue added before blk_mq_unquiesce_tagset() runs unquiesced,
> and then gets unquiesced without ever having been quiesced, which trips
> the warning in blk_mq_unquiesce_queue(). NVMe gets there when a
> controller fails while its namespaces are being scanned.
> 
> Count the quiesce calls in the tag set and quiesce a joining queue that
> many times, under a spinlock that also serializes the two functions. It
> can't be tag_list_lock, see commit 59e25ef2b413.
> 
> Fixes: 414dd48e882c ("blk-mq: add tagset quiesce interface")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

After this patch landed in -next as commit 71ec3c7d6db8 ("blk-mq:
quiesce a queue that joins a quiesced tag set"), I am seeing the
following build error:

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper allmodconfig rust/kernel.o
  error[E0277]: the trait bound `bindings::__BindgenOpaqueArray8<[u8; 72]>: pin_init::Zeroable` is not satisfied
      --> rust/kernel/block/mq/tag_set.rs:41:49
       |
    41 |         let tag_set: bindings::blk_mq_tag_set = pin_init::zeroed();
       |                                                 ^^^^^^^^^^^^^^^^^^ the trait `pin_init::Zeroable` is not implemented for `bindings::__BindgenOpaqueArray8<[u8; 72]>`
       |
       = help: the following other types implement trait `pin_init::Zeroable`:
                 ()
                 (A, B, C, D, E, F, G, H, I, J)
                 (B, C, D, E, F, G, H, I, J)
                 (C, D, E, F, G, H, I, J)
                 (D, E, F, G, H, I, J)
                 (E, F, G, H, I, J)
                 (F, G, H, I, J)
                 (G, H, I, J)
               and 6359 others
       = note: required for `bindings::spinlock` to implement `pin_init::Zeroable`
       = note: 1 redundant requirement hidden
       = note: required for `blk_mq_tag_set` to implement `pin_init::Zeroable`
  note: required by a bound in `pin_init::zeroed`
      --> rust/pin-init/src/lib.rs:1688:24
       |
  1688 | pub const fn zeroed<T: Zeroable>() -> T {
       |                        ^^^^^^^^ required by this bound in `zeroed`

  error: aborting due to 1 previous error

  For more information about this error, try `rustc --explain E0277`.
  make[4]: *** [rust/Makefile:799: rust/kernel.o] Error 1
  ...

> ---
>  block/blk-mq.c         | 22 ++++++++++++++++++++++
>  include/linux/blk-mq.h |  6 ++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6d3ea97f9a00..0e8449424c9a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -336,12 +336,15 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>  {
>  	struct request_queue *q;
>  
> +	spin_lock(&set->quiesce_lock);
> +	set->quiesce_depth++;
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
>  		if (!blk_queue_skip_tagset_quiesce(q))
>  			blk_mq_quiesce_queue_nowait(q);
>  	}
>  	rcu_read_unlock();
> +	spin_unlock(&set->quiesce_lock);
>  
>  	blk_mq_wait_quiesce_done(set);
>  }
> @@ -351,12 +354,16 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>  {
>  	struct request_queue *q;
>  
> +	spin_lock(&set->quiesce_lock);
> +	if (set->quiesce_depth)
> +		set->quiesce_depth--;
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
>  		if (!blk_queue_skip_tagset_quiesce(q))
>  			blk_mq_unquiesce_queue(q);
>  	}
>  	rcu_read_unlock();
> +	spin_unlock(&set->quiesce_lock);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
>  
> @@ -4346,6 +4353,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>  static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  				     struct request_queue *q)
>  {
> +	unsigned int i;
> +
>  	mutex_lock(&set->tag_list_lock);
>  
>  	/*
> @@ -4359,7 +4368,18 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
>  	}
>  	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
>  		queue_set_hctx_shared(q, true);
> +
> +	/*
> +	 * A queue that joins a quiesced tag set is quiesced like the others,
> +	 * and blk_mq_unquiesce_tagset() finds what it is going to undo.
> +	 */
> +	spin_lock(&set->quiesce_lock);
>  	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
> +	if (!blk_queue_skip_tagset_quiesce(q)) {
> +		for (i = 0; i < set->quiesce_depth; i++)
> +			blk_mq_quiesce_queue_nowait(q);
> +	}
> +	spin_unlock(&set->quiesce_lock);
>  
>  	mutex_unlock(&set->tag_list_lock);
>  }
> @@ -4928,6 +4948,8 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>  
>  	mutex_init(&set->tag_list_lock);
>  	INIT_LIST_HEAD(&set->tag_list);
> +	spin_lock_init(&set->quiesce_lock);
> +	set->quiesce_depth = 0;
>  
>  	return 0;
>  
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 5e130b282b42..aa3b35405edc 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -523,6 +523,10 @@ enum hctx_type {
>   * @tag_list_lock: Serializes tag_list accesses.
>   * @tag_list:	   List of the request queues that use this tag set. See also
>   *		   request_queue.tag_set_list.
> + * @quiesce_lock:  Serializes blk_mq_[un]quiesce_tagset() against each other
> + *		   and against a request queue being added to @tag_list.
> + * @quiesce_depth: How often blk_mq_quiesce_tagset() has been called without
> + *		   blk_mq_unquiesce_tagset().
>   * @srcu:	   Use as lock when type of the request queue is blocking
>   *		   (BLK_MQ_F_BLOCKING).
>   * @update_nr_hwq_lock:
> @@ -548,6 +552,8 @@ struct blk_mq_tag_set {
>  
>  	struct mutex		tag_list_lock;
>  	struct list_head	tag_list;
> +	spinlock_t		quiesce_lock;
> +	unsigned int		quiesce_depth;
>  	struct srcu_struct	*srcu;
>  
>  	struct rw_semaphore	update_nr_hwq_lock;
> -- 
> 2.56.0
> 

-- 
Cheers,
Nathan
