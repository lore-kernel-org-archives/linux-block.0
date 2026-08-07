Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B645FFB5
	for <linux-block@vger.kernel.org>; Fri,  7 Aug 2026 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098064; cv=none; b=mgvYtlXZJu3f86QtpoIAbSF1jbaYuzEtExnj5ASpSI/VbZNXPGGr3TPfKh5QKxB5hi6P23Hcirt4KN1NbU0bCkrUdS6nWubJIpLiUtZRBvcwp7QmwD/+UWUKMDuY7geO/mBZHlHIsqiUhoNcfcWF8TKCzPnP9nRxK5hSpcBQqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098064; c=relaxed/simple;
	bh=DYtKv3dGtRGHExMGHfIRrpe+9sufHcMwRjJh6iSc74g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZA/onO80xSovNSXgqBcloVde7zCv/8s8k6cM45dVBs8RMD03emrC3g2XDvGpfFfGEvJxdOInLDhA0+4MA2UdGkkIRrYQ/xQ9vHsvoNEJ/lUfMlVyMQwcsGou0W5SUA022M6LzIZHM9IKSw1HBa2G5WMOVYElHzEdKW5Smp5Wcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FgLTZWVk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4AAhXhEB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZS4AsiuY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yHGFFr9E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FgLTZWVk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4AAhXhEB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZS4AsiuY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yHGFFr9E"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F0AE3E0C;
	Fri,  7 Aug 2026 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786098055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzbmb5+k5WTHPrZssyGIIFg2os95SDkrJw8EI98At9Q=;
	b=FgLTZWVkR7O6KGQnSeh9p6p1MsaSOTpQ2Mw5ZO+CQ3kxq7ggYlXcHI+DAptLxs5VyLO8Oc
	m4C7tObsEtwy3q3W072kFDE7L3dOVNKijkSXc5uy3MLTY2gEI5NNfSx7b77HQCJPSo3RzP
	1KMnGzw91IWLyWsPR4G7dP/zb5eI9JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786098055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzbmb5+k5WTHPrZssyGIIFg2os95SDkrJw8EI98At9Q=;
	b=4AAhXhEBmtcPvG+AKkcYK/HHxByEPR5yN6ihrUUxZ8npxjR+MtVDpfff6FEjU/YkZZOpbM
	F8rkiFwkoft+aDAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786098051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzbmb5+k5WTHPrZssyGIIFg2os95SDkrJw8EI98At9Q=;
	b=ZS4AsiuYtgieePn/ocSzU/bvD+/IjHreFTw1Ec+iGScmgjx7hD68ns1+JO02EP0749qUlZ
	w0M4ILW2F0xKgpXrRFi6JKsdP5aJ7gnS7BahNYlzoOBb0RL/6VYouAsjeQnQRjkVpjFM0B
	DdRWfXssYea0g9HRIP3QUmBQhcU8dLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786098051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzbmb5+k5WTHPrZssyGIIFg2os95SDkrJw8EI98At9Q=;
	b=yHGFFr9E0cMZLv3Xgs3D0UUZ5E7HD+FiMCPSb1vddiR74oC31w++QA2udfHmg9Moegeg3h
	96acembKCuoOm0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FF11779B6;
	Fri,  7 Aug 2026 10:20:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9nf1EoOxdWoyPQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Aug 2026 10:20:51 +0000
Message-ID: <e4d46522-9835-4c07-9726-c2eae5775a64@suse.de>
Date: Fri, 7 Aug 2026 12:20:51 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] block: introduce disk_for_all_zone_wplugs()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org>
 <20260806160445.848337-7-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260806160445.848337-7-dlemoal@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 8/6/26 6:04 PM, Damien Le Moal wrote:
> Introduce the helper function disk_for_all_zone_wplugs() to allow
> executing an actor function on all hashed zone write plugs. This helper
> is used to simplify the implementation of blk_zone_reset_all_bio_endio()
> and queue_zone_wplugs_show().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-zoned.c | 68 +++++++++++++++++++++++++----------------------
>   1 file changed, 36 insertions(+), 32 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
