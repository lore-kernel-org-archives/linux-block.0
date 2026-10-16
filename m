Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49463806D8
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 02:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118701; cv=none; b=d6ieGTweQbYBahbiSoe2blODf92MzoIAmMid3+klcG73DCMigX6uJkaT5CvQBMBPhEt7ZUs1ledEfI3oxUaBbAS5Ekgg0L46TCl3QMKlaXHGiXFs1d+NeMYrrvQMShFxsLqwLkY1tE7xq2B+SUcjhYfJix28qdIWeuhNIe4NwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118701; c=relaxed/simple;
	bh=0Vxm4VZCZ8jpZLCSVg0ggNJMQhCWNG8XahSTGZ9xNlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jt95MSzzfdB1VVqzvJjTPGRb2Lt3/2FL2yOt35YrWwLegCeAw9g5Wn6YTG4pZIEYYCHs4wCRC11GJ2SvnWQzDXjZCJ8ydngft9489cJw2u7DA9kozkHj5mSqmfppNchoN/g8+b7CSO6MSzIQDQ5XtlJbFRduU0ylKHtdIyTEhNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0/xjsdw; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0/xjsdw"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so4452244a12.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 19:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792118700; x=1792723500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bhQu6i5bnomJdqlUlby+n7UCmgHRVsFKdREdnXuUkFg=;
        b=g0/xjsdwYah8Qb5dh7lkmite/VXew6BEbd1hvCLTn/1Yx08UtcS6BOw2365TdjI2JV
         wJMACAcM+SGvoZC2C4xRu8JgXr6th25nQNOPVEx3UbC2S9R9mJh72y17MNaTQkFBVFyK
         qnIeADbUIUUa4GyaSeOYoKwRE9ZKtnX3kXwf0ePhkxiPo6DZgcwl3mb9ZRRbJYk1VtxS
         GffZ4E29zxTpMHuCt2L+7DDgFQquI0/r7ONAiAjcssQrYhHg59PDnACtq5HsOXIGldzQ
         CWUfC6bGiHJ3fFKq1yn4UOtLvKUW/QkFCpe5o5C9pUMOFcJQ/pvMK5nzne/od1Qwga/Y
         IwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792118700; x=1792723500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bhQu6i5bnomJdqlUlby+n7UCmgHRVsFKdREdnXuUkFg=;
        b=g3upPQnjI3PIKxTK7JU+5lWvrMICUkMm2ZNGeuzweSWS/b9Lp5ciq9Q6NifCsuRkoD
         +psWnlAKVPJF8y8Oc/63/fnW0Xb1ZhRojH4A5x0SBQx8DtK7Qt5iCFfx5YcbOIOmOPg/
         M96scpTcdd1GvbNMpKtERUPhW4IGaLAuKM2pSiuxDBm9Y+6ncrfNdRZC7KoyABj+KztI
         YRv9ICm0Dq38S25hwj+vBGDf2YN5x84Ssn0LHk6YEFHB2I/wpI+rhlLBcAQItFUmMbHI
         9wSsOa0f5rEa3mFjw++S5srxt2RDngp0k0EY99A9azqjbd815SAysVDl81A4H1xiFKW/
         Vgjg==
X-Forwarded-Encrypted: i=1; AKwUvBxUcyVaWHCAeJ2K4xXxQrE/PrEtpKQ4G6hja+ZFTEcRVmGltBTLYNInYlVL2jApjTaKqtchxlZn/fAmKw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJB3sJvsvwRX422yKSA2xzsL6p4KO6mDPk3xk0KPX2Q8y7VDGqH
	P1KNDu8uKCq0XfuIAA3RFhY8fLK1dZSGYjwgJqgTsz1THQEhjoqWo09CB3I5Clypcdk=
X-Gm-Gg: AYBFou0Khh3mY4dD71HsCYYN04sQtSYlfZ7Gfitw+f+VJixPwcv1NSIhstza/e2JB8D
	yF4Mdyn5KEu7ONAVgnOEq8u4u26GtRGOw48CFy3vTBpMD0Vv8Yye3Gs0nhUikSyxQBfWeP7vf7r
	k8u0rpsqxCJXC+8FiICryT9IyYdlAXjU3mTAAIQmPmm/jQSdj9xsmxw+Qxq7CseAUmonhYfSFPf
	KVQiEoSGv8zIZklzoZh93w+jfBkJsH94mpfkP1l0TGiR4HM7PSrT91FjmR9mLjEBOr20wzFdFad
	Z5sbal/5F32kgoc+5X3p/WerepgeRpEg8dKW6QOkKJEoHXVXVb43FftGsUkZuzrso4TpmdCuRA1
	oujM2+x8F5J4OIKU6GUgpo+f9+Gyrk1qdpAvI7D2FIaYkRGMYRrkU7NBYPFoFPnWFStZu4lmVYM
	8s1/8uMv+2yY2gldce4NaNMzvosDKYF7LWej/2zd/+Ct2WvNotloDBvixw4FWz584TkRpuEbFxW
	+xj0j9YCjQ=
X-Received: by 2002:a17:90a:b90:b0:3ab:be66:ddb7 with SMTP id 98e67ed59e1d1-3abbe66df61mr9344941a91.47.1792118699948;
        Thu, 15 Oct 2026 19:44:59 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f4cadsm1769353a91.12.2026.10.15.19.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:44:59 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iov_iter: validate extracted segment for bvec alignment
Date: Fri, 16 Oct 2026 11:44:37 +0900
Message-ID: <20261016024439.4069212-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181702.21329d323eb40d145a6d0c9d@linux-foundation.org>
References: <20261015061907.2713943-1-4ncienth@gmail.com> <20261015181702.21329d323eb40d145a6d0c9d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yes for bio-based drivers, but not necessarily for blk-mq hardware drivers.

The worst effect I have confirmed is an alignment-contract bypass.  An
unprivileged O_DIRECT preadv() produced bvecs with offset/length pairs
(1, 4095) and (0, 1).  The bio reached brd_submit_bio(), and the read
completed 4096 bytes instead of failing with -EINVAL.

I have not demonstrated harmful behavior on real DMA hardware.  For a
normal blk-mq target, blk_mq_submit_bio() calls __bio_split_to_limits(),
where bio_split_io_at() rejects the misaligned bvec before queue_rq().
Virtio-blk and loop both returned -EINVAL in my controls.

So a bio-based driver can receive a bvec which violates its advertised
dma_alignment, but any further effect is driver-specific.  I have not
reproduced memory corruption or a crash on real hardware.
