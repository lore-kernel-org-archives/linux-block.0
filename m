Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480784A2E
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712889; cv=none; b=WLY3ONjM9a0RfqaTqakxksxdqbwofzpyGD/vayG3UgUZ4oVZPxI/aWMVVwlPCGgADzcJQ9sZAzWTC+MJYVB9dIjRtBaTrAd0a/Y29jaa+khGL3kovwPTf1O62cOIOGqYtPEgS9DqX+UrtYoWK5lUdUzF7IfmFv1RhxFANokWktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712889; c=relaxed/simple;
	bh=lDjFKNdSjktCWTnrP36guAx2KyT01h+vfaOsmV3kEqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R51k6XL/aPjI8BE5hyWKpWAJ4FuUbozOobLR6mTCkCXTwR9/n1jQn72FSWhSNG9lFX8GD+8u182Rp9v5l6hhHeoH9l1uZ7CEunq1WHexSlr3t5ugJMe1sZXan9tB4EQtvMUJtHk7zms02O4lrq9JPCvq50WAHu7LsgMWFNOwWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w008ksq8; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w008ksq8"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso67364639f.1
        for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706712886; x=1707317686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHJQ/aG4p3T91agak0V8di4mytjOgAxT9qUMt5eIZHo=;
        b=w008ksq895OnsRl6funjwLly+BnNzUOIoJsAy7glokT5xdh9WiC3HiXLq/4NWrWJM3
         ajl/+QHmEzoPRFdgxjrK6oy43csOICn6UslNYP2uQnmilQq8jeeAOB5RqPeQs12vOGtm
         00vOD1DyKbgStY7l+2iL5m1XZI6RW/APf9HJwrYalYZu1SnZnSQEqrRxz5rwlKMPcLr3
         NRNItGERLIRHi5acm+L0EhgctJHPzPv57kFgvElKDMuYxQMzLBNZhTWcYI0pnlEeWVgl
         WtzRfuV/E+w0Zo019aoTQDvV+uuwyVHCRVIIRJ4Tn9hG8Lp6TuLFXsa1fsl8t72v+JUM
         Anag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712886; x=1707317686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHJQ/aG4p3T91agak0V8di4mytjOgAxT9qUMt5eIZHo=;
        b=mZL2m9P2FZyLrlXaCGQaa8qkvM8FZY8v5t3pe7POnmqafsC2F6zhB1EAXsCSAzZTNL
         8MxW0Y4i3BP1h9jP3Jq117uEHByl3mmfb9u9ZVO/bL7OTNGYLY224UFlpLNdsO+a34Tf
         oocD+wEtGvkx+8dO3/Fmd0XpSo5AZ0rrLqXdZveeqldWg+UoAsaAhzHSOw7hLv7Xpc+/
         Abl5A1htFS/9tg/YWm6YgodWa/VenB+A3BE5yoE4xh3/WA0k64UaTL1twrz1QOoQ9m9P
         B4kmOCLwmzhJNJvB11X6k8SzT/Jr44WUi75lkDnoE7DcDJoY13YTtpg4+jWYIQe3pzYg
         Jjtg==
X-Forwarded-Encrypted: i=0; AJvYcCVmZKIlYm2SGBwnrkr8icSg+HIuAGaZ4YZPJNuad4175Cjx8Y+sVKHxizmGtO/QhhMUrMjZyVK7ymu3WxDxMIGqJuUdmDjCiJLEX2s=
X-Gm-Message-State: AOJu0YwV4ttgi8QPgRR+k9aNHno9sxV7BItnX2/5GLOWsmEk+bFQSxrh
	rEvMoq0fxqIUoTnFed6MSem32PZBxUG7cjI+lg8U4fvwyuVZjcJXAy8m8Zl8zw8=
X-Google-Smtp-Source: AGHT+IEt1S3q1yxIamRX2NO+jB7ghgLZERhYPZgKQ/bWKhlHRf1N8j4BmbVE/+5xSCORU5L/shVDVA==
X-Received: by 2002:a6b:e211:0:b0:7bc:207d:5178 with SMTP id z17-20020a6be211000000b007bc207d5178mr2105418ioc.2.1706712886384;
        Wed, 31 Jan 2024 06:54:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x7-20020a5eda07000000b007bfe7b63a30sm2231455ioj.21.2024.01.31.06.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:54:45 -0800 (PST)
Message-ID: <27bf629b-7549-4f15-8d88-cbc2def86df3@kernel.dk>
Date: Wed, 31 Jan 2024 07:54:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace/blktrace: fix task hung in blk_trace_remove
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org, dvyukov@google.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, pengfei.xu@intel.com, rostedt@goodmis.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000002b1fc7060fca3adf@google.com>
 <tencent_6D33089EBD1B9C4BEE1B2425C6BAB4BB9F08@qq.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_6D33089EBD1B9C4BEE1B2425C6BAB4BB9F08@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/24 6:28 AM, Edward Adam Davis wrote:
> Delete critical sections that are time-consuming and protected by other mutexes
> to avoid this issue.

What is "this issue"?

-- 
Jens Axboe


