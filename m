Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03368266588
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539309; cv=none; b=knG/589tuQmsUMZX32GLSvDY19Co3N+hvuGreNyuf5toO0sX3NUcTpQuMsY1FOOl1NGkU8+M3Ff2zKQrcXJgGRO4ICe0xMcbnieslBWL9aqkfGWH+ewam0QnzUSjrRgRK6M6yiLDKAM0/dU91aMGviY+sZUTstjtdelhKxf3nOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539309; c=relaxed/simple;
	bh=QRGdlD65eNsYAPwAC1S3BaioH7MmJ5frZWnduOm9Nfk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W63c1l5wlcxTl5SPg93/cJdnjcMRvCVkHrB6/udK2v8Zh4kCh/Jw6KGMPuK/gxQg6/Kuuldun4PuTNxSHHmFwngVen3PEEe5ofAogHjENAIZKVFpwAZDWiAN1TAFyYgG4aUVv3uCSWpyGuvgcoAEXuPCA7VjRmf1AJcyu8TKjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B4gFtCFY; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B4gFtCFY"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d9189e9a06so22621485ab.2
        for <linux-block@vger.kernel.org>; Tue, 06 May 2025 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746539307; x=1747144107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouux5tEC0r8GlXcTXcTxPnn6FWgykiMGJ+EUBiPslWE=;
        b=B4gFtCFYiTgeMUBkGtyWoAKMQatG2Ju8gQgQoJ+wPPAkKzzPGiVSqEv9B4ZuYBcnyl
         MHRQba5+0o0+zN1nGMhZ/L5CuUjzSOHQtgS58d8I4rp31DhbamWwUxcFT+iDamxb0ug/
         kFn9sLKPFhIhMh7akn9XyOlRikLUERfMV+AcpORKLoDUfEFqNdjHi8U0eYUU+62E1CUU
         USAFx0SCNbwxB7V/Oa3Bh11GZlanc13zDXEan1qBvNRCpgAaG/TVxB6sx11Nn5aNYWtV
         ucXIQSveMBsOu6xs7xcaFb28+rO0iNHDCcOwxQT8AUsuXC3Atx6D9wdmJgDe5lM+wcFV
         r56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539307; x=1747144107;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouux5tEC0r8GlXcTXcTxPnn6FWgykiMGJ+EUBiPslWE=;
        b=hT2qB3mxXFEQGkfBoOmePMRXuGWAjp7fP9puyMeiTGWP53ZimHcF0dfYEy9HDhcWyJ
         XEWxuyrwqtYVQazXvhycROydXCNIoQS5MLfST+snQzoYrDr3EQJsqxieyCB+5r/uWn/k
         8TgMTujW1gK1zlDHh9gz5U8iYsQJPiSSLkaARXEG+jpccsZZGDy+qgLr8HPjH5cWtPIm
         s4sgeFMnicZPNo2/78bP89nCAhHTN0h/h/INWy0uIlZXlt5KmUw2OVJIHEqDTag2PSas
         P3pjSSjiVYkM1ic2Uo/Wh8sxeMLoKLB03Iq/a8TtTKQe79MJXAf+EJSbsT2OkQarudQh
         NR1g==
X-Gm-Message-State: AOJu0YyUMXgbR9wOt6M/+2XS6yn79hjN5a83KUmR4pYCnqlZ1pRDwkzL
	LUQXDGPTmqq/fdiwULQ9yOrOUEtRppP7ffKg8KI7sVpdsda2b+IM0a0ViJcT3BE=
X-Gm-Gg: ASbGncvOOJqMRtrh954Uui4alxIuxwUpIIhka/kzIpZyS4o5pETuiCCaorcwTKrhwlp
	HDgq4UIaGLxRkakYHOYyFOpnQEHIcRi+KpOXKN4WGY8c02bmJldxqhCyKLjyoPs6OqPMUj6G9Tw
	Vw2nHM9qhEQoP3Ql2QThb83sK7ywvCodORRvHXQs8Yoghe28J8oAOLCiMpO+yT252VGXSLImE+N
	2yjuz9wYX3Tb8IDexoi4CyokEFc8JyPEhpFTkQmpZPdHS3HZT0IJbUlvJk1Qoj4ZZT/1f4zEBSm
	1rd/63AuL/JnjiFVilVfxTxdKHY5Xd8=
X-Google-Smtp-Source: AGHT+IFS6y2zyC+HSLyH0EZxcFlNsQhUlPmnmGKHIPFidATO98ChCD+1NzFKCLy5UGcU5KTMMpWodw==
X-Received: by 2002:a05:6e02:1fcd:b0:3d8:1fe7:4439 with SMTP id e9e14a558f8ab-3da6cdeedc4mr29148175ab.17.1746539307017;
        Tue, 06 May 2025 06:48:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f58be3sm25930915ab.58.2025.05.06.06.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:48:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, kbusch@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250506061756.2970934-1-yukuai1@huaweicloud.com>
References: <20250506061756.2970934-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3 for-6.16/block 0/3] brd: discard bugfix
Message-Id: <174653930584.1466231.14181176515309477509.b4-ty@kernel.dk>
Date: Tue, 06 May 2025 07:48:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 06 May 2025 14:17:53 +0800, Yu Kuai wrote:
> changes in v3:
>  - rebase on the top of for-6.16/block
>  - add comments in patch 1 about NULL page.
> 
> changes in v2:
>  - rebase on the top of the other patchset:
>  https://lore.kernel.org/all/20250421072641.1311040-1-hch@lst.de/
>  - merge top 2 patches from v1 into one patch;
>  - add reviewed-by for patch 2,3
> 
> [...]

Applied, thanks!

[1/3] brd: protect page with rcu
      commit: 0e8acffc1be10d53e909b3aa43831d6c2d25a579
[2/3] brd: fix aligned_sector from brd_do_discard()
      commit: d4099f8893b057ad7e8d61df76bdeaf807ebd679
[3/3] brd: fix discard end sector
      commit: a26a339a654b9403f0ee1004f1db4c2b2a355460

Best regards,
-- 
Jens Axboe



