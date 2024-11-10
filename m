Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A16C143C40
	for <linux-block@vger.kernel.org>; Sun, 10 Nov 2024 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731208075; cv=none; b=M+PuUK9ZTF0lrSSBtSyKEQmZ1MzQY4AQoT4JyRZrq1Io5+Vnf0EwQsCE3gmSyaazoXVEq2MBvBVUur47mBhTTwTS7LL2oFCPpIaHAAHgudYGh9lFz6/NqQs9wx7uFPDrmMjcuYvXw1Rdi2EmMxbxsu/0JIYB1yq+9Yv74trDzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731208075; c=relaxed/simple;
	bh=Ddlkrurer8cK/hJ0z+vu0jL3CNQu+azPve2HSFJpx2o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K9jfUDXYE9ccc3uvwsl7FnaaB+aYtPnrJMzZmIxUyNrmFity2LoP60GD3UmnZ5KRIOK3hxsv2mqnqSZtiajiwd/cik7gye3432NdQ55o8pSAa44QWsqeK0/iiUSXmKQVD7onyMYTC6Pw13mk9dlMljvTjzbfCfXlUKEU7pGvnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AR667vp/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AR667vp/"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso3146865b3a.2
        for <linux-block@vger.kernel.org>; Sat, 09 Nov 2024 19:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731208073; x=1731812873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+ah3ff/iaOakiD1bDDFQjjjXs2a3Yki555XDccDYKo=;
        b=AR667vp/Q4rC0t/oR6N1B5l2R+/jMfeObLrMRCMzYuUnhLv+MPcPQUeOvvsY7p68fL
         steUTjuimNZe38GrA705yzT+5oDF68BKCD4+kkneia2EYDI0MkJJs891Ac/Xhngyr50z
         rT8Grk/r1Sq7rnjYuWWKXLm5THF3By+L2+2JqBGjoF53TNSvLQ3fEbTXKOUKFqsNri/X
         a+49fcyaw9whkaUNnocCe2mqKq9fgLTv26eL81vPeFiYuuRwtU+nWI/0mM9tLw5OmNYl
         tNAPLblbSfYQzZq7qjbw2KgkvTpP28jHIBTZEqwmsOYas/kC7syqKPu2Njl+OJ35UpEx
         0D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731208073; x=1731812873;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+ah3ff/iaOakiD1bDDFQjjjXs2a3Yki555XDccDYKo=;
        b=HWQVNlBcG9arxuh1t42fzPnWZKG9M3N3GkeRkUuxkh5CXQ2u+Ma8Rr0RFm1o+ybr6q
         ueHWwRXQxG33E/TEV+uLxVsKEyivoIXddACRgcf0eLsTgTU3092ArKG+lRuXE4ocAKgb
         WfJ+/u31YaI1kuKm+ZEv9xKgZumKBqomuGZ0LuXNkeunkok1lnvGYitnDqiq0nqifNqD
         rcMxvEiC/K0fbu9WTnhSn8yMiAhLg3jFSe4sIINSsbmv547RQanUzAsp4O/d288MqEu7
         XQ9g8ReM0ovOzzLzu42TrAM9Nl9617ZiW6uaJq8mNi0xRRXYsweM1oQM7fwD4JPCGUoh
         pBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU05bH9Sp69YKeYMprYJEpuHrMPRLrnuAWR+6MRS/DSu0T0aqewwjBXjPu/bZMPSkahDuIjEcJzZtxg1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdvSlEJxbeMkTJfdbkx0Bx9roCCI+PWj5v43ppnYDfKxE2smUD
	S1X4mlbNQMudV7j7I5aSJGSrtU5yM7EclvNwWJjR+2YI9rFrxUajpZOqhD5p7yU3msbU17i8hCp
	GcE4=
X-Google-Smtp-Source: AGHT+IESpJhtDuk4HXdiWHoXeGIL3Q6nSo2M5QBjlKiB852AVIVQd+1bXezgbCpqL4E716wxYAr6Fw==
X-Received: by 2002:a05:6a20:8421:b0:1d9:c6e8:60fc with SMTP id adf61e73a8af0-1dc228931b2mr13005769637.6.1731208072986;
        Sat, 09 Nov 2024 19:07:52 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65ba92sm5922982a12.80.2024.11.09.19.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 19:07:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Liu Shixin <liushixin2@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20241108100147.3776123-1-liushixin2@huawei.com>
References: <20241108100147.3776123-1-liushixin2@huawei.com>
Subject: Re: [PATCH] zram: fix NULL pointer in comp_algorithm_show()
Message-Id: <173120807169.1615597.15714479143069057914.b4-ty@kernel.dk>
Date: Sat, 09 Nov 2024 20:07:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 08 Nov 2024 18:01:47 +0800, Liu Shixin wrote:
> LTP reported a NULL pointer dereference as followed:
> 
>  CPU: 7 UID: 0 PID: 5995 Comm: cat Kdump: loaded Not tainted 6.12.0-rc6+ #3
>  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>  pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : __pi_strcmp+0x24/0x140
>  lr : zcomp_available_show+0x60/0x100 [zram]
>  sp : ffff800088b93b90
>  x29: ffff800088b93b90 x28: 0000000000000001 x27: 0000000000400cc0
>  x26: 0000000000000ffe x25: ffff80007b3e2388 x24: 0000000000000000
>  x23: ffff80007b3e2390 x22: ffff0004041a9000 x21: ffff80007b3e2900
>  x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>  x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>  x11: 0000000000000000 x10: ffff80007b3e2900 x9 : ffff80007b3cb280
>  x8 : 0101010101010101 x7 : 0000000000000000 x6 : 0000000000000000
>  x5 : 0000000000000040 x4 : 0000000000000000 x3 : 00656c722d6f7a6c
>  x2 : 0000000000000000 x1 : ffff80007b3e2900 x0 : 0000000000000000
>  Call trace:
>   __pi_strcmp+0x24/0x140
>   comp_algorithm_show+0x40/0x70 [zram]
>   dev_attr_show+0x28/0x80
>   sysfs_kf_seq_show+0x90/0x140
>   kernfs_seq_show+0x34/0x48
>   seq_read_iter+0x1d4/0x4e8
>   kernfs_fop_read_iter+0x40/0x58
>   new_sync_read+0x9c/0x168
>   vfs_read+0x1a8/0x1f8
>   ksys_read+0x74/0x108
>   __arm64_sys_read+0x24/0x38
>   invoke_syscall+0x50/0x120
>   el0_svc_common.constprop.0+0xc8/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x38/0x138
>   el0t_64_sync_handler+0xc0/0xc8
>   el0t_64_sync+0x188/0x190
> 
> [...]

Applied, thanks!

[1/1] zram: fix NULL pointer in comp_algorithm_show()
      commit: 5fcfcd51ea1c1309a673d45f12698dec53ffbd9b

Best regards,
-- 
Jens Axboe



