Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD737BE7F
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165686; cv=none; b=MJHb9X084FHsG4A+aO24BYv42nmiJ6qwHF897/BUAuUK6VEgZzTPT8oScbKUvHt/485bzlyENCp7VsEOmZfrnAHyERdELb2gyKxmZ6l5ZKXT86tpTWehU7rDaaBu6166tY0MVofdMlNyDA08G7pPCo+6UsxogwlaP7jteIigCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165686; c=relaxed/simple;
	bh=pw5rgiM42z9+JBpwIt2H1ljq/Yya2FexrtMFO0dWt34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LnC1TnEBF1dPUObNFc8qby2V1WHjysOdIkVZ+3aHElKrfrSpzFBVzazMMLiIovifkRMg2MEyenUOu31DrsONDfrvw9w5xngSHD0+Lxi8mwZIOlcaymGS52yaUQnMFB3aOkdek2hRIjftKISkAuTZ3wMLMN5/6lwab9ZKH9rGCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=OsTU8y12; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="OsTU8y12"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bbca605be3so242730e0c.1
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782165683; x=1782770483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlBCKHTgRWvnY8xmPasPUtWMx6sHe4epc0vhl27EoaM=;
        b=OsTU8y12MtR99HtRIrn6bqnYyNaVf9im0qmZ7+WTfIr7kKbPBrkV8atjAKDQGlrQ/2
         TYYKDLRnlIkwnxMqynMn2xOujZIpVbI9pkYJ65jEw3ZuPUeqoJGLfGhkt0lESbDZ1uci
         kB/LW+5aAJ43kDCJe++a7gc322ttfLY7bvlb3tdfCZAmaypMseakJ82KptJLeOQjkMYg
         Q3twJApRBVkRwS0zQS6bRABn1aW7waUa4G1HuDxV9ulscKRSg7MbrQklroAqfJeRz/UW
         NWMCUWxOqJ/61PQ9RJFqnBY0K5cAZkeT5wUYChpMc5+U0tx+IaexgbJpA5JZg+9lwA8s
         31oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782165683; x=1782770483;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AlBCKHTgRWvnY8xmPasPUtWMx6sHe4epc0vhl27EoaM=;
        b=IwDIrQpRrP1/Gy2NrChUs9eXb4bBSLDVb0H7+g9sOyDMVjsx7OATnPxPJ74grg+zhL
         rqXPC3EsMlvAhYJcuq1B7mkNK1qz0oPFeqVSlzkt30KamWdp7tRlZeWU523tChxedaLe
         IseXfZrOelbx2J0ZvI5MaJkWUieRo/g5FgNSLmuXBAE+LOJ8afLOLGgrXpWlByS3jOST
         kvh2nCEA9e5oNBQl06H6qhGniA6gpSsoAs8qK5obtYspBmQnoTNdVe80lRiXrwznPBCE
         RhS9+VgYAdxIgQuIxPaShLCRdb/12ar7zeI+wF+CxYPUaRuqXlD6V/SkV9wEIh8jDWmc
         xgzA==
X-Forwarded-Encrypted: i=1; AFNElJ+wwe4FrswqeMP/iRHmMzcYaYpz2TihO38m6rSHWr/NfgfOYqksaWewZZbxcm13j4pvdiSxEKshSD6rKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDCeuOiuNbJyI4zJF0WnqYLOYMPXP+KJf4iybp/J3WEgTRep2e
	z/H0Yt3boFGGJf7Iw2QQApwwH5+/8On+EC88bxntHjDn2PwHk5mnw+kW15sPHlOUmnM=
X-Gm-Gg: AfdE7cmQ3aElGX04bhsJOARtS/z6aJtzx+bgSpB3qNN9oIMZ0jStuJWqfg1avCAGABy
	JxMGFyuO8UJ+/RmAZJZ1HhdXzEfBcsvWgxpREquoMr1B3dDgA45edheOCSb8pupJ22Is4jLN8qW
	FJJQzOY676xjhbQFVOjbZ1jAYEbrWSCdFqYqJ6y6nd9mSyjf+0ToQqQ86sM3hOulAcb4LuXg0rF
	2bgg0MW4BxaIrWUppPGik9ecPMD3DSBaXsddguNaiJeIv3GeUHtL8d4wGu2MwsGENwd++t9lepg
	vn4dMSpy+WgUfH9JsdtziHNarcKEil1TKzFwbWbqJ1Th1kuzrtqtq1Zwm5SJ44yzfGHVSuvVHEx
	Vh2DvA0QSenS/GYciJCfCvxA8yiaWdn+tavpsfm42nuzc/WDd0QYEMfLeAeDZSSXfAUfrn2Jtdm
	COyvdYWLAY6fcH4mkUcXsiVcxG03o7L4moVes=
X-Received: by 2002:a05:6122:4895:b0:5bb:fa79:56dd with SMTP id 71dfb90a1353d-5bc2ad5d404mr736786e0c.7.1782165681330;
        Mon, 22 Jun 2026 15:01:21 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.128.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018898sm106932496d6.7.2026.06.22.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:01:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, linux-block@vger.kernel.org, 
 Zizhi Wo <wozizhi@huaweicloud.com>
Cc: cgroups@vger.kernel.org, yangerkun@huawei.com, chengzhihao1@huawei.com, 
 houtao1@huawei.com, yukuai@fygo.io
In-Reply-To: <20260616011746.2451461-1-wozizhi@huaweicloud.com>
References: <20260616011746.2451461-1-wozizhi@huaweicloud.com>
Subject: Re: [PATCH V3] blk-cgroup: defer blkcg css_put until blkg is
 unlinked from queue
Message-Id: <178216567226.110437.9780532607179300407.b4-ty@b4>
Date: Mon, 22 Jun 2026 16:01:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 16 Jun 2026 09:17:46 +0800, Zizhi Wo wrote:
> [BUG]
> Our fuzz testing triggered a blkcg use-after-free issue:
> 
>   BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x75/0xe0
>   Call Trace:
>   ...
>   blkcg_deactivate_policy+0x244/0x4d0
>   ioc_rqos_exit+0x44/0xe0
>   rq_qos_exit+0xba/0x120
>   __del_gendisk+0x50b/0x800
>   del_gendisk+0xff/0x190
>   ...
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: defer blkcg css_put until blkg is unlinked from queue
      commit: 3ed9b4779a4aa3f44cd9f78627498d7adac40daa

Best regards,
-- 
Jens Axboe



