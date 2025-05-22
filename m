Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADBF23BF91
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921760; cv=none; b=QMp1wkT6acrVDvudCmDh9ivGb2t+ZlqBqsGmtTflUZDL0uY+Q3OWsv3sctWMi8SoPCvlSHsCKnJ3eOMFWSC1RgghUIjWWeCCD9C/Hu8/1mvGoVnC6nAGhu0Lhdt0V2nkafbrTtOQTdC4M5oFs2RmvGgdiw/KbIuiaKFhXQ7opOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921760; c=relaxed/simple;
	bh=lz0d92Zl3w6saQRcWP+ViMr/rParf+M9qlt/N64idqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCAaYDaqe3V9fAtlVehXRmQGsrcTreH20Y0TZKG10TL7/zjzUmbon+wpz4K0i2SwZq2zIYjmPtl3VQNZzwRZyXDJjEoHHNhIfTrya82V/T69is+CxFs3Bm+2/rREi5UdJ8sus9OJ/YFoEImXdU8n9cazNSNgawo5NdH8wg3JfKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ekjUXkK3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rm7SuQVp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=El2Eav0w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wRz5VrOL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ekjUXkK3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rm7SuQVp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="El2Eav0w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wRz5VrOL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B3352128E;
	Thu, 22 May 2025 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747921756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kG67W+efPQ/Q4IYEeKFGbx/HNEOvITIVECtGCn0Na9I=;
	b=ekjUXkK3lTDzK/4r5TZeVXwg4BjJTpWS67T2TM6Eff6InIIK1J8hsoXzA2UetbG3xnX6z0
	4Q9Nj+muzLaDiyx4oEeOl9fTXPQ3qhuYSecs7FLW5u9czVJ47vVqDm5/jo8B6+Zw6SB0iB
	0d5/1gIjRVtioWjDT0apw/PD2knrh1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747921756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kG67W+efPQ/Q4IYEeKFGbx/HNEOvITIVECtGCn0Na9I=;
	b=rm7SuQVphqQQP1B7sHOuAwxA5HAZFYoVDipx7g6PO3GHtqH7JrBMXZ/fvRgV+e+2N1aZf/
	HguGQ1rBj/upL5Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=El2Eav0w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wRz5VrOL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747921755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kG67W+efPQ/Q4IYEeKFGbx/HNEOvITIVECtGCn0Na9I=;
	b=El2Eav0w/7WyiorK3Xw3gKIuvG5kRkg9DPeqxKLQJ9VHxXYOxRqGO+N8VqSz+ZhC/gKczM
	O9ubrha79Q35EHVCEyfeITYRoQQDbl0YOK4ZSthCIsEw6dXPoZIItYkcgwctnCVWVIDJtc
	Ae0onT+QEjVxP5hCU3PvgGz7gj5IUNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747921755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kG67W+efPQ/Q4IYEeKFGbx/HNEOvITIVECtGCn0Na9I=;
	b=wRz5VrOL6EwHP96OstCfZtimSvBLY/uVk1cCITsfeuoVgw003hqXgoU01U5EoguU9hJYij
	jsHEYTZXi+TnWjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C0E9137B8;
	Thu, 22 May 2025 13:49:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AwVrEVsrL2jeCQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 22 May 2025 13:49:15 +0000
Message-ID: <57400edb-4c47-4d80-8861-597f9fd5d276@suse.de>
Date: Thu, 22 May 2025 15:49:15 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] block: add support for copy offload
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250521223107.709131-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 6B3352128E
X-Spam-Level: 
X-Spam-Flag: NO

On 5/22/25 00:31, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Various storage protocols can support offloading block data copies.
> Enhance the block layer to know about the device's copying capabilities,
> introduce the new REQ_OP_COPY operation, and provide the infrastructure
> to iterate, split, and merge these kinds of requests.
> 
> A copy command must provide the device with a list of source LBAs and
> their lengths, and a destination LBA. The 'struct bio' type doesn't
> readily have a way to describe such a thing. But a copy request doesn't
> use host memory for data, so the bio's bio_vec is unused space. This
> patch adds a new purpose to the bio_vec where it can provide a vector of
> sectors instead of memory pages.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/bio.c               | 25 ++++++++++++++
>   block/blk-core.c          |  4 +++
>   block/blk-lib.c           | 47 ++++++++++++++++++++++-----
>   block/blk-merge.c         | 28 +++++++++++++++-
>   block/blk-sysfs.c         |  9 ++++++
>   block/blk.h               | 17 +++++++++-
>   include/linux/bio.h       | 20 ++++++++++++
>   include/linux/blk-mq.h    |  5 +++
>   include/linux/blk_types.h |  2 ++
>   include/linux/blkdev.h    | 14 ++++++++
>   include/linux/bvec.h      | 68 +++++++++++++++++++++++++++++++++++++--
>   11 files changed, 226 insertions(+), 13 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 3c0a558c90f52..9c73a895c987b 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1156,6 +1156,31 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
>   	bio_set_flag(bio, BIO_CLONED);
>   }
>   
> +static int bvec_try_merge_copy_src(struct bio *bio, struct bio_vec *src)
> +{
> +	struct bio_vec *bv;
> +
> +	if (!bio->bi_vcnt)
> +		return false;
> +
> +	bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> +	if (bv->bv_sector + src->bv_sectors != src->bv_sector)
> +		return false;
> +
> +	bv->bv_sectors += src->bv_sectors;
> +	return true;
> +}
> +
> +int bio_add_copy_src(struct bio *bio, struct bio_vec *src)
> +{
> +	if (bvec_try_merge_copy_src(bio, src))
> +		return 0;
> +	if (bio->bi_vcnt >= bio->bi_max_vecs)
> +		return -EINVAL;
> +	bio->bi_io_vec[bio->bi_vcnt++] = *src;
> +	return 0;
> +}
> +
>   static unsigned int get_contig_folio_len(unsigned int *num_pages,
>   					 struct page **pages, unsigned int i,
>   					 struct folio *folio, size_t left,
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b862c66018f25..cb3d9879e2d65 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -837,6 +837,10 @@ void submit_bio_noacct(struct bio *bio)
>   		if (!bdev_max_discard_sectors(bdev))
>   			goto not_supported;
>   		break;
> +	case REQ_OP_COPY:
> +		if (!bdev_copy_sectors(bdev))
> +			goto not_supported;
> +		break;
>   	case REQ_OP_SECURE_ERASE:
>   		if (!bdev_max_secure_erase_sectors(bdev))
>   			goto not_supported;
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index a819ded0ed3a9..a538acbaa2cd7 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -369,14 +369,7 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
>   }
>   EXPORT_SYMBOL(blkdev_issue_secure_erase);
>   
> -/**
> - * blkdev_copy - copy source sectors to a destination on the same block device
> - * @dst_sector:	start sector of the destination to copy to
> - * @src_sector:	start sector of the source to copy from
> - * @nr_sects:	number of sectors to copy
> - * @gfp:	allocation flags to use
> - */
> -int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
> +static int __blkdev_copy(struct block_device *bdev, sector_t dst_sector,
>   		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
>   {
>   	unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);

That's a bit odd, renaming a just introduced function.
But if you must...

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
