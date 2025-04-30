Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A801E5B7A
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745994781; cv=none; b=HFn+z7+PNrUsw2hBb9Pn7DEPOLfeZcM+qvCd2otsiidrDQy5F/1C97MghIkt9BbYT9pVhmvPzx5Q+RD6Vqc2cP69/82iMDbJN3wsxbRbTwDFDqygfToW+bKo1v5ydHAsByPpFLAW8YE/r9OqCtxwxU2+v4RI5l7i61wURIKnDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745994781; c=relaxed/simple;
	bh=ODjpZyCvSkklqgi2EMhrZSX4/9SVPtV5fKn7Cs+xWls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBQLsFfuSrE2ty1OdXZ6hjgmKGsi9OPxHtvrSA508az0bueTiCEMwp8fIO6OA/DEoex0rZsSsOLp3WyltgYWPRtZ3uX0RA8LR7NXgBPsoFFXLmONmsyMpboSfmQhiLcEVkcPUMvB524mnTrMgxhLB9OER7+Gfsx9gmcLpU/a2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bLORk9T0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KDTLZx4o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lKBN6IiZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pePiv3Sg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bLORk9T0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KDTLZx4o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lKBN6IiZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pePiv3Sg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E75EC1F7C3;
	Wed, 30 Apr 2025 06:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745994778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYNC2uBCjJp0G71fSy7f2j5es5mV/Xnkym/Wm1txfso=;
	b=bLORk9T0JJ2wBIZ2bjWoC6IDUw0EEKdisU8Jm69YZV/0kI1jWj5PwVZFfA4QMx/gYhnOcN
	3gVb1AuLOrNKGp5etH4nWxaM6ORBsBw0R62IDxc3aEM8GPZJa89+Ue9En4+z2tdleIK+7n
	2I71s9lPnzH7aEmRiwm3CtkmGOcTKaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745994778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYNC2uBCjJp0G71fSy7f2j5es5mV/Xnkym/Wm1txfso=;
	b=KDTLZx4ocEGPP6sIncjHM93EbGrVjTr1w06fseC85iOpH56KnDSNVkTazgs/eADIslXHcR
	QUdmlCnAPQ1pdRAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lKBN6IiZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pePiv3Sg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745994777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYNC2uBCjJp0G71fSy7f2j5es5mV/Xnkym/Wm1txfso=;
	b=lKBN6IiZWvRB0uH72w/2qSp1lhvxQrcmTSyzKPvFkzh/ljan3n9dd8oekhK39SvVlMGsoH
	bziUUbvih1ct4znHy1bWr/rQPsujLiENiUkgtNjNGCpww3umWpzy93MHW560855hSXB/bd
	3A4pTiDK3AVbt4R4W/WiWT9DiDN1qQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745994777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYNC2uBCjJp0G71fSy7f2j5es5mV/Xnkym/Wm1txfso=;
	b=pePiv3SgraDSBq8Qa8G3yX6ZNWMcI69eTu1ciqIvE/3mT0JJWJMwOjW/h3SoBJtfn+A8qU
	XDNuoqHluyQ4sSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 957EC139E7;
	Wed, 30 Apr 2025 06:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jsalIhnEEWiNawAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Apr 2025 06:32:57 +0000
Message-ID: <22c0a3e4-db67-4788-9e15-44b4a5feb674@suse.de>
Date: Wed, 30 Apr 2025 08:32:57 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 19/24] block: add new helper for disabling elevator
 switch when deleting disk
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-20-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250430043529.1950194-20-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E75EC1F7C3
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/30/25 06:35, Ming Lei wrote:
> Add new helper disable_elv_switch() and new flag QUEUE_FLAG_NO_ELV_SWITCH
> for disabling elevator switch before deleting disk:
> 
> - originally flag QUEUE_FLAG_REGISTERED is added for preventing elevator
> switch during removing disk, but this flag has been used widely for
> other purposes, so add one new flag for disabling elevator switch only
> 
> - for avoiding deadlock risk, we have to move elevator queue
> register/unregister out of elevator lock and queue freeze, which will be
> done in next patch. However, this way adds small race window between elevator
> switch and deleting ->queue_kobj, in which elevator queue register/unregister
> could be run concurrently. The added helper will be used for avoiding the race
> in the following patch.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c |  1 +
>   block/elevator.c       |  5 ++++-
>   block/genhd.c          | 12 ++++++++++++
>   include/linux/blkdev.h |  3 +++
>   4 files changed, 20 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
