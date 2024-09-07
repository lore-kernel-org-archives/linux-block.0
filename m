Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A014C5A7
	for <linux-block@vger.kernel.org>; Sat,  7 Sep 2024 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725716789; cv=none; b=H3pGcWQAnM0akIAEfhtVJOvPchH2QBhG5Bl8iElUVPK4OFQ/9gfYu+ONK727UTOBPI198qbQsjeuROKFIyyKN7vdJGl/MYI42fYdELGCF+ff/GTp43wakvCJDz+BVW7ZYj/oAUhj+Dk8pJzZqhBlVzA9LDuhwIHwepyuvZIDh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725716789; c=relaxed/simple;
	bh=jC6eaEVaUgtHevOaNW5Npt0yuoQ+IKgQGTXS/6VL5l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L69TgFNulfk6wrDl5dO1I23CDj1V3pciJ/r/Q3JZsr0KF0MiJt1X6B+XHPXqspGQXjXkTnLeOYRhQjVXcaRLP/f85JyKw+2qt85flHb8Q1T0ssq5Z+uP072nVxJzjlMRBm2aZ9q/J8Dj/gTuiB0esa6/hjCJ5oADZksiuW6G/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d7vwSeAS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d7vwSeAS"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718d6ad6050so1278377b3a.0
        for <linux-block@vger.kernel.org>; Sat, 07 Sep 2024 06:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725716787; x=1726321587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKQCeQuyzhcW2EGOCYxUzY2nkSFp5q+ZqrKGkSxVdoM=;
        b=d7vwSeASvql7yNw7RJ+lUyaBVbtv+2OQM8PhLUcKWMRpxKI11tufshh9O+REebZuja
         TgK7vYRHizjfO2/h7hrer/bkoTSRA5tQTLYzRrYafpxEv9g9Xfg951f6YUnEoxQ/CDFj
         VZTXD/BBBzyUXSEsR6ph3zevW/O+peC0F5KCtz6L5l6I8cXzfFwJYAFpoDWMR8KnH//n
         EfWjBEmv4hEUK34vEELmK2zZNMoRZ8IfE7ND7gv2shDckyoMLjBAZPAizFA+IoX5ylVc
         Hr+3x/mecDnSVTkxmiI+01sigC+jFktayuPWgN6f54l1mdX/u3NTX55YHDcbE273WFb7
         OECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725716787; x=1726321587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKQCeQuyzhcW2EGOCYxUzY2nkSFp5q+ZqrKGkSxVdoM=;
        b=mprAZVEltd5utzpv8U5UFDPTI42LX6IAv7fDfH4hhN2QkL+7tqnIYsH/Cq7TJGUEqO
         BWJmufz1+hWRWlfmtGJyD9E7ZMqmCb5khzwKeHZPWfw0nBs+9XJRDVdNKyZD1CnqF+jG
         /YoM4g2uMevFTOl3fss7nBnsZndm2xSOVGvBP6i+lo93dMwG6WO4UiK0pT2YIdQUe4Z7
         Zh21X4g/XtR50eC+63bC8LJ5KhMcd4xXpxMrCJF6zFAz4c7sb9jfSP0pcbo5vziuy+Em
         peKCKYEyD/s2OYmS16dNJJHaeq9s1XFTWnIMsXjeZy5YuhQ+B78odp6lKiEoDtE6K/e7
         zE5g==
X-Gm-Message-State: AOJu0YyHFGPWbug9XU2d7SLLy1nZw7UPgBRV97+X5gUQj/2qXYkvNaTj
	7RYQ8xh9g1XcqC/SdHAW4LogYs4kaOZDIpBcOGwMmI2bz7wKJ3MyYUSaxTKBiyk=
X-Google-Smtp-Source: AGHT+IE6uE37wAuU+Qa8T3FQhdmjWcRErvMn2sQsvQu6TnaKx5AlJSuIz5qsqbq6z95mLsPrE9nXJA==
X-Received: by 2002:a05:6a20:db0c:b0:1c4:8291:e94e with SMTP id adf61e73a8af0-1cf1d1ef82dmr6834087637.45.1725716787064;
        Sat, 07 Sep 2024 06:46:27 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5896537sm897885b3a.3.2024.09.07.06.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 06:46:26 -0700 (PDT)
Message-ID: <38a71a3f-b505-48a3-bbaf-2bdf60dfcd9d@kernel.dk>
Date: Sat, 7 Sep 2024 07:46:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] block: move non sync requests complete flow to softirq
To: ZhangHui <zhanghui31@xiaomi.com>, bvanassche@acm.org,
 ming.lei@redhat.com, dlemoal@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240907024901.405881-1-zhanghui31@xiaomi.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240907024901.405881-1-zhanghui31@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 8:49 PM, ZhangHui wrote:
> From: zhanghui <zhanghui31@xiaomi.com>
> 
> Currently, for a controller that supports multiple queues, like UFS4.0,
> the mq_ops->complete is executed in the interrupt top-half. Therefore, 
> the file system's end io is executed during the request completion process,
> such as f2fs_write_end_io on smartphone.
> 
> However, we found that the execution time of the file system end io
> is strongly related to the size of the bio and the processing speed
> of the CPU. Because the file system's end io will traverse every page
> in bio, this is a very time-consuming operation.
> 
> We measured that the 80M bio write operation on the little CPU will
> cause the execution time of the top-half to be greater than 100ms,
> which will undoubtedly affect interrupt response latency.
> 
> Let's fix this issue by moving non sync requests completion to softirq
> context, and keeping sync requests completion in the IRQ top-half context.

You keep ignoring the feedback, and hence I too shall be ignoring this
patch going forward then.

The key issue here is that the completion takes so long, and adding a
heuristic that equates not-sync with latency-not-important is pretty
bogus and not a good way to attempt to work around it.

-- 
Jens Axboe

