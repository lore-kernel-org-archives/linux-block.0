Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA994F61E
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/gIKBtb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fpYk1PzFVLtBnCZV9ClSsGllAafpf61bpnFKWSHK9l8=; b=X/gIKBtbrSBfvf4LyPrMs5k0H8
	sNGQ76NIVfk2KckETh7Q5zsL4LhiGJQ5tLIEPueua3OPNSXSXFB0NVULrga0sRloDFizaS9V5vEMm
	i52jYI7z2V93qqgSzIQySZMW7f5qLILPL2FoUiL3EQFH7uc7oATIpSlZGehxMSBdOs5kAfRMMYO5w
	ZHANWoQqKmiEq8RvR9rsq6Jvh3IF1dx+JXME40y9BFkPVjXVCHxkdMVUfPn5ZDnlZ7+axMCaQDOGg
	Ibc5SvRCyv6zIeABk7l7C/ryZJKI7pR6y5NnjBRhCg7mk+Is3P6ABvJpDBFrKBuExNFmUo+Qbkbyk
	WVBYRo5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNxZY-000X95-0l;
	Thu, 11 Jan 2024 16:06:24 +0000
Date: Thu, 11 Jan 2024 08:06:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 2/3] block/integrity: flag the queue if it has an
 integrity profile
Message-ID: <ZaASADP4js2Oboqx@infradead.org>
References: <20240111160226.1936351-1-axboe@kernel.dk>
 <20240111160226.1936351-3-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111160226.1936351-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 11, 2024 at 09:00:20AM -0700, Jens Axboe wrote:
> Now that we don't set a dummy profile, if someone registers and actual
> profile, flag the queue as such.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-integrity.c  | 14 +++++++++-----
>  include/linux/blkdev.h |  1 +
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index a1ea1794c7c8..974af93de2da 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -339,22 +339,25 @@ const struct attribute_group blk_integrity_attr_group = {
>   */
>  void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template)
>  {
> -	struct blk_integrity *bi = &disk->queue->integrity;
> +	struct request_queue *q = disk->queue;
> +	struct blk_integrity *bi = &q->integrity;
>  
>  	bi->flags = BLK_INTEGRITY_VERIFY | BLK_INTEGRITY_GENERATE |
>  		template->flags;
>  	bi->interval_exp = template->interval_exp ? :
> -		ilog2(queue_logical_block_size(disk->queue));
> +		ilog2(queue_logical_block_size(q));
>  	bi->profile = template->profile;
> +	if (bi->profile)
> +		blk_queue_flag_set(QUEUE_FLAG_INTG_PROFILE, q);

Is this really so much better vs just checking for bi->profile
being non-NULL?

