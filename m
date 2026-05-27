Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0F3859CE;
	Wed, 27 May 2026 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866660; cv=none; b=uT2GzXJjaN38XaGIFnlzvaNpn23SXNlQEkuywiFxvE8PQrJ0bgbjT5az2NJD25++uLbDqmpN93Sk6pKc0/TvSV8BmGpvSA5ZIrPVisO6taCcHXsXO2egI5E2UzR2jtiWbpyRjKjQHUgVfoWlRnKhfEDsIhBdnYDSv2powCHlBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866660; c=relaxed/simple;
	bh=KKaNcC8bu1ZYAB6OXBa8iNOJE/gWRwy9d06vsFTJpeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASk/s66ZdwFVSnQ3oEtGixFBZZoezmlqPdkmyjWXrbqYQ2ktc+bY4xCo6jfq9tkWB5ACKMHmbk5i+CYQZgKaTRpGdKwDIFvsBbrOl8gRQLPgarfUgHdL0je2oZcS15YJ+J+16mDW8XzVtYRORlxogGz+i20SKKnmF3b0OaDRQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2359E68C4E; Wed, 27 May 2026 09:24:15 +0200 (CEST)
Date: Wed, 27 May 2026 09:24:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Cunlong Li <shenxiaogll@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] zram: fix use-after-free in
 zram_bvec_write_partial()
Message-ID: <20260527072414.GA17856@lst.de>
References: <20260527-zram-v2-0-2fb84b054b5c@gmail.com> <20260527-zram-v2-1-2fb84b054b5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-zram-v2-1-2fb84b054b5c@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 27, 2026 at 12:49:24PM +0800, Cunlong Li wrote:
> zram_read_page() picks the sync or async backing device read path
> based on whether the parent bio is NULL.  zram_bvec_write_partial()
> passes its parent bio down, so for ZRAM_WB slots the read is
> dispatched asynchronously and zram_read_page() returns 0 while the
> bio is still in flight.  The caller then runs memcpy_from_bvec(),
> zram_write_page() and __free_page() on the buffer, leaving the
> async read to write into a freed page.
> 
> zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
> ("zram: fix synchronous reads") for the same reason; the
> write_partial counterpart was missed.
> 
> Fixes: 4e3c87b9421d ("zram: fix synchronous reads")

That's just the last patch touching the line.  This bio chaining goes
further back.  AFAICS all the way to introducing backing device support
in: 8e654f8fbff5 ("zram: read page from backing device")

The patch itself looks good, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>
