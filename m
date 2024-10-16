Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D421EB5B
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084830; cv=none; b=Gu0rAkqEWq2XpRjvZK6cFUnfkvZcTSd7l0+P+R4tu46c/sbu46xemdPi0KVJTBZZqDs1Mjoj+UHxY6riDr/yyaeXxk7N1HM5l1gxhfQcEGGjRv1kZZ3ySZOw4qvatl/CPDMKkUv2tidiYRxOb4R9srcm8I7qyRAEXDrNWawD+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084830; c=relaxed/simple;
	bh=yapHRqMObz/IloKc/G+D+IfpZTkb5qyzvwe0iF6ccyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TzdJwnud3xsvP58faIL2qTrnFejJamFna9Fw6UhIcf74/qUsQbNleN6tZE6rk/xDxwwgj/UhfF8/e/wwdFvmzIYwqVbCeGvHVStKc7b5z/FUMtMp6LbgeWJMj1CJD3RlYPMuAUZ/tO1/ziLgmffai0gT+LZK2ZP30qDjxTeL41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Wa+SN6G8; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Wa+SN6G8"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso35983475ab.3
        for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729084826; x=1729689626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wHx5vpvY4x1VsngndqCERKtk/V1WKwRew/f295FoT0=;
        b=Wa+SN6G88xmbQhWg8g/DYi4AehUYzCi6HIzUVQRlRdr5vWk9KHnp1U4NXKV0+WN5Ig
         bQmhhdht0JAd6o6tD6R/IF6TNQ06ugIOQCWK9H1YWtVboSILrrN3y5RUSmeIcTSJzdPU
         S2DPKywvH9gMZBHXjCNvG3Ew8Sgmd0JfQcNMjY1ldoiTii18JmO6BESVP6bGHgaeH8Jz
         RMwJ7kavK+aHR7CRX7dhh91vaI8RbGwHNUlLT4yEJ8tctj9hqsnNpRhagSsUsUGjml/1
         T/HkONl+5Cee+UPNa0Tc2cvalEnvagHXigXet/44G8iqhYTNZux4REwFlJbjac+4Vp+6
         NpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084827; x=1729689627;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wHx5vpvY4x1VsngndqCERKtk/V1WKwRew/f295FoT0=;
        b=QGCj/1UQgMmA6v6086rg/vY1FQTNeXUZV4nyr9/PECeovXksWU+r6nJXlW/5cplIX0
         oOSyGXsECuG1oIJAP66F00AojTLWlGq3ZZdwcUVU5hQ81fkUuyFvj36Qh+6GKF/gIfzi
         /uAYRIWD47VoWwl04o3bLEZ45jJU0RhDe+MGxZepILL5ilxt9gFErBwiRDEI+hNhEw8P
         l6WZ4ll5/7L/w/BVhrqfWj3Juua2Swy0dZV0BaN8cYNwGXufIOPdbQuCQr3EwzHO7jJb
         QK0W/RsOweSqF3Kd/oGj2sRlN3/ImESOpK6pULY4eUFJRVv09BBgHyuupkmz1/NfEPNz
         /+Dg==
X-Gm-Message-State: AOJu0YxGJBKkqSktGCQyo5UDYiBLz3nbNNZhBCNbdzm3+Jc9IQuGxFI2
	Sq7Tudz6lGtZF9o+4UDBi5++/hazcQHe8JpXxhQrOtpK1Y4L5CrFMBrX/N+kB6gKvEfM6rPAdPV
	o
X-Google-Smtp-Source: AGHT+IGDtzZQmBMXIEUPBwA/BEmFfU3q7UHIAtLgXJlaTgeL+Mck8vH00bTSoU78M6/fkNfvNJfh1Q==
X-Received: by 2002:a05:6e02:1548:b0:3a2:7651:9846 with SMTP id e9e14a558f8ab-3a3dc4c5631mr42439735ab.13.1729084826578;
        Wed, 16 Oct 2024 06:20:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70cd49esm8024155ab.48.2024.10.16.06.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:20:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc: kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>, 
 Tejun Heo <tj@kernel.org>
In-Reply-To: <d3bee2463a67b1ee597211823bf7ad3721c26e41.1729014591.git.osandov@fb.com>
References: <d3bee2463a67b1ee597211823bf7ad3721c26e41.1729014591.git.osandov@fb.com>
Subject: Re: [PATCH] blk-rq-qos: fix crash on rq_qos_wait vs.
 rq_qos_wake_function race
Message-Id: <172908482553.56817.6212914511023337996.b4-ty@kernel.dk>
Date: Wed, 16 Oct 2024 07:20:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 15 Oct 2024 10:59:46 -0700, Omar Sandoval wrote:
> We're seeing crashes from rq_qos_wake_function that look like this:
> 
>   BUG: unable to handle page fault for address: ffffafe180a40084
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0002) - not-present page
>   PGD 100000067 P4D 100000067 PUD 10027c067 PMD 10115d067 PTE 0
>   Oops: Oops: 0002 [#1] PREEMPT SMP PTI
>   CPU: 17 UID: 0 PID: 0 Comm: swapper/17 Not tainted 6.12.0-rc3-00013-geca631b8fe80 #11
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:_raw_spin_lock_irqsave+0x1d/0x40
>   Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 54 9c 41 5c fa 65 ff 05 62 97 30 4c 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 0a 4c 89 e0 41 5c c3 cc cc cc cc 89 c6 e8 2c 0b 00
>   RSP: 0018:ffffafe180580ca0 EFLAGS: 00010046
>   RAX: 0000000000000000 RBX: ffffafe180a3f7a8 RCX: 0000000000000011
>   RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffffafe180a40084
>   RBP: 0000000000000000 R08: 00000000001e7240 R09: 0000000000000011
>   R10: 0000000000000028 R11: 0000000000000888 R12: 0000000000000002
>   R13: ffffafe180a40084 R14: 0000000000000000 R15: 0000000000000003
>   FS:  0000000000000000(0000) GS:ffff9aaf1f280000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: ffffafe180a40084 CR3: 000000010e428002 CR4: 0000000000770ef0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   PKRU: 55555554
>   Call Trace:
>    <IRQ>
>    try_to_wake_up+0x5a/0x6a0
>    rq_qos_wake_function+0x71/0x80
>    __wake_up_common+0x75/0xa0
>    __wake_up+0x36/0x60
>    scale_up.part.0+0x50/0x110
>    wb_timer_fn+0x227/0x450
>    ...
> 
> [...]

Applied, thanks!

[1/1] blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wake_function race
      commit: e972b08b91ef48488bae9789f03cfedb148667fb

Best regards,
-- 
Jens Axboe



