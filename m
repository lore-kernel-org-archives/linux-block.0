Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836BF22F745
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490877; cv=none; b=TLOgsUDCq2Qw0FvVpLe5IYwDu3752wUxcR70p9qSJ8vppYOUs2E0jmJmgzFpfs3izXIzwToJZzyP/wMtSP4XPamG7zRH5RkFkAu1KEJsoPzQN8WyxlieJo+MpdRK6sBI3SeKLdRPZANTk0ehT39HFw2yCzUkhULSw3goVeTonZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490877; c=relaxed/simple;
	bh=oOeMArBBpv2H16GPK+D9psHWM7T02BgtLkZ0841uj1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbQ4kxiVcWmFkdzF5V0GO8eJZ8w3vgPCdoy85+i+nYwXJUT0hcoirA8lulOsobRktk61WiciPlp13t4461oAk91mpmiPz27zTsT5Gh37gMf8aSJDrNsx2MAW5iWKaEb5YEP7nanyLGUr4bjXbI1jeXKoTyRSChYOS5I7NAVDHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IyJODjYp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UnVbAyxs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IyJODjYp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UnVbAyxs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IyJODjYp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UnVbAyxs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IyJODjYp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UnVbAyxs"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A31721188;
	Thu, 24 Apr 2025 10:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745490872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5i8NWYJkZQso+bDNPOp3oKxsk4hm+g1+Fuxt2hFTs4=;
	b=IyJODjYp6wLs9vnwNZ9Kow45IN+3GyXAqHXoSzuq2lUXxLsDoqGsM1LPh8yiW0Y4Uc5bsU
	nIDqrgSrq0baPAIXu1PPkF1N6jRKlRITeeXSW+132JA4B1lR/rEDRTp+/9DBFBcUNCBiDr
	WyeO3jmX0k69TrqVs1yGfmyRkkKmk7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745490872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5i8NWYJkZQso+bDNPOp3oKxsk4hm+g1+Fuxt2hFTs4=;
	b=UnVbAyxskGkhny0/QlALzgHFCl/XJCoeDCDlit0xa+ita7g4EtLKuUowkz+DPKHt8+zEs9
	tlTQjJ8yO0ZJIoCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745490872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5i8NWYJkZQso+bDNPOp3oKxsk4hm+g1+Fuxt2hFTs4=;
	b=IyJODjYp6wLs9vnwNZ9Kow45IN+3GyXAqHXoSzuq2lUXxLsDoqGsM1LPh8yiW0Y4Uc5bsU
	nIDqrgSrq0baPAIXu1PPkF1N6jRKlRITeeXSW+132JA4B1lR/rEDRTp+/9DBFBcUNCBiDr
	WyeO3jmX0k69TrqVs1yGfmyRkkKmk7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745490872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5i8NWYJkZQso+bDNPOp3oKxsk4hm+g1+Fuxt2hFTs4=;
	b=UnVbAyxskGkhny0/QlALzgHFCl/XJCoeDCDlit0xa+ita7g4EtLKuUowkz+DPKHt8+zEs9
	tlTQjJ8yO0ZJIoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 797DF139D0;
	Thu, 24 Apr 2025 10:34:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MRs/HbgTCmi+LAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 10:34:32 +0000
Message-ID: <901f88c2-22ed-479d-98a4-2e9c21b0ff31@suse.de>
Date: Thu, 24 Apr 2025 12:34:32 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: never reduce ra_pages in blk_apply_bdi_limits
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
 =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
References: <20250424082521.1967286-1-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424082521.1967286-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/24/25 10:25, Christoph Hellwig wrote:
> When the user increased the read-ahead size through sysfs this value
> currently get lost if the device is reprobe, including on a resume
> from suspend.
> 
> As there is no hardware limitation for the read-ahead size there is
> no real need to reset it or track a separate hardware limitation
> like for max_sectors.
> 
> This restores the pre-atomic queue limit behavior in the sd driver as
> sd did not use blk_queue_io_opt and thus never updated the read ahead
> size to the value based of the optimal I/O, but changes behavior for
> all other drivers.  As the new behavior seems useful and sd is the
> driver for which the readahead size tweaks are most useful that seems
> like a worthwhile trade off.
> 
> Fixes: 804e498e0496 ("sd: convert to the atomic queue limits API")
> Reported-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> ---
>   block/blk-settings.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 6b2dbe645d23..4817e7ca03f8 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -61,8 +61,14 @@ void blk_apply_bdi_limits(struct backing_dev_info *bdi,
>   	/*
>   	 * For read-ahead of large files to be effective, we need to read ahead
>   	 * at least twice the optimal I/O size.
> +	 *
> +	 * There is no hardware limitation for the read-ahead size and the user
> +	 * might have increased the read-ahead size through sysfs, so don't ever
> +	 * decrease it.
>   	 */
> -	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
> +	bdi->ra_pages = max3(bdi->ra_pages,
> +				lim->io_opt * 2 / PAGE_SIZE,
> +				VM_READAHEAD_PAGES);
>   	bdi->io_pages = lim->max_sectors >> PAGE_SECTORS_SHIFT;
>   }
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
