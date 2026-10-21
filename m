Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581043;
	b=0wkRd7IucaMOQGxKi/wPKC5nEaENHWz2KbaPqIdl/HC5k2uWXI4BxxVKq8SslxMYPxRs
	 6Wx+RkLocBJWTPcypjyZzGuQU5Be9tFfQCVDwfU6jTlvPo6u42e3oHwRACvsdCpd4TyUt
	 rCafvqZUcK3DKUI+GX9uHoxrG4yxA6PGR8SZh7QEXQ/Nr/Lq79ZcYIvEhpnsgNiTgmyZG
	 0wQhPONXG/zgzAT6mqItec0Jv/xOUmGLvPAC21fN7HJaR8X+my1IfxwXEYUxTBdbxWtXS
	 Aynubq1+/pYmMNYoR+yb4voeYBEgGSedeIDoxqVJQhfHni71t4wYTA8/h0iwBAO3AAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581043;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=UCkfmHOiQxhQajlRY6RXrRx6cpO82id1YJHUSOoswrs=;
	b=ZsS09WWJYIm5QBJRJTxIOYzH6dZG1rfWmIZh5WApMr67CeOgeBEgmpkQSSOKi5yC32G8
	 ykUtPmUNk23PHRSR+yUuQWXAVRydRBPiE1dePO3VTopVFkIkYR/5RAcgQUpDfgW63hGp5
	 Q5eEu3bGMJrLMFSL+BTXge5LSTIffvj5byGyRowS0oGQO/n/bLkMxEYDN+9PKD1fwWnvR
	 9G/LsBHbXGBAdMHFRrXj3sItiRTwy0OCuN1xeOBRNG0gbNhFDTh7kG21dtodwiqgEvUiH
	 ZUt5DWK63dL1ikgZNWlc8vrbCt5gcRkiy2IS3qaBAVnl3mxW/heM0bUA1C6HMCz0w9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rD6+WzcF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6ekZ5gws;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rD6+WzcF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6ekZ5gws;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317F606A31B;
	Wed, 21 Oct 2026 11:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4317F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rD6+WzcF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6ekZ5gws;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rD6+WzcF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6ekZ5gws
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7951D21DE1;
	Wed, 21 Oct 2026 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCkfmHOiQxhQajlRY6RXrRx6cpO82id1YJHUSOoswrs=;
	b=rD6+WzcF+YZIhOklmrjuoOOhngj24XwaPJIobh9u+JBhhhbeB/7UlGOB19C2VZNh+8unzh
	gU9wLuLmuSE8uvDc/jKTYNsPwnmAyS0A1qyH5Zln4FuQUYB9clHFdPcft6GrBWz5k+Y1yM
	arA2Fd8TQWiyT0dmYQdI3kABnSXqspo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCkfmHOiQxhQajlRY6RXrRx6cpO82id1YJHUSOoswrs=;
	b=6ekZ5gwsivf9G+TIG9GapkV6C+0hjmwaZx1H/6wajgwDvu77eR8eQYkaKhLvl1E1iAAxqk
	LkRDSBn3jew6gkDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792581041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCkfmHOiQxhQajlRY6RXrRx6cpO82id1YJHUSOoswrs=;
	b=rD6+WzcF+YZIhOklmrjuoOOhngj24XwaPJIobh9u+JBhhhbeB/7UlGOB19C2VZNh+8unzh
	gU9wLuLmuSE8uvDc/jKTYNsPwnmAyS0A1qyH5Zln4FuQUYB9clHFdPcft6GrBWz5k+Y1yM
	arA2Fd8TQWiyT0dmYQdI3kABnSXqspo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792581041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCkfmHOiQxhQajlRY6RXrRx6cpO82id1YJHUSOoswrs=;
	b=6ekZ5gwsivf9G+TIG9GapkV6C+0hjmwaZx1H/6wajgwDvu77eR8eQYkaKhLvl1E1iAAxqk
	LkRDSBn3jew6gkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C3CE134A5;
	Wed, 21 Oct 2026 11:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7JaSOrCd2GqvfwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Oct 2026 11:10:41 +0000
Message-ID: <62c3831f-f4e5-484e-b32a-f83ed1316d68@suse.de>
Date: Wed, 21 Oct 2026 13:10:40 +0200
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
Subject: Re: [PATCH 2/5] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Surabhi Gogte <sgogte@purestorage.com>,
 Hannes Reinecke <hare@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Aaron Tomlin
 <atomlin@atomlin.com>, Maurizio Lombardi <mlombard@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
 <20261014-nvme-fabrics-isolcpu-v1-2-355156be27b2@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-2-355156be27b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 10/14/26 9:46 AM, Daniel Wagner wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> Since commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> isolated CPUs") isolated CPUs are removed from hctx->cpumask.  That
> commit assumed the mask is only used for kworker placement and CPU
> offline handling, but blk_mq_alloc_request_hctx uses it to pick the
> software context of the request.  If only isolated CPUs are mapped to a
> hardware context, the mask is empty and blk_mq_alloc_request_hctx fails
> with -EXDEV, although the isolated CPUs still submit I/O to it.
> 
> The nvme fabrics transports allocate the Connect command for every I/O
> queue this way, so connecting a controller fails with isolcpus=domain
> or an isolated cpuset partition as soon as a hardware context only has
> isolated CPUs.
> 
> Passthrough requests are inserted directly into hctx->dispatch, so
> their software context only selects the CPU the completion runs on and
> the hint for freeing the tag.  Use the software context of an online CPU
> which is neither isolated from the scheduler domains nor from managed
> interrupts for them.  Other requests and inactive hardware contexts
> still fail.
> 
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   block/blk-mq.c | 37 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a26a11c73ee3..79fb08400c48 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -697,6 +697,25 @@ struct request *blk_mq_alloc_request(struct request_queue *q, blk_opf_t opf,
>   }
>   EXPORT_SYMBOL(blk_mq_alloc_request);
>   
> +/*
> + * Return an online CPU which is neither isolated from the scheduler domains
> + * nor from managed interrupts, or nr_cpu_ids if there is none.
> + */
> +static unsigned int blk_mq_housekeeping_cpu(void)
> +{
> +	unsigned int cpu;
> +
> +	rcu_read_lock();
> +	for_each_online_cpu(cpu) {
> +		if (!cpu_is_isolated(cpu) &&
> +		    housekeeping_test_cpu(cpu, HK_TYPE_MANAGED_IRQ))
> +			break;
> +	}
> +	rcu_read_unlock();
> +
> +	return cpu;
> +}
> +
>   struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   	blk_opf_t opf, blk_mq_req_flags_t flags, unsigned int hctx_idx)
>   {
> @@ -747,8 +766,22 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   	if (!blk_mq_hw_queue_mapped(data.hctx))
>   		goto out_queue_exit;
>   	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> -	if (cpu >= nr_cpu_ids)
> -		goto out_queue_exit;
> +	if (cpu >= nr_cpu_ids) {
> +		/*
> +		 * Isolated CPUs are not part of hctx->cpumask, so it can be
> +		 * empty although online CPUs are mapped to this hardware
> +		 * context.  Passthrough requests are inserted directly into
> +		 * hctx->dispatch, so use the software context of a
> +		 * housekeeping CPU for them.  Inactive hardware contexts have
> +		 * no online CPU left.
> +		 */
> +		if (!blk_op_is_passthrough(opf) ||
> +		    test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state))
> +			goto out_queue_exit;
> +		cpu = blk_mq_housekeeping_cpu();
> +		if (cpu >= nr_cpu_ids)
> +			goto out_queue_exit;
> +	}
>   	data.ctx = __blk_mq_get_ctx(q, cpu);
>   
>   	if (q->elevator)
> 
Hmm. I wonder.
While the patch looks correct, the reasoning for this patch is slightly 
confusing: 'nvme connect' surely tries to send a 'connect' command on
every queue, and every queue maps to a cpu (-set).
But why do we execute a 'connect' sqe on an isolated CPU? I thought
we would exclude them when connecting the queues?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
