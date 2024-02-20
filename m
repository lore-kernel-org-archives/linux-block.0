Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70805A7AE
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413736; cv=none; b=Z97KH0/B53MW9aH2ePhs9Uk6tnynACxJxL3oBOEutqkPiGNBXUhprhGXkeYeKzUWvez3z0ifaiVea1+IZcdajc2Hdj5eAEv0/R6z2B7UE4OU0XnmXGI20wKWXhi3GaAJ8FwQ9oy/g7A7QDmqxjMbU1GK6YpquOr97I0j/hJm2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413736; c=relaxed/simple;
	bh=VM514YubvffS0HGZh3x1Wk0HwWDBQEeRtI5voLu2pqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6BH6nN1adCGP3MUB9VS/m3wi0lHRH/e9APghXlUMHe/9ijrJLV/ul15s9J/KXuM+3sasGkj97oXz1AXq00kzl3d0kvBliSFxxprS6Sz5y9RjvuDV5HUhOQXfDMHqTaOIU2U8RzzsImJQ1SlIcJueAi0LuvU7aohFNeFPYOFdhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yMYOhNvO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8uBZyFrR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zwproqzz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JFAJR0pA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yMYOhNvO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8uBZyFrR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zwproqzz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JFAJR0pA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7F831F850;
	Tue, 20 Feb 2024 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVlZWYKj3LyymARpjmbzzdTqFRkIsZN5fl0/Hs3Kvew=;
	b=yMYOhNvOa+BR6NJ5kJ3ZOT80i1Bw0+DV6+vW8xJXbHz9eKAxnVrBexKM6QwOo0+2kho/mS
	OzQHJO3gzTc7QKyo+ZW375299OlMb9UP/JHOOGRDGnIZgjznaYHSoJJ1hyjUzxq4YX65SB
	PzeJxkkkwz/sMdej8kEMOOc0HQxitCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVlZWYKj3LyymARpjmbzzdTqFRkIsZN5fl0/Hs3Kvew=;
	b=8uBZyFrRQEGelBaXzAv2Yyzp78jKWOZGsMSeTGB2QGzMD1gbvb9GHNtox4BF1mdmulLmqv
	MQ2Da/GS5rLwhzCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708413731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVlZWYKj3LyymARpjmbzzdTqFRkIsZN5fl0/Hs3Kvew=;
	b=ZwproqzzKmc1mt9lynkcoWFDzE5jiiLU34c0zM+Zy3LzLm3vCWBYAsltNERqv3WWqAmEUJ
	HSzJfVRxBIIXJHlZw96eD0n/wCbgr0IGM/yXpdPtiNuj60+yoNfk0fEibF43Qt6JL2O4wz
	DxW2RjJ0mS6q6ty+VR+/W9I61P4Ha4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708413731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVlZWYKj3LyymARpjmbzzdTqFRkIsZN5fl0/Hs3Kvew=;
	b=JFAJR0pADPUHv+xwsuugjKRFweYT3qTDCSAs3T2F7BlXVbsMFczkJj5uhkFvN6iIAPAf0b
	TaVkFuYbJyd83sBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BB78134E4;
	Tue, 20 Feb 2024 07:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wEXZGyNT1GUpRQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 20 Feb 2024 07:22:11 +0000
Message-ID: <7bea9e26-55be-4873-9500-cefda595d72f@suse.de>
Date: Tue, 20 Feb 2024 08:22:10 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] null_blk: refactor tag_set setup
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240220053303.3211004-1-hch@lst.de>
 <20240220053303.3211004-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240220053303.3211004-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zwproqzz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JFAJR0pA
X-Spamd-Result: default: False [-3.14 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.84)[99.31%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,wdc.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C7F831F850
X-Spam-Level: 
X-Spam-Score: -3.14
X-Spam-Flag: NO

On 2/20/24 06:33, Christoph Hellwig wrote:
> Move the tagset initialization out of null_add_dev into a new
> null_setup_tagset helper, and move the shared vs local differences
> out of null_init_tag_set into the callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/block/null_blk/main.c | 106 ++++++++++++++++------------------
>   1 file changed, 51 insertions(+), 55 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

