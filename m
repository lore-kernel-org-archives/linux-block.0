Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D524A05D;
	Fri, 25 Jul 2025 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466859; cv=none; b=jS9R+Ap2DecwYqS1Ws9dxec6zFY0NhNDRmTdRO8lgAoc8AW1imviAsyEOJG+Wea5RaTa3jQW4BZSCbgAS01znBL3xcjBRZp1w5ZYOob/UftQGzZKBpvebA+JU2T4WrcoQiLhXkr/pe9B9moCs3d8vSsCH5O3j6AiCtbFIdaDFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466859; c=relaxed/simple;
	bh=CyXDKIm/NOaUiEVH3RX+Xm2vCciV+OMT/NH5s2ctpDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZUP8JzSh0Hw/JXKbazmmcMZoJm4yd4LnG5xFD4qR2UWm7mtIP6AGwMzRoCw5Llow+CMUhQQFz9hfymZGS+pugyNeVY+z2lLRnJVzkKyQnFRKqi1+kRNZf4aKG7TC/XrX9UpZbuzRZlIlDMosPvLPyk4rNI5QBm55U0ZKflD2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn6I4Brf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn6I4Brf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD169C4CEE7;
	Fri, 25 Jul 2025 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753466857;
	bh=CyXDKIm/NOaUiEVH3RX+Xm2vCciV+OMT/NH5s2ctpDg=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bn6I4Brfm9P1/zR8QphMtNEuzgEY/QLn0heZ4pCQINsZMLES59Vvue81uPD3doHjF
	 ZWmdkngY33tNoLrRf60WeKFcrvaSmIV6AjP3AA7c2LwgNJpmn1oKyDEgnbv4X0IJmn
	 RX9njpDdmA5MQK7LeqqZSqn80H4KLmAktKanCK2m6LPQxoK6/UoX544KMZdQSRiakc
	 ntwVrQapCmgUMiuxud3sAh1lXQDBY4tDi6pWLO/hK76aO3CpcSK8Fj7kyDUcdFzqbk
	 m2yctPv+cke2YgRG3bBvEm9kQzBUPz5a3SVWSW5JD1tC4bPeD8V6/kCA1dItV5LxCk
	 HqMgPm98JPLPg==
Message-ID: <6375ee42-a9c3-4cb9-b14e-856565dd8525@kernel.org>
Date: Sat, 26 Jul 2025 02:07:33 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH 1/3] blk-wbt: Optimize wbt_done() for non-throttled writes
To: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk, hch@lst.de,
 jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 tangyeechou@gmail.com
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
 <20250724083001.362882-2-yizhou.tang@shopee.com>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <20250724083001.362882-2-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/7/24 16:29, Tang Yizhou 写道:
> From: Tang Yizhou <yizhou.tang@shopee.com>
>
> In the current implementation, the sync_cookie and last_cookie members of
> struct rq_wb are used only by read requests and not by non-throttled write
> requests. Based on this, we can optimize wbt_done() by removing one if
> condition check for non-throttled write requests.
>
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>   block/blk-wbt.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index a50d4cd55f41..30886d44f6cd 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -248,13 +248,14 @@ static void wbt_done(struct rq_qos *rqos, struct request *rq)
>   	struct rq_wb *rwb = RQWB(rqos);
>   
>   	if (!wbt_is_tracked(rq)) {
> -		if (rwb->sync_cookie == rq) {
> -			rwb->sync_issue = 0;
> -			rwb->sync_cookie = NULL;
> -		}
> +		if (wbt_is_read(rq)) {
> +			if (rwb->sync_cookie == rq) {
> +				rwb->sync_issue = 0;
> +				rwb->sync_cookie = NULL;
> +			}
>   
> -		if (wbt_is_read(rq))
>   			wb_timestamp(rwb, &rwb->last_comp);
> +		}
>   	} else {
>   		WARN_ON_ONCE(rq == rwb->sync_cookie);
>   		__wbt_done(rqos, wbt_flags(rq));
At lease this is correct logically.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
