Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85A1C9EC2
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592205; cv=none; b=es5wrkKv9deHDPcxvmLSr5+DlTk8Ia9d+sdTmJvuZnsdDmi/jN0XAjO+Shv9Ukw72Hz+za3ANfZ6CmxXBZxpWy5ezsxbQDdS7AUVMvaEVJ6875aAAKm71w3NHT44s5XPPUL44WfDX6/ETJhBx+zF9Vv42fZFqXzS3AHUdrQV29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592205; c=relaxed/simple;
	bh=j0+JnBGjqEG57E/An809/HBqP/2YNCRvU0R/jGOUhHE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=si3oUGqYP3+h7x/5YGd6V4KHXpv7vpoVTcmGfpgVXbvsLCvBCwcFT9mop44TkC36bWidK3+HBH5gxau8BVs8q1arkcn3E4gbHVHJ2fBroawfUqS6TTHu9iLPzY6+uAUQLjflnwUi2SMaW1s6k8Rz2LI2SAnbKWGl5xKxjuBm8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PxITm8oO; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PxITm8oO"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d56573277dso44364b6e.2
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719592202; x=1720197002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdFGR8L1JMqP6x98gQC6CZedO+qdockpFgpFqewPIJc=;
        b=PxITm8oOQIfWB6wKRGYpPJHkyMCVXa6CRcLquowpCi7zalNJyxrME4CcLPE1PXbyKV
         Rz8a3UEtdYichebilJnIjoywS2KRShcUz01b3JCfS/+WxctQfkpeNl4lYfyN+qyf+cq6
         c6Nj24aRQn5JqEwV98ofa7fbuPws+MUuvJ+9pTSceRI6DVDfGyZ+wZpoh1cc+Ox0txZr
         GAhLgufXDneIKwa1sTS3rSytiXJKOuMWuzqqViFu9l2T8v0e5FoqjrvRG+Xl+hlCfwQ4
         yQXqlN2/6Q15cf/H76qs/Nm9Ndt+E353hhVdNhkVt/EDbtLPNhaM/x3J3uYMXJXk2vpC
         MkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719592202; x=1720197002;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdFGR8L1JMqP6x98gQC6CZedO+qdockpFgpFqewPIJc=;
        b=CV9BvV/W9g0sgTMW6XjRf5BEy+GTpLTDc7j4GKf2whAYPNA/Y0dkLPTw8V8PYtxvEh
         1tX1kYuSpskyRCFScu+SUA+tJ1THzSUIk8xNpT+DKlUsB6hUpX8yrkSn5Syl+2wa7VvS
         tN3nMdf5/wEGlcnOmjHA2C07SEnavFzrN76AqH7LGlzV9cGr9jjkMKwShg9GHiPfZkus
         wLyprg1rympmgHTWn/c1aWoEcIrWUVzAOF//0pROm4GroP1LLtKQOtYJEdXbmq8nID3d
         OTk3YMOAL8K3qm2/Qura+yiqvswSAQUr6i+E1HeoSG9NNYmAEwrg9I5f7ZureBWTy1Bg
         jlZg==
X-Forwarded-Encrypted: i=1; AJvYcCU7O7L8H9EWlinYLv+ZatOIRCbDoErm/HuD1zhlC5G8D87vpZ2pT1uDTNaibCBJt9b6gidfyCwFYP4d8gPhCBwcqrFx8ko18wJSLIs=
X-Gm-Message-State: AOJu0YwWaf/rViaeOJiWaarAi1pmXHx1ncCF28hUnHRXUR4L1vTXSt6+
	dHH0DmLzEP+Y6v6lPvbTGQqjh/JPA7ciocsdQXo55zLS1kIZP3bEpK1M3wpiRBHfXwLY7lXTiJt
	rSDo=
X-Google-Smtp-Source: AGHT+IFF3tf7timPDcUgd5GWgFOzfWQvQ+4xVklRtvUdZQUERseEo7qiuGWGZEI2qSrcnNPmbTtxSw==
X-Received: by 2002:a4a:c186:0:b0:5c2:25cb:e6c6 with SMTP id 006d021491bc7-5c225cbe811mr7375915eaf.0.1719592202220;
        Fri, 28 Jun 2024 09:30:02 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c4149ce4dbsm305220eaf.47.2024.06.28.09.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:30:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, 
 linux-block@vger.kernel.org
In-Reply-To: <20240626045950.189758-1-hch@lst.de>
References: <20240626045950.189758-1-hch@lst.de>
Subject: Re: integrity cleanups
Message-Id: <171959220107.886801.4777540472026186092.b4-ty@kernel.dk>
Date: Fri, 28 Jun 2024 10:30:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Wed, 26 Jun 2024 06:59:33 +0200, Christoph Hellwig wrote:
> this series has a few cleanups to the block layer PI generation and
> verification code.
> 
> Diffstat:
>  block/bio-integrity.c         |  101 +++++++-----------------------------------
>  block/blk.h                   |    7 --
>  block/t10-pi.c                |   97 +++++++++++++++++++++++++++++++---------
>  include/linux/blk-integrity.h |    9 ---
>  4 files changed, 96 insertions(+), 118 deletions(-)
> 
> [...]

Applied, thanks!

[1/5] block: only zero non-PI metadata tuples in bio_integrity_prep
      commit: c546d6f438338017480d105ab597292da67f6f6a
[2/5] block: simplify adding the payload in bio_integrity_prep
      commit: c096df908393b0b3445f4335dd9bbd9d98252951
[3/5] block: remove allocation failure warnings in bio_integrity_prep
      commit: dac18fabba59149acec42621b9b603654e9459b2
[4/5] block: switch on bio operation in bio_integrity_prep
      commit: df3c485e0e60e8ad87f168092f1513a3d621fa4b
[5/5] block: remove bio_integrity_process
      commit: d19b46340b3c0ea66bef0f6c58876cc085813ba8

Best regards,
-- 
Jens Axboe



