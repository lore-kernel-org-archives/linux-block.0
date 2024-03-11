Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F658AAC
	for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201207; cv=none; b=K0m3oFqK/iB4/CC2RmstZ0J/6bbynAHrci4cFnZimPKdLf58Kk30Zwbry0wHkHu9lSNe8kV9QkSKZK7EWcLKi25ZUVPW48YUHieUQjC0SPJscGcSq0t0AgJerJAynm0uc7PgEa1vDTnajU/jZmSJfbWjwz5oKKmx5vYM+HvP0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201207; c=relaxed/simple;
	bh=gmWgWWhAsASPhDlzwAuc6bd5GT/rzjx8Me522PE8VAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hO9uMqQYUylUkEt6nATynR8TF/DowH88R8U9414Y+9cT5zEn54scNeZCLLIH5Po7ExK3c5wB3jey925gGKMkEahWgG/A4CGvcuz0u7/d3f/XjrSoJ6USwHINhm5aeCWTfpD9D/26nyzGtkGh8WxrRCkjotm+IXdw1FkBoAPQ4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kt9iVJ5k; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kt9iVJ5k"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29c27a559eeso145018a91.1
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 16:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710201203; x=1710806003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVCvJNbvwm0mgrRxU+zPbh1SyI+onc85nD3ttImI+RY=;
        b=Kt9iVJ5kgqav7meghShjyNCKAB8EkuILZ/wwELs6oMo9CfB8gR7Y1y5EhoisAHCbb4
         6Y2z3/lC8b6azmiwHJ+hCGhKepaNsJ9sNW3jTiSEMVLrdj2VtYpKh/FPpS7TjOlT0P4y
         3UphLi4Cbp6DKwWDwxm0usclzz8pgfmgrPcEnM4AVlpIQP2eT07x3KOfq23+VchArQUb
         A2Cz1Q8R8/rU4R/4sQLZddwTarDu7vuzQtM0yv+0IRSv5j5m+V12j1wFE52pwCI461Oo
         QJUSBwvznMTWOEALPfBUbbG5J91Dyjyi1VeO2ag4CkZsox114zgcExuiBjl2t+DhjrzH
         0dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710201203; x=1710806003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVCvJNbvwm0mgrRxU+zPbh1SyI+onc85nD3ttImI+RY=;
        b=dVz40wZZdmt6F3eD0JMYTgpi+trfKqzmkqLBBbxqkbWtegbL9ZcA3kPKNKFiK+QtsK
         RrWKAQ1M24NAaa9DWa8E0VLkWNiJTQVex2ponXYG32+w/+CebR1hJPAfREYw0Wou/+8E
         2keEkJ310GUpm/K847BnU69Fnf5nJDz8uGqToF/ZcmnjOlU9M/Wzip+FUNGSSGPxzJgC
         ZFKK390REqP0nhqvbJoYVPxLzU5lLD10aNK20Jf5U/GyXr+J25FcU3FnzMyWxnFOV3al
         7kRDifvtfEbQ7OYKx8GJz68d6knNa0GL7cYuhV4QK4YyLr5i5LU/Cpl1duQsIua7gv9n
         6NJw==
X-Forwarded-Encrypted: i=1; AJvYcCWpf9WhymgYMT4Lj+mGs+lYp/3PAuwxaIU9MC7bS94lL8CuAcDpWbLNn2HZHayUYAWK3Yrzwq9UM/KD6s08ZbV8GiEqONSySZPhk4w=
X-Gm-Message-State: AOJu0Yy674xYtj6tU2O4QgB3ilLdjxd/xr2sk0xhz6ykYgu/toMy6C+j
	sRMz8tagvUlfU0KslAERYCsoxKkYlLS6V/Nb1PQtuNVJqmes9Bdx+HlA02S3uog=
X-Google-Smtp-Source: AGHT+IF4wliE5GfQWr4XFZdHKojsQTB1SaOGg6DLv7aJq9TlEE6xRDqsCA9DMacS9ROFQWirEWRofA==
X-Received: by 2002:a17:90b:3ec3:b0:29b:780c:c671 with SMTP id rm3-20020a17090b3ec300b0029b780cc671mr6581267pjb.0.1710201203128;
        Mon, 11 Mar 2024 16:53:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090a394300b0029a4bacfb13sm65922pjf.0.2024.03.11.16.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 16:53:22 -0700 (PDT)
Message-ID: <31d63c56-22aa-4596-bcfc-a94175db5459@kernel.dk>
Date: Mon, 11 Mar 2024 17:53:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240311235023.GA1205@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 5:50 PM, Johannes Weiner wrote:
> On Sun, Mar 10, 2024 at 02:30:57PM -0600, Jens Axboe wrote:
>> Hi Linus,
>>
>> Here are the core block changes queued for the 6.9-rc1 kernel. This pull
>> request contains:
>>
>> - MD pull requests via Song:
>> 	- Cleanup redundant checks, by Yu Kuai.
>> 	- Remove deprecated headers, by Marc Zyngier and Song Liu.
>> 	- Concurrency fixes, by Li Lingfeng.
>> 	- Memory leak fix, by Li Nan.
>> 	- Refactor raid1 read_balance, by Yu Kuai and Paul Luse.
>> 	- Clean up and fix for md_ioctl, by Li Nan.
>> 	- Other small fixes, by Gui-Dong Han and Heming Zhao.
>> 	- MD atomic limits (Christoph)
> 
> My desktop fails to decrypt /home on boot with this:
> 
> [   12.152489] WARNING: CPU: 0 PID: 626 at block/blk-settings.c:192 blk_validate_limits+0x1da/0x1f0
> [   12.152493] Modules linked in: amdgpu drm_ttm_helper ttm drm_exec drm_suballoc_helper amdxcp drm_buddy gpu_sched drm_display_helper btusb btintel
> [   12.152498] CPU: 0 PID: 626 Comm: systemd-cryptse Not tainted 6.8.0-00855-gd08c407f715f #25 c6b9e287c2730f07982c9e0e4ed9225e8333a29f
> [   12.152499] Hardware name: Gigabyte Technology Co., Ltd. B650 AORUS PRO AX/B650 AORUS PRO AX, BIOS F20 12/14/2023
> [   12.152500] RIP: 0010:blk_validate_limits+0x1da/0x1f0
> [   12.152502] Code: ff 0f 00 00 0f 87 2d ff ff ff 0f 0b eb 02 0f 0b ba ea ff ff ff e9 7a ff ff ff 0f 0b eb f2 0f 0b eb ee 0f 0b eb ea 0f 0b eb e6 <0f> 0b eb e2 0f 0b eb de 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00
> [   12.152503] RSP: 0018:ffff9c41065b3b68 EFLAGS: 00010203
> [   12.152503] RAX: ffff9c41065b3bc0 RBX: ffff9c41065b3bc0 RCX: 00000000ffffffff
> [   12.152504] RDX: 0000000000000fff RSI: 0000000000000200 RDI: 0000000000000100
> [   12.152504] RBP: ffff8a11c0d28350 R08: 0000000000000100 R09: 0000000000000001
> [   12.152505] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9c41065b3bc0
> [   12.152505] R13: ffff8a11c0d285c8 R14: ffff9c41065b3bc0 R15: ffff8a122eedc138
> [   12.152505] FS:  00007faa969214c0(0000) GS:ffff8a18dde00000(0000) knlGS:0000000000000000
> [   12.152506] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.152506] CR2: 00007f11d8a2a910 CR3: 00000001059d0000 CR4: 0000000000350ef0
> [   12.152507] Call Trace:
> [   12.152508]  <TASK>
> [   12.152508]  ? __warn+0x6f/0xd0
> [   12.152511]  ? blk_validate_limits+0x1da/0x1f0
> [   12.152512]  ? report_bug+0x147/0x190
> [   12.152514]  ? handle_bug+0x36/0x70
> [   12.152516]  ? exc_invalid_op+0x17/0x60
> [   12.152516]  ? asm_exc_invalid_op+0x1a/0x20
> [   12.152519]  ? blk_validate_limits+0x1da/0x1f0
> [   12.152520]  queue_limits_set+0x27/0x130
> [   12.152521]  dm_table_set_restrictions+0x1bb/0x440
> [   12.152525]  dm_setup_md_queue+0x9a/0x1e0
> [   12.152527]  table_load+0x251/0x400
> [   12.152528]  ? dev_suspend+0x2d0/0x2d0
> [   12.152529]  ctl_ioctl+0x305/0x5e0
> [   12.152531]  dm_ctl_ioctl+0x9/0x10
> [   12.152532]  __x64_sys_ioctl+0x89/0xb0
> [   12.152534]  do_syscall_64+0x7f/0x160
> [   12.152536]  ? syscall_exit_to_user_mode+0x6b/0x1a0
> [   12.152537]  ? do_syscall_64+0x8b/0x160
> [   12.152538]  ? do_syscall_64+0x8b/0x160
> [   12.152538]  ? do_syscall_64+0x8b/0x160
> [   12.152539]  ? do_syscall_64+0x8b/0x160
> [   12.152540]  ? irq_exit_rcu+0x4a/0xb0
> [   12.152541]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> [   12.152542] RIP: 0033:0x7faa9632319b
> [   12.152543] Code: 00 48 89 44 24 18 31 c0 c7 04 24 10 00 00 00 48 8d 44 24 60 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [   12.152543] RSP: 002b:00007ffd8ac496d0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   12.152544] RAX: ffffffffffffffda RBX: 0000564061a630c0 RCX: 00007faa9632319b
> [   12.152544] RDX: 0000564061a630c0 RSI: 00000000c138fd09 RDI: 0000000000000004
> [   12.152545] RBP: 00007ffd8ac498d0 R08: 0000000000000007 R09: 0000000000000006
> [   12.152545] R10: 0000000000000007 R11: 0000000000000246 R12: 00005640619fcbd0
> [   12.152545] R13: 0000000000000003 R14: 0000564061a63170 R15: 00007faa95ea4b2f
> [   12.152546]  </TASK>
> [   12.152546] ---[ end trace 0000000000000000 ]---
> [   12.152547] device-mapper: ioctl: unable to set up device queue for new table.
> 
> Reverting 8e0ef4128694 ("dm: use queue_limits_set") makes it work.

Gah! Sorry about that. Does:

https://lore.kernel.org/linux-block/20240309164140.719752-1-hch@lst.de/

help?

-- 
Jens Axboe

