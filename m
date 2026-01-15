Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7856F212549
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486966; cv=none; b=tww7KN/GjM1EABtnHEQglGTHRmE3rFCCPPb8GrSeDaOtSQ10G4W3DqZoF36JUUdosVx0vbC2Y47vy2twx28zU7OY5BiU8ziUX9ATq9T+WU59jn8eTsnr+8IGbsXhEsQXkR9UQqJni/PXUgICEGOkEc+6DmyqoL4IVFJdab1DQVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486966; c=relaxed/simple;
	bh=N5SP9u8NyaqlqJGbhed37h/EVcEsQ2lF0KmoDZKLJlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VgfD07uAezMWsQRJx93DenIuZdEHziqhP6Pb3gIOvv+DQmPEEDFI4MVkw/jBcabmv/7yt7oxY1c+Chz5u4n2FiuzAbigunCubS2D1dtkE0/cq78Ncp31ocSuvMZeHRFSiRd+LESfA08XYyLUX13A6zPXWUwskSdanIQCQm4m3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nz0AK2AQ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nz0AK2AQ"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40421de595fso655129fac.3
        for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 06:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768486963; x=1769091763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/2mnT/PHyltzTTPTkq7MpDkkTKP8GbDY8kCAW/ksT8=;
        b=nz0AK2AQ+lw9qjYIMcSojooPwTZIIl98Cnn5eLAlnuJi9MQ/AW/5eYBOdK08xbhiKB
         pppL2oE3UA/nKRKKSPyd6klhxGyl9px/HZfDnJrU3cAgK2CaIiYsC62zI8AI9YwDjdPV
         XjsnMZzBO+UXpqezPLpk5cIwXNBaen+v+JzNxHTvnmFltHQknkMQAPCKuUuDFVXKicsi
         gj6JgGtqRHWIGiaog/FMOdFEJuNJzNUVuTbl0t90NznhqHG6hc7K48BEDy4zOsORK+p3
         0CkrYvZnol9T1EGvg4A30FkpwJZl3DxbXYlxvgwh8MBnGqHFyfhevaw3Fdmckvez+wHO
         69rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768486963; x=1769091763;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X/2mnT/PHyltzTTPTkq7MpDkkTKP8GbDY8kCAW/ksT8=;
        b=KxbWQvJxZIQAGYVj9eH3N6ylB1RTFZEHF93jlgM7m/YU4gXJcqFynR5BQikd9sDGVU
         lJ0XKboUeU1PnwHkpTt/P7HqyBpg1zmETHKNtHib6hS7rI+rWdmyGg9KsXsEt0Addehp
         80lf+nY0kuINCNEIzFdZOXGsFvGb6fHjryRGSWhPe8pxWfOYMKcSwb4Vfck4iNsnOqoM
         fgS/inP94r0QKGAInO31xTA8aAeIArLKt6TcAqTxvNe5T0fJ+oqNFphLQfXjdybIjqXL
         7VhFS5/XFrDrxpNICLirBUsHg6DsWNBNr8PqpTWGraDhFos1OpkQcxU0VbD+IJdwI71j
         jGQA==
X-Gm-Message-State: AOJu0Yzn6WbcaD5xwGFVjfsEjJ9t9UwVcvJ6aB+HaQTEfz0yhAWj88Cf
	Qv3PKqZ6DzaG5JIupZRJCAjW3aQBO3W32PC4qiQlN9FCYoVcjSPy5FwbE/sQKrR+3Asz+M20FBO
	VAb8/
X-Gm-Gg: AY/fxX5iB0MNKjWefqyMJUpyGkVxqbGfqdQKhEpvkslQZ9hVj8eszNZ09TfkirMop0D
	3QDx3c5O7+RNpqNkzC3efpbtg5AWT7KAdK5ypbSmZktP7R9R4Olg2npYeksWDbuYli8ZqdP99DB
	7ZcErOHr4+b+LEcdLknE7LuWfOI+b1D8fspqw6likAgwVrAm6OOGWisWjH/BAeSrfOl/msvhYS7
	omFjsB7zRgd4ZPgkXpWYfJ1MS678x8NDBEGFAfmEzvIR6Hpuf1MOOifk5Z3ye1ijMP9e81p4LEq
	XQ9Hn98nUXAAWBxYCcw/1tSOajOQLmmpFp0nd0W1Vv4aqYnPQRZ969GiFibuzRFculQx4K+X3X+
	XlZVsiM1eKOm3TwXS8XCwgUiIEpT8354/ot35fSMJksEV+Bwj/+nTXqyyTQhyHtWywmpwuvLTcQ
	TnH7A1yVEEG6/y
X-Received: by 2002:a05:6808:2028:b0:455:bebf:af3c with SMTP id 5614622812f47-45c71590f09mr3773981b6e.48.1768486963397;
        Thu, 15 Jan 2026 06:22:43 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c98a4d3d3sm120202b6e.20.2026.01.15.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:22:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: haris.iqbal@ionos.com, jinpu.wang@ionos.com, yanjun.zhu@linux.dev, 
 grzegorz.prajsner@ionos.com, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
References: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
Subject: Re: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
Message-Id: <176848696172.896295.7096462379350367119.b4-ty@kernel.dk>
Date: Thu, 15 Jan 2026 07:22:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 12 Jan 2026 15:19:28 -0800, Chaitanya Kulkarni wrote:
> During device unmapping (triggered by module unload or explicit unmap),
> a refcount underflow occurs causing a use-after-free warning:
> 
>   [14747.574913] ------------[ cut here ]------------
>   [14747.574916] refcount_t: underflow; use-after-free.
>   [14747.574917] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x55/0x90, CPU#9: kworker/9:1/378
>   [14747.574924] Modules linked in: rnbd_client(-) rtrs_client rnbd_server rtrs_server rtrs_core ...
>   [14747.574998] CPU: 9 UID: 0 PID: 378 Comm: kworker/9:1 Tainted: G           O     N  6.19.0-rc3lblk-fnext+ #42 PREEMPT(voluntary)
>   [14747.575005] Workqueue: rnbd_clt_wq unmap_device_work [rnbd_client]
>   [14747.575010] RIP: 0010:refcount_warn_saturate+0x55/0x90
>   [14747.575037]  Call Trace:
>   [14747.575038]   <TASK>
>   [14747.575038]   rnbd_clt_unmap_device+0x170/0x1d0 [rnbd_client]
>   [14747.575044]   process_one_work+0x211/0x600
>   [14747.575052]   worker_thread+0x184/0x330
>   [14747.575055]   ? __pfx_worker_thread+0x10/0x10
>   [14747.575058]   kthread+0x10d/0x250
>   [14747.575062]   ? __pfx_kthread+0x10/0x10
>   [14747.575066]   ret_from_fork+0x319/0x390
>   [14747.575069]   ? __pfx_kthread+0x10/0x10
>   [14747.575072]   ret_from_fork_asm+0x1a/0x30
>   [14747.575083]   </TASK>
>   [14747.575096] ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied, thanks!

[1/1] rnbd-clt: fix refcount underflow in device unmap path
      commit: ec19ed2b3e2af8ec5380400cdee9cb6560144506

Best regards,
-- 
Jens Axboe



