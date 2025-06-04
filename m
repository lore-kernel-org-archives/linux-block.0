Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C823E33D
	for <linux-block@vger.kernel.org>; Wed,  4 Jun 2025 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749021008; cv=none; b=N4R3dGaPJvx1YKcVr+aAmzNn5ZOLZleuhXLRTrHZSM+LJZh7aTkVe4c4Zlh4m2+xOWoI9QyEP2GYQuNg8RIDXmGI/FukivTOfMiHQy4+4MhKe9YphseewoFZ/qTNn1lP3Hvqdd/bWPf1XjhyO/3ONGKxhA/ePcAN+JpgKMiJ+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749021008; c=relaxed/simple;
	bh=Daf5PtKb+ZIskZ4w+OPkPbwNltVlW2dhcrdxjxXYj9k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bptf3lc8xuLs2HMuXPIs2gZ6SN8ltV145eWrYL72ZepO7/XFek1k9MhuZOqnQhoO64OxVdXNpbejYeSZCwy54nhLti5FZNOIkp6LDPQ447zhsMDpDJpu8/PMUv2wDz/sz7GNWmy2hl+vScLsGs4ipVXB47J7J7G0uwti2R1HHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d3f72391so47412355e9.3
        for <linux-block@vger.kernel.org>; Wed, 04 Jun 2025 00:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749021003; x=1749625803;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJPaiZJsxvLRj8n9GtUojsvWhjC5TJnVjUXCQvcGx+o=;
        b=sLVy816kkGiyYrP763iTl7Euf9YtQBejNM/pFHytmOQmTLwqrDFvtwh+NuzMZHZmcA
         8vSSMfjtLiYHj6H2b6IVI1L8w5HhBxK3Pfs7xzIKByVEJryr12NAGDLvRtyxerb90K1t
         ar+ngMS4OHaXjFNrn9BnHHDC81yor+Y5OPrNmgULU6pXJdtodoauIoE+V/61vsrcBoNj
         dbP9doj1upOImWwg1sC5Vq2TOLjGZN9fLTHXbcqwy8lznjXkuvvjqSmmcOmCFq32btRt
         3/QoCdUp1dfEm/iOg5YfKkWoB+8SuyQ5FiHYNxJd4d70npJWC5p/GCQwejGkt6nw9BYe
         fLzw==
X-Forwarded-Encrypted: i=1; AJvYcCUddHI1kBeQZgpHYTn7Pn4puCIP7h+fBVZyskC64AyiuEz0uOsxnkmY9m0PPhlXlhNj2D2BSMbVczjGyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YypJpmaHKZAiVTdWTb60IMIdzklC8VYF5EXUkyfamxcuozxqrwr
	XA51yzIPuXPDIBcCGAyvgnR29zg3LyvuzxFT1iuSsXrY6atUI9LFDckz
X-Gm-Gg: ASbGnctq6R3QMOIcMSfUOgZIORRGivza5rRLHTr71Z1CBw4VQwD74WHqYjIPazU+Rzf
	1/1xUZj/y5/3TFxdUGosXeXuYCCYtMl5ukDbB31XYrhR6ljoinLZWfPQKXq6LD0zwQE59bqFrhJ
	sFjNgCJtR7bbwBTwudUlwYoixRbLP5X/dRf4Sn7OR4zOMSGed+zq5UJK8wbiyodJyoz1eA1qmVh
	Z1glUL1ZxXwsPjx3FirE08xfhEF6BBdalw5RcBq30hO4SczxV+8Rnz5ya7qSmxkfXKSIxivBywt
	Xt3iZ8pISZDHgSe866cfntVOUAyDEQruqdcCRh7+bmWdbHBw0YfOgbqIGPO7sATCfzuNPAD0BMs
	xU66taLoodCjAQXRRWw==
X-Google-Smtp-Source: AGHT+IHon9DfcaPAiiToq2KeOmfxWZMKIYrPebJyfC50rCjcnfdd1+uduc+AwTinWfVAAaGbZImElA==
X-Received: by 2002:a05:600c:a015:b0:442:f8e7:25ef with SMTP id 5b1f17b1804b1-451f0a757bcmr12398775e9.11.1749021003216;
        Wed, 04 Jun 2025 00:10:03 -0700 (PDT)
Received: from [10.50.4.239] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb0654sm188090925e9.21.2025.06.04.00.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 00:10:02 -0700 (PDT)
Message-ID: <86e241dd-9065-4cf0-9c35-8b7502ab2d8a@grimberg.me>
Date: Wed, 4 Jun 2025 10:10:01 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
From: Sagi Grimberg <sagi@grimberg.me>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block <linux-block@vger.kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
 <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
Content-Language: en-US
In-Reply-To: <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/06/2025 13:58, Sagi Grimberg wrote:
>
>
> On 02/06/2025 7:35, Shin'ichiro Kawasaki wrote:
>> When the nvme scan work and the nvme controller reset work race, the
>> WARN below happens:
>>
>>    WARNING: CPU: 1 PID: 69 at block/blk-mq.c:330 
>> blk_mq_unquiesce_queue+0x8f/0xb0
>>
>> The WARN can be recreated by repeating the blktests test case nvme/063 a
>> few times [1]. Its cause is the new queue allocation for the tag set
>> by the scan work between blk_mq_quiesce_tagset() and
>> blk_mq_unquiesce_tagset() calls by the reset work.
>>
>> Reset work                     Scan work
>> ------------------------------------------------------------------------
>> nvme_reset_ctrl_work()
>>   nvme_tcp_teardown_ctrl()
>>    nvme_tcp_teardown_io_queues()
>>     nvme_quiesce_io_queues()
>>      blk_mq_quiesce_tagset()
>>       list_for_each_entry()                                 .. N queues
>>        blk_mq_quiesce_queue()
>>                                 nvme_scan_work()
>>                                  nvme_scan_ns_*()
>>                                   nvme_scan_ns()
>>                                    nvme_alloc_ns()
>>                                     blk_mq_alloc_disk()
>>                                      __blk_mq_alloc_disk()
>>                                       blk_mq_alloc_queue()
>> blk_mq_init_allocate_queue()
>> blk_mq_add_queue_tag_set()
>>                                          list_add_tail()    .. N+1 
>> queues
>>   nvme_tcp_setup_ctrl()
>>    nvme_start_ctrl()
>>     nvme_unquiesce_io_queues()
>>      blk_mq_unquiesce_tagset()
>>       list_for_each_entry()                                 .. N+1 
>> queues
>>        blk_mq_unquiesce_queue()
>>         WARN_ON_ONCE(q->quiesce_depth <= 0)
>>
>> blk_mq_quiesce_queue() is not called for the new queue added by the scan
>> work, while blk_mq_unquiesce_queue() is called for it. Hence the WARN.
>>
>> To suppress the WARN, avoid the race between the reset work and the scan
>> work by flushing the scan work at the beginning of the reset work.
>>
>> Link: 
>> https://lore.kernel.org/linux-nvme/6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm/ 
>> [1]
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> ---
>>   drivers/nvme/host/tcp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index f6379aa33d77..14b9d67329b3 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2491,6 +2491,9 @@ static void nvme_reset_ctrl_work(struct 
>> work_struct *work)
>>           container_of(work, struct nvme_ctrl, reset_work);
>>       int ret;
>>   +    /* prevent racing with ns scanning */
>> +    flush_work(&ctrl->scan_work);
>
> This is a problem. We are flushing a work that is IO bound, which can 
> take a long time to complete.
> Up until now, we have deliberately avoided introducing dependency 
> between reset forward progress
> and scan work IO to completely finish.
>
> I would like to keep it this way.
>
> BTW, this is not TCP specific.

blk_mq_unquiesce_queue is still very much safe to call as many times as 
we want.
The only thing that comes in the way is this pesky WARN. How about we 
make it go away and have
a debug print instead?

My preference would be to allow nvme to unquiesce queues that were not 
previously quiesced (just
like it historically was) instead of having to block a controller reset 
until the scan_work is completed (which
is admin I/O dependent, and may get stuck until admin timeout, which can 
be changed by the user for 60
minutes or something arbitrarily long btw).

How about something like this patch instead:
--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2697db59109..74f3ad16e812 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -327,8 +327,10 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
         bool run_queue = false;

         spin_lock_irqsave(&q->queue_lock, flags);
-       if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
-               ;
+       if (q->quiesce_depth <= 0) {
+               printk(KERN_DEBUG
+                       "dev %s: unquiescing a non-quiesced queue, 
expected?\n",
+                       q->disk ? q->disk->disk_name : "?", );
         } else if (!--q->quiesce_depth) {
                 blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
                 run_queue = true;
--
