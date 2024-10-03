Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1ED199397
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961585; cv=none; b=JhgJTwaqBYKJIYiO3UEzeorXXVn3kWJeArguVNtycYrdLOW8OqStVZ1CyD3e+xoxkvtlUFjGP2zg9E1DyWc93ChVMjfxZyeNmAyUe+x4NtmmNEuX+MI9LKs9N8ZWM8SFVvflT8A8cwVEpG4kfSKirLqOTGkvoJ9mGQ3aiSvQNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961585; c=relaxed/simple;
	bh=zEb6a1QvZoqzNEtpcnL5thUH9mK5tyo1QgQ2a1ZjwzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWt1m84KOm/vy0CVznrh+ufKjcceGGlFhxN6E5y1qFPvnXYmeaCFFsGBUPKhT39C0f1D8mROMs4sUhNbDZTgXNCY/1HZdiE8kMEe+2+bmbQLwWmw/avI7SoI4c7C1USVRDS1GQkx1q4b0s6K1jU0Su0YEdMzvRM6aPo/hJMcL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yJsantDn; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yJsantDn"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82d24e18dfcso43676039f.3
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727961582; x=1728566382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ksledoz+0tCyRkg6dZBWZTFYrHLsLVD+KPBfYyEgYsU=;
        b=yJsantDnPe+Ksj1SRqxZIsMdLQ1fL4HoE4n1JeUN/i/ZvTj7jCFr9zj8SpRDuMPZmh
         oTuJvZQQS7du/wh+ETsY78eOZMI9D5Ipf5gb/1X/zpKNs8hSbqhnTv+/NDNw1TDIpD5E
         P1dQj+mr13hgtzW0EB609LwqsVr7WcZnJojlvMC6yHsLS670Vs2CsfDV3XtO2QZvjGOi
         PMOPHrxZihPvV3XO8ICgjE9wwv43r+p2Vfmne1IGfI05eJSxQZ5GHkMH5qT784IjtmAi
         klg7nGIQWnU35wZTQSHYIqJ19HVT7XyabpGfg5+HrLZBqjnTDjdJz4ykxMykHD3R2uUy
         2qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727961582; x=1728566382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksledoz+0tCyRkg6dZBWZTFYrHLsLVD+KPBfYyEgYsU=;
        b=DV1gl/5okuyzfvqRiFmuAIjZgPrNaAAo14zsDwWQ5D27D1MuPFt7RR9XBcXNR9kGg9
         kZiJ1UIFHuiuLY/FfgQC3v3nDHd1hzpWBl9A+R2XilAEpWtzOIMVmOQPz4iKgyjqKcS4
         nHuIcmj941dE/kqt8VgmaEAXTkhMOlQRJOStkdi+V+4lWcztDL71cq7SuhRgurcsegs0
         4EDUcG1VoU40BHy6un37dAfM7S8+bB6TaUZBHEuIg5yIuXAAw/B9nGZfW6PRMpsU6zYw
         X/eWr2updTHrdL9h4I6pdi+tvhHdkMTkGCItdJtT4kF1YPOJ8M81QXxBzX+gO+4NT9i6
         sXCg==
X-Gm-Message-State: AOJu0YwKeqv5NAlhEhMmLXT2RxrWDIM+0TFbtJzqyl81wCQaXjiePp0i
	Co3BD5wcMI9D8ZWmmpHIiOIWHEvfY3PaBffC7hVBEgQLr0YSmB/YEoqSl1+g8FOljKdDsLyaee+
	0U80aPA==
X-Google-Smtp-Source: AGHT+IHgJIGLrfkkKi5vJWqHGlsDFAxA2ea+j9r0KS7N+MGOu6xV4VcsMs4xssx1qX6Dhk6tR4CPoQ==
X-Received: by 2002:a05:6602:1615:b0:82a:a4e7:5544 with SMTP id ca18e2360f4ac-834d8440a47mr651238939f.9.1727961581917;
        Thu, 03 Oct 2024 06:19:41 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55ad6608sm264952173.171.2024.10.03.06.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 06:19:41 -0700 (PDT)
Message-ID: <80ddb9f2-af29-4489-8985-8ba9588e5891@kernel.dk>
Date: Thu, 3 Oct 2024 07:19:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: move iostat check into blk_acount_io_start()
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <550fc8a0-3461-49ac-879e-32908870f007@kernel.dk>
 <Zv6XkXyAQ4yiaJGE@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zv6XkXyAQ4yiaJGE@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 7:09 AM, Christoph Hellwig wrote:
>>  static inline bool blk_do_io_stat(struct request *rq)
>>  {
>> +	return rq->rq_flags & RQF_IO_STAT;
>>  }
> 
> I'd kill this somewhat oddly named wrapper now that it is a single
> check.

Yeah I did ponder that, since there's just that one check left. Will
do a followup for that.

-- 
Jens Axboe

