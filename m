Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D9229D268
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793655; cv=none; b=ferICK+q/zx6hu50FR3iqkam11zQ1jJeVGXGiDQP7+1sj2WPyIlEOM9S9FBwzygZVn5ySif3v6BPFzmIlvPSSkOlFsykgwVtLSZQCQpR6jEQKZu3M0H5ZKEJBmD10SvvEX2mTeTtVh0rE1JzL4mEzYpp3xXVbg9n8u4xvok1VI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793655; c=relaxed/simple;
	bh=hkog+jHq43lcN04D3PrxPQ8Az/WJVdZkCo6wI+g+PZ8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=S4KCjg4fDac5llDwPoa17P5OfWkrdPIg/aoeBDpJwo/O8MIuIgtvOXjkYOwiQ7D82tT5XjsQTIpnsrPWfQAajnR3u60OMajFmBSuv2p9rRu5VCMImay6KXtnRS3negzQbuJi4OU0+Xi3d3FrCDV9peRLXmHdBV54uzjS71n03fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=aj4tCdS9; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="aj4tCdS9"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40429b1d8baso2141723fac.0
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776793652; x=1777398452; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+uA6tfiy5TvLcDxis+yr1LykpZrZeJjZDAG/n12EDI=;
        b=aj4tCdS9x5GUArACxWb/iBbZKhpuzy9kYuZX8WBv/Tt2QFHWkVQY4L2iS+rgUaBEMS
         eL12+45MxIIrmAICH5e6NtHEQF8lbXG5q2fPVnSjnKbLuLFIoM7a6iV36Cfq/enellmj
         OBi1WT5RnLOISDzRZyH03RrPqTVv91QlhEqwVtEAzvda/JcaKUxJ/khitKb6iSES3FAp
         bg2W3ADhmBBiJ+KLVdAx6B5NP+rEJRy5ZL/FiCDcNERlHhyt4DH0fn6Jpi8zSKt3WV90
         pts/kF4kTYVh7WuKcZnehlamOL0HRWgJcJr1ypPAB1RQWar5kudpwN3PkrJ7KCkXcbUA
         b0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793652; x=1777398452;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+uA6tfiy5TvLcDxis+yr1LykpZrZeJjZDAG/n12EDI=;
        b=idBq/joF8I9hJqm50KTs+rC2KjNeWWvsnzNm567WPcHkdPIluQRx10sPThRRqnGJOe
         /rhP6LtRIe1sfeUjYyCyM79Va90W9mTSHZpogMzfGCV79eVld1C+hTS9jfcYOZ7KBiOi
         qnBx6BPLYOATrZrFp2k0AnZi2Ozb5nVCDA5NbyBnZPukTrhOEpnlWLp2OEJs+xqjGF2U
         2pRkxHGtyzUid6Alc/dzJyrMfrZ/Ve2kzkFzzPwQecLiJyZfqLtfSU1ONcL1QNxiPiVu
         JhFFJKqVtm9Z8Hj6SSGq4RrTKu/94uCXoZ9Pc1o/4pNe/OziH2sv7AF64VtshS3bD1dU
         et2g==
X-Forwarded-Encrypted: i=1; AFNElJ8ujwnC//rh1ZK+ZNZmvmfBIvh20xVnSj0p1YYBVU6v7OySsxM/nBWhbd6bBzybKvQJjp81dGknAM9gFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL6gNwUkfT9ca4wmwaA4z1czzHIxIfVuBJ8zS0R7stQaGTeqYa
	KmvFgpsfHZVKeXIhEn/pGcPJFuuAKOmV/MvJo/C4DO8YPYOhgL/qFTpYhGCE5lUO5kU0QRwSAlW
	KqoGY3DA=
X-Gm-Gg: AeBDieu0AHsa/LFw1z5BjvAiCfBcGwEcox+2ArSQ2UCy2QkRn+oA7BBJjBDX55S/DDp
	N09mQu8JWyMtHdXqcC6Ek0ue2X3Mb02dJWI9cknHyerYLM9fr5KGsn/VknBForJuNUHyDWNyo3a
	cl9tJJx9RVTmNrX1EnvMgrS1gXyhhRajKpvu/26R6HxC/9iY1ZZ9ZdW94G03YIO7aRiAulboESX
	iy1lToLoPCbZin3ul1UkOaYNVZxOVWO+yLkbMgHrzTJVsEOZzZB2M+PlJJmHwkJSjr8Yr3H+8Dy
	CGF+f9HsecxWeB+05h99bKKBIHQwCkwyH08rrza/t34m81jHeOfYezdR5oZmuZQ5vD1l0BBunxZ
	o7Frpl+k78Kop8pCvJRDMW2XYvmHb/ffOqkuqExE9Xlp7Z3uvGXEs9j7ze8MDVHBgHXTJGW+EXN
	1vj6h8FjV1atqSPGbhBtQfBD6qi3705uZC1Zd0XmQANa554hEkkHOACxucqfaSJ3XqXYvVuHWlV
	mmWQf7oroQuVrrqYcyyvL5R6q2hyA==
X-Received: by 2002:a05:6870:e8c:b0:41c:305b:14e1 with SMTP id 586e51a60fabf-42aded84232mr11979349fac.28.1776793652264;
        Tue, 21 Apr 2026 10:47:32 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42f090b1de9sm1645594fac.6.2026.04.21.10.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:47:31 -0700 (PDT)
Message-ID: <0349d72d-dff8-4f9f-b448-919fa5ae96da@kernel.dk>
Date: Tue, 21 Apr 2026 11:47:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ming Lei <tom.leiming@gmail.com>
Cc: io-uring <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "Liam R. Howlett" <liam.howlett@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: RCU warning off ublk_buf_cleanup() -> mas_for_each()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ming,

Ran into the below running tests on the current tree:

=============================
WARNING: suspicious RCU usage
7.0.0+ #16 Tainted: G                 N 
-----------------------------
lib/maple_tree.c:759 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by iou-wrk-55535/55536:
 #0: ffff800085a451a0 (ublk_ctl_mutex){+.+.}-{4:4}, at: ublk_ctrl_del_dev+0xdc/0x2f8

stack backtrace:
CPU: 4 UID: 0 PID: 55536 Comm: iou-wrk-55535 Tainted: G                 N  7.0.0+ #16 PREEMPT 
Tainted: [N]=TEST
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x1c/0x30 (C)
 dump_stack_lvl+0x68/0x90
 dump_stack+0x18/0x20
 lockdep_rcu_suspicious+0x170/0x200
 mas_walk+0x3f0/0x6a0
 mas_find+0x1b4/0x6b0
 ublk_buf_cleanup+0xe0/0x240
 ublk_cdev_rel+0x34/0x1b0
 device_release+0xa4/0x350
 kobject_put+0x138/0x250
 put_device+0x18/0x30
 ublk_put_device+0x18/0x28
 ublk_ctrl_del_dev+0x120/0x2f8
 ublk_ctrl_uring_cmd+0x598/0x29b8
 io_uring_cmd+0x1e0/0x468
 __io_issue_sqe+0xa4/0x748
 io_issue_sqe+0x80/0xf68
 io_wq_submit_work+0x26c/0xdc8
 io_worker_handle_work+0x334/0xf20
 io_wq_worker+0x278/0x9e8
 ret_from_fork+0x10/0x20
Buffer I/O error on dev ublkb0, logical block 0, async page read
Buffer I/O error on dev ublkb0, logical block 0, async page read
 ublkb0: unable to read partition table
Buffer I/O error on dev ublkb0, logical block 0, async page read
Buffer I/O error on dev ublkb0, logical block 0, async page read
Buffer I/O error on dev ublkb0, logical block 512, async page read
Buffer I/O error on dev ublkb0, logical block 512, async page read
Buffer I/O error on dev ublkb0, logical block 0, async page read
Buffer I/O error on dev ublkb0, logical block 512, async page read

and I briefly looked at it, but then just gave up as a) the maple tree
documentation is not that detailed, and b) other in-tree users also just
call mas_for_each() without either a lock held or RCU read side locked.

Adding Liam for shedding some light on this...

-- 
Jens Axboe

