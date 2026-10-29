Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267021;
	b=x+D6RS6jyapSSfj6v5utD51pJh9KBtNN3tNbeucnu6Bi1PqxtQ8XmWDr/i9GpQPT3yex
	 avbYrDT/3DrvmwBee6YdQ4QHWsxtUAhYMCddVLCg7dJcSXUlDGNl7bWC7LxXD1FrjCGS2
	 tvKDLFB96Xy4I+VqE8pGPRXVPUBOj4opoOqv2UljhZErgbz6cGRDvH2Sa8xJGgpVQjD8y
	 fxGdDen9HE7AFk8UaQ8kOdxeo14RIzFB6pivRcQOJTHs/wYWwmkWRjidPrYgspw1QnsIX
	 SjkiB8YSEH+ZH4laW7LGb7J8cIaS0uyBY2OKWXAX5SBSWMVzR/7pUgtw0yJL8gRZZGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267021;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=MHH9E1FbbUsKEmoffbmKnICQtExYCL6YL5jeJzsKwGQ=;
	b=sCi9bYCtkNn3y9lOwLXGHF8C60v+opfrt49lGayAMYYUWl7qXnayvsPMY+P+EPNXbzH1
	 fP18XKt7nrE7iEGUFSUOgKqbUowF3CuKLWYmT73d0n8FIKmYu5xS2qJ30/DphgChO7jd5
	 ixWlRPmT2zS/WGVEUKgmtxs+S4o17OZsi02h7aJhp2Ji4jZFqq8VIfaaefOr0i1Kee2aG
	 SfybkrBcfmKqFVbzykLo4XuFipMPULpSkF6yX7KbB2TZo5+aEJfmsqR08CKVH8DNkzdWe
	 K3+x/nlQwvVwx++Mz3bmWHMsGr78KHGrc/Xq2JsYp7Hy74/GSRO7f5cxaBk4tdUbV5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hU2QDPy1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="aMSSA5/L";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wH3bDaN2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=h5q5V9XH;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9C606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 09:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2E9C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=hU2QDPy1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aMSSA5/L;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wH3bDaN2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=h5q5V9XH
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE55321D11;
	Thu, 29 Oct 2026 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHH9E1FbbUsKEmoffbmKnICQtExYCL6YL5jeJzsKwGQ=;
	b=hU2QDPy1EiSrNL/turNKUFMjtu98vqjZuSPaIL0ta8R4avPNEZP0et6UHkwnNnMSGw86zd
	Iue8ElaM8YKJONOj2ynXpyJMt/SeG91JqUiikStPTPNdxQz3LbmmP7J0JLsjvf0SdOr2QU
	GXMlsQiE8KAJbpqg7DJGWSmoHbYaGYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHH9E1FbbUsKEmoffbmKnICQtExYCL6YL5jeJzsKwGQ=;
	b=aMSSA5/LyPlt2jzlWFkYgTJKGLe+nox5jIkCjKGdj5fX2OSr20+tnPDn4RYOKd7GhWITDw
	r+bKONlWA/80E3Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHH9E1FbbUsKEmoffbmKnICQtExYCL6YL5jeJzsKwGQ=;
	b=wH3bDaN2IWG9k/ZBrWNB+/c04ZF5qJM1tIcO0OCwB+F9pXDy5A+4i4HvKJW0LoN41d0zK/
	LebxNGNGvThl0RPLqVcjGEHvzl+nZ9lbJQHggw7G2mDob0232f8jAvxRk+1xpA8IQvaOO6
	3pfmRmBkkaMqbtyjTcfKXZs2ld5qLLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHH9E1FbbUsKEmoffbmKnICQtExYCL6YL5jeJzsKwGQ=;
	b=h5q5V9XHHoNe17TQZqgCMNEHkBib6gbuztPWSaslStIs3qED+HM87yJvbm/PLUT+YzyTBe
	hkJ4TOK3yX07NSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9668013419;
	Thu, 29 Oct 2026 09:43:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0d7yG0oV42oTFAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 09:43:38 +0000
Message-ID: <febc5026-da7b-4d39-bc7d-30ba78eb7324@suse.de>
Date: Thu, 29 Oct 2026 10:43:38 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 60/98] nvmet-auth: keep the negotiated hash per queue
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-61-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-61-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,lst.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,nvidia.com:email,kernel.dk:email]
X-Spam-Score: -13.29

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Every queue runs its own DH-HMAC-CHAP transaction, but the hash that
> AUTH_Negotiate settles on is stored in the controller. A host that
> doesn't offer the configured hash gets a fallback, and that changes
> ctrl->shash_id under the transactions of the other queues, whose
> challenges have the length of the old hash:
> 
>    qid 1: AUTH_Negotiate (SHA-256), 32 byte challenge
>    qid 0: AUTH_Negotiate (SHA-512 only)
>    qid 1: DH-HMAC-CHAP_Reply with a hash length of 64
> 
>    BUG: KASAN: slab-out-of-bounds in nvmet_auth_host_hash+0x2c9/0x530
> 
> No secret is needed for that.
> 
> Store the negotiated hash in the queue and use it for the rest of the
> transaction. ctrl->shash_id stays the configured preference.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/auth.c             | 35 +++++++++++++-------------
>   drivers/nvme/target/fabrics-cmd-auth.c | 12 ++++-----
>   drivers/nvme/target/nvmet.h            |  1 +
>   3 files changed, 25 insertions(+), 23 deletions(-)
> 
Weird. But spec seems to be okay with that, I guess.
But then we don't really need to the shash_id from the controller,
so it should be removed from there.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
