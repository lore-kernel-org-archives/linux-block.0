Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FB424EA85
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690747; cv=none; b=Ky5+bg3veu2OoSqHsVc7zztT0D1SMLx82e27QCpVmQHnJeNXydi5Nragkw1zYqRnsMtkJllmp1xvctjbzuETxoCJf+K6QTfOj4fz4a3At9S98CiBUBGADK4G1AXZ5y12z5mfAgycG8Dqx5d3pmIO2TpUUm0ST/rKWpxJKsWIBFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690747; c=relaxed/simple;
	bh=HvfGMoSUI/KKVq0x71mQTs7eZuFOzkjFAiscFS2Raso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CUksGiLr+ft9/czpFKgx8giXYYyC72+dGpzr/NrhFPA3OXPVM/nB7+D7vtCZJXn4/2++VKPvuVzRP+ULqg8jVszhVrVT/4OC6zNsL3JSnaqxOAvLHzMDYt30w1n6VU0VdJdh1yJYzBl76QRgsFH9Fj2n8vRgvGSY1GJtGT1x0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bL+XaQ6N; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bL+XaQ6N"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d46fddf43aso7366525ab.3
        for <linux-block@vger.kernel.org>; Thu, 03 Apr 2025 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743690742; x=1744295542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PeSjzBiNMIqqvYr8aR+qj+7vF/gh0iP8PIzwKLAMzo=;
        b=bL+XaQ6NODgSgxqIDvxBYNsZXqqhQZwWCfz1xqL9qpmDbGj0P/g8hN0dsHp+xaC9R9
         W9N/Bpi+ezs876YavSNq+PGCHHlu1+luWDb0Td+nIEhVQtTtkhyo2dBwGe0nU28ybaJy
         EdjHJ+tenzFFIevqiqHNZSYi6kjXmNX6lVkL8mNlhHT8et4gOq2BY7CTwFbouoYPIh+r
         8cjpBzaqyZNCMrM1D3sMvEZslkaxYTuGzyaa6vIw6FT+1V463gLoPaGc+FaUJqzp0acZ
         M+gyLVYyUFzn6tc6ACFdS+H06HJxhrzaveYkFOq7fFJlEsHKraSv48tq5OlEtnJizgNB
         dzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690742; x=1744295542;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PeSjzBiNMIqqvYr8aR+qj+7vF/gh0iP8PIzwKLAMzo=;
        b=tMfq5DantBqLRvXxhp7P8wAD/F44Q7AHa2StRw9XzVANwVi9MuCF3V3P13pO8LSA2U
         /bTMUWGvGgIUwIi39EpQQdyrwDLVk8/VDoYSilSNyTN9MiYzyj1jPj5fLWf8da8IJ7zx
         kol8hNfRgGvl+4rWn7QQx9x6fp5gFnqA+OIe9T/6QGtGLlyMYrMSqInIDfdDePhOtXix
         dHz2qX3CQwkTEY/GP1dNcRfF1E+wO0tvO3gGzu31RCpG+EqgumBhoWnrzdggOSdRVa5W
         S1J140Ejj5nJOrNcFv6r3Qczt1OccczRztDQEx3pso2bFrDZKIEaq8FIujOM2oOI4vlh
         Q/YQ==
X-Gm-Message-State: AOJu0YwFQ84hX1+g47KruUhSps2oYuV5KZnbOibTbGNnNGrZ1Or1AiJW
	I4UEkJFhSo2Ww6VWpJ7KwshoRdIFQSwXoOjrw7fsNBpWAPb5OmD6CkVGJwOuMUzrNIXdAcy2IwN
	F
X-Gm-Gg: ASbGnctVdhaN/ncD8bMDRTTVXdw10N+sv0pAkixEyjWcgbqbY1/5wH4UVz7RoMgb1Nu
	XeiEbrLUy9dZpzpFEaGTisQDYKShfCjVGvyVEVm0Y6PydQSKU4JrX2EroJkQNu8sQsCRsgWKDS1
	ZkNjg3fzqpx3XgalIUotEaN6xdvtdSo7ZEkbl/lYUPFxt0uHxFx/JEtlh6o6sNA1Ubo//sLR825
	1yJBBuQAFPag2wcyRBbRNKVekt3wEGNx6HcaVX48IVXje03FBUUYeCdSWE6TxBbS1q+kG6xeQY4
	k0bJ1Bred3MU2sFTJSL0uqPn1AFvRwZJySs=
X-Google-Smtp-Source: AGHT+IFJ8F5Iyuxs59JMABZjHTpFEaDGgW47GZB+XcBsdyHFRErlKIZetJEK4UlNsQGMNINKCZNFRw==
X-Received: by 2002:a05:6e02:12ec:b0:3d6:d179:a182 with SMTP id e9e14a558f8ab-3d6dd824cb5mr37287585ab.20.1743690742263;
        Thu, 03 Apr 2025 07:32:22 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d6de79f259sm3196695ab.13.2025.04.03.07.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:32:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, 
 syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
In-Reply-To: <20250403105402.1334206-1-ming.lei@redhat.com>
References: <20250403105402.1334206-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
Message-Id: <174369074094.172837.7603605901713272828.b4-ty@kernel.dk>
Date: Thu, 03 Apr 2025 08:32:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 03 Apr 2025 18:54:02 +0800, Ming Lei wrote:
> ->elevator_lock depends on queue freeze lock, see block/blk-sysfs.c.
> 
> queue freeze lock depends on fs_reclaim.
> 
> So don't grab elevator lock during queue initialization which needs to
> call kmalloc(GFP_KERNEL), and we can cut the dependency between
> ->elevator_lock and fs_reclaim, then the lockdep warning can be killed.
> 
> [...]

Applied, thanks!

[1/1] block: don't grab elevator lock during queue initialization
      commit: 01b91bf14f6d4893e03e357006e7af3a20c03fee

Best regards,
-- 
Jens Axboe



