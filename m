Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1C829617A;
	Thu, 26 Jun 2025 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928084; cv=none; b=U5YUpphbjFG+QQyuhJs4tQJdVhxSWqhtHiR7o+XvwiDcscW3TY1DYdq0a4Y/Yf5UMn1VGDGqhZRFkY58szLx87ilECEgWFD3Peuq6AymWwEKLuexbLzqh3STkq5CRkhnGTazNyW7LpgUU52t1k+DFpPSon8oh0Gp7E8lRMr4m4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928084; c=relaxed/simple;
	bh=0TH71Dhds5dtLv4EikA0QKrDx9Iy9bKdIp2ZGs2Ak/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAUd4YLeBIzYQn12UdkZlTYF55vke5lIFIm50i+F+5Zom1sgK8ByF0pZu04wsvCK1pQikIb2EhweWNgpZr8jiDPI+3Z/nk7c9IvsRgg3ARkiGb9DPKPsRCsfUznoB+z1e79aqrYg6YfgVOJesySHGzKQKBVVlJZHQT+C4AEjAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhDTPZwF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhDTPZwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1113FC4CEEB;
	Thu, 26 Jun 2025 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750928083;
	bh=0TH71Dhds5dtLv4EikA0QKrDx9Iy9bKdIp2ZGs2Ak/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EhDTPZwFbQ+12IG9Do0UP3kDYNFDPmM7uBuCFjBR5kEUcMiKw65/QdNOEYccu8ovn
	 CppZZZmRnsUgBAd3No2t9DD/30wnxxK+M7NiB3GqzGr1pOp3/YBmg76gQzlxCuzzBM
	 spIxuqR6VXakFYox3e/F68aResjV6SdGqtpJ+zml+YRXI2BNP25ywbGEsa46UEL4Z6
	 1e1AYWMh9QyRZbv1COCgVX6xUzfwkxAoTJfzkiqI9J9EJTeTDY1TJMrD9b18gTCSQv
	 2c7d+JmcZ6V91PHWKmnMEZex2bymoM1yIg3ffAMs9XYNBnl/e7K0zRQpI+gkqJBANc
	 z2P+NTfRqwSdQ==
Message-ID: <2350a34d-2f7b-49c0-b286-2856c088131a@kernel.org>
Date: Thu, 26 Jun 2025 17:54:40 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix false warning in bdev_count_inflight_rw()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hare@suse.de,
 hch@infradead.org, yukuai3@huawei.com, john.g.garry@oracle.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@redhat.com, calvin@wbinvd.org, david@fromorbit.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250626083927.576207-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250626083927.576207-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 17:39, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> While bdev_count_inflight is interating all cpus, if some IOs are issued
> from traversed cpu and then completed from the cpu that is not traversed
> yet:
> 
> cpu0
> 		cpu1
> 		bdev_count_inflight
> 		 //for_each_possible_cpu
> 		 // cpu0 is 0
> 		 infliht += 0
> // issue a io
> blk_account_io_start
> // cpu0 inflight ++
> 
> 				cpu2
> 				// the io is done
> 				blk_account_io_done
> 				// cpu2 inflight --
> 		 // cpu 1 is 0
> 		 inflight += 0
> 		 // cpu2 is -1
> 		 inflight += -1
> 		 ...
> 
> In this case, the total inflight will be -1, causing lots of false
> warning. Fix the problem by removing the warning.
> 
> Noted there is still a valid warning for nvme-mpath(From Yi) that is not
> fixed yet.
> 
> Fixes: f5482ee5edb9 ("block: WARN if bdev inflight counter is negative")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/linux-block/aFtUXy-lct0WxY2w@mozart.vkv.me/T/#mae89155a5006463d0a21a4a2c35ae0034b26a339
> Reported-and-tested-by: Calvin Owens <calvin@wbinvd.org>
> Closes: https://lore.kernel.org/linux-block/aFtUXy-lct0WxY2w@mozart.vkv.me/T/#m1d935a00070bf95055d0ac84e6075158b08acaef
> Reported-by: Dave Chinner <david@fromorbit.com>
> Closes: https://lore.kernel.org/linux-block/aFuypjqCXo9-5_En@dread.disaster.area/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/genhd.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 8171a6bc3210..680fa717082f 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -141,9 +141,14 @@ static void bdev_count_inflight_rw(struct block_device *part,
>  		}
>  	}
>  
> -	if (WARN_ON_ONCE((int)inflight[READ] < 0))
> +	/*
> +	 * While iterating all cpus, some IOs might issued from traversed cpu
> +	 * and then completed from the cpu that is not traversed yet, causing
> +	 * the inflight number to be negative.

Nit (grammar):

	 * While iterating all CPUs, some IOs may be issued from a CPU already
	 * traversed and complete on a CPU that has not yet been traversed,
	 * causing the inflight number to be negative.

> +	 */
> +	if ((int)inflight[READ] < 0)
>  		inflight[READ] = 0;
> -	if (WARN_ON_ONCE((int)inflight[WRITE] < 0))
> +	if ((int)inflight[WRITE] < 0)
>  		inflight[WRITE] = 0;
>  }
>  


-- 
Damien Le Moal
Western Digital Research
