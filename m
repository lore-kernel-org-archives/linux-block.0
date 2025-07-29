Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BC22A4F6
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784389; cv=none; b=HUNNQIlox5RSziJrIMQqKNGJrvpPsT0TXNHiH4GX4yodG/gh8BFd2L3O8b8ROU87qhSlGJ2rjozSSw2OMf4RU+aJdbx9YfvmnraRLYt7Rp28fon9d5dgXOefh7UD5Jvi6Ps5q+ShTH3wMiyE453MPPBvbOAyXOLY/MR9W2UUevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784389; c=relaxed/simple;
	bh=oSwh0G2w7Viju+gYn6dkev50d+2GGHjmfU9cPFfBikM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PO2BSz/i7oCAIB6wWWH07Wep9DKKDKz2L2fwXpL8I6ePT0/PooKkj/lukgNXQFrpMyHD16LyV1O+iArAdhJgCSvwwdq+IEX4gfw9bttHG0EDOWqjhKwVyKseKmcs+rvsFHxqscH7p1AnWEDtN8+/w0tk3j8KaTiWtR5Bq25Oymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ro+OvbHd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1LIkgrcY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ro+OvbHd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1LIkgrcY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ro+OvbHd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1LIkgrcY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ro+OvbHd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1LIkgrcY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 852DA21184;
	Tue, 29 Jul 2025 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753784384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRmYve4vvOWlKUi6vjlD47oFrSsHSrR9Nv1qq1etsFg=;
	b=ro+OvbHdHPu8NjqznD3Y14IW6iKpZYVm6X83XYXwh1TZXdeQr5QMnGbFTkbY/2df4bdZUx
	oqDCYLx7hh1GNjVPI8SYyWq4Uxc4+Z43orR/vBrhFtl8JguUcFlt6U3J85a8O52SqP4qYV
	NJOtOMadg0EoltnNDF7bJi8Qpp47DbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753784384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRmYve4vvOWlKUi6vjlD47oFrSsHSrR9Nv1qq1etsFg=;
	b=1LIkgrcYtSniE+A2iZN6AEJE4xn2OfEo3gInu37U7oUKA/te3tpy0VZk/z8tu7OWCV0oyw
	0Sme6ZCsXRpYL3AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753784384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRmYve4vvOWlKUi6vjlD47oFrSsHSrR9Nv1qq1etsFg=;
	b=ro+OvbHdHPu8NjqznD3Y14IW6iKpZYVm6X83XYXwh1TZXdeQr5QMnGbFTkbY/2df4bdZUx
	oqDCYLx7hh1GNjVPI8SYyWq4Uxc4+Z43orR/vBrhFtl8JguUcFlt6U3J85a8O52SqP4qYV
	NJOtOMadg0EoltnNDF7bJi8Qpp47DbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753784384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRmYve4vvOWlKUi6vjlD47oFrSsHSrR9Nv1qq1etsFg=;
	b=1LIkgrcYtSniE+A2iZN6AEJE4xn2OfEo3gInu37U7oUKA/te3tpy0VZk/z8tu7OWCV0oyw
	0Sme6ZCsXRpYL3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6589313A73;
	Tue, 29 Jul 2025 10:19:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k27AF0CgiGhzYAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Jul 2025 10:19:44 +0000
Message-ID: <17b5c0f1-f92d-42ca-9ead-2ac609f98463@suse.de>
Date: Tue, 29 Jul 2025 12:19:44 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] block: Enforce power-of-2 physical block size
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
 bvanassche@acm.org, dlemoal@kernel.org
References: <20250729091448.1691334-1-john.g.garry@oracle.com>
 <20250729091448.1691334-3-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250729091448.1691334-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/29/25 11:14, John Garry wrote:
> The merging/splitting code and other queue limits checking depends on the
> physical block size being a power-of-2, so enforce it.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   block/blk-settings.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index fa53a330f9b99..5ae0a253e43fd 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -274,6 +274,10 @@ int blk_validate_limits(struct queue_limits *lim)
>   	}
>   	if (lim->physical_block_size < lim->logical_block_size)
>   		lim->physical_block_size = lim->logical_block_size;
> +	else if (!is_power_of_2(lim->physical_block_size)) {
> +		pr_warn("Invalid physical block size (%d)\n", lim->physical_block_size);
> +		return -EINVAL;
> +	}
>   
>   	/*
>   	 * The minimum I/O size defaults to the physical block size unless

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
