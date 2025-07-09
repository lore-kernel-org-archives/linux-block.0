Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F68F40
	for <linux-block@vger.kernel.org>; Wed,  9 Jul 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075069; cv=none; b=rjL4PMwKYjhGKDgwDtrPG68McCEAVdBw8+XLsLsaK6P+5++rCcytUzRtI68ipl29r3vnvyRQs0FGoi6vUC9UVVOqtqwY091RgX1aXoxlse/A0/r7K4tEa6EoEpKz4SsosqRqxIRFdhl+cFsdJNRLYQGgG2Ct5Sk5VJwR+SSsyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075069; c=relaxed/simple;
	bh=dU+Ved/g5d7SCrq1W+opf0g98wicJCdou66CkHAxarU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxT0BG2W/+YodG0/QDa4+ivYbGwihY1hoWVgXU1hwEsYkCWyY44BPZz5nhRo7b3T2dr2njjRJ+ITaVK0Uf1wqWij17hPDgp6nRfi9237CmT78bdVXoXgBuMNMzJtqPO63NjM1JBLum/VGzj3xT0U8hhJkf4fP4z+auwa6K085mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=USWsGdZd; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="USWsGdZd"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bchlG27kLzlgqV5;
	Wed,  9 Jul 2025 15:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752075064; x=1754667065; bh=6qDxA14Cpzy36gs4e9lfBoOY
	dFYUxIHYbk3l+DK5sf0=; b=USWsGdZdY8hjer2hCLwDdXZiLGri4jpTE0w7leX+
	sDwlwQSRruj0iN+UzQC5Xl+8fUDbAq83cgp1ZXIU3ZtLSt83A1PDVUG68ijsuzwr
	/tyXgZ/uDWnombDS0vFQUPmfOyIC9kl5EgCsUYWbNMfuE3CrU7CMJAc/i8pPR5PJ
	7ofwnnBWMT+laD7wAaDQwRQ8xS6kNTvPWBmMf8TFhpo8tQpXWZvXsV8aMZT9FEU0
	jl/uNny9AQ/y9IvN5MVOkuCgvbg/ATUqplqhm5bhtNStmKGzFiIQOX2kIZmE/2e8
	vKqtiJ4ZqgForAvcgobXWWvReyTVdYka0mGPrvsn9uw7oA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aFQUVxwpWrsX; Wed,  9 Jul 2025 15:31:04 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bchl71vnhzlgqV7;
	Wed,  9 Jul 2025 15:30:58 +0000 (UTC)
Message-ID: <de8c6c73-3647-4cc7-a8a2-6848b2f4607e@acm.org>
Date: Wed, 9 Jul 2025 08:30:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-2-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250709114704.70831-2-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 4:47 AM, Johannes Thumshirn wrote:
> Add zoned block commands to blk_fill_rwbs:
> 
> - ZONE APPEND will be decoded as 'ZA'
> - ZONE RESET and ZONE RESET ALL will be decoded as 'ZR'
> - ZONE FINISH will be decoded as 'ZF'
> - ZONE OPEN will be decoded as 'ZO'
> - ZONE CLOSE will be decoded as 'ZC'
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   kernel/trace/blktrace.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 3f6a7bdc6edf..f1dc00c22e37 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1875,6 +1875,27 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
>   	case REQ_OP_READ:
>   		rwbs[i++] = 'R';
>   		break;
> +	case REQ_OP_ZONE_APPEND:
> +		rwbs[i++] = 'Z';
> +		rwbs[i++] = 'A';
> +		break;
> +	case REQ_OP_ZONE_RESET:
> +	case REQ_OP_ZONE_RESET_ALL:
> +		rwbs[i++] = 'Z';
> +		rwbs[i++] = 'R';
> +		break;
> +	case REQ_OP_ZONE_FINISH:
> +		rwbs[i++] = 'Z';
> +		rwbs[i++] = 'F';
> +		break;
> +	case REQ_OP_ZONE_OPEN:
> +		rwbs[i++] = 'Z';
> +		rwbs[i++] = 'O';
> +		break;
> +	case REQ_OP_ZONE_CLOSE:
> +		rwbs[i++] = 'Z';
> +		rwbs[i++] = 'C';
> +		break;
>   	default:
>   		rwbs[i++] = 'N';
>   	}

Has it been considered to add a warning statement in blk_fill_rwbs()
that verifies that blk_fill_rwbs() does not write outside the bounds of
the rwbs array? See also the RWBS_LEN definition.

Thanks,

Bart.
