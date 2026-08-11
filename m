Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCE43F8D9
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448713; cv=none; b=AlUVgYf/yMgvAMdWWgaJXJLoHmGKueyPm1GwHv5I4TdUid18YBWdMotxrwrk8w73aX5d1GGURf56F3x6+AzjqIRez2Q5zGc1us7EnuUOLwfd0fVSHhkiLkYJbOflOy16KMmEycdqmn6rGSbaN6LliLG7VqsM1u8/iIFRLuHVW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448713; c=relaxed/simple;
	bh=kzlsDj6Pb4t+k/S5CJ7rVHY8H9sHKyMXqn9mRUrBiZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cN++l/kNE9hIgmmy7j7jneivHOTS2ywFPEx4hqb4/6fhSaWiiV+MI+k0M2BY/Fv/IHOhQo/KLQ2XFtUAaW3+LOLIQZtGChTqPiSMxiH8sON3hDGNXY4hrf2LG1UvuKopyFyjBibX/B0ny5/dvpDZTzdXIGhiSI8WWigNpNPbBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Aefx0Qkk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vcBeEGFA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uBq4HT4s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/0Z+YcWH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Aefx0Qkk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vcBeEGFA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uBq4HT4s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/0Z+YcWH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7168A3E09;
	Tue, 11 Aug 2026 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCwlW9Rq79SwBpLt4/cLfculjCJdLMOq1D+RdapN5HU=;
	b=Aefx0QkkfjbCb5W3ncalV9c+pMqXF3RDmczLRAd1BaSrHarckZNvwL6zhzzDVydaoBNWXy
	W+Pbz2/cIzaiOcBsRd4C01FMVyDUUC6Jd8/sN1GFyHApNZHT353wfcWIPt+qZEIYVmxHip
	cy+uXyc9OVVkq4PAMPuPrRyDBdBGKFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCwlW9Rq79SwBpLt4/cLfculjCJdLMOq1D+RdapN5HU=;
	b=vcBeEGFAhfmC0RwoEyZpQaqGKn/MFKcToTrAKKxT5SMZV5Rmxd1rDf4VGUOw+bl4ZWsK1B
	Wl0i4MXhHZf0xcBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uBq4HT4s;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/0Z+YcWH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCwlW9Rq79SwBpLt4/cLfculjCJdLMOq1D+RdapN5HU=;
	b=uBq4HT4suFtTOjFbeIhfipOLef0Xp5FTmwN1ogvdkABF2sDIHyftIrMOI90g42ALzXtof9
	K6V2emAkZsk8rT6PmK3l91hoLqnjLZJ22kH7HCMXwE+WWbnoLySxyMueg+UEdN9bmwAJfm
	ul7907AcZmIAwXu4KOez5ujF1MdfWK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCwlW9Rq79SwBpLt4/cLfculjCJdLMOq1D+RdapN5HU=;
	b=/0Z+YcWHnkI3NjVA9XPQS1gLtZEDco52yb6f1xTHdFQZFRXMm5z7oMJmPy40myH9L9sK3m
	9r7H6+Gqe2283TDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ACE8779B6;
	Tue, 11 Aug 2026 11:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QTLCFTwLe2q5AQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 11:45:00 +0000
Message-ID: <ec2f60a0-ab4d-47db-95ee-53486487768f@suse.de>
Date: Tue, 11 Aug 2026 13:45:00 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] block: simplify disk_zone_set_cond()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-13-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260811105852.1245357-13-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 7168A3E09
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/11/26 12:58 PM, Damien Le Moal wrote:
> disk_zone_set_cond() is used to set a zone condition afer a reset, a
> finish or a reset all operation. For a single zone reset or finish, we are
> guaranteed that the target zone is a sequential one that is not offline
> nor read-only (otherwise, the operation would have failed). For a reset
> all operation, there is no point in calling this function for offline and
> read-only zones since the condition checks in disk_zone_set_cond() will
> result in nothing being done.
> 
> Simplify all this using disk_zone_is_offline_or_readonly() in
> blk_zone_reset_all_bio_endio() to skip zones that are offline or
> read-only. This change allows simplifying disk_zone_set_cond() by removing
> the zone condition checks. This change is also consistent with the fact
> that conventional zones can now have the offline or read-only condition.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-zoned.c | 26 ++++++--------------------
>   1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index acf60982e6c9..02f92d113d32 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -235,29 +235,14 @@ EXPORT_SYMBOL_GPL(blk_zone_cond_str);
>   static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
>   			       enum blk_zone_cond cond)
>   {
> +	unsigned int zno = disk_zone_no(disk, sector);
>   	u8 *zones_state;
>   
>   	rcu_read_lock();
>   	zones_state = rcu_dereference(disk->zones_state);
> -	if (zones_state) {
> -		unsigned int zno = disk_zone_no(disk, sector);
> -
> -		/*
> -		 * The condition of a conventional, readonly and offline zones
> -		 * never changes, so do nothing if the target zone is in one of
> -		 * these conditions.
> -		 */
> -		switch (zones_state[zno] & BLK_ZSTATE_COND_MASK) {
> -		case BLK_ZSTATE_NOT_WP:
> -		case BLK_ZSTATE_READONLY:
> -		case BLK_ZSTATE_OFFLINE:
> -			break;
> -		default:
> -			blk_zstate_set(zones_state, zno, cond,
> -				       blk_zstate_flags(zones_state[zno]));
> -			break;
> -		}
> -	}
> +	if (likely(zones_state && zno < disk->nr_zones))
> +		blk_zstate_set(zones_state, zno, cond,
> +			       blk_zstate_flags(zones_state[zno]));
>   	rcu_read_unlock();
>   }
>   
> @@ -1306,7 +1291,8 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
>   	/* Update the cached zone conditions. */
>   	for (sector = 0; sector < get_capacity(disk);
>   	     sector += bdev_zone_sectors(bio->bi_bdev)) {
> -		if (disk_zone_is_offline_or_readonly(disk, sector))
> +		if (!disk_zone_is_seq(disk, sector) ||
> +		    disk_zone_is_offline_or_readonly(disk, sector))
>   			continue;
>   		disk_zone_set_cond(disk, sector, BLK_ZONE_COND_EMPTY);
>   	}


-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
