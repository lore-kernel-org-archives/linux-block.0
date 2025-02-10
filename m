Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9E2206A5
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189648; cv=none; b=ORda254mHfmKjg3ja9/Y3LdDsdAnt6GWFMRExVISNjRT0Vsx4T+Eb5TnEv1WsKn568FXNG84ZkauQEda5eNHiHoSRMPfVAvugJEokLe9EPqPvw6u0g42eQ97gAPPtMu8d+GpGMQvOrs1BEvkMIpxGh3QnBqUf+EHwzliL2SRN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189648; c=relaxed/simple;
	bh=iizSjD+7XYcXA62OPmo1wT9ro58bj4FUTM32EBQulGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfdYWaTLs4RHyen3uYn/x2XRBn/hFZE6kTRxGj7lu/nPL7AqKhBBhyiUxz6XkijIzJg7bR0OKnxj7DGH5DdgcNid95gLkIe6okFFERJLiWhKtcsUki/T82iynI0xWjkP02dgLl/zoeSXkgVBU5lLPoshy7nMT/vFPOCR9DMWevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kiSnAkSr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IKNCJlZo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kiSnAkSr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IKNCJlZo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kiSnAkSr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IKNCJlZo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kiSnAkSr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IKNCJlZo"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2BDE71F38F;
	Mon, 10 Feb 2025 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739189645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWvvJfgrP429nFf3u96aVSb1NZbDzF9YGh7kd4TR5l8=;
	b=kiSnAkSrkWGT4zTmKF3IdHoKyEDr6uM5P3B+2sKmR7DO1b2+OUY+65wteQHnoHS+9yY9w/
	bRcKCP2ce7rLrwsmdjYJaC3DueNs5l5klywWZqKP4qBsOqZ8eZxxuGFAjFpVFeLDFQhUST
	4lS4iMLQFxXmfwoBAlFQ7dPR7/dFZ78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739189645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWvvJfgrP429nFf3u96aVSb1NZbDzF9YGh7kd4TR5l8=;
	b=IKNCJlZoRDk9FNnJTlrHg1aqArIzsMafWK2p8iHmT29mrI2G8cAaj5eb8VVx6xX6AAbOvW
	A3bcR1yNjhkZpeBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kiSnAkSr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IKNCJlZo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739189645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWvvJfgrP429nFf3u96aVSb1NZbDzF9YGh7kd4TR5l8=;
	b=kiSnAkSrkWGT4zTmKF3IdHoKyEDr6uM5P3B+2sKmR7DO1b2+OUY+65wteQHnoHS+9yY9w/
	bRcKCP2ce7rLrwsmdjYJaC3DueNs5l5klywWZqKP4qBsOqZ8eZxxuGFAjFpVFeLDFQhUST
	4lS4iMLQFxXmfwoBAlFQ7dPR7/dFZ78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739189645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWvvJfgrP429nFf3u96aVSb1NZbDzF9YGh7kd4TR5l8=;
	b=IKNCJlZoRDk9FNnJTlrHg1aqArIzsMafWK2p8iHmT29mrI2G8cAaj5eb8VVx6xX6AAbOvW
	A3bcR1yNjhkZpeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C81AE13707;
	Mon, 10 Feb 2025 12:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WnphLoztqWcgcAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 10 Feb 2025 12:14:04 +0000
Message-ID: <51da6bf9-4226-467d-87c1-e6ec785b1c06@suse.de>
Date: Mon, 10 Feb 2025 13:14:00 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Bart Van Assche <bvanassche@acm.org>,
 Keith Busch <kbusch@kernel.org>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250210090319.1519778-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2BDE71F38F
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/10/25 10:03, Ming Lei wrote:
> PAGE_SIZE is applied in some block device queue limits, this way is
> very fragile and is wrong:
> 
> - queue limits are read from hardware, which is often one readonly
> hardware property
> 
> - PAGE_SIZE is one config option which can be changed during build time.
> 
> In RH lab, it has been found that max segment size of some mmc card is
> less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.
> 
So why isn't this reflected in the blk_min_segment settings?
Or, rather, why isn't setting blk_min_segment not enough?

> Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
> as 4K(minimized PAGE_SIZE).
> 
But why 4k then? That is a value like anything else, and what is the 
rationale to use that instead of the more natural sector size?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
