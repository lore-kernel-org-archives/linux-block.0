Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7BF2BE7B2
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118885; cv=none; b=FdKGb5BvlwbahXxpdBPiFkit4fV1Ay+Z/geZ8z4cWmMZm0HPiDEq4pycvvLTepwY2iv92uAXEzW1wvkyN5l1+yJ9oXpharYTJBd1adTtFFIcaERtk9wHIYBKB6BSembVx2nGOSc4jmeYbXFLU5hABBT4v/utiaJt1j1g2t40eFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118885; c=relaxed/simple;
	bh=1TUVSazKQlcSc3z3Y2bsrkbYOyuQZNMq/r+GrFIaxTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hTmSC2L6xHRojVGHABZigGlcy7qd9TfeUtUqRxoKFWcopSCUcMz1AMXCZLty5An+sPuudgKjunikp1CSKJ0S2nLtRR0vwUA4+lkuQFn+T/GJvujmkCU6WcfpoQLTUmh402GjmaYnaOBCwv8qDe549v3OHNPrreWPeIn2uEEE+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wjJHQij1; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wjJHQij1"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-88703c873d5so194933339f.3
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758118873; x=1758723673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d68s8pWNCdPaGhVBNodG3vOwiZCJ3oHbIMlBi1U/Nnw=;
        b=wjJHQij1Djnyd+LvAKaJ4kZDOns/Xoy+QAvOS3vhpqxRB2B+xGPTELcZ2lPynzkwTK
         I3l4cTijuHItHj42TfPELiHvw2dhDtgLdYHWo5xIhbNbLEzoVQUrjCjhSh2tEqSrbo6t
         xHcXVl2d08mcWhHFf0v4CGXDC9Lgk2lfF9aQHF42dyYSRugUJ48y1NN3jiTpUt+PIH2c
         huq2O72EpWltyhKJhSubacSFu5Ba3RpyJ58Uise8DjqELET2s6wlEAKwr4IF+nEq5IV8
         cfBPcfLjgSiLIzWOpd0sHHjoOxSa+eEjLpBaEst2HvKX4LKilkAe+yRuG/vvcbpBz302
         fmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118873; x=1758723673;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d68s8pWNCdPaGhVBNodG3vOwiZCJ3oHbIMlBi1U/Nnw=;
        b=Y2vfYWtd6Ww5cKATBa1XX8S96YVNZ6aCLG0tiwRvwsfz04QJFVmug68XLCBACJfJ8h
         mLf6KNEQ8W3KjsJqaP2N+T2wLLh39+A00f20BcQk6WcSsK/Wg0uDTvPb5VdCUKMW81+d
         BUHmJi1PCPXIEd1qQ7uQzle/mrgKFr/73XoOlWH75pK9cf7yDaut5MPcG/JwEr1qdk8I
         0TDU6YD1T7O9lPEekGQOfIPfksWYKKjq9ioCp6ATI1OHW/V1kyIp80YoXbSDdw6gP4iW
         vCch3iuASG98zfk+OuDZf+aMBkX6YiqmeAYgU1ZJdomQ/fxBNY7pW/f8/u3dyucwwFU0
         hIDg==
X-Gm-Message-State: AOJu0YyBj8gO9+okzyEKuy2BKmt0vTOj7s2Qbv1vkEfMq6wnojb9QYDK
	6ROioessf1TONTDiQbdYJlL11zFgTZjDqxVIyxewvapLOU/+jzCYQ9E3Hve0rF3eD68=
X-Gm-Gg: ASbGncvU5euBUKcYorMe4AFUk/AN0B3IlbYGQbW0tG/2HEvzGr4pC6xEm9w46JUkRo8
	LDekFrdr1xFQqUcSrVFfNSJ4MuEV3dmXZIRH3vyWYoLk9vYVn0+IELHK1ej/mZFdAghPyjnSnel
	AeHW3vvseFKBRLJ+GkQx1ONBd40x2ldpepDDRTidFQ854EAdMhe6BEQ8eEs/GQvaMUnS5syCnuz
	/kl1Tg3txKDp+pd+10fiIoGrtEEUojJFTGa/S55SO7IWcFxeMPxQH1zO9p98OuA5hc+yAk5dAKd
	RuS5T62epQVnvVB4r9coQ3cAhLlDIGlQPb8EA4cMiuiDQZ9+pPApHs5I5vHgIEp3ZCuTV6P9niJ
	cgzlZNcDyLotgMQ==
X-Google-Smtp-Source: AGHT+IHdd2VS4yz6Fa1klXONV8I+5ZoG/vMhg8JzZxOXeIeHOgf+AemBCv8ARUuHNgaKUufvKlJZJA==
X-Received: by 2002:a05:6602:1683:b0:887:1b69:9693 with SMTP id ca18e2360f4ac-89d1bfaa016mr356375239f.5.1758118872921;
        Wed, 17 Sep 2025 07:21:12 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88f2f6c6339sm670751239f.21.2025.09.17.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:21:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
 drbd-dev@lists.linbit.com, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 john.g.garry@oracle.com, pmenzel@molgen.mpg.de, hch@lst.de, 
 martin.petersen@oracle.com, yi.zhang@huawei.com, yukuai3@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
References: <20250910111107.3247530-1-yi.zhang@huaweicloud.com>
Subject: Re: (subset) [PATCH v2 0/2] Fix the initialization of
 max_hw_wzeroes_unmap_sectors for stacking drivers
Message-Id: <175811887192.378805.895284774096542580.b4-ty@kernel.dk>
Date: Wed, 17 Sep 2025 08:21:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 10 Sep 2025 19:11:05 +0800, Zhang Yi wrote:
> Changes since v1:
>  - Improve commit messages in patch 1 by adding a simple reproduction
>    case as Paul suggested and explaining the implementation differences
>    between RAID 0 and RAID 1/10/5, no code changes.
> 
> v1: https://lore.kernel.org/linux-block/20250825083320.797165-1-yi.zhang@huaweicloud.com/
> 
> [...]

Applied, thanks!

[2/2] drbd: init queue_limits->max_hw_wzeroes_unmap_sectors parameter
      commit: 027a7a9c07d0d759ab496a7509990aa33a4b689c

Best regards,
-- 
Jens Axboe



