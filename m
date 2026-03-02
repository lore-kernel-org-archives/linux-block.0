Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6C3815ED
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436146; cv=none; b=a4Z7eI7yH6NLwxyo+fA8TuWxO6GHmJ3nDc/Kyyr85ZB9dDZtVYCURCYIHwBIIbHCg2NaLdVbKmivpBLU0R0x6DsUH3s12LUfkH3RYrQzngzFVpK4cYQfsnAjCqZhVu5bjnuKQGwRgmlnaU2OU6QXtMcymd5bURHAlyKKwGgpY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436146; c=relaxed/simple;
	bh=DOpQ0c3rMbYEUT2vHwToRc2830vsOQnCH5MWhMkZdq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FBsXbWFyzBV4MIfgtjimJt+E8gxTNWFV7PzbKSDYFrvsCq1JP2ebm7Ok/w7YDh8WZVMKIoUzE1anW/pQoIWcH0a/04l/4NzNlEWTxCADf836AhfVuqdnvN2s4fuN1A5OQpUgELt7//iR9RiRvnBitjYlK2fY/ftkIwopfU+pr3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ssBUOgy6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yxx2eIlu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ssBUOgy6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yxx2eIlu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ssBUOgy6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yxx2eIlu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ssBUOgy6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yxx2eIlu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 936055BD19;
	Mon,  2 Mar 2026 07:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772436143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtxdkPBgWWqNrpQ0W9PzrW/JxY+Z7IRbiwjqvcxGF/k=;
	b=ssBUOgy6RiHhLWsO3hHVYjnLPM3xcFSd8eBDPSx+JwsazYCMlPhxbO2xW5/QvwE0BkXbpO
	khx/7QYqUrVsgPYHtIgkeXJESPu3lv+FaCaB0Qm/9DrIxfev5xHB5gf2s3YV/S6WQnPIV5
	nsPO/AFc/c8Ahhku47I6NpZSq8w+1OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772436143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtxdkPBgWWqNrpQ0W9PzrW/JxY+Z7IRbiwjqvcxGF/k=;
	b=Yxx2eIluexRbdTELle2gHFJE9PXTZ/5/df/+mV2oOTwP8j1G+R+KNDj/sghGPRtEmg8sX6
	k2qsQuGccxH0PDBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772436143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtxdkPBgWWqNrpQ0W9PzrW/JxY+Z7IRbiwjqvcxGF/k=;
	b=ssBUOgy6RiHhLWsO3hHVYjnLPM3xcFSd8eBDPSx+JwsazYCMlPhxbO2xW5/QvwE0BkXbpO
	khx/7QYqUrVsgPYHtIgkeXJESPu3lv+FaCaB0Qm/9DrIxfev5xHB5gf2s3YV/S6WQnPIV5
	nsPO/AFc/c8Ahhku47I6NpZSq8w+1OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772436143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtxdkPBgWWqNrpQ0W9PzrW/JxY+Z7IRbiwjqvcxGF/k=;
	b=Yxx2eIluexRbdTELle2gHFJE9PXTZ/5/df/+mV2oOTwP8j1G+R+KNDj/sghGPRtEmg8sX6
	k2qsQuGccxH0PDBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 773083EA69;
	Mon,  2 Mar 2026 07:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aQk4G686pWn5bAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Mar 2026 07:22:23 +0000
Message-ID: <8143b7bb-c599-4335-8d52-41d26e4fc3e3@suse.de>
Date: Mon, 2 Mar 2026 08:22:23 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] block: rename and simplify
 disk_get_and_lock_zone_wplug()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260227014951.2327711-1-dlemoal@kernel.org>
 <20260227014951.2327711-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260227014951.2327711-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 2/27/26 02:49, Damien Le Moal wrote:
> disk_get_and_lock_zone_wplug() always returns a zone write plug with the
> plug lock held. This is unnecessary since this function does not look at
> the fields of existing plugs, and new plugs need to be locked only after
> their insertion in the disk hash table, when they are being used.
> 
> Remove the zone write plug locking from disk_get_and_lock_zone_wplug()
> and rename this function disk_get_or_alloc_zone_wplug().
> blk_zone_wplug_handle_write() is modified to add locking of the zone
> write plug after calling disk_get_or_alloc_zone_wplug() and before
> starting to use the plug. This change also simplifies
> blk_revalidate_seq_zone() as unlocking the plug becomes unnecessary.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 26 ++++++++++----------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
