Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA618C008
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036464; cv=none; b=pDNYD0qBmY3HZX2kzd9eI8/gpZVnG0pbYKgMd8vEv4YXa7OfWLz+cuCnpr+vRxnmtneQyFs4eyu+pZdsDLi3YEqRD/fL0K6MnrmkJ6c6dp+8D/kaxBbeDG1bMubvJZyApcDeTu+H24rdNGHgN7QMHAdfqTfWArseARKE/qd7iOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036464; c=relaxed/simple;
	bh=sFxJJoG001FaaHORlx+NJKGqzDVTcrZakzqS6MqaA9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLpZYtNxLSyUemM/MOpPo/BeTtt2Hvttt4qcBqK+CqQkGKQSi5fNHqKvIkCu1REUYsqQ7PubbG61u4Ncd6uDNq80T4UytTXHQjyywfcUDY/VDZoWX4cGCXVVW4BlSjJrT3j+EVwla5YeWmK3jjx23M6Hq86UVjWWmgJFNdp3PXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nP33aqgh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9GvjVip6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QPSsibk6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LQttSQ2C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nP33aqgh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9GvjVip6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QPSsibk6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LQttSQ2C"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1746C6A9F2;
	Fri, 29 May 2026 06:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCC7hlWAohqLo5kk6M+93g1E2ZFC5amW9SV5gGREF8s=;
	b=nP33aqghJuSy9Yx7rr0lvR48WuCaRqFh+8YEMx+Vy4VenVY38v+seTR0c2GbNv5yrJytEn
	qWWfDprNiMMT9F8pS+sz5AcwBum7ASsed2rvb6mxqIlURPW/UxPPzwejz5SeU14jLP7q3r
	1C7YsxxxeJ6AVYE5KiOEyabgBT99Mz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCC7hlWAohqLo5kk6M+93g1E2ZFC5amW9SV5gGREF8s=;
	b=9GvjVip6ju7iWz5iQAYR4W4VJSseb2sK+OF+Gg0sRqXQfReAvglIxYpdJCtrO8uoyrE0Qk
	WH9AmzFxLhBItBBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780036461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCC7hlWAohqLo5kk6M+93g1E2ZFC5amW9SV5gGREF8s=;
	b=QPSsibk6Dc64xQml5kZZKElQaMPjYgqmCUvl3h0RMQ8lTR2cNAZXN4GJkPFV8gW/XCwi7T
	SzuO4ARNmTdRC/nf2HmfA286ZowR5G84v68AOGWj5fxf42Z4lzX4l/Qm0RLiKweLSC0I2i
	oaYOIYzaj0QcrAsaDAW9YpGXiDUBmnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780036461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCC7hlWAohqLo5kk6M+93g1E2ZFC5amW9SV5gGREF8s=;
	b=LQttSQ2CypoTAtQx6zKJercSC09jXsViIotwSIeT4txUWhOoWbUJw+0lfWTq8YDv4Ic+3U
	6LKddw8n+FEkT2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA8845B1D6;
	Fri, 29 May 2026 06:34:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A+C3M2wzGWq8JAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 May 2026 06:34:20 +0000
Message-ID: <0c32d98f-9a46-47df-a827-2bfdde5d6013@suse.de>
Date: Fri, 29 May 2026 08:34:20 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] block/blk-mq-debugfs: Improve lock context
 annotations
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>
References: <cover.1779997063.git.bvanassche@acm.org>
 <b49bc91945356894b8ab1dc2de1aabad6db3ce16.1779997063.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b49bc91945356894b8ab1dc2de1aabad6db3ce16.1779997063.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,acm.org:email,suse.de:email,suse.de:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,acm.org:email,suse.de:email,suse.de:mid]

On 5/28/26 21:45, Bart Van Assche wrote:
> Make the existing lock context annotations compatible with Clang. Add
> the lock context annotations that are missing.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq-debugfs.c | 12 ++++++------
>   block/blk.h            |  4 ++++
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reiecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
