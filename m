Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C812B66
	for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kUlbguWY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3b84173feso14636725ad.1
        for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 08:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703868770; x=1704473570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSNSWnuaXWoD96pZfJRvHlzqw6OfFPh5yR+M67iO49I=;
        b=kUlbguWY7v2RnOcvb+MFg5wRvScaqr2iM03/jLZEbjgvZUaKLThvjZxUJVc2tn4p0p
         yOmeayFWrHFI1lXFExP44SIkYBvGc4TtYQ30GAAyq7ZPNAffa76JqBh2EO00jWoCEj6E
         95O7ML3RFmVvlT02OY+S6GYYiN6hsXbOtkUsAwCp/3A0TvV/u9P3FYD9UDZNGKf+yEJX
         a69KEMd+kP6Wg9SQYr1XwjKDttPC5YlvR0BtWk1OM+BxqE3cYlr3mJluNpbkawIrGOcf
         TTSj+AFzbpSnusYVdqPS8AUrjalwm7DwQgxq1XACcq2hM6rL2sPZyAtPSogeuHU/8bBb
         o0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703868770; x=1704473570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSNSWnuaXWoD96pZfJRvHlzqw6OfFPh5yR+M67iO49I=;
        b=e4dZQudKOYxUV/8R2aVWqxlF5gO8+5Yy9FXXWfZwceSad40zEWi2AMmcHdNpcsvYTo
         8gqCWwYoQDzsOyqcullLVaocYa7/cC97f0ZVdKm7MFgHnU512zCZ8vNBLUFtAt9VJXPj
         c5LRPFtgWqxp4/sImr5lzjXJazMhZUX5UtSYcqv6JUOx0qqIAUvYnX56QbU2VeoO3yec
         RlDWHs7yub3Fy8Ty1tdgMM1MWTXZNPwEHT2nFBXPROZN5x1RMZkAkWKB3rOhOOWZ2AVL
         i/ZD/5UoeykMcRB/GPMfkKC/oYyNQAnIFsTfL478UD1T2jIiGF8UdL6Sp43SL+LpEvEO
         Jd4Q==
X-Gm-Message-State: AOJu0Yz6orAcloEuotXCXbBuVh5VLXEO15jKbpYV0Pm9kVCOiBslroLy
	sLRPYNkjHh6Eb2u8SQqP9DTuOHRsTrfYMO4ybYbqnpRX80c0aA==
X-Google-Smtp-Source: AGHT+IGiSo6gfL6F95WOAnfesLOgRyGsedXwl+rlko3RNnUsSMwbXGkaPtrt/okfz5sK3yB1/MkqyQ==
X-Received: by 2002:a17:902:ea06:b0:1d3:f36a:9d21 with SMTP id s6-20020a170902ea0600b001d3f36a9d21mr25302192plg.4.1703868770057;
        Fri, 29 Dec 2023 08:52:50 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d3cb4e3302sm15220806plb.214.2023.12.29.08.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 08:52:49 -0800 (PST)
Message-ID: <f1f002e9-8010-4b74-9da8-2551be97fa6f@kernel.dk>
Date: Fri, 29 Dec 2023 09:52:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/block/null_blk: Switch from radix tree api to
 xarrays
Content-Language: en-US
To: Gautam Menghani <gautam@linux.ibm.com>, kch@nvidia.com,
 ming.lei@redhat.com, damien.lemoal@opensource.wdc.com,
 zhouchengming@bytedance.com, nj.shetty@samsung.com, akinobu.mita@gmail.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 riteshh@linux.ibm.com
References: <20231229164155.73541-1-gautam@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231229164155.73541-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/23 9:41 AM, Gautam Menghani wrote:
> Convert the null_blk driver to use the xarray API instead of radix tree 
> API.
> 
> Testing:
> Used blktests test suite (block and zbd suites) to test the current 
> null_blk driver and null_blk driver with this patch applied. The tests 
> results in both the instances were the same.

What's the purpose of the change?

One thing that always annoys me slightly with xarray is the implied
locking. So now you're grabbing two locks rather than just utilizing the
lock that was already held. I think a better transformation would be to
first change the locking to be closer to the lookup and deletion, and
then convert to xarray and now being able to drop that other lock. Just
doing a blind conversion like this without potentially understanding the
details of it is not a good idea, imho.

-- 
Jens Axboe

