Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E4172BCF
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347522; cv=none; b=TnDrIztyn52Wgbf2l6yb/3JaL5AYds/obSO7/9YrlTXmaTMJR1fGOzUOp8v/ocsyrQTz5lXQqhagsGnFPvH3/+IO8b3ChM82HfeEPrTDFcXcs/QD/QTLtk+XcPqh90712q5isZuKBxFoZb8iTwltbKrcli/fZ4M4OJGOlYT+Gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347522; c=relaxed/simple;
	bh=qBp5DSqrTP1eme7CbDFjFuTz/8rhDiNAP+ZQiYa3Y2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDKYEhJLHUkJ1uNk1ih1nWodGtdG06ZRJHs+GfCAdj+hoXtWv7HBDk0geREXe1vfvn/fzCixD0HmCSx3jUUzwaG2GK/4UcAdbK/ieL7y2MGa9Ke/OaFxs5lr32w7qzJQckUdVQ/2lQ6ObQiMBURdzfxdAJJbvaeebeWsZibjn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zOghuoCm; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zOghuoCm"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VB8bz4hMKzll9bR;
	Fri,  5 Apr 2024 20:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712347517; x=1714939518; bh=2B7hahosA0QBjvBjGenwwVcw
	WPJPvb6Na/TPwzgSh0k=; b=zOghuoCmqk5OvFbaCICWSIHUATB9GFnx+opyTTNT
	PEK4STksnV/lM1PKL2b3fO+msmoBhZthIEPCoxg8RaXX9NyWE98h6wU9Yco7zHL8
	8lhq2qOhr3Vrf/KhbJ93EeKkqY2qaAT4Aov2Y0nPVYQgU1JJLEhaUYfCDTD33X4p
	OfDjcycjOUvzgLZyeg399/HphbObMnj4t3S+5PLmxCD0McSJy84M19BPwy8JGPu8
	n2SVqGfAmn1F45HqUsdUXPG1uutdAHZxz7jy4fYeuPGN78EtYMU21JboOsGOguhE
	dKFUz6INDH7dyLeTqe7hAPCIKV4fAIDVnvnXllBv72hZ4w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CMREySZq265a; Fri,  5 Apr 2024 20:05:17 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VB8bw4bL9zll9bQ;
	Fri,  5 Apr 2024 20:05:16 +0000 (UTC)
Message-ID: <a712785d-9441-45c6-a57b-6a35d802028b@acm.org>
Date: Fri, 5 Apr 2024 13:05:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Call .limit_depth() after .hctx has been set
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>
References: <20240403212354.523925-1-bvanassche@acm.org>
 <20240403212354.523925-2-bvanassche@acm.org> <20240405084640.GA12705@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240405084640.GA12705@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 01:46, Christoph Hellwig wrote:
> Calling limit_depth with the hctx set make sense, but the way it's done
> looks odd.  Why not something like this?
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b8dbfed8b28be1..88886fd93b1a9c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -448,6 +448,10 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>   	if (data->cmd_flags & REQ_NOWAIT)
>   		data->flags |= BLK_MQ_REQ_NOWAIT;
>   
> +retry:
> +	data->ctx = blk_mq_get_ctx(q);
> +	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
> +
>   	if (q->elevator) {
>   		/*
>   		 * All requests use scheduler tags when an I/O scheduler is
> @@ -469,13 +473,9 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
>   			if (ops->limit_depth)
>   				ops->limit_depth(data->cmd_flags, data);
>   		}
> -	}
> -
> -retry:
> -	data->ctx = blk_mq_get_ctx(q);
> -	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
> -	if (!(data->rq_flags & RQF_SCHED_TAGS))
> +	} else {
>   		blk_mq_tag_busy(data->hctx);
> +	}
>   
>   	if (data->flags & BLK_MQ_REQ_RESERVED)
>   		data->rq_flags |= RQF_RESV;

Hi Christoph,

The above patch looks good to me and I'm fine with replacing patch 1/2
with the above patch. Do you want me to add your Signed-off-by to the
above patch?

Thanks,

Bart.
