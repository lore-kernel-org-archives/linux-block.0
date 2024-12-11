Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8F238E2C
	for <linux-block@vger.kernel.org>; Wed, 11 Dec 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918461; cv=none; b=h4Uao9rJNspK4ru8zcvlgxZTwtFk/ABOR+AEueMV6BcfTxFFHXrQ84vKcl9QaknlcFc+qGPs3r39WuOIByA6W7TFGRhOsKpa6iGEa9FN0UOqjp1cVpedHTgduYhI+sVu5a5UJvZYK8zIkICHPiJwwu/ecURWIhoNVkKfmE38ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918461; c=relaxed/simple;
	bh=ELMiQQvXyIzCW1PBPFAa8AHMmZA6wxL2EhmzyrL1U10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc/LcZQSUyGz/h0npElgTAt4uAS+CUnUYiJZ+EVPq8nWuEZPsTSp27YHt9UlcGeFxfIuBuIYOJ+8K9ZFvzGUp3c6qh65Ij9HHw0+HK/5DSEjJOlEHrZktpXH4XvUNtVLZa4HU6HBfBrlxy0AEQNmoqx9rDcDAiKaWoxUNfSVSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5GZE1dN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5GZE1dN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733918458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ztO32ykSyJ47NmU5Y15f1u+g4H/w4URyfWp4cnDdGnU=;
	b=W5GZE1dNON/fTMoHfh3GcrYtRuz0vx4Qpe0wZ9yKU+so0dQwwllPkbWf2VAQpPBRCaS5hl
	bXpwANswp2R1jyVj3D0fLTLzSAH+lXE4yw3hg5ob1qBhKl/zPOy5/iQj8oSbKEjnwNQZF2
	Xq0VL6bN/TfTdmUTrJXrtN2PoDaqU38=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-OyYRscB4PfqYWBNf5Pf9_g-1; Wed,
 11 Dec 2024 07:00:55 -0500
X-MC-Unique: OyYRscB4PfqYWBNf5Pf9_g-1
X-Mimecast-MFC-AGG-ID: OyYRscB4PfqYWBNf5Pf9_g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30E90195608C;
	Wed, 11 Dec 2024 12:00:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F934300018D;
	Wed, 11 Dec 2024 12:00:47 +0000 (UTC)
Date: Wed, 11 Dec 2024 20:00:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, kjain@linux.ibm.com, hch@lst.de,
	axboe@kernel.dk, ritesh.list@gmail.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2] block: Fix potential deadlock while freezing queue and
 acquiring sysfs_lock
Message-ID: <Z1l-6sBKSI9ubV9G@fedora>
References: <20241210144222.1066229-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210144222.1066229-1-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Dec 10, 2024 at 08:11:43PM +0530, Nilay Shroff wrote:
> For storing a value to a queue attribute, the queue_attr_store function
> first freezes the queue (->q_usage_counter(io)) and then acquire
> ->sysfs_lock. This seems not correct as the usual ordering should be to
> acquire ->sysfs_lock before freezing the queue. This incorrect ordering
> causes the following lockdep splat which we are able to reproduce always
> simply by accessing /sys/kernel/debug file using ls command:
> 
> [   57.597146] WARNING: possible circular locking dependency detected
> [   57.597154] 6.12.0-10553-gb86545e02e8c #20 Tainted: G        W
> [   57.597162] ------------------------------------------------------
> [   57.597168] ls/4605 is trying to acquire lock:
> [   57.597176] c00000003eb56710 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x58/0xc0
> [   57.597200]
>                but task is already holding lock:
> [   57.597207] c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x94/0x1d4
> [   57.597226]
>                which lock already depends on the new lock.
> 
> [   57.597233]
>                the existing dependency chain (in reverse order) is:
> [   57.597241]
>                -> #5 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
> [   57.597255]        down_write+0x6c/0x18c
> [   57.597264]        start_creating+0xb4/0x24c
> [   57.597274]        debugfs_create_dir+0x2c/0x1e8
> [   57.597283]        blk_register_queue+0xec/0x294
> [   57.597292]        add_disk_fwnode+0x2e4/0x548
> [   57.597302]        brd_alloc+0x2c8/0x338
> [   57.597309]        brd_init+0x100/0x178
> [   57.597317]        do_one_initcall+0x88/0x3e4
> [   57.597326]        kernel_init_freeable+0x3cc/0x6e0
> [   57.597334]        kernel_init+0x34/0x1cc
> [   57.597342]        ret_from_kernel_user_thread+0x14/0x1c
> [   57.597350]
>                -> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
> [   57.597362]        __mutex_lock+0xfc/0x12a0
> [   57.597370]        blk_register_queue+0xd4/0x294
> [   57.597379]        add_disk_fwnode+0x2e4/0x548
> [   57.597388]        brd_alloc+0x2c8/0x338
> [   57.597395]        brd_init+0x100/0x178
> [   57.597402]        do_one_initcall+0x88/0x3e4
> [   57.597410]        kernel_init_freeable+0x3cc/0x6e0
> [   57.597418]        kernel_init+0x34/0x1cc
> [   57.597426]        ret_from_kernel_user_thread+0x14/0x1c
> [   57.597434]
>                -> #3 (&q->sysfs_lock){+.+.}-{4:4}:
> [   57.597446]        __mutex_lock+0xfc/0x12a0
> [   57.597454]        queue_attr_store+0x9c/0x110
> [   57.597462]        sysfs_kf_write+0x70/0xb0
> [   57.597471]        kernfs_fop_write_iter+0x1b0/0x2ac
> [   57.597480]        vfs_write+0x3dc/0x6e8
> [   57.597488]        ksys_write+0x84/0x140
> [   57.597495]        system_call_exception+0x130/0x360
> [   57.597504]        system_call_common+0x160/0x2c4
> [   57.597516]
>                -> #2 (&q->q_usage_counter(io)#21){++++}-{0:0}:
> [   57.597530]        __submit_bio+0x5ec/0x828
> [   57.597538]        submit_bio_noacct_nocheck+0x1e4/0x4f0
> [   57.597547]        iomap_readahead+0x2a0/0x448
> [   57.597556]        xfs_vm_readahead+0x28/0x3c
> [   57.597564]        read_pages+0x88/0x41c
> [   57.597571]        page_cache_ra_unbounded+0x1ac/0x2d8
> [   57.597580]        filemap_get_pages+0x188/0x984
> [   57.597588]        filemap_read+0x13c/0x4bc
> [   57.597596]        xfs_file_buffered_read+0x88/0x17c
> [   57.597605]        xfs_file_read_iter+0xac/0x158
> [   57.597614]        vfs_read+0x2d4/0x3b4
> [   57.597622]        ksys_read+0x84/0x144
> [   57.597629]        system_call_exception+0x130/0x360
> [   57.597637]        system_call_common+0x160/0x2c4
> [   57.597647]
>                -> #1 (mapping.invalidate_lock#2){++++}-{4:4}:
> [   57.597661]        down_read+0x6c/0x220
> [   57.597669]        filemap_fault+0x870/0x100c
> [   57.597677]        xfs_filemap_fault+0xc4/0x18c
> [   57.597684]        __do_fault+0x64/0x164
> [   57.597693]        __handle_mm_fault+0x1274/0x1dac
> [   57.597702]        handle_mm_fault+0x248/0x484
> [   57.597711]        ___do_page_fault+0x428/0xc0c
> [   57.597719]        hash__do_page_fault+0x30/0x68
> [   57.597727]        do_hash_fault+0x90/0x35c
> [   57.597736]        data_access_common_virt+0x210/0x220
> [   57.597745]        _copy_from_user+0xf8/0x19c
> [   57.597754]        sel_write_load+0x178/0xd54
> [   57.597762]        vfs_write+0x108/0x6e8
> [   57.597769]        ksys_write+0x84/0x140
> [   57.597777]        system_call_exception+0x130/0x360
> [   57.597785]        system_call_common+0x160/0x2c4
> [   57.597794]
>                -> #0 (&mm->mmap_lock){++++}-{4:4}:
> [   57.597806]        __lock_acquire+0x17cc/0x2330
> [   57.597814]        lock_acquire+0x138/0x400
> [   57.597822]        __might_fault+0x7c/0xc0
> [   57.597830]        filldir64+0xe8/0x390
> [   57.597839]        dcache_readdir+0x80/0x2d4
> [   57.597846]        iterate_dir+0xd8/0x1d4
> [   57.597855]        sys_getdents64+0x88/0x2d4
> [   57.597864]        system_call_exception+0x130/0x360
> [   57.597872]        system_call_common+0x160/0x2c4
> [   57.597881]
>                other info that might help us debug this:
> 
> [   57.597888] Chain exists of:
>                  &mm->mmap_lock --> &q->debugfs_mutex --> &sb->s_type->i_mutex_key#3
> 
> [   57.597905]  Possible unsafe locking scenario:
> 
> [   57.597911]        CPU0                    CPU1
> [   57.597917]        ----                    ----
> [   57.597922]   rlock(&sb->s_type->i_mutex_key#3);
> [   57.597932]                                lock(&q->debugfs_mutex);
> [   57.597940]                                lock(&sb->s_type->i_mutex_key#3);
> [   57.597950]   rlock(&mm->mmap_lock);
> [   57.597958]
>                 *** DEADLOCK ***
> 
> [   57.597965] 2 locks held by ls/4605:
> [   57.597971]  #0: c0000000137c12f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0xcc/0x154
> [   57.597989]  #1: c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x94/0x1d4
> 
> Prevent the above lockdep warning by acquiring ->sysfs_lock before
> freezing the queue while storing a queue attribute in queue_attr_store
> function. Later, we also found[1] another function __blk_mq_update_nr_
> hw_queues where we first freeze queue and then acquire the ->sysfs_lock.
> So we've also updated lock ordering in __blk_mq_update_nr_hw_queues
> function and ensured that in all code paths we follow the correct lock
> ordering i.e. acquire ->sysfs_lock before freezing the queue.
> 
> [1] https://lore.kernel.org/all/CAFj5m9Ke8+EHKQBs_Nk6hqd=LGXtk4mUxZUN5==ZcCjnZSBwHw@mail.gmail.com/
> 
> Reported-by: kjain@linux.ibm.com
> Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
> Tested-by: kjain@linux.ibm.com
> Cc: hch@lst.de
> Cc: axboe@kernel.dk
> Cc: ritesh.list@gmail.com
> Cc: ming.lei@redhat.com
> Cc: gjoyce@linux.ibm.com
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>     Changes from v1:
> 	- Fix lock ordering in __blk_mq_update_nr_hw_queues (Ming Lei)
> ---
>  block/blk-mq-sysfs.c | 16 ++++++----------
>  block/blk-mq.c       | 29 ++++++++++++++++++-----------
>  block/blk-sysfs.c    |  4 ++--
>  3 files changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 156e9bb07abf..cd5ea6eaa76b 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -275,15 +275,13 @@ void blk_mq_sysfs_unregister_hctxs(struct request_queue *q)
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned long i;
>  
> -	mutex_lock(&q->sysfs_dir_lock);
> +	lockdep_assert_held(&q->sysfs_dir_lock);
> +
>  	if (!q->mq_sysfs_init_done)
> -		goto unlock;
> +		return;
>  
>  	queue_for_each_hw_ctx(q, hctx, i)
>  		blk_mq_unregister_hctx(hctx);
> -
> -unlock:
> -	mutex_unlock(&q->sysfs_dir_lock);
>  }
>  
>  int blk_mq_sysfs_register_hctxs(struct request_queue *q)
> @@ -292,9 +290,10 @@ int blk_mq_sysfs_register_hctxs(struct request_queue *q)
>  	unsigned long i;
>  	int ret = 0;
>  
> -	mutex_lock(&q->sysfs_dir_lock);
> +	lockdep_assert_held(&q->sysfs_dir_lock);
> +
>  	if (!q->mq_sysfs_init_done)
> -		goto unlock;
> +		return ret;
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		ret = blk_mq_register_hctx(hctx);
> @@ -302,8 +301,5 @@ int blk_mq_sysfs_register_hctxs(struct request_queue *q)
>  			break;
>  	}
>  
> -unlock:
> -	mutex_unlock(&q->sysfs_dir_lock);
> -
>  	return ret;
>  }
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index aa340b097b6e..cccfc6dada7e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4455,7 +4455,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  	unsigned long i, j;
>  
>  	/* protect against switching io scheduler  */
> -	mutex_lock(&q->sysfs_lock);
> +	lockdep_assert_held(&q->sysfs_lock);
> +
>  	for (i = 0; i < set->nr_hw_queues; i++) {
>  		int old_node;
>  		int node = blk_mq_get_hctx_node(set, i);
> @@ -4488,7 +4489,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  
>  	xa_for_each_start(&q->hctx_table, j, hctx, j)
>  		blk_mq_exit_hctx(q, set, hctx, j);
> -	mutex_unlock(&q->sysfs_lock);
>  
>  	/* unregister cpuhp callbacks for exited hctxs */
>  	blk_mq_remove_hw_queues_cpuhp(q);
> @@ -4520,10 +4520,14 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  
>  	xa_init(&q->hctx_table);
>  
> +	mutex_lock(&q->sysfs_lock);
> +
>  	blk_mq_realloc_hw_ctxs(set, q);
>  	if (!q->nr_hw_queues)
>  		goto err_hctxs;
>  
> +	mutex_unlock(&q->sysfs_lock);
> +
>  	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
>  	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
>  
> @@ -4542,6 +4546,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  	return 0;
>  
>  err_hctxs:
> +	mutex_unlock(&q->sysfs_lock);

The change in blk_mq_init_allocated_queue() isn't necessary, since queue
kobj isn't exposed yet, otherwise, feel free to add:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

