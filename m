Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC94259C9C
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504473; cv=none; b=hgIa/5PwSPIeS9ucOasmk/RsfDwxkd91cx24ic7S3ghzq3+9MJ6Q4ZrNFG9XCzmyz+1SCNA3l85u6I9U8ILm94BgxmB53XJQw09+xQZYRzBlh8b1IqwipsbaQrktHEVdJDHAWHZLXqjpHxC4ge0k30+G9DmyIYntTzfi2APG7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504473; c=relaxed/simple;
	bh=/MmVl3eDMjnVNLqFGMm5G48v7YuNGyAzBJK1p+NQRME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0vyV1Bs7IJ/xTbSi/MptTC3hfMssIq9EHq5+F3I+1yElmrndD3Gi06tBdLfZXS145Xqu2/VNoaTdBA9Ksh1k3fWuU0SARodGGacca0T6XO0Su0BLzVOwKNPI6iZLV26tG8Pnof87EpIBBmSVqyHuISTUdV7E3Me+eygRY8s8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FmeZPGKU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tcu9lFO3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rwv+vac6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HVm7tdHi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FmeZPGKU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tcu9lFO3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rwv+vac6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HVm7tdHi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECD561F6E6;
	Fri,  7 Nov 2025 08:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762504470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ONvZwRyuD3VuaCSC3c6E7KNx1a3gfFXycNSraJo8UY=;
	b=FmeZPGKUwWE9nYgCcvYvJJ/dYeM4fau3aCle5nYx17foHeNyKAqQFL9b/h3xGURUVx4hHq
	ldld5KR+ZZN0Yo3qflis18nEExWCVCrF/qPnWwVZNJl5pmumdjkgZmds72lB4Rb8Ret3s9
	nR6ggvz/jZjDGIDop0ufXnZqe6y0wm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762504470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ONvZwRyuD3VuaCSC3c6E7KNx1a3gfFXycNSraJo8UY=;
	b=Tcu9lFO3iY3CV1yyoG1la7Tu2cOLc0vzalcqcy7dYXGQZ893ycbheI4dbTqOo2+eUzwaOk
	/wG2YZ3GoCC9j/Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rwv+vac6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HVm7tdHi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762504469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ONvZwRyuD3VuaCSC3c6E7KNx1a3gfFXycNSraJo8UY=;
	b=rwv+vac6aKZ0iVpz4iHM3rSdJ6sQDo99Ogwino+qkb/1ZWAyjRij8YNG4r1FKHf62krj9T
	ofkR+G6FfdW9307MLre55/90sA8KUHDZOqLqagLWd/9aK2P1jWWSZT13/V0Qir88qqc9jM
	xVpVd854cVlApjB3JdqE5ohAKY2q664=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762504469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ONvZwRyuD3VuaCSC3c6E7KNx1a3gfFXycNSraJo8UY=;
	b=HVm7tdHiM9Na4F1Fi8YlZeHE7mxkgPQi7gkWARUmWMHW3Rxw1Wkjz5x9KQaBaLN5W7E69u
	U4OSnRL8/2OWHeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B307F132DD;
	Fri,  7 Nov 2025 08:34:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lxA5KRSvDWkJTgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Nov 2025 08:34:28 +0000
Message-ID: <c6272c05-fc9d-47b0-9b89-7f209fc506c0@suse.de>
Date: Fri, 7 Nov 2025 09:34:28 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] block: improve blk_zone_wp_offset()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20251107063844.151103-1-dlemoal@kernel.org>
 <20251107063844.151103-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251107063844.151103-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECD561F6E6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 11/7/25 07:38, Damien Le Moal wrote:
> blk_zone_wp_offset() is always called with a struct blk_zone obtained
> from the device, that is, it will never see the BLK_ZONE_COND_ACTIVE
> condition. However, handling this condition makes this function more
> solid and will also avoid issues when propagating cached report requests
> to underlying stacked devices is implemented. Add BLK_ZONE_COND_ACTIVE
> as a new case in blk_zone_wp_offset() switch.
> 
> Also while at it, change the handling of the full condition to return
> UINT_MAX for the zone write pointer to reflect the fact that the write
> pointer of a full zone is invalid.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
