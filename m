Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2722538F
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847285; cv=none; b=eWCoWmngzHwXfc6OEeBmelurb0fL8912J2qgOnDpryqJobzi4xiAKNbBQG2kRJVcGYQO3iAc34Ie5I5ulgWyv7s3p8dx1hcGKzZ8SO9KEhTXjfG8KikZFpNHVdehC0RIIoGzgMlRiAUI3Sy6TpMEXz/n2T+LfGmKdphR6cZEI6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847285; c=relaxed/simple;
	bh=ZIZnuCoYNg/cBAI69nLUJsQ+F6/dMvEPMZs0zHVDGnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=slWW4ZbrvBqyi2wqgUD7RcshmYMVJ/4zeRR+qRph1yi/eHYxCAZ/R3rHDt0BxQpGm4yJSgkqVkVPwpcyo7iArE0GA3BBMNK4X233DchsvzWOtTP/OBsWsowsRJS1joog8o5b7g0dyO/9RdgJ8uI8HTSBDOF15XmaJ73b8Fj3eUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=peiFEFBe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Y8YBo5+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=peiFEFBe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Y8YBo5+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="peiFEFBe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Y8YBo5+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="peiFEFBe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Y8YBo5+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14B543EC58;
	Mon, 23 Feb 2026 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771847282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zz9Xd6xu46c/qyFVk8bSqbo2BlymGzE0rjbKd2+jAvA=;
	b=peiFEFBezgpxJot1DViErRrsNUpx3+e2/ufXjmy6V3f+m5vrLnaXBPGPr1RCWz05jsmhLO
	DGmQIexcgLrDsQ3x9osF9EKtF/RK4kpmmdOVYqoYq0sU9J4q4wyVxwn9HS66SH/pA4QOc5
	4pyp2e3W5MnHlErqDjgW2MqSAi3jPGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771847282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zz9Xd6xu46c/qyFVk8bSqbo2BlymGzE0rjbKd2+jAvA=;
	b=+Y8YBo5+ybEb219Mdg3Omd+mXrtqaRmTexlkvUmRSgyJ5k9hTMAvBL5TvpUYNktmjpm0Ea
	i6R7Le6iGZKo8aAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771847282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zz9Xd6xu46c/qyFVk8bSqbo2BlymGzE0rjbKd2+jAvA=;
	b=peiFEFBezgpxJot1DViErRrsNUpx3+e2/ufXjmy6V3f+m5vrLnaXBPGPr1RCWz05jsmhLO
	DGmQIexcgLrDsQ3x9osF9EKtF/RK4kpmmdOVYqoYq0sU9J4q4wyVxwn9HS66SH/pA4QOc5
	4pyp2e3W5MnHlErqDjgW2MqSAi3jPGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771847282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zz9Xd6xu46c/qyFVk8bSqbo2BlymGzE0rjbKd2+jAvA=;
	b=+Y8YBo5+ybEb219Mdg3Omd+mXrtqaRmTexlkvUmRSgyJ5k9hTMAvBL5TvpUYNktmjpm0Ea
	i6R7Le6iGZKo8aAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFD123EA68;
	Mon, 23 Feb 2026 11:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yYUXOnE+nGkMPAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 11:48:01 +0000
Message-ID: <65ac9a0d-6b9a-4591-9bf8-c513d3073d28@suse.de>
Date: Mon, 23 Feb 2026 12:48:01 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] block: remove BLK_ZONE_WPLUG_UNHASHED
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260221004411.548482-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.947];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

On 2/21/26 01:44, Damien Le Moal wrote:
> Detecting that a zone write plug has been removed from a disk hash table
> can be done using hlist_unhashed(), so there is no need for the zone
> write plug flag BLK_ZONE_WPLUG_UNHASHED. Remove this flag and convert
> all tests using it to use hlist_unhashed().
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 30 ++++++++++--------------------
>   1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 9c38497e7258..3dd50b2ba2bb 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -99,17 +99,9 @@ static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
>    *    being executed or the zone write plug bio list is not empty.
>    *  - BLK_ZONE_WPLUG_NEED_WP_UPDATE: Indicates that we lost track of a zone
>    *    write pointer offset and need to update it.
> - *  - BLK_ZONE_WPLUG_UNHASHED: Indicates that the zone write plug was removed
> - *    from the disk hash table and that the initial reference to the zone
> - *    write plug set when the plug was first added to the hash table has been
> - *    dropped. This flag is set when a zone is reset, finished or become full,
> - *    to prevent new references to the zone write plug to be taken for
> - *    newly incoming BIOs. A zone write plug flagged with this flag will be
> - *    freed once all remaining references from BIOs or functions are dropped.
>    */
>   #define BLK_ZONE_WPLUG_PLUGGED		(1U << 0)
>   #define BLK_ZONE_WPLUG_NEED_WP_UPDATE	(1U << 1)
> -#define BLK_ZONE_WPLUG_UNHASHED		(1U << 2)
>   
>   /**
>    * blk_zone_cond_str - Return a zone condition name string
> @@ -592,7 +584,7 @@ static inline void disk_put_zone_wplug(struct blk_zone_wplug *zwplug)
>   	if (refcount_dec_and_test(&zwplug->ref)) {
>   		WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
>   		WARN_ON_ONCE(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
> -		WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_UNHASHED));
> +		WARN_ON_ONCE(!hlist_unhashed_lockless(&zwplug->node));
>   
>   		call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
>   	}
> @@ -603,14 +595,14 @@ static inline bool disk_should_remove_zone_wplug(struct gendisk *disk,
>   {
>   	lockdep_assert_held(&zwplug->lock);
>   
> -	/* If the zone write plug was already removed, we are done. */
> -	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
> -		return false;
> -
>   	/* If the zone write plug is still plugged, it cannot be removed. */
>   	if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)
>   		return false;
>   
> +	/* If the zone write plug was already removed, we have nothing to do. */
> +	if (hlist_unhashed(&zwplug->node))
> +		return false;
> +
>   	/*
>   	 * Completions of BIOs with blk_zone_write_plug_bio_endio() may
>   	 * happen after handling a request completion with
The order of the checks have changed here; not sure if that matters,
but as it stands it's not a 1:1 conversion.
Maybe move this check up.

> @@ -635,16 +627,14 @@ static void disk_remove_zone_wplug(struct gendisk *disk,
>   	unsigned long flags;
>   
>   	/* If the zone write plug was already removed, we have nothing to do. */
> -	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
> +	if (hlist_unhashed(&zwplug->node))
>   		return;
>   
>   	/*
> -	 * Mark the zone write plug as unhashed and drop the extra reference we
> -	 * took when the plug was inserted in the hash table. Also update the
> -	 * disk zone condition array with the current condition of the zone
> -	 * write plug.
> +	 * Update the disk zone condition array with the current condition of
> +	 * the zone write plug and drop the extra reference we took when the
> +	 * plug was inserted in the hash table.
>   	 */
> -	zwplug->flags |= BLK_ZONE_WPLUG_UNHASHED;
>   	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
>   	blk_zone_set_cond(rcu_dereference_check(disk->zones_cond,
>   				lockdep_is_held(&disk->zone_wplugs_lock)),

Especially as the checks here at in the same order.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
