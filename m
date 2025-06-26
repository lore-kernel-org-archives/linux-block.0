Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4222E610E
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944940; cv=none; b=A5my8T5WXa4730roE7w8f+vPK0/fYudlzKBK46xWU6LN7MXFyOYx8Fezw1B7WVutUmOWU541tFbkClYA2uN4BbKl9quw9sQNBE0Co7iBw1UbLUsxN2/sAv3kRgidIVK6Pkr42eHw8Yc8P2/pRpjE3BKLOfvvUoP6dmUVh5HdPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944940; c=relaxed/simple;
	bh=1UbVy/RYpG9ong/Mdlmi033HkEmNEofwguj2VKz77OM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=to70i9FNhCCJInw0IhpjeyohNxlFeG5gUB1ypjdGTZYHc24QDx8v7Tyxi2M8oankywfABibSmEi4RKvMJJ5m6Hwvwt/fAv/YWFJxrS9hOzUncLYYHAg9fuC6g7PXlpMoSU70ubG9/qGVFdoYK+WQvlDjcysZB/+oms+bThzfvac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1MdL3vaH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1MdL3vaH"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237311f5a54so10385705ad.2
        for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 06:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750944937; x=1751549737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5FkoSkJCzwjOUrZnCicv7j2S+UOLKD4I0+5496OYCs=;
        b=1MdL3vaHDPhAfN4GjpaHewVIpYLE421w97vFJprC3fyv7CNSoqvc8y0nfOyz8y8too
         pHBNjTawQjW5vDycLRXcG56Ol3oR3dFl40tI31Y51hMGUR4Oo26BzcnV2CXUXKSgMjc8
         XSzxhDwjToxfNl7BmJvPlTcCfQQkjrRsRAH8d4FJnvTfJ6D9Z1k5XVwJh4bLl+i7tiL1
         k1jU8s7lV5aqedYf3cFruW+AGQyPq47NPQlWAJuWHa/prun8DXTjS3BT1V5rsOFNHkj1
         SmQI5M1fRaVxZc0/O4jUC+DhDC1aBvVoWjTjogjWnPtm7MyTQl1APT5DGKFpZYnns/zl
         KAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944937; x=1751549737;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5FkoSkJCzwjOUrZnCicv7j2S+UOLKD4I0+5496OYCs=;
        b=qWYZHi1uOButEkMaMjuDIKM7lg9BlP+GL1wFmjtm5F/DePd4kv8ysYdGoZGnZ63Mw4
         231P9CHvP5EWLFGKW7BZybutXNJI7GkxFjiYCGz+yXPkGsroY4WiIHBGW7c8bojN9Wbc
         14urtBy9oODFQ2yKCtOkTrmE87hK8cIixYxU2NaNMm17XaRzDcSweFrf8fOKZnjGanJg
         IYzczP3O+8XL9heSP1fmOayi9JVwVu0eo+pm8Hr7gr3AH5YSuiPfQdxiGGFtBiGFNSQr
         8TumvCRQIXT8c2QSPbL+50yJLiUq40/YB29Vt0lfoYBMIFEBExIzxbeNgwoKr/iePdkm
         kKgw==
X-Gm-Message-State: AOJu0YwOKE8WdANVWREgfxXUtOpC/9sGb3Gafwpil5CNqRFTX/g+YHIr
	/4M1kQBeRlAZ+iWsVXzPdlWhbqxZO2gRn3zOqcxtoX7E7rJHcMmtzIzAz48W2Se/g14=
X-Gm-Gg: ASbGncvDEKsylhzTIHYUFLl1H2WcSNEBd969t5rna3yzi1Cr5W0KjkQ/onsemjnDc4q
	1djgQ8fNiQV08CA479xl683WnmOhtHNK7nFC/wb4rASttY9E+MWHdhKxmQt++D0kBg7rHbAUDN3
	kIde7h6aihy5D7FXEisOS+6HmJLhy519ukiLPNijCqLLWi6MVH5Dc1HR8tof0YlAqbilUOeqgF7
	rk4PIUMmVP61F+9VQqoH6r99sD3hhRj9hNkUi6oI+Zle7cPzq/894RD6Rwgmizr14rAKd2pSwWg
	PxqLS/pHuZ+06KkdR0Bspf8/EpmScgCWdp2MPckcTE7CJ7LnZR84MwiCpXJcRCPq
X-Google-Smtp-Source: AGHT+IF5Uf5pf+UNggE64dI/LHtG8EE8QAxrgFSHws8yjCwdfNuacGWJPVN9G1vMDi39wJPuCdtcKw==
X-Received: by 2002:a17:903:350b:b0:237:d192:ac4a with SMTP id d9443c01a7336-238240984c3mr108548585ad.51.1750944937419;
        Thu, 26 Jun 2025 06:35:37 -0700 (PDT)
Received: from [127.0.0.1] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8651b47sm162695205ad.153.2025.06.26.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:35:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hare@suse.de, hch@infradead.org, john.g.garry@oracle.com, 
 Yu Kuai <yukuai3@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yi.zhang@redhat.com, calvin@wbinvd.org, david@fromorbit.com, 
 yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250626115743.1641443-1-yukuai3@huawei.com>
References: <20250626115743.1641443-1-yukuai3@huawei.com>
Subject: Re: [PATCH v2] block: fix false warning in
 bdev_count_inflight_rw()
Message-Id: <175094493620.208798.522979576401700817.b4-ty@kernel.dk>
Date: Thu, 26 Jun 2025 07:35:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Thu, 26 Jun 2025 19:57:43 +0800, Yu Kuai wrote:
> While bdev_count_inflight is interating all cpus, if some IOs are issued
> from traversed cpu and then completed from the cpu that is not traversed
> yet:
> 
> cpu0
> 		cpu1
> 		bdev_count_inflight
> 		 //for_each_possible_cpu
> 		 // cpu0 is 0
> 		 infliht += 0
> // issue a io
> blk_account_io_start
> // cpu0 inflight ++
> 
> [...]

Applied, thanks!

[1/1] block: fix false warning in bdev_count_inflight_rw()
      commit: c007062188d8e402c294117db53a24b2bed2b83f

Best regards,
-- 
Jens Axboe



