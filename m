Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480C3385B1
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249272; cv=none; b=KM0ePNsZG/l/Qhv403pKAaiILZzOPlFkfHOaDj5xoiXdzo+dY597K3iBZFQ2eRp7auZ0hchw14HC9e4t7JV4evnlRX6t4RK+VD9d06nEn/xCfuYiSAuZqnUehdRtuXN1TZ6SuxBbLKqnT37Cdg0wcs4SK5sgeufot414GldIZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249272; c=relaxed/simple;
	bh=L3xYk9YVhC4Q8EM5yBp9mHD2qfyDq9jwZPh0FEe3Uz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbHudAF3wCiGE/vokUyvq+4TMptvi9vSX/135NGulK/sxwRhwMJyks5Kae0G4mvCYJmsCgUZE2YGpieB9WM3jh7JcXrtEOvGqGb5LuMslf81I+V2djZcgBqHaE3brIRsMeP89G+07p0f/h9bkAJmZDC+/L1y8Ncxd99jIRGo2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZfFtpC4f; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZfFtpC4f"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c95936e43cso2659636a34.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 12:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768249268; x=1768854068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ioUlpxdHIloI8vwf4hgAx8BeRkzcl61FRKnS8oERP/A=;
        b=ZfFtpC4fw5bJs0qdjmAGvb4UNTyZPez5+l/f3QBtHbCHjpnCHNMHbTlDVQ4/5aNQdx
         iQyq5EiQuT+xOysSymSCBP1TwaggF6iwUB66l2B4KSpuDGMD/Kzri32+dX53Q4fHTEwI
         /67k2aTCxMd3Mby0bk57k5mJqTfMv59nWMsy1yFSeZa8VdfVj/n0DGvB0sIBhSaX1XaA
         D8HUGrH8GJK7wvUYIblllx9ShpqOS7oYcZgoAt8V81nyhkPtnUfbuExjzaA3SS4+GBko
         b6NVl+TeqCpESxHN9LI4nrZdTETpGLIalu+UkFI+Lkhz551gDoFivzgm4DGhRutxY8yx
         lN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249268; x=1768854068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioUlpxdHIloI8vwf4hgAx8BeRkzcl61FRKnS8oERP/A=;
        b=ll51MS3fv3dQHAeUP4/5VX2U1u2f6DQOW2xv7rlJMYeKygcVm52CNID6bE4aqLmhq5
         QSuDZ2aKxwc5fNgd52Q6jPl9hodfA0PfR1Kue0cF8i33w2zVcP5AE3WTFgjuZr8UAT9+
         bYl8zFF4Y8qs7k79y5EI+98T1sRM1ZV0UQ0QtwE4Xgm84Ub2YyrH03qthK/GDgtWBoIL
         yCi5Ug8bGmnth0bIb43LDBWvGJgtFPrLtfp67lHWslCrjv0D0Vu+k/oyBwXoPfQpHxWs
         LZZOgTgFdT9VvyMq2jQhk1rinmFeiQZHzAuuty74S1Y60cjZkRuVPaRPQWTVQPi3qIMP
         VFMg==
X-Forwarded-Encrypted: i=1; AJvYcCXB9/pRZTWFrFmz3vf0kjjQheoamr2vZSJxo1M6OL0RD22vu6ua1NilrbqpYAO29LtC17HHyPVCAsHBYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWl5ILh3P3PeNytyZbsdhOFXJxdBfj+h+jBcTLLGs933IFvcIK
	Ny3y1uXdkAFJxymA2wGKUqrSM8Gpm8QM0d0Hw9UoqvIvk8wQEn0ZfjF0cJ64wONnoupr1BADPre
	dV6Ca
X-Gm-Gg: AY/fxX6d/RZDF5zr4mEBKplAKL2JIqr+wqqOnHhMwD+31qoISL7PnjB236LLuVkeu6p
	bp2WkeauU3mphh2c3WJava2vA4ma67pT2v/6OseRz6vjOcdWtB4MyjuqjPfnil3FrcXI5Mj/aa3
	EpwDVITYZiZnzlNtXJkLNmRWPoBTpas5k2JjPxC/y9ElbEXq4sTOd0XuaY8Re7dANvShxVpUgIh
	GItbXFUlg9yVYaQDmNglL1ucK9RkdhWYn/OqtwkHZRHftmxyMTxgO5KokvVzIeLpNldbQX/tjlw
	Mf9GZ6MRmKoTIAtjF5wQzaJ884qVzeI1H8Gqyl20HoriQxm4IaL7GJoI9SQR+UXKLEC/sQP7OYP
	QQ2DpXjIRCW/zW5wIKpa6crPO2f3+uSYO8IRh+RciZW+6BOoyRLCwWmax6Ovs2Tn8CbpUpmNulG
	9Fp+NKaK8=
X-Google-Smtp-Source: AGHT+IFDBWwKrsiZjQ6fyDSPZp1z/khGe1+w/sjPm0GPVkBngP3NbUKKvX4aT3AGqMHbmopAcR8YWA==
X-Received: by 2002:a05:6830:2705:b0:799:c0c8:e9d1 with SMTP id 46e09a7af769-7ce50a2721amr12198384a34.24.1768249268259;
        Mon, 12 Jan 2026 12:21:08 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4781eecasm13668893a34.10.2026.01.12.12.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 12:21:07 -0800 (PST)
Message-ID: <b8a5b940-3be3-4f4d-bf3d-36fdf6896e5a@kernel.dk>
Date: Mon, 12 Jan 2026 13:21:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: fix kmemleak by releasing references to fault
 configfs items
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: gjoyce@ibm.com
References: <20260112174003.1724320-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260112174003.1724320-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 10:39 AM, Nilay Shroff wrote:
> When CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled, the null-blk
> driver sets up fault injection support by creating the timeout_inject,
> requeue_inject, and init_hctx_fault_inject configfs items as children
> of the top-level nullb configfs group.
> 
> However, when the nullb device is removed, the references taken to
> these fault-config configfs items are not released. As a result,
> kmemleak reports a memory leak, for example:
> 
> unreferenced object 0xc00000021ff25c40 (size 32):
>   comm "mkdir", pid 10665, jiffies 4322121578
>   hex dump (first 32 bytes):
>     69 6e 69 74 5f 68 63 74 78 5f 66 61 75 6c 74 5f  init_hctx_fault_
>     69 6e 6a 65 63 74 00 88 00 00 00 00 00 00 00 00  inject..........
>   backtrace (crc 1a018c86):
>     __kmalloc_node_track_caller_noprof+0x494/0xbd8
>     kvasprintf+0x74/0xf4
>     config_item_set_name+0xf0/0x104
>     config_group_init_type_name+0x48/0xfc
>     fault_config_init+0x48/0xf0
>     0xc0080000180559e4
>     configfs_mkdir+0x304/0x814
>     vfs_mkdir+0x49c/0x604
>     do_mkdirat+0x314/0x3d0
>     sys_mkdir+0xa0/0xd8
>     system_call_exception+0x1b0/0x4f0
>     system_call_vectored_common+0x15c/0x2ec
> 
> Fix this by explicitly releasing the references to the fault-config
> configfs items when dropping the reference to the top-level nullb
> configfs group.

Seems like this should have a fixes and stable tag, too?

-- 
Jens Axboe

