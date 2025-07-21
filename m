Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5221F1302
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082214; cv=none; b=aEbg9BcmrU0BnL8mj2cYJR+6/oDNhQzFdW1siyg0EEMJZxvmV3OKbYNs1ED+72JqP5JVzSw6ZYz/NmJ57NvnYNNKoDPUXGNiIxjpSWRVpgs4A1DdywU6bjRSFObLH8NBPRPlxHd6OnWV6Rz78/ZZIa2b27/uzGdoQmg8CYebJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082214; c=relaxed/simple;
	bh=arNOAMBg/yjQ9okla+E98JHbiCPQxiWigfWHUCC11+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESNA0nOKaj8L+TKObYl6Hau0EDMpvPu8VDnB0jqB9HuZ/xKqaDS4sZJSd37R9zEVeN7PB5NapYmzXF+aodmDfmVrCWmefz/PZvIkv5SlM/eEl/ArVwbLeTucckbDbN/NamgtKhN1Dc9PQORZf8Mhlo3IMQ3lnlDYw0PbPJEn9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JnFHU4A2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YWWuchj6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JnFHU4A2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YWWuchj6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JnFHU4A2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YWWuchj6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JnFHU4A2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YWWuchj6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDE52219D8;
	Mon, 21 Jul 2025 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753082211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LSKmvCUBIRnbdkU3d6FhNBLPxqYepeJ3GDDapuIzLw=;
	b=JnFHU4A2+BnlJt99f2L7iAE9IGr4Fl5mqL52UrY6Z21vVjpDkXPdbTXaZmFKS15FDpg9Co
	s5qzYdAEPkcDuquvXCYJDM9cvwkrlGeIuusBpx6yTBzlXOIWbnfW41Xbc/5192mn8dDUy7
	7G+8j4zecS2Sqn0kOIWh5s4Xt84StF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753082211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LSKmvCUBIRnbdkU3d6FhNBLPxqYepeJ3GDDapuIzLw=;
	b=YWWuchj6sVmAP758Pl+f1pqv04LNllXXg3GmUFDgjdzMQtGLtztHjOF82LQXptQsXPqmqm
	zxKQlxcHcVUJhRDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JnFHU4A2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YWWuchj6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753082211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LSKmvCUBIRnbdkU3d6FhNBLPxqYepeJ3GDDapuIzLw=;
	b=JnFHU4A2+BnlJt99f2L7iAE9IGr4Fl5mqL52UrY6Z21vVjpDkXPdbTXaZmFKS15FDpg9Co
	s5qzYdAEPkcDuquvXCYJDM9cvwkrlGeIuusBpx6yTBzlXOIWbnfW41Xbc/5192mn8dDUy7
	7G+8j4zecS2Sqn0kOIWh5s4Xt84StF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753082211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LSKmvCUBIRnbdkU3d6FhNBLPxqYepeJ3GDDapuIzLw=;
	b=YWWuchj6sVmAP758Pl+f1pqv04LNllXXg3GmUFDgjdzMQtGLtztHjOF82LQXptQsXPqmqm
	zxKQlxcHcVUJhRDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4B28136A8;
	Mon, 21 Jul 2025 07:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9/lMJmLpfWgvWwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Jul 2025 07:16:50 +0000
Message-ID: <e63ba3f4-76f6-46ec-8d41-4554b92dd581@suse.de>
Date: Mon, 21 Jul 2025 09:16:50 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] null_blk: fix set->driver_data while setting up
 tagset
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, dlemoal@kernel.org,
 johannes.thumshirn@wdc.com, gjoyce@ibm.com
References: <20250720113553.913034-1-nilay@linux.ibm.com>
 <20250720113553.913034-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250720113553.913034-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EDE52219D8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Score: -4.51

On 7/20/25 13:35, Nilay Shroff wrote:
> When setting up a null block device, we initialize a tagset that
> includes a driver_data field—typically used by block drivers to
> store a pointer to driver-specific data. In the case of null_blk,
> this should point to the struct nullb instance.
> 
> However, due to recent tagset refactoring in the null_blk driver, we
> missed initializing driver_data when creating a shared tagset. As a
> result, software queues (ctx) fail to map correctly to new hardware
> queues (hctx). For example, increasing the number of submit queues
> triggers an nr_hw_queues update, which invokes null_map_queues() to
> remap queues. Since set->driver_data is unset, null_map_queues()
> fails to map any ctx to the new hctxs, leading to hctx->nr_ctx == 0,
> effectively making the hardware queues unusable for I/O.
> 
> This patch fixes the issue by ensuring that set->driver_data is properly
> initialized to point to the struct nullb during tagset setup.
> 
> Fixes: 72ca28765fc4 ("null_blk: refactor tag_set setup")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/block/null_blk/main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index aa163ae9b2aa..9e1c4ce6fc42 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1854,13 +1854,14 @@ static int null_init_global_tag_set(void)
>   
>   static int null_setup_tagset(struct nullb *nullb)
>   {
> +	nullb->tag_set->driver_data = nullb;
> +
>   	if (nullb->dev->shared_tags) {
>   		nullb->tag_set = &tag_set;
>   		return null_init_global_tag_set();
>   	}
>   
>   	nullb->tag_set = &nullb->__tag_set;
> -	nullb->tag_set->driver_data = nullb;
>   	nullb->tag_set->nr_hw_queues = nullb->dev->submit_queues;
>   	nullb->tag_set->queue_depth = nullb->dev->hw_queue_depth;
>   	nullb->tag_set->numa_node = nullb->dev->home_node;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
