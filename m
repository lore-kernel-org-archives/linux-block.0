Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D301527AE
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632338; cv=none; b=JZsNeCsF6iL2Gp8SJIRQUhWQyUgMf62RDMA2m52rSN4fU1FwM9oSAOF8aNQWQVlG4F6US3qKlpUbAPuqBSszeA7x0ByB2V5JJouJFirMGJC2Ii//saWjwLGAA/U1jJAywwmHso4SD5XhVNq3UUkERp4C4Wjh0fBCSpEUMx1UeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632338; c=relaxed/simple;
	bh=9gpF1ZeoIB+BLVk+0MjpqZda1gRKi8C0YBM1991aFCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNVmIJ/GSS2GJzcjeEP88D8f48gpBQF/2Pkic1F6uSrFArd6yQ1bhg701SqxX6bcH8UOqsGW5da/W4HKRCLlJ989JsJ5xdCrVMLsT0Hh54RE7CpzlbmZ6flqp39AY5RJfw5osXB8mi5peYRx1AFqGnvbz7wQWz05uQqeBbn7fbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uy/zHLG2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SuhAbAfh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uy/zHLG2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SuhAbAfh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uy/zHLG2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SuhAbAfh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Uy/zHLG2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SuhAbAfh"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4E9D1FC06;
	Thu,  2 May 2024 06:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714632334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQcMKXJVOG43VIEs3AdXElWrHRr8HzHo02RLuW651HI=;
	b=Uy/zHLG2qINwM71ZkxpdSs5rB3wliqrVvc1KK+lGFygIJ6bD6K9LFuBPeFT3HQE6qlM9BU
	nHQL2ToiCdtY9T7bqRqtFIfysKdFCIMxumLkMGiWJg+FB5mnPDt6ZRhe+yqvvCwq3yBltl
	6eUE1JoyKx9dPRiqlJ2Z1BtaJDMzu4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714632334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQcMKXJVOG43VIEs3AdXElWrHRr8HzHo02RLuW651HI=;
	b=SuhAbAfhJLl0zdsTJNbNVwymkuA2Mf2XzVBlqrzX9VgWe6WHuzdLU4l1scgPX3gzxIIFLP
	lV4lhnelLeU+4aCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Uy/zHLG2";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SuhAbAfh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714632334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQcMKXJVOG43VIEs3AdXElWrHRr8HzHo02RLuW651HI=;
	b=Uy/zHLG2qINwM71ZkxpdSs5rB3wliqrVvc1KK+lGFygIJ6bD6K9LFuBPeFT3HQE6qlM9BU
	nHQL2ToiCdtY9T7bqRqtFIfysKdFCIMxumLkMGiWJg+FB5mnPDt6ZRhe+yqvvCwq3yBltl
	6eUE1JoyKx9dPRiqlJ2Z1BtaJDMzu4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714632334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQcMKXJVOG43VIEs3AdXElWrHRr8HzHo02RLuW651HI=;
	b=SuhAbAfhJLl0zdsTJNbNVwymkuA2Mf2XzVBlqrzX9VgWe6WHuzdLU4l1scgPX3gzxIIFLP
	lV4lhnelLeU+4aCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A4D81386E;
	Thu,  2 May 2024 06:45:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P8XrC442M2ZuQAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 May 2024 06:45:34 +0000
Message-ID: <317ce09b-5fec-4ed2-b32c-d098767956d0@suse.de>
Date: Thu, 2 May 2024 08:45:33 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block : add larger order folio size instead of pages
Content-Language: en-US
To: Kundan Kumar <kundan.kumar@samsung.com>, axboe@kernel.dk, hch@lst.de,
 willy@infradead.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
 anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
 gost.dev@samsung.com
References: <CGME20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff@epcas5p1.samsung.com>
 <20240430175014.8276-1-kundan.kumar@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240430175014.8276-1-kundan.kumar@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A4E9D1FC06
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]

On 4/30/24 19:50, Kundan Kumar wrote:
> When mTHP is enabled, IO can contain larger folios instead of pages.
> In such cases add a larger size to the bio instead of looping through
> pages. This reduces the overhead of iterating through pages for larger
> block sizes. perf diff before and after this change:
> 
> Perf diff for write I/O with 128K block size:
> 	1.26%     -1.04%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
> 	1.74%             [kernel.kallsyms]  [k] bvec_try_merge_page
> Perf diff for read I/O with 128K block size:
> 	4.40%     -3.63%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
> 	5.60%             [kernel.kallsyms]  [k] bvec_try_merge_page
> 
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20240419091721.1790-1-kundan.kumar@samsung.com/
> - Changed functions bio_iov_add_page() and bio_iov_add_zone_append_page() to
>    accept a folio
> - Removed branching and now calculate folio_offset and len in same fashion for
>    both 0 order and larger folios
> - Added change in NVMe driver to use nvme_setup_prp_simple() by ignoring
>    multiples of NVME_CTRL_PAGE_SIZE in offset
> - Added change to unpin_user_pages which were added as folios. Also stopped
>    the unpin of pages one by one from __bio_release_pages()(Suggested by
>    Keith)
> 
>   block/bio.c             | 48 +++++++++++++++++++++++++----------------
>   drivers/nvme/host/pci.c |  3 ++-
>   2 files changed, 31 insertions(+), 20 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 38baedb39c6f..0ec453ad15b3 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1155,7 +1155,6 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>   
>   	bio_for_each_folio_all(fi, bio) {
>   		struct page *page;
> -		size_t nr_pages;
>   
>   		if (mark_dirty) {
>   			folio_lock(fi.folio);
> @@ -1163,11 +1162,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>   			folio_unlock(fi.folio);
>   		}
>   		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
> -		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
> -			   fi.offset / PAGE_SIZE + 1;
> -		do {
> -			bio_release_page(bio, page++);
> -		} while (--nr_pages != 0);
> +		bio_release_page(bio, page);

Errm. I guess you need to call 'folio_put()' here, otherwise the page 
reference counting will be messed up.

>   	}
>   }
>   EXPORT_SYMBOL_GPL(__bio_release_pages);
> @@ -1192,7 +1187,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
>   	bio_set_flag(bio, BIO_CLONED);
>   }
>   
> -static int bio_iov_add_page(struct bio *bio, struct page *page,
> +static int bio_iov_add_folio(struct bio *bio, struct folio *folio,
>   		unsigned int len, unsigned int offset)
>   {
>   	bool same_page = false;
> @@ -1202,27 +1197,26 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
>   
>   	if (bio->bi_vcnt > 0 &&
>   	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
> -				page, len, offset, &same_page)) {
> +				&folio->page, len, offset, &same_page)) {
>   		bio->bi_iter.bi_size += len;
>   		if (same_page)
> -			bio_release_page(bio, page);
> +			bio_release_page(bio, &folio->page);
>   		return 0;
>   	}
> -	__bio_add_page(bio, page, len, offset);
> +	bio_add_folio_nofail(bio, folio, len, offset);
>   	return 0;
>   }

That is not a valid conversion.
bvec_try_to_merge_pages() will try to merge a page with an existing
bvec. If the logic is switch to folios you would need to iterate over
all pages in a folio, and call bvec_try_to_merge_pages() for each page
in the folio.
Or convert / add a function 'bvec_try_to_merge_folio()'.
But with the above patch it will only ever try to merge the first page
in the folio.

>   
> -static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
> +static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
>   		unsigned int len, unsigned int offset)
>   {
>   	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>   	bool same_page = false;
> -
> -	if (bio_add_hw_page(q, bio, page, len, offset,
> +	if (bio_add_hw_page(q, bio, &folio->page, len, offset,
>   			queue_max_zone_append_sectors(q), &same_page) != len)

Wouldn't this just try to add the first page in a folio?

>   		return -EINVAL;
>   	if (same_page)
> -		bio_release_page(bio, page);
> +		bio_release_page(bio, &folio->page);
>   	return 0;
>   }
>   
> @@ -1247,8 +1241,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   	struct page **pages = (struct page **)bv;
>   	ssize_t size, left;
>   	unsigned len, i = 0;
> -	size_t offset;
> +	size_t offset, folio_offset, size_folio;
>   	int ret = 0;
> +	int num_pages;
> +	struct folio *folio;
>   
>   	/*
>   	 * Move page array up in the allocated memory for the bio vecs as far as
> @@ -1289,16 +1285,30 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>   
>   	for (left = size, i = 0; left > 0; left -= len, i++) {
>   		struct page *page = pages[i];
> +		folio = page_folio(page);
> +
> +		/* See the offset in folio and the size */
> +		folio_offset = (folio_page_idx(folio, page)
> +				<< PAGE_SHIFT) + offset;
> +		size_folio = folio_size(folio);
> +
> +		/* Calculate the length of folio to be added */
> +		len = min_t(size_t, (size_folio - folio_offset), left);
> +
> +		num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
>   
> -		len = min_t(size_t, PAGE_SIZE - offset, left);
>   		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> -			ret = bio_iov_add_zone_append_page(bio, page, len,
> -					offset);
> +			ret = bio_iov_add_zone_append_folio(bio, folio, len,
> +					folio_offset);
>   			if (ret)
>   				break;
>   		} else
> -			bio_iov_add_page(bio, page, len, offset);
> +			bio_iov_add_folio(bio, folio, len, folio_offset);
>   
> +		/* Skip the pages which got added */
> +		if (bio_flagged(bio, BIO_PAGE_PINNED) && num_pages > 1)
> +			unpin_user_pages(pages + i, num_pages - 1);
> +		i = i + (num_pages - 1);
>   		offset = 0;
>   	}
>   
I would rather use folio as an argument here ...

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8e0bb9692685..7c07b0582cae 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -778,7 +778,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   		struct bio_vec bv = req_bvec(req);
>   
>   		if (!is_pci_p2pdma_page(bv.bv_page)) {
> -			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
> +			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1))
> +				+ bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
>   				return nvme_setup_prp_simple(dev, req,
>   							     &cmnd->rw, &bv);
>   

In general I'm in favour of moving the block layer over to folios, but 
then we should do it by adding a folio-based version of the functions,
and the gradually convert the callers over to those functions.

Trying to slide it in via folio->page or page_folio() things is not
the way to do it as they are not equivalent transformations.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

