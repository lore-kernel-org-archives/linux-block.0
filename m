Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67D330B0E
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203667; cv=none; b=VmIvV0WvGKThwTXrYIahvHU9rFYNSpKnMhdQ+Zt5Mp2FBUoqXyPTOY1GvRRS/RX6R8ummw1S2ltAG2DVq8QCfPSVvJ7cXfna8wDBJOtz1hFXVntfUPne73ZDRpHxwDTdWdzzXbbOvVw12PzuEK8+OCj8jRZZow/oWLxDl51nTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203667; c=relaxed/simple;
	bh=/ng5UwzfNtKn16R3D1kOdg0gDAJL6ZFUJ0bcndxmwGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ictIS/tNs0liAtF+Ttq0LGoCt+Mbd8oZl3eRV8YnNyVFl9TRb567q4LeUexiDeB5GBNXjKqzjF+db1cdr537Tjqf356T9NhtOTv+X+GvdCl6WY66U+OF7p8dsXuTcqMfR7h0e2Kbc/VJGLD6ebIGYp4GlbqnGeWIlNRBx4kl9Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TSE/K0Wu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CqbUX022; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TSE/K0Wu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CqbUX022; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TSE/K0Wu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CqbUX022";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TSE/K0Wu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CqbUX022"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B6D2336FD;
	Mon, 12 Jan 2026 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEXmgS/MeC0/qackH28HoAnjxYTWBKix3q8uQtOPgRY=;
	b=TSE/K0WuhOohgSAg6sKakLjHJ9Fanx9s7JmXJiH9ntgZdITOWimtL2OXjVKsB2FB+mdeER
	bWn+HXQlare6QdULXPekJ64qKegxWd8ux4SpJN2jk78tno/cJK6EW9OrYEnOljuO+TwIMr
	5elPnxNrz/6e3AVOH1ViHRFli1nZQOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEXmgS/MeC0/qackH28HoAnjxYTWBKix3q8uQtOPgRY=;
	b=CqbUX022/cQZ5u8FwQG+/2tzckNPTlgl2Rp9jsDnBTmtv4bPc4W6QEqxJmza0g27XGESGi
	THu7+1bL0VnDkrCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="TSE/K0Wu";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CqbUX022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEXmgS/MeC0/qackH28HoAnjxYTWBKix3q8uQtOPgRY=;
	b=TSE/K0WuhOohgSAg6sKakLjHJ9Fanx9s7JmXJiH9ntgZdITOWimtL2OXjVKsB2FB+mdeER
	bWn+HXQlare6QdULXPekJ64qKegxWd8ux4SpJN2jk78tno/cJK6EW9OrYEnOljuO+TwIMr
	5elPnxNrz/6e3AVOH1ViHRFli1nZQOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DEXmgS/MeC0/qackH28HoAnjxYTWBKix3q8uQtOPgRY=;
	b=CqbUX022/cQZ5u8FwQG+/2tzckNPTlgl2Rp9jsDnBTmtv4bPc4W6QEqxJmza0g27XGESGi
	THu7+1bL0VnDkrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA54F3EA63;
	Mon, 12 Jan 2026 07:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UR46M4+lZGmJUQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Jan 2026 07:41:03 +0000
Message-ID: <0956885f-1bff-4969-bb82-7d2556e23187@suse.de>
Date: Mon, 12 Jan 2026 08:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] blk-mq-debugfs: make
 blk_mq_debugfs_register_rqos() static
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
References: <20260109065230.653281-1-yukuai@fnnas.com>
 <20260109065230.653281-6-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260109065230.653281-6-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 1B6D2336FD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/9/26 07:52, Yu Kuai wrote:
> Because it's only used inside blk-mq-debugfs.c now.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c | 2 +-
>   block/blk-mq-debugfs.h | 5 -----
>   2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 4fe164b6d648..11f00a868541 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -744,7 +744,7 @@ void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
>   	rqos->debugfs_dir = NULL;
>   }
>   
> -void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
> +static void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
>   {
>   	struct request_queue *q = rqos->disk->queue;
>   	const char *dir_name = rq_qos_id_to_name(rqos->id);
> diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
> index 54948a266889..d94daa66556b 100644
> --- a/block/blk-mq-debugfs.h
> +++ b/block/blk-mq-debugfs.h
> @@ -34,7 +34,6 @@ void blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
>   void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
>   
>   void blk_mq_debugfs_register_rq_qos(struct request_queue *q);
> -void blk_mq_debugfs_register_rqos(struct rq_qos *rqos);
>   void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos);
>   #else
>   static inline void blk_mq_debugfs_register(struct request_queue *q)
> @@ -75,10 +74,6 @@ static inline void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hc
>   {
>   }
>   
> -static inline void blk_mq_debugfs_register_rqos(struct rq_qos *rqos)
> -{
> -}
> -
>   static inline void blk_mq_debugfs_register_rq_qos(struct request_queue *q)
>   {
>   }

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
