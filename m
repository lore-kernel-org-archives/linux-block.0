Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF81F4C8E
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265435; cv=none; b=rHMtM4iaAHLzGj4vzhV6nAoN1IVUIn4R9v+MhMhNlIiHj5LuUACGUywDNklteRUQvrJK5qOIoSc6yo+l30aknZ9VlG0cX1tIUVf85Fh1gkGnA9WaxtQkoeLj+FM6vHq2K8k11EeaYc8RPqq6rHHb/kfolrjV2fPLVQs1ymzzq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265435; c=relaxed/simple;
	bh=bFVpewGiJ4KJ2cjCvfb7CI7RL75WeVj0KOPO90QnC+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIbGV/i42wcOnd1TeXr+V+Gho2vBkQhqGswB9sy1h4MWHmsiyNBtonUlwMrMICvtO7TT3sCI2ZpVH7XufF6W2j87x/lkvm0mKL4OYNYzKWRtFbsacfE7xyrHbKCIn2o6ytLDbIyu4hAljLyzKp2yEvuUzKyQ5J+ld/d10p6bkKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nsp0vVSQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Div0tf8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nsp0vVSQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Div0tf8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nsp0vVSQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Div0tf8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nsp0vVSQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Div0tf8"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CB6533796;
	Tue,  9 Dec 2025 07:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765265431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ww6vuDW1k5TgQKvo8y4siizXxDDlkK0rlGtzyozrFSs=;
	b=Nsp0vVSQYd6LGJPC2Zmdw0R2n7m3Tr9UQS9D7UbvULjamwV0BU3Hq8M80UXaHNHexzn78R
	vnFGwgQWRggzW0aRK4in4NiIu1iClI5LccKu+jqFXzmSDu5/jViyMrRMFZhuB069yYO2UN
	hJDgaNt6jIlof87rark34Hozq5mxxds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765265431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ww6vuDW1k5TgQKvo8y4siizXxDDlkK0rlGtzyozrFSs=;
	b=3Div0tf8QcaAan5uAaeXYjDcesmI4TR/0D0y7a5k8zPQbVQSR5VKUQXSpeG8kqYYrqdsrB
	2SZbTkIi1LlSm6Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765265431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ww6vuDW1k5TgQKvo8y4siizXxDDlkK0rlGtzyozrFSs=;
	b=Nsp0vVSQYd6LGJPC2Zmdw0R2n7m3Tr9UQS9D7UbvULjamwV0BU3Hq8M80UXaHNHexzn78R
	vnFGwgQWRggzW0aRK4in4NiIu1iClI5LccKu+jqFXzmSDu5/jViyMrRMFZhuB069yYO2UN
	hJDgaNt6jIlof87rark34Hozq5mxxds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765265431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ww6vuDW1k5TgQKvo8y4siizXxDDlkK0rlGtzyozrFSs=;
	b=3Div0tf8QcaAan5uAaeXYjDcesmI4TR/0D0y7a5k8zPQbVQSR5VKUQXSpeG8kqYYrqdsrB
	2SZbTkIi1LlSm6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2A283EA63;
	Tue,  9 Dec 2025 07:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QSKwIxLQN2nuSgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Dec 2025 07:30:26 +0000
Message-ID: <eb03af5f-6371-4e3b-acfc-9c3d75403d18@suse.de>
Date: Tue, 9 Dec 2025 08:30:23 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Casey Chen <cachen@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
 <20251205211738.1872244-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251205211738.1872244-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.980];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[sina.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[purestorage.com,redhat.com,sina.com,lists.infradead.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 12/5/25 22:17, Mohamed Khalfella wrote:
> blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> tagset, the functions make sure that tagset and queues are marked as
> shared when two or more queues are attached to the same tagset.
> Initially a tagset starts as unshared and when the number of added
> queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> with all the queues attached to it. When the number of attached queues
> drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> the remaining queues as unshared.
> 
> Both functions need to freeze current queues in tagset before setting on
> unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> hold set->tag_list_lock mutex, which makes sense as we do not want
> queues to be added or deleted in the process. This used to work fine
> until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> made the nvme driver quiesce tagset instead of quiscing individual
> queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> set->tag_list while holding set->tag_list_lock also.
> 
> This results in deadlock between two threads with these stacktraces:
> 
>    __schedule+0x47c/0xbb0
>    ? timerqueue_add+0x66/0xb0
>    schedule+0x1c/0xa0
>    schedule_preempt_disabled+0xa/0x10
>    __mutex_lock.constprop.0+0x271/0x600
>    blk_mq_quiesce_tagset+0x25/0xc0
>    nvme_dev_disable+0x9c/0x250
>    nvme_timeout+0x1fc/0x520
>    blk_mq_handle_expired+0x5c/0x90
>    bt_iter+0x7e/0x90
>    blk_mq_queue_tag_busy_iter+0x27e/0x550
>    ? __blk_mq_complete_request_remote+0x10/0x10
>    ? __blk_mq_complete_request_remote+0x10/0x10
>    ? __call_rcu_common.constprop.0+0x1c0/0x210
>    blk_mq_timeout_work+0x12d/0x170
>    process_one_work+0x12e/0x2d0
>    worker_thread+0x288/0x3a0
>    ? rescuer_thread+0x480/0x480
>    kthread+0xb8/0xe0
>    ? kthread_park+0x80/0x80
>    ret_from_fork+0x2d/0x50
>    ? kthread_park+0x80/0x80
>    ret_from_fork_asm+0x11/0x20
> 
>    __schedule+0x47c/0xbb0
>    ? xas_find+0x161/0x1a0
>    schedule+0x1c/0xa0
>    blk_mq_freeze_queue_wait+0x3d/0x70
>    ? destroy_sched_domains_rcu+0x30/0x30
>    blk_mq_update_tag_set_shared+0x44/0x80
>    blk_mq_exit_queue+0x141/0x150
>    del_gendisk+0x25a/0x2d0
>    nvme_ns_remove+0xc9/0x170
>    nvme_remove_namespaces+0xc7/0x100
>    nvme_remove+0x62/0x150
>    pci_device_remove+0x23/0x60
>    device_release_driver_internal+0x159/0x200
>    unbind_store+0x99/0xa0
>    kernfs_fop_write_iter+0x112/0x1e0
>    vfs_write+0x2b1/0x3d0
>    ksys_write+0x4e/0xb0
>    do_syscall_64+0x5b/0x160
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> The top stacktrace is showing nvme_timeout() called to handle nvme
> command timeout. timeout handler is trying to disable the controller and
> as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> to call queue callback handlers. The thread is stuck waiting for
> set->tag_list_lock as it tries to walk the queues in set->tag_list.
> 
> The lock is held by the second thread in the bottom stack which is
> waiting for one of queues to be frozen. The queue usage counter will
> drop to zero after nvme_timeout() finishes, and this will not happen
> because the thread will wait for this mutex forever.
> 
> Given that [un]quiescing queue is an operation that does not need to
> sleep, update blk_mq_[un]quiesce_tagset() to use RCU instead of taking
> set->tag_list_lock, update blk_mq_{add,del}_queue_tag_set() to use RCU
> safe list operations. Also, delete INIT_LIST_HEAD(&q->tag_set_list)
> in blk_mq_del_queue_tag_set() because we can not re-initialize it while
> the list is being traversed under RCU. The deleted queue will not be
> added/deleted to/from a tagset and it will be freed in blk_free_queue()
> after the end of RCU grace period.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> ---
>   block/blk-mq.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d626d32f6e57..05db3d20783f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>   {
>   	struct request_queue *q;
>   
> -	mutex_lock(&set->tag_list_lock);
> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
>   		if (!blk_queue_skip_tagset_quiesce(q))
>   			blk_mq_quiesce_queue_nowait(q);
>   	}
> -	mutex_unlock(&set->tag_list_lock);
> +	rcu_read_unlock();
>   
>   	blk_mq_wait_quiesce_done(set);
>   }
> @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>   {
>   	struct request_queue *q;
>   
> -	mutex_lock(&set->tag_list_lock);
> -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
>   		if (!blk_queue_skip_tagset_quiesce(q))
>   			blk_mq_unquiesce_queue(q);
>   	}
> -	mutex_unlock(&set->tag_list_lock);
> +	rcu_read_unlock();
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
>   
> @@ -4294,7 +4294,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>   	struct blk_mq_tag_set *set = q->tag_set;
>   
>   	mutex_lock(&set->tag_list_lock);
> -	list_del(&q->tag_set_list);
> +	list_del_rcu(&q->tag_set_list);
>   	if (list_is_singular(&set->tag_list)) {
>   		/* just transitioned to unshared */
>   		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> @@ -4302,7 +4302,6 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
>   		blk_mq_update_tag_set_shared(set, false);
>   	}
>   	mutex_unlock(&set->tag_list_lock);
> -	INIT_LIST_HEAD(&q->tag_set_list);
>   }
>   
I'm ever so sceptical whether we can remove the INIT_LIST_HEAD() here.
If we can it was pointless to begin with, but I somehow doubt that.
Do you have a rationale for that (except from the fact that you
are moving to RCU, and hence the 'q' pointer might not be valid then).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
