Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594272;
	b=NhhUg1bHQvm2GIfLPWRAcg8WAkgCqFdBZwUXgaKGEXcwQXt8D8YmZ79KkhNZYy3LO7jk
	 cN46cKuDTr7r/dffEdAd50VlOgurlWkxtInI/Z3/lVkYVjTECdMEhdp1yGe/hGko0GndZ
	 TrW0V/YLYLXj37cthp8vLH2QaX1wAbfja3d1CIAjOxa+FJuAUCUnMDMOKgNF0ERq1LTrf
	 WVjQrodW77vhZ+xpTaEJVu8lk9rxKnRwtst5LIUwgu3iJ7pSr7eQ56fKD1uhgEaw5jsJV
	 i6VvurTWbYY9UlIN5O76H5L+7Raa8lSruPTxLKrJ6GnaNpQSdRuAZZMG/QqtCVzTR6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594272;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=vaKq5fGXOIrrDQX1oaRN9vtHHZA9dCiuDgGNV9bO81o=;
	b=5P5UE6adBBGqfO3HziX9ElqgAdwjxBVkYoG6RonIMsvjcm7YqY9r+B+4wrvM84MgGXAM
	 egHMUbkOKLRC+JoaLmWL1vRRLOnAmRi+E1ewIgLbLOmyGmJ56zJ/jcW7rBYNuaONAo72E
	 ztntlTLJGoXSTtuoPhSD/zK9tFrdTvAVp138Vvu4SNjYICryvx7vZdIt8PHO319iwltZG
	 aH4VinRr+dcP9wEExe/+sCVusZGkLlub0bQ0BKF75xkGk8m8S4cEUZcbbK0chtW5M3PaL
	 PG67XF7JKApGI3WBVoMLAlkTOYoL/E0LB4Fq96wTSrstq/JoTm515bE+20UzxCeEnkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eOMDSvrr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rU2SmRPx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jlwpXr3+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sS0U0Rpu;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04915606A31E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 08:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04915606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eOMDSvrr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rU2SmRPx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jlwpXr3+;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sS0U0Rpu
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E025A2233F;
	Wed, 25 Nov 2026 08:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795594270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaKq5fGXOIrrDQX1oaRN9vtHHZA9dCiuDgGNV9bO81o=;
	b=eOMDSvrrEHM9UXTqVfuUJMk1aaqYWqrfzLkDIOu42v085/PkYnESN7fzeVpoaAG3BWofS8
	ONZMgHR88vujKtcoG3z7JfZ2sU/lmlIdlKOYrc9bGz8l4ZmoDyxnsgKE1nbg+FYn6tVATa
	tXTrC9L6BtMmbyp6ahmY1gU2x3g88jQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795594270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaKq5fGXOIrrDQX1oaRN9vtHHZA9dCiuDgGNV9bO81o=;
	b=rU2SmRPxpXFDKOtk6h8gVXbtz/UUIWugMDPgp/bcZyeqMwvXRRrNKxqDd5y6vFiu3T91pM
	6dLNnZX4JGi67kBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795594269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaKq5fGXOIrrDQX1oaRN9vtHHZA9dCiuDgGNV9bO81o=;
	b=jlwpXr3+OoodkR0/m8aELTAjxz2R3Gyj0hTPsHr/OHw+6PvUo8AMsoSaHRakh1jeI6jEo8
	mGbdSDOvHABfXzRTPYnHpd1wPSJGsQ9cq/vSZ7rWFjTNA/SaBB7vutgAUTGpliRHrAdbAW
	fznuP+NGEe0Q7EJs5xSrtwrwdqlU4kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795594269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaKq5fGXOIrrDQX1oaRN9vtHHZA9dCiuDgGNV9bO81o=;
	b=sS0U0RpuzgyLb1ZpOiMaQW6psaV3G5o6JouBLgPXCuQblcIvECSZsTx+HmxpjOExubmQ7u
	4tyyY0B9jmVRKVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97A84134CA;
	Wed, 25 Nov 2026 08:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZZ01Gx2YBmtfVwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 25 Nov 2026 08:11:09 +0000
Message-ID: <562f7e29-5613-41fd-be2b-960aaa8b10ec@suse.de>
Date: Wed, 25 Nov 2026 09:11:01 +0100
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
Subject: Re: [PATCH v3] blk-mq: scope the no-sleep requirement in
 blk_mq_alloc_request_hctx()
To: hmi.jeon@samsung.com, "hch@infradead.org" <hch@infradead.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: =?UTF-8?B?7KCV7J6s7JuF?= <jaew.jung@samsung.com>
References: <CGME20261125073914epcms2p653a329ef9213d5a9e2f74ec5401a3018@epcms2p6>
 <20261125073914epcms2p653a329ef9213d5a9e2f74ec5401a3018@epcms2p6>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261125073914epcms2p653a329ef9213d5a9e2f74ec5401a3018@epcms2p6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 11/25/26 8:39 AM, 전민식 wrote:
> BLK_MQ_REQ_NOWAIT is mandatory in blk_mq_alloc_request_hctx() only to
> keep blk_mq_get_tag() from re-picking data->hctx after io_schedule().
> But the same flags value is passed on to blk_queue_enter(), so a caller
> also takes -EAGAIN for a transient freeze that has no bearing on hctx
> selection. There is no way to ask for the hctx guarantee without also
> opting out of waiting.
> 
> Force BLK_MQ_REQ_NOWAIT on the tag allocation alone, right before
> blk_mq_get_tag(), and let blk_queue_enter() honour the caller's flags.
> nr_hw_queues/queue_hw_ctx and alloc_time_ns move after blk_queue_enter()
> now that it can sleep through such an update.
> 
> Co-authored-by: Jaewoong Jung <jaew.jung@samsung.com>
> Signed-off-by: Minsik Jeon <hmi.jeon@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> Changes since v2:
> - resend only; the v2 mail had the patch headers pasted into the message
>    body. No changes to the code or the commit message.
>   block/blk-mq.c | 40 ++++++++++++++++++++++++++--------------
>   1 file changed, 26 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
