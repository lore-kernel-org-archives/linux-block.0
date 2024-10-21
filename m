Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B53D68;
	Mon, 21 Oct 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524477; cv=none; b=szncLd/u4i8CF+ZWpT6mHwKnyeyBKIdbbGggc54hzUMLM2i/rSZl3Lndz8G4aiUBDsS9UUTR13xsZXQ4C/fG06jYKOZmNi24XID2Zo4tqcVKpLVoDhxCAK3lgXRu5wg+Oa3GcdFty5B0ShQhsTzrPR0QchLN9k/SVs+3W04Quyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524477; c=relaxed/simple;
	bh=EhKv4lbBzS7rCDbkK2yFUL6LgmmXbVphH6XU8q+Ffr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYU9GqMQ/cNdbOhMVaz6MsW5z5Um5ttsvpWaLy5j+pgXtmy0+66IPlOHq9vo/WToLT4dU/r6Mmy3YHSanGZm8zT/kctOj4I4lMELkW7zPPEvOSpEb6uJ4Nyfi6vODwKxbTaHyWLfb1prUV199HmpWB7nOOJC21SjrZ9C80Uf2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d49a7207cso3387912f8f.0;
        Mon, 21 Oct 2024 08:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524474; x=1730129274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPNYpFd/xwLgKe8tmdP26yJlWnsjulWDdXDNr81wB04=;
        b=eDYaqTr+/o1wUa8fWzy5vCdcI1BNY02Ssl29IMitizpaVxl3JA8TpadC25ZVjLJEos
         0chzN3CgNnYdlccoG6ftImCz4nouBmqwX28RW+Xana/R1Ru3j7m2ZJyI2WzKTtZBQMBg
         liZDOpe4kVKREiRIinbeGYBbhOM3pqlkbjvnCmRYFxeX4j5yEXU3mLev50lrIosHHjfw
         3emB7/mqblIhYFx35RM185yUrUT60nGubjmQbTDyZH8Y7b9hKgdCoFw41xJTcKkcTtkf
         jcqSFMXRVanZGLl3ZjhfLiC5iJDJU+GvgTgrrhlUfOotfv2P1lxXAf42OrSVAAXprtD6
         TDeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZAy0P5FLH97hkXH8hCSUCAskRYTG0nfyJkUGQesAOhYaW6Er6lM4nh4O4ryKuC7wLLdCvQqABsj3AjA==@vger.kernel.org, AJvYcCVqevv/umQXndzcTOdqoM+rDdZeQGrG/2a0RDv3Hlc7j0PdpLXDAWDUFj3u0cy5KRN99PndjHiYrET7qK5Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwunRJlEqBul2RfByM1A5PNgvCAGgNA0pcQmvEJB11fDJWx7e3H
	Kx8grIodj0an3pxbuqAi3qKlslvY22tFYzZrUMnsoB32JSJhCY/F
X-Google-Smtp-Source: AGHT+IHxOPVkphc+4ylvQkg4yvf6bqARGxtQ8CDPo9/Vc1nfBMf6q+Zr8IupvM0DYrzPxucpArfPyg==
X-Received: by 2002:adf:f6d2:0:b0:37c:d299:b5f0 with SMTP id ffacd0b85a97d-37eab6ec6camr7295086f8f.59.1729524473533;
        Mon, 21 Oct 2024 08:27:53 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a487bdsm4611998f8f.32.2024.10.21.08.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 08:27:53 -0700 (PDT)
Message-ID: <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me>
Date: Mon, 21 Oct 2024 18:27:51 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
To: Ming Lei <ming.lei@redhat.com>
Cc: zhuxiaohui <zhuxiaohui400@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora> <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
 <ZxYRXvyxzlFP_NPl@fedora> <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
 <ZxZm5HcsGCYoQ6Mv@fedora>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZxZm5HcsGCYoQ6Mv@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 21/10/2024 17:36, Ming Lei wrote:
> On Mon, Oct 21, 2024 at 02:30:01PM +0300, Sagi Grimberg wrote:
>>
>>
>> On 21/10/2024 11:31, Ming Lei wrote:
>>> On Mon, Oct 21, 2024 at 10:05:34AM +0300, Sagi Grimberg wrote:
>>>>
>>>> On 21/10/2024 4:39, Ming Lei wrote:
>>>>> On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
>>>>>> From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
>>>>>>
>>>>>> It is observed that nvme connect to a nvme over fabric target will
>>>>>> always fail when 'nohz_full' is set.
>>>>>>
>>>>>> In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
>>>>>> isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
>>>>>> and when nvme connect to a remote target, it may fails on this stack:
>>>>>>
>>>>>>            blk_mq_alloc_request_hctx+1
>>>>>>            __nvme_submit_sync_cmd+106
>>>>>>            nvmf_connect_io_queue+181
>>>>>>            nvme_tcp_start_queue+293
>>>>>>            nvme_tcp_setup_ctrl+948
>>>>>>            nvme_tcp_create_ctrl+735
>>>>>>            nvmf_dev_write+532
>>>>>>            vfs_write+237
>>>>>>            ksys_write+107
>>>>>>            do_syscall_64+128
>>>>>>            entry_SYSCALL_64_after_hwframe+118
>>>>>>
>>>>>> due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
>>>>>> blk_mq_ctx on the hw queue.
>>>>>>
>>>>>> This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
>>>>>> as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
>>>>>> indicate that block layer can fallback to a  blk_mq_ctx whose cpu
>>>>>> is not isolated.
>>>>> blk_mq_alloc_request_hctx()
>>>>> 	...
>>>>> 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
>>>>> 	...
>>>>>
>>>>> It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
>>>>> online CPUs, both are same actually from this viewpoint.
>>>>>
>>>>> It is one long-time problem for nvme fc.
>>>> For what nvmf is using blk_mq_alloc_request_hctx() is not important. It just
>>>> needs a tag from that hctx. the request execution is running where
>>>> blk_mq_alloc_request_hctx() is running.
>>> I am afraid that just one tag from the specified hw queue isn't enough.
>>>
>>> The connection request needs to be issued to the hw queue & completed.
>>> Without any online CPU for this hw queue, the request can't be completed
>>> in case of managed-irq.
>> None of the consumers of this API use managed-irqs. the networking stack
>> takes care of steering irq vectors to online cpus.
> OK, it looks not necessary to AND with cpu_online_mask in
> blk_mq_alloc_request_hctx, and the behavior is actually from commit
> 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each possisble CPU").

it is a long time ago...

>
> But it is still too tricky as one API, please look at blk_mq_get_tag(), which may
> allocate tag from other hw queue, instead of the specified one.

I don't see how it can help here.

>
> It is just lucky for connection request because IO isn't started
> yet at that time, and the allocation always succeeds in the 1st try of
> __blk_mq_get_tag().

It's not lucky, we reserve a per-queue tag for exactly this flow 
(connect) so we
always have one available. And when the connect is running, the driver 
should
guarantee nothing else is running.
