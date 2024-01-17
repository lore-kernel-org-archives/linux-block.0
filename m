Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6324212
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522963; cv=none; b=putvGLRwhOG7eSPIrNxbDY44g0ZufBLEvxWd2wHNGjTQTjDCkwaTkruWGUHER74FWv5qOWuNGUs/6bau8rI9dJJOXO7fUyCT0kMAVZnOM0foGVZ88YQwk0MrBEf9cT/SLKiFTadmi2oho2jmKUW1tz/TLUerlqbq5NBQfbhktH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522963; c=relaxed/simple;
	bh=6Q73kxkTyRMQ/uqES9pxTm33SQgM22gVRwe2porzqxs=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding; b=XhqDo9Fj0pX6VDTIGVRAWoCzGyRQ0Q4mLkqplfD+84y0fXm94bvCl3yKKB78ECtRrUb+GCgq+UmcHPEJcGC0gwtVbtQhmj+NOpVac1/NqS6J6NawtFI4jW/hnFtQZukrDWqZXez5kxPEGSViDOB07oQ+/zUUDoq22BzfbFow8WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9bec20980so6303244b3a.2
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 12:22:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705522961; x=1706127761;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/ssYgMvSHU0V2p8049WYSJVkmv5/Vrtm0lsXdrQDb4=;
        b=s/VU834n6vz5mYzhezO/mmD4MKmo7jE7fUhBkg3hohS2XI7Cc1skwrDAQqJZfK6gjL
         8TabU33i07xt+njPqw7zam17Eypl/qE7GZ49OhMxUh3tELEVlep58WiNA4TTpcfO5WSm
         udZD8S65kVOSfGMw/pm2bfMuoPZ+thmIJZpFSyxOTcrenyRt0dUX4OhwjyxeSdhjzjjA
         Q+QSz0nH8Uv1iI6M0YYT5nN4vex4NFNWyQYaRGC1NWMQAZApaoY1D9pyYqOSSJ19at7d
         sZSyi8OmpbrwETSJ8oqn2pJgtYDFOpRSif7h4+Y0+Y3TufkhKJiUmJolsAeswH2FgjKX
         P06Q==
X-Gm-Message-State: AOJu0YwdMRUrhK65s9ghtxHgpXCTCjXuZziTXVulwu4tSTSQ+xBvJvhG
	6CDmg7v0trApbUSfusWvpylZ60Ikn0c=
X-Google-Smtp-Source: AGHT+IGrBZ2QPoUY48q6/N2D2CEOosqci/KqldkB/vXK2m9mXYYQ4uDPmXVHLdi9Rw9WPQF8fibS5g==
X-Received: by 2002:a05:6a20:9f4b:b0:19a:fd3c:b7d9 with SMTP id ml11-20020a056a209f4b00b0019afd3cb7d9mr4146365pzb.110.1705522961563;
        Wed, 17 Jan 2024 12:22:41 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:718b:ab80:1dc2:cbee? ([2620:0:1000:8411:718b:ab80:1dc2:cbee])
        by smtp.gmail.com with ESMTPSA id s19-20020a056a0008d300b006d9a6039745sm1852098pfu.40.2024.01.17.12.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:22:41 -0800 (PST)
Message-ID: <37b7836b-f231-4bf5-bee1-7571f889d6ff@acm.org>
Date: Wed, 17 Jan 2024 12:22:39 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race in block/blk-mq-sched.c blk_mq_sched_dispatch_requests
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Gabriel Ryan <gabe@cs.columbia.edu>,
 linux-block@vger.kernel.org
References: <CALbthteVP3BnZuQuGWfW-SviB64CwjACP2v1N5ayDVFpnjEOtw@mail.gmail.com>
 <e4347147-f88f-4a83-ac48-fde1af6a89e9@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e4347147-f88f-4a83-ac48-fde1af6a89e9@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/17/24 12:17, Jens Axboe wrote:
> On 1/17/24 1:16 PM, Gabriel Ryan wrote:
>> We found a race in the block message queue for kernel v5.18-rc5 using
>> a race testing tool we are developing. We are reporting this race
>> because it appears to be potentially harmful. The race occurs in
>>
>> block/blk-mq-sched.c:333 blk_mq_sched_dispatch_requests
>>
>>      hctx->run++;
>>
>> where multiple threads can schedule dispatch requests and increment
>> the request counter htctx->run simultaneously. This appears to lead to
>> undefined behavior where multiple conflicting updates to the hctx->run
>> value could result in it not matching the number of requests that
>> have been scheduled with calls to blk_mq_sched_dispatch_requests.
> 
> I suggest you take a closer look at how that variable is actually
> used.

It's probably a good idea to explain this in a comment above the
code that increments hctx->runs because others may also be wondering
what the impact is of concurrent hctx->runs increments.

Thanks,

Bart.


