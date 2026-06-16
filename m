Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA511392C3D
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642169; cv=none; b=TRjHWjTAR58uPn+3toGQ8OGekKQQQH0d7lgPX3KDi9tOACFm0zTBOoMv2nbY/7j9I4S2evy0Nm/FDw7DLrWiquOzwxcZ9i4uGo99cQmhuoOzXZC9mBbfpGxBuq6dX+q8L5Ph98h60kz5pLMhpc5ojLDi5ql0/lLuOiEqU3li+Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642169; c=relaxed/simple;
	bh=mxMKe0jgsxOJM/p9h7RtsXKKJZ4vpt/rgkLudw2LN4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhAuue1ybAdUb2l+K7IFMcTafKa67vljl1H+LlsMTVJtKk6SMJunrEr8q7iJwrwpjfaPvDtoSrg+e3/ntEd0kWH8p5/hWvSl7NNOpW3ZKMhNBllxCpoDq+sxYFmlZk0Fi/Zel1HjYsRb8CP5k9pL2RvCltNme1ec+nFRVRtEvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=nE539p1K; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="nE539p1K"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6d37b7098so5132379a34.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781642166; x=1782246966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2o1XTR7VeYkIhqu4UtENSoBuqpZfEyKyn3oza9yC94=;
        b=nE539p1KlGa15vI841yfbah1dtZVYsMGZS7l7VyiOhXxdDuGdyeaLXrJ+lsI9GgIzC
         hlN8xT7CDmPbxdA/hSHjsO1/rKq6mcNqDyrfSN9ZmYIcHrjBw7GbBVTJNWXb24JN3JkM
         fZbeLNHsNTvmWZRBOy8G4RtvskHoFDlO8onGcHWflTJbtbjj2ZlNt2hoMK60xMvTTGUf
         vG0549szZZKtEC8GVJS55dj8HqICEznt81kyxO9ao8QjVV7tpQedAU9/c7ysvjbgSB2x
         uPO6GJUsZiko8ofHKNlqI1JpUbGk7NL6TiT+JXoLst/0/bjdlF+WsmCWiVR4ZpDyMC5V
         s75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642166; x=1782246966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2o1XTR7VeYkIhqu4UtENSoBuqpZfEyKyn3oza9yC94=;
        b=QuLCbzC9ExOUAHSaRjqF2t27bNCkMq9KNkL2Xo3NSQ+fXbQFq/iJ/IPyg2iEllVEN6
         /0VH4Sz91bbn+WsR7lNBuq07smSl8YFSZ8EsC7Cwjivtp2qceBUNzZR4bg3QIdWg2oVt
         V8d+Uthko7uCB5nimQ5Qu8FdQXteQs9N+G/XIvu4mHJV72M/qxb6/i0kYcfA74uHqEC8
         Q1fJYo5t+qU+T1/cjYKd/Y/pYTP4Hbyhd4JkEW5l6QJ4lmKaU5zyTUk12Q440rPJZhlt
         zcuLd6tQDmauG8i4YqgT8QjDYWbWqGlKP95DkFWbseS22LFLXg2esM08H5f8CE7Ur5xJ
         w1Hg==
X-Forwarded-Encrypted: i=1; AFNElJ/CRqTG6M4hqpJuADNesTf9P0mkqjIjiEefTc426+oCNgQ7zTGzgpbi1YONv4K0ohRJ1+7fnUxOFDxSWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0K3MCO+odBDdf5Jc2ERkPWiJwliB25uMcvWemKV+rhFA7Ne/u
	bcpNLPZiOipBsmUP/rGGWIs/FInBXnY0+aXUGdMpW83AX2N4PdeiFafDM2qmT8038Kg=
X-Gm-Gg: Acq92OE2IYidDSVPfE/P4MQ7L1Mvqkvzyufh644aj3BYW7ynpUh9Kg2wF0/W7DR2RK2
	VxOLSLFRkVpSo0uzJEgQMa6yfCGK0f3u/thLPxQAwxQYf43AYL5lECio1qGt26C4+1Ug3KFc0Zy
	8K7P+pzB3y7LYfCJCa+RPYTkf1Dr0dYQH12e9gS1w+rmb988Ah+r9nuYb71S3Cu1IWzP93f0phB
	2DnBS1Kh4dS3bYXLc/Mhp8IqeNYoRhAAvJgbhbdMkJTEgWLQF/WzhbsZ+pktqALEIb5uYpfRJAz
	fekzpiChhe0B7xpXtVVqgItMrCvupB3VCOG63HL9UG9QpPo5pPogr+uGZ5RkEq6irSglB3QaTEB
	+GlraumMhhXoP2fv+Prs0TySBfGdePIH7i0z1UYfqC/nhVKVbET/rFPkQ4FB+p5+LEe88jPVyE1
	BHJ2yetESz7eU/0bPASN4Dt63pA7PEkzroCEiFinxu3K60v4JfxT5vfg+f92PFVJcxCU0D09yuw
	PbCZb+HtA==
X-Received: by 2002:a05:6830:3747:b0:7e6:fd45:9cbc with SMTP id 46e09a7af769-7e90b3b982dmr1104256a34.14.1781642166451;
        Tue, 16 Jun 2026 13:36:06 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6de65bsm7523821a34.19.2026.06.16.13.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 13:36:05 -0700 (PDT)
Message-ID: <fcfa9bc9-4f7d-478c-90a2-ec4efd4c7d43@kernel.dk>
Date: Tue, 16 Jun 2026 14:36:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring
 IORING_OP_URING_CMD
To: Bryam Vargas <hexlabsecurity@proton.me>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Paul Moore <paul@paul-moore.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260616201633.275067-1-hexlabsecurity@proton.me>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260616201633.275067-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 2:16 PM, Bryam Vargas wrote:
> Hello Micka?l, and Landlock / io_uring folks,
> 
> A task confined by a Landlock ruleset that grants READ_FILE/WRITE_FILE
> on a block or NVMe character device but withholds
> LANDLOCK_ACCESS_FS_IOCTL_DEV can still reach the device-command
> surface through io_uring IORING_OP_URING_CMD with the IOCTL_DEV check
> bypassed: the request enters the device-command handler (block
> discard, or the NVMe char-device passthrough) where the equivalent
> ioctl(2) is denied. The destructive completion and the NVMe-admin
> surface follow from the code -- see Impact.

I've said this before, but apparently it hasn't been received - this
isn't an io_uring issue. If landlock is missing a hook, then that's on
landlock and they should add it. Other security handlers already have
that. Hence no need to broadcast this to a bunch of lists, it's strictly
a landlock issue.

-- 
Jens Axboe
