Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324113F003
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952581; cv=none; b=Z+YPhzrCslV3ZpMqniXWZ0pHKk5yDDjcOohBCLj5Tus+pSVJCz7UFrauZhQtgOAIjhNE8tJPBeAVMyM3TkF/FT9spBMylDdvzp8/6HeN/Z6zdSLmJFp8pTprRWMXqO2h21uQYo0rWeYjw1A1904S1ZdjzylM23a988xxkpvzcUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952581; c=relaxed/simple;
	bh=WLPjJ8QmGm2nLRNm1y8f/NBBqzZnlfSv+jM1qew4lMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTR9BXbDCMEJztFkmZ6+73W4J5XKJjkKaCIbrfolu8CFB4tR9TTl5qkd8WPd3Xk5JmJQsrb83rBWB5pgtnWRvozdnCs9X6baetuJNbzVPIjjRDZXbjbZuKn2M1V2UFlsfFq965WIsrSrZ5Van09UXcKAEAbYGZNmxOso42C9KuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvaa4pdh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvaa4pdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52000C433C7;
	Wed, 14 Feb 2024 23:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707952580;
	bh=WLPjJ8QmGm2nLRNm1y8f/NBBqzZnlfSv+jM1qew4lMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uvaa4pdheiB12+E8EVUEu0UHyIeWpoWLm5sKXv9UOCAcURRWUYj0SOKRI5gcRIoDS
	 KIAIIp000KYOCVh5iU4AliRnXgjrZ4XGF2KB3l4KlY4B2bjh26yVP6JLu9hXDLOYTB
	 ZLtjWA1tX8H5oaFAxPuExF9LumSE3Xdn+9Zxg598k2RPYH1k/ouuEpBNsh5WyLoW//
	 gWBhfCXJmwGNiSNpqHNjvgW7bfQNnFnVJ5RqJVcvkiuCvJqOuCjSbugsHZaWEsIT/J
	 0mbzj+ctpSAM/DDpjt7dkIOJrI/J34AJ5qZ+BFPdQVbTfY87+MP+tku7/JvjeAYNNq
	 Ib4WRniiUJicg==
Message-ID: <0a5497e2-87f1-481a-9948-bd9e68b3bb79@kernel.org>
Date: Thu, 15 Feb 2024 08:16:19 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] null_blk: remove the bio based I/O path
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240214095501.1883819-1-hch@lst.de>
 <20240214095501.1883819-2-hch@lst.de> <Zcz3pd3A09dJScHH@kbusch-mbp>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Zcz3pd3A09dJScHH@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/15/24 02:25, Keith Busch wrote:
> On Wed, Feb 14, 2024 at 10:54:57AM +0100, Christoph Hellwig wrote:
>> @@ -2036,11 +1813,15 @@ static int null_validate_conf(struct nullb_device *dev)
>>  		pr_err("legacy IO path is no longer available\n");
>>  		return -EINVAL;
>>  	}
>> +	if (dev->queue_mode == NULL_Q_BIO) {
>> +		pr_err("BIO-based IO path is no longer available, using blk-mq instead.\n");
>> +		dev->queue_mode = NULL_Q_MQ;
>> +	}
> 
> Seems pointless to keep dev->queue_mode around if only one value is
> valid.
> 
> Instead of checking the param here once per device, could we do it just
> once for the module in null_set_queue_mode()?

We need the check for the configfs path as well...

> 
> ---
> @@ -134,7 +134,7 @@ static int null_param_store_val(const char *str, int *val, int min, int max)
> 
>  static int null_set_queue_mode(const char *str, const struct kernel_param *kp)
>  {
> -	return null_param_store_val(str, &g_queue_mode, NULL_Q_BIO, NULL_Q_MQ);
> +	return null_param_store_val(str, &g_queue_mode, NULL_Q_MQ, NULL_Q_MQ);
>  }
> 
>  static const struct kernel_param_ops null_queue_mode_param_ops = {
> --
> 

-- 
Damien Le Moal
Western Digital Research

