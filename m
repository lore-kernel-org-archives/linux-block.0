Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6B1C54AF
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701031; cv=none; b=HPlbv23t8gOmYA4tuQ7sGHYC2WH5Ia7vZsGAX7EQfBpG1LZ3Anb1w0hds0/FAMFFwx8exBcFyAfx1eV/7QslchROjt4VrwBQo+vWuc8Xc2AxtmvSnMAW/ir9TpBIVpYt+P3HFJ1Nk8N0Ju/MTjoF5gWMuTJOs8D9UPa9tNu9DNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701031; c=relaxed/simple;
	bh=TF1EGeovnW6B5Fki5wnGhvAhhpu8DdqNVf1ne8WgrYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nEpgEb3LuQJRs0CViTvrH2oFjFaOb7GgUd6+NMKv1v2NSMuhNbIlkqoYYHjfo04r4xHX3nawa1Ae/UQSItoyqonhYabTUUQ+uTS2A/BAKjV9N5JF3z3AVhXx/xBCMFdMcrFvMF8SPDjKwFKuMsROxNJCOGMCIv1vltS32r8VNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Qq9AxeyN; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Qq9AxeyN"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d2b6ed8128so19021465ab.0
        for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741701029; x=1742305829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsrXv0bf4SwYPCzHdWKazz89+OtA3vJ8ZRt7BAG3VbU=;
        b=Qq9AxeyNi3Y05gMenacVL9WNk3d//dkEh18qBZICwwH1kUvll5vMi19dUFfgabyf0P
         LY9laxGSv2Cl3+dIg5xbTj9BSZ2Cky9A6xhzR/2MRgQ128TXbQbMMAdSh6s0GsBm6FWE
         W4l5Re0AP2dAsxY9fLielDL88IxTHIVpcnXz0qDlA1bS5YFkclLBUjG6MShIG7a9XmjX
         l0+TPfeYWkVsyLy3zPUZ/920Scj6rHoRAK/WkWoBWKScbV2B8UoEBYeRGK9CjKTFM45X
         azw3WWua//dXZSJ2RkeMwQ/gnYrYiDrztjLbHGt+bERDIKYEejYS+dET8f5XpHhvmGiE
         fLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701029; x=1742305829;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsrXv0bf4SwYPCzHdWKazz89+OtA3vJ8ZRt7BAG3VbU=;
        b=INzhkZSIKTIZVlyo8tdXHRCHj1ygdRgrpMpV7EdazgoHj0TFhzUeewnp9cGlXGFG93
         Z7fP7XLqcmVQT1QBA+NF/eU0lb6IgdMbHYHO2vOry/8p/BDiDPGw1esa4kNNygaVdqpg
         F9U9J0ON+G8wimiRhhL8ycvHXlzsZ0aVYugI7Ef9M9gvnPYhn78nwJYmWDOmif80/6m5
         m/Aq+ASidOwqV0ZId8jH50/PmSvcUGP9pbL4v1eKkQ+i9fA6kS6QlDuQoJYisTxadiRh
         M4RhFQ3z0AFKaKitE8GhCFrKGGqAa+ZyaqTb/BXcOaeqQzLrWPWxUDZOLCJrdtnMt2+n
         lFUQ==
X-Gm-Message-State: AOJu0YzQVguEHlrOVWy3cmA1yAgAnWkv2FJPY/UY7BPtlDL6W7mAHJxd
	/WRHiUr3hGANiCDU9hemFpS4nXuYHypVxLYXEoFUchAJP+xO0or2y3v9sFdttrU=
X-Gm-Gg: ASbGnctmU5v2Ad814zp5DvY2RMClczEd7cgQ6ElklGjHTPyuW/UGVfYmE8wBFNxTTB2
	+D6MTZpeDYag+B7lS09ixoATaRiB+kHvgyUaEO1tTUUPhghb3szEBvKzx86a/U4G2a7PZege5IL
	2wtAKcUw4l85A4xLJcGOC4a5WIckIKIJOY3cHuAC3ZkKM+YsIIRYtjMq1UPzgs3Ba1oAm+DYSXs
	qgQaFV597+1/Vro/wirix7bZiywOOAjyMIgVKWBWai49vD+gxMsmlN/MUYN8wn99+Q/sqfTZiz5
	q1k/qOsqhgZLd/zab5M/IaqSPiMOS2tn5lRxCxij9lXArw==
X-Google-Smtp-Source: AGHT+IEJpumqHggfcCQNZSUxuoyo1e+nAm1OVkr94r5e5qCv6EQWmunFqyrvyE3JGQqty289x1CA7g==
X-Received: by 2002:a05:6e02:3389:b0:3d4:346e:8d49 with SMTP id e9e14a558f8ab-3d4692159fbmr36048055ab.9.1741701028951;
        Tue, 11 Mar 2025 06:50:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f24ca8602bsm275068173.145.2025.03.11.06.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:50:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Alan Adamson <alan.adamson@oracle.com>, 
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: virtualization@lists.linux.dev, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Hannes Reinecke <hare@suse.de>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
In-Reply-To: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 0/2] block: nvme: fix blktests nvme/039 failure
Message-Id: <174170102773.320314.5830688529132236537.b4-ty@kernel.dk>
Date: Tue, 11 Mar 2025 07:50:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 11 Mar 2025 19:43:57 +0900, Shin'ichiro Kawasaki wrote:
> Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
> conditions") in the kernel tag v6.14-rc3 triggered blktests nvme/039
> failure [1].
> 
> The test case injects errors to the NVMe driver and confirms the errors
> are logged. The first half of the test checks it for non-passthrough
> requests, and the second half checks for passthrough requests. The
> commit made both halves fail.
> 
> [...]

Applied, thanks!

[1/2] nvme: move error logging from nvme_end_req() to __nvme_end_req()
      commit: e5c2bcc0cd47321d78bb4e865d7857304139f95d
[2/2] block: change blk_mq_add_to_batch() third argument type to bool
      commit: f00baf2eac785bba837e5ed79d489f16520e7a6d

Best regards,
-- 
Jens Axboe



