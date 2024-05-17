Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6812F595
	for <linux-block@vger.kernel.org>; Fri, 17 May 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960470; cv=none; b=sDyh0ZFFqvrmmp1t4jWw86BBBhDc4OMbOOdiw7ZEWCAo+4sfvSmZ5xtpOJJ4l6a4YBom1GYXE5PTd1BWSE1+uA84LWlxc2ydrtZoGC1fWvnT3pomrOI1qIzz5jAYJfQHh07PkZaSYRU8pSuow4SirJYUvI4yLE/NXArRCcV0IHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960470; c=relaxed/simple;
	bh=daIjeLJoYfF/qiW/jXTlnkKca5gDynEnT598Pz+MVxs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SbBwrVia5Kpi9LyVLYn/RzN2Vm5Mc0bIDnlgMsd4K0ImCp+0w49tdti2C/zouRSf6QkfDs8CVTwZLcpItCVtDSzdk4MShdQ2E36u0F8/2IkxhmRYC7vhEECnPATTmTa/5diuCYFlO+Cj83y1n5AqlBsOnoVj/Tidw4jHDedHYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dO+YQ9kA; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dO+YQ9kA"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e1fb2a81fdso13373539f.1
        for <linux-block@vger.kernel.org>; Fri, 17 May 2024 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715960462; x=1716565262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2gDIsaoeq0TSAEMY5fz35Za46TPuUHkxbIlOmvSFNc=;
        b=dO+YQ9kAfLQZTAeUWyZ41AMAlhwo31rOB6x+wqRDlsKTN/BW/nOZomwZnKE+BjwRM9
         nS4PcuuMeTIGYy+JFHMoOM/p5N/wXXrO/gVqv1k6fKI8pmeo5Ngv958z61ZIrM6zAhM1
         vgw4YWD3Q81rhtIZ0pZPFKipEfydR3Ws5kVj2iWvX4IKswn4jBitwMqkxFKHoI8QxBwm
         tqt1wiqISBG3uiSkEiD4BfgHC/+JKZ2yTrJmQ94v2xVJ8v+g4wjCH9AeACZzcpvbng2L
         ND2HkNKB/T0DRE6bJtu2FtmAgkGw/T7iEoRIxz1+6VclgsCcaD3dJ6IDTXBF9Od/ICYy
         T2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715960462; x=1716565262;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2gDIsaoeq0TSAEMY5fz35Za46TPuUHkxbIlOmvSFNc=;
        b=t8iGkIkTtzj5hJGde5XikYEIQIaB+3rpRlPZC9Yi9SgbqFXzxl+tQZHZ17hAW7mSFT
         SQ9L1OihtuYJ+Z6WsLJD8KavTftLxlrHxPy5OjIvxeR5yF/nciA4e/KnWq4yW6fZxfnZ
         e+Ab5c5UnLpLrCCnyKBAOmfa/PeKUoxag0+nvI5SLFrMa5BiGnbOHwcy01OTO424nZw7
         M6jEkYK1LeVvZYvQR/BWs2aBKvyOnTV0R3Syc554JDIwQwAIOnZxw84a53318rd7ZhL5
         8+Q0l4uaTNBg2N9uY+tY67kUsZ53hIP5IBVoaX5BRrsaL4ebct8mPiVa7ApYW6vMfMim
         +xgQ==
X-Gm-Message-State: AOJu0YyrOSIn7fWxeSw5NT8tNbAE9M8xPT5QDLi7T3R7IgRnKtGYsPjM
	IYvcC4iKexBm/4L/+Npt8gk21mtUHQ2GKPMMsVi4JihFYXnMlcRrNFGzkS0BVcbl/xB8DwDbz1b
	m
X-Google-Smtp-Source: AGHT+IH7H6fvlHVPknrkefefwYKmrg8/VOlj7yq/36l4s6tauiCEeApsDxPQSR8dkChW12qCzsTJ3Q==
X-Received: by 2002:a5e:8704:0:b0:7de:e495:42bf with SMTP id ca18e2360f4ac-7e1b51f3e6amr2276898739f.1.1715960462143;
        Fri, 17 May 2024 08:41:02 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376fc708sm4652992173.177.2024.05.17.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 08:41:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Raju Cheerla <rcheerla@redhat.com>
In-Reply-To: <20240517020514.149771-1-ming.lei@redhat.com>
References: <20240517020514.149771-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: add helper for checking if one CPU is mapped
 to specified hctx
Message-Id: <171596046118.12101.5842133090388456838.b4-ty@kernel.dk>
Date: Fri, 17 May 2024 09:41:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 17 May 2024 10:05:14 +0800, Ming Lei wrote:
> Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> rules out isolated CPUs from hctx->cpumask, and hctx->cpumask should only be
> used for scheduling kworker.
> 
> Add helper blk_mq_cpu_mapped_to_hctx() and apply it into cpuhp handlers.
> 
> This patch avoids to forget clearing INACTIVE of hctx state in case that one
> isolated CPU becomes online, and fixes hang issue when allocating request
> from this hctx's tags.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: add helper for checking if one CPU is mapped to specified hctx
      commit: 7b815817aa58d2e2101feb2fcf64c60cae0b2695

Best regards,
-- 
Jens Axboe



