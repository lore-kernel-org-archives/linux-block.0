Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC5253358
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333177; cv=none; b=JnH5eWot0Kg6TWjZuK+hRCFv6qVvCNIfwL8LuQEzW3ec1WKhQM+mUnO4CY7MsI3A0IY5eI60VZx5kPFs7g/by1HNuGYfoBEQFXgQ/KzYezCtWqSSvonwP9G8ah8OgsAa3Up6gwSj4TEMPNX4XI2H8yYKMHn0EeYUaOQwHfyd0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333177; c=relaxed/simple;
	bh=s/QjyZzY/EnfUUvNKb7Q7l8bqIG7rG8gTYAL2oTY5W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHkR6eXy0nXq7W7WwumAdahNS0HjvyMLikoOvhnKYduV9yl7R6B5YI1Q8RvCd+7Od5YS+hdpSsME/A6jRB892bSPpmmYSaEk8vWvWDU2l/Q/TzrjkzD8xd3FjbSh/BphLTZWqRFIFpf9gsEGKyeEwcwiFEoO/PqkO4syaiVd8v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kcVrGY0w; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kcVrGY0w"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8647a81e683so34777039f.1
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747333174; x=1747937974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96xY6/n/0fhqAkgNUIqk6HeWQCuRjQ3BV7nB9J6drQA=;
        b=kcVrGY0wNLRo1y5Cwo33gWpbq5GjPez55xOZNbREb37HEmycAbB7rVLVpCxbACLB5q
         cgzwssAQwJCD4OvEfySDH5KN0D1R40rE4pde8RnGubvGHUFuZH0lX2tstOEFfazio8M0
         uKrICjXQimEoCY/pxavBVSwdp3jXxct+N5voc71YYvCkv/QmHyQONfGgBd2NZTDxnhYb
         V5Jv81v1nvCxH+tjUShYTI5XgDQAUIZrSsIZsPdNA0eJt3wsAMU+gHy5wJrc0DtRENzN
         ebjFCFOz07QnJss4w6HZ0V7aGAuIhoghl58bRoIPL0rECc97S2WAyG0VryWtXUsF21rq
         ueKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747333174; x=1747937974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96xY6/n/0fhqAkgNUIqk6HeWQCuRjQ3BV7nB9J6drQA=;
        b=sIeLA8b1nPN87QHy7hRy6AZxAzxb5EWr7VUBVvP7EE9IvOs1Agd4cwjf4lqYnIPR1j
         5CxL8qXolM3e8NgFs8AeCg7cYP/aqZiTOhqObOn9Cxl7LKJOzDZobsGNEhYpRYC5lWNW
         mg3n6rOssawWguVRD9mxHqDQMrdG0SJAzkU7lIaDOl3sivoveoCeFV4IetTU1O5Lh/fE
         WeTUpKBhx0Luwbs3xwiZb46im2HcS2ElCx5ojDBeqpfGUBbphGPOB+kHy8SEcKisBCWx
         ilQZrl3axTV70rcJIsQUpdXg8XlqP4UgAx3hEPYZdCVmMf3kbLhTpsnXAes/8ySqUDY6
         BcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZwWP8FlGB6BEeNs6xqkv6UMz64aI1cShkEmGOjrfZ2azw0xL6+lapTQ2oxMW6sCaJ4Vl5nnMtg+XZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVG4OUOLBD3RD5sfftTbwXOQIYJ+HVnrCLI/c4KnUTH9b+xBTb
	oHLS7/rXAgC5qJ7DGWKpROn6E7NRbVxWbxojVbeTEq6xWdEEZ2I4ZG5aelPyBUvLpsI=
X-Gm-Gg: ASbGncvdylFmAtvV5tgQVAZs+8v9lDgCfWBsyDjSZCTty1PgRvK4imcpp2SdlyjfJV3
	8f94Vk8yHjNL/5yoZWW/HVKwtyxKVbcoti607njCtmU62QlwRMEaLi8Lg3Tvuf7tPCOMXKFFNky
	CnahQIKtJQjSG81mJInoYLunKa6VlWGzNs8EnrkQuR2mj+NSZy7Ur3ntoXM5wdIJOgfVQvQaUjP
	Kk4uFZzGeac3JisjWjaP5JWqssvs4U6ShO6NJk+KbrNgkGVdUxZC1SCJi94HnwB+ZQncftK5djd
	8es75DFN1AZ1v6gppcBXM7LOxLwogngLsFqJA0qOVP777sI=
X-Google-Smtp-Source: AGHT+IH5rh3RaD+mXxl/U/ED5r/PqNk+HsLHF/ipKK7WOh4aSk3GsClD76p331wCOo6l3ZpGehK4jQ==
X-Received: by 2002:a05:6602:6a48:b0:85b:3791:b2ed with SMTP id ca18e2360f4ac-86a231c3ee4mr95598639f.8.1747333173762;
        Thu, 15 May 2025 11:19:33 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4b1715sm30431173.123.2025.05.15.11.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 11:19:33 -0700 (PDT)
Message-ID: <e65279dc-3054-42bc-8365-2065769d5898@kernel.dk>
Date: Thu, 15 May 2025 12:19:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] blktrace: use rbuf->stats.full as a drop indicator
 in relayfs
To: Jason Xing <kerneljasonxing@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>,
 Yushan Zhou <katrinzhou@tencent.com>
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-4-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250515061643.31472-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks fine:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
