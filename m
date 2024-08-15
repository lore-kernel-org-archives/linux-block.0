Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E621B29A5
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737019; cv=none; b=nQZny+PZfswrR/HiuO8ijOQ7egq+rr+VAPKvWt7ZFS1XGE/z0gjfbfAmdXKp/GbnErLDv/HfU8nApQH+eG8RS0cOMbWCxMOaPiTvUcdCYbPSCVfWlFyaarokLrir3v2XXr0YSDVBjgFwWOuHaiwRFm5Hhq+K0IyqQgrrCos41vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737019; c=relaxed/simple;
	bh=h41YmOa5zOQODAClJoL5x7kmZK8GxrFxSOsVQ1egjrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMTlHq+sfmNSKES/UcbwKHiTbgHOZRAKQU0j4Mz8oem1IcIGYdXfOr7lDtukiyanG+Qi3QseUxLn4oZ6cxCMdh78QrcS/48tlrpUvZRvkzDb5TgYYD23Q/aFBC0rvtYBZHIosRp49H/OvmJR5Q43eD8eEu3ECCs4Lq0gXcYhsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QamiHNGJ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QamiHNGJ"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39a22cfda10so594155ab.3
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723737015; x=1724341815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdOckHrkEyAP+PfY5R6862py6dLLc14uZGSEwR4R1DI=;
        b=QamiHNGJ9tj2j5hRJQyb0jSxMmmDs646W6Be8WKVpWwFwV0UjugbTjMJWXT/r1sClF
         zWUfPzmcwTw3DaoHwj3InCMEPWawVHm8GAt9EhtJL0GNVJkZT+T3jKccBIlHfSlbUBxe
         dRJvhYyW0Zlphg+V3Psb9xCdo+uwNPh6eeldMVZ09HidtgYlqGEthyOudw/x/cudEbd3
         MM2OSAIrcBqEgxSARDexhR2xelBkaJLM7h6gmEQN3A1WF2LJTMaC54pNRdQakGub24/r
         IdWSGzzbQ4jAFbBhxsQplfcgYD/SzTIPP4pyDKbc6P2/QCYL1ssktyZXtmGOiAVWth/9
         IPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723737015; x=1724341815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdOckHrkEyAP+PfY5R6862py6dLLc14uZGSEwR4R1DI=;
        b=ljtpvHDsYgJoKNt2w0zxoloL0lMs3ICWyzZlGNc5KwoOaDIkK9DQRXPJiY8w8Xx4Tz
         IwHqeduT/vnovy0B9g1s93m1pSt5G32gp3CrX/LJC/U6mLtCQf2Y1juFXzpTQSVl491m
         7ULFv7xrKcSFX0U2ePb6q3KtBEJiAlyro8sMGRILeCVBeveNlSJ8AvfYUf8S3Buv7dGE
         90O2sX8STvO/WdEGx+cl8rL8CxfuRImeShjtpr5Ku99d2vHxfP8V8Cy7mGzbx/y7IRp6
         Dergk/6vFD7R9EeZMCYoz75MdyJXVw/IZ1VaSeUQCY/RNvQDywyqJ0TNf0o4GX7yPhpY
         1enQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJvRuj4a3qD3dD+QuDU3bYhW0lQxqhQduBQMUBYpXN0e2kl78lb+k+Scv5pUL/Dn9uul1+XzgS8p0Zlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyH5SqafwoW5/e6c1u3wd8Fpsx9MP+DIbgSwuJSb9xjD/Wa5c2
	z62Tv8+AEAXwyZSXpKfhNKTNBtmHiSaiofg9chToIbrtHdajzMMTn3UYdHbwCdE=
X-Google-Smtp-Source: AGHT+IE2zOP+lY1YyGAZT/nsjWDqkSGP1A3erhshqNBaTpi9hPdWu0zNuzQIz05cD0DHnR8VUOkj9A==
X-Received: by 2002:a05:6602:42cc:b0:7f9:3fd9:cbb with SMTP id ca18e2360f4ac-824f25e4952mr14867739f.1.1723737014687;
        Thu, 15 Aug 2024 08:50:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6e93f89sm557006173.57.2024.08.15.08.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 08:50:14 -0700 (PDT)
Message-ID: <9eac5571-a330-40b1-92ac-c6983be3619c@kernel.dk>
Date: Thu, 15 Aug 2024 09:50:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] implement asynchronous BLKDISCARD via io_uring
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: Conrad Meyer <conradmeyer@meta.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org
References: <cover.1723601133.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1723601133.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/24 4:45 AM, Pavel Begunkov wrote:
> There is an interest in having asynchronous block operations like
> discard. The patch set implements that as io_uring commands, which is
> an io_uring request type allowing to implement custom file specific
> operations.
> 
> First 4 patches are simple preps, and the main part is in Patch 5.
> Not tested with a real drive yet, hence sending as an RFC.
> 
> I'm also going to add BLKDISCARDZEROES and BLKSECDISCARD, which should
> reuse structures and helpers from Patch 5.
> 
> liburing tests for reference:
> 
> https://github.com/isilence/liburing.git discard-cmd-test

FWIW, did a quick patch to wire it up for fio. Using this
job file:

[trim]
filename=/dev/nvme31n1
ioengine=io_uring
iodepth=64
rw=randtrim
norandommap
bs=4k

the stock kernel gets:

  trim: IOPS=21.6k, BW=84.4MiB/s (88.5MB/s)(847MiB/10036msec); 0 zone resets

using ~5% CPU, and with the process predictably stuck in D state all of
the time, waiting on a sync trim.

With the patches:

  trim: IOPS=75.8k, BW=296MiB/s (310MB/s)(2653MiB/8961msec); 0 zone resets

using ~11% CPU.

Didn't verify actual functionality, but did check trims are going up and
down. Drive used is:

Dell NVMe PM1743 RI E3.S 7.68TB

Outside of async trim being useful for actual workloads rather than the
sync trim we have now, it'll also help characterizing real world mixed
workloads that have trims with reads/writes.

-- 
Jens Axboe

