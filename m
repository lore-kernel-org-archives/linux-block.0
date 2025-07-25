Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B88246764;
	Fri, 25 Jul 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467225; cv=none; b=oNNQt6cKp0+1a+8VWIVNpKo0GlRBHaYssMxd+qA94yYrnDweaok8O/HIccF5jNLzwKYrQ70/nlVAK4ms5T9ZjE0hL804ieUm01sc/RT4tp5Nqx3oCTfrxP9NjHeB1AXVRr33GAm79K7EWu1wgd0yvUsOvVU7hzNxOeQ19LRmi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467225; c=relaxed/simple;
	bh=gvP4RTQh1qAjrE4HkuGUslv22dn+rJLnxSCcEZsHzCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSQXsHCZm7uoDy4MrWp/B+DIVB/qJc1U+nGyHdLJ8mlAKxdmYAJf3M5sZVcAVEeHv0f+hFhhQzdAsGDdCjRMyIrY5MBipwQnGO0FFL2xiL3NWB9zrRGnXHcq2Ina8jzY+NuR9rXOeAdpdarTWM9YyIhY1MTbrG8kQMU2yBzWzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4w/DRDB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4w/DRDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B581C4CEE7;
	Fri, 25 Jul 2025 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753467224;
	bh=gvP4RTQh1qAjrE4HkuGUslv22dn+rJLnxSCcEZsHzCQ=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n4w/DRDB4GkzLul076g0RAfzMkTOUSjznvuOzHeHYdnS13sHW529xD8vaSl+PIt//
	 VM4TOX3lrRQPo2YzoGLMFyYGzAxy3aTy4MXbDg5ozjTXfFHSggkUkgayMvyEnLl+nX
	 hb8RmyM8++MmN0f7AH1hM+2WQzVidQN0hIW3li3zu6WaxA/Jwm73oJhWCysrJK9yXT
	 3XpCnR3HUe/ArBLlZQA95xgNybjX4+aIe8GIuy2aW18WuWjTP3yroxE0Jj5oLSVY8d
	 lsOdITy/jOokrLPEq4uOkHeXvtK5I2eD/bDUHFvwG6Dca0Jsql8yfvijMeYj2/9UmC
	 jleOrISLPse6g==
Message-ID: <9e1bc039-ed01-46d4-8ce3-6ce0f73f2733@kernel.org>
Date: Sat, 26 Jul 2025 02:13:39 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH 2/3] blk-wbt: Eliminate ambiguity in the comments of
 struct rq_wb
To: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, hch@lst.de,
 jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 tangyeechou@gmail.com
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
 <20250724083001.362882-3-yizhou.tang@shopee.com>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <20250724083001.362882-3-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/7/24 16:30, Tang Yizhou 写道:
> From: Tang Yizhou <yizhou.tang@shopee.com>
>
> In the current implementation, the last_issue and last_comp members of
> struct rq_wb are used only by read requests and not by non-throttled write
> requests. Therefore, eliminate the ambiguity here.
>
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>   block/blk-wbt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 30886d44f6cd..eb8037bae0bd 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -85,8 +85,8 @@ struct rq_wb {
>   	u64 sync_issue;
>   	void *sync_cookie;
>   
> -	unsigned long last_issue;		/* last non-throttled issue */
> -	unsigned long last_comp;		/* last non-throttled comp */
> +	unsigned long last_issue;	/* issue time of last read rq */
> +	unsigned long last_comp;	/* completion time of last read rq */
>   	unsigned long min_lat_nsec;
>   	struct rq_qos rqos;
>   	struct rq_wait rq_wait[WBT_NUM_RWQ];
Not sure if this is worth it, I'm more concerned about backport trouble.

Thanks,
Kuai
