Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA81DE3A5
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742277370; cv=none; b=Jys54HsIWlyFjDyiPk34woTXQ6ltlReTrK7BVgUbgTgGcAe4HLBuQ7ue2MFb/4hrTadRbxzE5tHYzGqOkRVzgPmFtw8qU/1YWwQvhkF4hzNjXGgXN4lMeTh/cU/RnyZuZvb9Xu70Wu8GDTqRVq7s0kaiSjAMc/ptsaGRc+bMWBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742277370; c=relaxed/simple;
	bh=VXWwZuEuCOwe8Le4O/bF4WnDNtCdDeZwt1+t6wZx7Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsTDvPCExuhmrPwQFEZq6oKCYJe3m0kYBN1kzom6CdeAVizP36g8k95yB82/argonnRlO3n94FnFC1HEvbPg+tNQ9WRM5LpnFaYqycKfkMXinFNgiD6v5NcOHsroOCu0NynQ6M2Z6l/SIw2K2/R1vVn30TdXXsd2XzuP+YQUSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MreVBbqw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MreVBbqw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L/LbVwqvXLAd7K4Yd8eLiYO/LLQeqOjwv2Ks7hWVBZI=; b=MreVBbqwaSjD2tejRMkWzMV2hE
	hJtl16KoKDKlDcirz4zyp8S3iyuSR9+rkclmVgFmH6iugzDVfESWA3L6BIocve0ONx5eDNnouGLTu
	cs/ODus2rWDIY1rF+wLUVbfdLg35kcbbOd7CCrnGnl0PRSXBa40Iw3DWPInKEC3W+DV/eAo93Dj1Y
	Wr7UcmvjgiXzASllu8p7yPbhYltI4qMq1kpxaUoK2+vbCVNgErywP8IL+PRXYZldXJZu6Ht5hmPDa
	Sv879OYWE+ubWYzy6rfQ+izyvJAx6YwNBcbnPz3/E9gUhsRgap01w+nz2CPO0fFY5ekcwAufQoSgM
	ALD31LnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuPvr-00000004li2-19bJ;
	Tue, 18 Mar 2025 05:56:07 +0000
Date: Mon, 17 Mar 2025 22:56:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH V2] loop: move vfs_fsync() out of loop_update_dio()
Message-ID: <Z9kK95VoHmp5k7_B@infradead.org>
References: <20250318010318.3861682-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318010318.3861682-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 18, 2025 at 09:03:18AM +0800, Ming Lei wrote:
> If vfs_flush() is called with queue frozen, the queue freeze lock may be
> connected with FS internal lock, and lockdep warning can be triggered
> because the queue freeze lock is connected with too many global or
> sub-system locks.
> 
> Fix the warning by moving vfs_fsync() out of loop_update_dio():
> 
> - vfs_fsync() is only needed when switching to dio
> 
> - only loop_change_fd() and loop_configure() may switch from buffered
> IO to direct IO, so call vfs_fsync() directly here. This way is safe
> because either loop is in unbound, or new file isn't attached
> 
> - for the other two cases of set_status and set_block_size, direct IO
> can only become off, so no need to call vfs_fsync()
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
> Reported-by: Jiaji Qin <jjtan24@m.fudan.edu.cn>
> Closes: https://lore.kernel.org/linux-block/359BC288-B0B1-4815-9F01-3A349B12E816@m.fudan.edu.cn/T/#u
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- update comment(Christoph)
> 
>  drivers/block/loop.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 8ca092303794..7ddb3cbc20fe 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -189,18 +189,12 @@ static bool lo_can_use_dio(struct loop_device *lo)
>   */
>  static inline void loop_update_dio(struct loop_device *lo)
>  {
> -	bool dio_in_use = lo->lo_flags & LO_FLAGS_DIRECT_IO;
> -
>  	lockdep_assert_held(&lo->lo_mutex);
>  	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
>  		     lo->lo_queue->mq_freeze_depth == 0);
>  
>  	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
>  		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
> -
> -	/* flush dirty pages before starting to issue direct I/O */
> -	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !dio_in_use)
> -		vfs_fsync(lo->lo_backing_file, 0);
>  }
>  
>  /**
> @@ -637,6 +631,9 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
>  		goto out_err;
>  
> +	/* may work in dio, so flush page cache before issuing dio */
> +	vfs_fsync(file, 0);

What does "may work" here mean?  I think you mean something like:

	/*
	 * We might switch to direct I/O mode for the loop device, write back
	 * all dirty data the page cache now that so that the individual I/O
	 * operations don't have to do that.
	 */

?

