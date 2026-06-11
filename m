Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112113D9DD2
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176936; cv=none; b=MFl+mR5Y0k+fAJh9rTILQZoiQ/iQ1enJWHGhsLAYYwEzEVmknQGE/OIEukNYqoWtQtRSKKKos/ikA2QEs0DeBXaG7Bk4NsUA9t8ujNpWi0u4tmTNkuT0PUf2z7nvxwf1dtdMLguOz3QljOegFiBlb6QxklpN+qEKjLhopT3OlGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176936; c=relaxed/simple;
	bh=3+HjwDwmERtNJcgqHMSA5lLe7/fEgmvxMqn1D0guxPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GArOF6Ksu4Cd8UJRe0utRQbFBEKmkjQa5ESmG0c7sXx7Htd80znena1xbuozwsrhfXWlM812xfGINb4YFAMq/ivVIc78HPiy1wo8UsizmacntN3p0JOrvyMlHpq70/yNAdKUXGg6EymTfcneT9JXfoLm+8ONP0cGMpesGyCQB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlE7FQj4; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlE7FQj4"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccdf8d4ac5so83152786d6.1
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781176934; x=1781781734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRMkRoDiaOxru7HFOB0PIVRyV+baEAWvJr7FzBa4SME=;
        b=VlE7FQj44oKyb2PQGu9K8FT4mArBZfiGzyESmdBpz5j1ST6crBA0TrGslPRlWmBOmN
         ooH08nCp7m3kvLAud+rziSUfX0YVF5rBLUC+vEjVDi/tv5JF6+hmQYMy59cT4XIfPL6O
         YxmoFojTvBdtnWjtIWfo67p3A2JeMVvVQJdnqf+4MCg93IYmnUGWg8L8VtkUett4OAhU
         YxPwfaDRnEZs56lV+Hnww/HFPxl/7hIBBUmOpykNrQj7qxV3tLjdI1SlQorSXfIRRx/j
         wHoxEJlHSn4foR5S9TVQ2MX3DzVuv9YPKRt9yZdvHGUuawtEVebzmeLts7s7PzufoJlv
         zZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781176934; x=1781781734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRMkRoDiaOxru7HFOB0PIVRyV+baEAWvJr7FzBa4SME=;
        b=f9757NALteRgtkvWjrs5maauVKfxmAoA6kPxz2cWsKYmtpL0P4/5Krw4n6EkTXtcDh
         Qhq8718ktXDl2ZkOuoSWSpekIY3Qhz+NFnbf3Y+xkOvQAJaaH7VLIIzIdDZIKtjSakcv
         lNngo/pizKfcEODbmgc9YWNpGZhW463l/rZXY6AjG04sEkDhIhMcSzml3DuBcEx4F46I
         RZM1+9X6NkKiq79VR945CfFsbHFtmzlTNLGThHIB+CqGA15WJFXJsHn8EQNfpsChQlFJ
         xJvpcEdDE0s2+K+c3y6ogFD/WnAiu1KeK/KJF+NwGYVc07ccizVU1SXPxRmtils6nfWK
         n4Jg==
X-Gm-Message-State: AOJu0YxtPhR6XL+HS8xnYW+RfihXUiGr255O/AXAw8BJM/tNZiOp09c4
	VTzAoul5y1MslK+W57KfzDbyjnZk1F2XL4ZC8oI1kSCUaAxnzh72i69o
X-Gm-Gg: Acq92OHK2nmaGsoizULVKbFyMjbVhspFxIRAmwxjGWgm/tDDy4/kRhdkjrL1VbPORGM
	4VoPVIS1vWSUdL2OC65h/hk4qH1u/pKtcJNTBam58uTwsmKEZJ2oWmsWNhD2h6e2W4iPsQZ0Ptl
	asLFgtmkjOyZjNq10IdLBpaXtO+mT/Sc73U5j/gG9k44jImMUN02CHd9FZro/3Z8Mpq6i/zscHX
	0iKeHSLOXPBBOe0/uQKCmJhiRPO59mUzsFp5nn3PDIlV9RWmS0O1TT8A7AFRin2kCfRIebyViU4
	sNnTM+IM22N6YLX954kyOgCgmgTz38s//FfIOXUEOb67hgM5oMlam7811q/NQib6qzvccgd6uTj
	8PaHltU+RgYzb2QLMT+nL+G6WTYGdE75XXlU+sVtI4T1VxREGVgH9JMNdj9mzuUC3p4GAYX/ZM9
	jhBTbm0z90yHSw+RV+f3sg/fpgifBKyUW6i8G1c+JEj7sl8n5l7j2Ch3GE3QQUSPkfzUSkgj09L
	aNUx5XroBXvzVc37MSA1PDHAQeqaYv97HnEHFHE0A==
X-Received: by 2002:a05:6214:5d11:b0:8ce:ba04:7bcd with SMTP id 6a1803df08f44-8d1daa3b1e3mr35080676d6.38.1781176933971;
        Thu, 11 Jun 2026 04:22:13 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1eb2b5f66sm14906506d6.46.2026.06.11.04.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:22:13 -0700 (PDT)
Date: Thu, 11 Jun 2026 06:22:05 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH RFC 0/1] block: fix concurrent elevator change failure
Message-ID: <aiqaXfTqCLMu2DwF@fedora>
References: <20260611074200.474676-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611074200.474676-1-shinichiro.kawasaki@wdc.com>

Hi Shin'ichiro,

On Thu, Jun 11, 2026 at 04:41:59PM +0900, Shin'ichiro Kawasaki wrote:
> I observed that the blktests test case block/005 hangs on a specific
> server hardware using a specific HDD as a block device. During the test
> case run, the kernel reported a KASAN null-ptr-deref (and other memory
> corruption symptoms) [2]. This failure looked sporadic and hardware-
> dependent.
> 
> From the kernel message, I noticed that udev-worker wrote to the
> queue/scheduler sysfs attribute to change the IO scheduler, or elevator.
> The test case block/005 also wrote to the same sysfs attribute, which

sysfs write is supposed to be serialized...

> indicated that a concurrent elevator change caused the failure. I
> created a new blktests test case that simply does the concurrent
> elevator change with a null_blk device [1]. It recreates the failure in
> a stable manner on various server hardware.
> 
> Using the new test case, I bisected and found that the failure first
> appears at the commit 370ac285f23a ("block: avoid cpu_hotplug_lock
> depedency on freeze_lock") in the kernel tag v6.17-rc3. However, that
> commit does not appear to explain the failure by itself: it changed the
> queue freeze behavior and only unveiled a race, probably. Looking back
> at the changes to elevator_change(), I think the actual cause is the
> commit 559dc11143eb ("block: move elv_register[unregister]_queue out of
> elevator_lock") in the kernel tag v6.16-rc1. This commit moved
> elevator_change_done() out of the guard of ->elevator_lock and the queue
> freeze. As a result, when two threads write to the same queue/scheduler
> attribute concurrently, elevator_change_done() runs in parallel causing
> the memory corruption and the hang.
> 
> As the fix attempt, I created the patch in this series. It adds a new
> mutex that serializes the whole elevator switch sequence, including the
> elevator_change_done() call. I ran the reproducer with lockdep enabled
> and confirmed that the patch avoids the failure and new WARN was not
> observed.
> 
> However, the fix patch adds a new lock, and I'm not sure if it is the best
> solution. Comments on the patch, or suggestions for a better solution,
> would be appreciated.
> 
> [1] https://github.com/kawasaki/blktests/commit/4f8c63ed7d049f5e9c935c3fe00142b2a3629826
> 
> [2]
> 
> [30102.760660] [ T186170] run blktests block/005 at 2026-05-11 05:53:53
> [30104.969837] [ T186111] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
> [30104.983590] [ T186111] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> [30104.992929] [ T186111] CPU: 2 UID: 0 PID: 186111 Comm: (udev-worker) Not tainted 7.1.0-rc2-kts+ #1 PREEMPT(lazy)
> [30105.004019] [ T186111] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12/17/2015
> [30105.013216] [ T186111] RIP: 0010:blk_mq_debugfs_register_sched+0x46/0x210
> [30105.020667] [ T186111] Code: 48 89 fa 48 c1 ea 03 48 83 ec 10 80 3c 02 00 0f 85 83 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 08 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 57 01 00 00 48 c7 c0 24 a3 b3 97 4
> 8 8b 6d 00 48
> [30105.041036] [ T186111] RSP: 0018:ffff88816b9c7708 EFLAGS: 00010246
> [30105.048111] [ T186111] RAX: dffffc0000000000 RBX: ffff888117f18000 RCX: 0000000000000000
> [30105.057097] [ T186111] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888117f18008
> [30105.066086] [ T186111] RBP: 0000000000000000 R08: ffffffff957c47ac R09: fffffbfff2f6633c
> [30105.075083] [ T186111] R10: ffff88816b9c7730 R11: 0000000000000001 R12: ffff88814c1f2000
> [30105.084088] [ T186111] R13: ffff88814c1f2018 R14: ffff8881b8a336ac R15: ffffffff95bfae30
> [30105.093111] [ T186111] FS:  00007fc1c7970c40(0000) GS:ffff8887c534e000(0000) knlGS:0000000000000000
> [30105.103093] [ T186111] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [30105.110751] [ T186111] CR2: 000055fa37e182c0 CR3: 0000000108350003 CR4: 00000000001726f0
> [30105.119796] [ T186111] Call Trace:
> [30105.124154] [ T186111]  <TASK>
> [30105.128301] [ T186111]  blk_mq_sched_reg_debugfs+0x8d/0x1a0
> [30105.134193] [ T186111]  elevator_change_done+0x2f2/0x610

blk_mq_sched_reg_debugfs already includes debugfs lock, so I feel the proper
fix could be check & avoid the null-ptr-deref.

Adding new lock should be the last straw usually, especially this one is
depended by queue freeze.

Thanks,
Ming
