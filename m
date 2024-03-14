Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E72BB13
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444708; cv=none; b=NTU5LyAaW/OzLSk2He6CjSxG8nWKbht97eg5K3e42EZpJp52x3rvujMIOPPaaHHlyMdN+F6l6vYiBsLPHxCiSw17sKfC5PA/+V6FzXA6tnyjVdhYRY1Arqx8Wgq23ze7K77bl0+8J4+Hr/17uMw84iM8YSCEHmXzP3oUzMut/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444708; c=relaxed/simple;
	bh=aB4H10YZKwGckj93TxrwTiRM/bnShEwil9MnpJZzo64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDCeO8gzYeDsi62183CndJbn5Kr0FitzEKOWoCRWEagGIkq+mj3pRt84SFkrGGqg7oRWm5c7NayEp8vxCGNO4akyoBl6NDWGNxdjlSOCEsGu6bBbr6GSPM1wvDUPj3WL0VDZdV53kEKNu4gQoyhy6Rq9Y9MnzNys3J+/SZn2Fo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XvjAuUia; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XvjAuUia"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-366427fa029so2038205ab.0
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710444706; x=1711049506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNdWzucTbA2b4HqU2AzZHwnzmQsiogETbnj1c0h9bsY=;
        b=XvjAuUia5yJSs0S18Besb9E8WI2dhiPmP6c5xpcb2THOoRqKLN5j/3NYcSDYmuGGz2
         ECb0rZN6cfU17Naz4e6NLkDPOW/h1DMxbqWBFvmMv6KdOMoJhCAsF/jfJGWVsOL5XCjt
         s21fkUvSymmO68aI4HAiAFuTc0kgG0YjCdq+EV54inObBpJgILOfs2n42uoDFwrVE1nc
         SxaDiSd1fP/P5PVnc9zUF+jV6vIG5EImv+DlB+US8cUUT+QOKmoDPWE+C7Gyfi1d0mmt
         Yk/m9Yv/iZ2Ezl60dghFuA38eUAr4DIGbaA83rc3LgG2q2MMvjZjTwxMn1Bx3nkOCgIx
         FkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710444706; x=1711049506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNdWzucTbA2b4HqU2AzZHwnzmQsiogETbnj1c0h9bsY=;
        b=e11aAbl8MjGMjUYfE0V2g3sN0uXS5oWMcnc6zohA7goLx89qKNyMGdEEL112RYAhEN
         Adr5yFIaQe97PB62RkorTxMjl9jSX1qlQcYpsiyoTMuYamg9ycTPmd8HHXalyRS1M1Zn
         SOY9//Fsnv2tKGSpna71J3PtcUexA5RYy3Fv7TxOMAlA8kc5F2XlUD19qXiG6JDugj3s
         +gsqfllqR4HHIJIt/F/LAylvHAbaI/mxF8yMMajDS2QSfsubJF/j1BiwB0NQwfIlUzYl
         PvJ50SFVo8VLgK7ZYUYtPJFyprCqJdqvcvVInPSJvrgSaqR73krgzTeJQDuFCmtuKoa+
         RUdg==
X-Gm-Message-State: AOJu0YxL6TsM7t8JTb9I6SKhz6T15W2pGwFCT9EPWnsqLCJTAxXA9wUD
	978vh8avtKKtbjZhpQy/b1X/ehn53YxyII5fQOt7GxTXzys14GAzkPQyByzyZUYvjryO57YVnOm
	g
X-Google-Smtp-Source: AGHT+IHeaQ9qFZyGKBuJMivY/uPhDQofowiVjTFuuY9C8fVTgO6bVZJ7BAjko8vp41VVWZLeQrxGVQ==
X-Received: by 2002:a05:6e02:142:b0:363:cec2:e344 with SMTP id j2-20020a056e02014200b00363cec2e344mr2641654ilr.2.1710444706399;
        Thu, 14 Mar 2024 12:31:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y15-20020a92d0cf000000b00365d7fcf12bsm306364ila.14.2024.03.14.12.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 12:31:45 -0700 (PDT)
Message-ID: <32af3475-8e36-4d18-8b5d-0b6c00b0258e@kernel.dk>
Date: Thu, 14 Mar 2024 13:31:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBSZXZlcnQgImJsb2NrL21xLWRlYWRs?=
 =?UTF-8?Q?ine=3A_use_correct_way_to_throttling_write_requests=22?=
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 =?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 =?UTF-8?B?6YeR57qi5a6HIChIb25neXUgSmluKQ==?= <hongyu.jin@unisoc.com>
References: <20240313214218.1736147-1-bvanassche@acm.org>
 <cf8127b0fa594169a71f3257326e5bec@BJMBX02.spreadtrum.com>
 <cf7e6d94-63fd-4ef5-bbdb-9c3877d8560a@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cf7e6d94-63fd-4ef5-bbdb-9c3877d8560a@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/24 11:08 AM, Bart Van Assche wrote:
> On 3/13/24 18:03, ??? (Zhiguo Niu) wrote:
>> Just as mentioned in original patch, "dd->async_depth = max(1UL, 3 * q->nr_requests / 4);", this limitation methods look likes won't have a limit effect, because tag allocated is based on sbitmap, not based the whole nr_requests.
>> Right?
>> Thanks!
>>
>> For write requests, when we assign a tags from sched_tags,
>> data->shallow_depth will be passed to sbitmap_find_bit,
>> see the following code:
>>
>> nr = sbitmap_find_bit_in_word(&sb->map[index],
>>             min_t (unsigned int,
>>             __map_depth(sb, index),
>>             depth),
>>             alloc_hint, wrap);
>>
>> The smaller of data->shallow_depth and __map_depth(sb, index)
>> will be used as the maximum range when allocating bits.
>>
>> For a mmc device (one hw queue, deadline I/O scheduler):
>> q->nr_requests = sched_tags = 128, so according to the previous
>> calculation method, dd->async_depth = data->shallow_depth = 96,
>> and the platform is 64bits with 8 cpus, sched_tags.bitmap_tags.sb.shift=5,
>> sb.maps[]=32/32/32/32, 32 is smaller than 96, whether it is a read or
>> a write I/O, tags can be allocated to the maximum range each time,
>> which has not throttling effect.
> Whether or not the code in my patch effectively performs throttling,
> we need this revert to be merged. The patch that is being reverted
> ("block/mq-deadline: use correct way to throttling write requests")
> ended up in Greg KH's stable branches. Hence, the first step is to
> revert that patch and tag it with "Cc: stable" such that the revert
> lands in the stable branches.

Indeed, no amount of arguing is going to change that fact. Zhiguo, it
caused a regression. Rather than argue on why the change is correct,
it'd be much more productive to figure out a future solution.

-- 
Jens Axboe

