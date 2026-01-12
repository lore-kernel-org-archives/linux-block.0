Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0E3191B4
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203792; cv=none; b=owfPWi4+W/l7HYlIqoc7tVDtLtWd3+hTtAHtAL7U9xea7zx1A/MYqtmyI7nUx8UJu/bL9CJxqKClibs/28DERZMFreXLiCYqKByNSs2BsOj0yrwSWHcvhXswIS4pE0Msu5sIDpTKRqOtyBQoGkI4GNvBkPkQS4bAwR3ej6TOD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203792; c=relaxed/simple;
	bh=EJ3juPGMpyjWN0Sqp4dEJlC10DFSp+UqdIiIlLHo+ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uREiY6N053BTU5J7rHBBObqvn++SEB2xwil/3Rl+6qrloEzXET3pFQn6u2HOsqC0PGmUIYr1l6iPaHqWWMSyiPV+KXSHyY7J8hYS+BT6GBcD5IajK5LB5M5hBs0awU/A2Th7OcX2rqhI59iSZgtkYGDHxjvRlvvfs1LcAV6tof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=15Hu2Bsx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pfxjyQp+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=15Hu2Bsx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pfxjyQp+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="15Hu2Bsx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pfxjyQp+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="15Hu2Bsx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pfxjyQp+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 38DDF5BD31;
	Mon, 12 Jan 2026 07:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=it9IJ5l110KKjeHv2lWS3ACJza9g89o0OnPeHnZ9hXU=;
	b=15Hu2BsxpWf7pvR7Y2tnb4ysYRwcofyRKnAFwugtdfBmlvXGdHbhjJpQMqJHdc0l6hwZeR
	L7HEaguJdjY4NJk/PZt3Zt18fNtrwcF1HdO18Rwbwtt5myLsBDgkHFdIHr2XCJk8Amxcoy
	jUIRskdrhLwmCqS4t5p+4Ocs7YdGv6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=it9IJ5l110KKjeHv2lWS3ACJza9g89o0OnPeHnZ9hXU=;
	b=pfxjyQp+m/4l2kM36tmxubjGPPwj6NYw7Vicb3g6H8XzuDneuDmDiezvb95cYD3E2tDoeG
	YhaK2CmYbhqCqaBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=15Hu2Bsx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pfxjyQp+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768203789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=it9IJ5l110KKjeHv2lWS3ACJza9g89o0OnPeHnZ9hXU=;
	b=15Hu2BsxpWf7pvR7Y2tnb4ysYRwcofyRKnAFwugtdfBmlvXGdHbhjJpQMqJHdc0l6hwZeR
	L7HEaguJdjY4NJk/PZt3Zt18fNtrwcF1HdO18Rwbwtt5myLsBDgkHFdIHr2XCJk8Amxcoy
	jUIRskdrhLwmCqS4t5p+4Ocs7YdGv6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768203789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=it9IJ5l110KKjeHv2lWS3ACJza9g89o0OnPeHnZ9hXU=;
	b=pfxjyQp+m/4l2kM36tmxubjGPPwj6NYw7Vicb3g6H8XzuDneuDmDiezvb95cYD3E2tDoeG
	YhaK2CmYbhqCqaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04F883EA63;
	Mon, 12 Jan 2026 07:43:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XHdQOwymZGmZUwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Jan 2026 07:43:08 +0000
Message-ID: <d34644fb-a3d7-4ea7-8787-e245bfd027c2@suse.de>
Date: Mon, 12 Jan 2026 08:43:08 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] blk-mq-debugfs: warn about possible deadlock
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 tj@kernel.org, nilay@linux.ibm.com, ming.lei@redhat.com
References: <20260109065230.653281-1-yukuai@fnnas.com>
 <20260109065230.653281-9-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260109065230.653281-9-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,fnnas.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 38DDF5BD31
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/9/26 07:52, Yu Kuai wrote:
> Creating new debugfs entries can trigger fs reclaim, hence we can't do
> this with queue frozen, meanwhile, other locks that can be held while
> queue is frozen should not be held as well.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-debugfs.c | 31 ++++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
