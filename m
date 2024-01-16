Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662A1F95B
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439321; cv=none; b=hT7tQJD6+aoNJU+LtzqemcGtmG2TAlQf+nrlZw3OzFJg7OufcNjcTNuwk3WObZKyFu3dt+9ySKJ7m3HL2o7FUCnF5sSNCdHU9/bgvjCVXZ7QRMyA0OBO0L7Fvlzm/OLDrZLawqIRBxI/7ONFKxNgbPM/1rSJsHQt2TNd+lBHvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439321; c=relaxed/simple;
	bh=wjdhA9Wx/G9JI+UMvxCg1223sOIZUuC/gF+B08th0mQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=mgIbHS3OHezPzr9ae49eQ9OpASJoOR8wUX+cSg+ugEZv+a+nEc2yEJG0nuHog5gTNuppa5sS7ApZJRDqklxijwLoDb6D/e9ZiwhIeU0VAdZaO5DQ0jNcQR5bLRJvK/4cc0TZcYNebo0776pl+61fyE6DuqPP9myVlxWm3yXlGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AvntdGYc; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AvntdGYc"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-360630beb7bso8140145ab.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 13:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705439317; x=1706044117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZ9UWgbz5tCJlrTfYrqTFQs+p6e2qJiObigyvDXwRj4=;
        b=AvntdGYc5qwQKwVIpcjjdBYGPGt4NJ8yCsgZYWqBAQYAe9IC2tuUQ0AKe9j+wMvKxO
         emrCF8qUsnq6lW/weTmgbY0FPknRKKz6y1ltcTMSdjCPXN9EERmD86wR652J/ePeOEYJ
         OPt5HX2hbfs05kkAQ7kA37K+PpqviYcIBkSlZ/bN6zzCpmS30R9dexfiJ2MDnUEf37+O
         csGA+KPdrnPmEHt2E1LfrGSqRBdCJDdhaklS6q5U87az73FXVzCM11A2KYy/VBCr9H94
         1D7jZvArmNNM8gG7MjQd9maFv9AFmEbhghO+OesSTjVhe6zdxOJ3NftLCyElGKV0L8f4
         F2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705439317; x=1706044117;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ9UWgbz5tCJlrTfYrqTFQs+p6e2qJiObigyvDXwRj4=;
        b=kTSi2n43LSc39mLSwlXNXOXV9iFiH3JSVCRZYVPV1P9zDjbKkAt5trPj8Qvzn7Zqr/
         W6t7Z/9KyPXixfPMlMC/W8M2ri1tlkzrppRYry0BOkMe9J3Q+xo6sj3e9eabJYNW67dj
         GmoV8GGKVJvInyVHWC0m69DflFoQVBgJeEl5H8J5EtMcnlfgK36Q4eIk8c2PdzGeqK84
         qhqhgSW+A7m5GCc64kFaVwjHl30NqYDvIxuMvSoiLvutpDnVYHVeoxmAZkHuYEYwnksr
         ElNbYKU3BLZZ1Wf9pLXGiIxCTtQpBNLHf0j/buDoeSJCaHDmIV4MmLuBZXq7B48m2tdJ
         0C6Q==
X-Gm-Message-State: AOJu0Yzsp1d1zYeLfzFyIQnBol7ss/LvO3q0n/kEhYJDG2SHs9TZpkFp
	x9sISs5jOhVTKBkpjU6vpE8Gzt2SAAy5ZBcBcKpklskE/3CUvQ==
X-Google-Smtp-Source: AGHT+IFuMSETEf3UojmE80fEvZPV6DIevsJQqiObnggttGyrsKhWb5JzTtBba2sScLgCwKxWoxWwxQ==
X-Received: by 2002:a05:6e02:1bcb:b0:360:968d:bf98 with SMTP id x11-20020a056e021bcb00b00360968dbf98mr14394120ilv.1.1705439317331;
        Tue, 16 Jan 2024 13:08:37 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bd10-20020a056e02300a00b0035f7f712c78sm3782819ilb.36.2024.01.16.13.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 13:08:36 -0800 (PST)
Message-ID: <a43fda39-cda6-4fa4-9c5a-2062b0ef19f8@kernel.dk>
Date: Tue, 16 Jan 2024 14:08:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET RFC v2 0/5] Cache issue side time querying
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: kbusch@kernel.org, joshi.k@samsung.com
References: <20240116165814.236767-1-axboe@kernel.dk>
In-Reply-To: <20240116165814.236767-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/24 9:54 AM, Jens Axboe wrote:
> Results in patch 2, but tldr is a more than 9% improvement (108M -> 118M
> IOPS) for my test case, which doesn't even enable most of the costly
> block layer items that you'd typically find in a distro and which would
> further increase the number of issue side time calls. This brings iostats
> enabled _almost_ to the level of turning it off.

Enabled the typical distro things (block cgroups, blk-wbt, iocost,
iolatency) which all add considerable cost (and is an optimization
project in itself) and this is the performance of the stock kernel with
iostats enabled:

IOPS=91.01M, BW=44.44GiB/s, IOS/call=32/32
IOPS=91.29M, BW=44.58GiB/s, IOS/call=31/32
IOPS=91.27M, BW=44.57GiB/s, IOS/call=32/31
IOPS=91.26M, BW=44.56GiB/s, IOS/call=32/31
IOPS=91.38M, BW=44.62GiB/s, IOS/call=32/31
IOPS=91.28M, BW=44.57GiB/s, IOS/call=32/32

which is down from 122M for an optimized config and with iostats off.
With this patchset applied (and one extra patch, missed a spot...), we
now get:

IOPS=101.38M, BW=49.50GiB/s, IOS/call=32/32
IOPS=101.31M, BW=49.47GiB/s, IOS/call=32/32
IOPS=101.35M, BW=49.49GiB/s, IOS/call=31/31
IOPS=101.44M, BW=49.53GiB/s, IOS/call=32/31
IOPS=101.32M, BW=49.47GiB/s, IOS/call=32/32
IOPS=101.14M, BW=49.38GiB/s, IOS/call=32/31

which is about a 10% improvement. Mostly ran this because I was curious,
and while the above config changes do add more time stamping, it also
adds additional overhead. In any case, 10% win for the distro config
case is not bad at all.

-- 
Jens Axboe

