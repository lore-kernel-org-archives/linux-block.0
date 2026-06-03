Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E58382F18
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451600; cv=none; b=M85fD180ro2MPtMjQGy6nWaHcrV9xJc+zp+3LlufhEH2CFH5+pQ4l4szpG5Eo/GjnIOdE3URpr/JRH0doVS81SORabZPrw+qtP9GW7L2UYXYblEeFG1bQvKKey4u208VkPrXhIR9OHgiEw3oHW5225DHdPVHrEqQGBTrgIAlDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451600; c=relaxed/simple;
	bh=V5HVWyZYUlOOAFNtVLI5X3ue9Ei2knj+V8sRIvN3Ceg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBauglb+WJTAvjqXhurAFvbACUKJEn2XPCbBBjM5FrpHFAFMDi3wtOU+deeQFDbSxtdfR3vd91EOTEN/hb7AXs8sizS+F5MoZMMq72ekOXNSWV8KhkAGa6P6rEuPoZhtcClgygOtVriS3+NFipF4nfbcCe4znNk9bGp7ZpaxuOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yTYBMTa5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XZmZZxCp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yTYBMTa5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XZmZZxCp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yTYBMTa5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZmZZxCp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yTYBMTa5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZmZZxCp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A77E6A7E8;
	Wed,  3 Jun 2026 01:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780451597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tahRP1/1iSSvaqS1bNFS55EF0prFmI52wEWmn9Dy5YQ=;
	b=yTYBMTa54GJ8xliJFXPmfCQNKHnCIwn8nnOvsU3gMoHo1lyuTX0Jja1QYYVCyApm/NXPwT
	iHbpdJxcMd4QslxP3rm0BW0Q5UPGH8Lo2ixtbCczU+mB9hP64umY1caH2edLMEk3v+V59A
	ZCyJLQ/mXEl6Hv2YhtIDtbwjQ0OriI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780451597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tahRP1/1iSSvaqS1bNFS55EF0prFmI52wEWmn9Dy5YQ=;
	b=XZmZZxCpqanx6Phar5fehsuidhqflwizA7g2XlAdmid1D1dPohlEXeXrqhT6UPdYIxEegc
	Fxhp4rpnz8ULiKBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yTYBMTa5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XZmZZxCp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780451597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tahRP1/1iSSvaqS1bNFS55EF0prFmI52wEWmn9Dy5YQ=;
	b=yTYBMTa54GJ8xliJFXPmfCQNKHnCIwn8nnOvsU3gMoHo1lyuTX0Jja1QYYVCyApm/NXPwT
	iHbpdJxcMd4QslxP3rm0BW0Q5UPGH8Lo2ixtbCczU+mB9hP64umY1caH2edLMEk3v+V59A
	ZCyJLQ/mXEl6Hv2YhtIDtbwjQ0OriI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780451597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tahRP1/1iSSvaqS1bNFS55EF0prFmI52wEWmn9Dy5YQ=;
	b=XZmZZxCpqanx6Phar5fehsuidhqflwizA7g2XlAdmid1D1dPohlEXeXrqhT6UPdYIxEegc
	Fxhp4rpnz8ULiKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC64F779A7;
	Wed,  3 Jun 2026 01:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3iVGIguJH2qScQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jun 2026 01:53:15 +0000
Message-ID: <8e905e08-a999-4b6d-bfab-86ff9bb9d552@suse.de>
Date: Wed, 3 Jun 2026 03:53:13 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] block/blk-iocost: Split ioc_rqos_throttle()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
References: <cover.1780419600.git.bvanassche@acm.org>
 <8037f3bb5f5ecbbd635ef48804a1a9ad2d2be2e0.1780419600.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8037f3bb5f5ecbbd635ef48804a1a9ad2d2be2e0.1780419600.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8A77E6A7E8
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,acm.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/2/26 19:07, Bart Van Assche wrote:
> Prepare for inlining iocg_lock() and iocg_unlock() by moving the code
> between these two calls into a new function. No functionality has been
> changed.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-iocost.c | 163 ++++++++++++++++++++++++++-------------------
>   1 file changed, 94 insertions(+), 69 deletions(-)
> 
Not a big fan of the 'action' enum, but I don't see a better way here.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
