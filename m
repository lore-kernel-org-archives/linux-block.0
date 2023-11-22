Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R6YRWtxa"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F469D1;
	Tue, 21 Nov 2023 23:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xKzadQBp86OPkvjkpX1NPj8LtoV9+7VhbqtkMJ7c0p8=; b=R6YRWtxaLw6jG2S3GfiNe5UL1W
	19YrMm3BTQIFpje67cz9XGp2xu4KuwhFCVHLKcNW2+0JoczOf/E8SKNVh5osjmP34/iXSvALyTC82
	OkXvMx5oCWyGdg8JPzbGfB40hjvB7m0gJNPgFMzY2VlSP8ZC2B4eY2V3vD1lJMrNl2qR1juBD73Si
	cNtjziHq1vutkQd2+v0taG733jkz2D8q7Et5FUwa0YdwWe1ASzGoVkn2/7j0YcVA/JQJfSwGHWamy
	qhtwVIRX6jaRKN0iZ/3Obpbc+oS9n3xHzMp3jmHjRQJQQ0QIS5wZEoOjF5+X78OgOHMDwIdUIT752
	eZZU8d+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5hfM-000uPI-0t;
	Wed, 22 Nov 2023 07:28:56 +0000
Date: Tue, 21 Nov 2023 23:28:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Message-ID: <ZV2tuLCH2cPXxQ30@infradead.org>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122103103.1104589-3-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	if (partno && bdev_flagged(disk->part0, BD_FLAG_HAS_SUBMIT_BIO))
> +		bdev_set_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
>  	else
> +		bdev_clear_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);

While the block layer has a bit of history of using wrappers for
testing, setting and clearing flags, I have to say I always find them
rather confusing when reading the code.

> +#define BD_FLAG_READ_ONLY	0 /* read-only-policy */

I know this is copied from the existing field, but can you expand
it a bit?

> +#define BD_FLAG_WRITE_HOLDER	1
> +#define BD_FLAG_HAS_SUBMIT_BIO	2
> +#define BD_FLAG_MAKE_IT_FAIL	3

And also write comments for these. 

> +
>  struct block_device {
>  	sector_t		bd_start_sect;
>  	sector_t		bd_nr_sectors;
> @@ -44,10 +49,8 @@ struct block_device {
>  	struct request_queue *	bd_queue;
>  	struct disk_stats __percpu *bd_stats;
>  	unsigned long		bd_stamp;
> -	bool			bd_read_only;	/* read-only policy */
> +	unsigned short		bd_flags;

I suspect you really need an unsigned long and atomic bit ops here.
Even a lock would probably not work on alpha as it could affect
the other fields in the same 32-bit alignment.

