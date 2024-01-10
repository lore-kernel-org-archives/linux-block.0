Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C9374FD
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CyNiF5wQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r5d+GxkV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LP7LwHGC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EfQLyTb7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A93331F8A8;
	Wed, 10 Jan 2024 09:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704879535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ur2z0MeU1ffaM16aONAdKJTxSCGcKSLsanPv1MPPnXU=;
	b=CyNiF5wQhaBrb2cygLUBl3qi6EuJcnr5Ouxuqoab9Xq0cTkp3U5PKt6Z0gd+vf7muUDDZm
	W+PvR5+BMp5sEyjBKECIS5Mhzl6PV1P8Y56ToH6W2yDEBdy6m+UUnhkHwDMfs53cryVITQ
	uiaBLePm/0oLgnNMU0LGoXRQDus9knI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704879535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ur2z0MeU1ffaM16aONAdKJTxSCGcKSLsanPv1MPPnXU=;
	b=r5d+GxkVPlsputHHw/E9UfoZFxFqscgMQe9aTUzWld1BpTfqYT81wG24e07bMqGlf/sT6p
	vUQarDObhiZv2KDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704879533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ur2z0MeU1ffaM16aONAdKJTxSCGcKSLsanPv1MPPnXU=;
	b=LP7LwHGC95MxT9J+/dY8sIkDLSw0UdMsYOiMSITcpWA8wrBEtCB9t2DcA5KIc0s0rtq0IC
	BajXSmp2ejXXNH957M6eOXcrMZXz3uQpzKVg6OAxI2SGWDC9B/G6kuOe5hBKCFfAxzmBf4
	JT+DRACHsFNImRU4PObtFVdM4kEncp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704879533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ur2z0MeU1ffaM16aONAdKJTxSCGcKSLsanPv1MPPnXU=;
	b=EfQLyTb7JfXuykHiSonA8XtqclnDmfHZbZfS9+jiKDrFdaG52pxWWuPWGEn9K6CZZ/K6K6
	KFlwKLanET5yyQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F81713CB3;
	Wed, 10 Jan 2024 09:38:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DvxtIq1lnmWKIgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Jan 2024 09:38:53 +0000
Message-ID: <7dff3f7c-f3d8-4501-b183-6de45eb64e7e@suse.de>
Date: Wed, 10 Jan 2024 10:38:45 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: fix partial zone append completion handling in
 req_bio_endio()
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20240110092942.442334-1-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240110092942.442334-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LP7LwHGC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EfQLyTb7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,wdc.com:email,lst.de:email,vger.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: 0.00
X-Rspamd-Queue-Id: A93331F8A8
X-Spam-Flag: NO

On 1/10/24 10:29, Damien Le Moal wrote:
> Partial completions of zone append request is not allowed but if a zone
> append completion indicates a number of completed bytes different from
> the original BIO size, only the BIO status is set to error. This leads
> to bio_advance() not setting the BIO size to 0 and thus to not call
> bio_endio() at the end of req_bio_endio().
> 
> Make sure a partially completed zone append is failed and completed
> immediately by forcing the completed number of bytes (nbytes) to be
> equal to the BIO size, thus ensuring that bio_endio() is called.
> 
> Fixes: 297db731847e ("block: fix req_bio_endio append error handling")
> Cc: stable@kernel.vger.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes from v1:
>   - Fixed typo in commit message
>   - Added review tags
> 
>   block/blk-mq.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c11c97afa0bc..cd59b172c8fc 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -772,11 +772,16 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
>   		/*
>   		 * Partial zone append completions cannot be supported as the
>   		 * BIO fragments may end up not being written sequentially.
> +		 * For such case, force the completed nbytes to be equal to
> +		 * the BIO size so that bio_advance() sets the BIO remaining
> +		 * size to 0 and we end up calling bio_endio() before returning.
>   		 */
> -		if (bio->bi_iter.bi_size != nbytes)
> +		if (bio->bi_iter.bi_size != nbytes) {
>   			bio->bi_status = BLK_STS_IOERR;
> -		else
> +			nbytes = bio->bi_iter.bi_size;
> +		} else {
>   			bio->bi_iter.bi_sector = rq->__sector;
> +		}
>   	}
>   
>   	bio_advance(bio, nbytes);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

