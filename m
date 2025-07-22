Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C4928936B
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183742; cv=none; b=SofzZgH23BRGIaxPRIBBlB4cLVumz5wqBFBSRwW9YyAaZ6M+ZLxFjuft+srTJYZiOFcRHWUvLNHZT8PwZd2QXyL4SnfkhyYRAmiXVE9fw/AQ5uGT9AF4oDDt0OVl6v8wfYrBi8kjpcJxC/Nf/FMKJlgHENu2EVdoiIC5xOD0YoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183742; c=relaxed/simple;
	bh=fYlDv5D82NDsNCSHLbGHvoxmczo7LZmemLmISpEY1GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+SEdCLcvcv5xqpwuK3jSBl+FIAZmTVLGBpFglW3KgfXUHMxoOtBnwSkPOE0D0I9tgmSmCiazbaO6t2XDcUT+EOjbiJRdjjlSTcrFP9xdDEKcFwARljSiMlKAKfAtKcvJOQWsIfcyAoo589ibMDOjbcAhhPgqZMRCssbECG3HHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oXMzORTI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YI7GEhQJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oXMzORTI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YI7GEhQJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oXMzORTI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YI7GEhQJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oXMzORTI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YI7GEhQJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A35221ADC;
	Tue, 22 Jul 2025 11:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753183738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0TbSwF/4FJcllmNgeLdPebKTAXgaCMBnlXiCL22s24=;
	b=oXMzORTIURzw75+emLpnnJEZd/cgb1gLWWWGR+3ohoFm3MRFJFGxTF6wzgbQ80TAxpxWsd
	nMa28j8sffRvhsBF+SlJh3YkESMrmCIg/roS9WnflMCJEaUE44YToc2wk5xyONXtHVL0rX
	yFSzLyXElWG5kQq8xNsk2uKsTMzidxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753183738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0TbSwF/4FJcllmNgeLdPebKTAXgaCMBnlXiCL22s24=;
	b=YI7GEhQJGgugNOBbi/vcOgIorFabURKNvNbzpK/LWmYc4YANAhC+YKS77bKntivceCFZNL
	UFM+7D4T3FQ/FaDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oXMzORTI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YI7GEhQJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753183738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0TbSwF/4FJcllmNgeLdPebKTAXgaCMBnlXiCL22s24=;
	b=oXMzORTIURzw75+emLpnnJEZd/cgb1gLWWWGR+3ohoFm3MRFJFGxTF6wzgbQ80TAxpxWsd
	nMa28j8sffRvhsBF+SlJh3YkESMrmCIg/roS9WnflMCJEaUE44YToc2wk5xyONXtHVL0rX
	yFSzLyXElWG5kQq8xNsk2uKsTMzidxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753183738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0TbSwF/4FJcllmNgeLdPebKTAXgaCMBnlXiCL22s24=;
	b=YI7GEhQJGgugNOBbi/vcOgIorFabURKNvNbzpK/LWmYc4YANAhC+YKS77bKntivceCFZNL
	UFM+7D4T3FQ/FaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57FC313A32;
	Tue, 22 Jul 2025 11:28:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 91MAFfp1f2jZRgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Jul 2025 11:28:58 +0000
Message-ID: <d0adde51-8fb8-4fea-ada0-176a9d745db4@suse.de>
Date: Tue, 22 Jul 2025 13:28:58 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] block: Enforce power-of-2 physical block size
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
 <20250722102620.3208878-3-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250722102620.3208878-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 6A35221ADC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/22/25 12:26, John Garry wrote:
> The merging/splitting code and other queue limits checking depends on the
> physical block size being a power-of-2, so enforce it.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   block/blk-settings.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index fa53a330f9b9..5ae0a253e43f 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -274,6 +274,10 @@ int blk_validate_limits(struct queue_limits *lim)
>   	}
>   	if (lim->physical_block_size < lim->logical_block_size)
>   		lim->physical_block_size = lim->logical_block_size;
> +	else if (!is_power_of_2(lim->physical_block_size)) {
> +		pr_warn("Invalid physical block size (%d)\n", lim->physical_block_size);
> +		return -EINVAL;
> +	}
>   
>   	/*
>   	 * The minimum I/O size defaults to the physical block size unless

Why not calling 'blk_validate_block_size()' here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
