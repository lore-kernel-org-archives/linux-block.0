Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D724113D
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445640; cv=none; b=TRriPqGgqf/nJoi7CNoXDXEcpVLmr98XoBHHxu8gpR1BnqAA63OUETBZwd++n7iyYadtAP1v2Qefci8sZdDTr7BRhCt9ncsshbdblqTWAdxALUYjfv7mrxqiDochYYk36MoY8JTqsR0MHZ1MD+uzZkxKfRmUgMH6J1aRMmEMI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445640; c=relaxed/simple;
	bh=f4wl+vcgIKBIOjO4jpW10mqP3jLPh7VleEMc3RPonzo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t/nnBxkOk1zluA1WCmlwp3AuiuVHaEI5aZvn/oGzbhTv5+2aWaoK829vPS2YRoxe60AiWaS1XgAyAgORvE2Br4YWYHfaIzX6RUekJKXT7S/EQP/pXxsE1ymhQ35Y7h9q0rMT0YUguwR+CeuHtJKW+hz4eR0JtOqvxVdlzbvrNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WtvISMKI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WtvISMKI"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74264d1832eso2384458b3a.0
        for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 05:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753445637; x=1754050437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs7OnM/L49OqrbcCYuablnaOFePtlu3SrrQ5ImGKpvU=;
        b=WtvISMKITNPG+ZXN7VjGBd/pHjhtsfsfEHMYxqaOLKNe6SAFQgrRehWrHYGYLNy85Z
         hyBdd/7lySEZoUmGdluJm7y+j/6UF+88JVHoR6mpVqx4TOvLQK7IH1M5UHtDAK/KfXyK
         S1byDl7eTPbwaC0Q+YFDWNqmDli6rMUegk9sP+nS29U+vpmbwZ0AEj6l+huM/jtuhljJ
         PI/PgQZl4Mor1dlyfFE1Apm6ol42t6BBqvAgQwlQknk6y8lr/AQgn7wXGFr/Icv3X4co
         eLaJn3M9TfehchHZ4xz/GEFVoLd7bzW/sJfNT0cwJvFhmcx7tYDIyV5F96EbKcKn8OlJ
         jRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753445637; x=1754050437;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fs7OnM/L49OqrbcCYuablnaOFePtlu3SrrQ5ImGKpvU=;
        b=lLkGxN8xxCFPzh9emfk4DtxKAIRPNeX+skOk5xdWBOaIZ+gMvBrFR3f0q5aqtMWBGh
         Rais7i6tvgg1o9XIMgON+14RkxD8QEvfZSzOy368OcqmIcpj1m+I6crbxhZCAfi9y9CU
         nQGnp9QANYq/WXAh/l/qBz4xwCgHwV+AQ5q27muh0SJ+QQwfocjmW6oLbFn+X50WDlCn
         Vla0DhptN/ZyqhRZZThIkTZRFrGYBjOZ74Tt4aXl3CzLbz5iAKtcpNN3SRRaF7Emjmvm
         DhiiDtY/4XSkD+6cbYWUNs+m0DNomiFlNT/oBa3C6NB9MNBjJYiBxDFnQh0Vz1B/kFr9
         o9NQ==
X-Gm-Message-State: AOJu0YwKMfGue5DzRqeP7CaEHZiz3M+c09J8iRCEUX/TVbIm2TrHqecX
	aiU6PEb2zkpOA2GvrkthH7vO78FOnaACyruia076EQ2urTcCHVfy6vL1f7nEVbODf6c=
X-Gm-Gg: ASbGncuiooWM04HUXxEuZrP723COGmIy7KdnbPAbINz8Hrhq7CRogw8jCUTLAo5h10X
	NtD6hQHgb+N4gio0MRYmGUw/zp9nzBp/WIeJAiYIT+rINiURyClxrtMxNHalyYT6ipuitbwQ/Wp
	zWsKbNrkJrteb5M6zGliKa7lkSm0Sca32Cxwg7lJQdON59V6VxXRK2acXj3Y24tqJKg4ohHj6uk
	IjwduXrnxYM4li26PLxeMPARVnP4nh6UUFNtu/dkVx/jjOPXuXDGT/PrYz3bSzAYV027zov0hga
	eKFUsae+M8xwsGibHHyc7YhMqDsJ0RweeLFHQDDrHqucW4TYDcfauV9kXVAO82KXtbR62PFplR+
	YvG7cgsncSp9iq90/pJ8U6MWl
X-Google-Smtp-Source: AGHT+IGDAf5msIeWgMblo6PBl+lsfu7V3ivd2t8RBFUkADmEkDCNh+IldhpH6lvH4doJdr8tMlES1w==
X-Received: by 2002:a05:6a00:139f:b0:742:da7c:3f30 with SMTP id d2e1a72fcca58-763377f0704mr2877289b3a.19.1753445637497;
        Fri, 25 Jul 2025 05:13:57 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b0622bdfsm3772083b3a.121.2025.07.25.05.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 05:13:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: yi.zhang@redhat.com, hch@lst.de, ming.lei@redhat.com, 
 yukuai1@huaweicloud.com, yukuai3@huawei.com, shinichiro.kawasaki@wdc.com, 
 gjoyce@ibm.com
In-Reply-To: <20250724102540.1366308-1-nilay@linux.ibm.com>
References: <20250724102540.1366308-1-nilay@linux.ibm.com>
Subject: Re: [PATCHv3] block: restore two stage elevator switch while
 running nr_hw_queue update
Message-Id: <175344563631.580395.16494421873653438111.b4-ty@kernel.dk>
Date: Fri, 25 Jul 2025 06:13:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 24 Jul 2025 15:31:51 +0530, Nilay Shroff wrote:
> The kmemleak reports memory leaks related to elevator resources that
> were originally allocated in the ->init_hctx() method. The following
> leak traces are observed after running blktests block/040:
> 
> unreferenced object 0xffff8881b82f7400 (size 512):
>   comm "check", pid 68454, jiffies 4310588881
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 5bac8b34):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x419/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     0xffffffffc09ceb80
>     0xffffffffc09d7e0b
>     configfs_write_iter+0x2b1/0x470
>     vfs_write+0x527/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff8881b82f6000 (size 512):
>   comm "check", pid 68454, jiffies 4310588881
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 5bac8b34):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x419/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     0xffffffffc09ceb80
>     0xffffffffc09d7e0b
>     configfs_write_iter+0x2b1/0x470
>     vfs_write+0x527/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff8881b82f5800 (size 512):
>   comm "check", pid 68454, jiffies 4310588881
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 5bac8b34):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x419/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     0xffffffffc09ceb80
>     0xffffffffc09d7e0b
>     configfs_write_iter+0x2b1/0x470
>     vfs_write+0x527/0xe70
> 
> [...]

Applied, thanks!

[1/1] block: restore two stage elevator switch while running nr_hw_queue update
      commit: 5989bfe6ac6bf230c2c84e118c786be0ed4be3f4

Best regards,
-- 
Jens Axboe



