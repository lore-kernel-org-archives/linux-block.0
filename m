Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062D278E42;
	Tue, 12 Aug 2025 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754962984; cv=none; b=TChog4/iW6ZP9q0suTR4oEun14YBG3PIHjRoo4DqawXbffF9p//sEQc2g5lm7qBoQ/Tpy+S5TgihUZVkp2nP96GfEiwZE0+gbhopgcKn+yHJZSH4upU1fXHzVCRcTrgWubaOkGEWDyCr5kNyzsP3+pUGXJkdgyHp05qpiuX8u1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754962984; c=relaxed/simple;
	bh=QNYaXJ3BSUGnVQ38MaOSNWQKXtQmrXZZNRH5KU1m+9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srj0nosHNZErNgoMMQWyr7mn4c4EIWWZn1vK9aWd7H15ViLyNMbGrvHaycaEfZ+GfVrlKtr+4a0Csxdw0nvMyf0D5P/wmeDiP759km8lGbFM4lJiuGb7AVcpJzFkpQ/siXXMOUIb6/7cZCzppLC+qQpk+erWOuW4Inny2rxD9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsIX3UjJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsIX3UjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E91C4CEED;
	Tue, 12 Aug 2025 01:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754962984;
	bh=QNYaXJ3BSUGnVQ38MaOSNWQKXtQmrXZZNRH5KU1m+9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rsIX3UjJ7JR7/dDVlwN9gxS+2zW7J7Qm9FCC7x0y1CNvTSP9KNZyBZizyfSqolelv
	 D7pJAHx589yHUZANNceRXYtUGkw72Nk+oR0ZSN+cEMsG4TT0ix6cztMsbRKA3QWxK0
	 AbfBZ0STsnDxsCpbNDf86P/GPVR+P9U7dt4dVz8yqZA+4LZ3jcbCIUsh5MN/7PzguI
	 tnrrU4YzclQEwpdc7o3eAmykzZXVlf+HrsU2stsRuKNFRxR/ZubLJW1ygHm6nccHTu
	 ySppy1wqKqXMrvmW6+/kNRfBWZVXz+nhiPlSUKyQqEFoPSywbdi+mJNwXvLsQusLXQ
	 ucTjJ+e5WTJyg==
Message-ID: <45b33232-9089-4df4-b9f8-c843cb3d2d07@kernel.org>
Date: Tue, 12 Aug 2025 10:40:21 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] loop: use vfs_getattr_nosec() for accurate file size
To: Rajeev Mishra <rajeevm@hpe.com>, axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250811190303.222802-1-rajeevm@hpe.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250811190303.222802-1-rajeevm@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 4:03 AM, Rajeev Mishra wrote:
> The get_size() function now uses vfs_getattr_nosec() instead of
> i_size_read() to obtain file size information. This provides more
> accurate results for network filesystems where cached metadata
> may be stale, ensuring the loop device reflects the current file
> size rather than potentially outdated cached values.
> 
> Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
> ---
>  drivers/block/loop.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 1b6ee91f8eb9..c418c47db76e 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -137,12 +137,32 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
>  static int max_part;
>  static int part_shift;
>  
> +/**
> + * get_size - calculate the effective size of a loop device
> + * @offset: offset into the backing file
> + * @sizelimit: user-specified size limit
> + * @file: the backing file
> + *
> + * Calculate the effective size of the loop device
> + *
> + * Returns: size in 512-byte sectors, or 0 if invalid
> + */
>  static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
>  {
> +	struct kstat stat;
>  	loff_t loopsize;
> +	int ret;
> +
> +	/*
> +	 * Get the accurate file size. This will prevent caching
> +	 * issue that occurs at filesystem layer.
> +	 */
> +	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
> +	if (ret)
> +		return 0;

return 0 here is odd. Why not "return ret;" to propagate the error if any ?
An error may come from the underlying FS inode->i_op->getattr().

> +
> +	loopsize = stat.size;
>  
> -	/* Compute loopsize in bytes */
> -	loopsize = i_size_read(file->f_mapping->host);
>  	if (offset > 0)
>  		loopsize -= offset;
>  	/* offset is beyond i_size, weird but possible */


-- 
Damien Le Moal
Western Digital Research
