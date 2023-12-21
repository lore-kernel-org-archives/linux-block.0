Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165B53A1C
	for <linux-block@vger.kernel.org>; Thu, 21 Dec 2023 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rmTXVivq"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso93001a12.0
        for <linux-block@vger.kernel.org>; Thu, 21 Dec 2023 07:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703172300; x=1703777100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYQveJ1jD0cKNQUKWDB7XgI9CAkh4jcQs70cKoBqfeQ=;
        b=rmTXVivqslGhjDAsYD1CLMJZCL6LdK6aIfq0P5Q9+z0GrcOhffKkkaeCul9lfGQtzx
         +MIT2pcbe2P68x3RXa1eJBx74l12NSUTz8G3FD84ihxD7TgceXx6XTkfl1PSIpftfND6
         +/EOOUPHrWeQRiS/LFnQ84Af55/HPbnbTrzxsy1S3MisyVaAu3t6ECibeFCEwm3UGzKF
         1WTOB7tP/7cVQDI2VN59N0Z4KpLet9iP+26l5m7pO8Y9pgsAZ/Fu9X8QAXNYZ4CUrEdY
         EAo+St03dYDftLxFzyYTTgcsxpKIMCyU+ofjf7rgn9QVjU8romz1IMfB3MDsMvaioFp3
         K0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172300; x=1703777100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYQveJ1jD0cKNQUKWDB7XgI9CAkh4jcQs70cKoBqfeQ=;
        b=mswBb/7yNsVJBTm+1j1OCpMLOwUeq3tfFnM0PXcCsSu1z9mqg3KW2g4N0UDMvaUMhq
         qLoVTSpU7Ai7SVX6mmiI1czD5mvHqln0mTAAAPfA5y8rWA0Qeh5o0UwUoktEYmn3l3iF
         BnDWFhS9F3ZkAy+SLs9lJ9NqRPKDoRSeklUBQD/noOcGICRxdsTI83mhvHeCY2eTWQym
         8Q0hBc4Q9f1+K2rdz1dpI/iDrFzXfsv1YosT/ctyGhN7tfHa2jiGGAx0I23L8o0S/kuL
         1dghb8ABB1IwjeivNlxRUACYjMS/yEd6GyQwA1YOKm7Z0in2DOn4IGF0eE5BLmw/MbHh
         oEKQ==
X-Gm-Message-State: AOJu0YyVdGWM3hAntUzc2rCM6VhGb1Tn0Dc5Rgl8E1l3QXpAO4Po4XQ1
	Wx87qYGVdzfZoeVjeN3SNuZ4eQ==
X-Google-Smtp-Source: AGHT+IHHJCfGBT3Rs2txpxdbm1HOAQZb3RyKuDFU91acoYMz23YhzN9NSNdno2Q30INfofwDvrCO/w==
X-Received: by 2002:a05:6a20:f3a6:b0:194:957a:2247 with SMTP id qr38-20020a056a20f3a600b00194957a2247mr8931593pzb.0.1703172300566;
        Thu, 21 Dec 2023 07:25:00 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id k24-20020a170902ba9800b001acae9734c0sm1747110pls.266.2023.12.21.07.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 07:25:00 -0800 (PST)
Message-ID: <b84b6321-137b-4783-9e76-c644bdb0e01b@kernel.dk>
Date: Thu, 21 Dec 2023 08:24:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: skip start/end time stamping for passthrough IO
Content-Language: en-US
To: Kundan Kumar <kundan.kumar@samsung.com>, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <CGME20231221111858epcas5p46c3bf66f33df8652d2da966b3ecbfa60@epcas5p4.samsung.com>
 <20231221111221.4237-1-kundan.kumar@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231221111221.4237-1-kundan.kumar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/23 4:12 AM, Kundan Kumar wrote:
> This patch will avoid start/end time stamping for passthrough IO.
> This helps to improve IO performance by ~7%

This commit message needs to explain why we don't need to do
timestamping for passthrough, rather than just say what the win is.

> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 1ab3081c82ed..04617494db7e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -830,7 +830,8 @@ void blk_mq_end_request_batch(struct io_comp_batch *ib);
>   */
>  static inline bool blk_mq_need_time_stamp(struct request *rq)
>  {
> -	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_USE_SCHED));
> +	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_USE_SCHED) &&
> +		!blk_rq_is_passthrough(rq));
>  }
>  
>  static inline bool blk_mq_is_reserved_rq(struct request *rq)

I feel like this would be cleaner with a bit of separation:

static inline bool blk_mq_need_time_stamp(struct request *rq)
{
	/* comment on why passthrough is excempt */
	if (blk_rq_is_passthrough(rq))
		return false;
	return (rq->rq_flags & (RQF_IO_STAT | RQF_STATS | RQF_USE_SCHED));
}

or something like that.

-- 
Jens Axboe

