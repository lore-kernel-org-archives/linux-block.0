Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA32030B
	for <linux-block@vger.kernel.org>; Sat, 30 Mar 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711814210; cv=none; b=hZG7TLuQ46ueuiwMhDyp3T4p9lbntRTBvaxBt3xisKFhaKaWv5SW0mh6l7NnesRqpsG6H/0RbQJIXopXbEh2MRlTpUzF1KDDPLGVP6+PLHBhRMKejrYek7oobFrcwUAopzR4c9yUB+we7SffpnqOFNdEwAhvmtISOK+K3Bavwvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711814210; c=relaxed/simple;
	bh=xoAsYZJO0wX2onOOATdXzocbpmNv6QdcowR9r8eIV8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KsAa+Q/RHdpUG+is2yIFcTYR+5aQhtMc1o4z56aV91voFz/Qqtx+So7HvyM9PVkLAeUR0fqz3tsPEXMrYaHwM4oANA3+r0oFQ1VErhqzN88JT/0m5eyfg7TMXdoMcUT8RTEJd+dUp6jWgkbUvbmR6qYZWkP4vgmYJcwhslb4E2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=K6zGZAo8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="K6zGZAo8"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29df844539bso911845a91.1
        for <linux-block@vger.kernel.org>; Sat, 30 Mar 2024 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711814206; x=1712419006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7Jr8Mxp1vrfbIrute0fi4mGtv3ul0qwzd0u//gsM6I=;
        b=K6zGZAo8SrOtlSOanQl2lI3WlNLkEZIatekRNxQ90XFKzG8DdPYAxXJyVBl5dI278n
         uE4fR5Uivyh55YzH3XbFcNay05p9CCFPbgVTYVmF9y5aQljWfJTFXBkGcdu/oxPyBvzv
         MhFZItYvEO9vxjADdhzn9AvW+3gNoIPKFuGJDqwo2RDmj/MtM9U8/iWydxhE7BtO6oNH
         MDve3vId3TtiU/SbL+fyStBo3Q88uxiY+UIfvlOPtLikea+7y8PcVf93PNnLsbyHV5aE
         SLozViut5QIIEBEZSkvFXT3fJiW94pN2jjWTEIlmvcMlGyGuVGc/GvciZ22V/4Deand4
         0iLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711814206; x=1712419006;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7Jr8Mxp1vrfbIrute0fi4mGtv3ul0qwzd0u//gsM6I=;
        b=Yvqta41d9890ojaz3kbxRbEc6nXR2QTsLMAIsQXP4Uj5/9BLo06b2pu5JT0LGIi3C/
         lImT2yIznE3kAuW0qXCT7yTXSopQocFnq3DLH25vVqMMzmtvycLvVrpyZu4ye7bpjgVd
         C6/AuPYk/A4wM+0nIiH5HuYv9pn8avnpn7XWEOHA5kowB6l5u7Iw/5kFAxWbQmoEqBsa
         cxmr+7BvquBSi9D0vwWqzLyGi4r1dGr4b3BxBHkoS5MpBxkF+bGh9yCLX9q04Vrj+p1e
         eonHKXI29K6DY+6brGKu2V0EN3K8KNfsYDjgxYf/AMO36YLjKROgFQ9YWgieowwkrhUy
         ZCAQ==
X-Gm-Message-State: AOJu0YwGam6l7lhQJUk50VSJP2HOEY6GyCOot2PcLBV81/f5ikvzSwDd
	ccwHpoWgYM5ISCYsDBU09U4QCXSIg2jX3S8MMpWM+DqCudNr7FYR+T5kJLzjob3zW+AW+b59Ml3
	T
X-Google-Smtp-Source: AGHT+IEkgA1Zw6nLPQis1fIlSHzZ73FKIEvSWdibO/LQTa3vBztlRsKCE0oyqBjFFR9qhBM/gyPX2A==
X-Received: by 2002:a05:6a20:a107:b0:1a7:c6d:5265 with SMTP id q7-20020a056a20a10700b001a70c6d5265mr1732787pzk.6.1711814206332;
        Sat, 30 Mar 2024 08:56:46 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b006ea7e972947sm4734875pfd.130.2024.03.30.08.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 08:56:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20240330005300.1503252-1-dlemoal@kernel.org>
References: <20240330005300.1503252-1-dlemoal@kernel.org>
Subject: Re: [PATCH] nullblk: Fix cleanup order in null_add_dev() error
 path
Message-Id: <171181420525.944993.7345868203105095420.b4-ty@kernel.dk>
Date: Sat, 30 Mar 2024 09:56:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sat, 30 Mar 2024 09:53:00 +0900, Damien Le Moal wrote:
> In null_add_dev(), if an error happen after initializing the resources
> for a zoned null block device, we must free these resources before
> exiting the function. To ensure this, move the out_cleanup_zone label
> after out_cleanup_disk as we jump to this latter label if an error
> happens after calling null_init_zoned_dev().
> 
> 
> [...]

Applied, thanks!

[1/1] nullblk: Fix cleanup order in null_add_dev() error path
      commit: a057e4036487351ad25002a88c75f7d195e36d79

Best regards,
-- 
Jens Axboe



