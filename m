Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5F2AD21
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241600; cv=none; b=B2SiO1Oh59wexPQvzx7D4M0pBo0/jlqBvwNJabuZFH9MkXP9NxuTDCgNQOhGAlVwDUHw44Bi1z4w2a9EBXutsVSPwyF38wKcx+cWEAh9VYX/5MqxNC8nue95LNDyYjcnWP3MR9ng++3NHE3bsRGD01xMmU+j2wpySdgiztv0zLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241600; c=relaxed/simple;
	bh=D9dpK6dD3qlvJaJirzKxgO+jWPO4OeERtDtmXQkM/w8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AVqS5Asj4iY0MxoVFQKbh/exFUiZkKS4EjU7kj3uowLwzf7TdK2pumc0G27Q6T0Qfq/Ba0rnySo7A0QqiLYgkxG5vUOQPoE0ask8npcKHTFy8zt+9Be9xk2cEcEMZn/6CsGE6uhCkj4G6mugyXbI4oLhPsQBB7hv/+4x4W9uxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YT3ZVZit; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YT3ZVZit"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86d0c5981b3so85210639f.3
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752241597; x=1752846397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/juseajL28aExOR0ncFEkgamJFYX4aY2BgbPyJWuRxo=;
        b=YT3ZVZit3U2UJs9GpS3C6CwcM+11nn1BOD55qrkXdHSzTA9JJfhTGsx0ny/P6nlMAy
         3MRRhqMLM/VcppfbsMq7HKBBULoPKNPlWwqISyrWsqBul6FqXKKS7tEcoW/37TtKvzv5
         YOS/DqXWWsFxJdYT7iD4JnvH3jI2XtGtYPQ8QRhJqPU2nvNVDQLQ5tpWOp4NOoSGfjSM
         WbF/MuRdhLqsnWhxbTkT0iqiSWduvgjx8/vyfBxWDHjKCzZqtz8YDZWiS/wWMAN7Ti0w
         ilVSVn/HZZjR0IgwW972FRtCwRWYzsvRSX7X0dpXRpDkKlEm7qtmyRagXOdWD9A1nunV
         vCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241597; x=1752846397;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/juseajL28aExOR0ncFEkgamJFYX4aY2BgbPyJWuRxo=;
        b=Rru8nDn6sxIMSJdKFx8ZGsXjVrqFi6yKQxjf80XQGP+LCAuB3jT+3lO0igiO33Dqys
         aoWcmJLC3y13GmtXsuVz77ZzdG4pUC1cnHG0TntrJWSepOhIoZ24cUH9O/DmfO0ZUgjc
         OKekH5OaiJ+qBgfSa9UAjrZt/LGTY8vsuoHbgTdP4Ns7S8bhkwVoK0h8gZMeHyFf2f3z
         9Ci4VyYkskbNO86IX6O181VYw2X18iEnTGfcCmewi5aa6Noyihg5UUEs4YNBcXfAzJbP
         nNpXI5U5NkNSNA7c8hmpPiDLuGq7jN9oSnlUFUZ2N2lRd19ZYelhOAgtyItK540+d1cU
         2D7w==
X-Forwarded-Encrypted: i=1; AJvYcCVEOhtlDMsnr+vssGKi++QcJ9A6Zk3shKdYInrElD9aSZsp1YtE6WNAOGglFEBWCENs6XJxx2GqxXDJuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTptqlduWcvTz6X6XE/ZfUTN5GFmMY4LXAXR7B4a0F4uFGQ2tK
	Dsf7cAPRMR/zzq7ywMmpONr2dnyJ/rggrCti6H5aLRzej73zFP2RF2or75IY5O+ad10=
X-Gm-Gg: ASbGncv6kQH3UD9y1dxEZFy8UtTwuVdLbaTT3GMIEHZS7jueTgZeOPHoGtMLiSZr6Ww
	c9nQNVUabox18CAcg9XW9ytBLNLs/6TIVNf258HRfd/7bZ7APRkBroGxyRcybO39+J1rvk5daue
	dDnx8IWljbjCUus32Xxyn/i13Su2wJADZ2acZj4TjJAv7umMYPi3fAu2A+msl8o9EvsKEquaoo0
	zS/8kOSnkZWZpjmB+oIQA9VsDFxwXg1D4LyhGIjO4yJdRtwOA/ureCw4kyjiBh3k9sjKJRXAhDU
	Md4cff867iLfThhNM0MLLiMk66q+EuKzsu4MEBDJX/Oh49H0SKOAqpdz840AVBXbTdCqI73/z2F
	kMhh4Z3zIepvUUA==
X-Google-Smtp-Source: AGHT+IHC39aaGhMdGdrpBQXoGqq43BIWcV2gT087/3qAkm55jq0BVsD9zJu4zapauSL4z+v7y+zNpw==
X-Received: by 2002:a05:6602:3fcc:b0:875:dcde:77a9 with SMTP id ca18e2360f4ac-87977fbe295mr457592739f.14.1752241597239;
        Fri, 11 Jul 2025 06:46:37 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8796b79fe4bsm97569039f.0.2025.07.11.06.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 06:46:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20250711112250.633269-1-hch@lst.de>
References: <20250711112250.633269-1-hch@lst.de>
Subject: Re: [PATCH] nvme-pci: don't allocate dma_vec for IOVA mappings
Message-Id: <175224159635.1454175.11115661661587383197.b4-ty@kernel.dk>
Date: Fri, 11 Jul 2025 07:46:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 11 Jul 2025 13:22:50 +0200, Christoph Hellwig wrote:
> Not only do IOVA mappings no need the separate dma_vec tracking, it
> also won't free it and thus leak the allocations.
> 
> 

Applied, thanks!

[1/1] nvme-pci: don't allocate dma_vec for IOVA mappings
      commit: 1bb94ff5ab4be2485884e0a46483f12629f3bb92

Best regards,
-- 
Jens Axboe



