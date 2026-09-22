Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE97B48F003;
	Tue, 22 Sep 2026 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055732; cv=none; b=t3uYr0RQS01MbLB3tWmOZI9P1L3g+R7hySqKxq9Dnno2i//cHuZIe4mBU1uHKBCW4jV4HDo6U5jdLkB6cF9y0kzaaSIGzM6Ab08Zm1O6gSGEhaDAzTUuuDcuNfdYgA0i/GgvcfjIddPUiJaiUwX5y26UtR1v9LXguWSFvKmwo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055732; c=relaxed/simple;
	bh=AzPAOI4NFJfyE/Ha1mBUQDgMUvZWqGeT2QiVBMIYlno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHqiSfaTicOqlOT+mlut9/byktFmpmhVKaU79a6uj8m76VWlFidZoB5FuHWyc5YwxZHe2lGiYAFzKE58I+wPGNP/XYRYAkxI0z3cYe9ltlboX/qY7vzrfqB1BFCUKw12O2Q1OptGfsjplS3egysKnhOt9lkrzvj4uW4Vk3zsIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jq/y9R6P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sKg2iIKT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UyUrEqzm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=grBMCrKs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jq/y9R6P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sKg2iIKT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UyUrEqzm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="grBMCrKs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 625A01F390;
	Tue, 22 Sep 2026 05:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790055723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1Et7cOXUcNPBRGMvhwtNBIFCdIkznXtPd7c2ABVCLc=;
	b=jq/y9R6PW7gZ1H9hTn4Yeg48nd9IqiJy7YQJBR4R2fVIYoYiCg+cp6iaSucsFvAxEh6FRr
	/5421Puj0lJAcWf6yYvp25377YHVDiWPE0l8OTCV5b2ILXEybU1T70+p/rG/Ap5Ytbeg0i
	0EDapJIakqhz0WpGXkaOrusxe8T8FA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790055723;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1Et7cOXUcNPBRGMvhwtNBIFCdIkznXtPd7c2ABVCLc=;
	b=sKg2iIKTrnm2RXGwJ4CgsHHmyTYFod/eOdhPkRVpw2DxeyAeltS1yDzfL6uX4TA1bocAmq
	5VC32kchcVkI2NDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UyUrEqzm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=grBMCrKs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790055719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1Et7cOXUcNPBRGMvhwtNBIFCdIkznXtPd7c2ABVCLc=;
	b=UyUrEqzmJ4W3RRSRcfRoVncRoGfgM2SZsavTQKgaHpi+VRnGWsZ5e72JPd6M2Epm/7YUkx
	rZa+d4u46yn8PsHkm17W5EH3iX2RGNaWGEL8RUdj6V0i6nJrLCupwX3GypcPCqAS4Ko3Om
	P1PXPBlS8XGJV5LFKitpqHwFygcJTQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790055719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1Et7cOXUcNPBRGMvhwtNBIFCdIkznXtPd7c2ABVCLc=;
	b=grBMCrKszZ6CLCD/+93t0prKH7inVqyLu36vLX/4gz9rcYuUFzRKw5/L33Y0yDdINR3XPc
	kSf9K4JRxZbi3FCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D906D136D9;
	Tue, 22 Sep 2026 05:41:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /hu1JSYVsmrGbAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Sep 2026 05:41:58 +0000
Message-ID: <94d29ac5-d01a-49c3-8001-96798452ca80@suse.de>
Date: Tue, 22 Sep 2026 07:41:58 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] block: don't fall back to buffered I/O for atomic
 writes
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 John Garry <john.garry@linux.dev>, Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu>
 <20260921-blkdev-fixes-v4-6-e2801f71ede9@columbia.edu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260921-blkdev-fixes-v4-6-e2801f71ede9@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 625A01F390
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[columbia.edu:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,sashiko.dev:url];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On 9/22/26 4:54 AM, Tal Zussman wrote:
> blkdev_direct_write() turns an -EBUSY from page cache invalidation into
> a 0 return, so an IOCB_ATOMIC write is retried in full through
> blkdev_buffered_write(), with no atomicity guarantee.
> 
> Skip the buffered fallback in blkdev_write_iter() for IOCB_ATOMIC, as
> it already does for IOCB_NOWAIT, so the -EBUSY case returns -EAGAIN and
> the caller retries, matching __iomap_dio_rw().
> 
> ext4 has the same fallback and only warns in it. For block devices the
> fallback can be skipped before any I/O is submitted, so fail early
> instead.
> 
> Fixes: caf336f81b3a ("block: Add fops atomic write support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   block/fops.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 90777e8a9a6c..7f23778f6b81 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -766,10 +766,11 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (iocb->ki_flags & IOCB_DIRECT) {
>   		ret = blkdev_direct_write(iocb, from);
>   		if (ret >= 0 && iov_iter_count(from)) {
> -			if (iocb->ki_flags & IOCB_NOWAIT) {
> +			if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_ATOMIC)) {
>   				/*
>   				 * The buffered fallback blocks on i_rwsem and
> -				 * on writeback of the data it copied: return
> +				 * on writeback of the data it copied, and
> +				 * can't provide torn-write protection: return
>   				 * the short direct write instead and let the
>   				 * caller retry.
>   				 */
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
