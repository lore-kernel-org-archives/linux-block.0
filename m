Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433201DE2A0
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177054; cv=none; b=ofNvfO5CubrZs31fVRS1AbpncdzSFysSPB6c2dxp7mXgk8XSjjcMzZpE0MdJTzY7TC6lW8zT4QNd5vcymkf//qVUjP8V5uJix7pHGy+H36p7C+bXNVEtHWGdEsqvc8+Yr4ehHmjQz2Sy//llWQrZUBVQOedevYOATAUZWl4nOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177054; c=relaxed/simple;
	bh=OtHnRc1/s3W3oU1lRgMfpH1v7alnB0qCfreHsV6616A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDMN0ivSFT72lwuEZfYj8iVMbRfHK7o+L2OZY1qMkO9IzCItWDyPqXKay/rQoABqJadsrDcNa9HfuG5omQv26x9szxZ0hS3+uuch3mVS08XQ6gmyDUOGG50UG+sUBNyG9cFBEFBg8rLtVovAaOo/4pf2J5t8Vr3j0Nym9ihY7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wulpvVLc; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wulpvVLc"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ce301bc718so1465025ab.0
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2025 07:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736177047; x=1736781847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VE/2btXal0iOHS1ElaeDOrQzUNAVkVfB2IRlP64x2Ao=;
        b=wulpvVLcwfuohAxEvYzACRP2gjU8ZMEjwDr5YZvL+MBFMotJ/dMoUt2NOkYdpxoYc2
         AOD7Pl0lDzA0reVtZvqyDlAZ48hZmcS9zNSvAQQ+bbIVRbJFaxQ4FGssHR9kLWNj24lc
         XyFfgurkn4xgQrQcsgkX7RMGBrVFXkzQC+RY++iygiO6oa27GB8X2YCrXFmNv8VeZX4e
         5Ll1nSuZHbMVmyrXsZqt4JVzKyQy0iUsX2FvYjZatVRUMiXybqqAvdIZPt3b5QqFoKAE
         fleJQyo/1fEUX6epJwRaFroIBJwJok1uYxQpIXijOc7UFgnnugBDkGkMu2zHVCDYyuuM
         hr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177047; x=1736781847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VE/2btXal0iOHS1ElaeDOrQzUNAVkVfB2IRlP64x2Ao=;
        b=G6Gs+34R1j06gcUDNVmxgP4gqyoP/dnNHlFsPdAK/WRD6/8sWQ4x86AeCSJH3EtbDN
         UIuZvW5vMsxZMvqa/EDlz1hdFzJRO94vLkUz+QRxkIWH15UnEs/Zi5ITE6rQhSwMDmsx
         3t3jTeWgfkGJKGLnLBopGzHQ0BaeCmVQqh2/V1wYXNI5DoL9DT/1AUXIqTI8UNpBCNkM
         Hg4I85fFn85xIhVIoSwjvB8RDqGOV902407i4Uob2UOM2Wy93oBxAxr5O2BsGqCGSBUA
         QJ1j7FOalCPQ82IskiPHssCenQNSeWD84Es3sguAZDjlR+IW0RdhonYBYsVPjL9y/ALt
         KKEg==
X-Forwarded-Encrypted: i=1; AJvYcCUKTqHVEwncBimxeUndhi6TQJCw7EcpVYLNyHkQyRrby1DLQ/hwHE8D5SXvs39vIISyDtoFGYf4JhIqmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCupSe84l1U0sn6ad+dfKlhLkpypuYU0LTSAqt3AXQ+tif17yl
	/nLuTqt4FTuesqlp0BsrEdvI0WulJlip2NDg1FvVHLUsZ8qJ6r0KVu0OfxOCfhsPUPVHLCyGf3J
	y
X-Gm-Gg: ASbGncvh6hiLQnJVmuXLs2B9297zGJa4n+e1NiajlvfAHEaCeTyUYZWRPWcM+x5ZpFn
	JdnH8A3uBEnKoj0bniAleh1NBoUsqapygKcwSNGIqF1yCnZvZ7gYZChj+o5tqw0L49HYnFXGbqJ
	8n+PvAgwexEdn7gJ4MBPEpWSKozc/ex4t+eO/xxmXvoDOMDrV6Uj+CfJD99hvXl1FRBwVW8XVun
	e9yQ5toc79I5+Q3aC8+hiKcqNPFlpMhwUdsDsC538tb2TZrFpRN
X-Google-Smtp-Source: AGHT+IEpQq+uDxZSjIYsoIHOGrkdeJpkKvUij4Jj+8tPlXoxDVpN/ZzMFyUx+rpt7x+Q1FAwn9W7BA==
X-Received: by 2002:a05:6e02:2687:b0:3a7:e83c:2d10 with SMTP id e9e14a558f8ab-3c2d5b37857mr567264535ab.24.1736177047348;
        Mon, 06 Jan 2025 07:24:07 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c1deed2sm9024689173.135.2025.01.06.07.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:24:06 -0800 (PST)
Message-ID: <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk>
Date: Mon, 6 Jan 2025 08:24:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250106152118.GB27324@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 8:21 AM, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 07:54:05AM -0700, Jens Axboe wrote:
>> On 1/6/25 7:24 AM, Damien Le Moal wrote:
>>> The first patch implements the new "zloop" zoned block device driver
>>> which allows creating zoned block devices using one regular file per
>>> zone as backing storage.
>>
>> Couldn't we do this with ublk and keep most of this stuff in userspace
>> rather than need a whole new loop driver?
> 
> I'm pretty sure we could do that.  But dealing with ublk is complete
> pain especially when setting up and tearing it down all the time for
> test, and would require a lot more code, so why?  As-is I can directly
>
> add this to xfstests for the much needed large file system testing that
> currently doesn't work for zoned file systems, which was the motivation
> why I started writing this code (before Damien gladly took over and
> polished it).

A lot more code where? Not in the kernel. And now we're stuck with a new
driver for a relatively niche use case. Seems like a bad tradeoff to me.

-- 
Jens Axboe
