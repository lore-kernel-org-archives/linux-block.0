Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E6236A8B
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751852; cv=none; b=ORXKzeeH4awdlBanT9i7mrPlWqwsEitFPC6CzLCHtcZnEYD3yQw6C5VQ2yVWyW8Af5/KKgOFwQVRuyI80vwVUjH+QjZ8ng9ZcixNHDs30+6GID8EyUwZ5iSxhUZmgz1syuYFY5ujX7U0V+AFGi9p3QKX21sxHf3geufeQt9Xtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751852; c=relaxed/simple;
	bh=jFFLsTaZSalP/i67gmqv5CN4+piSWUcVRQzYX92VUzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qc7OkbMHFiQydSrdCdyyLD/F08iMjvQs6+Bo6IK/j5inSNdNnQEWU4Kx0ZRhkPuccexi6ASGA45QmO+bzRr08ILLG0TbxZPHmkFoD7fV2kYGWl/OjSRr1NrQJYVcjPj43NvnIKCeXcc+qsQWHt9Fu4PJPL+khVE170OM8+7xdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tMxe8fFc; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tMxe8fFc"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c7545310b8so824411a34.1
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 18:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767751847; x=1768356647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcTQoUcIXWvvQGWuloMJzBEK7Hz6Zc+n1XoQykXAO6Y=;
        b=tMxe8fFcaH9+t2CK/vykIYQsCiziIciUtAhi4a6alRkH7rdqzpMOKJlhWqoJgJu45j
         X5xN6BjqVow7x4/cWHdgOo+YonswesUi1sZmDM5Am2lPFLlGvFOALvZ+y9MarQ3vIsYy
         GGQlALTGRijfyAV4kZ4oG7pnFDVCR1an90dKLqmxyhpbB76OD50UHU/81jYCcBFaR0lo
         vtSL9L3RLGVQRrsFIz0iT9bQZuo/E8omqfYE+1lN4cfwkkxbUqlXzrHDdi1cWqn4FhC4
         7GPviVpLO2btG00sObHl3AB1weFBJ3didsJuAJWymWKbDcJKoNEEBEFlxMh+offOzYc4
         Gfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767751847; x=1768356647;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QcTQoUcIXWvvQGWuloMJzBEK7Hz6Zc+n1XoQykXAO6Y=;
        b=LTQg7VwxG2i1NznJnTgtFudnTcQdneLRfIpunMDNkivmXK1HwZUUxTWIhAoODn1d/L
         S0/aA5A3gayqvwlFkYiOohT5ZSwzHUMtzJuiNjl8jsXzDXVGtUpEX2m/lBBJvIkGLXuD
         IkgYvX8vhq+ueujwS/GRUa+0Vxjp+ThEzWrDMSLEpca+PCDKle8f5BWeP7kiB29nmqnN
         rGqSfo94L37UCCrQH5Pdds5FEOLdRyWyYfT2z2nMvedaHJvw9hxhCZ6pr3JgJiwSS/fC
         K4j0MMuS1YHT/+RfDk+1dhhfCvKQXwA+d9K44LTRW3D2DQPT3ZX6APHCmUPiHuQBbRcj
         OuVg==
X-Gm-Message-State: AOJu0YzBLCRFYmEpD90HEvTEphMRicDmnEwDBrqeCv9jD0M4sWxkf6Cb
	VphqH1mzrtkTmKTquAyL6/Kpm74R1s4KoatNzRTmsTDrLTyNjjFEB1fqZq5q5raR2mJsHz9ayso
	e2ZHZ
X-Gm-Gg: AY/fxX5mIaqaulQh8oUihTyi1i+WL8ARnC/DKP1N25y+RyJyVfO7qw6nRBnkgFXmCUN
	wPWGk6Bm2KoSToxFwlyOH/W/nFXBEoeJ5IvDwPcvuJc0kaz4FuEDUv1DVptdNwtcMZi++pIuRTQ
	/3fcn7Zdll3p8wGSYanu6WZpz598JcMiOwCd881iI+fqnomvN+DmWzstJthzquF03M8JpDIhjG/
	uEWPZsYJLOwnO2jBOSBuIYlyQgDNPD8qrtJlwDcq3y3W7O+b8RQ0w5Ne0+K8NBm9dp4YlSjYBVf
	gVTFWe+9VM+bhuTBsDJTrIrg+ZRMRgCCm607iIlGHBfl/282z+RwutdTD22T/M50a5pE2dIc4Ds
	UEkMsT+5Yy97f2fDDVmw2FiOMh813gAYUCnrrBWeozgv957vY5FDo7WBzygPKsB8HEkyqbWtiF3
	to3oA=
X-Google-Smtp-Source: AGHT+IFJHePhw1jDwTbBMyvhpWIyliB0q51lm8NfZmuYk9ACWXlLP38woqs1kc+gNRVBKWouepc6FQ==
X-Received: by 2002:a05:6830:3c07:b0:7c7:68d6:5925 with SMTP id 46e09a7af769-7ce50bc2392mr551073a34.27.1767751847543;
        Tue, 06 Jan 2026 18:10:47 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af8besm2460657a34.14.2026.01.06.18.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 18:10:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-Id: <176775184639.14145.18318539882421290236.b4-ty@kernel.dk>
Date: Tue, 06 Jan 2026 19:10:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 17 Dec 2025 11:41:22 +0200, Leon Romanovsky wrote:
> Jens,
> 
> I would like to ask you to put these patches on some shared branch based
> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
> and DMABUF code.
> 
> --------------------------------------------------------------------------------
> Changelog:
> v3:
>  * Rebased on top v6.19-rc1
>  * Added note that memory size is not changed despite change in the
>    variable type.
> v2: https://lore.kernel.org/linux-nvme/20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com/
>  * Added Chaitanya's Reviewed-by tags.
>  * Removed explicit casting from size_t to unsigned int.
> v1: https://patch.msgid.link/20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org
> 
> [...]

Applied, thanks!

[1/2] nvme-pci: Use size_t for length fields to handle larger sizes
      commit: 073b9bf9af463d32555c5ebaf7e28c3a44c715d0
[2/2] types: move phys_vec definition to common header
      commit: fcf463b92a08686d1aeb1e66674a72eb7a8bfb9b

Best regards,
-- 
Jens Axboe



