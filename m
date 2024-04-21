Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC438C
	for <linux-block@vger.kernel.org>; Sun, 21 Apr 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713695491; cv=none; b=CQqHbhfI9HmhQL6JqLYZvTN8zpDttb6Ly5Jof90ozNWPGZyWFQAf8Vc5rjhHdpB8i2/b58g8ZPZApDoVFproovwOB7RMvDz2tfE800hfO1enkn9UzN+lxcJVJkh7KhXdHVcwtJwz5zPz+XGjH9krgCXGsM6DdaltIvYQNe2ccU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713695491; c=relaxed/simple;
	bh=46+KsbtoZpc+f0wCgYIYpjd01JpJw+2+O6qfuGc14+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBHcWkpu+pXa/EQlcYkhT1DbXhY3EIN+tzfJf627EXsIY/47OpSPYpZo9/+IR5zV2tuFEsBrBQABfdEzZ1jBf4SexIGHtW9MaApnFWp5YXZRSdkJ75iuvBPlnkv1rGjh1Ca2GwvCeIcKb0nQ82AyxPpWOMjFVPUAepsHtL3i3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-349fd1d3723so720444f8f.0
        for <linux-block@vger.kernel.org>; Sun, 21 Apr 2024 03:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713695488; x=1714300288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GszQgQpzUTRi5dJxCQXi4tBvNXzSdoVKhpu21Kn30yM=;
        b=KpYFLl92jzkK+sIiRzv1L5atP9M53s3tFlnCpHW6caIGhGb1ZGc4v1c24ZTUcR4hQc
         rdFEp6pBvHSVDJ1Df1+6jufNHWodcYSJFlJtUzO0XX1JtflEbZBU0Emu0xYtP7rOOidr
         AGhJt5T7IkaydZz5tD+1Q450z65v2osps26hIlaE8e8DP271SZ37jGsEEoHGAb21n6TZ
         n4jFCGD/BDqoazCVLS3vd1n0WmGjYVxMSjMLKHr/HwBeVpJ91GbUN56PMPbgy1R+fXZO
         xbl0DIj/w557WdjQepOapQ1gjK9ALAU/y63715oYOva/ngNu9ylq7zNQKUmhQPyQvi3d
         ws5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV93aWqgTHw798COM8t6gadC2p2lL8fW5UhwG6LENQ/yEM7qgWjOOzOrnD+3RZnHNIHkKn4JWmitohnbXUBi/s3BPWClzIsno+KTfU=
X-Gm-Message-State: AOJu0YyglVAQrj68dZJ1TIgVqzamW7EfP8H3SsLnjNRfO2Y1rzyQi8xR
	bER6bxxgsko6D5hVV0KNcUus2En1EvWoFbfnxM8FSF5LHtd/j0OC
X-Google-Smtp-Source: AGHT+IHHsQNnARBtgBiA47qYmYz+T9oXZgOmuinv8K61cf/j6tm3LWYbhboL1FrG6iEexKpWPv51sQ==
X-Received: by 2002:a05:600c:3b09:b0:418:ef65:4b11 with SMTP id m9-20020a05600c3b0900b00418ef654b11mr5410497wms.2.1713695487651;
        Sun, 21 Apr 2024 03:31:27 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id fl14-20020a05600c0b8e00b0041a25e1e2fcsm1998202wmb.20.2024.04.21.03.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 03:31:27 -0700 (PDT)
Message-ID: <ede49e66-7a0a-472d-a44c-0c60763ddce0@grimberg.me>
Date: Sun, 21 Apr 2024 13:31:26 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak observed with blktests nvme/tcp
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Yi Zhang <yi.zhang@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CAHj4cs8xbBXm1_SKpNpeB5_bbD28YwhorikQ-OYRtt9-Mf+vsQ@mail.gmail.com>
 <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/04/2024 6:19, Chaitanya Kulkarni wrote:
> +linux-nvme list for awareness ...
>
> -ck
>
>
> On 4/6/24 17:38, Yi Zhang wrote:
>> Hello
>>
>> I found the kmemleak issue after blktests nvme/tcp tests on the latest
>> linux-block/for-next, please help check it and let me know if you need
>> any info/testing for it, thanks.
> it will help others to specify which testcase you are using ...
>
>> # dmesg | grep kmemleak
>> [ 2580.572467] kmemleak: 92 new suspected memory leaks (see
>> /sys/kernel/debug/kmemleak)
>>
>> # cat kmemleak.log
>> unreferenced object 0xffff8885a1abe740 (size 32):
>>     comm "kworker/40:1H", pid 799, jiffies 4296062986
>>     hex dump (first 32 bytes):
>>       c2 4a 4a 04 00 ea ff ff 00 00 00 00 00 10 00 00  .JJ.............
>>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     backtrace (crc 6328eade):
>>       [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
>>       [<ffffffffa86a9b1f>] sgl_alloc_order+0x7f/0x360
>>       [<ffffffffc261f6c5>] lo_read_simple+0x1d5/0x5b0 [loop]
>>       [<ffffffffc26287ef>] 0xffffffffc26287ef
>>       [<ffffffffc262a2c4>] 0xffffffffc262a2c4
>>       [<ffffffffc262a881>] 0xffffffffc262a881
>>       [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
>>       [<ffffffffa76b0813>] worker_thread+0x583/0xd20
>>       [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
>>       [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
>>       [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
>> unreferenced object 0xffff88a8b03647c0 (size 16):
>>     comm "kworker/40:1H", pid 799, jiffies 4296062986
>>     hex dump (first 16 bytes):
>>       c0 4a 4a 04 00 ea ff ff 00 10 00 00 00 00 00 00  .JJ.............
>>     backtrace (crc 860ce62b):
>>       [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
>>       [<ffffffffc261f805>] lo_read_simple+0x315/0x5b0 [loop]
>>       [<ffffffffc26287ef>] 0xffffffffc26287ef
>>       [<ffffffffc262a2c4>] 0xffffffffc262a2c4
>>       [<ffffffffc262a881>] 0xffffffffc262a881
>>       [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
>>       [<ffffffffa76b0813>] worker_thread+0x583/0xd20
>>       [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
>>       [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
>>       [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30

kmemleak suggest that the leakage is coming from lo_read_simple() Is 
this a regression that can be bisected?
