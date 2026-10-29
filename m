Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258705;
	b=XNu2ec62v+VRAwNvFmOhsFjXcXN5Pa0Nr38rwrWjaR6Y57UvR9KPYOHm90R+aKSCIT4t
	 KtP1mJB0TTGgdAVRz871Jdtn9aLPfbPqcyeIJe1t62nXPnkrDB5gW8ylPVKQeWgg2JaaG
	 Br0AW1rQhtRyj8M0/+uvC303pgL/yXF2/lYP0+EUa30ciMPcdE102J773LvBV9/Yhgxer
	 Z+jrdYPW1kkWrxHlcfOV9wqQhPhU/vFrW08ANl9/VkbaYeoh0lOIkXQ0ySAzFp7xvCQmG
	 XsDwcmYy2Ei/3AJbSYCRDMjreJ1X5sHnILHQ9+fXtXgP52Qp+iIqofuaHhZrY8LUzTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258705;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=N/FVVr6MiGh14kRryo07c9vZHP0Y55/kORPZrkLccis=;
	b=W3K5OdQZEXzuP58JY0BmQGBl+Vz3hq9xy/pcnlGaMV80Ldip8cLdVT6Lg5Qxfpv/AyNB
	 PvOM/d7HW55tMhhr+uhK2QgrTjEVKyI+puOWfJcpjyPRP8K5nS1oCa6kEXtkq3hgYztp5
	 REfnAgv5rutHMdq0nIe6Ud5TlUA/UrIkDSfqa1rv5tWTvG924pV8+zX/SlvFkt+MrWy5O
	 TVkmOq2Csy1ObMq+gf0GscKntf4uTU0fGsHir0Ou90OnUZEXsujrwpLmwFQpdDBsckO/K
	 fBHwHZwwf8Mub0gg6i9Kg/4APBF/zx5e1oRSaOennYJZYui17yzyA2A9FasRTA+gLWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T+On5HLl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ThtBxnex;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BlKCqUyh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HCw0U4XJ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EEC606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 07:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7EEC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T+On5HLl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ThtBxnex;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BlKCqUyh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HCw0U4XJ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E46DC1F800;
	Thu, 29 Oct 2026 07:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793258703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/FVVr6MiGh14kRryo07c9vZHP0Y55/kORPZrkLccis=;
	b=T+On5HLlPlQqqj81vxxCmgLl6x4QEtrb67poRmpjmNlcB7nbonsRw68msucBSDQbJNZ0Tc
	QBSxKeVqe/sXi/9H2mdgZbwzOs4agFxFOldrBfjtCdD4a4SP+yUnPkaBLBYVk6qkgXWSoS
	egG7E2TsCbTzfpeffq46bzAeCTp2EPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793258703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/FVVr6MiGh14kRryo07c9vZHP0Y55/kORPZrkLccis=;
	b=ThtBxnexjUzbWu1VTk0821Ne8qMdDqfIzZC9rmFlvmRRuOMkwX6ZDgvjtYrVBAVyJE9486
	PPBiEdgROEffMBBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793258702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/FVVr6MiGh14kRryo07c9vZHP0Y55/kORPZrkLccis=;
	b=BlKCqUyh9CSfUQpousEEwjBKVlKLIeNuAsfbMHcVAZBr4aMtsSk1SSJHCDeGlOyY27ym6v
	Act2RTZbpxAolWxU4UhXMySHNCP9ijdOtwvWAwg1Cg/mcb4I9c4f50GayEDYVcyqck3HBI
	H5NqacoyzM2tetCzfWYTD49I0mIRpO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793258702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/FVVr6MiGh14kRryo07c9vZHP0Y55/kORPZrkLccis=;
	b=HCw0U4XJjxA4MlYao2XlRS8xoXvD5Wc5qwMfDjwdPU8lIXW4mquvqMVz1c7V49e46YIiqH
	ngXPL+RkZQm5uuDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B246613419;
	Thu, 29 Oct 2026 07:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id epAyIs704mqrAgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 07:25:02 +0000
Message-ID: <5ed1bcc3-b586-4ec7-b8fe-beb4765fa5d8@suse.de>
Date: Thu, 29 Oct 2026 08:24:54 +0100
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
Subject: Re: [PATCH 43/98] blk-mq: free the bitmaps of tags in the SRCU
 callback
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-44-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-44-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.28 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-0.99)[-0.995];
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,kernel.dk:email,toxicpanda.com:email,suse.de:email]
X-Spam-Score: -13.28

On 10/28/26 5:41 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit ad0d05dbddc1 keeps struct blk_mq_tags and the requests until the
> iterators under tags_srcu are gone, but the two bitmaps they walk are
> still freed right away. When the number of hardware queues shrinks,
> blk_mq_tagset_busy_iter() may be about to walk tags that
> __blk_mq_update_nr_hw_queues() frees. sbitmap_free() clears the map
> pointer, so that's a NULL dereference or a use-after-free, depending on
> the timing.
> 
> Free the bitmaps with the rest in the callback.
> 
> Fixes: ad0d05dbddc1 ("blk-mq: Defer freeing of tags page_list to SRCU callback")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq-tag.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index aaea2e2c2f23..e3edf18697af 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -623,17 +623,17 @@ static void blk_mq_free_tags_callback(struct rcu_head *head)
>   		kmemleak_free(page_address(page));
>   		__free_pages(page, page->private);
>   	}
> +	/* An iterator may walk the bitmaps for as long as it may see the tags */
> +	sbitmap_queue_free(&tags->bitmap_tags);
> +	sbitmap_queue_free(&tags->breserved_tags);
>   	kfree(tags);
>   }
>   
>   void blk_mq_free_tags(struct blk_mq_tags *tags)
>   {
> -	sbitmap_queue_free(&tags->bitmap_tags);
> -	sbitmap_queue_free(&tags->breserved_tags);
> -
>   	/* if tags pages is not allocated yet, free tags directly */
>   	if (list_empty(&tags->page_list)) {
> -		kfree(tags);
> +		blk_mq_free_tags_callback(&tags->rcu_head);
>   		return;
>   	}
>   
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
