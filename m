Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AE22C95
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611260; cv=none; b=bIVL7xZfnAz4g/dY+S2KgVYziEeXyD7xpXOk30+haQN9buTT1IjGfz2HmFdnjczW9MCpYTZKxd+saWGsCxw3205GuEM8vFbhTIDpUqmfY0UNCMNYwhXNjaigQYqvu08NfiRx3sXZz8A/n2Tn0ztcRlpLEkyknlwX8S8LGYBIvoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611260; c=relaxed/simple;
	bh=XlaBgIk03gwg9hXViHjBnESCujBmUxLENhKIfLNL8Xw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kP0b+XR/nFsa6WbcGkWaztZGeYe2CULZTyxMZRedsy2S/Fp16psd+en85eFHmq0uzllqBrGTx8iqzMRKAWxQpKG0uRx3JRsoYTuNUJMQ+asXPG0ynETomN4AoO1SUg6aUGp1E8JwMP5d31jm+0oJwOvn7ThdICtWX0/BrGUPIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZqwD01Hy; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZqwD01Hy"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25075f3f472so4208fac.2
        for <linux-block@vger.kernel.org>; Wed, 05 Jun 2024 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717611258; x=1718216058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oSVIp5tH0Fdf6LZyEl2CHXsReyyORLHTvKvZ7WJfPCg=;
        b=ZqwD01HypASHFhJ+pcja4rsJC4HnYDvOeViMjtHeSwl0sAeVMno/reK2nUKaUGK2YW
         3qT/KG2R+F8YLIK1ifGcw1GuJTx6YZSYurxRkYi1UFQrIhK11bHoWzcTHFvoIRdVYGdK
         yFrAK1OeHW82H7d5TcwdiNWxu698TGXIaG1dHHaWZV5h9sCG+lzlZPXHIHxAUR1fMezY
         YKaLUIYj0ew+1NVNPbE1/zCJ3K4SQKXNkS4aSk6w1O5fZJJfdxD2c+5SOBKxnwn5RPsD
         iW9MFPkf4YrpTEYQY4VREf1C0cKrpalFgKOBWBVtzWAkuKZjaLf8TBVXMWDPuzGvPDsl
         Kx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717611258; x=1718216058;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSVIp5tH0Fdf6LZyEl2CHXsReyyORLHTvKvZ7WJfPCg=;
        b=HeCniW826rOBxVdMFDroSpZ2OgmIIoqLSMBPalxFGnoNSUv0uqn7DruRpFDs8RxC4x
         MD3SvypT4tzlGy+sQPJA9ctRrTYag6DiJXONQDs/M9ZW9EOKoElK98IHxIiE7e0yjUj3
         Z2MbnhOmIB1mPbPrsaXsxiGISEOMnrjNV9G2Kw3jFOr8jy7g9cyMaXmBAxnqylgytzkn
         xNilPJfzZzHGox91lt58QXp6HSzjvOehR0p5rIvDmruYg/br5ROfhp34nHH0J4hefdcv
         sednEmnkwI+pWQFH0VpBpb1V+xrX//ERxYiei7k1wK8Jxz+t5KDywpF4/TdLFAH/sbZi
         nFmQ==
X-Gm-Message-State: AOJu0YzxNJj+xcs10aknTqRctgJ2jDy4d2Gg17lU4k+bGYqgnQHYxdzg
	Zz7rDHKvsvWFF85bHvpWz2vfdf4OvrBt+YlkbKdAG+SUEqCcp9Rh08UjJOCizKeDDG9SeZhmnKP
	j
X-Google-Smtp-Source: AGHT+IH3rTwst3rxHfabtcaxMo9YJRolfNWPOCLPBsmQkznjrFlkHCCWS0vObDUTUJlxOHzHgjR8hA==
X-Received: by 2002:a05:6870:ec94:b0:250:7928:6550 with SMTP id 586e51a60fabf-2512236d536mr3634384fac.3.1717611258005;
        Wed, 05 Jun 2024 11:14:18 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-250852250fdsm4082020fac.44.2024.06.05.11.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 11:14:17 -0700 (PDT)
Message-ID: <cc2bd808-194e-431d-b733-4aa7bd410da3@kernel.dk>
Date: Wed, 5 Jun 2024 12:14:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, hch@lst.de, f.weber@proxmox.com, bvanassche@acm.org,
 Chengming Zhou <chengming.zhou@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
 <171751063844.375344.3358896610081062168.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <171751063844.375344.3358896610081062168.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 8:17 AM, Jens Axboe wrote:
> 
> On Tue, 04 Jun 2024 14:47:45 +0800, Chengming Zhou wrote:
>> Friedrich Weber reported a kernel crash problem and bisected to commit
>> 81ada09cc25e ("blk-flush: reuse rq queuelist in flush state machine").
>>
>> The root cause is that we use "list_move_tail(&rq->queuelist, pending)"
>> in the PREFLUSH/POSTFLUSH sequences. But rq->queuelist.next == xxx since
>> it's popped out from plug->cached_rq in __blk_mq_alloc_requests_batch().
>> We don't initialize its queuelist just for this first request, although
>> the queuelist of all later popped requests will be initialized.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] block: fix request.queuelist usage in flush
>       commit: a315b96155e4c0362742aa3c3b3aebe2ec3844bd

Given the pending investigation into crashes potentially caused by this
patch, I've dropped it from the 6.10 tree for now.

-- 
Jens Axboe

