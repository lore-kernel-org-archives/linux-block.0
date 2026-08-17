Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51F39B4AF
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958501; cv=none; b=o7u2SMc0dAsrBocR59fUf84igzr+KNCzYSm5Vul6Lng1YT6OVvl6wxHHkJj5x6Yo1JF6Xh6rHCwizI2w4RyaypVaiYRmwJAU6BSsQguoorQ/3SmVx3QkgK3lofLD2UBnMoC6syUcYLmRwhIgQ3NIx9s+vWfeO4d4Z8GG3QUBjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958501; c=relaxed/simple;
	bh=wncs3z8sHfQWbWtSt0F/Ta9h5Q9Y6Skqz2nrW8Ti8jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6dKIeIItMeS98eCqp5v4PxLSQQb5vFPb4XeTVZayhd+ci1440TgKbWwMZtAu/vqSV80QwLyOGgQ46RU9R+ydQROPSZuQ/I3jPVHuWTUQLHu8SSZAW48gkiy4RYkOG1MM35gEyVC9OxJc0GJl+b1ipZxDf5gE1JeL5r+xD8SmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xI8Mkr5S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xI8Mkr5S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UNGTu1MwIDlj7xWG61Pqlt/x3wAG1+M+uUeHpjGTo9Y=; b=xI8Mkr5S8hOLMWaTabDwdFktWN
	mLXLvdl6vpXCQtnljDTjvyq1Gngk59PKXeVnNrZ+khDGFdY79xdPitGDLw7+NBjqc+EMd1AuYqLjq
	v/fDPrgCwJtcjciY26ciWI6H1q40nD7MrbBjZJ5dhkpXrHcQFB/Bv+4JiKp/qFcZteq7RvTVypbBg
	ezuLDcaTVqtT0lX/81WXj8x8I8A6go6PTMhKpfk6AIhiYAKmTedtoOtTdxKBrJtqaLzEb8uaYp7ot
	834MyceJjwoyOBz4PMXG8mOhIwzDOraIPNssveKqLLIzMS3Mzf6Cr6vT5VZaN47VVdSiciYH6rzI/
	pyiBoJ4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvtXG-00000005nhX-1bKm;
	Mon, 17 Aug 2026 09:21:38 +0000
Date: Mon, 17 Aug 2026 02:21:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhenxian Ma <1604099876@qq.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org, mzx199711@gmail.com,
	Zhenxian Ma <mazhenxian@xiaohongshu.com>
Subject: Re: [PATCH v2 2/2] block: only use REQ_FUA for direct writes if the
 device supports it
Message-ID: <aoLSovrhs5H1y34L@infradead.org>
References: <20260812130335.60354-1-mzx199711@gmail.com>
 <cover.1786782832.git.mzx199711@gmail.com>
 <tencent_A41247F29AC0971AE96B52964BE4491B440A@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A41247F29AC0971AE96B52964BE4491B440A@qq.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Aug 15, 2026 at 08:02:15PM +0800, Zhenxian Ma wrote:
> From: Zhenxian Ma <mzx199711@gmail.com>
> 
> When a block device does not support FUA natively, the block layer
> emulates it by adding a cache flush to every write bio.  An O_DSYNC
> direct write that spans N bios then costs N flushes, rather than the
> single generic_write_sync() issued after the write completes.
> 
> Introduce blkdev_dio_fua() to decide when REQ_FUA is set.  A synchronous
> write can rely on generic_write_sync() when the device lacks FUA, so it
> sets REQ_FUA only when bdev_fua() is true.  An asynchronous write
> completes in blkdev_bio_end_io() and cannot call the blocking
> generic_write_sync(), so it keeps REQ_FUA (emulated when needed) to stay
> durable.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Zhenxian Ma <mzx199711@gmail.com>
> Signed-off-by: Zhenxian Ma <mazhenxian@xiaohongshu.com>
> ---
>  block/fops.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index a2c3af38106b..e7d073620271 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -26,12 +26,26 @@ static inline struct inode *bdev_file_inode(struct file *file)
>  	return file->f_mapping->host;
>  }
>  
> -static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
> +static bool blkdev_dio_fua(struct kiocb *iocb, struct block_device *bdev)
> +{
> +	if (!iocb_is_dsync(iocb))
> +		return false;
> +	/*
> +	 * Async writes cannot fall back to generic_write_sync(), so they must
> +	 * use FUA (emulated if needed); sync writes only need it when the
> +	 * device supports FUA natively.
> +	 */

Ah, I guess this explain why the original code unconditionally uses FUA.
Let's hope no one cares about the performance of large async writes
on devices without FUA.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
