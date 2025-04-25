Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C582F32
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563518; cv=none; b=AXdVaTYyTRllOfMv7pc4MOpuQ80ebBR4F7Q9sOX8VVSl9AEEfex3hNoV6bxNSA/vesHA61D24kYDKwRYUOISw+4m/L24A02j6PWrkIVZTSYhEwkwGGAoDJugO8LQo+b69YoyhrTeEXfiGZmOtiPhbV0mA01nBudxr2kPZ5qc//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563518; c=relaxed/simple;
	bh=fppw8mAGqBzzKckcSPCeuVXvuwuPgEBuIHrfUoShB8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhMjN7p8usVczeEPSMZS1x+iLOAJeX8eyYLlY9ITjPibrY3knfwccucoR+HX1Fztky/jpUHwhse0ywBOrhiMVbYXRE9G5f2ozHdKv9HTSS3j77noX0/mJBQnivS0RD+NFWKpoyFt6wji4/kQeYH2ZhihxQLKQx6TV50AnLJpnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QDp0q5KW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YKZPgG8D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QDp0q5KW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YKZPgG8D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QDp0q5KW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YKZPgG8D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QDp0q5KW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YKZPgG8D"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D166210F9;
	Fri, 25 Apr 2025 06:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2VloUgf+dZ8HVD2q4pyh1O1FNhttdCiVnMpAxCviNE=;
	b=QDp0q5KWlsAeJAHifZbMoDfmW4dbHM7H574GktFYjC/ejPrX4cm0shBfaR/7LhJOQpojsB
	WMK+KEiyB/qDkY7UdWPAnnwNMQjmkQ9OyVbCfOz2uGCy5HANDLeHlsQwgSrjzi8vT+0Pbv
	CLH6kjzGs3FPDdTwKvuZI2xDIUo/oDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563514;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2VloUgf+dZ8HVD2q4pyh1O1FNhttdCiVnMpAxCviNE=;
	b=YKZPgG8DFGLIb8VJHPIJIgpwJSL327dSUl5OnzDT0CP2n4R8q6kJQTvHI2aIf1NiG/Hi/u
	6J9/oVtYfyfq/KBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QDp0q5KW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YKZPgG8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2VloUgf+dZ8HVD2q4pyh1O1FNhttdCiVnMpAxCviNE=;
	b=QDp0q5KWlsAeJAHifZbMoDfmW4dbHM7H574GktFYjC/ejPrX4cm0shBfaR/7LhJOQpojsB
	WMK+KEiyB/qDkY7UdWPAnnwNMQjmkQ9OyVbCfOz2uGCy5HANDLeHlsQwgSrjzi8vT+0Pbv
	CLH6kjzGs3FPDdTwKvuZI2xDIUo/oDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563514;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2VloUgf+dZ8HVD2q4pyh1O1FNhttdCiVnMpAxCviNE=;
	b=YKZPgG8DFGLIb8VJHPIJIgpwJSL327dSUl5OnzDT0CP2n4R8q6kJQTvHI2aIf1NiG/Hi/u
	6J9/oVtYfyfq/KBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D75313A79;
	Fri, 25 Apr 2025 06:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ScQwFXovC2hRYwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:45:14 +0000
Message-ID: <fc9aa614-8d67-4671-add0-37013fa0d5ec@suse.de>
Date: Fri, 25 Apr 2025 08:45:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 15/20] block: fail to show/store elevator sysfs
 attribute if elevator is dying
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-16-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-16-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9D166210F9
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/24/25 17:21, Ming Lei wrote:
> Prepare for moving elv_register[unregister]_queue out of elevator_lock
> & queue freezing, so we may have to call elv_unregister_queue() after
> elevator ->exit() is called, then there is small window for user to
> call into ->show()/store(), and user-after-free can be caused.
> 
> Fail to show/store elevator sysfs attribute if elevator is dying by
> adding one new flag of ELEVATOR_FLAG_DYNG, which is protected by
> elevator ->sysfs_lock.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-sched.c |  1 +
>   block/elevator.c     | 10 ++++++++--
>   block/elevator.h     |  1 +
>   3 files changed, 10 insertions(+), 2 deletions(-)
> 
Not particularly happy about this, but I fear it's the best we can do
for now.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
