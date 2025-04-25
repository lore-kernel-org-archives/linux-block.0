Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A177197A76
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563253; cv=none; b=fQyrGFW4B3L9hxWtIbMcxGavT+ZFuD4uHfZHifzN3SwbWDQJIe4B3E02GlAb2sAD5baMRhVQE6DiIxJpoVTw+tiKcOmYhum4bUxkXVu4p0npzGX62iHpj8ZgN+xEdV4yEfsZPPO+wgYDIdOOjFfbRArAK0dbAPyGu55m5dutago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563253; c=relaxed/simple;
	bh=sR7EEjBqCqOZgo4eov6KIR3s5GvGhv+0YMfk02RKlmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXzO9MKTKlqxvoQnUKa8YGqUAsew60iWOrwCKQw8tjLpv+PJXXVl9TY9fbzFw1JvISKLEZmxvROyPIRwemzS/BUDzCta9n0YHZD/xS5qC9DEeu8AMO+HZ/eaogZnR87wo3d4L/bXbQpPj72liJT03x35K8HD1u3m8LtHQTitcT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iGmG3TYb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0aqh6lZL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iGmG3TYb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0aqh6lZL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iGmG3TYb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0aqh6lZL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iGmG3TYb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0aqh6lZL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F4BD210F9;
	Fri, 25 Apr 2025 06:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Szu9/0jvWPRj+ixnZzE0C2U6J21dvyoOJDCs+n1tkiE=;
	b=iGmG3TYbX+PLImR5GPwCvCMxOFsIaVBJZg2sJmEfLzWK477fXZxObs3V4TX3iWNZHl1kGu
	S9tGQ55s7TvMmV/HmHWjoq6CJ23+Usejmb68Rp46Lq6Kq0EHDQvae6bZqNYmJxgL23ytEE
	IBvzwX2SE8SeEb19gmcLzkswZCKSquc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Szu9/0jvWPRj+ixnZzE0C2U6J21dvyoOJDCs+n1tkiE=;
	b=0aqh6lZLyM3N8s2pjLdyOTub0+mQSsKrVup20jwjkNwGGYTSZ2ILEsXGVCap7eybNIfFD+
	MuYhj3AGKIrSdAAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iGmG3TYb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0aqh6lZL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Szu9/0jvWPRj+ixnZzE0C2U6J21dvyoOJDCs+n1tkiE=;
	b=iGmG3TYbX+PLImR5GPwCvCMxOFsIaVBJZg2sJmEfLzWK477fXZxObs3V4TX3iWNZHl1kGu
	S9tGQ55s7TvMmV/HmHWjoq6CJ23+Usejmb68Rp46Lq6Kq0EHDQvae6bZqNYmJxgL23ytEE
	IBvzwX2SE8SeEb19gmcLzkswZCKSquc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Szu9/0jvWPRj+ixnZzE0C2U6J21dvyoOJDCs+n1tkiE=;
	b=0aqh6lZLyM3N8s2pjLdyOTub0+mQSsKrVup20jwjkNwGGYTSZ2ILEsXGVCap7eybNIfFD+
	MuYhj3AGKIrSdAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BBE213A80;
	Fri, 25 Apr 2025 06:40:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vnH5AHIuC2gZYgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:40:50 +0000
Message-ID: <7d1bb830-4bf6-4888-aeb0-d0046b85116d@suse.de>
Date: Fri, 25 Apr 2025 08:40:49 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 14/20] block: pass elevator_queue to elv_register_queue
 & unregister_queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-15-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-15-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F4BD210F9
X-Spam-Score: -4.51
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/24/25 17:21, Ming Lei wrote:
> Pass elevator_queue reference to elv_register_queue() & elv_unregister_queue().
> 
> No functional change, and prepare for moving the two out of elevator
> lock & freezing queue, when we need to store the old & new elevator
> queue in `struct elv_change_ctx` instance, then both two can co-exist
> for short while, so we have to pass the exact elevator_queue instance
> to elv_register_queue & unregister_queue.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/elevator.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
