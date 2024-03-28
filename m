Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443E134A5
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622324; cv=none; b=SrveezVp6H/nkcPuFEjqZ9nC9lwhMWXolhJnTLRrctIbY+LGEsHPDweUEmZ7/spmvu4ds4f+uzNhHtjXjZMZLX/Z4jFWeHv1vg/G3GPEJ7jPWKnScvK9p0+wc5+07IQXM0dgW3U/QnKhWlcnMIp2xrVOr5WuzxMLtff8gWLfhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622324; c=relaxed/simple;
	bh=ihnRth88gfZhdbclsxUWJRq8kdzIzsdGIhjcKycgpno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5BngqLBgw93q+9LNcJcyZHprRFbNY+zp1K3f6gqCc3pUJdWQA4kiUZ0LhRCsSJwuRSjtscYj3lrLZMA2JTksTLqej05nY/JZwoGyo1uts4iwI/uuPCK8n9NkWj9+spOQ09fXFyBQKPUv831CKSBCnVYvGrpXjtI/+7rGvpO5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-341bba83366so197528f8f.1
        for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 03:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711622321; x=1712227121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr5CVYVHQhlbInTEfSxMv7vhYKWCp3Kaeaw3PIRXnBw=;
        b=ZfbY0VMsxkzVoVmEmUUmmIqDWhB7ydnJNrBQdSet0PjO1F84nBpMDJrYwPLP2fMDJh
         TowulsU8rFktIcPHRUUK3EmiFe9Zln/F7uw45HX/POD1j6U4Hdni0t/d5YJbbYxtuq7x
         FsIdWq77pkf/ZDr4SU0JWYFLTxZKcEA+sBO0sY/k3kC02HNBWP0p3h/7aXWH/wrfVCj9
         S6Y8zglVGT47b2pqu3Eep8dEev+u3Pq+FUZe5kJgJB8osz0kdDrxsujGLzjJei/KgBIN
         pRycClvOZZZoPMi5n8ncJkGBkX4pSRJzT1WngnbxMCYgePF961fRabYoPA/hSNvI4EM6
         5/cg==
X-Forwarded-Encrypted: i=1; AJvYcCUqjsNVk9ads7JcWcQR1lUIP+ehPJHhytzBTBNftlSoC+p+eAT5veknu3KrpubzVDiTehY/vAY1PcZ5JYRfdF0HG4SGZSYPEGE5znE=
X-Gm-Message-State: AOJu0YzcT0pDLTA57oU6fQ/Nl504Z9Qi15BXDVvzfgggHbNyTlIr6NwN
	zbepYRufG8S8XCAav2nQwE/FupHl3hVFLwz7me8qCD7xWM8lvifj
X-Google-Smtp-Source: AGHT+IFou6tOPC7Ao+bhIwpk7Xu50MBOaItZV60Nzslc1N6So9zsFjJxO7Dq0ongdDNfQM+cUzaazA==
X-Received: by 2002:adf:e487:0:b0:341:e368:2c0a with SMTP id i7-20020adfe487000000b00341e3682c0amr1740329wrm.5.1711622320709;
        Thu, 28 Mar 2024 03:38:40 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id l2-20020adff482000000b0033ec312cd8asm1395501wro.33.2024.03.28.03.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 03:38:40 -0700 (PDT)
Message-ID: <5cade4b4-f19f-422d-ab93-bc853b1563d1@grimberg.me>
Date: Thu, 28 Mar 2024 12:38:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] block,nvme: latency-based I/O scheduler
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20240326153529.75989-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240326153529.75989-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/03/2024 17:35, Hannes Reinecke wrote:
> Hi all,
>
> there had been several attempts to implement a latency-based I/O
> scheduler for native nvme multipath, all of which had its issues.
>
> So time to start afresh, this time using the QoS framework
> already present in the block layer.
> It consists of two parts:
> - a new 'blk-nodelat' QoS module, which is just a simple per-node
>    latency tracker
> - a 'latency' nvme I/O policy
>
> Using the 'tiobench' fio script I'm getting:
>    WRITE: bw=531MiB/s (556MB/s), 33.2MiB/s-52.4MiB/s
>    (34.8MB/s-54.9MB/s), io=4096MiB (4295MB), run=4888-7718msec
>      WRITE: bw=539MiB/s (566MB/s), 33.7MiB/s-50.9MiB/s
>    (35.3MB/s-53.3MB/s), io=4096MiB (4295MB), run=5033-7594msec
>       READ: bw=898MiB/s (942MB/s), 56.1MiB/s-75.4MiB/s
>    (58.9MB/s-79.0MB/s), io=4096MiB (4295MB), run=3397-4560msec
>       READ: bw=1023MiB/s (1072MB/s), 63.9MiB/s-75.1MiB/s
>    (67.0MB/s-78.8MB/s), io=4096MiB (4295MB), run=3408-4005msec
>
> for 'round-robin' and
>
>    WRITE: bw=574MiB/s (601MB/s), 35.8MiB/s-45.5MiB/s
>    (37.6MB/s-47.7MB/s), io=4096MiB (4295MB), run=5629-7142msec
>      WRITE: bw=639MiB/s (670MB/s), 39.9MiB/s-47.5MiB/s
>    (41.9MB/s-49.8MB/s), io=4096MiB (4295MB), run=5388-6408msec
>       READ: bw=1024MiB/s (1074MB/s), 64.0MiB/s-73.7MiB/s
>    (67.1MB/s-77.2MB/s), io=4096MiB (4295MB), run=3475-4000msec
>       READ: bw=1013MiB/s (1063MB/s), 63.3MiB/s-72.6MiB/s
>    (66.4MB/s-76.2MB/s), io=4096MiB (4295MB), run=3524-4042msec
>    
> for 'latency' with 'decay' set to 10.
> That's on a 32G FC testbed running against a brd target,
> fio running with 16 thread.

Can you quantify the improvement? Also, the name latency suggest
that latency should be improved no?

>
> As usual, comments and reviews are welcome.
>
> Hannes Reinecke (2):
>    block: track per-node I/O latency
>    nvme: add 'latency' iopolicy
>
>   block/Kconfig                 |   7 +
>   block/Makefile                |   1 +
>   block/blk-mq-debugfs.c        |   2 +
>   block/blk-nodelat.c           | 368 ++++++++++++++++++++++++++++++++++
>   block/blk-rq-qos.h            |   6 +
>   drivers/nvme/host/multipath.c |  46 ++++-
>   drivers/nvme/host/nvme.h      |   2 +
>   include/linux/blk-mq.h        |  11 +
>   8 files changed, 439 insertions(+), 4 deletions(-)
>   create mode 100644 block/blk-nodelat.c
>

