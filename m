Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC81D1BF50
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783241; cv=none; b=QZVFAaRZBc6EVq1Hx/xsCwjM5ctsfMNHxiOoPHr+iD+5+hDcZN1lH7nNYrA5huc6o4yq16qQmNiBEPUXkLdGicGBi8b8TtyVuw6DJiWg+msQzDTbe9e3EqADZ8w2XRxW9Erh8cJsGeV1KtU7YFPNVBYhClyg/TdA8ZjfUu8QbqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783241; c=relaxed/simple;
	bh=7b8Py8fxi1/oN7dKX0xESBrPLmHoobCjCUifft6cQ/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plznCv9ZzG8ekoYM7fWP3fLJJ0n4LGvm4GD4z62nEvsHpY2/iCdy77n91vfeAr1U7TIkfcYeXMG9hG7GvuyZY7CeNWK0JK/0l79HoO3StiPbn56zwqq1WyyekwyZnOaOXcsJKHsWB7QuGmwrhx3AUqrOs3Z4pIHMJrn0yVIALWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TflJlX7C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a1HLfPJ9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eDqIuDd8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eMYCqMk9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TflJlX7C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a1HLfPJ9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eDqIuDd8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eMYCqMk9"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2AC821A5B;
	Wed, 19 Jun 2024 07:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718783238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgWste3bWmwqMIfDouOQ/JwfxbFp/SvetiLqCZMcwsw=;
	b=TflJlX7CUM/mSNxVPpglzCPZrzw2WXYAdmO9oHdoaEWjMLinvGL4dI64AWhYn/Sf8CsrZn
	gOUzkHjAVppnTcOe6mRKxszPk1WO40cYQTqwLoUd+yGZ94Ze7QDycCkr0TG6Fakkyz8w82
	NJQk0ek/7VPx1ZZNePAtEu5d2Qo9a4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718783238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgWste3bWmwqMIfDouOQ/JwfxbFp/SvetiLqCZMcwsw=;
	b=a1HLfPJ9Eg9CqJ/UwLgrgzj+u2ssGoLkw0lYEB0caaP1D2lmwVsIzTaAEoH/7d8m7XQcDr
	uCNd2lRc8BRrCIDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718783237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgWste3bWmwqMIfDouOQ/JwfxbFp/SvetiLqCZMcwsw=;
	b=eDqIuDd8VQOAsLvk7ZpJCHCNL8L9zlbEIFk/yfV8uLxtll7zOHCOmLl6alquUGTYuC7vfy
	OHdtGyFrAXBZjghhXGBURoVK37z8a06ULn9a4V0IJP5LXKnQVAZxY9h/M/A0hYmLPngUYE
	ZdPwHYhsPPDgd6oezhmA9391oXg/bKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718783237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgWste3bWmwqMIfDouOQ/JwfxbFp/SvetiLqCZMcwsw=;
	b=eMYCqMk9GMfBWs0xCiX9R+vLyWwnzSxcp/hsi6zvdk9kTF8ATSHwS/N28+dNFsncZRgJFC
	w3ccwIH8KHSzZ+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E9E613AC3;
	Wed, 19 Jun 2024 07:47:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WAQEFQWNcmYtDwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 19 Jun 2024 07:47:17 +0000
Message-ID: <c29524a5-f3c7-4236-968c-58b5f3004b66@suse.de>
Date: Wed, 19 Jun 2024 09:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] block: add folio awareness instead of looping
 through pages
Content-Language: en-US
To: Kundan Kumar <kundan.kumar@samsung.com>, axboe@kernel.dk, hch@lst.de,
 willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
 anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
 gost.dev@samsung.com
References: <20240619023420.34527-1-kundan.kumar@samsung.com>
 <CGME20240619024150epcas5p267bd3cbd24061e723a7b632746de92d6@epcas5p2.samsung.com>
 <20240619023420.34527-3-kundan.kumar@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240619023420.34527-3-kundan.kumar@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 

On 6/19/24 04:34, Kundan Kumar wrote:
> Add a bigger size from folio to bio and skip merge processing for pages.
> 
> Fetch the offset of page within a folio. Depending on the size of folio
> and folio_offset, fetch a larger length. This length may consist of
> multiple contiguous pages if folio is multiorder.
> 
> Using the length calculate number of pages which will be added to bio and
> increment the loop counter to skip those pages.
> 
> Using a helper function check if pages are contiguous and belong to same
> folio, this is done as a COW may happen and change contiguous mapping of
> pages of folio.
> 
> This technique helps to avoid overhead of merging pages which belong to
> same large order folio.
> 
> Also folio-lize the functions bio_iov_add_page() and
> bio_iov_add_zone_append_page()
> 
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> ---
>   block/bio.c | 72 ++++++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 58 insertions(+), 14 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index c8914febb16e..3e75b5b0eb6e 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1224,7 +1224,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
>          bio_set_flag(bio, BIO_CLONED);
>   }
> 
> -static int bio_iov_add_page(struct bio *bio, struct page *page,
> +static int bio_iov_add_folio(struct bio *bio, struct folio *folio,
>                  unsigned int len, unsigned int offset)
>   {
>          bool same_page = false;
> @@ -1234,30 +1234,60 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
> 
>          if (bio->bi_vcnt > 0 &&
>              bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
> -                               page, len, offset, &same_page)) {
> +                               folio_page(folio, 0), len, offset,
> +                               &same_page)) {
>                  bio->bi_iter.bi_size += len;
>                  if (same_page)
> -                       bio_release_page(bio, page);
> +                       bio_release_page(bio, folio_page(folio, 0));
>                  return 0;
>          }
> -       __bio_add_page(bio, page, len, offset);
> +       bio_add_folio_nofail(bio, folio, len, offset);
>          return 0;
>   }
> 
> -static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
> +static int bio_iov_add_zone_append_folio(struct bio *bio, struct folio *folio,
>                  unsigned int len, unsigned int offset)
>   {
>          struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>          bool same_page = false;
> 
> -       if (bio_add_hw_page(q, bio, page, len, offset,
> +       if (bio_add_hw_folio(q, bio, folio, len, offset,
>                          queue_max_zone_append_sectors(q), &same_page) != len)
>                  return -EINVAL;
>          if (same_page)
> -               bio_release_page(bio, page);
> +               bio_release_page(bio, folio_page(folio, 0));
>          return 0;
>   }
> 
> +static unsigned int get_contig_folio_len(int *num_pages, struct page **pages,
> +                                        int i, struct folio *folio,
> +                                        ssize_t left, size_t offset)
> +{
> +       ssize_t bytes = left;
> +       size_t contig_sz = min_t(size_t,  PAGE_SIZE - offset, bytes);
> +       unsigned int j;
> +
> +       /*
> +        * We might COW a single page in the middle of
> +        * a large folio, so we have to check that all
> +        * pages belong to the same folio.
> +        */
> +       bytes -= contig_sz;
> +       for (j = i + 1; j < i + *num_pages; j++) {
> +               size_t next = min_t(size_t, PAGE_SIZE, bytes);
> +
> +               if (page_folio(pages[j]) != folio ||
> +                   pages[j] != pages[j - 1] + 1) {
> +                       break;
> +               }
> +               contig_sz += next;
> +               bytes -= next;
> +       }
> +       *num_pages = j - i;
> +
> +       return contig_sz;
> +}
> +
>   #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
> 
>   /**
> @@ -1277,9 +1307,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>          unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
>          struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>          struct page **pages = (struct page **)bv;
> -       ssize_t size, left;
> -       unsigned len, i = 0;
> -       size_t offset;
> +       ssize_t size, left, len;
> +       unsigned int i = 0, num_pages;
> +       size_t offset, folio_offset;
>          int ret = 0;
> 
>          /*
> @@ -1321,15 +1351,29 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> 
>          for (left = size, i = 0; left > 0; left -= len, i++) {
>                  struct page *page = pages[i];
> +               struct folio *folio = page_folio(page);
> +
> +               folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
> +                               offset;
> +
> +               len = min_t(size_t, (folio_size(folio) - folio_offset), left);
> +
> +               num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
> +
> +               if (num_pages > 1)
> +                       len = get_contig_folio_len(&num_pages, pages, i,
> +                                                  folio, left, offset);
> 
> -               len = min_t(size_t, PAGE_SIZE - offset, left);
>                  if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> -                       ret = bio_iov_add_zone_append_page(bio, page, len,
> -                                       offset);
> +                       ret = bio_iov_add_zone_append_folio(bio, folio, len,
> +                                       folio_offset);
>                          if (ret)
>                                  break;
>                  } else
> -                       bio_iov_add_page(bio, page, len, offset);
> +                       bio_iov_add_folio(bio, folio, len, folio_offset);
> +
> +               /* Skip the pages which got added */
> +               i = i + (num_pages - 1);
> 
>                  offset = 0;
>          }
> --
> 2.25.1
> 
> 

Well. The issue here is that bvecs really only use the 'struct page' 
entry as an address to the data; the page size itself is completely
immaterial. So from that perspective it doesn't really matter whether
we use 'struct page' or 'struct folio' to get to that address.
However, what matters is whether we _iterate_ over pages or folios.
The current workflow is to first allocate an array of pages,
call one of the _get_pages() variants, and the iterate over all
pages.
What we should be doing is to add _get_folios() variants, working
on folio batches and not pre-allocated arrays.
Then we could iterate over all folios in the batch, and can modify
the 'XXX_get_pages()' variants to extract pages from the folio batch.
And then gradually move over all callers to work on folio batches.

Tall order, but I fear this is the best way going forward.
Matthew? Christoph? Is that what you had in mind?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

