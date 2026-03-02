Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709571D0DEE
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436082; cv=none; b=tJzj3ZEadrMt0UFKLh/1laou/UtWO8KIF9UW5IJeOInQn+x0dfBsTZByTx0BgnNgSadm3sxmyFx6FaTJnQFy8c045cBSg+gZu6SyU4DoKIyYEuvDsINQU6C7WStkqXLSbC95AcZwMO3wYd3XjIY2MsZJnHXyzVDJdijO9aPib9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436082; c=relaxed/simple;
	bh=1XWuONnBCEzjdsXcL/aElfge2aTzoI7EONT1uvR409Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D5jvSmUXTOGx1yjTLLY2aZlsVw2Ddn5CXujx6K2Zfc8xvXeNrx0Aa9T0+8Ewa0768i3Iq38rgN61CQ/RU58I8aC6JWFRJOG4hOoE+YIRDOjvIBzootMaZ018qht/ba7QMNm3KXLiQ5JgiCrWUJjMJILsCsFWXUklZ3KYWi3q3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ndhdwj3y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZcCxO7vH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ndhdwj3y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZcCxO7vH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ndhdwj3y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZcCxO7vH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ndhdwj3y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZcCxO7vH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA17F3E76A;
	Mon,  2 Mar 2026 07:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772436079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoFtLMV6SP2Dwr6WDjgxtkE0oVtK2YynKgIynm0WD3s=;
	b=ndhdwj3yZSnxafgCJL4imuTWCId4aFeA4+DK177STtGYXX287GrtEhYD6sY6kc/FkKgawJ
	wLmmsKrO2Rj4nEJSzeTTp772f77th6DKcqpQvVYMz/Ny9qov/6mF+OM5VodJEGv+PL8xT6
	Z0ZsJOlr7Dc0xai7s2tKW+yegQInANM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772436079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoFtLMV6SP2Dwr6WDjgxtkE0oVtK2YynKgIynm0WD3s=;
	b=ZcCxO7vHj2lZzxoAPdiZwqzJoedq0OP2qHIDoZhrTb5XcQZxS7wNQSyNBbY/pn3d/tzq8P
	dezieo8ZrA7EYPDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ndhdwj3y;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZcCxO7vH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772436079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoFtLMV6SP2Dwr6WDjgxtkE0oVtK2YynKgIynm0WD3s=;
	b=ndhdwj3yZSnxafgCJL4imuTWCId4aFeA4+DK177STtGYXX287GrtEhYD6sY6kc/FkKgawJ
	wLmmsKrO2Rj4nEJSzeTTp772f77th6DKcqpQvVYMz/Ny9qov/6mF+OM5VodJEGv+PL8xT6
	Z0ZsJOlr7Dc0xai7s2tKW+yegQInANM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772436079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoFtLMV6SP2Dwr6WDjgxtkE0oVtK2YynKgIynm0WD3s=;
	b=ZcCxO7vHj2lZzxoAPdiZwqzJoedq0OP2qHIDoZhrTb5XcQZxS7wNQSyNBbY/pn3d/tzq8P
	dezieo8ZrA7EYPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81F4C3EA69;
	Mon,  2 Mar 2026 07:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KgxyHm86pWmtawAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Mar 2026 07:21:19 +0000
Message-ID: <4d042d8d-94ac-428c-96a9-0fe6df123aba@suse.de>
Date: Mon, 2 Mar 2026 08:21:19 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] block: fix zone write plugs refcount handling in
 disk_zone_wplug_schedule_bio_work()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260227014951.2327711-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: AA17F3E76A
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/27/26 02:49, Damien Le Moal wrote:
> The function disk_zone_wplug_schedule_bio_work() always takes a
> reference on the zone write plug of the BIO work being scheduled. This
> ensures that the zone write plug cannot be freed while the BIO work is
> being scheduled but has not run yet. However, this unconditional
> reference taking is fragile since the reference taken is released by the
> BIO work blk_zone_wplug_bio_work() function, which implies that there
> always must be a 1:1 relation between the work being scheduled and the
> work running.
> 
> Make sure to drop the reference taken when scheduling the BIO work if
> the work is already scheduled, that is, when queue_work() returns false.
> 
> Fixes: 9e78c38ab30b ("block: Hold a reference on zone write plugs to schedule submission")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-zoned.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 6e3ef181e837..7aae3c236cad 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1154,13 +1154,17 @@ static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
>   	lockdep_assert_held(&zwplug->lock);
>   
>   	/*
> -	 * Take a reference on the zone write plug and schedule the submission
> -	 * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
> -	 * reference we take here.
> +	 * Schedule the submission of the next plugged BIO. Taking a reference
> +	 * to the zone write plug is required as the bio_work belongs to the
> +	 * plug, and thus we must ensure that the write plug does not go away
> +	 * while the work is being scheduled but has not run yet.
> +	 * blk_zone_wplug_bio_work() will release the reference we take here,
> +	 * and we also drop this reference if the work is already scheduled.
>   	 */
>   	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
>   	refcount_inc(&zwplug->ref);
> -	queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
> +	if (!queue_work(disk->zone_wplugs_wq, &zwplug->bio_work))
> +		disk_put_zone_wplug(zwplug);
>   }
>   
>   static inline void disk_zone_wplug_add_bio(struct gendisk *disk,

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
