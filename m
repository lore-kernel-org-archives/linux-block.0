Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B63443230B
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929047; cv=none; b=d/pzBcdhj5ZB+3hjyvDIMHfnVN12cvF69sbG2ntsygixxHg9BjsgvfXbi5PyKqHxj+T+2URwnKtomX+QK+YR36Epr0GFerWLdPH4snF8XC6fNM0jvGNeAl0qXapIFf2+/0Oxfbl6v+ctzADaEpvIFGaxsGDuLBQsiXD9Z/AnUm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929047; c=relaxed/simple;
	bh=8+OCWQU/xZe9LKYLjGRRMEWXlV36JHbNdWYbtrjWEmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9M5gRJKfWOHcMxeT9Afy8A1VjHNaB6kMkcZhZT0djqOAZv4PNINRCb+Z35Wfh3lMBS2t+ZV2wGQtaK3GdcdBldN4gkztfiyHSk51gzmexojO4gpcZBDfEt8h880Zg62m9IPuwAGH7sfbwmp9WIzmqF8gmYqanawSqdGw49LVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tBZ+UeFQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6AmDu0od; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S+rMGY7t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v0/WGWIl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tBZ+UeFQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6AmDu0od";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S+rMGY7t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v0/WGWIl"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01E1540F7;
	Wed,  5 Aug 2026 11:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785929040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h75zj8tBXx1teuIPXSsJHcyTdx8+zTeojDelqPH+Ebs=;
	b=tBZ+UeFQv1+4IdmwwDXjBuawQVrRmDEM9x+l3qt43zZRJy6Cy2FAC2lm0EaIv5dX8ib97c
	sEjoiJPx7IFhM6kBDTvJcNirTCUnbMvx9drvbUmfCe35CGIbGiGyft2bXOPaW34eUrixQ/
	iHrWGe5thTlxUc3qfUqJ5damx3wyAFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785929040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h75zj8tBXx1teuIPXSsJHcyTdx8+zTeojDelqPH+Ebs=;
	b=6AmDu0od4JFW7WCd15RoBJQhlbQgD8r1faX7FPuWC5PYtqAZgCkz7fbFGXS7D/2k/LRBBv
	uviKVNcYazcOz7CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785929036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h75zj8tBXx1teuIPXSsJHcyTdx8+zTeojDelqPH+Ebs=;
	b=S+rMGY7tbBWwMOqaTl+V7FQL4OiN6SLoQqyUZpzfwvrXxBcT61wBxO0RE/nwfqexMaBdOL
	pNuPatY6P3snapsRPJ0z4Kr+aaT6AE/5WhQAZoMxGL5iTaXZkbhIG3qG1oayqfqyGMKzK4
	ldgdA1wIpzyf9+6D7yyDLODXUZN0Pec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785929036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h75zj8tBXx1teuIPXSsJHcyTdx8+zTeojDelqPH+Ebs=;
	b=v0/WGWIl/QhUjVAmHaXFzjSNFMQYPjVLHKs6LQylT1sbEoKMpRL70xBht5YrKgn/gUIGOA
	KD8gv/unbkXaz1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E75A8779B6;
	Wed,  5 Aug 2026 11:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +Df0N0sdc2p2KwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Aug 2026 11:23:55 +0000
Message-ID: <88c28d3d-ea11-4a45-8cbf-0dba05d66530@suse.de>
Date: Wed, 5 Aug 2026 13:23:55 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] block: refactor disk_revalidate_zone_resources()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260805022719.735323-1-dlemoal@kernel.org>
 <20260805022719.735323-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260805022719.735323-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 8/5/26 4:27 AM, Damien Le Moal wrote:
> The function disk_revalidate_zone_resources() is misnamed as it does not
> revalidate anything but rather allocates the revalidation arguments and
> then calls disk_alloc_zone_resources() to initialize the disk zone
> resources if they are needed and not already allocated.
> 
> Make this function less confusing by renaming it
> disk_init_revalidate_args() and moving the call to
> disk_alloc_zone_resources() into blk_revalidate_disk_zones(). As before,
> this function is only called if the zone resources are needed and not yet
> allocated.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 69 ++++++++++++++++++++++++-----------------------
>   1 file changed, 36 insertions(+), 33 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
