Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE0420010A
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451996; cv=none; b=V7IurRNBHffhuqmoItWWQTU3lckziL62py473A2CERQAFUu8IWDnkX6GdA8lMnt1/BabQGpXI7DSZ913tToCixjmZtU1oasAY2u30jN8EeA0mJ2H5WT+2uEZIY471zWAQSZUsqlJ7ACkQdgzg0n2r3t4A98Zu69xlcdYdAVa7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451996; c=relaxed/simple;
	bh=1hVbtK9p2VYgFTECyuhzMT3jbs4HA9nPHjW9KYHC19E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lt7pTmxdyIxke9og6hVfI0fh85DtnlR202tZbLBGNCExPQR7SZZxmrRe3LU+7UZ3syhqOUpSrfBKw41kEGwh+lY9aM/32zP+38Lg9MVQL5sN3qyVYvK/ANrW9bVAekgUJjgOTMqmyLCM/u20mJPc2qymLk30imLA369GHfSAvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vtsQ4W4t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c6NDL04d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mvx5fbp2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GQHYV8HI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vtsQ4W4t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c6NDL04d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mvx5fbp2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GQHYV8HI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C31166F90;
	Wed,  3 Jun 2026 01:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780451993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXYO5qzYjvqrtmc52ULJE7bva37HgsqCXLH8UTo0iY4=;
	b=vtsQ4W4t5OVJQW1n8VcB23qUv7gIZEN7mjqeL+dVrJBZbtvrTAXvD4/z5w032tXFDyu80W
	x0avsH1woxyejikFDNx/k2XFQQG+FkLlfKVKH6Y+X9fRNdb4idq3keDLM9yY6ly4G+B65u
	mdZNGPi8XnyAHHxMUvQZF78/Gf7jxOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780451993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXYO5qzYjvqrtmc52ULJE7bva37HgsqCXLH8UTo0iY4=;
	b=c6NDL04dmd7RpZoxOkPky6xqlNFCMgQinCqGsFRSl/pJt0xp5zXf7ZZRg+3hFoiPcMAfGT
	gtiR+c0cH3bRLkDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mvx5fbp2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GQHYV8HI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780451992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXYO5qzYjvqrtmc52ULJE7bva37HgsqCXLH8UTo0iY4=;
	b=mvx5fbp2vhgqvTLORzSSgc54/hCAAiJUUzPePvrVNT3kk9jd9kmS5AsGd5SK2l5fY4CTBP
	LxppxeV1zDq7SJI/EVpSrOxUUp3NmYZVdSOvxG3Pr43lzcnXpQIEHa1YW00LnxOeHlheFT
	Ezh6zFzaH5nL28lugrmgtOTaTtugB98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780451992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXYO5qzYjvqrtmc52ULJE7bva37HgsqCXLH8UTo0iY4=;
	b=GQHYV8HIxFW2fhFHpEP/BvEkLitCxlgWTJCNrS4jDkkBQEYo2E+19FXCUoqGMNnCI874y9
	ov7v7bbTJbR/hPCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC1DC779A7;
	Wed,  3 Jun 2026 01:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BRjEJZOKH2qvdwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jun 2026 01:59:47 +0000
Message-ID: <2a5a7139-3fcc-4065-9685-d179e9fc78ba@suse.de>
Date: Wed, 3 Jun 2026 03:59:44 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/14] block/blk-iocost: Inline iocg_lock() and
 iocg_unlock()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
References: <cover.1780419600.git.bvanassche@acm.org>
 <e0e81fbd746bfb54c31cb84f8671a0c23dcdedb2.1780419600.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e0e81fbd746bfb54c31cb84f8671a0c23dcdedb2.1780419600.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7C31166F90
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/2/26 19:07, Bart Van Assche wrote:
> Both iocg_lock() and iocg_unlock() use conditional locking. Fold these
> functions into their callers such that unlocking becomes unconditional.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-iocost.c | 49 +++++++++++++++++++---------------------------
>   1 file changed, 20 insertions(+), 29 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
