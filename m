Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267563;
	b=S1MSvVe0eyPBlSQ20uMDJCamPAYFphzZaCS5BT9r9a3QZqkwv98uKBcc1lYpeC+jiprz
	 5HupI0mhlij+Xdmp+PXgzvFzWKdj0e/G/jPqc9krkeW5OJulq93uQ2HnNSGYiDM0MoV1O
	 mjUCU12op47tkPrR+VvltylTJEOM/njRRD+kT192B00ExIU+7rirM/hphDZe/h9jmY1zi
	 COzOfqRcdX7tg8Rs8RWap43Tc0RjAPwsmeSfO3HNGmE1uBF2Go2O79FI8F4eq+xS7dvGy
	 OqXVnQAKHlerfcenBu91SpniT9uk3+UDub2FB/folIxe599nmMY9s2zQHK5cDi1vR+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267563;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=UA4lB6ni5Kt+yPiZxHFsjRd+esYIJj19ltU5Ds3pfso=;
	b=bGIW0C0e0hu1CJqCYX+qXk2/dwzhHCscAsBlBHYfV+2UloOBbQE4dqeeAK5Ev1IYF7zG
	 zWqPWoWl129WAYO+Uy1cCCscyCxMlPfb/G0z4zcJJW3qJSjhlyiNfHLzIOk3oeWg7EYic
	 t5Eq46IJyxwoHBBMUKPnNzO8JOlCbr8UVLZTMmYLTF0YU48dm5iCqh9uIoLN7fEy7AO16
	 ZwiltgDunAT5ghko8IhtdUAlQSr3QAUc1vSJMZEoZf60TekLuF3MCZtJYeJaXrMoOrPnR
	 RLlHLwatKKcjLAyZaOIv8WwkNW14+fm6Ozvqqxh0tdJNFv2HhIDTdh8USK6O5A+ZAyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LaoCgKc4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TPKyoOF4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LaoCgKc4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TPKyoOF4;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F608606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 09:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F608606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LaoCgKc4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TPKyoOF4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LaoCgKc4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TPKyoOF4
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BB5B1F8B4;
	Thu, 29 Oct 2026 09:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA4lB6ni5Kt+yPiZxHFsjRd+esYIJj19ltU5Ds3pfso=;
	b=LaoCgKc4o0UZh9s5rTt712kuGpE9fZomuGzlDWy8YIwoJV2ruGp1cJuZ2QqtalCyjRrVyw
	W0Oj6WKqiAGTaDQmU9in+RASWcyOg+WA6zj5vvOJKFN/6aeOrZR23AFYd1UIMH16Kk8fd1
	70KzRsXp0Am3GlbVcSIHaTsJ+j3tyHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA4lB6ni5Kt+yPiZxHFsjRd+esYIJj19ltU5Ds3pfso=;
	b=TPKyoOF4D2voFzAIk1LYkfCUngWWS5dF8Ib5kDvzTWGDO1LSnlduRtETXbYm1BjC6i0gnF
	+MfSvTYfjUrLqeBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793267561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA4lB6ni5Kt+yPiZxHFsjRd+esYIJj19ltU5Ds3pfso=;
	b=LaoCgKc4o0UZh9s5rTt712kuGpE9fZomuGzlDWy8YIwoJV2ruGp1cJuZ2QqtalCyjRrVyw
	W0Oj6WKqiAGTaDQmU9in+RASWcyOg+WA6zj5vvOJKFN/6aeOrZR23AFYd1UIMH16Kk8fd1
	70KzRsXp0Am3GlbVcSIHaTsJ+j3tyHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793267561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UA4lB6ni5Kt+yPiZxHFsjRd+esYIJj19ltU5Ds3pfso=;
	b=TPKyoOF4D2voFzAIk1LYkfCUngWWS5dF8Ib5kDvzTWGDO1LSnlduRtETXbYm1BjC6i0gnF
	+MfSvTYfjUrLqeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07EED13419;
	Thu, 29 Oct 2026 09:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y0vgNGgX42p2HQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 09:52:41 +0000
Message-ID: <4be77cb2-7e6e-4054-a9ae-89530e89d853@suse.de>
Date: Thu, 29 Oct 2026 10:52:40 +0100
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
Subject: Re: [PATCH 62/98] nvmet: don't mix queues with and without TLS
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-63-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-63-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,grimberg.me:email,lst.de:email,nvidia.com:email]
X-Spam-Score: -13.29

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Since commit fa2e0f8bbc68 a controller whose admin queue uses TLS gets
> no host key, the PSK stands in for DH-HMAC-CHAP. But a port with TREQ
> "not required" takes plain connections too, as does any other port the
> subsystem is linked to, and the Connect of an I/O queue names its
> controller by NQNs and cntlid only. So anyone who reaches such a port
> can add a plain queue to a TLS controller, and with no host key nothing
> is asked of it. The other way round, a TLS queue skips DH-HMAC-CHAP on
> a controller whose other queues had to pass it.
> 
> A host uses TLS for all queues or none. Refuse an I/O queue Connect that
> differs from the admin queue in that.
> 
> Fixes: fa2e0f8bbc68 ("nvmet-tcp: support secure channel concatenation")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/core.c        | 1 +
>   drivers/nvme/target/fabrics-cmd.c | 9 +++++++++
>   drivers/nvme/target/nvmet.h       | 1 +
>   3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 5bd78bb83cf9..333739f14c2b 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1646,6 +1646,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   
>   	ctrl->port = args->port;
>   	ctrl->ops = args->ops;
> +	ctrl->tls = args->sq && nvmet_queue_tls_keyid(args->sq);
>   
>   #ifdef CONFIG_NVME_TARGET_PASSTHRU
>   	/* By default, set loop targets to clear IDS by default */
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index 38311187d27a..ddb732f62981 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -377,6 +377,15 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
>   		goto out_ctrl_put;
>   	}
>   
> +	/* All queues of a controller use TLS, or none of them does. */
> +	if (ctrl->tls != !!nvmet_queue_tls_keyid(req->sq)) {
> +		pr_warn("ctrl %d: queue %d with%s TLS\n", ctrl->cntlid, qid,
> +			ctrl->tls ? "out" : "");
> +		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
> +		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
> +		goto out_ctrl_put;
> +	}
> +
>   	status = nvmet_install_queue(ctrl, req);
>   	if (status)
>   		goto out_ctrl_put;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 46501d0757c0..cc7fface77de 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -308,6 +308,7 @@ struct nvmet_ctrl {
>   	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
>   	bool			pi_support;
>   	bool			concat;
> +	bool			tls;
>   	struct mutex		auth_lock; /* one AUTH command at a time */
>   #ifdef CONFIG_NVME_TARGET_AUTH
>   	struct nvme_dhchap_key	*host_key;

Hmm. Technically TLS is a feature of the TCP transport and only 
applicable there. We should delegate this step to the TCP transport.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
