Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8553C1D57
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447694; cv=none; b=h/8HS0Wxm30/cKVvqtCeqw8SyatC6UOsHNNgCehJqkVRUP/ScsK3jKw/ilC4M8kY5aL6N3FeTYI4VjxB7TzHFBS+E7liDxk5VY8ZPkvmsA77aCxieAuSWoYVmsD75fg2AzqL3Iz+LsWndix96J8ba5j/uWQZTtovATh01Krz4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447694; c=relaxed/simple;
	bh=DrMvIEiZxkBtAdR1BtMIMf6dcCqEfn2axGsdesKWw2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZ72LoRcoElpidDO2KDCo+gIE2C1CO3014pKAyqSHmYSiaAcTrHaC0gwaFtWsmW0fYRA/MZzMPTk9I1zsJdzQfRMK/uMQdlpOjpCGeIfglvO3klMNkaDa1/Rbhvzxnsk9PcUIR+/4lCw6OCOK8J9iQg890xOQlLs3JkIgn3Hp/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yLHm9Ij6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hPR/GrWg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YGIOpoDL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ptX/N7DO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yLHm9Ij6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hPR/GrWg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YGIOpoDL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ptX/N7DO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46F2081B50;
	Tue, 11 Aug 2026 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786447687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDwsl8Ewx6m0mMpk/yXGZHANMoRBKBOigYb1/1aWwLY=;
	b=yLHm9Ij6n3+qIbgaagn+BEQU9rvjqTG2kLnSOQAUMy3lvFHAzDmlhewSsRX+jhXwTOjIEC
	R67s2fDmQLXDxmePFLAjmlxL4ct2249tPYbUeEPJBa80dXdwBYiK7lSOUpCmo8bNguM5aQ
	UAGoQBcmKaPMZKNnhnaGQ5phJIxU6Qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786447687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDwsl8Ewx6m0mMpk/yXGZHANMoRBKBOigYb1/1aWwLY=;
	b=hPR/GrWgpxAinikCUNk/Mhv8Onb/PNGVn/yeC7ACHRw3hZt4rEi/Z7NloiQMWfYTPC4ob/
	nqlwxhn+3o4WnYBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786447683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDwsl8Ewx6m0mMpk/yXGZHANMoRBKBOigYb1/1aWwLY=;
	b=YGIOpoDLlMD7Yu7fWuOcxfnLTv7faEeSzKechWHm2PpY1h1k7K7TqIu2YphLV2wt1uGtDZ
	/BNSLZKytsKHWkB2JKvgTIux8LpmCfCa3rzSE3lCxuUPU/BXajGQBRaLTv6JRghVDuVbpM
	F2SZ5qwwRxSNJZ32eXvwXKR2IXmKZdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786447683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDwsl8Ewx6m0mMpk/yXGZHANMoRBKBOigYb1/1aWwLY=;
	b=ptX/N7DObbKFGoSJExgO+KSkg7uKkBjwqklb8gW1AFheKd/25VEOlDC531O0CqCxYn3/Uo
	MEPLAZtCZdDkJXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30CFD779B2;
	Tue, 11 Aug 2026 11:28:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bb2uCkMHe2oWcAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 11:28:03 +0000
Message-ID: <d6d725c9-4730-4c23-b971-197533fb9067@suse.de>
Date: Tue, 11 Aug 2026 13:28:02 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] block: refactor disk_update_zone_resources()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260811105852.1245357-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.28
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.914];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,lst.de:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 8/11/26 12:58 PM, Damien Le Moal wrote:
> Since the function disk_update_zone_resources() does a lot of checks
> beside updating a zoned disk limits and resources, rename this function
> to disk_revalidate_zone_resources(). To keep all checks together, move
> the capacity check in blk_revalidate_disk_zones() to this function and
> simplify it by moving the check on the number of zones before the call to
> queue_limits_start_update().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c | 46 +++++++++++++++++++---------------------------
>   1 file changed, 19 insertions(+), 27 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
