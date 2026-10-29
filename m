Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268421;
	b=xfgjca/gwcfhMIRdqF5Tv6kINgfoLYxWe7U5AiJgLg+pLEDvkI4v9OzKbrVTP3HpnVqp
	 CwWhZAUtLDLy5bBozBmSVGd1GvZdjjE4M2uSRn+bwTHw2Ijz6bSHUYwNxQ++IQEMPq4bj
	 TWD6IFSqpHOqdUEkv+ue3wp2Sa2mXt7T3Jk3H6MjjJTaM5ho32ZlwWmZMZOkYKGLOViWP
	 8vzRhbAL1kWvstH1j8ncphHh9P8h5ZupvjUEOerXpimG5L6YWKU0UiP7ib9iZOqEwR2CO
	 W2REr5vQFbBcUtD3mOb9nylaAc2PGOrTWqp9+fCu3HdvGCLoXGjgO/rxZi79l7qzbZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268421;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=uh7aKxAnQ2vbYF7zyO+141IKOuPw5bGGBCezf0HWLW4=;
	b=KZrtKu6PWfnOEj43GQxfzGQAxmm03Fnxuhd0DOhycDaZlBiGQm4I0VLWDtccaYupy/Gz
	 XoQAPxG59lc+rEbeWaO+RnbEF0Vc+Zic4SW5si0n4x+VzA5o9Iu+opHh7C5akjebwuxeO
	 TiFnXZBstYw623xSEq4Spjo8b262BQOnvcBkAidf2Nilgb/7WTk5fbnghW9m9Gvp4OybX
	 U+/bjS7pRKQleeR9o0m9AuIKZdg/nW9m9B1hgFdBAFmJ7qOkjjUIPQew5jCRuuiFdXx8C
	 AZkzN8SNO+qyqieSl3zVco7tRdIF1oqIGDKOHfLygRPjI2xAsZbAfB8j5NlvM+/iPdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l38am5NH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wX2Je5DY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l38am5NH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wX2Je5DY;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047BA606A32F
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 047BA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l38am5NH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wX2Je5DY;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l38am5NH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wX2Je5DY
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31C4721F77;
	Thu, 29 Oct 2026 10:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uh7aKxAnQ2vbYF7zyO+141IKOuPw5bGGBCezf0HWLW4=;
	b=l38am5NHrpX6hlLI1e3or1uYt2j0aXyzHDNzWods5YlDtTr5LpPiH90XkjGnS1i8pY9zy7
	BYyY77ewdH09BcOAmP6uhTslTUElu0kEfIoVFSu32caaqDDynHKcE5+PUVDDHBA9vprLmD
	mX76dxPJIlskknBY4OsLKKYEUvv5azg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uh7aKxAnQ2vbYF7zyO+141IKOuPw5bGGBCezf0HWLW4=;
	b=wX2Je5DYcKMKWtUMPXZP5VoNgwr2ftJbYolgd9S8Xe7WbEx5lhClsxlkqAsdu1qJSTtnwe
	9RnFEIKstVvTgfAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l38am5NH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wX2Je5DY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uh7aKxAnQ2vbYF7zyO+141IKOuPw5bGGBCezf0HWLW4=;
	b=l38am5NHrpX6hlLI1e3or1uYt2j0aXyzHDNzWods5YlDtTr5LpPiH90XkjGnS1i8pY9zy7
	BYyY77ewdH09BcOAmP6uhTslTUElu0kEfIoVFSu32caaqDDynHKcE5+PUVDDHBA9vprLmD
	mX76dxPJIlskknBY4OsLKKYEUvv5azg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uh7aKxAnQ2vbYF7zyO+141IKOuPw5bGGBCezf0HWLW4=;
	b=wX2Je5DYcKMKWtUMPXZP5VoNgwr2ftJbYolgd9S8Xe7WbEx5lhClsxlkqAsdu1qJSTtnwe
	9RnFEIKstVvTgfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E733F13419;
	Thu, 29 Oct 2026 10:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id txWfLr4a42rRLAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 10:06:54 +0000
Message-ID: <bfb7dee9-f9b5-41fe-94fe-4e1d1f9f374e@suse.de>
Date: Thu, 29 Oct 2026 11:06:54 +0100
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
Subject: Re: [PATCH 77/98] nvmet-tcp: let the accept work come to an end
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-78-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-78-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,grimberg.me:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email,suse.de:email,suse.de:dkim,kernel.dk:email,toxicpanda.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 31C4721F77

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> nvmet_tcp_accept_work() loops until there's nothing left to accept, and
> anyone opening and closing connections fast enough keeps it running
> indefinitely, since tearing down a dead connection takes long enough for
> more to arrive. Whoever flushes nvmet_wq waits for it: removing any
> other port of the target does in nvmet_port_release(), and so does
> unloading the rdma and fc modules.
> 
> Accept a bounded number of connections per run and requeue the work. A
> flush doesn't wait for work queued behind it.
> 
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/tcp.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
