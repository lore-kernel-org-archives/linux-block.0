Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268488;
	b=MgI+fiuRDlrTCuDazP8dIHq7j32RdWtJvHKO96uFuIsmvyTZgo3hQHuYZI+60RgkxPS/
	 m0bvGVHlrIK8POE4TCd+ZdQJUM3Hmyr5j+sL4jgFAzgv6julGDJTDuzH7nwZFiuVgW+cW
	 OZ8KITn+L8wiBu/p6I2NltxnO2Otxli8E+CZkcx2OtrWGDZQlp/Za0Jtgyq3jslP0oDNr
	 Sa5XK0J2IaZibYB6xZQ3NmeTgjrTRV3KDxSJVIrPSYk/B8ZcC3tNHNJGILbbbbIR7VTiz
	 9kCAsqfIi4X3IdciMETkve1vb2QHKOftxqPfdfGUqQ5JrST+j27tKrtL3dvbfiVy11g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268488;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=YfsKotmiF6S30Blh5dPFkz9BiZrO3ruD48DAYR24JgI=;
	b=hwc1FHikGYyuT7++Abp3m/qG5POnj7kee+11GI/BqDLsHc2SjaMIh/GahvyrWN57qc1L
	 nG++tLpmwltMyhtWPvTjNjhQWy0GgT9VVu57D+nlZYBm4VFQrDAH2uXamxwNhVdDeGC9F
	 tLz/kf0LrueO9aeAxWXP5Asc6Ry5s6dpBtlsAyPJDZbFYl0MRH0+iZs9mHKWUsdLXARIL
	 IG7eWa83iJdMbKdkbZwMdJxE2hmuX3WjWLQeh5+zmscbIwchrw1kuUK3mgSXbr/rdp4QL
	 h64isSMPzPsuDZ5N4/cJvI2Jcputm5vymaLwsN/S1mc6Ap6xW3nmbglPC1vvicBvbSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GrvYcjw7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gVoVWWZR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uHJVTP1E;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eMFyLVkr;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0998606A321
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0998606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GrvYcjw7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gVoVWWZR;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uHJVTP1E;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eMFyLVkr
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A36C61F803;
	Thu, 29 Oct 2026 10:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfsKotmiF6S30Blh5dPFkz9BiZrO3ruD48DAYR24JgI=;
	b=GrvYcjw7fve5eeP0T3aX3YtNM+4mYzHZZUmzi1hGVuzFcZmtoGW+AIe9z09K8L9oXtk6HL
	869rKF98Mn2D60HJdsLPvSn+i0dQxEldhSVsEu0PTa+bvi6kQbl7bZSzmAVim5L3aayNdO
	xLYpyhiDaAyKLXk4w8EfSuVz16fqGw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfsKotmiF6S30Blh5dPFkz9BiZrO3ruD48DAYR24JgI=;
	b=gVoVWWZR+TJdmTQ7zfy09LNwyGNwEe0q2sEC9vzZXeUCxh1O3dzOewnRqEbnIcNL4D+v4J
	nX22bu/juf5W/YBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uHJVTP1E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eMFyLVkr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfsKotmiF6S30Blh5dPFkz9BiZrO3ruD48DAYR24JgI=;
	b=uHJVTP1Eq1yCdVPcqBrps53SX2nNHiQCrT9Vi4KtoKm539brcdDY8LZs4MjQXEmrPiI3ht
	UrsbmbPgRzH0gcmQt5HMpBq18Eykc2dqgzUcv+5+8jsizoq1ln41rUDX0UvZEkI8QKNOkD
	A0uA75QXfgP1itEGAmNcSGoOFuIEmvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfsKotmiF6S30Blh5dPFkz9BiZrO3ruD48DAYR24JgI=;
	b=eMFyLVkrwrAeOJLORdWxfzT7wT/3b1/91p1YoVWPhazUINTbIUmNYwSBqaTGdius5M1+aJ
	9mdmoB0DJ6tlmqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7028B13419;
	Thu, 29 Oct 2026 10:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fqXlEgQb42q+LQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 10:08:04 +0000
Message-ID: <c15eecc9-8086-4ce1-9a05-a395c3268a83@suse.de>
Date: Thu, 29 Oct 2026 11:08:04 +0100
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
Subject: Re: [PATCH 79/98] nvme-tcp: start error recovery when a send fails
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-80-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-80-axboe@kernel.dk>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,toxicpanda.com:email,grimberg.me:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,kernel.dk:email,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: A36C61F803

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> When the target closes a connection, nvme_tcp_state_change() calls
> nvme_tcp_error_recovery(), which does nothing unless the controller is
> live. While connecting that's fine for the queue being set up, its
> Connect fails and the attempt with it. But if an already connected queue
> is closed at the end of the attempt, nothing fails, the notification is
> lost and the controller goes live on a dead socket. Every request on
> that queue then fails with "failed to send request -32" and is retried,
> forever with native multipathing, and if it's the admin queue the first
> keep-alive fails too. Nothing but a manual reset recovers it. The Linux
> target closes its connections at exactly that moment after a fatal
> error.
> 
> Start error recovery when a request can't be sent, as nvme-rdma does.
> 
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/tcp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4aa666dd0266..52c7f6dd34d0 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1461,6 +1461,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   			"failed to send request %d\n", ret);
>   		nvme_tcp_fail_request(queue->request);
>   		nvme_tcp_done_send_req(queue);
> +		/* The close may have come when nobody could act on it */
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>   	}
>   out:
>   	memalloc_noreclaim_restore(noreclaim_flag);

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
