Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0E32FA13
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709056; cv=none; b=ZawoxWOHSY/1qLYUy6ZgxY4vysuB7Qc2bbQz7k4uVvoN2TcOCkSsgB3/r8wPkEjttpLjnJZ3SM1voEIOFe9rwqMxss6tfl1WFGjucga+P5tqvAWbyMJhGgUNPJrpFZqE1JUYzssRGooqjL44c+xnxTQsiK5N50CrYJhyylkyvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709056; c=relaxed/simple;
	bh=2biPTcE3uLMKple0PUFtCJ1j/ZmjHGXCFW45q3bkGkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qi/16foK4FoDZe/ek9/KTziaEuhC0qa+RNqbc9lS+gcco1tK6UQfSkET8VEOPo8+CnWFpdbKdy/Pgev37fIriderGJCEWKnZ+OWJs0FTAbn+qa53INjfxbqNYAi+2sCjTbMvGFxFKelmFhjHFGuwhvjf/jpWXv4rPwYNQtQW/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jhkKIlHQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=72MFnFSm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jhkKIlHQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=72MFnFSm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jhkKIlHQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="72MFnFSm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jhkKIlHQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="72MFnFSm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E19421221;
	Fri, 21 Nov 2025 07:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763709053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BRwxqcyROhK8KtpJRqmt8Io99aeBFumPUoHFBxklHs=;
	b=jhkKIlHQQ+Yx7YgIcYtuXHqrDyFe1QXK/eefJ457fS2x1rWK7GGyQWyvweK9Q3yzyPOGZS
	2cXy71tyxPV0CgeeywNmCMnGcWBk39PI/W4KxRnv8psoCS/l7xoZ8teafvTqcPa3X2TR8t
	XgAi45vTlL0IWq7+eEXzAD7JuO2tCUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763709053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BRwxqcyROhK8KtpJRqmt8Io99aeBFumPUoHFBxklHs=;
	b=72MFnFSm4nAubX2zxa0a1OejPvpHA4I3Dj7yXZ6xa+qhjjBxqzboSrZ6yaVi0m9H/Tp+Qk
	TNPrVJubbWKoDODg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763709053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BRwxqcyROhK8KtpJRqmt8Io99aeBFumPUoHFBxklHs=;
	b=jhkKIlHQQ+Yx7YgIcYtuXHqrDyFe1QXK/eefJ457fS2x1rWK7GGyQWyvweK9Q3yzyPOGZS
	2cXy71tyxPV0CgeeywNmCMnGcWBk39PI/W4KxRnv8psoCS/l7xoZ8teafvTqcPa3X2TR8t
	XgAi45vTlL0IWq7+eEXzAD7JuO2tCUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763709053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BRwxqcyROhK8KtpJRqmt8Io99aeBFumPUoHFBxklHs=;
	b=72MFnFSm4nAubX2zxa0a1OejPvpHA4I3Dj7yXZ6xa+qhjjBxqzboSrZ6yaVi0m9H/Tp+Qk
	TNPrVJubbWKoDODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3D9C3EA61;
	Fri, 21 Nov 2025 07:10:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p9NRHnwQIGkPcQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Nov 2025 07:10:52 +0000
Message-ID: <514960af-e392-4d12-9bdb-611b7e420e24@suse.de>
Date: Fri, 21 Nov 2025 08:10:52 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] blk-mq: factor out a helper blk_mq_limit_depth()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251121052901.1341976-1-yukuai@fnnas.com>
 <20251121052901.1341976-4-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251121052901.1341976-4-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:email,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/21/25 06:28, Yu Kuai wrote:
> There are no functional changes, just make code cleaner.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>   block/blk-mq.c | 62 ++++++++++++++++++++++++++++++--------------------
>   1 file changed, 37 insertions(+), 25 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
