Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8551FF7A2;
	Mon,  2 Dec 2024 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138984; cv=none; b=JSQiOqUe+FSwNVnpM7jbJfwUWMpPB+3FC3iNkOJU+m1hhDz67Bjfu27OAzWNTjxoVXnVKCjmUl3iE1qzsxUL8NItaepWF5WJhhESxRBiesUfjz4J9zf6Ohr5EAL/6kz/Pl9SnPI7HArGuF3k0DgDXxc/nI2QJLZkrIER0+8e91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138984; c=relaxed/simple;
	bh=caUzwjMghzOWCwLK1It6simu4RbhTbezCw9+gV08Q34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/TbNbC1jis0HtoAM1+R0XHJfa61xIivB7e+PP/ZawlNrDkFXXtrkFZuQgHomMSDad0tZ0Z/IPTPlxESrkaE6K/FBrUnOuah7eUa5Un2H0FGKRRnBFMImhXooNDEDjThNmVmR2Ek89giuRFF8B59j/NGgScAj/SrWthiLidKNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vYMqWHwW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A0vChZDa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vYMqWHwW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A0vChZDa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vYMqWHwW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A0vChZDa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vYMqWHwW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A0vChZDa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B501B1F444;
	Mon,  2 Dec 2024 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733138980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2aXKwkxxxOHOobiQgwNFgO02tv0tbtGIdAwJXK3xiA=;
	b=vYMqWHwWa76tLwlX7OrWJo9C5ZNZoXo+p/cO4On8XeEeviCnRTz/c2nzllW7PmDwrumvKl
	CkXjFiqI9nB+9Ab4qxLD43fiRv2mBLPQASDJufFhyq44ggD+wxMvINgvU0DnbTRorgF1rr
	z4rZOgWKhV51gqPT1y2Zjw+plk8MPmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733138980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2aXKwkxxxOHOobiQgwNFgO02tv0tbtGIdAwJXK3xiA=;
	b=A0vChZDaT0sRqDsC3B+4gPOiOrcg74r1iT51dTj7629gypPcGgYAfWiZEqk0ivxjs1uxbu
	qWWvPi9YMSnHBqCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vYMqWHwW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=A0vChZDa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733138980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2aXKwkxxxOHOobiQgwNFgO02tv0tbtGIdAwJXK3xiA=;
	b=vYMqWHwWa76tLwlX7OrWJo9C5ZNZoXo+p/cO4On8XeEeviCnRTz/c2nzllW7PmDwrumvKl
	CkXjFiqI9nB+9Ab4qxLD43fiRv2mBLPQASDJufFhyq44ggD+wxMvINgvU0DnbTRorgF1rr
	z4rZOgWKhV51gqPT1y2Zjw+plk8MPmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733138980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2aXKwkxxxOHOobiQgwNFgO02tv0tbtGIdAwJXK3xiA=;
	b=A0vChZDaT0sRqDsC3B+4gPOiOrcg74r1iT51dTj7629gypPcGgYAfWiZEqk0ivxjs1uxbu
	qWWvPi9YMSnHBqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5B57139C2;
	Mon,  2 Dec 2024 11:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G5d1KCSaTWf7YgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 11:29:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E974A08D6; Mon,  2 Dec 2024 12:29:36 +0100 (CET)
Date: Mon, 2 Dec 2024 12:29:36 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: yukuai3@huawei.com, axboe@kernel.dk, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] block, bfq: fix bfqq uaf in bfq_limit_depth()
Message-ID: <20241202112936.winpwxd5sbouczhj@quack3>
References: <20241129091509.2227136-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129091509.2227136-1-yukuai1@huaweicloud.com>
X-Rspamd-Queue-Id: B501B1F444
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 29-11-24 17:15:09, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Set new allocated bfqq to bic or remove freed bfqq from bic are both
> protected by bfqd->lock, however bfq_limit_depth() is deferencing bfqq
> from bic without the lock, this can lead to UAF if the io_context is
> shared by multiple tasks.
> 
> For example, test bfq with io_uring can trigger following UAF in v6.6:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in bfqq_group+0x15/0x50
> 
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x47/0x80
>  print_address_description.constprop.0+0x66/0x300
>  print_report+0x3e/0x70
>  kasan_report+0xb4/0xf0
>  bfqq_group+0x15/0x50
>  bfqq_request_over_limit+0x130/0x9a0
>  bfq_limit_depth+0x1b5/0x480
>  __blk_mq_alloc_requests+0x2b5/0xa00
>  blk_mq_get_new_requests+0x11d/0x1d0
>  blk_mq_submit_bio+0x286/0xb00
>  submit_bio_noacct_nocheck+0x331/0x400
>  __block_write_full_folio+0x3d0/0x640
>  writepage_cb+0x3b/0xc0
>  write_cache_pages+0x254/0x6c0
>  write_cache_pages+0x254/0x6c0
>  do_writepages+0x192/0x310
>  filemap_fdatawrite_wbc+0x95/0xc0
>  __filemap_fdatawrite_range+0x99/0xd0
>  filemap_write_and_wait_range.part.0+0x4d/0xa0
>  blkdev_read_iter+0xef/0x1e0
>  io_read+0x1b6/0x8a0
>  io_issue_sqe+0x87/0x300
>  io_wq_submit_work+0xeb/0x390
>  io_worker_handle_work+0x24d/0x550
>  io_wq_worker+0x27f/0x6c0
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> 
> Allocated by task 808602:
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x21/0x30
>  __kasan_slab_alloc+0x83/0x90
>  kmem_cache_alloc_node+0x1b1/0x6d0
>  bfq_get_queue+0x138/0xfa0
>  bfq_get_bfqq_handle_split+0xe3/0x2c0
>  bfq_init_rq+0x196/0xbb0
>  bfq_insert_request.isra.0+0xb5/0x480
>  bfq_insert_requests+0x156/0x180
>  blk_mq_insert_request+0x15d/0x440
>  blk_mq_submit_bio+0x8a4/0xb00
>  submit_bio_noacct_nocheck+0x331/0x400
>  __blkdev_direct_IO_async+0x2dd/0x330
>  blkdev_write_iter+0x39a/0x450
>  io_write+0x22a/0x840
>  io_issue_sqe+0x87/0x300
>  io_wq_submit_work+0xeb/0x390
>  io_worker_handle_work+0x24d/0x550
>  io_wq_worker+0x27f/0x6c0
>  ret_from_fork+0x2d/0x50
>  ret_from_fork_asm+0x1b/0x30
> 
> Freed by task 808589:
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x21/0x30
>  kasan_save_free_info+0x27/0x40
>  __kasan_slab_free+0x126/0x1b0
>  kmem_cache_free+0x10c/0x750
>  bfq_put_queue+0x2dd/0x770
>  __bfq_insert_request.isra.0+0x155/0x7a0
>  bfq_insert_request.isra.0+0x122/0x480
>  bfq_insert_requests+0x156/0x180
>  blk_mq_dispatch_plug_list+0x528/0x7e0
>  blk_mq_flush_plug_list.part.0+0xe5/0x590
>  __blk_flush_plug+0x3b/0x90
>  blk_finish_plug+0x40/0x60
>  do_writepages+0x19d/0x310
>  filemap_fdatawrite_wbc+0x95/0xc0
>  __filemap_fdatawrite_range+0x99/0xd0
>  filemap_write_and_wait_range.part.0+0x4d/0xa0
>  blkdev_read_iter+0xef/0x1e0
>  io_read+0x1b6/0x8a0
>  io_issue_sqe+0x87/0x300
>  io_wq_submit_work+0xeb/0x390
>  io_worker_handle_work+0x24d/0x550
>  io_wq_worker+0x27f/0x6c0
>  ret_from_fork+0x2d/0x50
>  ret_from_fork_asm+0x1b/0x30
> 
> Fix the problem by protecting bic_to_bfqq() with bfqd->lock.
> 
> CC: Jan Kara <jack@suse.cz>
> Fixes: 76f1df88bbc2 ("bfq: Limit number of requests consumed by each cgroup")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I can see Jens has already picked up the patch but FWIW the patch looks
good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 28c2bb06e859..95dd7b795935 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -582,23 +582,31 @@ static struct request *bfq_choose_req(struct bfq_data *bfqd,
>  #define BFQ_LIMIT_INLINE_DEPTH 16
>  
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
> +static bool bfqq_request_over_limit(struct bfq_data *bfqd,
> +				    struct bfq_io_cq *bic, blk_opf_t opf,
> +				    unsigned int act_idx, int limit)
>  {
> -	struct bfq_data *bfqd = bfqq->bfqd;
> -	struct bfq_entity *entity = &bfqq->entity;
>  	struct bfq_entity *inline_entities[BFQ_LIMIT_INLINE_DEPTH];
>  	struct bfq_entity **entities = inline_entities;
> -	int depth, level, alloc_depth = BFQ_LIMIT_INLINE_DEPTH;
> -	int class_idx = bfqq->ioprio_class - 1;
> +	int alloc_depth = BFQ_LIMIT_INLINE_DEPTH;
>  	struct bfq_sched_data *sched_data;
> +	struct bfq_entity *entity;
> +	struct bfq_queue *bfqq;
>  	unsigned long wsum;
>  	bool ret = false;
> -
> -	if (!entity->on_st_or_in_serv)
> -		return false;
> +	int depth;
> +	int level;
>  
>  retry:
>  	spin_lock_irq(&bfqd->lock);
> +	bfqq = bic_to_bfqq(bic, op_is_sync(opf), act_idx);
> +	if (!bfqq)
> +		goto out;
> +
> +	entity = &bfqq->entity;
> +	if (!entity->on_st_or_in_serv)
> +		goto out;
> +
>  	/* +1 for bfqq entity, root cgroup not included */
>  	depth = bfqg_to_blkg(bfqq_group(bfqq))->blkcg->css.cgroup->level + 1;
>  	if (depth > alloc_depth) {
> @@ -643,7 +651,7 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
>  			 * class.
>  			 */
>  			wsum = 0;
> -			for (i = 0; i <= class_idx; i++) {
> +			for (i = 0; i <= bfqq->ioprio_class - 1; i++) {
>  				wsum = wsum * IOPRIO_BE_NR +
>  					sched_data->service_tree[i].wsum;
>  			}
> @@ -666,7 +674,9 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
>  	return ret;
>  }
>  #else
> -static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
> +static bool bfqq_request_over_limit(struct bfq_data *bfqd,
> +				    struct bfq_io_cq *bic, blk_opf_t opf,
> +				    unsigned int act_idx, int limit)
>  {
>  	return false;
>  }
> @@ -704,8 +714,9 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
>  	}
>  
>  	for (act_idx = 0; bic && act_idx < bfqd->num_actuators; act_idx++) {
> -		struct bfq_queue *bfqq =
> -			bic_to_bfqq(bic, op_is_sync(opf), act_idx);
> +		/* Fast path to check if bfqq is already allocated. */
> +		if (!bic_to_bfqq(bic, op_is_sync(opf), act_idx))
> +			continue;
>  
>  		/*
>  		 * Does queue (or any parent entity) exceed number of
> @@ -713,7 +724,7 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
>  		 * limit depth so that it cannot consume more
>  		 * available requests and thus starve other entities.
>  		 */
> -		if (bfqq && bfqq_request_over_limit(bfqq, limit)) {
> +		if (bfqq_request_over_limit(bfqd, bic, opf, act_idx, limit)) {
>  			depth = 1;
>  			break;
>  		}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
