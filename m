Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7B396B9A
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447911; cv=none; b=IK4QQQlVsBc5Pq5xlTL4PxtafLpkzuGQ5DfNYB38GkiXPbbBsuVitLrnzw6YeMzRC7BHO1fw6s5r+0VjuLtIn7Q0WpGWzUm1Xk3IdDv/9/3tck2Wt8lotM3zKythD3SlrczOJJwsZUD9lCzSuur0jqx1narNqSm0KJfbpLFM+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447911; c=relaxed/simple;
	bh=QFc+cSaVFkf5JHLWSJVEksIySIXdNjzP9tTf2CwkvEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njWTpXTna2oXz1hAVbJ1zqpY736cCUn6hktJ7uq0QmuN5/99i0w6FFueJ111jIy7QH7CVp9QldVtwU4rD2XgvAwFcxNpHkegtbjA2uxkcBRuD2i4d2FNNMmp/CO/etJteIad/OjyEl4mHPRwwLoXRQyflxn+n2Bri/i4EL1o2Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iUZWiIlh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bp2tYBBq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fbty6Bo2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JAmvvtLP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iUZWiIlh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bp2tYBBq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fbty6Bo2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JAmvvtLP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2210D3E07;
	Tue, 11 Aug 2026 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786447904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIHtgnZlC3Fy5Fa3lvmdIuijUDq7e2zVXjLCpGbVZ6Y=;
	b=iUZWiIlhqHiXB1pHyvOlk/ovLU5Kas/24Wn83c1I+niq+T/r0XnpL8C+zmzxyPW2WrXHM+
	bKtTy5rE1nRaCvIQYlrAszDS9LL5CPx+oHBNgdR4MHtvSK988OivXpaY6Ftx/CeWFsCu2O
	cPHjj3b6R4sz+Yf3KWrwg6RWU9w5bfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786447904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIHtgnZlC3Fy5Fa3lvmdIuijUDq7e2zVXjLCpGbVZ6Y=;
	b=bp2tYBBq8VM+npUa3K/k48Zms/DVMS6ySgD3fI14RavSPueDLNt5qBPLGp6y+hO2yNbFlK
	jH2Mu6OyugOGfEDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Fbty6Bo2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JAmvvtLP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786447900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIHtgnZlC3Fy5Fa3lvmdIuijUDq7e2zVXjLCpGbVZ6Y=;
	b=Fbty6Bo2msF7vZa8ncXJJEp8NyUY56lkZ6z4Tc4MONK2gssrH2sFD5XloRPbclwFPuApY0
	odnS0AG7FMchjQyUYm4ZpMo4saplXiA/RPKnvK7Rk1BD+oJ2BoiCwQUwYmwdJggCjKJ7zC
	2FnGJdcr4nSmzR2pL67tWxPzK2i5zbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786447900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIHtgnZlC3Fy5Fa3lvmdIuijUDq7e2zVXjLCpGbVZ6Y=;
	b=JAmvvtLPUOpWcUbRlf1+bUmnVEcRJPRF5/nH3mzj28QOG8QxwJOyCBZPp7A3v0i13GGMO9
	FIBZSpg6PBkwCRBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 146B9779B2;
	Tue, 11 Aug 2026 11:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qTmUBBwIe2qQcwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 11 Aug 2026 11:31:40 +0000
Message-ID: <63bba9b8-9dd9-4a6f-ac59-7dc5c67f3c58@suse.de>
Date: Tue, 11 Aug 2026 13:31:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] block: introduce disk_for_all_zone_wplugs()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-7-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260811105852.1245357-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2210D3E07
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,acm.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 8/11/26 12:58 PM, Damien Le Moal wrote:
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
