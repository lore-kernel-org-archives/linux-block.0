Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259658;
	b=2b7IHTuRk/zjOZc48A+2BNFZEFHWkbPQW9ulkdFiEJFNFN4QJbxF1cXMAASUWo20W8FH
	 Tb+N1YttnrwnbLDveZmTlOzA3FiZ59Zg3iJO5AUwOmX4YaG90mUHYQMGE1KmqJVaoPLgx
	 f/cOofKjE1H3bHIVmY3IXgP+XZnvv5M4HoMu347hRW8n9pE5d2l4T+zBca+U6AsyEoDEW
	 KEz4mn+0GACXfJ/9oWc3umHvEN3RiRDeIa8v6aGiN/FHz+02mnVzaxagTD62TU1rpoWp3
	 bjhxMRanlmDdS/iyROGN3cFrNK6vOaT+MHR62hUrYb243qejl1kyUyV4ZL4HDl/ac3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259658;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=hUlacaKhExYHRf4258QqR1PayElB/Gd/eJyJhLSWnEo=;
	b=v1qQleCcqzPoUEMTXK4AV2Hzq1Mr1w+LN0ZuONxY0KO/DOf57LqX/OdcSV+Ubk6eObMI
	 ZfLNN8KKAIgIWR/SFr4q2CV2jDOoKHSsB1UCzHTzekTLFyLcsVWnn6iPSRvAWvf8EbdTw
	 3kHtM6NKBvfTz9UEpK8+/yXbe2sj+VwnXoEuTqi4Sf/NxAorGPJ5ToOMOSCTejOlRqA7i
	 sDna95raX0I6n+XlxymxmbGnJkg1iSMl/UpIbd5jvxayKiD1QJ2D1W9qqjl94SobMl0de
	 LSqUif+Le6H8xmNh5xwcH60Tvg7Ey9vluwHT2q3jhpyVNoVY353ldUNyMjU/ZUu2dmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sRWTMFlU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ffHRCq6h;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sRWTMFlU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ffHRCq6h;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3336A606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 07:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3336A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sRWTMFlU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ffHRCq6h;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sRWTMFlU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ffHRCq6h
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F3071F800;
	Thu, 29 Oct 2026 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793259656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUlacaKhExYHRf4258QqR1PayElB/Gd/eJyJhLSWnEo=;
	b=sRWTMFlUtEnw7gD0mNZno5CQ3dvwqF/OJukQ01b8uEvKF2z2Y9MU52Wgtjw4aV55Cqe0Co
	TXdGboDyApVHkROokw6Os4j0k77pzJ9S5jRtj1nNJ5hzyIKR7SNYkuzEeI1xI22vFLzis1
	n8l5C5RwQL5yhNrmhPQQFToIOzc/k0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793259656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUlacaKhExYHRf4258QqR1PayElB/Gd/eJyJhLSWnEo=;
	b=ffHRCq6h5u4KqiEb1dvKjSNWBU12vu4mglyDEgi1OmcPVUus5mexCrPz5UHA1WOyLB+5BV
	DyrGdkoHZSwUyaBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sRWTMFlU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ffHRCq6h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793259656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUlacaKhExYHRf4258QqR1PayElB/Gd/eJyJhLSWnEo=;
	b=sRWTMFlUtEnw7gD0mNZno5CQ3dvwqF/OJukQ01b8uEvKF2z2Y9MU52Wgtjw4aV55Cqe0Co
	TXdGboDyApVHkROokw6Os4j0k77pzJ9S5jRtj1nNJ5hzyIKR7SNYkuzEeI1xI22vFLzis1
	n8l5C5RwQL5yhNrmhPQQFToIOzc/k0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793259656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUlacaKhExYHRf4258QqR1PayElB/Gd/eJyJhLSWnEo=;
	b=ffHRCq6h5u4KqiEb1dvKjSNWBU12vu4mglyDEgi1OmcPVUus5mexCrPz5UHA1WOyLB+5BV
	DyrGdkoHZSwUyaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1E2213419;
	Thu, 29 Oct 2026 07:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SpJ/Kof44mpeEwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 07:40:55 +0000
Message-ID: <9d50dd8f-ec5f-4d0f-806f-52c03b610b42@suse.de>
Date: Thu, 29 Oct 2026 08:40:55 +0100
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
Subject: Re: [PATCH 50/98] nvme-tcp: wait for an in-flight TLS handshake
 callback
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-51-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-51-axboe@kernel.dk>
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,toxicpanda.com:email,kernel.dk:email,suse.de:email,suse.de:dkim,lst.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 4F3071F800

On 10/28/26 5:41 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> If the wait for the TLS handshake times out or is interrupted,
> nvme_tcp_start_tls() cancels the request and returns.
> tls_handshake_cancel() returns false if the handshake already completed,
> in which case nvme_tcp_tls_done() may still be running while
> nvme_tcp_alloc_queue() tears the queue down. On the first connect that
> frees the controller, including the queue array the callback writes to.
> 
> If the cancel lost, wait for the callback to signal completion before
> returning, like the SUNRPC callers do.
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/tcp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7190eb10c248..d735994ee517 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1827,7 +1827,12 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   		dev_err(nctrl->device,
>   			"queue %d: TLS handshake failed, error %d\n",
>   			qid, ret);
> -		tls_handshake_cancel(queue->sock->sk);
> +		/*
> +		 * If the cancellation lost to handshake_complete(),
> +		 * nvme_tcp_tls_done() is in flight and still uses the queue.
> +		 */
> +		if (!tls_handshake_cancel(queue->sock->sk))
> +			wait_for_completion(&queue->tls_complete);
>   	} else {
>   		if (queue->tls_err) {
>   			dev_err(nctrl->device,

This has already been reported to the linux-nvme list
(https://lore.kernel.org/linux-nvme/20261022071934.3818224-1-thnkslprpt@gmail.com/)
Please drop.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
