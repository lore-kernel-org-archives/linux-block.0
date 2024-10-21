Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAB1CF5F6;
	Mon, 21 Oct 2024 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494341; cv=none; b=a28SRGYp3C2Qikft3iinC08/+BEEQuQlMNV1BzOZcaI5jRr4tkM33D2v5bKsfus+8qPMbHcZB20xUe3/JXkhsLtXjjEGFMNrfIE1xHgHsGfAbfFm64wfcMsMtpDaumsapOObnAeawxWkgaE8oIIfoah46h2rAgvNI2xwT5zESf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494341; c=relaxed/simple;
	bh=84wmG/QqjIrtQQLbrCFY1D3Z/opjPo88jrJz0k32RHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sp7ILWUiYfrXOA7+qW2xMLF0kzXPWtwNicCdCOYsr6WQsaELELJDnT3uqXJMS1o/cnEVtLyOyHiTLQPDMiWZrDpnvivBOOT0qFNTTk2+JtyPm5GGTdeQvh2SKqbzJxaVqPLG/9Df5EF7koAUsBMjOV2ASfsPWATPbgHmNurZgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so32629175e9.0;
        Mon, 21 Oct 2024 00:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729494337; x=1730099137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuyasMgkP9ACihQpzbrksqcPeP7uWQUhYgegjJyc8I8=;
        b=oWAX9jY4mg6GduD2A37rkVYcnpRZkJkpKToXfWAa0eFD95AAyy919yzBt3S45d4ydJ
         +PhCNMwCpq3DKiGpy+cSkllmB1ynCGB9G7IOphLbq4aYCkTatH91N1jariOiIcXO1Pw4
         DgiD6RHSHBJ+YbGZEuc75VJNuz1M1UBfEsCU9oIqOlr86DQLcCdyT1k6ihGHi/7Q2Gej
         joD9TkDeBaNMoXuLbuVGTL26h5AJCL05Gd3a+DIqsn65RmPiWeA9V3O/KKiVdY97E8Mb
         7e5Zm0URQB8lNwyRy/08c3slxUN3Dr7QqwDYyFXTYg3/WJjpC65PQOU3nMhi9NUuOKjT
         CKxA==
X-Forwarded-Encrypted: i=1; AJvYcCVvafrsSCEJ8sh5xFX6uaknFZ6vn0H74LkREStDvTI47Iy6WfAiqjNCtzwzB7IWFaM8gqbqBLXasjzDdw==@vger.kernel.org, AJvYcCWMWC5Qo+/sN2yNHmX7aebm+GHepmnowq+lVWO08bJnXKWiV/Aa5QJeFu/ozwenPaqP60QamA6psUd9Txi/@vger.kernel.org
X-Gm-Message-State: AOJu0YyMzkETLrpEw32dSgOYmONvZmp/lJyCp/g3MrZYuv7fvmmPI93H
	bAZ7ZAMUaRAYy4xX/21xtBEpj03v6Nf80FPh1hVgbYiucNTD94WO
X-Google-Smtp-Source: AGHT+IG8O0M5kVa+Y0zMRDEF4giA3frmfFmV6DY0Rv6ItTOkBc3uE4a++W6C/asLcaygteal3Y9uQA==
X-Received: by 2002:a05:600c:1d09:b0:430:57f2:bae5 with SMTP id 5b1f17b1804b1-4316169a968mr69435105e9.27.1729494337054;
        Mon, 21 Oct 2024 00:05:37 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570c79sm46756225e9.3.2024.10.21.00.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 00:05:36 -0700 (PDT)
Message-ID: <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
Date: Mon, 21 Oct 2024 10:05:34 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
To: Ming Lei <ming.lei@redhat.com>, zhuxiaohui <zhuxiaohui400@gmail.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZxWwvF0Er-Aj-rtX@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 21/10/2024 4:39, Ming Lei wrote:
> On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
>> From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
>>
>> It is observed that nvme connect to a nvme over fabric target will
>> always fail when 'nohz_full' is set.
>>
>> In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
>> isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
>> and when nvme connect to a remote target, it may fails on this stack:
>>
>>          blk_mq_alloc_request_hctx+1
>>          __nvme_submit_sync_cmd+106
>>          nvmf_connect_io_queue+181
>>          nvme_tcp_start_queue+293
>>          nvme_tcp_setup_ctrl+948
>>          nvme_tcp_create_ctrl+735
>>          nvmf_dev_write+532
>>          vfs_write+237
>>          ksys_write+107
>>          do_syscall_64+128
>>          entry_SYSCALL_64_after_hwframe+118
>>
>> due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
>> blk_mq_ctx on the hw queue.
>>
>> This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
>> as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
>> indicate that block layer can fallback to a  blk_mq_ctx whose cpu
>> is not isolated.
> blk_mq_alloc_request_hctx()
> 	...
> 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> 	...
>
> It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
> online CPUs, both are same actually from this viewpoint.
>
> It is one long-time problem for nvme fc.

For what nvmf is using blk_mq_alloc_request_hctx() is not important. It 
just needs a tag from that hctx. the request execution is running where 
blk_mq_alloc_request_hctx() is running.
