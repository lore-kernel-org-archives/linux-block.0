Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9125B30D
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847820; cv=none; b=dO0zOISUHwSxVumLJhdhJEnhdt5F61Z1KPdSyHqoa9mrbmzRRhpOq1k6bKGu367TVUW5sqm/nZj/id1XgiWbL7Xb5ifYy/5wfTbpleb7V8bS52ijDZoW74wZ01x6jjj1xf5+lsA3Qsxi+t1nw0poh562Lv4PNainrd6hyKCdlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847820; c=relaxed/simple;
	bh=Og6UxobohMWt4ldQ+m9YNCnidnSWigaLdcK4Gj7OMds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BqQl/mm9oR4lEFF6s6Z4pZmeVI5fFUf2Yite/fj8NEm+Z4PdDoAQfw/BKg4wpZLtT7k1fvVRHYv986GpXEPZqDbYtIm+Mco5o3H4mxp4w/JMrp+ed8CJ/mHTtxkzpkfltU2grakNNox8pNRn8u2z+dnw1TbYVCyZ4M868RG8BAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XAft9rvF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vRhwHmMY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XAft9rvF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vRhwHmMY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XAft9rvF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vRhwHmMY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XAft9rvF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vRhwHmMY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 830223EC60;
	Mon, 23 Feb 2026 11:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771847817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7oNrotqBrbvxKDOlXHGYzkeB/IdauGvxO1K3wy0rNs=;
	b=XAft9rvF+8SC5JRm04KRt9N0QqtVZ8bpWuRf/8WktlIJftHMHNWf9ZtZgys4nI+GCcASB0
	zB2znk/2H5em+1WalgxJIFs6MNRP1zMYd/impvRsD4dKIHu48f+k9A4h8hBB3Uvm2GRtIK
	oU2NhFpoXTLsnpaO0eOz37wx304Bju0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771847817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7oNrotqBrbvxKDOlXHGYzkeB/IdauGvxO1K3wy0rNs=;
	b=vRhwHmMYlAnbjkufvAlndjtwBtsGNhRk4zvdQnMu5ICN5J5syw9d5/5AzLrOAFgK87v9WE
	yJERcWn8WHGd3xDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XAft9rvF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vRhwHmMY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771847817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7oNrotqBrbvxKDOlXHGYzkeB/IdauGvxO1K3wy0rNs=;
	b=XAft9rvF+8SC5JRm04KRt9N0QqtVZ8bpWuRf/8WktlIJftHMHNWf9ZtZgys4nI+GCcASB0
	zB2znk/2H5em+1WalgxJIFs6MNRP1zMYd/impvRsD4dKIHu48f+k9A4h8hBB3Uvm2GRtIK
	oU2NhFpoXTLsnpaO0eOz37wx304Bju0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771847817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7oNrotqBrbvxKDOlXHGYzkeB/IdauGvxO1K3wy0rNs=;
	b=vRhwHmMYlAnbjkufvAlndjtwBtsGNhRk4zvdQnMu5ICN5J5syw9d5/5AzLrOAFgK87v9WE
	yJERcWn8WHGd3xDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E6AB3EA68;
	Mon, 23 Feb 2026 11:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P4NaFolAnGm0RQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 11:56:57 +0000
Message-ID: <8c760518-7494-454a-9d7a-57f5316aba0f@suse.de>
Date: Mon, 23 Feb 2026 12:56:57 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] block: remove disk_zone_is_full()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-4-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260221004411.548482-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 830223EC60
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/21/26 01:44, Damien Le Moal wrote:
> The helper function disk_zone_is_full() is only used in
> disk_zone_wplug_is_full(). So remove it and open code it directly in
> this single caller.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-zoned.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
