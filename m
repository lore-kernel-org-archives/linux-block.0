Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD792376FD
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746170533; cv=none; b=YZlT1ge/h5/wHx+2mHcvhbc1hwSyTwg3xoDvjIUFkm2KpXyt2cN03+2hrFsj4n1n8y771CxRZ/Y8A7hMEOJvIslQzkkKXvfISoxDgyI/Mk/GDWWGu0Qmp+qUnWRUTdiw0fgVsuTzqX7aL86bHRCsc0u85SViEsEyrkTCgi+uF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746170533; c=relaxed/simple;
	bh=U9DVAjG0Jp3K+euBbfgvYmroI9YEp7vfVXJmfZvkzh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6Lh+eeBMAtUEgv0u/nVlcnw5qTz29swLKoBOZQbNIMF5VcbVjRjdC0eYnuGB7ORraiFPEBUkyCLyLVkzCTLtT3/WIwk/zTQZAtL5TmpThsgPUudv4HwjA/HirdCU4JPM0up/A3onERoHHrfBwb9z0/aEn240GiCvYU+4dpUeJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xmzsv+Vy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+TJm6/dT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jjXLTlLF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0MsBfqz2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xmzsv+Vy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+TJm6/dT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jjXLTlLF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0MsBfqz2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E834F21A0D;
	Fri,  2 May 2025 07:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746170530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdu9m/P+tQklfOXQav1rWIFqMgQETbHUNUcz//zL6U4=;
	b=xmzsv+Vy/+KSVv5T5pC9uDwNv04d6XNWEv5A2zFE2XVkeU3s6YE9mVjwA/qot/rqZogbTH
	Djgi1TVBKImEqt2PQKBcIkrT/xZwysIO5YRp4VLqyHthpDFKghXAGJYt2SpN80bbnEswXa
	1M4vbB6a1tjpJWIF3seZ9IbsygZCu+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746170530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdu9m/P+tQklfOXQav1rWIFqMgQETbHUNUcz//zL6U4=;
	b=+TJm6/dTNa76cNv0BMRQVdVeGZHmpiYMtooYfvjK0bI+e5apqZgOrS9cJxQzzdegj2RJ7N
	WSqEFA6Q7DV2IaCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746170529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdu9m/P+tQklfOXQav1rWIFqMgQETbHUNUcz//zL6U4=;
	b=jjXLTlLFLLS0M6KldadVYDpfRVR21G+3yuTL4+ANjmDIwRZ0d1UB2OqKyIbBdukvTLMFEB
	ylQE4PP62myb9k2wfQgkACEn4xXsvhNqbCqP0W21TY0YnbSJhv1sjIKP60EV9xAzoaCnqd
	IPB/y1nFSTqP9hqt25wt/WgCLbyPCGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746170529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdu9m/P+tQklfOXQav1rWIFqMgQETbHUNUcz//zL6U4=;
	b=0MsBfqz2to0Y7XXfYxKjGHDOpTw22aLzdYw80fNjEysSA8Zj2xMuoak1Bg7fV3ROO8TWXU
	Ha5fBE9F+W2hntBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9FED13687;
	Fri,  2 May 2025 07:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L54aKqFyFGhLNwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 02 May 2025 07:22:09 +0000
Message-ID: <064e6ed7-d1fd-44bb-b383-6299a71bc504@suse.de>
Date: Fri, 2 May 2025 09:22:05 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: use writeback_iter
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250424082752.1967679-1-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424082752.1967679-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,lst.de:email,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/24/25 10:27, Christoph Hellwig wrote:
> Use writeback_iter instead of the deprecated write_cache_pages wrapper
> in blkdev_writepages.  This removes an indirect call per folio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/fops.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index be9f1dbea9ce..f073ef6d3f27 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -451,12 +451,13 @@ static int blkdev_get_block(struct inode *inode, sector_t iblock,
>   static int blkdev_writepages(struct address_space *mapping,
>   		struct writeback_control *wbc)
>   {
> +	struct folio *folio = NULL;
>   	struct blk_plug plug;
>   	int err;
>   
>   	blk_start_plug(&plug);
> -	err = write_cache_pages(mapping, wbc, block_write_full_folio,
> -			blkdev_get_block);
> +	while ((folio = writeback_iter(mapping, wbc, folio, &err)))
> +		err = block_write_full_folio(folio, wbc, blkdev_get_block);
>   	blk_finish_plug(&plug);
>   
>   	return err;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
