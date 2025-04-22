Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767CB1EA7DB
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301606; cv=none; b=f3p080ezJCB49JLixXHqSuJFjijbexqE5CO7BO5WP+wExXg3sEQ/PCVbWnpxJ2YME/oae/5cv/60UTuM+sd9pRi1dGvL+Vpxn2FZUWDBe6DGwOx1qBjDIEOuj0GFbt50aGrarS4fEnAA+ySR/DwyaDpEVTI+0+JtAUJyxbloJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301606; c=relaxed/simple;
	bh=INh5Fo3iC/g8fmYvIlTjBFeq0Nx2A2IsrrLG0E7RvwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYJ5x2sXrLHWVxJVYNnEqb89PJEiPDN6AvXxIKfg04G5Z71qnBGRk8a0l4D2K9uMqzt678zpJSxho/YiFflMqbDkJIiReuXckZbKGIZ4WLC2vtrOwUe8yyL07Lydd2Qwi8McMjp8S4jJuPLy2F3jaezWvuuxeUb5yFkZFHziso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cvA+KFPg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rWmXUQIV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cvA+KFPg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rWmXUQIV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cvA+KFPg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rWmXUQIV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cvA+KFPg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rWmXUQIV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75C971F7C1;
	Tue, 22 Apr 2025 06:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745301602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rldJUOFD56mKXe1imA4+D2d8/k8qp9Z90sLcvo9pvnk=;
	b=cvA+KFPgF93t0fk1zO14WZ0CV1yhHOb9AJjLsayLm7uePVac3CVDAEn+itcwxiRdnaRYUy
	iJ0/8AFFvyWZf80v5p/mw9BFToeX2QPsczEpNbIp3mb/7EUXzXClYXiu3qoRBBssHfKLPx
	O7jeGOgGRpaFt/tGmCoTQ68nU3QQvYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745301602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rldJUOFD56mKXe1imA4+D2d8/k8qp9Z90sLcvo9pvnk=;
	b=rWmXUQIVHvOpMGWUaUuWjPq2AAxKdW9UvKwVPBWyocb+1zLUDE9SBaVN02+W7y0Te+b+9p
	YoehfMbDbJZwoYBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745301602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rldJUOFD56mKXe1imA4+D2d8/k8qp9Z90sLcvo9pvnk=;
	b=cvA+KFPgF93t0fk1zO14WZ0CV1yhHOb9AJjLsayLm7uePVac3CVDAEn+itcwxiRdnaRYUy
	iJ0/8AFFvyWZf80v5p/mw9BFToeX2QPsczEpNbIp3mb/7EUXzXClYXiu3qoRBBssHfKLPx
	O7jeGOgGRpaFt/tGmCoTQ68nU3QQvYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745301602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rldJUOFD56mKXe1imA4+D2d8/k8qp9Z90sLcvo9pvnk=;
	b=rWmXUQIVHvOpMGWUaUuWjPq2AAxKdW9UvKwVPBWyocb+1zLUDE9SBaVN02+W7y0Te+b+9p
	YoehfMbDbJZwoYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EDB4139D5;
	Tue, 22 Apr 2025 06:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id madCCWIwB2hbIQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Apr 2025 06:00:02 +0000
Message-ID: <1a215fc4-562c-4c26-aeb0-a7aeb304cb80@suse.de>
Date: Tue, 22 Apr 2025 08:00:01 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/20] block: move blk_mq_add_queue_tag_set() after
 blk_mq_map_swqueue()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-2-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250418163708.442085-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/18/25 18:36, Ming Lei wrote:
> Move blk_mq_add_queue_tag_set() after blk_mq_map_swqueue(), and publish
> this request queue to tagset after everything is setup.
> 
> This way is safe because BLK_MQ_F_TAG_QUEUE_SHARED isn't used by
> blk_mq_map_swqueue(), and this flag is mainly checked in fast IO code
> path.
> 
> Prepare for removing ->elevator_lock from blk_mq_map_swqueue() which
> is supposed to be called when elevator switch isn't possible.
> 
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-block/567cb7ab-23d6-4cee-a915-c8cdac903ddd@linux.ibm.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e0fe12f1320f..7cda919fafba 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4561,8 +4561,8 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>   	q->nr_requests = set->queue_depth;
>   
>   	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
> -	blk_mq_add_queue_tag_set(set, q);
>   	blk_mq_map_swqueue(q);
> +	blk_mq_add_queue_tag_set(set, q);
>   	return 0;
>   
>   err_hctxs:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
