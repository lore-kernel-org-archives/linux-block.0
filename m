Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA12D155321;
	Thu,  2 Jan 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735838611; cv=none; b=Zng7zxbIgke+WjElk2OUHSDV6tk4OLHxILaNUj5AH+p8Uc0gSX6r73c+W9BVTQJ/nkoB4mMCdZeG/uNDuOPPNLI/L+gWbb9B+f6POSXx9yqGSZ6g1gRjDlx9hN9Qy0WlaDep4bSXryGfokBfXcF/9F/z+PA85mPl6QnUiTQShFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735838611; c=relaxed/simple;
	bh=Xph7yzU3rfw180r/MiXIXjmB/wThD+U6hLNEBbbHbpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV/Hb9PlWGes2X1W7gPuw2hycSFbFgKgslPaF9DD85D7CuJ5zl7RJvrzSVxtGTJe11eQOGmv6FnN5CVE+mbzUJwjKQ+6bwPSC+MK1GXFBYZjr/vShDs9WhisDNLo5d+iK7G+KJWzeGfiFKlEA/zZnLTtIWwfXuN2PHN+kjVnNUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1w3++f9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1w3++f9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B3CC4CED0;
	Thu,  2 Jan 2025 17:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735838611;
	bh=Xph7yzU3rfw180r/MiXIXjmB/wThD+U6hLNEBbbHbpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1w3++f9r9qZY11J5GFIbueL0ue2WDvr91hEElaF/iGdoGAz54dpzawB13MjuJnWh
	 8fCclqOwnZ50veURjiPeCPq5znZXnvr2BJtDjAz4JHd2Zi1BjZ/ziJ5Dm1lffLeopL
	 Tc6rNGc6WE1u/Yw6dU3CY+o83+aQ6kQ/mNwyGEp1VC0mfQqnhgkZcnt204evJMFI5m
	 ZONgwiJNnngKdGQwPoT2tHrW/2KkKN5Zu3lgMQl1f53ij0z54g0bSEdBCQ/RIYfKPO
	 JmzMjWwv2VMBKvSXKc1lASeOrw4B2WyFV7cWEi/EBIOZd09vXPu6UJOyEcE+92zIXl
	 8e9b9KYcIHf2Q==
Date: Thu, 2 Jan 2025 17:23:29 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: axboe@kernel.dk, satyat@google.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] blk-crypto: Add check for mempool_alloc()
Message-ID: <20250102172329.GA49952@google.com>
References: <20250102083319.176310-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102083319.176310-1-haoxiang_li2024@163.com>

On Thu, Jan 02, 2025 at 04:33:19PM +0800, Haoxiang Li wrote:
> Add check for the return value of mempool_alloc() to
> catch the potential exception and avoid null pointer
> dereference.
> 
> Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  block/blk-crypto-fallback.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 29a205482617..47acd7a48767 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -514,6 +514,12 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
>  	 * bi_end_io appropriately to trigger decryption when the bio is ended.
>  	 */
>  	f_ctx = mempool_alloc(bio_fallback_crypt_ctx_pool, GFP_NOIO);
> +
> +	if (!f_ctx) {
> +		bio->bi_status = BLK_STS_RESOURCE;
> +		return false;
> +	}

mempool_alloc() with a mask that includes ___GFP_DIRECT_RECLAIM, such as the
GFP_NOIO which is used here, never returns NULL.

- Eric
