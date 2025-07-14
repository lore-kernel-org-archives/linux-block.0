Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2D1F19A;
	Mon, 14 Jul 2025 05:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752469311; cv=none; b=XmTnMZesm/0JLyDJnl9tYnOpYoNOQljLJik1w//iyUgTEuuLfq9/OLV3Q63mVsHzuJRN1X4uXCG+6u/mlUPMA2GMC8Imc36V4nxGW92ByAOvyy5jo43SdRJMG3lEhjFTmwbQr60UKZ+Hi9xPnYTrACxKbSwUt6PpCMWvFQ7JUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752469311; c=relaxed/simple;
	bh=GNxzXsYzlNDPVH27Z5T91SIlMeNBsdS+2ls/3XwDN+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpKmtabnc6SgWwaHJPu6coWsH5HmwsC4g7sY2AQCxyZ2fDtcMFJQpp3kPQcnkpGIjc/wQRhNaLhkEjVuJr0+lhCEFbjvaFEc5YUiyOsdeTQH0gKy5HFED281QQMeQ6khR1g3049vuQ7jfCULjzbrlYawDDTG8SQWlzp+iKkKlRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6GI6UVc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6GI6UVc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23dea2e01e4so40101395ad.1;
        Sun, 13 Jul 2025 22:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752469310; x=1753074110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+yJisL55v29eyx2sRZ1lV9ZD+fajqVVRY3S+f2r7hc=;
        b=Y6GI6UVcYBAVPUkcTe7bCoEQ6w7un4B677UtBC3Qls4371SxpSbuIz91K9YbKMaxPL
         uA9/aD7rCS6MnlTqXJWzwbduE6QvGVN/QjMOYDMe+EFEvvCljmV39gBevZMVDFe/PaAH
         70IebWx4qw7uuUmT4/9MEYQYJukGHKRZFf1BPcpCatxhlGGvwXqbP81O5xUiYmaogp6/
         yvhhJnJZBDvGPbWVfKRUpT5NOQ2PL/cykuVdURFPjaK4vHqHVXrlfptrzrbxD2DXPHp9
         l7hbd/OregVS2tkseFvdWYHi6J3NbZJCwc0zB6rs4lj+3V99qL9mpz3D8T9YZPhB6Hdb
         kxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752469310; x=1753074110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+yJisL55v29eyx2sRZ1lV9ZD+fajqVVRY3S+f2r7hc=;
        b=BKBscAvNylhppjrpcHH447caXGNnutilq2gczLtWSv2tLukMlzajQBoBxMONUqLxaB
         KgFJOq21P8+4pfwYma7la7/ES9qzMUjmQ7RXSr8zFa3m8UbIi3Q3l3k0oDk8uRbIJ7DZ
         9XPF7HhDPVoTFRWuBc/OKlSImahSDGvUsRF9HF1t/MX5DQDWZjOkPhUkoJIXER2CA/1W
         VtEheviOZ2e4JEBBNyBucM4mwc3ZoBLUvIcSx9Gmhii5ikgkAZo3YFkw/vlCt6GXag1U
         0JSNdMXT9YTlXW5HjBAIn52ulfZMjEeOZhJQPkcylRM4eb2z8YNxyeYw2aryEunvcBdO
         f0sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtcN8L1e6U8GtGyoYYmeWOHF6hhWubAwwmSyMwRO2BwHzWzt5UHhwK9VNgp6dL7NwdkHZEK9uBQxemqtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2IJ5ueqKJgaPvQJgCCvy9hET3UcwR+RmbYExAvz3Jk9RthcR
	LPnGSySK27+GCpBqF3DTNnIPpoJ3LTVX7F90aqxZ5nKji/EwBLdj6Fah
X-Gm-Gg: ASbGnctSvoYYUpi1QeGoqGMg0YnmBGiNYfivt/wxlWjDWKxCoOb2StsU+rUWIlfhORX
	FyP3mot0IzTAuji8zHd/EMOsMDLYH5KfSC5aO5UOzxu7Wscw0d74gncsnUH29zmqHC6aSqJEHA0
	oGdrT3cJw0fH1krg8EwW2SkRS55ekVuJ6/fJizIGsDBohr1396rn+MQ7ng2XOB88TqBWyUeRVW1
	GPa3GDJHv1G+vssY1B8S27DOhUkLmiuh9MjcBRqDevTlbqXicMpn3EaQoEsxs0R4oQ51PQ6fL2Q
	xe4I7cFodqgWYFyuOJeWsa7psGZqJ9CRRJaoL4ljWBVwUeci+cv7yIYAPz1FIRDrDbZvzeu+/zq
	Zfxst41zJxQUe3nE9WHh0SIuzV9dGUSu7BD9TRCwzaUCmpZahb/uOLlcavDIsfVlR2lm8RJIhFW
	HLog==
X-Google-Smtp-Source: AGHT+IGGRJZ0TN2pbJo6LSslcMT5o/cPZHsOJ0HiUeWBjmZ2uA9BnQZDwFW1S9tqGVvYk0720IH/Tg==
X-Received: by 2002:a17:902:ec8c:b0:234:b743:c7a4 with SMTP id d9443c01a7336-23dede874cbmr189167135ad.38.1752469309569;
        Sun, 13 Jul 2025 22:01:49 -0700 (PDT)
Received: from ?IPV6:2409:4090:20a4:5c0c:45b1:8db9:582c:7df4? ([2409:4090:20a4:5c0c:45b1:8db9:582c:7df4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de436056bsm84429175ad.238.2025.07.13.22.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 22:01:49 -0700 (PDT)
Message-ID: <21a075b9-8a2e-4b55-b63d-fedce36e7260@gmail.com>
Date: Mon, 14 Jul 2025 10:31:45 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: floppy: Fix uninitialized use of outparam
To: Jens Axboe <axboe@kernel.dk>, efremov@linux.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250713070020.14530-1-purvayeshi550@gmail.com>
 <175243012818.93872.4165824196717735145.b4-ty@kernel.dk>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <175243012818.93872.4165824196717735145.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/07/25 23:38, Jens Axboe wrote:
> 
> On Sun, 13 Jul 2025 12:30:20 +0530, Purva Yeshi wrote:
>> Fix Smatch-detected error:
>> drivers/block/floppy.c:3569 fd_locked_ioctl() error:
>> uninitialized symbol 'outparam'.
>>
>> Smatch may incorrectly warn about uninitialized use of 'outparam'
>> in fd_locked_ioctl(), even though all _IOC_READ commands guarantee
>> its initialization. Initialize outparam to NULL to make this explicit
>> and suppress the false positive.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] block: floppy: Fix uninitialized use of outparam
>        commit: cb1bdf0797acd79c53a899f72a06ab8c1ebc5bcb
> 
> Best regards,

Hi Jens,

Thank you for applying the patch.

Best regards,
Purva Yeshi
