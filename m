Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B951A71B
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6FF30D4
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 06:35:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C0C867373; Thu,  9 Nov 2023 15:35:17 +0100 (CET)
Date: Thu, 9 Nov 2023 15:35:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH V2 1/2] block: don't call into iov_iter_revert if
 nothing is left
Message-ID: <20231109143517.GA30592@lst.de>
References: <20231109082827.2276696-1-ming.lei@redhat.com> <20231109082827.2276696-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109082827.2276696-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  	if (bio->bi_bdev) {
>  		size_t trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
> -		iov_iter_revert(iter, trim);
> -		size -= trim;
> +
> +		if (trim) {
> +			iov_iter_revert(iter, trim);
> +			size -= trim;
> +		}

We also need to fix this.  This isn't supposed to be called without
a bdev set, but Kent broke this.  But if we don't have a bdev
we need to pass the block size manually and still do the revert if needed.

