Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115EC4F8B1
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r+QAwHLO"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-360412acf3fso2327605ab.0
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704989545; x=1705594345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lc8przq4SBWAgSQ3hxGCXOpGtWYOA8/gdD28Wl7y8i0=;
        b=r+QAwHLO1OLQqMcyfDl9g7gwZYQgokxilOUvOcnwnnKZDYb7OaGUrw+vkeZMrbCs/l
         /YB2nu1xNMK4QLXBnU4I0wtnOQVQYBqSpy8CMjcarOCvPp6jCSdgcJAWEiF5DgNmAHAc
         oE1ItMYYaaZ2jHqurggXXUMPptE9A9iZtioRZ3IbCF+JfG+QDx9qfeKQWINcYp1I4Ky0
         L89M2yVhFPmi/8NtfiTxk1rbn5rKcegNapF0PwIz+xsk4krSQeTniYd3MZwwcuw01ZON
         nn6NnqGBAtUf8yvCgIH4ztzT+MtQtxkKKTO8zKMqxkW5+T5Ru6hnx3J186J2fk8GTpFb
         LROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989545; x=1705594345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lc8przq4SBWAgSQ3hxGCXOpGtWYOA8/gdD28Wl7y8i0=;
        b=iSSp8N//9xSxZfR1iuktJffL2NkvrwNt8JQE3gb6F2KnYBxVfSkajGPT2tT1GG1YB5
         aWovX12o5rZxm7x1hWL6nPznQGGW2Fwkik9hJfqj4qcp/6Bds7SC7PzZogGkn8oshEEI
         xoHtSWP5d7PU0WWtHUOF+5sd3mFsAQWb4eOnvEgURZGT8gwj7t+Evnp0TRHR7iwjobxb
         mZSriCHwCpVgYiqpnDZrbvHi5uor7pTtbO3IZ5bAxBCkj+TteA7UEdFMhWNO8Qx/qR2j
         P0TL1CP8jo80zJVzGw4jDN7a1ME6W0aOOG4OOkjxT9PAlUFEVCUR2FoHhS5crlHlHEs/
         2mrQ==
X-Gm-Message-State: AOJu0YzFzh2UAgBDoHeMQ53QmwFScE3KbT9ESPHWRIBwjIQgXFNu2BYx
	lo3uSN9IAupjV+t2aB4pWJZ9SAfvphQkrg==
X-Google-Smtp-Source: AGHT+IGPUrWLUBhD9dKz0fGjV72+YoZCYawd0anZkh0Xob0aXI5/SlgBCtXgzE7+6VYOH3ERmJ3pog==
X-Received: by 2002:a05:6e02:19c9:b0:35f:d4dc:1b1c with SMTP id r9-20020a056e0219c900b0035fd4dc1b1cmr2873800ill.0.1704989545120;
        Thu, 11 Jan 2024 08:12:25 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ck12-20020a056e02370c00b003608a649906sm376084ilb.43.2024.01.11.08.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 08:12:24 -0800 (PST)
Message-ID: <d713fe1b-3eaa-4de4-99a6-5910247ffad5@kernel.dk>
Date: Thu, 11 Jan 2024 09:12:23 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-mq: ensure a q_usage_counter reference is held
 when splitting bios
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20240111135705.2155518-1-hch@lst.de>
 <20240111135705.2155518-3-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240111135705.2155518-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 6:57 AM, Christoph Hellwig wrote:
> q_usage_counter is the only thing preventing us from the limits changing
> under us in __bio_split_to_limits, but blk_mq_submit_bio doesn't hold it.
> 
> Change __submit_bio to always acquire the q_usage_counter counter before
> branching out into bio vs request based helper, and let blk_mq_submit_bio
> tell it if it consumed the reference by handing it off to the request.

This causes hangs for me on shutdown/reset:

[   56.146054] sd 6:0:0:0: [sdb] Synchronizing SCSI cache
[   56.147739] sd 6:0:0:0: [sdb] Stopping disk
[   56.148976] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   56.150803] sd 0:0:0:0: [sda] Stopping disk
[   75.549201] INFO: task systemd-shutdow:1 blocked for more than 15 seconds.
[   75.549636]       Not tainted 6.7.0-rc5-00173-g34d71db9cce2 #4540
[   75.549977] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   75.550401] task:systemd-shutdow state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00000004
[   75.550900] Call trace:
[   75.551042]  __switch_to+0x114/0x150
[   75.551253]  __schedule+0x510/0x10d4
[   75.551451]  schedule+0x7c/0x1ac
[   75.551635]  schedule_timeout+0xe8/0x1a4
[   75.551857]  blk_mq_freeze_queue_wait_timeout+0xf4/0x18c
[   75.552157]  nvme_wait_freeze_timeout+0x68/0xa4
[   75.552503]  nvme_dev_disable+0x35c/0x374
[   75.552734]  nvme_shutdown+0x34/0x40
[   75.552956]  pci_device_shutdown+0x48/0x54
[   75.553184]  device_shutdown+0x1c4/0x314
[   75.553403]  kernel_power_off+0x40/0x88

which seems to indicate that a reference is being leaked. Haven't poked
any further at it, I'll drop these two for now.

-- 
Jens Axboe

