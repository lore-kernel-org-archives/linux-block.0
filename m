Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFA1940A2
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183535; cv=none; b=au3M6MsX8fo8XpZUgWYazTmDIRW9dRcyDPtFJLPsUOj8FtZDCdFNQR3W6+/eOVCkZR1sSlqsFhqzroKX333GfDAkea8Olhk1o5lepWFeK2IUpAJ/z2B58ny8qDf/QCWS+qCIWA1qXPh4YkH1kGzu4empclrjltyRik8b1oOmKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183535; c=relaxed/simple;
	bh=GaAPAoxFyT1yaqVD/9M9itADrgURdDszy8hUqEiuqjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxP4scIHqGQSvXOucgwRKTbbw9SjvvEbSEtoVXKT8iIYDx851ow0pFF+bCll2s172+ZrmQ8Zoo4diNxVdMmWI/czJqTavcUExLRegmDNMutT3t37wCByhbToFVLDZynSLKT7xtVflFvholPdfbIz+lzKUJCMIKrO0sbTYZYhZGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nhFzSrKY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TZFoJwu7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nhFzSrKY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TZFoJwu7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nhFzSrKY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TZFoJwu7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nhFzSrKY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TZFoJwu7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 461DD21ACE;
	Tue, 22 Jul 2025 11:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753183531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QepW2ApxPOC/g6UixHgxVHHf9bfowcvjdnOPMi/H0Tc=;
	b=nhFzSrKYOsUofNB5TdMDfgS08iuq/tDQedmsXleJB2eUz+LJ4urp+QgUUxzi6YQ7kNOZYp
	/DCCGVvG6eoOlqI2BPkCBQRrllE27nlNeZa1IjSxm+be7gycKECLHxpbbwzCZhlu8mEOz9
	7mj9USj63T5m5b91cRX8ZitrIN3wAck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753183531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QepW2ApxPOC/g6UixHgxVHHf9bfowcvjdnOPMi/H0Tc=;
	b=TZFoJwu7J5wJotPrws/x6PsZcr1dA/ZmJIjqVOuHOW605FL/RrdTy9spyZskNvOw0rmWm8
	EwNtD3GLH26YsCDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753183531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QepW2ApxPOC/g6UixHgxVHHf9bfowcvjdnOPMi/H0Tc=;
	b=nhFzSrKYOsUofNB5TdMDfgS08iuq/tDQedmsXleJB2eUz+LJ4urp+QgUUxzi6YQ7kNOZYp
	/DCCGVvG6eoOlqI2BPkCBQRrllE27nlNeZa1IjSxm+be7gycKECLHxpbbwzCZhlu8mEOz9
	7mj9USj63T5m5b91cRX8ZitrIN3wAck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753183531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QepW2ApxPOC/g6UixHgxVHHf9bfowcvjdnOPMi/H0Tc=;
	b=TZFoJwu7J5wJotPrws/x6PsZcr1dA/ZmJIjqVOuHOW605FL/RrdTy9spyZskNvOw0rmWm8
	EwNtD3GLH26YsCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2318513A32;
	Tue, 22 Jul 2025 11:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xO2pByt1f2iCRQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Jul 2025 11:25:31 +0000
Message-ID: <51dcbafe-d0d5-4635-8aca-a75a8478e882@suse.de>
Date: Tue, 22 Jul 2025 13:25:30 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: avoid possible overflow for chunk_sectors
 check in blk_stack_limits()
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
 <20250722102620.3208878-2-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250722102620.3208878-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/22/25 12:26, John Garry wrote:
> In blk_stack_limits(), we check that the t->chunk_sectors value is a
> multiple of the t->physical_block_size value.
> 
> However, by finding the chunk_sectors value in bytes, we may overflow
> the unsigned int which holds chunk_sectors, so change the check to be
> based on sectors.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   block/blk-settings.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index a6ac293f47e3..fa53a330f9b9 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -795,7 +795,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>   	}
>   
>   	/* chunk_sectors a multiple of the physical block size? */
> -	if ((t->chunk_sectors << 9) & (t->physical_block_size - 1)) {
> +	if (t->chunk_sectors % (t->physical_block_size >> SECTOR_SHIFT)) {
>   		t->chunk_sectors = 0;
>   		t->flags |= BLK_FLAG_MISALIGNED;
>   		ret = -1;

<Silent round of applause; someone paid attention to the
numerical mathematics course>

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
