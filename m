Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268530;
	b=ACeEP0HBLHNOh+JxjMCZA9Q/ywB3GWBs4hvYgKQoMH8Gtk73hbidmM/7vFwloKebYL4b
	 u0+qc7s4ztCtIWoGho6PFu0OgLFJRCP70lqHeiYP2H7TqIgmcsuLHuuhgPRFJN0JuUbnH
	 zRACmCa0yx9mL5sG6ur8YUVl53RRDXFzU07ldQRGw6qjRoGjY+kley2/SQ+mXa2Zgia7J
	 asXU+sZd0VlxvGN1EMU9JcTdCw/2jporb2eSVJ9uUT4l0sgZjih8FYgQE+A2wU8szT8IR
	 k+WLidEP72GY/y3ER4bDMPM+5szthUAvNeJDbhRqSxuO4IAKUO6twiFRZ4Vu/hdkfBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268530;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=rw9P2IoBa6eZIdEYjDusioClo20Nhdo0iuTV6mBDZHQ=;
	b=BrIjyJgr8XokVmmXTD//UNmiXA4EGMkgJCtOxWBRq5+Gd+YcpHxlMrVJbo/CQcKkP0iE
	 lSi9QpOIp4MbFrc88ZqoPCo5aKssfTjeaEe53VAwxHF3MwVXwpBS7Z3q7V/YFXUKE58Wl
	 KDqyt4/GILgl/nFwaqIYHKYDsrGiureh9Vr+jlkJKuElsF0u3wgg/Gp58Uf4WKETOy3Jd
	 h4JVMWhl5i6Ta3NTZx9pHIT1SvhlLaQ/AidnKjDhcQRU570cPSOuWCU9Dp40RMhK87RoY
	 iTIXDgCG4ib4CkXamleu56XHQXD6Ugg9QVddXfjWXXKqQEI+j36yOLhbcU252OQOL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nqphY28o;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DY0705Fn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nqphY28o;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DY0705Fn;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E86606A326
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61E86606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nqphY28o;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DY0705Fn;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nqphY28o;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DY0705Fn
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 870031FB5F;
	Thu, 29 Oct 2026 10:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rw9P2IoBa6eZIdEYjDusioClo20Nhdo0iuTV6mBDZHQ=;
	b=nqphY28o0XFshSoLm7GnxZGsGfU3AvCeYafbA0dT+blTHIiw+ItQFURKEvlJP7xtAwrWld
	b6NdFzgugatTFT/TKHOi6qKtfWGD87H9QFSq2uAUR7WnhoQtH0rLBtxzb+VvInZ7XTBCRL
	abGaUuky/ShThuTmXlUYF2chabYyS/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rw9P2IoBa6eZIdEYjDusioClo20Nhdo0iuTV6mBDZHQ=;
	b=DY0705Fn3v2IVpa4oXszqpMhPJCmgGeFYd11Kz78J9URhYmtM5HI6u/8BAxoXVeqawPIu6
	2QiTjwOGNnYeKXBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nqphY28o;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DY0705Fn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rw9P2IoBa6eZIdEYjDusioClo20Nhdo0iuTV6mBDZHQ=;
	b=nqphY28o0XFshSoLm7GnxZGsGfU3AvCeYafbA0dT+blTHIiw+ItQFURKEvlJP7xtAwrWld
	b6NdFzgugatTFT/TKHOi6qKtfWGD87H9QFSq2uAUR7WnhoQtH0rLBtxzb+VvInZ7XTBCRL
	abGaUuky/ShThuTmXlUYF2chabYyS/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rw9P2IoBa6eZIdEYjDusioClo20Nhdo0iuTV6mBDZHQ=;
	b=DY0705Fn3v2IVpa4oXszqpMhPJCmgGeFYd11Kz78J9URhYmtM5HI6u/8BAxoXVeqawPIu6
	2QiTjwOGNnYeKXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5371A13419;
	Thu, 29 Oct 2026 10:08:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AxoTDC8b42qCLgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 10:08:47 +0000
Message-ID: <bb279413-aca9-419b-ad57-4aeabce10934@suse.de>
Date: Thu, 29 Oct 2026 11:08:46 +0100
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
Subject: Re: [PATCH 80/98] nvme-loop: don't BUG() if a scan runs beside a
 reset
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-81-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-81-axboe@kernel.dk>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,lst.de:email,toxicpanda.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 870031FB5F

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> A reset sets queue_count to 1 while it destroys the I/O queues and
> counts it back up when the new ones are made, and it doesn't stop the
> scan work. A new namespace found in that window trips the check in
> nvme_loop_init_hctx() for every hctx but the first:
> 
>    kernel BUG at drivers/nvme/target/loop.c:224!
>     nvme_loop_init_hctx+0x7d/0x80
>     __blk_mq_realloc_hw_ctxs+0x3af/0xa80
>     nvme_alloc_ns+0x1a2/0x22f0
> 
> The check protects nothing. ctrl->queues has nr_io_queues + 1 entries
> for the life of the controller, the tag set never has more hardware
> queues than that, and nvme_loop_queue_rq() rejects requests until the
> controller is live again.
> 
> Remove it.
> 
> Fixes: 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/loop.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 93ba6357a850..80b67608eb15 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -221,8 +221,6 @@ static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
>   	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(data);
>   	struct nvme_loop_queue *queue = &ctrl->queues[hctx_idx + 1];
>   
> -	BUG_ON(hctx_idx >= ctrl->ctrl.queue_count);
> -
>   	/*
>   	 * flush_end_io() can be called recursively for us, so use our own
>   	 * lock class key for avoiding lockdep possible recursive locking,
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
