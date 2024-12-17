Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC0158DD4
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462468; cv=none; b=ojmH1M8wFpez/jg66k516/dRhj9hby6LtMk8QoaI8CSzp6u7h8UzkYHP0NVfzVXiO8xOxbwXtAPVygMXr02X1a8KqhvPvF8iqFDiFvsEXhRNdtL/z2/1mC7N/0V02YQ6Kw5OGLc3koj4iViMhob0k19/Yq5hGezjNmQzJnib/M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462468; c=relaxed/simple;
	bh=zEbXJcKLBNhfe3jN+pGgrywxhmrCmOeVl4WLzsd7P+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNsRbcaZj+mmjTCaOjs39q/jAOK/j2cbk0PNpSw5j8O627tvJUypmburiBDQd+dOTCUr8Ekn3MYMeWR5Cgc9B99ForNTm5JiPxoy6fXa157/OYldESLYy9x9BruH3oWQVaYc47F31mSTx9ia2hx4imQO+Zeb8ixRGMikdjK8fA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OIJxjHS9; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OIJxjHS9"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a8aed87a0dso19542185ab.3
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 11:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734462464; x=1735067264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrS8yI6Hb9XeA3Rw6ZMtPk9YRKE9uzW2nd6vbG8oUgk=;
        b=OIJxjHS9cStINtOnW4wc+JqdfRwwZIyp3CYoBVPi7LOpo2hwhPsbQJDJant4uEekAD
         shkfzCZON8yPdtiFr+xHIpJTo7pODRkfEr7Ap6ihBLtnBhTiM6GXpr+pE9nwqf/VmO3N
         A4CO/dAp5uxmCIaoj2i/QJkqhYksFPQPI/agpgWuaXegjvTnuSC4VHrVSIHqZTsMslun
         d3FKS+Y3oouKg2GKge4spFp8bsLc7B0CUXFN5Tf6BYJLEcwaSMASl5KfdPkwKSoskFPJ
         y/5qZWA27aKM+QGCPrPFYig/FvS9xBE+HiNO+Zx+xvDELb2RFqETWi1x7yyAMhDOGXwu
         W6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734462464; x=1735067264;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrS8yI6Hb9XeA3Rw6ZMtPk9YRKE9uzW2nd6vbG8oUgk=;
        b=bx4Y+i81F0/XzE+JPicbaEn2OYXo1alZTXsHmBpJ27VJhbOoMnEtoKAN7ofha3ULjI
         Vdj20js0+bvVQAlf/svumPMOoin2x4h4z5FYY7/cCg3fzsN3jS70amC4wQiBG8IJj95Y
         QDnA8eSn+tDqRvtCDK67OVqDMn59i2GFIHmkHU7B7fLnMStT7prQkuVMp3jvGu4wjTyX
         4xrJaHSjfXP83InQ2MAr3XNHOfYRxa4NCyKXlPvWPbxVN9VVN3awGyQS3BalPo3MFu+z
         LFu6v63rFsOFMZ4dR3O8ejkqnJ2V5woNMr6SgCUH70tE8gnUzPrJoNaY5CCfFUCVmZoM
         vw5A==
X-Gm-Message-State: AOJu0YxT3DdSBarLiCNarXZuioFrixAo+cBuwef0HkilZUmxfNVBTXgR
	4prOOoaTfMapS4xFvxVP5syK+a0FAYtL0DOyASBK8QZmW6MTmXes+I8lSJwmOXA=
X-Gm-Gg: ASbGncvI4pzqtXhxT9G55dNjv7Y8CydjCOLHNKa18zhWu+fk+TowFvvJ/nPY8yPQHGm
	44A9LV4AXN9k+pyt/XtoMclxJOvt/lrSOVs6jCnyd45Rn5IPygZXY7rQjdmymd3F/gol5xXkgn7
	YBLqQRZK0XW5tMjfAKAlYcupEhFncfVV0oTQ+A82LXeO7jePdJ6w3L7lfoTNlWNHMOMr80z18bn
	tpbLhYaJlZ2BnJwTX+TgGtgy+aVAb18kpYYTtTEOe4pvUidQxL4
X-Google-Smtp-Source: AGHT+IHux0M3PoLxhv6fpXXq9/p8vypltto+bOEYmxyTUEBucgbKOJj6tRJ+lzm+Q7byscpBC0f6RA==
X-Received: by 2002:a05:6e02:1806:b0:3a7:dec1:de55 with SMTP id e9e14a558f8ab-3bdc4e21cf9mr1200975ab.22.1734462464236;
        Tue, 17 Dec 2024 11:07:44 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2475af322sm22597885ab.4.2024.12.17.11.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 11:07:43 -0800 (PST)
Message-ID: <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
Date: Tue, 17 Dec 2024 12:07:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 11:51 AM, Damien Le Moal wrote:
> On 2024/12/17 10:46, Jens Axboe wrote:
>>> Of note about io_uring: if writes are submitted from multiple jobs to
>>> multiple queues, then you will see unaligned write errors, but the
>>> same test with libaio will work just fine. The reason is that io_uring
>>> fio engine IO submission only adds write requests to the io rings,
>>> which will then be submitted by the kernel ring handling later. But at
>>> that time, the ordering information is lost and if the rings are
>>> processed in the wrong order, you'll get unaligned errors.
>>
>> Sorry, but this is woefully incorrect.
>>
>> Submissions are always in order, I suspect the main difference here is
>> that some submissions would block, and that will certainly cause the
>> effective issue point to be reordered, as the initial issue will get
>> -EAGAIN. This isn't a problem on libaio as it simply blocks on
>> submission instead. Because the actual issue is the same, and the kernel
>> will absolutely see the submissions in order when io_uring_enter() is
>> called, just like it would when io_submit() is called.
> 
> I did not mean to say that the processing of requests in each
> queue/ring is done out of order. They are not. What I meant to say is
> that multiple queues/rings may be processed in parallel, so if
> sequential writes are submitted to different queues, the BIOs for
> these write IOs may endup being issued out of order to the zone. Is
> that an incorrect assumption ? Reading the io_uring code, I think
> there is one work item per ring and these are not synchronized.

Sure, if you have multiple rings, there's no synchronization between
them. Within each ring, reordering in terms of issue can only happen if
the target response with -EAGAIN to a REQ_NOWAIT request, as they are
always issued in order. If that doesn't happen, there should be no
difference to what the issue looks like with multiple rings or contexts
for io_uring or libaio - any kind of ordering could be observed.

Unsure of which queues you are talking about here, are these the block
level queues?

And ditto on the io_uring question, which work items are we talking
about? There can be any number of requests for any given ring, inflight.

-- 
Jens Axboe
