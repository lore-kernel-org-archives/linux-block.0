Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6527BB01
	for <linux-block@vger.kernel.org>; Wed, 10 Jul 2024 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592632; cv=none; b=SeQnnqwQf0E4O9WaCljxXRCyFFa4xUow5qsjEhwtCfUOuNC48N/hyLR5sjbBs6Mx4JHGlg6b93bzc8XpTuXorqx2/5mda5zdVwo8SisAft9xgnqRhgYFG0vfCgP85TZgFpkoeB1a90McjOY7l/Dn/geyrbxQyZIKKz46XbU+6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592632; c=relaxed/simple;
	bh=JMy0IdHP2vj8MMt5CQdDCQDifY7+UMOpP6jkK0+RBSY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AK74ByxrDAGnupAWZ//CqSrcbUgYOkXDXXtPOU6rb2vRuAFJN54RdAy4qyVmqCNF2T5viFThkBCJQslfuC0u5+cubUeYULbql7xvB0WiwCEC/S+ULvWeAtZQfsPD1lWOP7kgMUztDemNBN2gavgt7nyumEqQ7peu3dM0YBqYZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=waBjZUTC; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="waBjZUTC"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee9bca8652so3765861fa.3
        for <linux-block@vger.kernel.org>; Tue, 09 Jul 2024 23:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720592629; x=1721197429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+Iw2mRb5b3fkJHVPFuH17d/vni8hlsTJrpGX3sfmls=;
        b=waBjZUTCpuTK12J0vAes2PyNKGT9Nx2JgNtA9KrBDXC8L6tIw0msJ1+twcD3J3Sp7/
         smaz9H0Y0xsg98NKsHJjNVEFEhMp/vLerRfUwXygVtX9K/XgbOZ4tRsp6JmpLvRjz9fh
         Y+56HUMU0MgZ8ivM2+VfyM390uf/qs4VwA31fvTMaz7hViE+9m3SbbHZ93TBCANLwtEO
         M5ZL/Lt+dz+ZgT3RiVs/jHYD+OBs/WtaO0wzg4Az0uGM1jduEVz0BJojVQaXssctgF2t
         ixW5Eib/CDE2FW7KjsdViWpiNDsgp/i/nPb1+KEZYXGSxCyhDiFmRRuIZXgKNP8QQBQc
         BMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720592629; x=1721197429;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+Iw2mRb5b3fkJHVPFuH17d/vni8hlsTJrpGX3sfmls=;
        b=jCTxPfBgs3MU2KypMNxlRX546rfPlen7ybpdndJghhYCfP0JU/DyRq8lbpeaSB7BFH
         phBcklAOW/LL79aCHUtvNNFPx08AnDyiV7Y5O8GoJFjTb0z7hZV97OiEjwFQiEWE6YOi
         oi6CwdHXLGzqGqfP39F8Z/2T7iK/beRv12ZW+76dFi7ytH5s4wQCU6Nk5on1AKFMTjOT
         JMNtw8P9XbW3aqJ2bd4AkEEK+pVyu59GtfsummY/3ixIs3LICvoa5CBtIKLA63qma83X
         nGfYPGQJfVcdqOBBGYxOLolVVXtIfCc0vW54OW1l1Gw67pdfzEc/67Rot3D2SlRoR4V8
         uuMQ==
X-Gm-Message-State: AOJu0YyPISr08iSxuVFkbxoU7FmVkxtRQL+NKzq8kCoux4u4xve8bsJu
	vpv21u4FawEAllEDCF7iypz58lFPFS5qgdjhuToDp/6pHZy36hSggSvyeD5kGgs=
X-Google-Smtp-Source: AGHT+IECVXP/9FojdqXQdR2fqJxlUqKz/VmuHKnupWRVjiIfOD3L1lkTc0pY5/bCQhuyXj99O0LpHw==
X-Received: by 2002:a19:5e55:0:b0:52c:d805:e8c9 with SMTP id 2adb3069b0e04-52eb975b388mr2090198e87.0.1720592628510;
        Tue, 09 Jul 2024 23:23:48 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb90670b6sm463892e87.197.2024.07.09.23.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:23:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240602-md-block-ublk_drv-v1-1-995474cafff0@quicinc.com>
References: <20240602-md-block-ublk_drv-v1-1-995474cafff0@quicinc.com>
Subject: Re: [PATCH] ublk_drv: add missing MODULE_DESCRIPTION() macro
Message-Id: <172059262687.380385.9397691467700024609.b4-ty@kernel.dk>
Date: Wed, 10 Jul 2024 00:23:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Sun, 02 Jun 2024 17:23:26 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ublk_drv.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied, thanks!

[1/1] ublk_drv: add missing MODULE_DESCRIPTION() macro
      commit: c25a271c294b8f064f5628ea4fc3c6b8d47bf227

Best regards,
-- 
Jens Axboe



