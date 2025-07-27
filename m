Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93EE1FC7E7;
	Sun, 27 Jul 2025 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753636155; cv=none; b=eH4ucXL0HEU2EKqYJuur3pgvMW8GwG7xklB/NmqqzUkAnz43vxlt9l5/7xBeqMh/ff819L8Q9CW7o+doUL/obdFvYQ3rSLEOTEGHrAXr+kyeN2X845EohILH7ymwy7gv/yO9sIGDyy5Hap10qFQeni1OLlGiF6rBqCZc6eV9u+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753636155; c=relaxed/simple;
	bh=SD6OqvapmGZ7UiIOFK1RyTjMRZLyejj7GlhBdpW6+oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szVP/fj59j3mpSsrby2CmDhXTr/TPTpnDt61aBVokF/SkNFATDPz8O/m+YR8dG3rEe827M4BBOCI6nLvm7S+0RnhDbydRUzt1GSxnDc0HRPl3K/8JyfbepiV8FUMTjpqTvNrZPsj0/s4+KjFJ67rYQbBLIL4rx7DTfeQcBek55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3DPVC2p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3DPVC2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B1DC4CEEB;
	Sun, 27 Jul 2025 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753636154;
	bh=SD6OqvapmGZ7UiIOFK1RyTjMRZLyejj7GlhBdpW6+oA=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z3DPVC2pRiShL7LhL0GftQfIepUEuhgMLl33nu7P/BF/7FF+U19m4Gqss/sHa7E/7
	 K40P8MMo5EBU/r93sRIkNaZDHrRd8BL0XjZXsbrK/QygGtQFQHtYvkjwKYy4GabnYf
	 bvvo78Y6c3YQrUkgVqEP59VoNIDklbwTBycv1kQrHI2WkurY5Bj1jKCzv3w4plMc+l
	 f0ncokFn6QGDXESwOvyWNCbb5RlXqgrkM7r7T/HnzdJzdbO8im0OqSkTuWGsmw2btl
	 iPYSxy1IFnYyfm8gMp3Qevr2U6EaLbrgXEdNOmmQzVLsvCEcbkuVRtYyDWgdDYH2rZ
	 9v8hkXtSFvjrA==
Message-ID: <939f45b2-4481-422a-a747-012808953d7f@kernel.org>
Date: Mon, 28 Jul 2025 01:09:07 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH v2 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec
 interface
To: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, hch@lst.de,
 jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 tangyeechou@gmail.com
References: <20250727164709.96477-1-yizhou.tang@shopee.com>
 <20250727164709.96477-4-yizhou.tang@shopee.com>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <20250727164709.96477-4-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/7/28 0:47, Tang Yizhou 写道:
> From: Tang Yizhou <yizhou.tang@shopee.com>
>
> The symbol wb_window_usec cannot be found. Update the doc to reflect the
> latest implementation, in other words, the cur_win_nsec member of struct
> rq_wb.
>
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>   Documentation/ABI/stable/sysfs-block | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 4ba771b56b3b..277d89815edd 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -731,7 +731,7 @@ Contact:	linux-block@vger.kernel.org
>   Description:
>   		[RW] If the device is registered for writeback throttling, then
>   		this file shows the target minimum read latency. If this latency
> -		is exceeded in a given window of time (see wb_window_usec), then
> +		is exceeded in a given window of time (see cur_win_nsec), then
Is this a typo? Jan suggested curr_win_nsec from v1.

BTW, I don't mind rename rwb->cur_win_nsec to curr_win_nsec as well.

Thanks,
Kuai

>   		the writeback throttling will start scaling back writes. Writing
>   		a value of '0' to this file disables the feature. Writing a
>   		value of '-1' to this file resets the value to the default

