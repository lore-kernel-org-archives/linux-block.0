Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279C319F115
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747138; cv=none; b=WXld2vPc0pL2EaJktnhFDJ9JH99D0mEtphuFdMjxjyKtoWmqXdtCXiyBJ6tKBpvw+lHvkUPfnlJuqihJTeVarQrAcmGsy/H5QW/uHiTVSUQCCl9TYnj97LgY0hiQKnrj0mV3n1c842bRGRSKfmstCmWUNcBvlItVFeLIOWhtcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747138; c=relaxed/simple;
	bh=3jWgAo7QfvXXs1kxS5LnqM5nczipheYvPpHiOaNsoL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2d9eHbYa9+/GFk1VdKKKuUEKRz58JmviovJh9OObPf9ERzS6yj4VcFYnrzhbvIch0BaoEokO3ZtIui2tzqrzqN9VUzTYpYTbtQ+iKhV9cuco9wTXgBSQ0MhfKrGsyavOUSlKvaOp9gXeFtiTRDJDuiuZEBlOxI2z6lv+b5XyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXnQXxTb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXnQXxTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F55C4CEF7;
	Wed, 29 Oct 2025 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761747138;
	bh=3jWgAo7QfvXXs1kxS5LnqM5nczipheYvPpHiOaNsoL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXnQXxTb8OHcvNUgHVFfNUdcKarzbnS7gQgml6jyXbF4acwnUhPZYIzY7jm+cJ7cN
	 iD9AHPa/J576+3BVcL+SEXolxXa2cTzzKLoYTlL97OJz4NxeubozI6V7CeGJOJNgal
	 7SFetEp/HFdEOUGfNUTWj6lOI7IJdlAVkfHWF3Y5SH51SBceDgj3kxzLwq1XSUGfAK
	 fJfL0x5xjOEadgvzxKsx3cpAoHljYAueh/6RFeHoeFOgI/IUrYbVrBovrweU+281Cq
	 COi8vZY1pxlCYszry/zeJt1rHTZ/TBH1n1KZk+xRkNmlOc2/D/zRuNde9tDHoKqynQ
	 MutIwiJQJ6lIg==
Date: Wed, 29 Oct 2025 08:12:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hans Holmberg <hans.holmberg@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH] null_blk: set dma alignment to logical block size
Message-ID: <aQIgvwec4Ol7ed8K@kbusch-mbp>
References: <20251029133956.19554-1-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029133956.19554-1-hans.holmberg@wdc.com>

On Wed, Oct 29, 2025 at 02:39:56PM +0100, Hans Holmberg wrote:
> This driver assumes that bio vectors are memory aligned to the logical
> block size, so set the queue limit to reflect that.
> 
> Unless we set up the limit based on the logical block size, we will go
> out of page bounds in copy_to_nullb / copy_from_nullb.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> ---
> 
> A fixes tag would be in order, but I have not figured out exactly when
> this became a problem.

Sorry! This is from the relaxed memory address alignment changes I've
been making to reduce the need for bounce buffers.

> @@ -1949,6 +1949,7 @@ static int null_add_dev(struct nullb_device *dev)
>  		.logical_block_size	= dev->blocksize,
>  		.physical_block_size	= dev->blocksize,
>  		.max_hw_sectors		= dev->max_sectors,
> +		.dma_alignment		= dev->blocksize - 1,
>  	};

It looks like null_blk only needs (SECTOR_SIZE - 1). All the data copies
work in sector_t units and SECTOR_SIZE granularity, so does dma
alignment really need to match the blocksize if it's, for example, 4k?
And if not, since null_blk didn't set dma_alignment before, it should
have been defaulting to 511 already.
