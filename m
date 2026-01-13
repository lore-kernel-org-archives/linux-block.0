Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81ED2877FE
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314433; cv=none; b=jmSiiS+6uSyKQq1el4HQB/r6FOjEtyXEqwfB1fW5Nb57bLf59RVxltkYvvSaYNyFkT6c+ndWPdynushX8SX4qTigMD70mUzpaWWuMk/W0M/kMRfMZrqc9r/N4Jeu90jLibjZ4yQqSISxo1ikJ+yv/94105oK2sH2HkbYh3EL11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314433; c=relaxed/simple;
	bh=G9UBihsqgT/3H5fphQ4b74J27f7T2JcA2uL+SUn3UpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fs9CUrK02/BdoYNap7p20kjz1qEbRybrOTylZkV4sp4zHeBSNpAB7a78alJofBqO8HSC0pcAjQuxh/GcuFEDp3iEirs3lsa4EOexErLYe6BCDCHA5Ce6zE6PIH910VVMDp/cuALgnUqK8YFkvrxKwHbxKbAiUa3Kt50FYAQAXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cgrSEE0S; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cgrSEE0S"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-65f59501dacso3830493eaf.0
        for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 06:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768314430; x=1768919230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfuxnF5eA4o2hoE0e5MjV7YAHQFMCIYI54d1UQv901M=;
        b=cgrSEE0SPu9MOWw3ZfYL+cbC+yhFkTN/ICExyD88W0n2BoMybT41DbGJ71Z6KFjPKM
         kXu0G9NZsqPKPUskd2RPfZolZv1FNCbisr9TP2eHHz7sagk6cAyMG4vy7Ig1koysMa9J
         PpD/Ag/TIrpM2Fhrqsglc9QL0/w5tWtPQcXZ9A55q5RvpWqdVWuiOJrzA0bBegemJQml
         1YUrIhNO3DFXBoVMzGeRIz5rY64+6oxNu5rJt9z4p5Qv0FCpXbqNIQRgbwhH7mLRhhs5
         b4L9JWVYXjHFJ7U6YAJgQdilFMffdFUP/kl+Zp0fiH5gN4jMHbW8+eXPUx7Zq0iwKsTV
         HaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314430; x=1768919230;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tfuxnF5eA4o2hoE0e5MjV7YAHQFMCIYI54d1UQv901M=;
        b=Fwhw/d6wWJMvPutAC8fLi4oIPTgEjOkGY/1QH/HaGA3V/jqXkSbqBYx3KhJ0JenGps
         fP95eIuWbkHFvjyGks+ZVZZmoJf37nxcMWxYG8feGoe45D28grheCGSVB63qqYbBqb/0
         3oiDet/H+4aLBs85J1rzYhuTshB4RnvDHBw1IrkHa5ROaIQSVQmGfB5VlQPL1ade/95Z
         7ktuLq1k41szHB6BLPLUenqxa3UKcvH+0X+kdicbJJdqke0vNViFs/DSJ9xuYa1uFwIp
         rYRInZJp3Wh71v80fvdUx2B1QhmJj2BEr9CsMPp2XrqEnSXpbEW6Sm7GbAinqnFJkOXx
         JfWA==
X-Forwarded-Encrypted: i=1; AJvYcCUgc6QQpTDMtiOC5r5SmkCP06SQho3rIwp/NOb26TB4WLi6N7ys2+6ODoTZZ3lFws35EeVSDKMYU/1bzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3jRSJNis6JFW4KzPvBp4DibQomoGtTc9t3TOtE21V54xAcyd
	4Rk9U1ovIfGcWEqNWeaPxnIg3bNAkIwS01FTusqB2K3bKYEDRleKtXvJkx4+81pMGRQ=
X-Gm-Gg: AY/fxX5Yx5beBgE1/dH56MVQlPcQgWLpinsj/OCWrV6hGDkDVXvzaRgxCXAlU3jivJQ
	dMLixywBteWQrybSYaURTsIP+tAA6lqHBZXaXu9FwST//PKalJQXCyp/XCzVE7MZh6ZjmLCYuzS
	QQmqQOjO801AnJ3xAsoNXPF4EzKBBzNOiipOuhkqFzg7UQD37VHWBong4ixjCwp21tuuFxwPq2H
	FZ1uqnF6/YROYAhDZBHNUjHYrBJVjrepLfWs+DRFUiauKIaOPCZPH2uqH+KJZToAKXq7XaSW33G
	k2TWibu7a2bw77eO7fxIj7ifwF0JvbXWHFOmW7F686KRgCrZKj9wirtlCeHr7yrDvICO0jUi5vY
	Q54thWan3lFJ9Ccd3hbzrYGt7nq+VhRIfQfbzcyjzWImBzrF3+5mp4q2P95VdhFg++vbKJcX2RY
	qs4RM=
X-Google-Smtp-Source: AGHT+IE52Ad54mXMSS1JD1lXqFjxduKzd+5RvyclXikoJMz3MbQ2fjeUupBP/ojmRFWD9r8fE9/ChA==
X-Received: by 2002:a05:6820:c086:b0:65c:fd25:f425 with SMTP id 006d021491bc7-65f54f0d8b3mr7635851eaf.34.1768314430421;
        Tue, 13 Jan 2026 06:27:10 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-403fa2058f5sm456126fac.13.2026.01.13.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:27:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Nitesh Shetty <nj.shetty@samsung.com>
Cc: nitheshshetty@gmail.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20260112143810.2046599-1-nj.shetty@samsung.com>
References: <CGME20260112144230epcas5p34403fd2f51e32c77ad4de7bac8c98a18@epcas5p3.samsung.com>
 <20260112143810.2046599-1-nj.shetty@samsung.com>
Subject: Re: [PATCH] block, nvme: remove unused dma_iova_state function
 parameter
Message-Id: <176831442891.313337.6561387582840780672.b4-ty@kernel.dk>
Date: Tue, 13 Jan 2026 07:27:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 12 Jan 2026 20:08:08 +0530, Nitesh Shetty wrote:
> DMA IOVA state is not used inside blk_rq_dma_map_iter_next
> 
> 

Applied, thanks!

[1/1] block, nvme: remove unused dma_iova_state function parameter
      commit: 91e1c1bcf0f2376f40ac859cf17d0a64a605e662

Best regards,
-- 
Jens Axboe



