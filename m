Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E9277020;
	Fri, 11 Apr 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400231; cv=none; b=ruCqC4dW3lhnnjyA5lD18s9XcD5O+Xmzu0inO0qFkoZ310r3EiTtpUN62d0WN2A5XWK2x6Q2I0jCKQEF003MzEbnpkv23Xq6+6euZ5kotujuWGDEUX46iFPix8ps4klDITv7N7xK/6RC9D81eO/WWjiL/X/KVPcTqY5VcN1Ec0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400231; c=relaxed/simple;
	bh=YHW+XTYVtG/PWwHSFCFDIMlxixyP18ghixjbBfXKENc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qa2uBRtfOxL7SilxKgXyhzFi2m9phYCixbvOHyjXt5tppgQ0rHCI1YQ18VDqH/2qlbdAxPd6FFg1l6Jpd3vTGNLSZ0K8t/H22iy1ovrUNeyhXo43g6zSY3/MZ2nbj4CH+CVcCH++K+fpWL+z32p9hc2n46A3FljZ6bbQbppmLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=z5Xj+3mh; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="z5Xj+3mh"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZZ6QD3c1Fzlvq7M;
	Fri, 11 Apr 2025 19:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1744400225; x=1746992226; bh=JoLaWsZ1YJpsW8YK4Nxv/ub/
	PCdEG//HtFwEC2IFQmA=; b=z5Xj+3mh4gRl5vVWgsQHR8wuqUrn6HKftyyzlrQN
	97LL1aDrB74cIOYCk4PTd+Ftza+E3mb7b0gRaIrk2mr1JTF9DZl7TZcYm2aL1voA
	fEjvs05z9ZcUIZD92N2madg9eQUuk7bvQEusfgc9s8B0OIby2ASir4IIHO/Cqyjc
	+Ys9ogELHVGN+reo8S4R5UF5GKtGnmZdE5sxAyWyWSevOmdwF07Wmz+D5IfqqLx3
	RuSB/agkPITGijaSxTox2WLL+tPglth26xbFe2NmfvKUwyBDmWTyT6LVd30PoOk6
	7TUV8JD5ZS7e6z15zxy8C0XCnY4lraRgO5tiKfLcKZO8pA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LHF9YpZ-hNQz; Fri, 11 Apr 2025 19:37:05 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZZ6Q50Lckzlnfx9;
	Fri, 11 Apr 2025 19:36:59 +0000 (UTC)
Message-ID: <319facaa-f3de-4cca-adf0-6916f30e8c7c@acm.org>
Date: Fri, 11 Apr 2025 12:36:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: aio inherit the ioprio of original request
To: Yunlong Xing <yunlong.xing@unisoc.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: niuzhiguo84@gmail.com, yunlongxing23@gmail.com,
 linux-kernel@vger.kernel.org, hao_hao.wang@unisoc.com, zhiguo.niu@unisoc.com
References: <20250411072816.445035-1-yunlong.xing@unisoc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250411072816.445035-1-yunlong.xing@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/25 12:28 AM, Yunlong Xing wrote:
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 674527d770dc..ed73627af3ff 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -447,7 +447,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>   	cmd->iocb.ki_filp = file;
>   	cmd->iocb.ki_complete = lo_rw_aio_complete;
>   	cmd->iocb.ki_flags = IOCB_DIRECT;
> -	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
>   
>   	if (rw == ITER_SOURCE)
>   		ret = file->f_op->write_iter(&cmd->iocb, &iter);
> @@ -1892,6 +1891,9 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>   		break;
>   	}
>   
> +	/* get original request ioprio */
> +	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
> +
>   	/* always use the first bio's css */
>   	cmd->blkcg_css = NULL;
>   	cmd->memcg_css = NULL;

Shouldn't the cmd->iocb.ki_ioprio assignment occur in lo_rw_aio() rather
than in loop_queue_rq() since the iocb is only used by lo_rw_aio()?

Bart.
