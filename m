Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D025B30D
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847787; cv=none; b=nOxYA2RLuNFkFInhSp9WvWiBB7GeBe0Db7gCLogIxNtESwQGVgXxNoakgAXu5JztikLj+NnZcLzoObciIeSYz5uNJSz0Sq9gsYujhkHn9xaK3FhbxYQO2Gjt6b6itsntgfrss/iK+fNQful5LEbF8AzWeg/VoOzk1Fyrw4ssdCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847787; c=relaxed/simple;
	bh=IxQERd+/pe6rmxSC4cnbctSnznBJ0zoumwIYVLg+Y4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IV+Ud/lmyMge6iFDHwecOVt96oiDJSktaC0WnpudXOR1KT1b521TQPqyRHsu4JZEJI06fJbtXKV0Tx8YBME8DY0wzCezIg+pvNyKlZd8sCFV8NaHcEG+kXFnozUg1mWokm9OVot37tx4wRnm/5nsR52zZ+470fzViZWzfBkZIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oZJ2R5X6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0xkKDTN3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oZJ2R5X6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0xkKDTN3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oZJ2R5X6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0xkKDTN3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oZJ2R5X6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0xkKDTN3"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CD485BCF2;
	Mon, 23 Feb 2026 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771847784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CENPDQVEL1SLmpdEVBcpe0K+kkmKCCzt19B6iJp75HU=;
	b=oZJ2R5X6pv1M2JhwNcJzvMjvGyR2GTQV2ZY/2EgQER8741+yNstyxS9jse61LsIg14gqqP
	pumjIbnrh3mkTePN6tvJxWmTlpA6cGef+A92X5CI0zqbM2jH83Qn4vOLCZ8WysGA42wt2V
	wxFCD+59VBvuBM/XZEWujRy7Az0GSf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771847784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CENPDQVEL1SLmpdEVBcpe0K+kkmKCCzt19B6iJp75HU=;
	b=0xkKDTN3qfBt8UA/0szR/OrYDkjIKb5X61xBCujbc5UTKboJ0oVSIvCM78fr209YCEBfkc
	DppUCHYQp51MMxDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771847784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CENPDQVEL1SLmpdEVBcpe0K+kkmKCCzt19B6iJp75HU=;
	b=oZJ2R5X6pv1M2JhwNcJzvMjvGyR2GTQV2ZY/2EgQER8741+yNstyxS9jse61LsIg14gqqP
	pumjIbnrh3mkTePN6tvJxWmTlpA6cGef+A92X5CI0zqbM2jH83Qn4vOLCZ8WysGA42wt2V
	wxFCD+59VBvuBM/XZEWujRy7Az0GSf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771847784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CENPDQVEL1SLmpdEVBcpe0K+kkmKCCzt19B6iJp75HU=;
	b=0xkKDTN3qfBt8UA/0szR/OrYDkjIKb5X61xBCujbc5UTKboJ0oVSIvCM78fr209YCEBfkc
	DppUCHYQp51MMxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC0A23EA68;
	Mon, 23 Feb 2026 11:56:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4zPNNWdAnGn3RAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 11:56:23 +0000
Message-ID: <ab25a49b-0732-4d0e-94b7-1785934a1a5e@suse.de>
Date: Mon, 23 Feb 2026 12:56:23 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] block: fix zone write plug removal
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260221004411.548482-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.949];
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On 2/21/26 01:44, Damien Le Moal wrote:
> Commit 7b295187287e ("block: Do not remove zone write plugs still in
> use") modified disk_should_remove_zone_wplug() to add a check on the
> reference count of a zone write plug to prevent removing zone write
> plugs from a disk hash table when the plugs are still being referenced
> by BIOs in-flight. However, this check does not take into account that
> a BIO completion may happen right after its submission by a zone write
> plug BIO work, and before the zone write plug BIO work release the zone
> write plug reference count. This situation leads to
> disk_should_remove_zone_wplug() returning false. If the BIO that
> completes in such manner transitioned the zone to the FULL condition,
> the zone write plug for the FULL zone will remain in the disk hash
> table.
> 
> Solve this by moving the check for removing a zone write plug from its
> disk hash table from disk_zone_wplug_unplug_bio() into a new function
> disk_check_and_put_zone_wplug() so that we can always check if a zone
> write plug should be removed when the plug references are being
> released. This new function calls disk_should_remove_zone_wplug() and
> disk_remove_zone_wplug() with the zone write plug lock held when the
> zone write plug reference count is equal to the minimum value (2)
> indicating that only the caller context is referencing the zone write
> plug. This is followed with a call to disk_put_zone_wplug() which may
> cause the zone write plug to be freed if the plug was removed from the
> disk hash table and the plug reference count dropped to 0.
> 
> The simpler disk_put_zone_write_plug() function is used whenever we
> know that we have multiple references on a zone write plug, that is,
> when we know that checking for the zone removal is not necessary.
> 
> Of note is that the calls to disk_should_remove_zone_wplug() and
> disk_remove_zone_zone_wplug() are maintained in
> disk_zone_wplug_set_wp_offset() because this function is called
> directly while walking the disk zone write plug hash table without
> taking references on zone write plugs when processing zone reset all
> operations.
> 
> Fixes: 7b295187287e ("block: Do not remove zone write plugs still in use")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 52 +++++++++++++++++++++++++++++++----------------
>   1 file changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 846b8844f04a..9c38497e7258 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -655,6 +655,29 @@ static void disk_remove_zone_wplug(struct gendisk *disk,
>   	disk_put_zone_wplug(zwplug);
>   }
>   
> +static inline void disk_check_and_put_zone_wplug(struct blk_zone_wplug *zwplug)
> +{
> +	lockdep_assert_not_held(&zwplug->lock);
> +
> +	/*
> +	 * Check for the need to remove the zone write plug from the hash list
> +	 * when we see that only the caller is referencing the zone write plug.
> +	 * Since this is racy without holding the zone write plug lock, this
> +	 * check is done again in  disk_should_remove_zone_wplug().
> +	 */
> +	if (refcount_read(&zwplug->ref) <= 2) {
> +		struct gendisk *disk = zwplug->disk;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&zwplug->lock, flags);
> +		if (disk_should_remove_zone_wplug(disk, zwplug))
> +			disk_remove_zone_wplug(disk, zwplug);
> +		spin_unlock_irqrestore(&zwplug->lock, flags);
> +	}
> +
> +	disk_put_zone_wplug(zwplug);
> +}
> +
>   static void blk_zone_wplug_bio_work(struct work_struct *work);
>   
>   /*

This looks slightly odd; a simple 'refcount_read()' always trigger alarm
bells with me as it inevitably races with 'refcount_dec()' /
'refcount_inc()'.
And similar the check 'refcount <= 2' also looks odd; typically one
would check against '< 1' and let the refcount destructor handle
things. But anyway, that's how the code does it, so:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
