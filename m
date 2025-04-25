Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34502F32
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563598; cv=none; b=oKKr0A+D0tuj8zfI9x7iX4QI2L+p8Vh7eqSK92qnhc4oLaEWfIHPwEohFfEYJwUlo1TUQBNbnzHibtH5iRZpPQpbkccYchZKWrIXYRDubixzpGfp5hlDPmrYQ8In3Zwtqx4STaR+F6PzCye6zMA62cK81Xnwp8ap40RhSnSHdrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563598; c=relaxed/simple;
	bh=4ez5w1y/YZWIsRMzfnrGPSen2SIV44XOBtoLes20kQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCcyBQAFRwYMBSts9WD5TA/ZxxthEZXZoVLDsR+9MBxbMJoOc2Q7ykEjVuJ/ffBIv1MiQcEoRdLON7S/+Y49n3rj8LhDsy6UT4aydrQGn0NKbm+dRVq3tXhovCmTlm40YT3mq2tD0vq4A2u4wzKhbibfQAKg0QaCBoy1p7o3OCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lngQBToF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F5gV5mde; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lngQBToF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F5gV5mde; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lngQBToF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F5gV5mde";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lngQBToF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F5gV5mde"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7D442116C;
	Fri, 25 Apr 2025 06:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPSWiIwKTxd9Ed1+0hgQOuUEL96ZWgFuT1bv8To0O3Y=;
	b=lngQBToFGIUfaUdX9j36ujSxA9pLdJM34ZTOng1zqWUw8ZgInPaNYf2+9LWCa0Tobf+fYA
	AOzRjNDrkAjGwDhv5fhH+ei0/gOGxXR4odeECM/n9cpBB+tt1v1a6fAlMtuXjX4ARdcvzt
	gkF5O6TjH8BGIXU7o6tDg+qN6fthFNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPSWiIwKTxd9Ed1+0hgQOuUEL96ZWgFuT1bv8To0O3Y=;
	b=F5gV5mdeqq7oyPGki1o7Zax1qv2DKh6tXWJ2dkTL7k1VNSvX8vOeV07Dj3J1ghyWxXdlQZ
	PVyYTUqCQrqvGICg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lngQBToF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F5gV5mde
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPSWiIwKTxd9Ed1+0hgQOuUEL96ZWgFuT1bv8To0O3Y=;
	b=lngQBToFGIUfaUdX9j36ujSxA9pLdJM34ZTOng1zqWUw8ZgInPaNYf2+9LWCa0Tobf+fYA
	AOzRjNDrkAjGwDhv5fhH+ei0/gOGxXR4odeECM/n9cpBB+tt1v1a6fAlMtuXjX4ARdcvzt
	gkF5O6TjH8BGIXU7o6tDg+qN6fthFNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPSWiIwKTxd9Ed1+0hgQOuUEL96ZWgFuT1bv8To0O3Y=;
	b=F5gV5mdeqq7oyPGki1o7Zax1qv2DKh6tXWJ2dkTL7k1VNSvX8vOeV07Dj3J1ghyWxXdlQZ
	PVyYTUqCQrqvGICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B13E13A79;
	Fri, 25 Apr 2025 06:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BmVfFcovC2iTYwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:46:34 +0000
Message-ID: <55828969-8ab1-4c4a-9d7d-01ff6756b93f@suse.de>
Date: Fri, 25 Apr 2025 08:46:33 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 16/20] block: move elv_register[unregister]_queue out
 of elevator_lock
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-17-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-17-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B7D442116C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/24/25 17:21, Ming Lei wrote:
> Move elv_register[unregister]_queue out of ->elevator_lock & queue freezing,
> so we can kill many lockdep warnings.
> 
> elv_register[unregister]_queue() is serialized, and just dealing with sysfs/
> debugfs things, no need to be done with queue frozen.
> 
> With this change, elevator's ->exit() is called before calling
> elv_unregister_queue, then user may call into ->show()/store() of elevator's
> sysfs attributes, and we have covered this issue by adding `ELEVATOR_FLAG_DYNG`.
> 
> For blk-mq debugfs, hctx->sched_tags is always checked with ->elevator_lock by
> debugfs code, meantime hctx->sched_tags is updated with ->elevator_lock, so
> there isn't such issue.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c   |  3 +-
>   block/elevator.c | 80 ++++++++++++++++++++++++++++++++++++------------
>   2 files changed, 62 insertions(+), 21 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
