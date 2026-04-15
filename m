Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA93806C1;
	Wed, 15 Apr 2026 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776294000; cv=none; b=Au5qsoKWIdZZjZPmEd/uphRrcOnKlCsJ5liEz7F0COJbCWVmCeRF+nSeDfWeC5roEeeS3y5/pK4gX6nWqh+1HU7sEQLIyNFrc3Q8tScbZGx5qPy9ZIFTMhvlVrE2H+w67Ivad1JYQRyU84XuDj9cNG4lNmO0ePTnFtQJfNZYLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776294000; c=relaxed/simple;
	bh=pbHjxXBxSfFS93OsSny5m0eUXvkEUQ2GtUMvPIJHplo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1oh7ZlPougQc3XJiQOWWOaDOyTAzuH0+iPD6RrlE0zlZoqOLpUFVcigiiMKDrtkiJbR+iX/HT6Xd+v9pSOrczj5DQtneTTCXCZDn0Unud4zKeuzAk8zzsdIWJwmKP1fBbnr/3DwH5UvtcCzVNtDIpsUFpEQiv3IzEjj2MpRx4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/TNMlmG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/TNMlmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5E0C19424;
	Wed, 15 Apr 2026 22:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776294000;
	bh=pbHjxXBxSfFS93OsSny5m0eUXvkEUQ2GtUMvPIJHplo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/TNMlmGny4Gie0sWmiUZ7EKMRI4X4jnYiUFS54exgVJswRndm1RPi4K06o5KU9I2
	 iF8VxrSsfW1uSqkWa4G/hiO6K+pro/9ZYPR1Ns1KleOwa093nd3gw/35y95lz/wVwh
	 2w07d+6otR478J+gUA1I7OO+xvaX68kK693jH6Ory3kL4KF+95YUQDcQjMKwHId18b
	 kBoubUoo2eesScgsT4Lwu9KWUSwbBRlfUV9xnVQ9XkpIiPoKqqoMhOG76I1I4cUSWW
	 BKSYWI7eJvLNZ4k8/tLHgYcdR9uR49VF/YpGVLO0kFOmq8zMTSbQHeWXdY97UWQXhL
	 2SdYIdMRuGShg==
Date: Wed, 15 Apr 2026 16:59:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?Q?Tom=E1s?= Trnka <trnka@scm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Spurious raid1 device failure triggered
 by qemu direct IO on 6.18+
Message-ID: <aeAYbuC5v4AgbakT@kbusch-mbp>
References: <2982107.4sosBPzcNG@electra>
 <ad-sprBWPA20iola@kbusch-mbp>
 <ad-0LIubzaT8M2_O@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad-0LIubzaT8M2_O@kbusch-mbp>

On Wed, Apr 15, 2026 at 09:52:12AM -0600, Keith Busch wrote:
> Suggest the stacking layers shouldn't consider BLK_STS_INVAL to be a
> device error or retryable.

I was able to recreate the reported issue (the key is you have to use
dm-raid, not md-raid), and the below diff tests successfully for me.
I'll send a formal patch tomorrow.

> ---
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index c33099925f230..cf1c25f290f36 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -293,8 +293,16 @@ static inline bool raid1_should_read_first(struct mddev *mddev,
>   * bio with REQ_RAHEAD or REQ_NOWAIT can fail at anytime, before such IO is
>   * submitted to the underlying disks, hence don't record badblocks or retry
>   * in this case.
> + *
> + * BLK_STS_INVAL means the request itself is malformed (e.g. unaligned
> + * buffers that violate DMA constraints).  Retrying on another mirror will
> + * fail the same way, and counting it against the device is wrong.
>   */
>  static inline bool raid1_should_handle_error(struct bio *bio)
>  {
> -	return !(bio->bi_opf & (REQ_RAHEAD | REQ_NOWAIT));
> +	if (bio->bi_opf & (REQ_RAHEAD | REQ_NOWAIT))
> +		return false;
> +	if (bio->bi_status == BLK_STS_INVAL)
> +		return false;
> +	return true;
>  }
> --
> 
