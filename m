Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471F1F428B
	for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261282; cv=none; b=n6i4Zw+1ErbMUZCO+b03bmHSvbwhnxGXboYCpvwr1Gy1uByEQJwRT0yAn/egV2YBalzxrLRf/7Tjzu64m4rN/oBcLfO/Eo5iZTtnIYGooM9soxj0WUHgE8h+6u2bckkv/XNjO+yFKABZvm2UioZDt0zJj787cYK1NMfU3J3Drqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261282; c=relaxed/simple;
	bh=xHybtiKyTxNA1jI8buXYvXG734IlXSdiFFZRHOOaxdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruooiSH9uhbDmS2/YY0vyuumnsizS7iiVCyxQapJKjXRNxUI/0NcuDBMJ/ZBkY1NrTNXsGswJFm+aSWQQw4BJrnD4kS1mT+tHyBE8IIYtlyoLX829fnIT7XN1kpPTaX2CQl3CJAWWhViUTk4UvGp28MCT0wJ3XDq0vfjoaalVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gf+2gEda; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gf+2gEda"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-208cf673b8dso22398355ad.3
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729261279; x=1729866079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxkU0SurZ3ytvyybPNhQLE8bgWu3q/xADixl58fl7SE=;
        b=gf+2gEdauu4iblVqH0Q8ixqqzmkR672MxZGaEGuTwcUofb3qD9OVe+U1LH3DZwNaO0
         UWvOQy7hB5rFSqc0EPKKSN7pcjHfKFuZa8U/3W30/f5wXyagc335BEcfwFf/9erOTTch
         iwX0sNKBTkKdc0I0GBvvZ5QSpKhZg1gGZlMth1KWytRbNeqWd/CiztxeORbF5ldViAWY
         TNkzfpizE+5b1eDVHhpusX79DPKwugtZ3EUJGwOUjpCTxCcR6FADs6dNDZC//T8p3kxf
         TawCxxvASl1gP/v9cBQJ32yNL0KuxNEcJ/IMPaNBLVVmETArdLZ5islYnuesfT85GO3v
         +ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261279; x=1729866079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxkU0SurZ3ytvyybPNhQLE8bgWu3q/xADixl58fl7SE=;
        b=emABPPfzcmxUz6utnAttPds32K690gZjJb4iJAvJGnj5EWQb/loAECCnc3IovWaqmw
         Izm1RH2nU3UiKehat/HjT2sz98q9i1FIp+5i/QI2Gv8xNta4zJfYonKAwOjeLiqJOTTf
         raUXJbyKOyQgic9et41D6fbLgoxN+wuK8eG6dHGk03HfcuFbidHxAdb2ek3UV10AdW6Q
         VBAT6lrLjvrCiIfNzBqTAsJ57MV5Befqyniz4XUTmReyIEaA+NPKMrSW4OxpnRLJnEpN
         6dIJYCAK1tboVADQXyTHSb5a0WMpO+7FKG9Buy1J05ySnIjmrzSo3VqftaYkPd9E2xwq
         NRZg==
X-Forwarded-Encrypted: i=1; AJvYcCX0XQNvOkT7alN+c6mhA6T/oRTM9RAM/TSEtwfb5HaylRan3YpZlD7yL5CJ1FZshoOik9y1NFqpUnp9fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxixWACYfCjEL4Q4+yY8MC2t0RGklk7/WiN4sk21RmBjT3c4GAn
	jD+xDQWMv1vtX5E8nyta4RAJD9HmCl6WTRRJgeV0lJjIZBFaZusphfKKUqTkD5vkx/xGMD8aZDm
	S
X-Google-Smtp-Source: AGHT+IGZk6UCrT0VIMAN6pIiPBhEinc4i35+NJcdRK7GjNJnOyc6aLd4dZkz49tcq67yLWma6DwkOw==
X-Received: by 2002:a17:903:234b:b0:20c:fa0b:5297 with SMTP id d9443c01a7336-20e5a78e147mr33139555ad.26.1729261279129;
        Fri, 18 Oct 2024 07:21:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8f9f34sm13138225ad.235.2024.10.18.07.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 07:21:18 -0700 (PDT)
Message-ID: <cb9d65fe-47b9-4539-a8d0-9863e8ebf49f@kernel.dk>
Date: Fri, 18 Oct 2024 08:21:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] blk-mq: add support for CPU latency limits
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241018075416.436916-1-tero.kristo@linux.intel.com>
 <20241018075416.436916-3-tero.kristo@linux.intel.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241018075416.436916-3-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 1:30 AM, Tero Kristo wrote:
> @@ -2700,11 +2701,62 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
>  static void __blk_mq_flush_plug_list(struct request_queue *q,
>  				     struct blk_plug *plug)
>  {
> +	struct request *req, *next;
> +	struct blk_mq_hw_ctx *hctx;
> +	int cpu;
> +
>  	if (blk_queue_quiesced(q))
>  		return;
> +
> +	rq_list_for_each_safe(&plug->mq_list, req, next) {
> +		hctx = req->mq_hctx;
> +
> +		if (next && next->mq_hctx == hctx)
> +			continue;
> +
> +		if (q->disk->cpu_lat_limit < 0)
> +			continue;
> +
> +		hctx->last_active = jiffies + msecs_to_jiffies(q->disk->cpu_lat_timeout);
> +
> +		if (!hctx->cpu_lat_limit_active) {
> +			hctx->cpu_lat_limit_active = true;
> +			for_each_cpu(cpu, hctx->cpumask) {
> +				struct dev_pm_qos_request *qos;
> +
> +				qos = per_cpu_ptr(hctx->cpu_lat_qos, cpu);
> +				dev_pm_qos_add_request(get_cpu_device(cpu), qos,
> +						       DEV_PM_QOS_RESUME_LATENCY,
> +						       q->disk->cpu_lat_limit);
> +			}
> +			schedule_delayed_work(&hctx->cpu_latency_work,
> +					      msecs_to_jiffies(q->disk->cpu_lat_timeout));
> +		}
> +	}
> +

This is, quite literally, and insane amount of cycles to add to the hot
issue path. You're iterating each request in the list, and then each CPU
in the mask of the hardware context for each request.

This just won't fly, not at all. Like the previous feedback, please
figure out a way to make this cheaper. This means don't iterate a bunch
of stuff.

Outside of that, lots of styling issues here too, but none of that
really matters until the base mechanism is at least half way sane.

-- 
Jens Axboe
