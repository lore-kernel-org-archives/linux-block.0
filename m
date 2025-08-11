Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418C221F37
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920940; cv=none; b=idVRL3Hh1NYRyasb7JIwvMmyixhpIqlcM6RHwhBz4+T3qUaPzn0i3RviInq0LVaKa8qFeJodBjNVa0X31ooJAhP6n27XuXin2PyiduYvYq/FJsxvzdq6sPxFGmOyYHLhDR2sFSxF4L4f6mlIH28AgsA6Z2Y7kGuVZGBmnqmXY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920940; c=relaxed/simple;
	bh=06gZDC92OAdkO5dOJ43DVg0d+8bMRn3RRcDU/RZvNxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hisVMTNH+o0YFBznvWzutLARu1zHGlxm/dRnnEU9v2oMHHphNIQ+xuV4BQIzZQBY1TqvkGR5vMmf0QJo4T1y1d1smSbwQPww1OpNGfZDvnmMXlN4QvQq7yga0W60Xx6MlE02ODNJd5ljHCW5IfKTkYbxG8FTG8aTTvHZXDp8UnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Umtee+5S; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Umtee+5S"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3f80661991so3797201a12.0
        for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920938; x=1755525738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HynK3yw74tCVZlnSB+FC55ZKGpBTHS1HxgPxvGEg9ro=;
        b=Umtee+5S01w19PhAMvQR7Ah47NgQTlYqcqS5wByBsYZg4PJ7Y4nx0Pz/g+C+roXosW
         7Wj7hIj6mwalOxgiu8hrHyiOy919PgEiiIiJhzLwAEA8+D6eBJvH0yHRHk6OSKZ96KO/
         3g7m0EKJRXqg1jX1bc+zWJxeINxSTjGmXx3eotJOK8oucPob37zLtu4Pn+RLGgA8aZ8F
         HOBZLWRYlJ9w4Cyt0mMXnG9/w2z4pZvxjWYxTB6iDvqlGtmJW4ObF/9eBkFbePCVqGqL
         EVLpZdtiwy7WGRFANRrkdrdi+6xWA5DHvBjvSRleA+bI8YnHXX605yR3RbqImYir+C8W
         2ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920938; x=1755525738;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HynK3yw74tCVZlnSB+FC55ZKGpBTHS1HxgPxvGEg9ro=;
        b=Zz2EvnXJZ5P7C8eCoYdNWYIG73sDGtR8kGhIdUcqERuBFdD00UWF4nXwdtfe8bUFAI
         fJrX1puh/oeBel31BsHZwWaFsM3ovoiVkydgrIZKEcoAYHiyugPC+mSNjyuLw40ePwBM
         dPhDXjr82HkK1hg8XnM0U9EX+ljMZhuic56gXYrFqNqspQt+6fPTUXTVBuFrSRQgyeBy
         bO6M5pbhY/+LCJdiKk9F4MTKkSXdpXQTuD6ljgt23FZd/c6A4dzS1e2+CoTK6nCpQMJq
         LJ7SWZDiEsOAbHGiex8lD7nL7a8eUfnukbT+dXHBo0QdmsLT1GLD+wwSNn/Kic8gkMIG
         q6yA==
X-Gm-Message-State: AOJu0YzsYk8iOeWE5uAkdAnSx1uUBYG4CXs0tbW9LB6v6Rr+rbQpHEGb
	gTnnBr9Bt1NxjjopfB6vLpFq3gHS8Ozt1d+0fDOrpvOlCKLrh9ZieWeG6M8yaoN0k3s=
X-Gm-Gg: ASbGncuZe3vQ3gukV1J62yjFkti8fl098F0ghVDcq5hJCHnVtEN4n58gDTA0SvGbufS
	Pn21m2ZK4jFFM6ttbs7eNZ8OTbNWJaf1Zbvu0Bv3b6miGId1buUHdo7m8AVwYK2fuDg8VJoHTTa
	JmVmdCvT3mHDGH1WUir6XdslSfmDYy9wbAHL8wNMzngW7haxxmIjQdusRkkMD/fk3lpL5Rm9qho
	bZzrbMA2yn+89TACy48Tv/jUvTWzl/w4TLmbvBc4SEUl6V+UeDDnvbTLNR5b/HzzM7cGaG9QMzU
	itMmbywgx+j7FGZrJx9kr9fpotvjXSOzuQqZBLcm5A9yx/JKTLx5wXbZIVUKhDO2LjvLWM9vd75
	7qBLrfSxLASFVoGJWQFS00gIRZQ==
X-Google-Smtp-Source: AGHT+IEfmpU0b6S0i3zhLG/7wjKd1mXcWSglcpDeYqSC0LLFira1cW5+wVyEDOnNDDCeYxgaoo2j7A==
X-Received: by 2002:a17:90b:1c12:b0:31e:b772:dfcb with SMTP id 98e67ed59e1d1-32175611801mr25545062a91.10.1754920912253;
        Mon, 11 Aug 2025 07:01:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 houtao1@huawei.com, zhengqixing@huawei.com, lilingfeng3@huawei.com, 
 nilay@linux.ibm.com
In-Reply-To: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
References: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
Subject: Re: [PATCH v2] block: fix kobject double initialization in
 add_disk
Message-Id: <175492091078.697940.9736842876552825184.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 08 Aug 2025 13:36:09 +0800, Zheng Qixing wrote:
> Device-mapper can call add_disk() multiple times for the same gendisk
> due to its two-phase creation process (dm create + dm load). This leads
> to kobject double initialization errors when the underlying iSCSI devices
> become temporarily unavailable and then reappear.
> 
> However, if the first add_disk() call fails and is retried, the queue_kobj
> gets initialized twice, causing:
> 
> [...]

Applied, thanks!

[1/1] block: fix kobject double initialization in add_disk
      commit: 343dc5423bfe876c12bb80c56f5e44286e442a07

Best regards,
-- 
Jens Axboe



