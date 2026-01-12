Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD6330B0E
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203724; cv=none; b=MWDralqbETr/DTcmCub+f3pdiHi6sESdT5xbp4XJP5GY+1SiPYU/HfpfsxYayVvwf3RaOtH2Scx5yUrL5BGyuUyMQU/CjOxn0e9C+Zhj9MTUspAI83KCcEyuqMmrZblKTEWRfb9XrNiZdPE/aywsZMDgX1UNP9EolWKnM6DYt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203724; c=relaxed/simple;
	bh=uj75e1etv8U6yqqa2p9AOmyHFfs/5A6pcgp8EflQ8Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FUmmfLoF8p91zx75DGaWVRm1iW/4kl2WtI8mnoRyVrKQAC3WFygeneRFG100GKLiSVDwtPuhzC1hb7buGxSiNnGDgGYK+iWYtbjIJg7bYhqVbNX6CLsJ4JSArGno6tUuaN1bH1d8kBli/D+64b7vUKFFY+ua13u0tZXq5hmOvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mekwA86q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3b1f6ShW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mekwA86q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3b1f6ShW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mekwA86q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3b1f6ShW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mekwA86q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3b1f6ShW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CF5C336BF;
	Mon, 12 Jan 2026 07:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkgIlUbagpEE9yaWhfXBVcKYhuLox0c/M2QHCcy4NS4=;
	b=mekwA86qAqc1pWsJ6b0LoZCEmXipiS0ee8L3SCPUI04OSBhq1/OciWeuYWz9wWRwVr565p
	FroEol4KjCp1jDnTLAcmNuuFa8zzEdggoCroKSiJkRIZqZY9a95OWqrf+wil7Cvk3wicx/
	bBqKrllMUl9xzpoxKNaFvNFT4s8V85w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkgIlUbagpEE9yaWhfXBVcKYhuLox0c/M2QHCcy4NS4=;
	b=3b1f6ShW4JGUB3ecXBBG1IGwO1+KIt41S772tZ5C7nhbqBvILaS4b5exvZsZG221mAzeku
	YDhrcGKGYzC+T/Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mekwA86q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3b1f6ShW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkgIlUbagpEE9yaWhfXBVcKYhuLox0c/M2QHCcy4NS4=;
	b=mekwA86qAqc1pWsJ6b0LoZCEmXipiS0ee8L3SCPUI04OSBhq1/OciWeuYWz9wWRwVr565p
	FroEol4KjCp1jDnTLAcmNuuFa8zzEdggoCroKSiJkRIZqZY9a95OWqrf+wil7Cvk3wicx/
	bBqKrllMUl9xzpoxKNaFvNFT4s8V85w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkgIlUbagpEE9yaWhfXBVcKYhuLox0c/M2QHCcy4NS4=;
	b=3b1f6ShW4JGUB3ecXBBG1IGwO1+KIt41S772tZ5C7nhbqBvILaS4b5exvZsZG221mAzeku
	YDhrcGKGYzC+T/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 676933EA63;
	Mon, 12 Jan 2026 07:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5gplF8mlZGlWUgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Jan 2026 07:42:01 +0000
Message-ID: <873ae2d3-95fb-4142-bad0-2faa03e04337@suse.de>
Date: Mon, 12 Jan 2026 08:42:00 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] blk-mq-debugfs: add missing debugfs_mutex in
 blk_mq_debugfs_register_hctxs()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
References: <20260109065230.653281-1-yukuai@fnnas.com>
 <20260109065230.653281-8-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260109065230.653281-8-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,fnnas.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9CF5C336BF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 1/9/26 07:52, Yu Kuai wrote:
> In blk_mq_update_nr_hw_queues(), debugfs_mutex is not held while
> creating debugfs entries for hctxs. Hence add debugfs_mutex there,
> it's safe because queue is not frozen.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 22c182b40bc3..5c7cadf51a88 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -679,8 +679,10 @@ void blk_mq_debugfs_register_hctxs(struct request_queue *q)
>   	struct blk_mq_hw_ctx *hctx;
>   	unsigned long i;
>   
> +	mutex_lock(&q->debugfs_mutex);
>   	queue_for_each_hw_ctx(q, hctx, i)
>   		blk_mq_debugfs_register_hctx(q, hctx);
> +	mutex_unlock(&q->debugfs_mutex);
>   }
>   
>   void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
