Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA9383307
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451265; cv=none; b=VrcpbEknEI1diL85LlyZAvaVLjtrK9Z82KJdNWg/Mb3rNGTquTnBgQRd5UziAV6mpastNkM7jbuy4q/JhM24sZqy662GYsTB1lBcaUmw1DJkiwziF0imYYH2pQ/XFcKhDG5wSmCUJ+RW1qhi0N0WM+r0e8w5fCEMQJ3iSD+uB6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451265; c=relaxed/simple;
	bh=vwCEus0OfdihXbDwMLgmWd8t75drZ8J3zdZd8pZTWx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1iT5yIM6czH4XwcmXG/Z6T8hn9y4WFv0Qj1EjmCYvmfFu0OPhQw2yGQEXROb3iIOkTviK2uJPUX61DumbOolwfX3Ub2+APDd2FGJCeVK4/r5jjVFNWtrzi+YWjAuAqZeExG99an0Sv38GxqWrZrf1Yn3BLMv5i8WtyLgOcGMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KeUOhvd/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TvDNGo/X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KeUOhvd/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TvDNGo/X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KeUOhvd/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TvDNGo/X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KeUOhvd/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TvDNGo/X"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4424266FB1;
	Wed,  3 Jun 2026 01:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780451262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGm99IF8orB1tPY+Kp1wRv5pbAmeilYGbupc+IyBHW8=;
	b=KeUOhvd/NpdF1c4Zbf3P78y6YIsBixzQcDx+hU06R0S5jdAy4/O2oVgVJHVaIZe2wBXHbB
	moJVlqMiKF1dj62m0tdSsht1oT/R71xk2cdK2PUkXO2FOWfvU2lRWRWPZeOxt2yezBzUw/
	bRjESRG9YPBK79b9SikPL6O8g+8eXvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780451262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGm99IF8orB1tPY+Kp1wRv5pbAmeilYGbupc+IyBHW8=;
	b=TvDNGo/X5rBZ5Crvs845NHPTpxyxV9AE1W5JvYVuAc4CM6gu4hH8HKaPMhj6G87/eVwb6w
	tB4SiAV16ms3RLCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="KeUOhvd/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="TvDNGo/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780451262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGm99IF8orB1tPY+Kp1wRv5pbAmeilYGbupc+IyBHW8=;
	b=KeUOhvd/NpdF1c4Zbf3P78y6YIsBixzQcDx+hU06R0S5jdAy4/O2oVgVJHVaIZe2wBXHbB
	moJVlqMiKF1dj62m0tdSsht1oT/R71xk2cdK2PUkXO2FOWfvU2lRWRWPZeOxt2yezBzUw/
	bRjESRG9YPBK79b9SikPL6O8g+8eXvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780451262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGm99IF8orB1tPY+Kp1wRv5pbAmeilYGbupc+IyBHW8=;
	b=TvDNGo/X5rBZ5Crvs845NHPTpxyxV9AE1W5JvYVuAc4CM6gu4hH8HKaPMhj6G87/eVwb6w
	tB4SiAV16ms3RLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 730B2779A7;
	Wed,  3 Jun 2026 01:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xyg+ELyHH2pYbAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jun 2026 01:47:40 +0000
Message-ID: <0a33876e-ba34-4b88-8c5e-971bcb162084@suse.de>
Date: Wed, 3 Jun 2026 03:47:34 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/14] block/cgroup: Inline
 blkg_conf_{open,close}_bdev_frozen()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
References: <cover.1780419600.git.bvanassche@acm.org>
 <08f0e3d5f8c01523a66cf55303acfa3c4ff47725.1780419600.git.bvanassche@acm.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <08f0e3d5f8c01523a66cf55303acfa3c4ff47725.1780419600.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4424266FB1
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/2/26 19:07, Bart Van Assche wrote:
> The blkg_conf_open_bdev_frozen() calling convention is not compatible
> with lock context annotations. Fold both blkg_conf_open_bdev_frozen()
> and blkg_conf_close_bdev_frozen() into their only caller. This patch
> prepares for enabling lock context analysis.
> 
> The type of 'memflags' has been changed from unsigned long into unsigned
> int to match the type of current->flags. See also <linux/sched.h>.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-cgroup.c | 46 ----------------------------------------------
>   block/blk-cgroup.h |  4 ----
>   block/blk-iocost.c | 25 +++++++++++++++++++------
>   3 files changed, 19 insertions(+), 56 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
