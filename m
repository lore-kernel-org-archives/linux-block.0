Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60D3644C0
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848461; cv=none; b=WvNyiDFd8VvDTmCbSNz3CqNIhbzdm7PkQHcbUHX0ilOaCF3fDxbbSpqr3For7W1abSfRv3Le1QTlfXORFbuoIr0s0PPmFc9LzsxZ/2ZuKefDy9p7L4SijO3xZMgID95oHnNl3riWbWHndoHqLKMM88pszljuF4DMN8k9zBLH/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848461; c=relaxed/simple;
	bh=lCYQdaImbgnpCKhhos7Y58Ow/1xz8ev6WnZIfAgryRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ppg5x0b6nZt3t8TuwKFMlkwm3yCH/tdUbaKv5ryqFF2Qz+chaDNX/y/jqi6CLHP1iiGShjTVqQAOJz7l2/nILrSFZAihW4KEZO397XxQQanQTxMWXcwBFNnVYcaxt0UXvt07NRY96Ph+YKqw0gvn+2deblLnG+/Q0VSRk1k+uTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I8O98R/O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TBEIM4fc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I8O98R/O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TBEIM4fc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I8O98R/O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TBEIM4fc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I8O98R/O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TBEIM4fc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 189415BD12;
	Mon, 23 Feb 2026 12:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771848459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8Y24qinfv9D3oyG02/fpMJKgnjiq200K8cCIL5F6hc=;
	b=I8O98R/O2u6oXhHUxeHblaJF+bWccYHAD5hxHy4IcTraNa6Plsn0QNmW1+VNIc2rrn5POs
	qb7DbrmF5KYwUVHngZhjxAZsu4Oo6F+B+BfcvAkcblT4VbU2WBmdKNOWdlVTS+c0+D57Eg
	I9zzdRCUWtP2IXt4DBrzQ9GSuICWj64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771848459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8Y24qinfv9D3oyG02/fpMJKgnjiq200K8cCIL5F6hc=;
	b=TBEIM4fcAiwCMP7gZSWIF8gy2pkoMYNKH97wlGB2U73qkYN5rIiT7mJR1UGngL3DVGs/8t
	pPJqpYU7Ha44bxAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="I8O98R/O";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TBEIM4fc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771848459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8Y24qinfv9D3oyG02/fpMJKgnjiq200K8cCIL5F6hc=;
	b=I8O98R/O2u6oXhHUxeHblaJF+bWccYHAD5hxHy4IcTraNa6Plsn0QNmW1+VNIc2rrn5POs
	qb7DbrmF5KYwUVHngZhjxAZsu4Oo6F+B+BfcvAkcblT4VbU2WBmdKNOWdlVTS+c0+D57Eg
	I9zzdRCUWtP2IXt4DBrzQ9GSuICWj64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771848459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8Y24qinfv9D3oyG02/fpMJKgnjiq200K8cCIL5F6hc=;
	b=TBEIM4fcAiwCMP7gZSWIF8gy2pkoMYNKH97wlGB2U73qkYN5rIiT7mJR1UGngL3DVGs/8t
	pPJqpYU7Ha44bxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F41683EA68;
	Mon, 23 Feb 2026 12:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5Ff/OgpDnGkpUQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 12:07:38 +0000
Message-ID: <eb5fcc3a-da07-4347-885d-f7d227f3cd74@suse.de>
Date: Mon, 23 Feb 2026 13:07:38 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] block: default to QD=1 writes for blk-mq rotational
 zoned devices
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260221004411.548482-1-dlemoal@kernel.org>
 <20260221004411.548482-8-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260221004411.548482-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 189415BD12
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/21/26 01:44, Damien Le Moal wrote:
> For blk-mq rotational zoned block devices (e.g. SMR HDDs), default to
> having zone write plugging limit write operations to a maximum queue
> depth of 1 for all zones. This significantly reduce write seek overhead
> and improves SMR HDD write throughput.
> 
> For remotely connected disks with a very high network latency this
> features might not be useful. However, remotely connected zoned devices
> are rare at the moment, and we cannot know the round trip latency to
> pick a good default for network attached devices. System administrators
> can however disable this feature in that case.
> 
> For BIO based (non blk-mq) rotational zoned block devices, the device
> driver (e.g. a DM target driver) can directly set an appropriate
> default.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-sysfs.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
