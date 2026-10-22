Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676182;
	b=LrXF0XofDl4VgCKBvLx4wYGG2oh5CIxf5/SxdErVReP7yTNyBnErp9G+cx3Fkm+LozEp
	 6QVSbmMb8+SPDil+P/608yRjJBR5GJbrdrJxnqlEB8gNVyZDyWx/hEyo2zX4mkOR/dqGx
	 tfy0nTcDIjUNTU7Q7kmUglBMBiYiYYVD9+jQvnYCYIpoDdlDFReI9fkT8ILTPkzd2m0bf
	 bkD13c7LGbk13Qx9WKQ/QgIQM+22YbKoGk1+AJD6vRMA+IxPpZytV0VcL5/rkuoYDqe5D
	 +JK5baTbjsCMtxoF3wYk7T/xOwv5gwnG0v4M6ekfD6x0fV0Zh1b6Lq/uC8TbHhmXOug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IbtxibXdI9zyqjziQv0IxMo79fhmOdo8yS+ycPfz4Yk=;
	b=gJWot/8mN8mX4CN90sk3QmCZ9ySz4vj4xYuI8ydLqAnNJ8z04n66D3JAhTf09fN7I6Ib
	 G2ba45k7rZkvLY3Diwf272qU1ivL4CjQhXL9q0Wmsd+YyirY05+bRuaiV/AP9WZ4SdDM8
	 d8/MpenjRobE27TZzDXN9u3Ld+RJNhuT54nxS1D7kX+vZxjcCBxWc63lrL3Fa9vTYrjo5
	 FtYMkyTNFB7LtjN9agDep+/Tx+QCgYf4FZ5cl7MnqNugAowAD6Lt4vlottWXVN4Ng5oDt
	 03ShbwTsURjr6Rz8ViuoRfRctxCw9oyRarBVuVv2ayGeBFcgCTSmagptKNQxkd6KEyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pSRz+sdz;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0900606A319
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 13:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0900606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pSRz+sdz
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-487049569b6so1287762f8f.1
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 06:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676180; x=1793280980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IbtxibXdI9zyqjziQv0IxMo79fhmOdo8yS+ycPfz4Yk=;
        b=pSRz+sdzwCM+wosNEQmUKUDNrg6La94MAOtYET6ansQaw4Jit8sWNTBdiELduFOb5c
         rD8REU/8N7Pf8nU8NqkVPhhXiPd5D8X7BRGL2CCKPKZGCNOfj8K5zg+6HMGYsgVJj7R0
         WyttVKbC7nj3EaT0P1LzpzCEBKK/4NYSTt5ryedZIqWgc8Wg3Ji9jJLzBkT8fyhU5dWv
         7KyxAGrHO/4gMd0elIMU5yRwgl42/StitCdJQd+XW7sEs6NP4Tdvm9fM4RuTURV+DjJE
         uqW+AWlfEO3YHYYMzmbWTgZjQfNsl70l/RCHF3/t5tnc1SvI2dtDcSCN/uBt8hr9UJFX
         WP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676180; x=1793280980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbtxibXdI9zyqjziQv0IxMo79fhmOdo8yS+ycPfz4Yk=;
        b=ztzJ2QphXkGd/SwjGzrIqZx82IFG7sycInpGa46UF+5hoO0t2yXmU2v6CmQKM++YrO
         g8IEr/8QpUnoiQIxOX1tp/1flHO48ZuDzWGJUWFTsmGAlEP5DN4XNBLe3NRw+i9GcM+k
         0N+yVfybrLN9okh4x0Pe1cy/CKEdcKDCaKJEcibtMW80U22kduPkcIwpMcycBf+IK71C
         iQrJyN25J0JM8WtbtO5aMbIqCHrZmfaRHwHjxfPwee+JDuyk7qESI3gecEG0u/5P0acd
         avGvHE9kJQXe4EBDkcYyyNILqcuc48MOXZuv7EExDM3XsnFCiIs8AyM6BoJOgyo8PEnu
         vYAw==
X-Forwarded-Encrypted: i=1; AKwUvBy/DswiQVHp6SeAWxr6I3kvqvsKr4azTv/8CSPAeEeXs190zOh8VsOPzeVq/sglnpw8Ex+8azdUHocubg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ14PF4AwKgPUWTvxsCinZmIBRTVeej0VR2RKyrDg9pcgvMQ2/C
	5JN8xqe/jsRADG2V+8xXEcmnCsjYM+30ZsF6kmABIEzpVXHabJUyAVj3
X-Gm-Gg: AYBFou0F/keU7C5TKyUHVSHF+2gZ9oG86IcqV9fXkVxTi1kglZR1JX1MLlDSo/+tQjX
	zY7EaKfrSSXteB+u0OwNl7eqOROZs+vpypJiIXlu3SP0YzalkOseU9AO8WrbS1pGr5XrOtl4ZSi
	edIOxHiZ8T5XzLbX+08fVGCAQd7d/qnd/McHzC5Gnzrh48d3oUDuo1iQeWvOxNYFH/Ln08ubWxC
	eV6icBtymeTwBGJ8x/xr4PHIqaEDOGF3W8/lzic9Ic1gd0aTL15sDKIeG9c4qWDUjL/aCPCzXHD
	Xa5ydMI2oZDTom1GrxtHkyn/ru6E1p0xqNCVAQLUosu1M3BOyijnnBUIFeRfHd7l8fNaCzFxrs3
	JfzaERS7fFKif8I7Rmxv8aNKyqyYspCeqqf74Ypv+0foGV49G08WzvVnE1nnV/TVcxqWCu0D0E6
	Wf2OKtiJnOwdvrIo7guAPmtkEcgO7z3lNj19yCiV4oUYi4A+btJh1uvs0C7LlGhMfgcW5eNkA7p
	acMYfkGWEco8f5hl/jWsf/+RBlEQpeyJ9GWdZqr8z02AiYkg7RTfP5NxY+T9sjuqnyRwevjOWa+
	kbCENCCPY3StHriWKATw8hVj
X-Received: by 2002:a5d:4573:0:b0:48e:e2a:4093 with SMTP id ffacd0b85a97d-48e264ab3a3mr8726545f8f.19.1792676180147;
        Thu, 22 Oct 2026 06:36:20 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f0d4sm12645777f8f.13.2026.10.22.06.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:36:19 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2 0/4] nvme: add nvmet zone report and FC regression tests
Date: Thu, 22 Oct 2026 15:36:04 +0200
Message-ID: <20261022133605.3593484-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel fixes that nvme/072 and nvme/074 test are now at v2:

  https://lore.kernel.org/r/20261022132934.3592924-1-parri.andrea@gmail.com

nvme/073 tests commit 31b8a6af19b7 ("nvmet: zns: don't leak stale
memory in zone management receive"), already in nvme-7.4.

Andrea
