Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB31A08DA
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526273; cv=none; b=aN69RBvIwc4M3YMeBulD92wmbcb+bN2nusHIZRftNYV35k2Nw2HGjpKl7xtILHZOiSNIe2i+cHeffvGR7gGYhw7AIgBfKtzTiI+2S4CFXM8svyiEMk2WCzZbryel0A22l3xFddBj5GoxfQUbqx0iJYaNUDduodbKni5njD9D8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526273; c=relaxed/simple;
	bh=X9E4Qk1wxYtBh5bxl/u2UGW8UBo30DycI6hdjoQ0HLQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qPNECUg/otDQ7JOWDrtr6zcTMKY+818jO5EhjbUwQQzGj+8rDWUs6tBNBooiZ3++XCZqNjWqPujoE3oRcRt5KlubhG3K3dGylVuB6lMfgY39D8sZxyP1ioeB0n6JCT0d/YOvLj5hzp6HdMwJ1JnLxmZ9aTtneUjImBCLbwX5cTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hc+5DR/9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hc+5DR/9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9f6f41898so2635775ad.1
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 15:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719526270; x=1720131070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzUeJSzA7O0i1y/5o3j5JniUi5itc+6L3iH7CyccPZ8=;
        b=hc+5DR/9ezmyFy+ezlVzhhoM9li1lzAnIqfMEb7ANQtP8TSn4Zx6TORh9zl7kPehA2
         xrWSAqq+CCjTECKAR1oLOSUEwZO93dqtvLsgj8OvQusCWgieOQtWLZ/KTY0ezG5XDBks
         fHVNlFyDHsc6JFYGsLxo/6N0K+YLyfdX6fIeS0BSFYdHF2vPK8wGxC8fFBEuMHzySdzu
         IsCorEczkAeEntbWPs0FvG7OA7WR5kvpPKojaiuqA040XIccYfwTOzuVXaDWYAWEmMQw
         lwOxRXJx3Ag5ByKz4zKLvaloLBS3duIAw9BEWpym8Ef9pzG8cvAfiv5whFZI/wo+WST4
         DYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719526270; x=1720131070;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzUeJSzA7O0i1y/5o3j5JniUi5itc+6L3iH7CyccPZ8=;
        b=TsM7olcXfkhBvklM9gn2r5KF4SWehN6GVCMr1xrVKdH8Tla7Zdec9Whm/OhHRheVUz
         0AL58dHMmmzwslScl+q6XfnQZp7t2mg0sFN5aSk3v5WWMiAPWaVJ32cyLdmAniXiJYed
         5gmFzYSDGX1LPJNMOBJJZmuAwsDQHV/xXe3devw47mxcfxcxPF1eit37z8Sf8uxPzbZu
         LPqMoWSy4kKJ7pYkmrhJ0KbE+FCzbBIQ5Vj65VW07UIMbIb+XCxqv8BgqatDpq47aYlE
         xBxowXI8lU6VkDRFbcDAJ1mcfFdcLA413ZIbIXjbLC8d6HPhug9XSUvqpTv9cNEMsrZL
         vXdg==
X-Gm-Message-State: AOJu0Yx/9bRhVjenhUu9rfkwR61Ngq5g5Xvvn+izqhjPRpg+OygVYlY8
	i0N6WIKuagTLQUDiJbWHcV3yIcwLQTaFobnVpdzQ+DZIO2DsLhZOsaU/prhoB6GYJ1RxojVLHxi
	i4HE=
X-Google-Smtp-Source: AGHT+IEkdnMzrHEj0QWgi0YI2EZP5KXthKiSAx47k9DNWh0/wM03ckJYoBxjLYbIctXBLkeKN91eLA==
X-Received: by 2002:a17:903:1c7:b0:1f7:2576:7fbe with SMTP id d9443c01a7336-1fa09e8a5e7mr177124265ad.5.1719526270012;
        Thu, 27 Jun 2024 15:11:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac156957fsm2513215ad.228.2024.06.27.15.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 15:11:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: yukuai1@huaweicloud.com, hch@lst.de
In-Reply-To: <20240618164042.343777-1-gulam.mohamed@oracle.com>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com>
Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Message-Id: <171952626823.874041.3335958762310133859.b4-ty@kernel.dk>
Date: Thu, 27 Jun 2024 16:11:08 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 18 Jun 2024 16:40:42 +0000, Gulam Mohamed wrote:
> 1. Userspace sends the command "losetup -d" which uses the open() call
>    to open the device
> 2. Kernel receives the ioctl command "LOOP_CLR_FD" which calls the
>    function loop_clr_fd()
> 3. If LOOP_CLR_FD is the first command received at the time, then the
>    AUTOCLEAR flag is not set and deletion of the
>    loop device proceeds ahead and scans the partitions (drop/add
>    partitions)
> 
> [...]

Applied, thanks!

[1/1] loop: Fix a race between loop detach and loop open
      commit: 18048c1af7836b8e31739d9eaefebc2bf76261f7

Best regards,
-- 
Jens Axboe



