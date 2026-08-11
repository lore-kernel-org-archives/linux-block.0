Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651DF29D29F
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448756; cv=none; b=my5GC87qX0f62V/k8mjNw0oqsHQixrGtw3KnpXmcDNuF4TE1AKLTEy0hVqs04Wdw1h6jxh5oyKrFmWWLlbtDW9ihHOH2KbslMDLueM0yJCJiHey1KDEgcMoBGKi3ndfwGqx1dhmw99WItymxvFhSFt0sXaDmxgg9MhqKWNIAkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448756; c=relaxed/simple;
	bh=yUNnpUAFSCFH/tw35BJzInEf35keYsOLxvYs1I6ajlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkfiyFIWieFAUMEnzkV4Hz0yvKT9+JiOb6/d6FxqG9sEaN29vdr/XBwZtc6uty/pMnvybjoMyyz4OvxeD0srKC4BC/vWa5xJJUpNPAd5QokPs8IRqttLT4pA5Mk2zQTCR3zAULo8uZrT99g46sq9yoeZg6QGNTPSd5WBNGZq240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BbyDVTqY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lRmjS49R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jvFMWbFI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8Js5vJQx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BbyDVTqY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lRmjS49R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jvFMWbFI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8Js5vJQx"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 210F381B8F;
	Tue, 11 Aug 2026 11:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0f21WizMaobUwmJCMZysANicnKlKiGMC+glgPwVQJ0=;
	b=BbyDVTqYaeB5jqCkzZaDRRJUC6OH8j/4Fw4nKgm0ZviCzUYdjM1l7j/TMOPfu7/6lN81a4
	kwQq78KFlhu4PfknWnuIXlpj263k6Z5l0fvUVTNfA5q5XyOuhudEWv5HLRB1b+Egv5ntmg
	q3LU3D4GZRIQyau+PeteEvYzNj1natY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0f21WizMaobUwmJCMZysANicnKlKiGMC+glgPwVQJ0=;
	b=lRmjS49RCeWG0fj1CclNeqJtL1JyEgG9JxJ9OC341ce8jwIcwaz5Q+ynkjqdSi8P6Cyzj9
	g+JyvyZtV+WoLpCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jvFMWbFI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8Js5vJQx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786448740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0f21WizMaobUwmJCMZysANicnKlKiGMC+glgPwVQJ0=;
	b=jvFMWbFInnD5MxL7AxnRaKtZ/UQeq76K4z3yBujKjGjY6blBWrqjrNDPDjGT3Bd42WH+/G
	jpyrzFRG/pq2v9NO6uO32+KCNqSh04dN+qTN5oF8biJ1sAUUWeqBserxmyqDXT60Ro/Vnk
	TfRw7cuAAipTEvrI+cJskvpcMPblmrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786448740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0f21WizMaobUwmJCMZysANicnKlKiGMC+glgPwVQJ0=;
	b=8Js5vJQx/vPbXGVpU/VedZxXIYv1sVYGUzSSv9+u/i1jNabrGQTmLTomcNwfw/BZ0NMaGk
	nnsRL1kLhs7KhKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13692779B6;
	Tue, 11 Aug 2026 11:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KPFMBGQLe2pzAgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 11:45:40 +0000
Message-ID: <014e0f95-ecbb-42cd-b3b8-94cc8bbccc93@suse.de>
Date: Tue, 11 Aug 2026 13:45:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] block: flag zoned disks with GENHD_FL_NO_PART
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-14-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260811105852.1245357-14-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 210F381B8F
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,acm.org:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 8/11/26 12:58 PM, Damien Le Moal wrote:
> Zoned block devices do not support partitions. However, the partition
> table is nevertheless still inspected, and any partition found ignored
> with a warning in add_partition(). While this is generally not a problem,
> and in fact beneficial to the user as it indicates an invalid use of a
> zoned block device, scanning for a partition table on the device may
> result in issuing read operations to offline zones (e.g. after a disk head
> is depopulated for disks that support head management operations).
> 
> Since partitions are ignored anyway, completely disable partition scanning
> for zoned gendisks by setting the flag GENHD_FL_NO_PART in __add_disk().
> The existing check in add_partition() is left as-is to ensure that we
> still get a warning if for whatever reason, despite GENHD_FL_NO_PART, we
> still endup trying to add partitions.
> 
> Flagging zoned disks with GENHD_FL_NO_PART also has the benefit to expose
> through sysfs the ext_range attribute with the value of 1 instead of the
> default DISK_MAX_PARTS, thus correctly advertizing the fact that zoned
> disks do not support partitions.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/genhd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index e8ce0cabf392..34a64077ba02 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -447,6 +447,13 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
>   		bdev_set_flag(disk->part0, BD_HAS_SUBMIT_BIO);
>   	}
>   
> +	/*
> +	 * We do not support partitions with zoned block devices, so do not try
> +	 * to scan the partitions table.
> +	 */
> +	if (blk_queue_is_zoned(disk->queue))
> +		disk->flags |= GENHD_FL_NO_PART;
> +
>   	/*
>   	 * If the driver provides an explicit major number it also must provide
>   	 * the number of minors numbers supported, and those will be used to
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
