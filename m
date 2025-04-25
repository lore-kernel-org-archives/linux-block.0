Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2E197A76
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563103; cv=none; b=g4kfSteyzCKI5HBeutqNS0ZuvCxoC1lz2kbRtjd64nFL8JkA20ds/6JLqxWmjTDhkRBrM1fsM3K5owzhp8hTxCm1+DXv6D5WYrpEuccXgViizztu6km0oGg9ZQ1i6btEYW6wq0n3fnQtViEC8gbk843Mm/3pXcSGoxRdojqYQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563103; c=relaxed/simple;
	bh=vAOlv+e2tYKo487iaNzay61BXCe2ucXIgo+3m7HadvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOeahjb/vpLGp2LmCFlTA7Sao/o4OOc6fXzPEZ7v5pVxNP07SS73/zRAYE4GhmBOivJYSCgw+2aZA34mNetB7GUYw25lu/TddNsiSnXT1eD4e8KOxPY6PdnWZRLLFD+E6CX0/wqSpVXSNoq0hebegeJ/E+T1EYjXtblhPxDWSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KDykAAoY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nyqN4WoP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VJa364Wq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LokOMS27; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KDykAAoY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nyqN4WoP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VJa364Wq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LokOMS27"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8C361F38D;
	Fri, 25 Apr 2025 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7U2E3AnKhPCEalHekRsAkAyWSC41odJrPyDZKqM2Yc=;
	b=KDykAAoY2i96r5wVPPRPvTOWifbasKc0fMv4/RBZcZqxjtxfIb51TWWP87HfdeVKLB+z7Z
	MVrsF2xiT28HPqgFzwTSes3jFqFhDGFFwpkI4upxV+WfLU4P1/8e9XxEofUgG3BoiYJYAy
	eGR/iqg/i/w/tQLFL1Ic3pxSEZYsgmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7U2E3AnKhPCEalHekRsAkAyWSC41odJrPyDZKqM2Yc=;
	b=nyqN4WoPgu3jqr6UWuk2ZrRx+F7SUcFXITLQ+rAyLs8+rsz08CuI4kV7oNHG7rycwxizmh
	m/G1IlAWF4d5ANCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VJa364Wq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LokOMS27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745563099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7U2E3AnKhPCEalHekRsAkAyWSC41odJrPyDZKqM2Yc=;
	b=VJa364WqT7kzEHLOv7AKNXzapdACQma6ECFMBrDfYxxdEc5XIvgXMN2oOAUBgttTkmltwS
	4lO2jv8rKbu6phd5GTKnDmylDO/8cZ5XyEQ1VUFd9d/rEglDceCy5b+fZ5iUPTTjCM5qWc
	a0k3kPYSiirTSJXaBmYJHHcPWOvHi38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745563099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e7U2E3AnKhPCEalHekRsAkAyWSC41odJrPyDZKqM2Yc=;
	b=LokOMS27qyE61BxMmlFUxLxbx6nmhxOYwDIJQDkjhkmE6ghHwin9MiR4mHGx5zjcw+McZV
	1fQ+1bybIt1pqOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D6CA13A80;
	Fri, 25 Apr 2025 06:38:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LD55JNstC2huYQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:38:19 +0000
Message-ID: <aac066fe-d5a0-4e88-b6db-b1a4faf5a333@suse.de>
Date: Fri, 25 Apr 2025 08:38:19 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/20] block: add `struct elv_change_ctx` for unifying
 elevator change
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-13-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-13-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8C361F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
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
> Add `struct elv_change_ctx` and prepare for unifying elevator change by
> [__]elevator_change(). With this way, any input & output parameter can
> be provided & observed in top helper.
> 
> This way helps to move kobject add/delete & debugfs register/unregister
> out of ->elevator_lock & freezing queue.
> 
> Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/elevator.c | 44 +++++++++++++++++++++++++++++---------------
>   1 file changed, 29 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
