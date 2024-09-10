Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB118CBE0
	for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974576; cv=none; b=rRoL6J+tNuQgTuoFNcduMH4Xww6VEVr6Mv0c8e26lR8eRA8GqKOZV5JTWACGRALm4xdBgWo/n5PYHFJeqyZr4XeiPCaCUdPzasJkQMl2C6aCnGjNDN3SlpYn9o4sbm3gIr8+8mdAtShIiLyrf1vLkqrfC8fokDBZZ4uS8y7j3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974576; c=relaxed/simple;
	bh=f3PKTxtggDOgToEGYYGgjQ0uDntcy+Y/oFBGor32rWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxFySB1grMTk9AWxATQAYb3I0pCdVH2zUpLlLFC6VOTRP35D5TeKeIGDfnwIoo+VUsQ5UQ+VgaZEIuv5ZxmGmqGu67ft/yH/FjKbUYkSLv7Ns2ZbiPTwJDZbxVzNyYme74lyGSF1kkCqCpAex2YuyXtLFT3UfghXh3ddIBs3pFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Wjqq6YcI; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Wjqq6YcI"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d3cd4fa49so18592525ab.1
        for <linux-block@vger.kernel.org>; Tue, 10 Sep 2024 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725974574; x=1726579374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zsz2DawbKokjmCBHoMj/5IgWeYCvivyMxUGL8HZEg8Y=;
        b=Wjqq6YcIwekcYIUP82qaSo5KJRNUo/vaoYe6mbB4Gu5qDpHtmn0ea0wKVoaxC2jrr2
         CgTE9MRUyj0jkMbwTmFHAGpNwWZ75opRaDmCbdrzWhOIO8FxGLEPj0pZZEtJ3LZQ/RZb
         77obYaHF8oEuyOQgTU3zgmlOENzKP74hYg9dxc0Pzrp4Mw2q/w+tN7RoC27wZcZBNqtf
         brnMkgUH8kOZMvFp/BVyUt1RMCsQPeMGQNm1emjrSV68iOnsnWg4v6DNel9tt2YN4ZO2
         QFeKvyNMoL/dPFNE8MgDuav213H/7XU3S0raD2dhPrkmLi+AfCfgnbeVgErtnLgSAiIk
         a0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725974574; x=1726579374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zsz2DawbKokjmCBHoMj/5IgWeYCvivyMxUGL8HZEg8Y=;
        b=Q2VNibmeH7nwZ8qzFRCMzJ7qocpuH/kx+umvhTs3ZtUVpHKHFTd9H5GKn6MYmdaPre
         l6oW+Acdj4CFYqhbqc3ywyD53tuYPr0igSagdQgfzss1dX2EsDuuipTlxcSzz2d9FtpQ
         dRLzfzLsICCrtmYH1ULo84ClqV55ZtK3X180j6YUUe3jlevkgH626LS3YXOQTlJxzC+9
         HrQ1Hk+Nw0i85BmbHvuBFY7qSJA8O4q/46R1ShQqeEGWQ4S7HxLVAT58BXXa9o66Jrvu
         iHptSA8/I6OcY5dk2aN9Elb0+/lu+jyiL57Ri+jEMRpx+stXzKqotg7B7Ra5RT1XALRZ
         B6GA==
X-Gm-Message-State: AOJu0Yw6vYBQ5EYJdxD/GjLP4kAEtTX5QvdTnEGL0WIfU/med0z9SGb2
	9/rhTXuh73q9jpcrWEWhKFdcpHzZ010LZhbGok6a6ZGm9kdAApS20vV4ndL63IA=
X-Google-Smtp-Source: AGHT+IHDvPZKRi5OPPT6Zxfq8GNcWYpeSOUaFFkDUjr74r3mQgiKPzPecXFzXvcX2Pd0XEIj7P7WGQ==
X-Received: by 2002:a05:6e02:17c6:b0:39f:558a:e414 with SMTP id e9e14a558f8ab-3a06b15a49emr25341685ab.7.1725974574552;
        Tue, 10 Sep 2024 06:22:54 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0590161cfsm20022565ab.77.2024.09.10.06.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 06:22:54 -0700 (PDT)
Message-ID: <db5193e8-5b8e-46f9-bbfc-a1821217f5a6@kernel.dk>
Date: Tue, 10 Sep 2024 07:22:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] block: fix ordering between checking
 BLK_MQ_S_STOPPED and adding requests
To: Muchun Song <songmuchun@bytedance.com>, ming.lei@redhat.com,
 yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 muchun.song@linux.dev, stable@vger.kernel.org
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-4-songmuchun@bytedance.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240903081653.65613-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 2:16 AM, Muchun Song wrote:
> Supposing first scenario with a virtio_blk driver.
> 
> CPU0                                                                CPU1
> 
> blk_mq_try_issue_directly()
>     __blk_mq_issue_directly()
>         q->mq_ops->queue_rq()
>             virtio_queue_rq()
>                 blk_mq_stop_hw_queue()
>                                                                     virtblk_done()
>     blk_mq_request_bypass_insert()                                      blk_mq_start_stopped_hw_queues()
>         /* Add IO request to dispatch list */   1) store                    blk_mq_start_stopped_hw_queue()
>                                                                                 clear_bit(BLK_MQ_S_STOPPED)                 3) store
>     blk_mq_run_hw_queue()                                                       blk_mq_run_hw_queue()
>         if (!blk_mq_hctx_has_pending())                                             if (!blk_mq_hctx_has_pending())         4) load
>             return                                                                      return
>         blk_mq_sched_dispatch_requests()                                            blk_mq_sched_dispatch_requests()
>             if (blk_mq_hctx_stopped())          2) load                                 if (blk_mq_hctx_stopped())
>                 return                                                                      return
>             __blk_mq_sched_dispatch_requests()                                          __blk_mq_sched_dispatch_requests()
> 
> Supposing another scenario.
> 
> CPU0                                                                CPU1
> 
> blk_mq_requeue_work()
>     /* Add IO request to dispatch list */       1) store            virtblk_done()
>     blk_mq_run_hw_queues()/blk_mq_delay_run_hw_queues()                 blk_mq_start_stopped_hw_queues()
>         if (blk_mq_hctx_stopped())              2) load                     blk_mq_start_stopped_hw_queue()
>             continue                                                            clear_bit(BLK_MQ_S_STOPPED)                 3) store
>         blk_mq_run_hw_queue()/blk_mq_delay_run_hw_queue()                       blk_mq_run_hw_queue()
>                                                                                     if (!blk_mq_hctx_has_pending())         4) load
>                                                                                         return
>                                                                                     blk_mq_sched_dispatch_requests()
> 
> Both scenarios are similar, the full memory barrier should be inserted between
> 1) and 2), as well as between 3) and 4) to make sure that either CPU0 sees
> BLK_MQ_S_STOPPED is cleared or CPU1 sees dispatch list. Otherwise, either CPU
> will not rerun the hardware queue causing starvation of the request.
> 
> The easy way to fix it is to add the essential full memory barrier into helper
> of blk_mq_hctx_stopped(). In order to not affect the fast path (hardware queue
> is not stopped most of the time), we only insert the barrier into the slow path.
> Actually, only slow path needs to care about missing of dispatching the request
> to the low-level device driver.

Again, this is way too wide, it's unreadable.

Patch looks fine, though.

-- 
Jens Axboe
