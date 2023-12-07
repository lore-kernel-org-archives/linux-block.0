Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cMZW8ORI"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E77D5B;
	Wed,  6 Dec 2023 23:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Q0/r8c8J5jaGf9nK/v5AUyuY2tHVneG34T5XTQysYnc=; b=cMZW8ORI7DHj6gN+gkCkoJLzEj
	WrbuHAOomTaAjazFGBbrj3B+nmpoMgHILgaNWp+K1x75GzpAVyaRscrYXw56OH/W6rPOJXkg5MQ5F
	0kcaf+bOvizfkStikj7nmnkN603fmedKzgvrNRM2uH6cdQ8LHup2zANzETckon1GpKFNXD8QwMNE/
	dyWTMOuje8JkC9T04AO4Nay/0EST7teYpfzJmCz0Tu/rhGaw0Cu9ZKwe20EKuBSVubo6cDdrMuSKS
	EYOwt5s1Kyc81YQtwq/IGVgTKTOYOhzGPP/u0nr399nKZIbVFXqFSd8z+GzRegqgFmQngtp6a6xOQ
	a/vMMhyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rB93d-00C71X-1x;
	Thu, 07 Dec 2023 07:44:29 +0000
Date: Wed, 6 Dec 2023 23:44:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sergei Shtepa <sergei.shtepa@linux.dev>
Cc: axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Sergei Shtepa <sergei.shtepa@veeam.com>,
	Donald Buczek <buczek@molgen.mpg.de>,
	Fabio Fantoni <fantonifabio@tiscali.it>
Subject: Re: [PATCH v6 02/11] block: Block Device Filtering Mechanism
Message-ID: <ZXF33Q9TpF4kBXP0@infradead.org>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-3-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124165933.27580-3-sergei.shtepa@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> +	bool skip_bio = false;
> +
> +	if (unlikely(bio_queue_enter(bio)))
> +		return;
> +
> +	if (bio->bi_bdev->bd_filter &&
> +	    bio->bi_bdev->bd_filter != current->blk_filter) {
> +		struct blkfilter *prev = current->blk_filter;
> +
> +		current->blk_filter = bio->bi_bdev->bd_filter;
> +		skip_bio = bio->bi_bdev->bd_filter->ops->submit_bio(bio);
> +		current->blk_filter = prev;
> +	}
> +
> +	blk_queue_exit(q);

This currently adds a queue enter/exit pair even if no filter driver
is used, which іs probably not acceptable.  We probably need some
way to avoid the check in the fast path.  In general an unlocked check
for bio->bi_bdev->bd_filter outside the protection seems fine to here,
we just need to find a good way to make sure it is visible by the
time a filter is actually set and the filter driver initialization.

>  	if (!bio->bi_bdev->bd_has_submit_bio) {
>  		blk_mq_submit_bio(bio);
> -	} else if (likely(bio_queue_enter(bio) == 0)) {
> +		return;
> +	}
> +
> +	if (likely(bio_queue_enter(bio) == 0)) {

This is just stray reformatting and we can drop it.

