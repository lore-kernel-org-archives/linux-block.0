Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA3131AF1F
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203522; cv=none; b=qKEYZxFsOySzknXDWPTFJe0mlBq7wuU3904wRQE+89uPS3JSU4/b8E60rwpmBbBS6NjAToY+E8W0AL5dkZzS/XAT6NcQ0kq7xP/guS0ZQjUl/bXZ5u2socdZQZBjewFCbU39Ec9AGbExeMdLx56bXschLDewWKQEQRInmWWazeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203522; c=relaxed/simple;
	bh=H+IpCN//ZhruPmdeGmXIuE5kFeshuaTaW3dBaFDy7Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BKXpj8TFficzNy4lAxnQA+6UpPfIrtRE2aMldqIwlbE0QGSzKaZptZq/MBuZPkAcdBm04MTegMntIaz6vjJWkyLUigcHfDOJGqf1gpraBAss60zsB5TmOluISSaSfhG1v2McTWsvty7Q+knNaffpLZYIAJFN3WL8GAQ7Wftly4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jPQKN3gI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zuYZknIF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jPQKN3gI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zuYZknIF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jPQKN3gI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zuYZknIF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jPQKN3gI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zuYZknIF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83FB95BD35;
	Mon, 12 Jan 2026 07:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLkSW3P+CSxBV6B5mDZrkjMzoFR/rXWJ529zoJGCNC0=;
	b=jPQKN3gIEXhOR0s8hb6vaalpfnd43SWp3WQcAXyBJppYWzXvofJHqlfkKNB14nd1+3IQnV
	jC6rpzWXXCnwgcB7u8n2x4O4+33tQY7Qlgc2Uw1YrJglqiPe9Z6Ansy0umQpGSFqZaX2mi
	u9Hr6Lc+741WlLbRukH2gyBHIlwztpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLkSW3P+CSxBV6B5mDZrkjMzoFR/rXWJ529zoJGCNC0=;
	b=zuYZknIF2pGds73nwxLxLXXqgea3Bwl7CfxnwAD24xac2IbeExAptFKFaxFeTs22DRfb8o
	1KHBnOZWoQM3TuBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jPQKN3gI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zuYZknIF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLkSW3P+CSxBV6B5mDZrkjMzoFR/rXWJ529zoJGCNC0=;
	b=jPQKN3gIEXhOR0s8hb6vaalpfnd43SWp3WQcAXyBJppYWzXvofJHqlfkKNB14nd1+3IQnV
	jC6rpzWXXCnwgcB7u8n2x4O4+33tQY7Qlgc2Uw1YrJglqiPe9Z6Ansy0umQpGSFqZaX2mi
	u9Hr6Lc+741WlLbRukH2gyBHIlwztpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLkSW3P+CSxBV6B5mDZrkjMzoFR/rXWJ529zoJGCNC0=;
	b=zuYZknIF2pGds73nwxLxLXXqgea3Bwl7CfxnwAD24xac2IbeExAptFKFaxFeTs22DRfb8o
	1KHBnOZWoQM3TuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CACE3EA63;
	Mon, 12 Jan 2026 07:38:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TSYWEf6kZGneTgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Jan 2026 07:38:38 +0000
Message-ID: <b6110ffc-f999-49a1-8a7e-ce51af51e211@suse.de>
Date: Mon, 12 Jan 2026 08:38:37 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/8] blk-wbt: fix possible deadlock to nest
 pcpu_alloc_mutex under q_usage_counter
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
References: <20260109065230.653281-1-yukuai@fnnas.com>
 <20260109065230.653281-3-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260109065230.653281-3-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 83FB95BD35
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/9/26 07:52, Yu Kuai wrote:
> If wbt is disabled by default and user configures wbt by sysfs, queue
> will be frozen first and then pcpu_alloc_mutex will be held in
> blk_stat_alloc_callback().
> 
> Fix this problem by allocating memory first before queue frozen.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-wbt.c | 108 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 63 insertions(+), 45 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index abc2190689bb..9bef71ec645d 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -93,7 +93,7 @@ struct rq_wb {
>   	struct rq_depth rq_depth;
>   };
>   
> -static int wbt_init(struct gendisk *disk);
> +static int wbt_init(struct gendisk *disk, struct rq_wb *rwb);
>   
>   static inline struct rq_wb *RQWB(struct rq_qos *rqos)
>   {
> @@ -698,6 +698,41 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
>   	}
>   }
>   
> +static int wbt_data_dir(const struct request *rq)
> +{
> +	const enum req_op op = req_op(rq);
> +
> +	if (op == REQ_OP_READ)
> +		return READ;
> +	else if (op_is_write(op))
> +		return WRITE;
> +
> +	/* don't account */
> +	return -1;
> +}
> +
> +static struct rq_wb *wbt_alloc(void)
> +{
> +	struct rq_wb *rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
> +> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e0a70d26972b..a580688c3ad5 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -636,11 +636,8 @@ static ssize_t queue_wb_lat_show(struct gendisk *disk, char *page)
>   static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
>   				  size_t count)
>   {
> -	struct request_queue *q = disk->queue;
> -	struct rq_qos *rqos;
>   	ssize_t ret;
>   	s64 val;
> -	unsigned int memflags;
>   
>   	ret = queue_var_store64(&val, page);
>   	if (ret < 0)
> @@ -648,40 +645,8 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
>   	if (val < -1)
>   		return -EINVAL;
>   
> -	/*
> -	 * Ensure that the queue is idled, in case the latency update
> -	 * ends up either enabling or disabling wbt completely. We can't
> -	 * have IO inflight if that happens.
> -	 */
> -	memflags = blk_mq_freeze_queue(q);
> -
> -	rqos = wbt_rq_qos(q);
> -	if (!rqos) {
> -		ret = wbt_init(disk);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	ret = count;
> -	if (val == -1)
> -		val = wbt_default_latency_nsec(q);
> -	else if (val >= 0)
> -		val *= 1000ULL;
> -
> -	if (wbt_get_min_lat(q) == val)
> -		goto out;
> -
> -	blk_mq_quiesce_queue(q);
> -
> -	mutex_lock(&disk->rqos_state_mutex);
> -	wbt_set_min_lat(q, val);
> -	mutex_unlock(&disk->rqos_state_mutex);
> -
> -	blk_mq_unquiesce_queue(q);
> -out:
> -	blk_mq_unfreeze_queue(q, memflags);
> -
> -	return ret;
> +	ret = wbt_set_lat(disk, val);
> +	return ret ? ret : count;
>   }
>   
>   QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 0974875f77bd..abc2190689bb 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -93,6 +93,8 @@ struct rq_wb {
>   	struct rq_depth rq_depth;
>   };
>   
> +static int wbt_init(struct gendisk *disk);
> +
>   static inline struct rq_wb *RQWB(struct rq_qos *rqos)
>   {
>   	return container_of(rqos, struct rq_wb, rqos);
> @@ -506,7 +508,7 @@ u64 wbt_get_min_lat(struct request_queue *q)
>   	return RQWB(rqos)->min_lat_nsec;
>   }
>   
> -void wbt_set_min_lat(struct request_queue *q, u64 val)
> +static void wbt_set_min_lat(struct request_queue *q, u64 val)
>   {
>   	struct rq_qos *rqos = wbt_rq_qos(q);
>   	if (!rqos)
> @@ -741,7 +743,7 @@ void wbt_init_enable_default(struct gendisk *disk)
>   		WARN_ON_ONCE(wbt_init(disk));
>   }
>   
> -u64 wbt_default_latency_nsec(struct request_queue *q)
> +static u64 wbt_default_latency_nsec(struct request_queue *q)
>   {
>   	/*
>   	 * We default to 2msec for non-rotational storage, and 75msec
> @@ -902,7 +904,7 @@ static const struct rq_qos_ops wbt_rqos_ops = {
>   #endif
>   };
>   
> -int wbt_init(struct gendisk *disk)
> +static int wbt_init(struct gendisk *disk)
>   {
>   	struct request_queue *q = disk->queue;
>   	struct rq_wb *rwb;
> @@ -949,3 +951,45 @@ int wbt_init(struct gendisk *disk)
>   	return ret;
>   
>   }
> +
> +int wbt_set_lat(struct gendisk *disk, s64 val)
> +{
> +	struct request_queue *q = disk->queue;
> +	unsigned int memflags;
> +	struct rq_qos *rqos;
> +	int ret = 0;
> +
> +	/*
> +	 * Ensure that the queue is idled, in case the latency update
> +	 * ends up either enabling or disabling wbt completely. We can't
> +	 * have IO inflight if that happens.
> +	 */
> +	memflags = blk_mq_freeze_queue(q);
> +
> +	rqos = wbt_rq_qos(q);
> +	if (!rqos) {

Isn't 'if (!wbt_rq_qos(q))' sufficient here?
'rqos' is never used, and might even trigger an 'unused variable'
compiler warning ...

> +		ret = wbt_init(disk);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (val == -1)
> +		val = wbt_default_latency_nsec(q);
> +	else if (val >= 0)
> +		val *= 1000ULL;
> +
> +	if (wbt_get_min_lat(q) == val)
> +		goto out;
> +
> +	blk_mq_quiesce_queue(q);
> +
> +	mutex_lock(&disk->rqos_state_mutex);
> +	wbt_set_min_lat(q, val);
> +	mutex_unlock(&disk->rqos_state_mutex);
> +
> +	blk_mq_unquiesce_queue(q);
> +out:
> +	blk_mq_unfreeze_queue(q, memflags);
> +
> +	return ret;
> +}
> diff --git a/block/blk-wbt.h b/block/blk-wbt.h
> index 925f22475738..6e39da17218b 100644
> --- a/block/blk-wbt.h
> +++ b/block/blk-wbt.h
> @@ -4,16 +4,13 @@
>   
>   #ifdef CONFIG_BLK_WBT
>   
> -int wbt_init(struct gendisk *disk);
>   void wbt_init_enable_default(struct gendisk *disk);
>   void wbt_disable_default(struct gendisk *disk);
>   void wbt_enable_default(struct gendisk *disk);
>   
>   u64 wbt_get_min_lat(struct request_queue *q);
> -void wbt_set_min_lat(struct request_queue *q, u64 val);
> -bool wbt_disabled(struct request_queue *);
> -
> -u64 wbt_default_latency_nsec(struct request_queue *);
> +bool wbt_disabled(struct request_queue *q);
> +int wbt_set_lat(struct gendisk *disk, s64 val);
>   
>   #else
>   
> +	if (!rwb)
> +		return NULL;
> +
> +	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, wbt_data_dir, 2, rwb);
> +	if (!rwb->cb) {
> +		kfree(rwb);
> +		return NULL;
> +	}
> +
> +	return rwb;
> +}
> +
> +static void wbt_free(struct rq_wb *rwb)
> +{
> +	blk_stat_free_callback(rwb->cb);
> +	kfree(rwb);
> +}
> +
>   /*
>    * Enable wbt if defaults are configured that way
>    */
> @@ -739,8 +774,17 @@ EXPORT_SYMBOL_GPL(wbt_enable_default);
>   
>   void wbt_init_enable_default(struct gendisk *disk)
>   {
> -	if (__wbt_enable_default(disk))
> -		WARN_ON_ONCE(wbt_init(disk));
> +	struct rq_wb *rwb;
> +
> +	if (!__wbt_enable_default(disk))
> +		return;
> +
> +	rwb = wbt_alloc();
> +	if (WARN_ON_ONCE(!rwb))
> +		return;
> +
> +	if (WARN_ON_ONCE(wbt_init(disk, rwb)))
> +		wbt_free(rwb);
>   }
>   
>   static u64 wbt_default_latency_nsec(struct request_queue *q)
> @@ -755,19 +799,6 @@ static u64 wbt_default_latency_nsec(struct request_queue *q)
>   		return 75000000ULL;
>   }
>   
> -static int wbt_data_dir(const struct request *rq)
> -{
> -	const enum req_op op = req_op(rq);
> -
> -	if (op == REQ_OP_READ)
> -		return READ;
> -	else if (op_is_write(op))
> -		return WRITE;
> -
> -	/* don't account */
> -	return -1;
> -}
> -
>   static void wbt_queue_depth_changed(struct rq_qos *rqos)
>   {
>   	RQWB(rqos)->rq_depth.queue_depth = blk_queue_depth(rqos->disk->queue);
> @@ -779,8 +810,7 @@ static void wbt_exit(struct rq_qos *rqos)
>   	struct rq_wb *rwb = RQWB(rqos);
>   
>   	blk_stat_remove_callback(rqos->disk->queue, rwb->cb);
> -	blk_stat_free_callback(rwb->cb);
> -	kfree(rwb);
> +	wbt_free(rwb);
>   }
>   
>   /*
> @@ -904,22 +934,11 @@ static const struct rq_qos_ops wbt_rqos_ops = {
>   #endif
>   };
>   
> -static int wbt_init(struct gendisk *disk)
> +static int wbt_init(struct gendisk *disk, struct rq_wb *rwb)
>   {
>   	struct request_queue *q = disk->queue;
> -	struct rq_wb *rwb;
> -	int i;
>   	int ret;
> -
> -	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
> -	if (!rwb)
> -		return -ENOMEM;
> -
> -	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, wbt_data_dir, 2, rwb);
> -	if (!rwb->cb) {
> -		kfree(rwb);
> -		return -ENOMEM;
> -	}
> +	int i;
>   
>   	for (i = 0; i < WBT_NUM_RWQ; i++)
>   		rq_wait_init(&rwb->rq_wait[i]);
> @@ -939,38 +958,38 @@ static int wbt_init(struct gendisk *disk)
>   	ret = rq_qos_add(&rwb->rqos, disk, RQ_QOS_WBT, &wbt_rqos_ops);
>   	mutex_unlock(&q->rq_qos_mutex);
>   	if (ret)
> -		goto err_free;
> +		return ret;
>   
>   	blk_stat_add_callback(q, rwb->cb);
> -
>   	return 0;
> -
> -err_free:
> -	blk_stat_free_callback(rwb->cb);
> -	kfree(rwb);
> -	return ret;
> -
>   }
>   
>   int wbt_set_lat(struct gendisk *disk, s64 val)
>   {
>   	struct request_queue *q = disk->queue;
> +	struct rq_qos *rqos = wbt_rq_qos(q);
> +	struct rq_wb *rwb = NULL;
>   	unsigned int memflags;
> -	struct rq_qos *rqos;
>   	int ret = 0;
>   
> +	if (!rqos) {
> +		rwb = wbt_alloc();

Similar here...

> +		if (!rwb)
> +			return -ENOMEM;
> +	}
> +
>   	/*
>   	 * Ensure that the queue is idled, in case the latency update
>   	 * ends up either enabling or disabling wbt completely. We can't
>   	 * have IO inflight if that happens.
>   	 */
>   	memflags = blk_mq_freeze_queue(q);
> -
> -	rqos = wbt_rq_qos(q);
>   	if (!rqos) {

Huh? Am I reading this correctly that we have
two calls for 'if (!rqos)' after this change?
That looks odd ...

> -		ret = wbt_init(disk);
> -		if (ret)
> +		ret = wbt_init(disk, rwb);
> +		if (ret) {
> +			wbt_free(rwb);
>   			goto out;
> +		}
>   	}
>   
>   	if (val == -1)
> @@ -990,6 +1009,5 @@ int wbt_set_lat(struct gendisk *disk, s64 val)
>   	blk_mq_unquiesce_queue(q);
>   out:
>   	blk_mq_unfreeze_queue(q, memflags);
> -
>   	return ret;
>   }

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
