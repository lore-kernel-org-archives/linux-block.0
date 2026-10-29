Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268128;
	b=CKmrDxjFr67S8RB7WngX6TeqcaLMLTaLIxZy3hjHPun2vClmCzLCEHJxXAD4k00xS1Ed
	 mouiclu+DM3BIOuaMgPFDN4lIDn/pSYgRrkaWvKYqRPf3+qE+Rvut/Y9pcS1lrDveUlz2
	 dYIVhgKdBT0dD2O8t4rXYvoLnO89Nu8cidG912nBSeScjyBiFW/22xdjj3gciH0DntZNA
	 aVdnh++HH2FmA8Vn+B7U2rz398FFDJH6JifOeWuVTt02H6JyUWDAe9rwV1iNCszPUXffU
	 1L/358Aeu4oQ319YQ9NHMayTUYszNkb9JByimOa0btQophwvR4ULQeX18ZAUpjALN8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268128;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=wFAVIpvWXmBPqenidlfjSz8sNcu2b+3ejAdYtmPRfRk=;
	b=xwzCXeRsGs+NfTzU+qAz1CzIbB7L0j3EBejr7p1/0tnrmQGDszVxShVO4JTnbUBfrUoS
	 zhF4FGEnFBrq8Zyy0WEnjy/G19Gyz4uZudxfZUE4c49vva/ZMLpdXqXa1PR9wLTFk3LYx
	 EPJANBtif/J5k+o7EVZmDMo6dCUlq/DMGT0VrrUYZYO1b9WCTvVJKWCuktQs3StOOFYJg
	 p4zaYPnUgkZCM44cCHXgkeKDFYtIwctmhZa+vwUky9U7FXUsL3wKHB5AL/Dy0aq4OWWAu
	 aJNDTs7GwNfujwQK4YrqSCy4B5XRAwxlNFiG0eNvmNuGTdnmFSJHOpYmVO+zhsku93A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="H/0DqX7y";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="BsGM/UqX";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XE9p+biY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6zf7ZX0h;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044D8606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 044D8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=H/0DqX7y;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BsGM/UqX;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XE9p+biY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6zf7ZX0h
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 19AE41FB41;
	Thu, 29 Oct 2026 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFAVIpvWXmBPqenidlfjSz8sNcu2b+3ejAdYtmPRfRk=;
	b=H/0DqX7y6FJaU9zdkpLg+/4ymUskvfChDFjPJ64K0f5jQwazm5fl9W4am3ER1+Q2VQp3YW
	uQSAkFfuqzMZGWhecwCcZiK0H6+iWZIm6zfRda1ShZz273WnUBcTThPrpVhHs708zCPnp4
	0xX40wBQj/Ggci3xn5MZBrKVjydz/DE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFAVIpvWXmBPqenidlfjSz8sNcu2b+3ejAdYtmPRfRk=;
	b=BsGM/UqX6GDa8xH+ngBbavw3PJvlSTSEZz+7XFcVBXJs6EGV3Lekbe1H1RcbPyRU9ouzLf
	p5n3Om+ekiRUSMBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XE9p+biY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6zf7ZX0h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFAVIpvWXmBPqenidlfjSz8sNcu2b+3ejAdYtmPRfRk=;
	b=XE9p+biYZHA3E/eFoZ7RPpM3AKpd90Mh81lNsBT7jadDwDzYLdoF1FdGqdtKIAFoVKsTry
	LcJXxWUSdq9UCPLXAgZm0Xg54oot8KxpD2iNeECHrKj+xKnkU3ZhFLZ5krw89JfoQVHeBf
	ouKda1NHAvuNZppiBTdYjVsm4lSIWaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFAVIpvWXmBPqenidlfjSz8sNcu2b+3ejAdYtmPRfRk=;
	b=6zf7ZX0hWSr5hrojtK28sUauma0JSuuKhW7JtaA0vp25NqnnIaq4a6EIHxzJk0r8zgqKCq
	xx58vKdUVaHltKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D54D813419;
	Thu, 29 Oct 2026 10:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q3OnKpsZ42q/JwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 10:02:03 +0000
Message-ID: <6fcce944-334e-4cf4-8a9c-486b8f551f5b@suse.de>
Date: Thu, 29 Oct 2026 11:02:03 +0100
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
Subject: Re: [PATCH 73/98] nvmet-tcp: stop listening when a port is removed
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-74-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-74-axboe@kernel.dk>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,nvidia.com:email,grimberg.me:email,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,lst.de:email,kernel.dk:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 19AE41FB41

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> nvmet_tcp_accept_work() accepts until there's nothing left. A
> connection that is already dead when accepted is torn down right there,
> which takes a few ms, and more can arrive meanwhile.
> nvmet_tcp_remove_port() waits for the work with cancel_work_sync(), so
> someone opening and closing connections in a loop keeps the removal from
> finishing. It holds nvmet_config_sem for writing, so nothing can be
> configured and no port answers a Connect until the flood stops. No
> secret needed, just an admin removing the port at the wrong time.
> 
> Shut the listening socket down first. Pending connections are dropped,
> as they were on release, and the next kernel_accept() fails and ends the
> work.
> 
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/tcp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 3d24efe3b7c3..0b70d3647e28 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -2263,6 +2263,8 @@ static void nvmet_tcp_remove_port(struct nvmet_port *nport)
>   	port->sock->sk->sk_data_ready = port->data_ready;
>   	port->sock->sk->sk_user_data = NULL;
>   	write_unlock_bh(&port->sock->sk->sk_callback_lock);
> +	/* The accept work goes on for as long as there is something to accept */
> +	kernel_sock_shutdown(port->sock, SHUT_RDWR);
>   	cancel_work_sync(&port->accept_work);
>   	/*
>   	 * Destroy the remaining queues, which are not belong to any

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
