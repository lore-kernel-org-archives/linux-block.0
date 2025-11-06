Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D831B132
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430498; cv=none; b=lT8EkUwsYJ30rS3TKHOgtKMcpdkXRNvXog2+WP7Ta5Z+yas2c9Vou7N7i+DlCvVFvgVDN32OGOapWp++CMsv7XgkDGcndzgl7pKU5CdbfwonIiNE3gOkkmhgejn1WlzxVETpN9qAzD3hwNOgdBB+b7M4F18Y9nVy8DjfW6mffkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430498; c=relaxed/simple;
	bh=ZlzmQsRcAo4E/fjgaPskmrxu0Erko3jiT8t4kONgRyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU08punihKuZUQyYMMm5Q+IbWDg8c4RWfHiNooUKd26QM5jb0BD4+B3Kdct+R6qeBQXoS8Glrvp2f7RGe0lLKPL4sQqJk1rmf4HjmXyNlS7U6KviY8//NPydtT9iQBmns+JXJOKRVVjNPAxKMoRJrq9esfQ1W1EMZPQxgBKNdC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 30526227A87; Thu,  6 Nov 2025 13:01:32 +0100 (CET)
Date: Thu, 6 Nov 2025 13:01:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	dlemoal@kernel.org, hans.holmberg@wdc.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
Message-ID: <20251106120131.GD2002@lst.de>
References: <20251106015447.1372926-1-kbusch@meta.com> <20251106015447.1372926-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106015447.1372926-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 05, 2025 at 05:54:47PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Allowing byte aligned memory provides a nice testing ground for
> direct-io.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/block/null_blk/main.c  | 46 ++++++++++++++++++----------------
>  drivers/block/null_blk/zoned.c |  2 +-
>  2 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 34346590d4eee..f1e67962ecaeb 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1130,25 +1130,27 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
>  }
>  
>  static blk_status_t copy_to_nullb(struct nullb *nullb, void *source,
> -				  sector_t sector, size_t n, bool is_fua)
> +				  loff_t pos, size_t n, bool is_fua)

Is it just me, or is n are way to non-descriptive argument name?  Can
we fix that if you touch it anyway?

>  {
>  	size_t temp, count = 0;
> -	unsigned int offset;
>  	struct nullb_page *t_page;
> +	sector_t sector;
>  
>  	while (count < n) {

And count here should be done of offset.  I really had a bit of a hard
time following the code due to the naming.

>  static blk_status_t null_transfer(struct nullb *nullb, struct page *page,
> -	unsigned int len, unsigned int off, bool is_write, sector_t sector,
> +	unsigned int len, unsigned int off, bool is_write, loff_t pos,
>  	bool is_fua)

.. and the indentation here could use fixing if we touch it anyway.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
