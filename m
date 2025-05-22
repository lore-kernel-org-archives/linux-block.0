Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B52882BC
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922090; cv=none; b=qLk7gU4YgUx0iR6c/v6zmR6yBaZNyzwol7bYCuQjJchUfur5lSbDsTRROVZ7bOVuCifhSRaFmt/3l1OXSrhuloROP2MPIR1vnuPP/2xQGEV2O11kuyWrzI3cFo/DGrL958Z/lpdvXyxEcTRRtrKq82ChJm30EeIFkx0F0jwp7L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922090; c=relaxed/simple;
	bh=k30M+rpVlVXkNl/ODF6CVt8+kWK5XeccIa6hBgJH/m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffxhUakgSWUrAnDjMQ8MkPl983txNEo6tTQF6etndMyWec673mSYzqjuf5Xre+vP+M6RMxbi1LHcp96g+qOWVNsOPWYhgGic5VN+3aaO1XsF5cIIfr8SFtInDKX7v8muyp7+zStFi6IDDUzMyWVH1pFT6Fgi8J8yMp+8qgyEYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jAuN7Phx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5xO5nyWP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jAuN7Phx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5xO5nyWP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jAuN7Phx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5xO5nyWP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jAuN7Phx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5xO5nyWP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 199AC216E4;
	Thu, 22 May 2025 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747922087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtT6KLq9HxZlzAqUdQx6rMNDXcYQ56MDN/QxpYiv4xI=;
	b=jAuN7PhxZEjd2qTBYfaMg82C3xFJ7V8qkZQE9Y6bATsLdgg2k1XvNgsGdWmKwJfHazu9LR
	QmRtqziuusbFJhaeDuxzpYJQojBTXD1WlFL07Caj6KZsiD5rUzqDEOCiCnuFYk2M21yp2D
	8FSq7uVq+04Nnn06b0luKi/74bEVXAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747922087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtT6KLq9HxZlzAqUdQx6rMNDXcYQ56MDN/QxpYiv4xI=;
	b=5xO5nyWP2a22NgLOJJIQnRSpo8Qj+i7Vs/jy089FB0q3UtXj3r18wbvGMpyTnOzeOUFtcw
	UQtpc36K1FA3NnCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747922087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtT6KLq9HxZlzAqUdQx6rMNDXcYQ56MDN/QxpYiv4xI=;
	b=jAuN7PhxZEjd2qTBYfaMg82C3xFJ7V8qkZQE9Y6bATsLdgg2k1XvNgsGdWmKwJfHazu9LR
	QmRtqziuusbFJhaeDuxzpYJQojBTXD1WlFL07Caj6KZsiD5rUzqDEOCiCnuFYk2M21yp2D
	8FSq7uVq+04Nnn06b0luKi/74bEVXAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747922087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtT6KLq9HxZlzAqUdQx6rMNDXcYQ56MDN/QxpYiv4xI=;
	b=5xO5nyWP2a22NgLOJJIQnRSpo8Qj+i7Vs/jy089FB0q3UtXj3r18wbvGMpyTnOzeOUFtcw
	UQtpc36K1FA3NnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED420137B8;
	Thu, 22 May 2025 13:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OTOhOKYsL2jQCwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 22 May 2025 13:54:46 +0000
Message-ID: <7aab2c6c-4cd8-4f23-b61b-153f6e9c2ce7@suse.de>
Date: Thu, 22 May 2025 15:54:46 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250521223107.709131-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 5/22/25 00:31, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Register the nvme namespace copy capablities with the request_queue
> limits and implement support for the REQ_OP_COPY operation.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 61 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/nvme.h     | 42 ++++++++++++++++++++++++++-
>   2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f69a232a000ac..3134fe85b1abc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -888,6 +888,52 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>   	return BLK_STS_OK;
>   }
>   
> +static inline blk_status_t nvme_setup_copy(struct nvme_ns *ns,
> +		struct request *req, struct nvme_command *cmnd)
> +{
> +	struct nvme_copy_range *range;
> +	struct req_iterator iter;
> +	struct bio_vec bvec;
> +	u16 control = 0;
> +	int i = 0;
> +
> +	static const size_t alloc_size = sizeof(*range) * NVME_COPY_MAX_RANGES;
> +
> +	if (WARN_ON_ONCE(blk_rq_nr_phys_segments(req) >= NVME_COPY_MAX_RANGES))
> +		return BLK_STS_IOERR;
> +
> +	range = kzalloc(alloc_size, GFP_ATOMIC | __GFP_NOWARN);
> +	if (!range)
> +		return BLK_STS_RESOURCE;
> +
> +	if (req->cmd_flags & REQ_FUA)
> +	        control |= NVME_RW_FUA;
> +	if (req->cmd_flags & REQ_FAILFAST_DEV)
> +	        control |= NVME_RW_LR;

FAILFAST_DEV? Is that even set anywhere?

Otherwise looks ok.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
