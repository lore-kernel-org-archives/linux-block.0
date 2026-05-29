Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83153AA4FE
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036213; cv=none; b=G4wILE5JXhXn1tMXJA6ID0UKCni0I5JoOr+bqSXDhdteeB2TXVRLrC7iFX75qJZgfyrfOPyMzmFbhtLkEQ07S0hUBURtyLLmwve+xzF+mXN1+wK6qRUj4/NNa0pYraQDBth+UJ/hc49qxb9pJys1YS4UD/xtXwLgbMHwJfPMDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036213; c=relaxed/simple;
	bh=hdE/m8DIEtAHw990i0xdQIr2DufPkNW2ZplClOcNCuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIB+BTh1VlwLHp2PW3K3OR+dRMKAn3A+SrI2VfznDaS203zImacD4hPs9h4571bzFSl1sswKJ9jH5hdWWK2K2Bo5Ir36JiRiJDiiw0hh7y27dqi1SKZ/dh8Kt1GjOz1bAK0foEFLbpStb+v8vodSc9NcSyDyagJ6KC4zlOSnlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Aowk61kB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KXItagqw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ONddicRU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=24hOsqjA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Aowk61kB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KXItagqw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ONddicRU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="24hOsqjA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0A8F66E2C;
	Fri, 29 May 2026 06:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCz86hRZ95m8DicgAhQICwyNqpfCtI05P5sHR+bMXpQ=;
	b=Aowk61kBny19bpH86C2kejViGhjsPuOl73PWSDG28D7oqUZKneWnnRXIgU9VAvzHlE43jo
	H3lmOSmRe0PC/sDp/h4KvkJvM+R9ISaGXhuWvTSZneQ2Xreg2Ot+jESXqzwK838zCM4aN5
	pu2cXr50sYOY5wiQ0QCC/n9Yb/mXm00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCz86hRZ95m8DicgAhQICwyNqpfCtI05P5sHR+bMXpQ=;
	b=KXItagqw8RPQFE2lUcnQc9QPvvLjp4x6qpxnWXXyW8MD+WsX0WAWHWugEOzN/U1Gl41Rg6
	ZR255P5QJqCq79AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCz86hRZ95m8DicgAhQICwyNqpfCtI05P5sHR+bMXpQ=;
	b=ONddicRUDWu66ecVojfMAvlYKhsGLF3hbI1mcEZojL1uRX7KfGIw74PGP283UpmjIauzha
	kkNCkuyCzDksI1wIM+IglQ5bvsZrAkAFxOAkJQTRRLNOvvBGWhOnREzrKX+rwikyfLQUTA
	uJ3WDDQnRw95p7ssQAJMBpfMSFJz28E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCz86hRZ95m8DicgAhQICwyNqpfCtI05P5sHR+bMXpQ=;
	b=24hOsqjAae4PgenY/tXrc8mZwv5QnYaAUbH1goxqTht8VcF9JzgA/DeM/NhCM1yiC4zLV/
	8jCckslGKHYzA4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 908F35B1D2;
	Fri, 29 May 2026 06:30:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zH/uIXIyGWqbIAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:30:10 +0000
Message-ID: <6f021cb2-b989-493b-b25f-64172119d914@suse.de>
Date: Fri, 29 May 2026 08:30:10 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] block/crypto: Annotate the crypto functions
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>
References: <cover.1779997063.git.bvanassche@acm.org>
 <91f2acf006f02c42d5d418f3074a6541e79e6fce.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <91f2acf006f02c42d5d418f3074a6541e79e6fce.1779997063.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,acm.org:email,lst.de:email]

On 5/28/26 21:45, Bart Van Assche wrote:
> Add the lock context annotations required for Clang's thread-safety
> analysis.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-crypto-profile.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
