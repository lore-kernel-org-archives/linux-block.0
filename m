Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52828213254
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764211771; cv=none; b=sX85cAUR4w6uE+XLWfjpI9QV98pgTAXxsbagDItx6gKMs6uTq4Dmm7B+O4FU/5PPeLgo/NklppRCIaPaHg9paeOZWEJKeXgPO+guw3fAKtuO+yumsTSgH+zbZT+pv6qhtwcXmejnfuBWjZDrn2wrznjmCBb6FRL8Vt1HcnNOpqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764211771; c=relaxed/simple;
	bh=YBSfdUK1Na6s5st1li1/YbDbuf/FaJeJWi9KOUaZZ4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIdAyUnntuxvODuVOR69mvuywUcmTOgeuXpjf+w0s4q6YNOZrQZ4Kfa6Ie0jExRO7d2W2ZHaTvnU+Y+e/Uuc+j5v2IcwGOaQ8JkFLCZSTtlEuMdjpL11klEK1XUXcIE7MTObA9HybJIRjUbNAPHEA9Sq76gM9sML2071XMg4UdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fS0XcNK+; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fS0XcNK+"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-433217b58d9so2390055ab.1
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 18:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764211767; x=1764816567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEC7MQMEWTMqZkr1wpkXMaWU9u11UUKRFRMEMd42Q5A=;
        b=fS0XcNK+FROkACUJafXNGIyAijyOn0T1BN+G8FA78vPyrNOKVQahsB5FDM5alHmGvZ
         z9TUhq6g+uugfSn4sqpXPjMQmdG7xRP19s9krTufoRYs1Bn5ZvyrCJY6gdqjZHB2VnJP
         KP8utuUwfE4yvXMclMpMtOBcD6outJOiFfqwjzeCWb1EYU9oqR34ZQR7YPh5LqJjpy6F
         9sDh2iYFcpilZSxyeY8udWrw6PSMxS2MNzwSitUvx5bMwWI1BfcGoD57UMiXowjSAvdu
         IA8f51FpHWOF99iF2O39IfGKzNtU8ayQ3Xf8u51IQ2BrUHNY6fDRB0YlCLgC8hHwAloU
         CNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764211767; x=1764816567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEC7MQMEWTMqZkr1wpkXMaWU9u11UUKRFRMEMd42Q5A=;
        b=qGDcR26dxmp/IUbx2gptMG6sJcdLbyv4kcv742DHzPT6AG5sk8FMnwknSOZ/Qf0YZR
         Kh6SaLoCrZvOcxDihbpcUS272MQY9/SMl9jtepHnHTe8xsjMqgUD+1yeDOA8+5AcWL1K
         ZkTLVz/fkfuf2ZVxr6hB4VYVn/dW6quMLaHhUm6/tVMcWu165vSMR3FLIZscvjQsy6qT
         zdD2jqiBm/wd7nO7PcN91lmez834SnahtvdJ1QmICcSnId5662VmkurJYfGJsGYwITtb
         2JZ8PMrWWfJABz52qJf5gvlK5goS3dG8s1FXMg1JIoL7VSu0mjx+Kk0b7CjJgnA+4DWe
         s1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCztlILlJ4v7o8x9fEB/XKhSCFqJhGCbDiBPinlDqAunMTA8WQEG6qQfBRxnDh2ui/qZwhJcWRexGXaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsXppRNftHonJR2Zk6NHihZW37cDBWqZE81RLralWfzgSIVtZ
	q1MepPOH0q7R4wh7/dnZ3kU5VSZtMdoLnitn+ObQ7NCsxpqK3ntJHgHMYRYaKVIqUxU=
X-Gm-Gg: ASbGnctTW0RhCZsUySF69Fsx2puo1McDISCgFZFeDVUoQDvGdAPyNiDQXk2wiBWaLDD
	ZH1ttWyrN3XH1tK/kfBwXiEEFy/w64TEg/OGv8Bzwcyf/mxmoMBB+ZEF1i4at1V11blUYAcLitw
	SQvJGvCkRWr8xaIt+K/+uc5Ir6lPE4vWiHlRnMBh3M8t9cFQMl1wWvKkLJL9MK1dIYsH5AC+2v3
	l9EN3zpznEAT4YXW80Ew+RW08Dnsis2pTMaju2bX4tm33nxCBq5Z+Yyep8Nm1XLQCEURKoWfsTH
	rBRtpVHrOPNoEW6MNN9c8zy0BvfXdl/rvqEjstcQdK+Fq43RGLT4tNhWQjSpczG/cKn6foBQgeT
	3KkaHjmRYe4MwUUwIb71ybg5iXOiFxwPgrO32TFY9RsYv+d4PZcjgL56x7XlZvTg1BkVhcGNR83
	jNPk0VV9Y5
X-Google-Smtp-Source: AGHT+IEzYXmXayDgt/IWjIckeiALWYy5af5OlWlc2br/tplg9mWmuvZtJuvJ5IaYTXvR4m23bcBzjQ==
X-Received: by 2002:a05:6e02:1102:b0:433:71a9:8f9e with SMTP id e9e14a558f8ab-435dd050f46mr65258015ab.7.1764211767402;
        Wed, 26 Nov 2025 18:49:27 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-436b85c5301sm1458805ab.26.2025.11.26.18.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 18:49:26 -0800 (PST)
Message-ID: <f7a406c0-ca24-4367-9e0d-fb7bfe91df3d@kernel.dk>
Date: Wed, 26 Nov 2025 19:49:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] blk-mq: use array manage hctx map instead of
 xarray
To: Fengnan Chang <fengnanchang@gmail.com>, linux-block@vger.kernel.org,
 ming.lei@redhat.com, hare@suse.de, hch@lst.de
Cc: Fengnan Chang <changfengnan@bytedance.com>, Yu Kuai <yukuai@fnnas.com>
References: <20251127013908.66118-1-fengnanchang@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251127013908.66118-1-fengnanchang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 6:39 PM, Fengnan Chang wrote:
> From: Fengnan Chang <changfengnan@bytedance.com>
> 
> After commit 4e5cc99e1e48 ("blk-mq: manage hctx map via xarray"), we use
> an xarray instead of array to store hctx, but in poll mode, each time
> in blk_mq_poll, we need use xa_load to find corresponding hctx, this
> introduce some costs. In my test, xa_load may cost 3.8% cpu.
> 
> After revert previous change, eliminates the overhead of xa_load and can
> result in a 3% performance improvement.
> 
> potentital use-after-free on q->queue_hw_ctx can be fixed by use rcu to
> avoid, same as Yu Kuai did in [1].
> 
> [1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.com/
> 
> Fengnan Chang (2):
>   blk-mq: use array manage hctx map instead of xarray
>   blk-mq: fix potential uaf for 'queue_hw_ctx'
> 
>  block/blk-mq-tag.c     |  2 +-
>  block/blk-mq.c         | 63 ++++++++++++++++++++++++++++--------------
>  block/blk-mq.h         | 13 ++++++++-
>  include/linux/blk-mq.h |  3 +-
>  include/linux/blkdev.h |  2 +-
>  5 files changed, 58 insertions(+), 25 deletions(-)
> 
> 
> base-commit: 4941a17751c99e17422be743c02c923ad706f888

Adding correct Yu address, was also wrong for v1 and somehow not
corrected?

-- 
Jens Axboe

