Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6E2D320B
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869530; cv=none; b=Zy0XorjPpeVrlSDghRYsaUDjy8F39LwNGIbqzZYd48d0c2Wn4Ljza6deXyc4FpPNnh/PmQag6BLNmhgauneNPtDQTpumf2K0GU3PgsmI4NAtdhyDmQy2v7luDZxKm+5UZ1P7ZCPy9lXRvS9qhGUD3FlT6CS1li/RILSJQB+r1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869530; c=relaxed/simple;
	bh=9bZm6fW/G9/Udcgue+uPgj81Ppf4wMkV4IELCGYoXKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DgH3pH+JWLHiANu01kQ+h++lL5hIdlarWpggZpe9986r5acvIBVXiXOoFiN1KKRE7MqXC0KBa5fETlTvPjkdJqMVWGFgg7A6LJ2T+7Fg/zXZgyJYABkogwsnEGWIZDmVp+Yve0vsCP8VK8Bp7rYdnzK2TtwGHMO1FsSrUe1A8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Pz2CEDxe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Pz2CEDxe"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235f9e87f78so1154515ad.2
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750869528; x=1751474328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJD7oYsuXClF0OaOzgGxIKveGu4NfGDAhJ8FOTY5Umk=;
        b=Pz2CEDxeqtSHJiEDuigYR5q61xrg9iET6drGC6zBSHDnNFsaF3mApRMQ/TCihsTeH2
         yJljY6x2Hwb5YHrBNjc3N6iHvfNNzKblzXw+wW9DngH96TcmsnH3Qwul3OyBgnszss+p
         eATFJOglQXVGY0tHffIUTvTLdsYh0qtxCT3TpHe46GkoYt4nJhF0kYB6wyYi1uiVxWf2
         LO26MV6Nv391jMo24mBA9j9vJfbetYOnMtGtpE+v0Fh/PWbp0G0Mpp3w6EUe3Cnmq+VQ
         INFc1c7krzubpUi4NHa6AIzP1RRXiIrRWIyD9qaXnY5wROhsWCUehic9iuOKmVnK4cWt
         7s3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750869528; x=1751474328;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJD7oYsuXClF0OaOzgGxIKveGu4NfGDAhJ8FOTY5Umk=;
        b=UlTb/xnXL+/kClJ5EkiNPD98UP2cY+pZOkAIM3flg6bG1cIfLUq9SvaQY6bEZFZiPP
         1JUGPDMNAMH6n8tJxtR2SKEwEVvInehXkVdI+SFlN1Es6rnzEBr7YpBcqPzG3Xo4OMSa
         jYmLTFttlrbue0leLNLHXNk+qhj4K3REXB3hHMFoHZqQgSOpRlIriZHgJzNYlJhs1Nj6
         IWyfGiBpvUabWH4Sfofy4z92GEDJf6SWiJkV10K0lD61zcjUbxfLHrK/n73djnffxW8v
         w0sVyhGQsTZGAEzRrnYDNXbXpcG13nkBCaHqnPxtSyCVZpbM6gUMSuzdTcdV33NtAofI
         L7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjXFeo/3QnXu+grJxbp8k4tcANtcCVz7dJYqQoZDFv0SmNyfFaFuLezZ86wWyEt2+n7NOS6FcyfD6rRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsVkp4J6rWCuAXo2LKtaC1Ve/EoafYh+Z66EK7EUdRT+WNqIiB
	4+6LrOfd5ojX8OfQ2tODvzeAi5ItnANP/LeAcizXDLIIPLtt8BVjnwXGOTNjIPz0S+U=
X-Gm-Gg: ASbGncvxS3/gwjwWEjmBrnLOj+cvX0lpPwwDBV5z6x+woo7i0/RFKLgPOWTZmCJM60E
	YycyDXRqdaZ/m4cruvzF7dE+M+O+oOnai1GhsUypMrXAu2YTvB6nClNypIAC5EUgNOnenLyru0l
	b4yedms5M7WtheR9wrY34RM4OAOZZI108C/GNOcQZFWf+iMrqomZq4yOWBXTxncjLLjcH2E7jh6
	A6iBhYxmc/6Drt2hpCtStVyXQVC0KXMy347YgW5jHRRuprrF8m+fw3Mo5uHSZVpyTPDpq/s3Hrp
	4RohbscWOqlanzZXKXpsN8trcrFnuTPOtXjIOUxK5F+yLgsP20wihA==
X-Google-Smtp-Source: AGHT+IGDhM9kiTgBHa5GA1KZysJZpg4uphx08kK+xQdK6jAIhu2+Nfg5iHkJwNuyHtRWpoMjNzaLjQ==
X-Received: by 2002:a17:903:1a67:b0:234:f200:51a1 with SMTP id d9443c01a7336-23823f94c1fmr57933555ad.9.1750869527845;
        Wed, 25 Jun 2025 09:38:47 -0700 (PDT)
Received: from [127.0.0.1] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8673e1dsm140580495ad.163.2025.06.25.09.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:38:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>, 
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org
In-Reply-To: <20250625113531.522027-1-hch@lst.de>
References: <20250625113531.522027-1-hch@lst.de>
Subject: Re: new DMA API conversion for nvme-pci v3
Message-Id: <175086952686.169509.6467735913091492336.b4-ty@kernel.dk>
Date: Wed, 25 Jun 2025 10:38:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Wed, 25 Jun 2025 13:34:57 +0200, Christoph Hellwig wrote:
> this series converts the nvme-pci driver to the new IOVA-based DMA API
> for the data path.
> 
> Chances since v2:
>  - fix handling of sgl_threshold=0
> 
> Chances since v1:
>  - minor cleanups to the block dma mapping helpers
>  - fix the metadata SGL supported check for bisectability
>  - fix SGL threshold check
>  - fix/simplify metadata SGL force checks
> 
> [...]

Applied, thanks!

[1/8] block: don't merge different kinds of P2P transfers in a single bio
      commit: 226d6099402d8de166af60b2794fc198360d98fb
[2/8] block: add scatterlist-less DMA mapping helpers
      commit: d6c12c69ef4fa33e32ceda4a53991ace01401cd9
[3/8] nvme-pci: refactor nvme_pci_use_sgls
      commit: 07c81cbf438b769e0d673be3b5c021a424a4dc6f
[4/8] nvme-pci: merge the simple PRP and SGL setup into a common helper
      commit: 06cae0e3f61c4c1ef18726b817bbb88c29f81e57
[5/8] nvme-pci: remove superfluous arguments
      commit: 07de960ac7577662c68f1d21bd4907b8dfc790c4
[6/8] nvme-pci: convert the data mapping to blk_rq_dma_map
      commit: 235118de382d6545d3822ead0571a05e017ed8f1
[7/8] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
      commit: d1df6bd4c551110e0d1b06ee85c7bca057439d28
[8/8] nvme-pci: rework the build time assert for NVME_MAX_NR_DESCRIPTORS
      commit: 0c34198a16a88878aba455bebe157037c9ab52c5

Best regards,
-- 
Jens Axboe



