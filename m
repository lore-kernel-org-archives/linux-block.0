Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38729 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750697AbcFANsS (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2016 09:48:18 -0400
Date: Wed, 1 Jun 2016 06:48:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@canonical.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	"supporter:XFS FILESYSTEM" <xfs@oss.sgi.com>
Subject: Re: [PATCH v6 5/8] fs: xfs: replace BIO_MAX_SECTORS with
 BIO_MAX_PAGES
Message-ID: <20160601134816.GA20963@infradead.org>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
 <1464615294-9946-6-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464615294-9946-6-git-send-email-ming.lei@canonical.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 30, 2016 at 09:34:33PM +0800, Ming Lei wrote:
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index e71cfbd..e5d713b 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1157,9 +1157,7 @@ xfs_buf_ioapply_map(
>  
>  next_chunk:
>  	atomic_inc(&bp->b_io_remaining);
> -	nr_pages = BIO_MAX_SECTORS >> (PAGE_SHIFT - BBSHIFT);
> -	if (nr_pages > total_nr_pages)
> -		nr_pages = total_nr_pages;
> +	nr_pages = min(total_nr_pages, BIO_MAX_PAGES);
>  
>  	bio = bio_alloc(GFP_NOIO, nr_pages);

While I think this is a useful cleanup on it's own I think
you'd make everyones life easier if bio_alloc simply clamped down
the passed nr_pages value to the maximum allowed.
