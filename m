Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D57337BA0
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082426; cv=none; b=HI3IlKFFoSiEe4PipBM4KBJfwYOz3MOhFOSMQIqJk75m0UFSn1pCe3au3i3eMrTG9T6apsvsTXChUVpcQWyCOvT1qEprJ6JGUx94hQalPIkuNCXmTw72eGMWk618fA5Wkxx0GGmST3Nz2ECHM0kQPtUHZYngvC4+HxsmFWfDou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082426; c=relaxed/simple;
	bh=L23kP1MKIlxxrA/vTdHehDXUOocxzJrIy3gu+khhV+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rofJ5Y7/ZW3AbkHlIwgRfkQEIKohMcZl/Ol2wJO5N5H9Vyv7A46XL+QLLOrC+ZxoBBhDRwSLB+0ZQh8atfOkyy91eBx0qgoIpYvwo88tFDXBoaFbSVx/qBUJf3SYH25CYZvPY8eMUzaocAorTTaaee68QIzZ0hZ1fyLtD3wNpJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nljiXZaw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nljiXZaw"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4359228b7c6so576386f8f.2
        for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 03:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769082423; x=1769687223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/c04FssyRzWAvFZbUZZ5iSwy4KaO1b4NaDQ9GK8JLME=;
        b=nljiXZawh5QxydA4lbo89SOm6Z5RduUhSqUBtra9we1Svfex2VEIf860MZoiYSNwow
         Q7dTem3yaRi1Pm57q/7He6mqWTLV55hH67oAbdm8VybY0K95d/umdKxgRfgJjj/ReFQd
         peOUFEAhJji17Q4l5c9oqDNwEjfRdHuPZ7GJ1rTO6/qCPaCDnmpnF5aQM0HtHerG4Ljv
         ccfpfM37hGbhRqBlN+54iBu05VAD1kreB0csgIgVM+xW3c6rOhHZScVQzYMjU6silAOx
         xWBcUQOsAmsQtVBgbhykOCRtAhr2ioAbGwk207natgOb0+EZLQlj4GIQ94Pjf+6/MvxK
         ccCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769082423; x=1769687223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/c04FssyRzWAvFZbUZZ5iSwy4KaO1b4NaDQ9GK8JLME=;
        b=FLgfMsn2w0/VjQMoENrNKIp7Gzb8g6uDcSScCoU6jQxxeJo/dX8cX1kOPeRfE418bl
         MXQIqKWduuWNCe9qCqzCAY6zh9DcB7idYMwDi92LvIfMRvq+kVklP+YsJ+10HuxVVszc
         XVj84mZ6kJQnTJ3xf0oOgGzR+UIL5dAJ0/CJoayKw/z8yf84e++5wu2jsKj/Yj3/1XVa
         Ang+wjObcuDjTE6iD4fKlgjaySIMEaw1lggZIaq/M4WS4OWsHVcR8/JZwPAR5y43HgZW
         SjXgoxqQjGmlIqLocVurnNSVSfq7DlwBIMTt/DA7sBNxhWXVy2iSJ6rqafZhvbwkkGAp
         cBWg==
X-Gm-Message-State: AOJu0YxhWbjC9I5hzl6p0zfQ8bR/mYgSREeN3VrYi7ueHpmLj1FN2Xq9
	q7y3TZ0J6qvVxFwrCMq7JwPYnFK8qbdtMbPYcdDtGV4AoDXRE1FQEzM+
X-Gm-Gg: AZuq6aKnRLx09IYZp/sCdbRY2qffuBjkrzpkYZfkZCS+T6PB7Q5jO0jh7C3bjHxxzsa
	4VGLmwPMgh6fZKtkrbl6LCQJFptEhkgEZDQ1g8DuZnU0BYMsKmEurq5ybkEutO78bBJxHotDMY4
	5SdMWkeMnAZtCAj5kkoc9f75tObZKXHZ+v4tL12hOwghLX1U5KoXPh5f5yfe+ghVoaILMyJpe6q
	83qJpSqJhOp1UiZb/hSdG3OhaqVz/VM14OEawfVTjd0/iXAayuetUIm/QwJ0EG5Xl+i5TaeZioQ
	Ds3xIjZ6fc2Xr+SIxROzglIlP7EgF+anGKyTwzHIuz2FR/VZnaptds0icHhHgByZ98wdQ8kNJTy
	voukLWLUBWPuolwZz5aRvsCzkTlT/Hq4celVTb3DgJUnDRAtgbvnYAGIH4wS6/0AKCxciro009K
	4IMwXfPsDbwL0j9JCxA82xc51Dfj1yLfRT1jfdLfQMkRDWx9CJ2cHZJvQxT/SDEg6z0vHyxupud
	B7wsKo7+6S9ghgcaJ8fdnXPls/N46Mrz0G6pd8hle1c+a4=
X-Received: by 2002:a05:6000:144b:b0:435:95ce:836e with SMTP id ffacd0b85a97d-43595ce838amr11818024f8f.55.1769082423045;
        Thu, 22 Jan 2026 03:47:03 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:46c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f138e26sm19447555f8f.17.2026.01.22.03.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 03:47:02 -0800 (PST)
Message-ID: <d3389449-f344-48ae-ab13-697e01d1cc46@gmail.com>
Date: Thu, 22 Jan 2026 11:46:59 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
 <CGME20260121074135epcas5p2eeb621d6acc9b4b73e6d45f5a40c078d@epcas5p2.samsung.com>
 <20260121073724.dja6wyqyf5apkdcx@green245.gost>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260121073724.dja6wyqyf5apkdcx@green245.gost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/21/26 07:37, Nitesh Shetty wrote:
> On 23/11/25 10:51PM, Pavel Begunkov wrote:
>> Add blk-mq infrastructure to handle dmabuf tokens. There are two main
>> objects. The first is struct blk_mq_dma_token, which is an extension of
>> struct dma_token and passed in an iterator. The second is struct
>> blk_mq_dma_map, which keeps the actual mapping and unlike the token, can
>> be ejected (e.g. by move_notify) and recreated.
>>
>> The token keeps an rcu protected pointer to the mapping, so when it
>> resolves a token into a mapping to pass it to a request, it'll do an rcu
>> protected lookup and get a percpu reference to the mapping.
>>
>> If there is no current mapping attached to a token, it'll need to be
>> created by calling the driver (e.g. nvme) via a new callback. It
>> requires waiting, thefore can't be done for nowait requests and couldn't
>> happen deeper in the stack, e.g. during nvme request submission.
>>
>> The structure split is needed because move_notify can request to
>> invalidate the dma mapping at any moment, and we need a way to
>> concurrently remove it and wait for the inflight requests using the
>> previous mapping to complete.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>> block/Makefile                   |   1 +
>> block/bdev.c                     |  14 ++
>> block/blk-mq-dma-token.c         | 236 +++++++++++++++++++++++++++++++
>> block/blk-mq.c                   |  20 +++
>> block/fops.c                     |   1 +
>> include/linux/blk-mq-dma-token.h |  60 ++++++++
>> include/linux/blk-mq.h           |  21 +++
>> include/linux/blkdev.h           |   3 +
>> 8 files changed, 356 insertions(+)
>> create mode 100644 block/blk-mq-dma-token.c
>> create mode 100644 include/linux/blk-mq-dma-token.h
>>
>> diff --git a/block/Makefile b/block/Makefile
>> index c65f4da93702..0190e5aa9f00 100644
...
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index f2650c97a75e..1ff3a7e3191b 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -29,6 +29,7 @@
>> #include <linux/blk-crypto.h>
>> #include <linux/part_stat.h>
>> #include <linux/sched/isolation.h>
>> +#include <linux/blk-mq-dma-token.h>
>>
>> #include <trace/events/block.h>
>>
>> @@ -439,6 +440,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>>     rq->nr_integrity_segments = 0;
>>     rq->end_io = NULL;
>>     rq->end_io_data = NULL;
>> +    rq->dma_map = NULL;
>>
>>     blk_crypto_rq_set_defaults(rq);
>>     INIT_LIST_HEAD(&rq->queuelist);
>> @@ -794,6 +796,7 @@ static void __blk_mq_free_request(struct request *rq)
>>     blk_pm_mark_last_busy(rq);
>>     rq->mq_hctx = NULL;
>>
>> +    blk_rq_drop_dma_map(rq);
> blk_rq_drop_dma_map(rq), needs to be added in blk_mq_end_request_batch
> as well[1], otherwise I am seeing we leave with increased reference
> count in dma-buf exporter side.
> 
> Thanks,
> Nitesh
> 
> [1]
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1214,6 +1214,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
> 
>                   blk_crypto_free_request(rq);
>                   blk_pm_mark_last_busy(rq);
> +               blk_rq_drop_dma_map(rq);

Ah yes, thanks Nitesh

-- 
Pavel Begunkov

