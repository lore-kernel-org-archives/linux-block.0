Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6E2DF67
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602812; cv=none; b=een5rf3fZteHSgWc/UTKttCkXdy7dwdSf+fS7NXkzNwcic2pPAvEi/tlg8S0vvmcci4dmdhFpWXnjc00P9WSl4QYvX7v0VYfpaV/C5bgHpb8f0hxkLp3Jolpuq6fT8BlOrORQqcL1eby4wEQ+A87VYmx2moV4YxV5rr6Mj9BziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602812; c=relaxed/simple;
	bh=ESMMrqXjwPRRi2DQsLItchRYxNt9BaIYRctDsKvD0HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cqMMigaIQn5v4HgebBJbn2eC6bGjOi8GG/abnmEao4tu66XeysLYdnkev8+2ZUUlQ0A3WBdGnkJ3yJPrjgkvXfc3c+d1o+BGLvgWYSY9elgmbWGP7QnIHuouLGiMYfeC4XwZ7T9hlr6eMfq/kcFbIJz92kq8km/fpHeHddWBFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W53D444C; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W53D444C"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36191ee7be4so3322135ab.0
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 10:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705602809; x=1706207609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5A8o+8wWNnZlQlp9A0X0HqRhh0IPNevh1aGagSr/owM=;
        b=W53D444CAg+UXws0laCTDZBkiyJbxKs4+NlMzvMqURYMg8+1lVZiY/fsx8ibpPL50u
         P0m+FOY002iiI9j1Q8Qd0Ic1SuS1Q8Nj5nlQ5odn8b5kTYh2LRw/Y3VKq/+iA5HU/hYP
         numfGtiOj+V22LztnktunCOfsimYOfYgHfXNCH4iTO1SQF5MX5mZOHA22YkAX/56oJTY
         oOf8p99PzLCne5Oj1GbqnO4myreR/7VlKtpq4DbWh4IXON6XkjxKSL5Ha0X9Oi5/J3b4
         CcKP3TToKDCpf8mHUZFr5zDwX+6BwexUHo73Xb9xMey2sEKtF4FXInPUhIIIPyXwwFT1
         eM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705602809; x=1706207609;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5A8o+8wWNnZlQlp9A0X0HqRhh0IPNevh1aGagSr/owM=;
        b=gNR33JqyHk4pLKFPlFQkdHpOwQck6Pvejaehv5Ya54pj+Ug+XAyVWXAWnsdDbUQcJQ
         TYG4Z0GAvJXBbjRTJH+vnCjM9zC3Dvm+2TGYBlWh6yhE1Op8eLsyiMcKOu7fUYjbOZnN
         CpiWUq8bchk8q3iiRyknT4po/Fk5Qz+0UMe6c3y0jWX85wOa+thnyvBaa8BWMKX+uheY
         /fKblvkdR84rbyM8E73Rb3l2ewoDQtq9a4NSiQ4bN3/aFYDCN5N3Xx8VEdnjbr04KSrJ
         +KB8ZXbOmVNlyK9SmiBFbQWbhohAjOdknoghLQqWjJSqzffIUmvKJwh/Rs5Em1hxUfxE
         8Fhg==
X-Gm-Message-State: AOJu0YwV//yjMZZx8o+zjFHe3PoQa3G3KJpd6LiPgW7S1Gyq99oK8L+U
	FjzeswTaR5EgUerpHC6LXEHZIvuCOfSey0X6aK1lZCfE5eCdUMkt3CIO7lB7JICMUC5kCwfyJRk
	vqKI=
X-Google-Smtp-Source: AGHT+IEXT6UncLaKDKW353JS0U6tHSBH8D3yo9lPapXi3oGUIbbQRoIwqKghFPbaqnUMnrrk8prjUQ==
X-Received: by 2002:a5e:8302:0:b0:7be:e376:fc44 with SMTP id x2-20020a5e8302000000b007bee376fc44mr208399iom.2.1705602809406;
        Thu, 18 Jan 2024 10:33:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t15-20020a05663801ef00b0046d4105b7e8sm1129940jaq.49.2024.01.18.10.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 10:33:28 -0800 (PST)
Message-ID: <c9f1b580-2241-4415-aa48-e4b7e1bacdea@kernel.dk>
Date: Thu, 18 Jan 2024 11:33:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-3-axboe@kernel.dk>
 <0ca63d05-fc5b-4e6a-a828-52eb24305545@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0ca63d05-fc5b-4e6a-a828-52eb24305545@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 11:31 AM, Bart Van Assche wrote:
> On 1/18/24 10:04, Jens Axboe wrote:
>> If we attempt to insert a list of requests but someone else is already
>> running an insertion, then fallback to queueing it internally and let
>> the existing inserter finish the operation.
> 
> Because this patch adds significant complexity: what are the use cases
> that benefit from this kind of optimization? Are these perhaps workloads
> on systems with many CPU cores and fast storage? If the storage is fast,
> why to use mq-deadline instead of "none" as I/O-scheduler?

You and others complain that mq-deadline is slow and doesn't scale,
these two patches help improve that situation. Not sure why this is even
a question?

-- 
Jens Axboe

