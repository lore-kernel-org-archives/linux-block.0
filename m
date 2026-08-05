Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C53C3F60
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928676; cv=none; b=suD/5fh3IPxzGWefYMqBRUIp04d9Z3bMvQGguiEkN+pSBDGMnf42uEkGBgEKlbA4Hhycb5b7u9nxm5XYbkEiMae3KYjnAobX5XWjgDKn3x2fxsJeteJ9Rse0D8cZqzYVo+/O+Orh+OgoNIpIhvgbhxJmU7FE60LinSAGzrLPwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928676; c=relaxed/simple;
	bh=Hb9F/UF7dtU68csZWaqB+NlzB7GDDcXQFtZBMaviBRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTB6WT/KAGkOCPdo9qVl3VjzRtEOG3PHbtqBUB6o0tLeCp1xYfLcVO/f56ytc80HpxpJgQihwr0djvvmfl4OW8w5nPhWyqhkY3a80ynOxoyKPtA017eYXRvmU22/qXnvALfd7wcKcXGLYYSrnJOa1fddXrsvEHCASzc8IxzRIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lGqjJgER; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XrZKCkgo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wuF7ZMxM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u3EANBnR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lGqjJgER";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XrZKCkgo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wuF7ZMxM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u3EANBnR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DFBF419A;
	Wed,  5 Aug 2026 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785928669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8LfVZF9pSbtmoqyPkYjiE2+20An/VBpboaxlj9Ttx4=;
	b=lGqjJgERLvRJUx/nDbuQDqOoFGvvYmuDoZbXZ2hP+1HESZX2vP4yms0+cKu/TfzkI7S6y1
	piWdA77zFZWEDRp1uR5FuDvBj5sS1TndPT6deKCtGcmYwmix1ZSMa1VBOfxGlSSqNg3db3
	U5giZW5shRY4i1IZRpn/ckgHcmXVmK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785928669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8LfVZF9pSbtmoqyPkYjiE2+20An/VBpboaxlj9Ttx4=;
	b=XrZKCkgo1DXEGS2VhGI/VkISMSyTEmE5Qo7GAbbSE3G1Q4eAw6qrxAd8zEluMP3f3tnFYy
	X2ZnOTX9pE6YUEBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785928665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8LfVZF9pSbtmoqyPkYjiE2+20An/VBpboaxlj9Ttx4=;
	b=wuF7ZMxMYZKX57aDWThkMXLqUI5t/2u7LWRTnjxopouoUvLtnQ+YjtFp8hfSV/Mel2uj6L
	OkwSLOLrFDBlpoRXE+bgPrm+XBUsU8eY9eqOKDIuVwxHnjT/+mYeT0TebP6t2Qqu8SnVma
	edw7HlT8W5OqTz4glfr+9Dp9e5qmB9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785928665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8LfVZF9pSbtmoqyPkYjiE2+20An/VBpboaxlj9Ttx4=;
	b=u3EANBnRo4iffSdvLgvilt2oAP+4SvCVayZcOSxpsdMDu9ofpo2HaDHBi+KaEWiwzoV3Eu
	dtBTHiAtPar//3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 343F3779B6;
	Wed,  5 Aug 2026 11:17:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jqz1C9kbc2rXJQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Aug 2026 11:17:45 +0000
Message-ID: <605be780-e25f-4566-b67a-f13731bb4fc4@suse.de>
Date: Wed, 5 Aug 2026 13:17:44 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] block: remove disk_free_zone_resources()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260805022719.735323-1-dlemoal@kernel.org>
 <20260805022719.735323-2-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260805022719.735323-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On 8/5/26 4:27 AM, Damien Le Moal wrote:
> In the rare event when revalidating the zones of a zoned block device
> fails, the device capacity will be dropped to 0. In such case, the zoned
> block device will either be rescanned and restored or dropped entirely and
> its gendisk destroyed. So calling disk_free_zone_resources() from
> blk_revalidate_disk_zones() in case of error does not make much sense. We
> can keep the zone resources in case the device is rescanned and restored
> or simply free all resources in disk_release_zone_resources() when the
> gendick is destroyed.
> 
> Remove the call to disk_free_zone_resources() from
> blk_revalidate_disk_zones() and squash disk_free_zone_resources() inside
> disk_release_zone_resources(). With this change, the conditional creation
> of the zone write plugs work queue is not necessary anymore as the
> workqueue will keep existing together with all other resources until the
> disk is released. This simplifies disk_alloc_zone_resources().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 56 +++++++++++++++++------------------------------
>   1 file changed, 20 insertions(+), 36 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
