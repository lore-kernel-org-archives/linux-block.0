Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569FB22D4E2
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562888; cv=none; b=Xb+Gr5DmRTKpigSezATv9QNMf6QSavqT9Z2iwsFOmDAuz7pjqoNIJZDIIBh3AD2XGShoL1ttLnlyvJ13YdAxT2pUJWcPQ/DTdaNeyS4jhQLjNqXJjmrSrz5kpB7s6SR/5qhvRc751IaK5/QZSsMxxlgkq1abRqrBVtJNJWh3qUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562888; c=relaxed/simple;
	bh=qd15lHf/30UqjOsIoP8mHTcUMoygH8jTtl4TZrAngmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4l+O8LvIAKhg2EUe36HLIiFjmjsmh6vdUkVzBZ65a45sPt5FmJHI+yA05cyAaWvMR5NP02fx49ocVld0XhpYrZwbow2/LruWNxVAK6YiUEJ/3LRxNvE5SsGkc5PUmN2Mx4B/DdqHrLkoVMiipqxwPblFHjpKq6ZKfGu17NpnuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H+VPs8j3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cLHBUAR0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H+VPs8j3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cLHBUAR0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H+VPs8j3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cLHBUAR0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H+VPs8j3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cLHBUAR0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 591E3210F9;
	Fri, 25 Apr 2025 06:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745562885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3S9sNqChJwj59V8YUhlQor2ZUDtGGbnnJ1+iB+pN+/k=;
	b=H+VPs8j39nZcI5YXuJ4WGOQX02MMWsrIqpmnG8mADyQylCR4HM8LJYNOf4uhsK1JpOQfy/
	BxORoaYCRE8DyILXBek2U+BnwvKdkta3enw5/LieAC15oAA8v3/gbwfU+gSU+7hXRkB/Fd
	e6IX+4LXoyrOC4tAw9eM6GQcntCWIz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745562885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3S9sNqChJwj59V8YUhlQor2ZUDtGGbnnJ1+iB+pN+/k=;
	b=cLHBUAR0PHcYAvAG2uHDkwGjrFJCkZTKTi7pJOOiMwvz/b2zSwE6gE6JUV2OaNuKrj3Cyw
	dGgACr43Pd+yRmCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H+VPs8j3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cLHBUAR0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745562885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3S9sNqChJwj59V8YUhlQor2ZUDtGGbnnJ1+iB+pN+/k=;
	b=H+VPs8j39nZcI5YXuJ4WGOQX02MMWsrIqpmnG8mADyQylCR4HM8LJYNOf4uhsK1JpOQfy/
	BxORoaYCRE8DyILXBek2U+BnwvKdkta3enw5/LieAC15oAA8v3/gbwfU+gSU+7hXRkB/Fd
	e6IX+4LXoyrOC4tAw9eM6GQcntCWIz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745562885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3S9sNqChJwj59V8YUhlQor2ZUDtGGbnnJ1+iB+pN+/k=;
	b=cLHBUAR0PHcYAvAG2uHDkwGjrFJCkZTKTi7pJOOiMwvz/b2zSwE6gE6JUV2OaNuKrj3Cyw
	dGgACr43Pd+yRmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0338F13A80;
	Fri, 25 Apr 2025 06:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L5t7NwQtC2ioYAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Apr 2025 06:34:44 +0000
Message-ID: <97e85033-4763-4f45-8a17-91a681ba26ca@suse.de>
Date: Fri, 25 Apr 2025 08:34:44 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 09/20] block: simplify elevator reattachment for
 updating nr_hw_queues
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-10-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424152148.1066220-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 591E3210F9
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
> In blk_mq_update_nr_hw_queues(), nr_hw_queues changes and elevator data
> depends on it, so elevator has to be reattached.
> 
> Now elevator switch isn't allowed during blk_mq_update_nr_hw_queues(), so
> we can simply call elevator_change() to reattach elevator sched tags after
> nr_hw_queues is updated.
> 
> Add elv_update_nr_hw_queues() for blk_mq_update_nr_hw_queues() to
> reattach elevator.
> 
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c   | 90 +-----------------------------------------------
>   block/blk.h      |  3 +-
>   block/elevator.c | 32 +++++++++++++----
>   3 files changed, 28 insertions(+), 97 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
