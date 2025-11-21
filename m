Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740B2FD68D
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708955; cv=none; b=PrSKNfIAwSfvSoExVVHz7L0xAV1CICpFs9YhxsuIf5htY1WUv3KHCDSSrTPhr9Pzrl1b6moimvRcmLzNTn5pALA85eGMfQJ+tFfyPJlx6q9sB52Tmqq2UFxuWeVmArN+rRvOU4DW+MWKqzlUQXYfwX7T7eEqR0zfb3F7TqK2lrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708955; c=relaxed/simple;
	bh=4/5mHjnglN0JNntqSueEpbLN+zhxBvIKg257i536KIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zt8UVe7AhLYwTfEtjY9aHXDT4q9kkR5EHykakm6h+agyMyUC2+xCci6926dR/o/DDXq1vBw6J+wbLfv3aXRwvQknJVqaCIOX3PRQsVdOH2i3zi33CTht3yKf4lEGOeZ8HthsMqS6wWWbkrIUFBy2vY9fswoLNlMfNnnA5u6y3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CbKoffAj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r97AOkEi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tx5tBlPA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=neV9NqtL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CbKoffAj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r97AOkEi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tx5tBlPA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="neV9NqtL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D40C820E85;
	Fri, 21 Nov 2025 07:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763708951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv7yWOJaBC7YW7mHqMv2wo6iAvofq/XaYJZSHFBBazk=;
	b=CbKoffAjKs/oPIfd7j17zRsy0yg+h8ofKB8TgPdnMnWgyyNA90H+rhi6gcfmp06pTYqhtE
	v9aV9Iioc27iOnZsQkE7e6L1GxeA04Ri1mZny7oGsz9R+uX/6mm6YUvlLnsNnXIyh8UQ+9
	zYsz4Fcz+QplZEBT07Ori2Cv1cBzeqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763708951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv7yWOJaBC7YW7mHqMv2wo6iAvofq/XaYJZSHFBBazk=;
	b=r97AOkEi1195ICn8sFjPNvToTUdr5JJmDADJxb7o+zy/FQvsX8loDAFSWVYc08YmMVVZWV
	0nKdww1MF+na1MAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tx5tBlPA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=neV9NqtL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763708949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv7yWOJaBC7YW7mHqMv2wo6iAvofq/XaYJZSHFBBazk=;
	b=tx5tBlPAZNOgzUpjcJdTUldoRmX/JvexdQbizt+5FJjzX3TrkcMIgXyCohX/PRHoDpFO04
	hhexHQgAmUd84F6Colyz+1DoMQcLJKxPTrE6o3Nk/1m+sXEAl7sJmQgs95SMDTQR2YfZFN
	pOlAiT6m3D9yTubJJk7MfsE8j348ocs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763708949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv7yWOJaBC7YW7mHqMv2wo6iAvofq/XaYJZSHFBBazk=;
	b=neV9NqtLrpJfq6CyQ/bNcYnrovXKYrxyibsM2ClAvJW5ckBt75B/W//1jeBh2oMCPRcDnU
	CCHVPT/u8UCrR6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87FBF3EA61;
	Fri, 21 Nov 2025 07:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MVliHxUQIGkRbwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Nov 2025 07:09:09 +0000
Message-ID: <3eaa8992-716d-49cf-91cf-3a1f5796afe1@suse.de>
Date: Fri, 21 Nov 2025 08:09:09 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] block: convert nr_requests to unsigned int
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251121052901.1341976-1-yukuai@fnnas.com>
 <20251121052901.1341976-2-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251121052901.1341976-2-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D40C820E85
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 11/21/25 06:28, Yu Kuai wrote:
> This value represents the number of requests for elevator tags, or drivers
> tags if elevator is none. The max value for elevator tags is 2048, and
> in drivers at most 16 bits is used for tag.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   include/linux/blkdev.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index cb4ba09959ee..cdc68c41fa96 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -551,7 +551,7 @@ struct request_queue {
>   	/*
>   	 * queue settings
>   	 */
> -	unsigned long		nr_requests;	/* Max # of requests */
> +	unsigned int		nr_requests;	/* Max # of requests */
>   
>   #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>   	struct blk_crypto_profile *crypto_profile;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
