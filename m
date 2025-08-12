Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC741B2186;
	Tue, 12 Aug 2025 03:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970327; cv=none; b=sPb/E0rkhohi0Yah2Q9ttmUaM1JMheynewcL6e+KC+2XXA3y5Dwj+4oeQMWq4UZdLFpvfKTkEMJyQXaUly7LVXsBj3WvWKeS//oXH3cPIKbrT84yiYZjFpYB56GDeJqaz96ERSawh7kM2YGvVPxnpe+ghrSQgtDDR/zjXTnkGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970327; c=relaxed/simple;
	bh=EtYefwQ06isDcxpPWHrzmmhgCcOPPIUkE/bef4RlpgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3sRNOs1BrWMMJb6/5LfdGKXYlIq0875M/cm3fTXDoPfsAT7mtLtPaHDeazzzwl4tgT0x1FR3ZkP0d7vV11G0325DqBfxHkdPIeirpAk+943lq8ZTuVinaKJTkNAQiyHyBlE7jomgBfbJ65nJpDtdsVs9J4oHidJxPuP+K0voqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr1PX3M/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr1PX3M/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEEDC4CEED;
	Tue, 12 Aug 2025 03:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754970327;
	bh=EtYefwQ06isDcxpPWHrzmmhgCcOPPIUkE/bef4RlpgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pr1PX3M/oxu3qVfPZdrKBYKkNrHO2BPr6+nYP3587IR7Mru81WnKV9vX8xIUoY3Az
	 XDZ9r7Gu0meJCQ20WkqmPbaEgxWrAT+zyNtf1IjThgAnyspryIrnkiPBRtqO0X8uLg
	 gZH8ACAO32b19vtqX7Y+l0YU/4ZMyIEV/ZciriBcWnIWQZ3p9sxUTz9u6CJVpeO/eo
	 kGEAO0sm5rGjT7FwMoOnkp8aStCkse2nHzrQIc1AAKK/ae3BNX1bCDGc1Ooki9oOtk
	 1CNam8eBjlU459lMZk0/lOWGoSOovv86KL9TvW6/ZV87Gzgi92mnL4jfK4AfEuhVgx
	 JZiuMP+qnaOlQ==
Message-ID: <34624336-331d-4047-822f-8091098eeebc@kernel.org>
Date: Tue, 12 Aug 2025 12:42:44 +0900
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
References: <a8041180-03f2-3342-b568-867b3f295239@huaweicloud.com>
 <20250812033201.225425-1-rajeevm@hpe.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250812033201.225425-1-rajeevm@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 12:32 PM, Rajeev Mishra wrote:
> Hi Kuai,
> 
> Thank you for the feedback on the v2 patch regarding error handling.
> 
> Yu mentioned:
>> return 0 here is odd. Why not "return ret;" to propagate the error if any ?
> 
> I understand the concern about proper error propagation. However, there's a 
> type compatibility issue I'd like to discuss before implementing v3:
> 
> 1. Current function signature: `static loff_t get_size(...)` 
>    - Returns size as positive loff_t (unsigned 64-bit)  
>    - All callers expect non-negative size values
> 
> 2. vfs_getattr_nosec() error codes are negative integers (-ENOENT, -EIO, etc.)
>    - Returning `ret` would cast negative errors to huge positive numbers
>    - This could cause loop devices to appear as exabyte-sized
> 
> 3. Current callers like loop_set_size() don't handle error checking
> 
> Would you prefer for v3:
> a) Change function signature to `int get_size(..., loff_t *size)` and update all callers  
> b) Different approach?
> 
> diff with ret approach
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index c418c47db76e..15117630c6c1 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -142,12 +142,13 @@ static int part_shift;
>   * @offset: offset into the backing file
>   * @sizelimit: user-specified size limit
>   * @file: the backing file
> + * @size: pointer to store the calculated size
>   *
>   * Calculate the effective size of the loop device
>   *
> - * Returns: size in 512-byte sectors, or 0 if invalid
> + * Returns: 0 on success, negative error code on failure
>   */
> -static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)

Since loff_t is "long long", so a signed type, I would keep this interface and
add a negative error check in the 2 call sites for get_size(). That is simpler.

> +static int get_size(loff_t offset, loff_t sizelimit, struct file *file, loff_t *size)
>  {
>         struct kstat stat;
>         loff_t loopsize;
> @@ -159,7 +160,7 @@ static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
>          */
>         ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
>         if (ret)
> -               return 0;
> +               return ret;
> 
>         loopsize = stat.size;
> 
> @@ -167,7 +168,7 @@ static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
>                 loopsize -= offset;
>         /* offset is beyond i_size, weird but possible */
>         if (loopsize < 0)
> -               return 0;
> +               return -EINVAL;
> 
>         if (sizelimit > 0 && sizelimit < loopsize)
>                 loopsize = sizelimit;
> @@ -175,12 +176,20 @@ static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
>          * Unfortunately, if we want to do I/O on the device,
>          * the number of 512-byte sectors has to fit into a sector_t.
>          */
> -       return loopsize >> 9;
> +       *size = loopsize >> 9;
> +       return 0;
>  }
> 
>  static loff_t get_loop_size(struct loop_device *lo, struct file *file)
>  {
> -       return get_size(lo->lo_offset, lo->lo_sizelimit, file);
> +       loff_t size;
> +       int ret;
> +
> +       ret = get_size(lo->lo_offset, lo->lo_sizelimit, file, &size);
> +       if (ret)
> +               return 0;  /* Fallback to 0 on error for backward compatibility */
> +
> +       return size;
>  }
> 
> 
> I am happy to implement whichever direction you think is best.
> 
> Thanks,
> Rajeev


-- 
Damien Le Moal
Western Digital Research
