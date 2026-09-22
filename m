Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4A48C8C7;
	Tue, 22 Sep 2026 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055664; cv=none; b=iMzopzZ/POIxVx7f1CViSOANODniSsOUM0UfY+gQLPJh3duGK4qIYHc9hNbzoJeqU7MOu/Qvbi0QAmVWoLXyz78NuX8McAbGbjV5k4AgMks2Vc+nmNqkgRxqTs8VzElZ4PkVgGb/J5cmwG/0yHROW5FXgR51xzKbna67Zq5iWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055664; c=relaxed/simple;
	bh=0m74/NuXnpdI5HZN7s9BSPJE2QIYMquBSMx4uL9l8E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWt1z3F5EdVw+czQcPEdAQcYjhCPg0ari/FYlXWX5hOMietgw31lNyANur+CLel2aP6AwHvJruqpxuGccuwODBPxeE0f7bbTTqh4HsXu72NzTXZbpvHvXrDFxizTtGsSwSJW4lzeSgz2nutYZh+8Lo7AmQWode43GAbvJQfb6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d95NfJ38; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k8LsAIwy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JiqjT+IH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fxHB4VJr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d95NfJ38";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k8LsAIwy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JiqjT+IH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fxHB4VJr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00C581F461;
	Tue, 22 Sep 2026 05:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790055648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=881qMJTzHXTYKTlngI1y105KnwzLXrZERRsJ5Asuak8=;
	b=d95NfJ38nVTpXOI5LeHSA6yRcU0PTj44ju2v+5SeGf0twYizHNuItn5DQYESyBQ6MQB0tg
	xK0GdWtHz+kdQrChAuhivFfqZI3kDVHcPbYvuJ3Gu7+S4g3VxG5Ij5oMP/H81qtG3y5b1C
	2U+lKpQIXwLC4by5KvxaQX232OuW6Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790055648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=881qMJTzHXTYKTlngI1y105KnwzLXrZERRsJ5Asuak8=;
	b=k8LsAIwyGjN52MTTmqHbN4Ft55EfclU00eq+LrXRLdkRqfqA6iXA6o1eMzV7LPR5f0LIMj
	Mg1bMPKhLiLJISDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JiqjT+IH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fxHB4VJr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790055644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=881qMJTzHXTYKTlngI1y105KnwzLXrZERRsJ5Asuak8=;
	b=JiqjT+IHxDG8qLLZmGho/l4WiiVe6J1HP0y2ZnnOlASFQGs63g56+tBjTAcfXGWFsTND7l
	TUR15/+pl0fHm1ZCul8KMofjx0CxsaX60Qk9nJowo9QJc+2VSX+okR+xgp/3XtRoEY8qX+
	YwVrFvwrt9zQu+G0Y4t/UfClr1qzftc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790055644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=881qMJTzHXTYKTlngI1y105KnwzLXrZERRsJ5Asuak8=;
	b=fxHB4VJr6JdaD32XpRHn2ejC7SwIkPi0m+pMZ43ZqP0WVzIVKAhRC2reREVE1f01zo/ZNR
	ZIh9RYw87aiAshCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64604136D9;
	Tue, 22 Sep 2026 05:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2UlED9sUsmrSawAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Sep 2026 05:40:43 +0000
Message-ID: <341ec217-4b3b-49aa-9481-4cf7e8952228@suse.de>
Date: Tue, 22 Sep 2026 07:40:42 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] block: fail a short atomic pin in
 bio_iov_iter_get_pages()
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
 <20260921-blkdev-fixes-v4-5-e2801f71ede9@columbia.edu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260921-blkdev-fixes-v4-5-e2801f71ede9@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 00C581F461
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
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,sashiko.dev:url,columbia.edu:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,columbia.edu:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On 9/22/26 4:54 AM, Tal Zussman wrote:
> On a partial page pin, __blkdev_direct_IO_simple() and
> __blkdev_direct_IO_async() submit what was pinned with REQ_ATOMIC set
> and leave the rest to the buffered fallback, tearing an IOCB_ATOMIC
> write.
> 
> This can be triggered deterministically. A 16K pwritev2(RWF_ATOMIC)
> whose last page is PROT_NONE, on a scsi_debug device with atomic_wr=1,
> completes short with only three of the four pages written, violating
> RWF_ATOMIC semantics.
> 
> Make bio_iov_iter_get_pages() release the pins and return -EINVAL when
> a REQ_ATOMIC bio doesn't cover the whole iterator, since an atomic
> write is submitted as a single bio and a short one would be torn. That
> covers iomap as well, where a partially unmapped buffer could trip the
> WARN_ON_ONCE() in iomap_dio_bio_iter_one(). The async block device path
> currently sets REQ_ATOMIC after pinning, so set it before, and move
> REQ_NOWAIT along with it.
> 
> Fixes: caf336f81b3a ("block: Add fops atomic write support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   block/bio.c  | 29 ++++++++++++++++++++++-------
>   block/fops.c | 12 ++++++------
>   2 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index f95b63c0604a..14429a5d4e68 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1285,6 +1285,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>   			   unsigned mem_align_mask, unsigned len_align_mask)
>   {
>   	iov_iter_extraction_t flags = 0;
> +	int ret;
>   
>   	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>   		return -EIO;
> @@ -1304,34 +1305,48 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>   		flags |= ITER_ALLOW_P2PDMA;
>   
>   	do {
> -		ssize_t ret;
> +		ssize_t size;
>   
> -		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
> +		size = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
>   				BIO_MAX_SIZE - bio->bi_iter.bi_size,
>   				&bio->bi_vcnt, bio->bi_max_vecs,
>   				mem_align_mask, flags);
> -		if (ret <= 0) {
> +		if (size <= 0) {
>   			/*
>   			 * A misaligned vector fails the whole I/O.  Release any
>   			 * pages pinned by earlier iterations before returning
>   			 * since this bio won't be submitted to release them.
>   			 */
> -			if (ret == -EINVAL) {
> +			if (size == -EINVAL) {
>   				bio_release_pages(bio, false);
>   				bio_clear_flag(bio, BIO_PAGE_PINNED);
>   				bio->bi_vcnt = 0;
>   			}
>   			if (!bio->bi_vcnt)
> -				return ret;
> +				return size;
>   			break;
>   		}
> -		bio->bi_iter.bi_size += ret;
> +		bio->bi_iter.bi_size += size;
>   	} while (iov_iter_count(iter) && !bio_full(bio, 0));
>   
I would swizzle the use of 'ret' and 'size' here; leaving 'ret'
untouched and use 'size' as the new variable. That will reduce
code churn and makes the patch easier to read.

>   	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
>   		bio->bi_opf |= REQ_NOMERGE;
> -	return bio_iov_iter_align_down(bio, iter,
> +	ret = bio_iov_iter_align_down(bio, iter,
>   			&bio->bi_io_vec[bio->bi_vcnt - 1], len_align_mask);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * An atomic write is submitted as a single bio, so it has to cover
> +	 * the whole iterator or it would be torn.
> +	 */
> +	if ((bio->bi_opf & REQ_ATOMIC) && iov_iter_count(iter)) {
> +		bio_release_pages(bio, false);
> +		bio_clear_flag(bio, BIO_PAGE_PINNED);
> +		bio->bi_vcnt = 0;
> +		return -EINVAL;
> +	}
> +	return 0;
>   }
>   
>   static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size,
> diff --git a/block/fops.c b/block/fops.c
> index a3a709697b40..90777e8a9a6c 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -342,6 +342,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>   	bio->bi_end_io = blkdev_bio_end_io_async;
>   	bio->bi_ioprio = iocb->ki_ioprio;
>   
> +	if (iocb->ki_flags & IOCB_ATOMIC)
> +		bio->bi_opf |= REQ_ATOMIC;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		bio->bi_opf |= REQ_NOWAIT;
> +
>   	/*
>   	 * Users don't rely on the iterator being in any particular
>   	 * state for async I/O returning -EIOCBQUEUED, hence we can
> @@ -371,12 +377,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>   			goto out_bio_put;
>   	}
>   
> -	if (iocb->ki_flags & IOCB_ATOMIC)
> -		bio->bi_opf |= REQ_ATOMIC;
> -
> -	if (iocb->ki_flags & IOCB_NOWAIT)
> -		bio->bi_opf |= REQ_NOWAIT;
> -
>   	if (iocb->ki_flags & IOCB_HIPRI) {
>   		bio->bi_opf |= REQ_POLLED;
>   		submit_bio(bio);
> 

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
