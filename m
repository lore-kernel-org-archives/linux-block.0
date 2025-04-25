Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEF74414
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563754; cv=none; b=N29xR7KK2I2WeT/mwhh5nySz9FARGsyUMh0yAKTxz9CaAdiuwPtZw0IRpexl/wTb1a5nVDmBu3tzpFipzeJiO57TKqN12J2Bii2wwv4hOiGzrDUwAZcPbgAxiKFuw9XElmOaggkDCvSkQLZYtDVd56vbI2euV8S6U7fGt/fgFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563754; c=relaxed/simple;
	bh=Ga2+lvuBCLKMvxV9OYaaDKERNOQrCRfcecK1ipL0gz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGcvXSIHhZTFZM0OuJTG/b+Jr5xI540Tn9TBxHZpyaCU2PMLHT3WMFRzcNdfY7YoB5oSn95Wqd/Dj7WSoPtbfRKz0b2h5XOkqn4+2oWWymnNd86uXVpWvvskmZdcQzNZztBIRtCHfrCAZaxsH8kHCKeHzbtaxgd46YO4118j2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EzhssI3x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wIbZMo7M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EzhssI3x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wIbZMo7M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EzhssI3x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wIbZMo7M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EzhssI3x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wIbZMo7M"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 703181F38C;
	Fri, 25 Apr 2025 06:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ns2QlPrgodkJjsZ2WN8rQW0ltQ1Nmc/LbtzDt6gs+MI=;
	b=EzhssI3xFASdg0LVCl/pK/wdhrbIkZcr6PfMyPCXdiOWh+A8yDAe0r0DfgG+qg+a4d9yoJ
	Qp4yP0ZIJU9mwnhIejwyjE6sqNb6onsA5c1U5ktFCYDgNfbWVgVeJCEaPrLz/Dgqb6rQvM
	BJ0+DSE5zZGQvT92lI3JgMOe4vyLavA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ns2QlPrgodkJjsZ2WN8rQW0ltQ1Nmc/LbtzDt6gs+MI=;
	b=wIbZMo7M5JacwvXHc3yKUC+sg3AosIe+omLItLkTFzBUkipOl8hNNmNuyIYVSTSuAio/uB
	G+kImaMDIrRH6JCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ns2QlPrgodkJjsZ2WN8rQW0ltQ1Nmc/LbtzDt6gs+MI=;
	b=EzhssI3xFASdg0LVCl/pK/wdhrbIkZcr6PfMyPCXdiOWh+A8yDAe0r0DfgG+qg+a4d9yoJ
	Qp4yP0ZIJU9mwnhIejwyjE6sqNb6onsA5c1U5ktFCYDgNfbWVgVeJCEaPrLz/Dgqb6rQvM
	BJ0+DSE5zZGQvT92lI3JgMOe4vyLavA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ns2QlPrgodkJjsZ2WN8rQW0ltQ1Nmc/LbtzDt6gs+MI=;
	b=wIbZMo7M5JacwvXHc3yKUC+sg3AosIe+omLItLkTFzBUkipOl8hNNmNuyIYVSTSuAio/uB
	G+kImaMDIrRH6JCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22AD313A79;
	Fri, 25 Apr 2025 06:49:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /HSRBmcwC2g3ZAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:49:11 +0000
Message-ID: <c3f5c8c8-5e76-4838-921b-f39dce773743@suse.de>
Date: Fri, 25 Apr 2025 08:49:10 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 19/20] block: move hctx cpuhp add/del out of queue
 freezing
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-20-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-20-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/24/25 17:21, Ming Lei wrote:
> Move hctx cpuhp add/del out of queue freezing for not connecting freeze
> lock with cpuhp locks, then lockdep warning can be avoided.
> 
> This way is safe because both needn't queue to be frozen and scheduler
> switch isn't allowed.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e08eda094ae7..add653f84797 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4964,7 +4964,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   fallback:
>   	blk_mq_update_queue_map(set);
>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> -		blk_mq_realloc_hw_ctxs(set, q);
> +		__blk_mq_realloc_hw_ctxs(set, q);
>   
>   		if (q->nr_hw_queues != set->nr_hw_queues) {
>   			int i = prev_nr_hw_queues;
> @@ -4988,6 +4988,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>   	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>   		blk_mq_sysfs_register_hctxs(q);
>   		blk_mq_debugfs_register_hctxs(q);
> +
> +		blk_mq_remove_hw_queues_cpuhp(q);
> +		blk_mq_add_hw_queues_cpuhp(q);
>   	}
>   	memalloc_noio_restore(memflags);
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
