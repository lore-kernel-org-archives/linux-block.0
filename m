Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928822;
	b=ykLfgGZgXfTosjIHSm1488Un/geBK+5xLKS4gRQrJjEdbO0J9ER1c7MuOlXJe/QxJdxH
	 palOZChmuuOx5hO2UAc82ANmiaHzcwga63begQPZZxOJX9Teha5GmPVBEfU+fciYNT+wi
	 dymVNTUnE57O/NWKYhFh3Y7KDSFxM8cyHslIoihN26c0BgBCy5raYJRzzyN3hS8kPaSdN
	 uHAqUYqceFo5r1gFhIuhhiAYAMV0d3m4ZiKMuJfToyNwSNolWBQEK4NX1FtdGezAQ/jUT
	 OmkKfGsljxIjAeuwHNPNouLWawNhJe/6QU635SvQDVguMxwJ4aC+2KItIKn9PAsRJ5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928822;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=IvY4z/d8ankXknUEQp8q8dL4c5fG5kUzOUlCZ38sG2o=;
	b=DyIlQrlPFknKvjY1bqjF3lt6SUAkklX0yoa0IMFbe4IF8HelbvXLQkpqT/DW8MebgwbJ
	 qnTx8Pj4jxopNubSSeY6AsNWIwJT47uQsCWStYQvME2AAMnYsLV8+rI4U28SiGm0wayDc
	 mQmI9uWSxC5+vMukEcyV/oI6I5sRdIe13w4xe1OswZMwrL16NyUKSRaxsCR6QHftHTacm
	 JBD3XfkQKc/SPE0trgIiQFnJ0qZBnfz/+d3bQFgOcdGY7SerDAXj88e0CBbRLrB1KxKb0
	 xm5S+sRIDJ+eMbeWabEh86fhYr7Jtg6Z1t/o05EiEiag+ugrpMlHb1i9HjzW1WwZQtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FgXRQdjx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U2sYxCQR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FgXRQdjx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U2sYxCQR;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898E9606A32F;
	Tue, 17 Nov 2026 15:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 898E9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FgXRQdjx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U2sYxCQR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FgXRQdjx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U2sYxCQR
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83FC01F792;
	Tue, 17 Nov 2026 15:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794928819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvY4z/d8ankXknUEQp8q8dL4c5fG5kUzOUlCZ38sG2o=;
	b=FgXRQdjxDK/70qLkaymzD3BGFVAjKeB7egnlPpIU2rO6ihXPFnbTIvW7SAyM3yAKHNLEdy
	tw8wjBed5R4/9MZ3Uw9hQybNIMXhbqcnVk1btMULsMtD8IRp412H4sYOYKI68GMbj1YOV/
	Bex7hS1CcsaQRXOTjrpfhK32r3sqxkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794928819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvY4z/d8ankXknUEQp8q8dL4c5fG5kUzOUlCZ38sG2o=;
	b=U2sYxCQRitR0iLsUdBJ+BP0PaaYpRZvtyABt3f1bhA5UwLuDMqBaY/vd+Qjs1lYdQNDm4C
	/5Ld7p8cSc0plxAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794928819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvY4z/d8ankXknUEQp8q8dL4c5fG5kUzOUlCZ38sG2o=;
	b=FgXRQdjxDK/70qLkaymzD3BGFVAjKeB7egnlPpIU2rO6ihXPFnbTIvW7SAyM3yAKHNLEdy
	tw8wjBed5R4/9MZ3Uw9hQybNIMXhbqcnVk1btMULsMtD8IRp412H4sYOYKI68GMbj1YOV/
	Bex7hS1CcsaQRXOTjrpfhK32r3sqxkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794928819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvY4z/d8ankXknUEQp8q8dL4c5fG5kUzOUlCZ38sG2o=;
	b=U2sYxCQRitR0iLsUdBJ+BP0PaaYpRZvtyABt3f1bhA5UwLuDMqBaY/vd+Qjs1lYdQNDm4C
	/5Ld7p8cSc0plxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE1121334C;
	Tue, 17 Nov 2026 15:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C5rJFrJw/GogcgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Nov 2026 15:20:18 +0000
Message-ID: <e50ff1ab-ff60-449e-9a8e-acfdbf157449@suse.de>
Date: Tue, 17 Nov 2026 16:20:17 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] block: return early when the elevator doesn't
 change
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <dlemoal@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
 Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20261116-bug-block-elevator-unchanged-v3-0-cb4dda2dadf4@linux.dev>
 <20261116-bug-block-elevator-unchanged-v3-2-cb4dda2dadf4@linux.dev>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261116-bug-block-elevator-unchanged-v3-2-cb4dda2dadf4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,kernel.dk,kernel.org,gmail.com,linux.ibm.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,linux.dev:email,lst.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,linux.dev:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.79

On 11/17/26 3:56 AM, Qiliang Yuan wrote:
> Writing the scheduler a queue already uses to queue/scheduler used to
> be a no-op. elevator_change() now only checks for an unchanged elevator
> after freezing the queue, and doesn't treat "none" on a queue without
> an elevator as unchanged at all, so that case also quiesces the queue
> in elevator_switch() and resets nr_requests.
> 
> Every such write therefore drains in-flight I/O and waits for an RCU
> grace period. udev rules and tuning tools that set the scheduler
> unconditionally stall I/O on live disks each time they run.
> 
> Check under elevator_lock whether anything would change before
> allocating scheduler resources and freezing the queue. The check can
> race with another elevator change, which at worst leads to a redundant
> switch, so keep the one done under the freeze as well.
> 
> Writing the current scheduler to queue/scheduler of a null_blk disk 20
> times takes (median):
> 
>    operation                 before (ms)  after (ms)  change
>    none -> none                     9.11        0.08    -99%
>    mq-deadline -> mq-deadline       9.05        0.08    -99%
> 
> 4k random reads at queue depth 1 for 10 seconds, while "none" is
> written to queue/scheduler every 50 ms:
> 
>    metric             before  after  change
>    IOPS               340562 390392    +15%
>    max latency (us)    16302   1224    -92%
> 
> Fixes: af2814149883e ("block: freeze the queue in queue_attr_store")
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/elevator.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 9d9b2e84a1288..549cf51543a8b 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -654,10 +654,24 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>   {
>   	unsigned int memflags;
>   	struct blk_mq_tag_set *set = q->tag_set;
> +	bool unchanged;
>   	int ret = 0;
>   
>   	lockdep_assert_held(&set->update_nr_hwq_lock);
>   
> +	/*
> +	 * Skip freezing the queue if nothing would change. This can race with
> +	 * another elevator change, which at worst leads to a redundant switch.
> +	 */
> +	mutex_lock(&q->elevator_lock);
> +	if (q->elevator)
> +		unchanged = elevator_match(q->elevator->type, ctx->name);
> +	else
> +		unchanged = !strncmp(ctx->name, "none", 4);
> +	mutex_unlock(&q->elevator_lock);
> +	if (unchanged)
> +		return 0;
> +
>   	if (strncmp(ctx->name, "none", 4)) {
>   		ret = blk_mq_alloc_sched_res(q, ctx->type, &ctx->res,
>   				set->nr_hw_queues);
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
