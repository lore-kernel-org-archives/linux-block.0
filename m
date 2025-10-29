Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F4301001
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753994; cv=none; b=RWFVogfn7+SBSR4qXSWctEeIUGnM1T+H9Azsk8LyF0a1+fOiW5ONWPdWYsLsgPCh65lYUt3gpnGDVZUXuL9hBJ91td+Ymoty5n/7Q0zAtTc6X+WxwkryndLB1JBgrBNruscrU+VJNKwTNngVIm1uyn93klAf5Mf+DnMP7Pth1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753994; c=relaxed/simple;
	bh=oBHgkEpdHT07OPZTUFGQJibbhABmUlX2gu9JV2jZzUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4ZfW61Jn6sWbJDEb0hhQQbTMOrm4RFNOD8eaXwjWAAr5dGD2xhFF4vwkrCtk//D9V57Cf7p3RZ4aOD5jP0yCy7vy23irtaQVBfXVas+cuq31Yq/HT2+2yBKF75VJ+oBimDlosLJ1bJATzVWUdnD+cKaz9vRTHm0ReTdnpue3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFKfjw+S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFKfjw+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCBDC4CEF7;
	Wed, 29 Oct 2025 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761753993;
	bh=oBHgkEpdHT07OPZTUFGQJibbhABmUlX2gu9JV2jZzUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFKfjw+SX15oD+wJz+Qg2wo5r5nj1u577kQi5HYUOWkhO8qmKC9zco9tdGe1iQ4Fu
	 +/x1zZcuPKYmRBnRYY1GrYjGpKYH2ZcfFqBQnjicJIw3ZPlBU7I1cQ7AnrFCnY6HDt
	 J+3bvpqX8m3nLCRUoHWkIF82bAu4a1iEZ6IxSD227meAk4UQy/UOq+GclE0vsCgF08
	 uOuLbqZeAUb+eTf1NXIYCtjQrfunNqttKGYiY9kwizijdXirNnUNYMTJfU89pKZ8gY
	 ncJ80EgO3mrSwF+gQyMPd1FEhrfiDri7A0h5XlfckNpj09Km1MotOTYCTmAIDs3OTb
	 xeNqjdm78u56A==
Date: Wed, 29 Oct 2025 10:06:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, hch <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH] null_blk: set dma alignment to logical block size
Message-ID: <aQI7hyET6f-nXnmp@kbusch-mbp>
References: <20251029133956.19554-1-hans.holmberg@wdc.com>
 <aQIgvwec4Ol7ed8K@kbusch-mbp>
 <49749a76-5849-410f-966d-6011dd4d5f41@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49749a76-5849-410f-966d-6011dd4d5f41@wdc.com>

On Wed, Oct 29, 2025 at 03:32:30PM +0000, Hans Holmberg wrote:
> Hmm, the data is actually copied nullb->dev->blocksize sized chunks
> 
> see copy_to_nullb:
> 
> temp = min_t(size_t, nullb->dev->blocksize, n - count);

That's just saying blocksize is the largest it will transfer. It can be
smaller if there's less data than a block size in the bvec.

> ..
> memcpy_page(t_page->page, offset, source, off + count, temp);
> 
> Just to verify that nullblk was missbehaving I enabled debugging
> for the copy and hit a bug_on in memcpy_page:
> 
> VM_BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
> 
> (This was a 4k block size nullblk with the default 511 byte dma limit)

Oh, I see. It's that the source buffer with its weird offsets that don't
align can cause a problem. This should fix it:

---
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f982027e8c858..385fe6523ec12 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1143,6 +1143,7 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 			null_make_cache_space(nullb, PAGE_SIZE);
 
 		offset = (sector & SECTOR_MASK) << SECTOR_SHIFT;
+		temp = min_t(size_t, temp, PAGE_SIZE - offset);
 		t_page = null_insert_page(nullb, sector,
 			!null_cache_active(nullb) || is_fua);
 		if (!t_page)
@@ -1172,6 +1173,7 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 		temp = min_t(size_t, nullb->dev->blocksize, n - count);
 
 		offset = (sector & SECTOR_MASK) << SECTOR_SHIFT;
+		temp = min_t(size_t, temp, PAGE_SIZE - offset);
 		t_page = null_lookup_page(nullb, sector, false,
 			!null_cache_active(nullb));
 
--

After this, you can set dma_alignment to 1.
