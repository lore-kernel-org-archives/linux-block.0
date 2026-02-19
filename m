Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215B253B58
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511548; cv=none; b=tZB1tVlyxoInp9hlZoM5YCu3vq65lJCD+2Z38wImUy4AOJWbPDWE+c/qgvHWdim36C5c7UwKQy0/WN8wa7s8XVWYN8Pt/X6Ni0ZrBPNJ08n8urzMXfH6+zWLA7QwwArtH7o44RoCZxiMpyO4t8AI5sJ6uShCiGclHlnzomGjm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511548; c=relaxed/simple;
	bh=66JfyiLinFfCyvPAbgz21SZgjf7hQ2708s1WoW1oV3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hw19B4vU66m82oze5XTH1CcsNs9q0ClK+DO6DWmp+2w/mkRrjt3BQsAX1VQZpsSS4OcX29+jukcgkEuYqlXWQKw+tR6reGHxbPcQmEXPIuAFbBfBaUnw0zkN3fi+h1RplRwS+iNuLQBxF3Ph3j7GV4NknSyfMFGir2c6mKS7r58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=hBWWhNvb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="hBWWhNvb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4834826e555so9631245e9.2
        for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 06:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1771511545; x=1772116345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1aygOr2SiR46cucNthKeoKXJ2dYog6+H1Q6WGVnZgI=;
        b=hBWWhNvb7L0w90k4CATqgfrqCrm4DMfRQvFMmiMw/zqcCd2IpukF8gKMt+neDDnUVQ
         kRsyH4c3O4PuAMpLwkhSpzvfR1zAx6ckqnqD5U4dQxbHjrVGsaAF7egZTbKyFkVFd2if
         jYdyYrEwU4dY3Y4wzvf+D9OFbyTPSGUhuQaMZ7s+NlBgqQwHyWxlF5xzI058dC44t/+Z
         yKM3ldeTbMLuKPiJvX+CSaYpiHfyBbTSJ9TXXfc/ReXFCGohCiBG6LwQ1zVSjCIvZ6hL
         qOKGaQXuRbKSkGqxjKOs47j8uZxPYg0hzut3Db28L7Be/PLQXCGXeJeFT13jsKL0XO/b
         PM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771511545; x=1772116345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1aygOr2SiR46cucNthKeoKXJ2dYog6+H1Q6WGVnZgI=;
        b=vhMN1koZZh/fY54YETpvZj2deX+D4A9UcQEQJmqRNJwndhQV9gvqvOPGbaTL0zK9ao
         z3vidF+GZ4TL86i9PiJaTc+qlohMHkdtHaH67N2K8nX/NT9qs51Jl4Wo6V2x0pLP3vGB
         /TEeEhj+b+Lpu1Adg1t77BhdiBVJ4ImM1cZsxQ9ih8YswcDYv5qB+9OPxlPRcdwrMTbV
         vWKbZX1y5pqTja8PV9t5HSUIu39YnzTcQtLTMdzAveHgLiD27sXLbzJEhpCrw06QcIm7
         5VmndffxyhaJgWEHqb+u39LQQzDJIvRQmOT+I3PzTqgwfrwZ7sOop0ux9qVwnRDHHH4D
         jXFw==
X-Forwarded-Encrypted: i=1; AJvYcCWZQHE0YD3v7l8uVU5jQ97fezyUtsMu9SH8T6tVda5+IkH+jH/ej7SVpK5ejo2UiylrxtZC3u0AxGVApg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/T2HjN6vsGK8id2BBpfEL/O9GzYXlMMeGcCK/tERXUhTCmAwR
	5UGx/RICA28+0YZq96vYcxkOWoC42NaK0saOBjqi2N0Vrt6TcbLSREuxP5OZ7/H5i3c=
X-Gm-Gg: AZuq6aJwo1Wcv+t3+PyH7UA/Y7GyC6mOXdlTLilqV5c/EX3vLBJRx+JOY7H7JhBKnpl
	2Os5Um0TZ20sYW+KXzpXKmFS1wboJbM8wGt+VhaCDS1SB9aGKdMmRbhvEDtLdG3ARJ3kMtaTHk2
	6MEHtWiWg56Oempt4IoJSmURII4qhIt4vVyfIjRgikYG4/KbOAWXxiHAKa0RY0JRPlEw7m/RpYa
	HjVa44FxVG47nAnEALE3rsYIn7ub4sRGsI1OChDSJkcKy8HavOjZHq+a1L8LlP+2K68E2fOU9rW
	ygkaqBvBW/EeYCjJ5FTem9u5xE6gjSQ7Xkqft9mMHAJsu8k+csny16sL4LzBEciHHq1iX3SR/bt
	XsQG6r2zA1AhSr6WUeuz7CeU45KQi/uIRmT2XJ8Sb4XA6K2tNZC49IHHfr1s7Jpk7RzErH94jNP
	SnMeL97p/ni/jSJJMM/g/GNalyXLAkszNC4iMfICJbXUKNEIL+7QwBBUg1ucw+OOXsCUEKOCEPw
	FK0NFabtdxnS0NwZCvG6mO3/pPYeQ==
X-Received: by 2002:a05:600c:8b61:b0:480:1b65:b744 with SMTP id 5b1f17b1804b1-48379bf7907mr277885095e9.28.1771511545296;
        Thu, 19 Feb 2026 06:32:25 -0800 (PST)
Received: from [10.43.5.171] (62-99-137-214.static.upcbusiness.at. [62.99.137.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31f9475sm6559915e9.14.2026.02.19.06.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 06:32:24 -0800 (PST)
Message-ID: <432b20cd-9ef0-4335-b8da-425d9a441c34@linbit.com>
Date: Thu, 19 Feb 2026 15:32:23 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drbd: Replace deprecated strcpy with strscpy
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260112170412.741013-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260112170412.741013-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/12/26 18:04, Thorsten Blum wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  No functional changes.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/block/drbd/drbd_main.c     | 14 +++++++++-----
>   drivers/block/drbd/drbd_receiver.c |  4 ++--
>   2 files changed, 11 insertions(+), 7 deletions(-)

Looks good, thanks.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
