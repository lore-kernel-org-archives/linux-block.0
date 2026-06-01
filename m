Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D82C11CF
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330426; cv=none; b=FtNOL9G6bWMOvSUEOolNZuYn5whL7lFbya3wCXcArs9MZptE6KQMqb+4WdbirQg45IxFFsrL2ClDZhu/tcdSMMhDpyvRfE2szabDxfs1/2MrkzKwOtNx3obZXr/NyUHicQ/J37OiObWdwqrYyoZniwi+jHkrwCFXKxBVC29VjXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330426; c=relaxed/simple;
	bh=E/TGQivgMHJimA4BSIx91AIeOI43MoqvNuXHOsohYIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi9Ij/cnfe+kIjhvcIgI5NYmjqJrAiy3eoP0iFtc0O/pqKHXgop3aywZrmwQrrEWF4ebth35QgOWzhWwYDfxL6GiPIR1B7yAzLAgBd4saHZPMmaoEMCsws8vFFcZhelSFOIWD7q5/woMujGVq7fctP6Xm3Ycd55McDq+7L7XMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aVT8OoJF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHvqfMtb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aVT8OoJF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aHvqfMtb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aVT8OoJF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHvqfMtb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aVT8OoJF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aHvqfMtb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 099A566EFF;
	Mon,  1 Jun 2026 16:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780330423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jtc6oyZiF4kCKo40Q8Qd02iiK1OO9fKOz3hhpZNr2ug=;
	b=aVT8OoJFEtrdmv56Ex2gMhb9OWmVzDY3x5p3wE0tm+mpXRPi2QyU2MwH/vENI0Tp6vROmx
	WSsmGttZvY+VbH/XUadFCGkRRjtfaVmZGJ0yEnKBTm/hIclS8PtlQukGutaxxVblXQIx9u
	HEBMaBwooSg2Os9MbGBpwQ8K1HyDV+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780330423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jtc6oyZiF4kCKo40Q8Qd02iiK1OO9fKOz3hhpZNr2ug=;
	b=aHvqfMtbIxSp0nm2BDX1gcueAk6Jlml8T+fMYwDIk9KFo14nZBbQNN650JtV6jIMWUzy/S
	xvDg2o3JZIDo5xCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780330423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jtc6oyZiF4kCKo40Q8Qd02iiK1OO9fKOz3hhpZNr2ug=;
	b=aVT8OoJFEtrdmv56Ex2gMhb9OWmVzDY3x5p3wE0tm+mpXRPi2QyU2MwH/vENI0Tp6vROmx
	WSsmGttZvY+VbH/XUadFCGkRRjtfaVmZGJ0yEnKBTm/hIclS8PtlQukGutaxxVblXQIx9u
	HEBMaBwooSg2Os9MbGBpwQ8K1HyDV+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780330423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jtc6oyZiF4kCKo40Q8Qd02iiK1OO9fKOz3hhpZNr2ug=;
	b=aHvqfMtbIxSp0nm2BDX1gcueAk6Jlml8T+fMYwDIk9KFo14nZBbQNN650JtV6jIMWUzy/S
	xvDg2o3JZIDo5xCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7FFB779A7;
	Mon,  1 Jun 2026 16:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JQ6kOLavHWoFbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jun 2026 16:13:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 85F1CA0EC0; Mon, 01 Jun 2026 18:13:38 +0200 (CEST)
Date: Mon, 1 Jun 2026 18:13:38 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai@fygo.io>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] block, bfq: release cgroup stats with bfq_group
Message-ID: <gscrsynwbepdg6ogl2vivebdjodfvfmwq37sc3lsyry5yn7rrl@xjyhzloepooa>
References: <20260601061502.899552-1-yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601061502.899552-1-yukuai@fygo.io>
X-Spam-Flag: NO
X-Spamd-Result: default: False [3.70 / 50.00];
	URIBL_BLACK(7.50)[fygo.io:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,fygo.io:email]
X-Spam-Level: ***
X-Spam-Score: 3.70

On Mon 01-06-26 14:15:02, Yu Kuai wrote:
> BFQ cgroup stats contain percpu counters embedded in struct bfq_group,
> but the old free path destroys them from bfq_pd_free(), which is tied
> to blkg policy-data teardown.
> 
> That is not the same lifetime as struct bfq_group. BFQ pins bfq_group
> while bfq_queue entities refer to it, so bfq_pd_free() can drop the
> policy-data reference while other bfq_group references still exist. The
> following blkcg change also defers policy-data release through RCU and
> leaves BFQ to run the final bfqg_put() from an RCU callback. For that
> conversion, stats teardown must belong to the last bfq_group put, not to
> policy-data teardown.
> 
> Move stats teardown to bfqg_put() so the embedded counters are destroyed
> exactly when the last bfq_group reference is released, before kfree(bfqg).
> 
> Without this preparatory change, the RCU-delayed policy-data free
> conversion reproduced the following KASAN report:
> 
>   BUG: KASAN: slab-use-after-free in percpu_counter_destroy_many+0xf1/0x2e0
>   Write of size 8 at addr ffff88811d9409e0 by task test_blkcg/535
> 
>   CPU: 0 UID: 0 PID: 535 Comm: test_blkcg Not tainted 7.1.0-rc2-g1e14adca0199 #1 PREEMPT  ea13f83d4b74a12510d20db4a7d9a0fe8275f05c
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x54/0x70
>    print_address_description+0x77/0x200
>    ? percpu_counter_destroy_many+0xf1/0x2e0
>    print_report+0x64/0x70
>    kasan_report+0x118/0x150
>    ? percpu_counter_destroy_many+0xf1/0x2e0
>    percpu_counter_destroy_many+0xf1/0x2e0
>    __mmdrop+0x1d8/0x350
>    finish_task_switch+0x3f5/0x570
>    __schedule+0xe8e/0x18a0
>    schedule+0xfe/0x1c0
>    schedule_timeout+0x7f/0x1d0
>    __wait_for_common+0x26c/0x3f0
>    wait_for_completion_state+0x21/0x40
>    call_usermodehelper_exec+0x271/0x2c0
>    __request_module+0x296/0x410
>    elv_iosched_store+0x1bc/0x2c0
>    queue_attr_store+0x152/0x1c0
>    kernfs_fop_write_iter+0x1d7/0x280
>    vfs_write+0x580/0x630
>    ksys_write+0xec/0x190
>    do_syscall_64+0x156/0x490
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>   Allocated by task 535:
>    kasan_save_track+0x3e/0x80
>    __kasan_kmalloc+0x72/0x90
>    bfq_pd_alloc+0x60/0x100 [bfq]
>    blkg_create+0x3bb/0xbe0
>    blkg_lookup_create+0x3a2/0x460
>    blkg_conf_start+0x24a/0x2d0
>    bfq_io_set_weight+0x17f/0x430 [bfq]
>    cgroup_file_write+0x1c5/0x4b0
>    kernfs_fop_write_iter+0x1d7/0x280
>    vfs_write+0x580/0x630
>    ksys_write+0xec/0x190
>    do_syscall_64+0x156/0x490
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>   Freed by task 0:
>    kasan_save_track+0x3e/0x80
>    kasan_save_free_info+0x46/0x50
>    __kasan_slab_free+0x3a/0x60
>    kfree+0x14e/0x4f0
>    rcu_core+0x6f3/0xcd0
>    handle_softirqs+0x1a0/0x550
>    __irq_exit_rcu+0x8c/0x150
>    irq_exit_rcu+0xe/0x20
>    sysvec_apic_timer_interrupt+0x6e/0x80
>    asm_sysvec_apic_timer_interrupt+0x1a/0x20
> 
>   Last potentially related work creation:
>    kasan_save_stack+0x3e/0x60
>    kasan_record_aux_stack+0x99/0xb0
>    call_rcu+0x55/0x5c0
>    blkg_free_workfn+0x130/0x220
>    process_scheduled_works+0x655/0xb60
>    worker_thread+0x446/0x600
>    kthread+0x1f4/0x230
>    ret_from_fork+0x259/0x420
>    ret_from_fork_asm+0x1a/0x30
> 
> Signed-off-by: Yu Kuai <yukuai@fygo.io>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-cgroup.c | 43 ++++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index ac83b0668764..37ab70930c8d 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -300,6 +300,25 @@ static struct bfq_group *bfqg_parent(struct bfq_group *bfqg)
>  	return pblkg ? blkg_to_bfqg(pblkg) : NULL;
>  }
>  
> +static void bfqg_stats_exit(struct bfqg_stats *stats)
> +{
> +	blkg_rwstat_exit(&stats->bytes);
> +	blkg_rwstat_exit(&stats->ios);
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> +	blkg_rwstat_exit(&stats->merged);
> +	blkg_rwstat_exit(&stats->service_time);
> +	blkg_rwstat_exit(&stats->wait_time);
> +	blkg_rwstat_exit(&stats->queued);
> +	bfq_stat_exit(&stats->time);
> +	bfq_stat_exit(&stats->avg_queue_size_sum);
> +	bfq_stat_exit(&stats->avg_queue_size_samples);
> +	bfq_stat_exit(&stats->dequeue);
> +	bfq_stat_exit(&stats->group_wait_time);
> +	bfq_stat_exit(&stats->idle_time);
> +	bfq_stat_exit(&stats->empty_time);
> +#endif
> +}
> +
>  struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
>  {
>  	struct bfq_entity *group_entity = bfqq->entity.parent;
> @@ -321,8 +340,10 @@ static void bfqg_get(struct bfq_group *bfqg)
>  
>  static void bfqg_put(struct bfq_group *bfqg)
>  {
> -	if (refcount_dec_and_test(&bfqg->ref))
> +	if (refcount_dec_and_test(&bfqg->ref)) {
> +		bfqg_stats_exit(&bfqg->stats);
>  		kfree(bfqg);
> +	}
>  }
>  
>  static void bfqg_and_blkg_get(struct bfq_group *bfqg)
> @@ -433,25 +454,6 @@ void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg)
>  	entity->sched_data = &bfqg->sched_data;
>  }
>  
> -static void bfqg_stats_exit(struct bfqg_stats *stats)
> -{
> -	blkg_rwstat_exit(&stats->bytes);
> -	blkg_rwstat_exit(&stats->ios);
> -#ifdef CONFIG_BFQ_CGROUP_DEBUG
> -	blkg_rwstat_exit(&stats->merged);
> -	blkg_rwstat_exit(&stats->service_time);
> -	blkg_rwstat_exit(&stats->wait_time);
> -	blkg_rwstat_exit(&stats->queued);
> -	bfq_stat_exit(&stats->time);
> -	bfq_stat_exit(&stats->avg_queue_size_sum);
> -	bfq_stat_exit(&stats->avg_queue_size_samples);
> -	bfq_stat_exit(&stats->dequeue);
> -	bfq_stat_exit(&stats->group_wait_time);
> -	bfq_stat_exit(&stats->idle_time);
> -	bfq_stat_exit(&stats->empty_time);
> -#endif
> -}
> -
>  static int bfqg_stats_init(struct bfqg_stats *stats, gfp_t gfp)
>  {
>  	if (blkg_rwstat_init(&stats->bytes, gfp) ||
> @@ -552,7 +554,6 @@ static void bfq_pd_free(struct blkg_policy_data *pd)
>  {
>  	struct bfq_group *bfqg = pd_to_bfqg(pd);
>  
> -	bfqg_stats_exit(&bfqg->stats);
>  	bfqg_put(bfqg);
>  }
>  
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
