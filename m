Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011332F6911
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776145849; cv=none; b=Rt5t1QrLFlXvnMHD9F9XI178t6XgShHGfRE+2de7APtaTk9u/5sbGInUejDoUVHtnsl/m749iao+IiCQIHugmEpV4Kuu4d2nnz5/Z6178WSsId0zDY90GT3n2fEy2vOfabVpaqXiUhi38r/76Abhazjh5xw835FUDSyMrfB1RUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776145849; c=relaxed/simple;
	bh=X7HfwBs6Hmnn23vF7gkRizj4eDs/alQHrjWU/7h0p40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdUHIj5/B1CKq8zdXsGhX7n0Iemx2OPzcrr0wtSaiOIVA+DeCDHE6BzJX3n2tgasBMNJbzu/8P6qphbKfqf43JjFP1CfLpYYiH2mbv1j8v6lNDsnRhDhO8vjA77s9Y12pqpp+7j8Nsbm1Icouh2hwYWrIfmyTAWICmTka0QMqSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmV6AcYo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmV6AcYo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aae4d2d215so4855855ad.2
        for <linux-block@vger.kernel.org>; Mon, 13 Apr 2026 22:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776145847; x=1776750647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RsXRCxDWNuKNcN/qQJzlr/9TFqUsZZ7ZspThUwaXJE=;
        b=WmV6AcYohXO54+6ILnz/cipqn8ACLn9d372kJx9d8yYn7NqyZEgsPES2+zQdIB5JYb
         hNQvCdgVKHuIoStm80wq7g/QW4RlcVD6XsP2zm2piibMq9/8DWcUbRGn8Xch64Z4koWI
         Lz5CRxhx79DvxYTjbRVMAvEn90SFxupcutHwkxWhZkLtOYYwiMF7rSh0GMWOlF3BI1Io
         6Lw0FJ+23p1Mk30/4dp3IbsvxwsqJ99y+wilanZ0+8q/wmkn9UvvUyun8lmxFNAu4Kbu
         UpiUv9vWtUHHue8th6UKiCeD+xM7beVjqZbiceS9l2L3Z6yEd/+CZxhr+TdYceMo2uFd
         JZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776145847; x=1776750647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3RsXRCxDWNuKNcN/qQJzlr/9TFqUsZZ7ZspThUwaXJE=;
        b=Iav2hkzaQcYEpo6jlCo23W7s/BagyHeslyQM9IJK31+5azVQPSdf25J7T7N7IsGkZO
         R/tY4siN/txa4TrLrZ7z1FnnshPZD/tjcJjV9fzNhnJmz/C/aodgkEAnRgr2Nr1cNNvp
         l4aCnHCglrFXD5ZtlnF+T6Mw34dVj7+ahoNC56yKLElsGrS4PP8slkeIhZawEm4t1M3F
         n9vlCqk97r8f/R6aBYIcEOwaen6hefibfq3jzGybtUV3ldqMEnVooiLdZMt605HG+M2U
         T9z2FcG6GfVE4Fy4UDsd9PgDIdu+ftbL2XGyu7fjVvUX4pTRVm6AiE5euLcHMR8EBi44
         9j/A==
X-Forwarded-Encrypted: i=1; AFNElJ8JSG/utkeJ4zKOcB4e8o2ln0GgyWILcvh4csEbyk61KnXOl59+lSZSaL/PSQcVy5I2bDdEFc2kE9kfhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweZRVPkEMyNqT5dsPT7pFT2rEjPn8drkOTwaQzBtK8iCGrfbkl
	HGjeAacUsnpfYVOmmhr2uGoVYv/5N9JBCAhq6XRYBVBoHHIZ/KdPHF3G
X-Gm-Gg: AeBDies66lNAZu8XS9Yg/7kA84bKJqCbOBuSDctmu8ZYaHnUmcGI1jGXrpDNqBO3vuL
	buKqi630BoWjCNbZE5enD6oBy6pAab+ByoMsFw6aJmxmqlJ1s3lEJfWR7bj2+DddtLzj+LGt5Jg
	dDBR0Br9KZkS68r/jS1LL4zTDm6c2XRRoF0iDNsTdE1y0BZWw5VeBLFSvZ+h3j90lYgwYIXyWJT
	rey/4/3SobUpeCRq900bKeizWzYHr6whPjYK/z5xs7RwKIDSn6Tv9M1eDV5lzUMpv/MO81RFa51
	whT1fMNsDretH3+nmfYCj9wGKCadl2Np7tZSfZJf3eUUMKkjhsaziLgW2s8W7KoR/WbHjdSpZa4
	9OFCJXimyAgECyuDz/MWjX+bKVcjT7tNwkM4L0/nybZpht/dBlgBe6vL2HfldogGBN5D0W7Zj2z
	qyPR3D8Ql50fjkuSUGu3xmKzrzypgULPa+TJ2/0Mf1z2elFUzIXaxoQQ3mkYw6Gaulc11RZgotS
	UgZcVeVw8qslRJX734W7xM=
X-Received: by 2002:a17:90b:164b:b0:35f:b2ee:6c6 with SMTP id 98e67ed59e1d1-35fb2ee10f8mr4978583a91.3.1776145846633;
        Mon, 13 Apr 2026 22:50:46 -0700 (PDT)
Received: from fedora ([38.244.149.186])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6e61455sm789761a91.8.2026.04.13.22.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:50:45 -0700 (PDT)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: ryncsn@gmail.com
Cc: baohua@kernel.org,
	minchan@kernel.org,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kasong@tencent.com,
	chrisl@kernel.org,
	justinjiang@vivo.com,
	liulei.rjpt@vivo.com,
	xueyuan.chen21@gmail.com
Subject: Re: [RFC PATCH] zram: support asynchronous GC for lazy slot freeing
Date: Tue, 14 Apr 2026 13:49:30 +0800
Message-ID: <20260414054930.225853-1-xueyuan.chen21@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <adt3Q_SRToF6fb3W@KASONG-MC4>
References: <adt3Q_SRToF6fb3W@KASONG-MC4>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sun, Apr 12, 2026 at 07:48:48PM +0800, Kairui Song wrote:
[...]
>What is making this slot_free so costly? zs_free?

Yes, I've captured some perf data on RK3588 cpu2: 

  -    3.79%     0.42%  zram  [zram]  [k] slot_free
     - 89.04% slot_free
        - 65.40% zs_free
           + 77.29% free_zspage
           + 21.75% kmem_cache_free
             0.68% __kern_my_cpu_offset
        + 13.19% _raw_spin_unlock
        + 4.86% _raw_read_unlock
          4.75% obj_free
        + 4.72% _raw_read_lock
          3.64% fix_fullness_group
        + 2.02% _raw_spin_lock
        + 1.31% kmem_cache_free

It's clear that zs_free is the primary hotspot, accounting for ~65.40%
of the total slot_free cycles. Beyond that, have some read and spin lock
in slot_free.

--
Thanks,
Xueyuan
