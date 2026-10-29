Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258748;
	b=Jhfv2HouO9eb+ps6X+9mjJ4pdAgK44I17DDiWQ2c9W2gVxbOwDIo7hu9/GSLfET5xH2k
	 MHWrbVmDpRdHWEB/EW9pY5O5vCbieFRK24JCCHiWMZqIxIuH2iFqg1JAalQ2IeBhw+mFE
	 HSFKTzdxiqjzucn/UGdqFMQ6b3BD61RWAnTloleaqa+qjX3FWiL9BOIONvET7kmdEv5rU
	 2+OuxUlLqoN8LjaXh24Dyb/AjH6r2yVUFH9O5Do9drPhaDFZmABTyjrZBhhO5YEeWba5J
	 fv2Mfwz2Zl77/CDai/7KLVDFxuiGLIznNPa4KK9sa9KYRB7Wzq6wQGmOecQwEHP8OQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258748;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=L34PDgUu4VdI+kYvsJPg20vHoQfp3T4Tx62Vh52Av0A=;
	b=XA2J0jX5b2sdRwbGzSn2UplsPyGJKA2dpKR/0f7JCKL5CYPpDrmAI7/nyEWaHQbwsXOE
	 jUa9ojPvOXn5cV5i/9xY5raiBzjbpmVLWJNxPvprQrQ1PJU5LgiSLH9fXhd5YRBE5KPyr
	 JmeRncJ9CaykG2PxX6b/Tm5LdiVj0sAuxAfUn/dj8ggKI4f9eHySR/cZFgMxvea/grnJW
	 dTcGC3QFFwgWvby9d4aswsZqvFhafxiHCjSSzuUNdkx2PLW/1t3pOcBeSfUeB+F9uZJDb
	 DXM+HjtWrgHWov6JGxTxwg7fWSXZveHvkhsX7Wq5uLBgwoCwH/d7LQtS640NY/sCY2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=O3WGreq1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4priFpai;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="DXT8x/ri";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U9XNj1mX;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06CC606A320
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 07:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D06CC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=O3WGreq1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4priFpai;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DXT8x/ri;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U9XNj1mX
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF5501F800;
	Thu, 29 Oct 2026 07:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793258746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L34PDgUu4VdI+kYvsJPg20vHoQfp3T4Tx62Vh52Av0A=;
	b=O3WGreq1KbDyINJpJroMuZ/4UkNf4drXsDE2tFW+oYoEzKFQQQDykPu3fnUcg2V8v1bOdx
	oHmRbldpgtk8qzGa5vdUjcGQQEU5aGLQXWTKEMC1aHGLtRBVou084k2NRd5okTkxW5Dea1
	BHaCAZH7d8oOy3/2ASzwMzqcjD4hmJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793258746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L34PDgUu4VdI+kYvsJPg20vHoQfp3T4Tx62Vh52Av0A=;
	b=4priFpaid4j/cX9eaMDnOhPi82oyb/808X0Yyo3jF3oRNF/zteP+8YD2wJG4xEkzAYjulc
	tWUXoShiGbgn1XCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="DXT8x/ri";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U9XNj1mX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793258745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L34PDgUu4VdI+kYvsJPg20vHoQfp3T4Tx62Vh52Av0A=;
	b=DXT8x/ri0wuskcZIdKJ0iUj0LHc0EsSoVt9JKYERduy/bZoXXBB2Z86+JMBM+mpkKsMWkl
	l4JOXOWhsFTH+u9y16sAbjgQfH74vPT6osP/AMB/ot4aRdFiy5uEuE+TnrVilDyEZluOfa
	z9TlVMYyMktI7TnDDMFHHCJ52dm6V7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793258745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L34PDgUu4VdI+kYvsJPg20vHoQfp3T4Tx62Vh52Av0A=;
	b=U9XNj1mXIBSXGFaWfG33BVQ9h7MEsqPrKv4G2cL2FN5HYp14wOQga8k4cVTPPn8RzbedsL
	MvrD6NQGi/c74ZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 852DF13419;
	Thu, 29 Oct 2026 07:25:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E/KqF/n04mqeAwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 07:25:45 +0000
Message-ID: <3503fdf8-c754-4d39-8afe-fc9ea8690da4@suse.de>
Date: Thu, 29 Oct 2026 08:25:37 +0100
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
Subject: Re: [PATCH 45/98] nvmet: don't truncate the length of big discards
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-46-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-46-axboe@kernel.dk>
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
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,kernel.dk:email,toxicpanda.com:email,lst.de:email,suse.de:email,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: CF5501F800

On 10/28/26 5:41 PM, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> nvmet_bdev_execute_discard() shifts the 32-bit nlb of a DSM range into
> sectors before widening it to sector_t, so on a 4k namespace the top
> bits are lost. A 3 TiB range discards 1 TiB, a 2 TiB range discards
> nothing, and both complete with success. The target announces no DMRSL,
> and hosts other than Linux (and nvme dsm passthrough) do send ranges
> that big.
> 
> Widen before the shift.
> 
> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/io-cmd-bdev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index f2d9e8901df4..ed2e2c89e3e9 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -389,7 +389,8 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
>   		if (status)
>   			break;
>   
> -		nr_sects = le32_to_cpu(range.nlb) << (ns->blksize_shift - 9);
> +		nr_sects = (sector_t)le32_to_cpu(range.nlb) <<
> +			   (ns->blksize_shift - 9);
>   		__blkdev_issue_discard(ns->bdev,
>   				nvmet_lba_to_sect(ns, range.slba), nr_sects,
>   				GFP_KERNEL, &bio);

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
