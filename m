Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323D144316
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403549; cv=none; b=qH1gf9qUafU+xoP00nNft97gxeu3tIqGTrJkyWAwWX7cOvShIIuRU73LoVAOoyNWgpsPWTu+nu97t54oO4LTa+DknCDZDrMuL6S0kYQOzJDwpvElI4jXxf2RZcxKeSHIrOC5eyXvu6BdGad7eZC6vfZVZRUyRZlnTsXXijxnOHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403549; c=relaxed/simple;
	bh=ePCv7FrHAMQuHZByR0Lq3P3iY134Y6c6QShxRU3pue8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xk+MPdYZldEbcLPKODifuI/zhXjhsY8kSo37+XXOUZlNfhcI4vw9MEkIV9hK9c2wAMhhzFyGCshou138WEtVcxrWrsdlglsJAE42lQwQRE0sHFGvOcRyNfNUBgo5/LoI21psVfS5hQuVWceaSPiFutDaHMhNaF2GR0n3IIHmjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ovAA7C23; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ovAA7C23"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-72703dd2b86so263621a12.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721403544; x=1722008344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gTt8DwdypGVam8YxhAR/m0jn8yv1n/KN+heoOXMT8k=;
        b=ovAA7C234Smuo8JJNwF0wzXejCQUUNKoI/iPVah6/H6QxvOVlUl4JWGgVFWClmq91b
         2+/zF06IPK+bqUKd+j/pEEGLDqHjPCj1L2o5GNFWKW7Xxw3B4SAQl6A4elnqU7ZI9n+T
         KWQ+aGKkBq6/PO7r3FJy7DdaIwqwmfL1V84cQGkPKiJyEmTZQBNWkyR5AwKCreAHIycG
         BvQfbYFX/l2L79AX/rxmUgiMzZIauBxDtP1U4SEo0/NzC2FbALHuI+/xmafCb8k+hOVz
         JANvVumxZj3AI3hvqDh0wt8tGbo5NWx/oiRsyFWIySuP7zAEvlSSXpeu9aX0lvOBl+KA
         OAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721403544; x=1722008344;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gTt8DwdypGVam8YxhAR/m0jn8yv1n/KN+heoOXMT8k=;
        b=vqPu4WmrMXNnIP1KQq8glELLOC4bIBjmbVVJ37sTzq+7QEHnGYTMWTJ8+QAVQ8S0SU
         OMm3I2lYPzr0/mdbzLwmi9MXyFkP+VZ9qIqsBSPYG5RFA5+XQE8sTfCAeMyB3cpG+K/1
         hV4JesHe0HAnD0OEKpTkkN0JIEQtzr+9rqD2pKD7kznNK9lywGAlVS9kEFcYzk4mKnhH
         KM9Ex3bZMutsvv5/iZcWynBmJut3+C1woDd8GSV4IQBAv1y1FcKVqOTfEsZWSWEiAsCz
         t6iMiWia87GRVz7HGEweFfCkMYTEhUR4v0LtcZiOVKVm3rLAi3ycDRlNHGH6IKf/otpM
         pdMw==
X-Gm-Message-State: AOJu0YweWdZDvMzFhEwgnt1+XXKj0RYJ7HLttSrakeX+kgttW5nzqHzN
	w92p8lIQR9/Gzro3/8BCTNFK8Tp20b+Uksej+3yB4aozsC3P/3H8gzuFxf/pAKqow4HVG5vU4oi
	9eDY=
X-Google-Smtp-Source: AGHT+IH5FXJwCaJXY+48M4dJBPSShl2xPForrjegT6TOsHYpxbCfZoB+ljSYgrtd3Jz5ULv7gGuetA==
X-Received: by 2002:a17:90a:d38e:b0:2ca:8577:bce8 with SMTP id 98e67ed59e1d1-2cd15f572d6mr245403a91.2.1721403543775;
        Fri, 19 Jul 2024 08:39:03 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77353847sm2969930a91.33.2024.07.19.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:39:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, bvanassche@acm.org
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Subject: Re: [PATCH v3 00/15] block: Catch missing blk-mq debugfs flag
 array members
Message-Id: <172140354242.11595.1311965862995279441.b4-ty@kernel.dk>
Date: Fri, 19 Jul 2024 09:39:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Fri, 19 Jul 2024 11:28:57 +0000, John Garry wrote:
> Currently we rely on the developer to remember to add the appropriate
> entry to a blk-mq debugfs flag array when we add a new member.
> 
> This has shown to be error prone.
> 
> Add compile-time assertions that we are not missing flag array entries.
> 
> [...]

Applied, thanks!

[01/15] block: Add missing entries from cmd_flag_name[]
        commit: 6b3789e6c5310a8f517796b0f4a11039f9e5cf8f
[02/15] block: Add zone write plugging entry to rqf_name[]
        commit: af54963f193533dd7c1fe8f3d4e7af18de2406d8
[03/15] block: Add missing entry to hctx_flag_name[]
        commit: 1c83c5375e2f1bc7b59fa3ec5aa1e5909ec8710c
[04/15] block: remove QUEUE_FLAG_STOPPED
        commit: c8f51feee135f37f0d77b4616083c25524daa7b0
[05/15] block: Relocate BLK_MQ_CPU_WORK_BATCH
        commit: 3dff6155733f25872530ad358c6f5559800f4ccb
[06/15] block: Relocate BLK_MQ_MAX_DEPTH
        commit: 793356d23f8a817e164a917c792741a6d6d651ed
[07/15] block: Make QUEUE_FLAG_x as an enum
        commit: 55177adf1837bc56f878f7f6f7123947a2088148
[08/15] block: Catch possible entries missing from blk_queue_flag_name[]
        commit: cce496de061d09794825b7c7c7d57faca4772d82
[09/15] block: Catch possible entries missing from hctx_state_name[]
        commit: 23827310cce7eff3477aeaeb59ea3718f5c9c633
[10/15] block: Catch possible entries missing from hctx_flag_name[]
        commit: 226f0f6afc3e5c8903c6e57e1f6073ad8ad189b5
[11/15] block: Catch possible entries missing from alloc_policy_name[]
        commit: 26d3bdb57ec3fa56eaf8d2e74b5d488e55f43013
[12/15] block: Catch possible entries missing from cmd_flag_name[]
        commit: 6fa99325ec86bcd442363d77561a1babd8d9a427
[13/15] block: Use enum to define RQF_x bit indexes
        commit: 5f89154e8e9e3445f9b592e58a7045e06153b822
[14/15] block: Simplify definition of RQF_NAME()
        commit: 2d61a6c2ca7aadce3771f81a3624848f97dcc39e
[15/15] block: Catch possible entries missing from rqf_name[]
        commit: 8a47e33f50dd779f94bc277c6d3de81672463c5e

Best regards,
-- 
Jens Axboe



