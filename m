Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E755C3E
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225613; cv=none; b=nKp2K5c0IVRtwf4ht8lAYkGIBNNcJJrqyAoE0x6FXRfhF0RtZHVlmo8DAjUAPPUz/236WdDmq8RY2DetP0QzcbTFUGR0/nrtQoFFOzAQSBw+tGNCT0D05Bb34Ru+Um/7EGnaNRgCYVWiC2eG0R3K3IvTLmv0TWnsvtjKUjMa1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225613; c=relaxed/simple;
	bh=x2snBHhVt4z5TOb+zscUiPsECWC11ob5QWlrzrhqK2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrUjmgr0nU7FrwFup+Rwm4mvDSWt1+p6VMvfKvc530/15bvitpX8sRocArxh6nKFGfvY4xaPlc4YPuPs/ZkKRIOKWeBen/z44OO6M3zMa4Ashep9zkrcV0TYp8U66kBbywWzsAho46ZUeUgL1TvvIn3MbTxLjgsPgQh8M6SRXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Yvax15Fc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Yvax15Fc"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c3071634bdso28542a91.0
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718225610; x=1718830410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSYIXvgTjBjLjDaj5a+Hbq3RRIqI54cl6LplLVVHNnw=;
        b=Yvax15Fc5ecUSpmvr5w7oAeQ75G5RfwEmSCbkQWwnvhsNBZDzuNG/KeQPBmqZ5YswP
         E9KtTx74pMdd9x1rRU9SfiQD+xuaCAA+RDr+11/sIP/2Ot6elidH4ASU5unijca7V1/R
         ixJq0kQ4YbrlLEaIuJJx9usiNtt+AMfB30AtsCLx+MnQFqoLWn3bFKfGbvTTsdaeb9Tt
         e6cm1KRyyEsZ5xPTaBSEidAatsEkklKSt0IYasBMx4GxfEAeAzlDsZ9LIWIvvfZ3aYN7
         a+2WAT4/CbrUR+MWRxkEM3vkLiBatI3cyCYWkq6U5VXCvOYN/vxLJSMZ7GaCCj5AuRl7
         x12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718225610; x=1718830410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSYIXvgTjBjLjDaj5a+Hbq3RRIqI54cl6LplLVVHNnw=;
        b=WQa/EAzjwuUlTz49RW3100+RosDBWJgDHSi/urZNQ1u4Lv/557tWFSq2LXLSWDDFTk
         cS/zlQqsJ72tEtH1GFBzoAxo86Fj3GMjvQTbVcgOwbrmVb4lfNTogPB+BADLZTtd6U4R
         VcjYuZ9N6PYbEekDJ7pD3vyXhcBWkNH1uK9mxq4P1lUV56BUFLKAPCTDkGp7+G1jt+6O
         HF7bBfsEYf/seABV87OGwKmlaRRhLHZVFjf+e5IkZ8bGlBto5PY/hfRl7S9LQbMdyjr9
         oqU8yMwt+uJ9sluFWKH67ARixaj/n2BfH9Akerzkb946FupluglOgOQfBupnbfh80ReP
         eZ2g==
X-Gm-Message-State: AOJu0YyDV9tIFz1p/CTO7VJmt4xbQ4F/1A5mmpmAcp6vRbvnRRU5OYOY
	l7CwRRpnfWVNk6HAo7PLaFpA5bGHNnmp0J0uoQzHwyyDsTPLlLHNMQzRFlCwreA=
X-Google-Smtp-Source: AGHT+IEBnkgvit8R/o/lYAcC85W+TBVXxi4/XDehB+eDIJlB10T7guKWGrixXTji//T7/aa9IA3sKg==
X-Received: by 2002:a17:90a:8186:b0:2c4:aab0:121e with SMTP id 98e67ed59e1d1-2c4aab01640mr2667270a91.1.1718225610127;
        Wed, 12 Jun 2024 13:53:30 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21cf::1466? ([2620:10d:c090:400::5:728])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45f3035sm5983a91.25.2024.06.12.13.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 13:53:29 -0700 (PDT)
Message-ID: <f092f5b5-68c8-4e76-9ea1-f319bcf20444@kernel.dk>
Date: Wed, 12 Jun 2024 14:53:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Avoid polling configuration errors
To: Christoph Hellwig <hch@infradead.org>, hexue <xue01.he@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20240531091021epcas5p48fdbd6302bec7a91ff66272c600b0dab@epcas5p4.samsung.com>
 <20240531091015.2636025-1-xue01.he@samsung.com>
 <ZlrQCaR6xEaghWdQ@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZlrQCaR6xEaghWdQ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/24 1:38 AM, Christoph Hellwig wrote:
> On Fri, May 31, 2024 at 05:10:15PM +0800, hexue wrote:
>> Here's a misconfigured if application is doing polled IO
>> for devices that don't have a poll queue, the process will
>> continue to do syscall between user space and kernel space,
>> as in normal poll IO, CPU utilization will be 100%. IO actually
>> arrives through interruption.
>>
>> This patch returns a signal that does not support the operation
>> when the underlying device does not have a poll queue, avoiding
>> performance and CPU simultaneous loss.
> 
> This feels like the wrong place to check for this.
> 
> As we've dropped synchronous polling we now only support
> thead based polling, right now only through io_uring.
> 
> So we need to ensure REQ_POLLED doesn't even get set for any
> other I/O.

We happily allow polled IO for async polled IO, even if the destination
queue isn't polled (or it doesn't exist). This is different than the old
sync polled support.

It'll work just fine, it just won't really do what you expect in the
sense that IRQs are still being triggered. The app side won't wait
however, it'll just busy poll on the completion and either race with the
IRQ delivery or find it once completed.

So I think the bigger question here is if we want to change that. It can
indicate a bad configuration, but there's also risk there in terms of
breaking a setup that already works for someone. You'd get -ENONOTSUPP
rather than just (suboptimal) completed IO.

-- 
Jens Axboe

