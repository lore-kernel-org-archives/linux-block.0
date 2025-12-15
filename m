Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BE3168F8
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765789388; cv=none; b=ZfflOtRRmCKWFwb33M9WWA528yr5tjlK2uGjehS/Zo+5rbIzitE/qx4f308BBIRfRY1fBHJnjAdcLLK+Em+2Q/RrD4x4gZ+3CXr1xzKcTsaFn57ghVQ/JO1LnS+9j6suEzsSiECwo1jZcd5MB2HVA36wdKtKGIDC6rMAgDsjOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765789388; c=relaxed/simple;
	bh=OY4r8eSfKRYFQFtxfzjic5hM/CISIaurnPf04hVrsWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqX2W1Lqe4/Am0iN1311F3WSpkQGggCzGtgPiZZzVeOb53CoCcPGJ3ptmMVrH6YziQayoQAyBnY+V0h8E46syieK8STp7BHPqx6uJ9Y9VHNkSRCXIyW2DshPXGA3NybBzqsVuNawyZI3RZdBm48i5PDRUizolHG/f8rVYKi+x8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADep48NW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADep48NW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38448C4CEF5;
	Mon, 15 Dec 2025 09:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765789387;
	bh=OY4r8eSfKRYFQFtxfzjic5hM/CISIaurnPf04hVrsWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ADep48NWo+2js0ewk3FHIxQgLTzsCsOjR1npO15AcWqI0bvuL8A1t+6RqkK4GjwR5
	 0eAS5SZ+1gJDYB067FSk6KMuT4yR4NB+Bcg5cCrTxwS7mZHBRv4k91U3ewnXb+vb89
	 l1lzfXjI3qGwTlqy54LkfuP4gqiWbN1vrsJR0NTNQZeTgfayJGswm8fl2sUzv4cCHN
	 YWVyd3c4abGe6PUj8OqcMVnzREdvcAITKGTGx+1lJd7GNTYtVnOaqas7p0CPpZh2ED
	 NqZC8lHI02xDulSvz2mXL2NVolvlRi8aCgvpwKAax5t49pMHInkcGWeinFaQ5viezU
	 aZH+r7IJj3kYA==
Message-ID: <867d692f-a0fe-4e6e-b635-66dead923535@kernel.org>
Date: Mon, 15 Dec 2025 18:03:04 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] loop: use READ_ONCE() to read lo->lo_state without
 locking
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
References: <20251215085518.1474701-2-yangyongpeng.storage@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251215085518.1474701-2-yangyongpeng.storage@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 17:55, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> When lo->lo_mutex is not held, direct access may read stale data. This
> patch uses READ_ONCE() to read lo->lo_state and data_race() to silence
> code checkers.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
> v2:
> - Use READ_ONCE() instead of converting lo_state to atomic_t type.
> ---
>  drivers/block/loop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 272bc608e528..f245715f5a90 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1858,7 +1858,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	blk_mq_start_request(rq);
>  
> -	if (lo->lo_state != Lo_bound)
> +	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound)

READ_ONCE() without a corresponding WRITE_ONCE() does not make much sense. You
need to use WRITE_ONCE() wherever the device state is updated under the mutex lock.

>  		return BLK_STS_IOERR;
>  
>  	switch (req_op(rq)) {
> @@ -2198,7 +2198,7 @@ static int loop_control_get_free(int idx)
>  		return ret;
>  	idr_for_each_entry(&loop_index_idr, lo, id) {
>  		/* Hitting a race results in creating a new loop device which is harmless. */
> -		if (lo->idr_visible && data_race(lo->lo_state) == Lo_unbound)
> +		if (lo->idr_visible && data_race(READ_ONCE(lo->lo_state)) == Lo_unbound)
>  			goto found;
>  	}
>  	mutex_unlock(&loop_ctl_mutex);


-- 
Damien Le Moal
Western Digital Research
