Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C34364EA9
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847968; cv=none; b=oecHvdtVG3eclzn0tq/be4m7dtbVUNgpv6sSJDt5z2QIbXS1W8EKESPo5UVtBXMIedPyJQKlLA7hbJV47M5LrR4otSPhLJcyLXNYu0m2Yzio43NLuvUUQD3vR9wPEH/N2695Q9DS6nh3JEnsaRN3TXfHJHLRKYkp3isDCCIkF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847968; c=relaxed/simple;
	bh=EUZRkkBcqlaCafmljUFwOgGJpTox4cyqxVZCrnigNy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B+PA/xbXCSCv+A95q7HtrtRLRrWV1wPSKxzoZBMBugkzS/UtSMZLDZBD4PPRR4uyURVdsPcNYC4K6DW7nCjOYPf16T3f8Xhax99/StY15Udw4lkimxTfpUi1o8s/L8EvOWtVaXXnkIwVKyl76y+KGq/5YDWocRawFv51lJ4EGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eJAg2sr1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YAnBk+LF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eJAg2sr1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YAnBk+LF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eJAg2sr1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YAnBk+LF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eJAg2sr1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YAnBk+LF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C181D3EC67;
	Mon, 23 Feb 2026 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771847965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BigM1jD32E7xiQzYArxysufjImlaoQyJBOe8IZTRi20=;
	b=eJAg2sr1ni9lVwwmfExRDsNIQS5r5lqzPFCilqBQrHSO1K2WgeNkkJugH0zwon577Ik3t2
	NaS65n8Uiicd/iCL3JcESgyHCCiHRH+/Rb45BdUUL2Rou36Cn6doDtrNR7oeePn7KDLhHf
	f70XhvlDMi2PPQT9r8SrZBgZTYojLIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771847965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BigM1jD32E7xiQzYArxysufjImlaoQyJBOe8IZTRi20=;
	b=YAnBk+LFJbJNgGtO5hVFrYzLoyO7VQTPxRjJ9NZJLzj2nQjKLdEjitc4BjChWZX0x4mZdS
	KGmefaFLpSjwZbCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eJAg2sr1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YAnBk+LF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771847965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BigM1jD32E7xiQzYArxysufjImlaoQyJBOe8IZTRi20=;
	b=eJAg2sr1ni9lVwwmfExRDsNIQS5r5lqzPFCilqBQrHSO1K2WgeNkkJugH0zwon577Ik3t2
	NaS65n8Uiicd/iCL3JcESgyHCCiHRH+/Rb45BdUUL2Rou36Cn6doDtrNR7oeePn7KDLhHf
	f70XhvlDMi2PPQT9r8SrZBgZTYojLIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771847965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BigM1jD32E7xiQzYArxysufjImlaoQyJBOe8IZTRi20=;
	b=YAnBk+LFJbJNgGtO5hVFrYzLoyO7VQTPxRjJ9NZJLzj2nQjKLdEjitc4BjChWZX0x4mZdS
	KGmefaFLpSjwZbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6B923EA68;
	Mon, 23 Feb 2026 11:59:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nm43KB1BnGkiSAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 11:59:25 +0000
Message-ID: <43213df9-9233-4d5a-8b56-77894052db67@suse.de>
Date: Mon, 23 Feb 2026 12:59:25 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] block: improve disk_zone_wplug_schedule_bio_work()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-5-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260221004411.548482-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C181D3EC67
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/21/26 01:44, Damien Le Moal wrote:
> The function disk_zone_wplug_schedule_bio_work() always takes a
> reference on the zone write plug of the BIO work being scheduled. This
> ensure that the zone write plug cannot be freed while the BIO work is
> being scheduled but has not run yet. However, this unconditional
> reference taking is fragile since the reference taken is realized by the
> BIO work blk_zone_wplug_bio_work() function, which implies that there
> always must be a 1:1 relation between the work being scheduled and the
> work running.
> 
> Make this less fragile by taking the reference on the BIO work if and
> only if the BIO work has not been already scheduled.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index c5c91f927a71..4b388ae1acaa 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1205,13 +1205,15 @@ static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
>   	lockdep_assert_held(&zwplug->lock);
>   
>   	/*
> -	 * Take a reference on the zone write plug and schedule the submission
> -	 * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
> -	 * reference we take here.
> +	 * Schedule the submission of the next plugged BIO. If the zone write
> +	 * plug BIO work is not already scheduled, take a reference on the zone
> +	 * write plug to ensure that it does not go away while the work is being
> +	 * scheduled but has not run yet. blk_zone_wplug_bio_work() will release
> +	 * the reference we take here.
>   	 */
>   	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
> -	refcount_inc(&zwplug->ref);
> -	queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
> +	if (queue_work(disk->zone_wplugs_wq, &zwplug->bio_work))
> +		refcount_inc(&zwplug->ref);
>   }
>   
>   static inline void disk_zone_wplug_add_bio(struct gendisk *disk,

Urgh. Don't.
There is a race condition; 'bio_work' might be scheduled directly and
complete before 'refcount_inc()' is called.
You have to invert the statement by keeping the 'refcount_inc()'
before calling 'queue_work()', and then drop the reference again
if queue_work failed.
Ugly, I know.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
