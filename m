Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36213ADA
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359597; cv=none; b=twpcwC/vKUiWRacs5D2tWRUaWh4uXsNZN1tjIKWVeVIxkVuzqWLDy9pHtgtXo+6+3Q/GAlQa5Xus0+EcObwczsQCUfaS3mzv6odIDCJp3lBppLhN4avOJtQF4wD6va/jnDKY5SyXj3pEm9H6K+x66ynlVUzPAuAuaHCUyR4zKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359597; c=relaxed/simple;
	bh=PB31OAOn8fQlcgAzOqDPcBz1IoRedBr6wzvvdcpwERI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=E9juVDAFYF7AGdnQbpVA5QHnss1KfE1D1TIzufk4DiFm28Du5YqBnesJR8cVSRv/E8cv4w4Gw4dUl0C/XipWf6u3GZmeSfLkqSyAc7iSB/YQw9mzr0+BjLp+dm3uvgymyKZ9BP1poKzPsqs6m3Ip4Y8RabWumEIpbsxrsHI++SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rlX0vD6D; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rlX0vD6D"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7e1ba5f5346so6003239f.3
        for <linux-block@vger.kernel.org>; Fri, 10 May 2024 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715359593; x=1715964393; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOjSAWdBKjKfnE/IyzZpvHAoxtgRelcMrm952VhOSCQ=;
        b=rlX0vD6DejVxrY4Us5rbnNk9pQQuOtsE0lreLVFuCINmH7xr5sfqcfrVAudjUeF4yn
         NzGf3QA5DqKICcZhgfrmoq3vFuOMr+/c2C+ZaBLxGjiE/WBTNQQ3yRKLLH39diG45aJ0
         EZHTk4P1kidMnpswhT5aj3YsCwdcLm41yeKwjVBuqrreT9SRUf3jm8f8yshFNDaumtHG
         ckpn7PHYk90/ONANYgbPf5fFlwVSdtR4hl78RdCpGoY8ebqG1RefmJcxv8VdDraet8vl
         LdmI5p7Om4RdSNlyv1KS8nvUPZPHFTYINPJUfr4XtR+cAH5nK2aqUkJWG1Ulajk69+Fv
         CWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715359593; x=1715964393;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FOjSAWdBKjKfnE/IyzZpvHAoxtgRelcMrm952VhOSCQ=;
        b=ZrhB3eK0pqiUXKnZYyFcyS9kuJ9dUKrTaJndpRc6AjzXPZVI9FJV1gwsvMKSzgIBmV
         bHXnJhiJYd+bJPoIFIsfQrMs0sZqHm1gTh+P2jVyXHPDK1DrIPOIeYAhmc3DTu/BcqY9
         2MhJjbsVmTMkBHTtIUrDhLxvrvg+g/LMggia6r6DCNuL64drpL9iiUkNBuYNJrNhAx/h
         teNPCjdIBmeG5702M+GlVExWJ0PJtT3hT7KSvT1wjGX8IwOsy8pzAmo8twH0k0JxoGzI
         Jh7/Zixvc1RbC2OC/9mYJqN/SZifyM/C8pw1fQsHudwmVlemqRYwqEv+DYT8d5ALz1dB
         v3og==
X-Gm-Message-State: AOJu0YyEAGXShoKHhCe/6xdXzNgMo2o4suWeGWQe5JP9Ml4atY6kAtO/
	pTJJpg7ZnmZ/zpJUqH9tEDVQtLb/+trLuPaKBflJRoftYKecAQWpgfJ2T75rwZG/79vsvICpVLZ
	j
X-Google-Smtp-Source: AGHT+IErUPyvi0w66SQycy/1vgWehQQnTVDr0kfSdiKo2ZaGdDwaADBZOTGxEcjY1MG89puMwm3y3A==
X-Received: by 2002:a92:d782:0:b0:36a:38bf:5fb2 with SMTP id e9e14a558f8ab-36cc14d041fmr33890945ab.2.1715359592737;
        Fri, 10 May 2024 09:46:32 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cc3f732adsm3889255ab.70.2024.05.10.09.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 09:46:31 -0700 (PDT)
Message-ID: <232508dd-214e-47ef-92b9-8f34ec479584@kernel.dk>
Date: Fri, 10 May 2024 10:46:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.9-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes that should go into the 6.9 kernel release:

- NVMe pull request via Keith
	- nvme target fixes (Sagi, Dan, Maurizo)
	- new vendor quirk for broken MSI (Sean)

- Virtual boundary fix for a regression in this merge window (Ming)

Please pull!


The following changes since commit fb15ffd06115047689d05897510b423f9d144461:

  Merge commit '50abcc179e0c9ca667feb223b26ea406d5c4c556' of git://git.infradead.org/nvme into block-6.9 (2024-05-02 07:22:51 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.9-20240510

for you to fetch changes up to a772178456f56e20778e41c19987f6744e20f2ee:

  Merge tag 'nvme-6.9-2024-05-09' of git://git.infradead.org/nvme into block-6.9 (2024-05-09 11:49:18 -0600)

----------------------------------------------------------------
block-6.9-20240510

----------------------------------------------------------------
Dan Carpenter (1):
      nvmet: prevent sprintf() overflow in nvmet_subsys_nsid_exists()

Jens Axboe (1):
      Merge tag 'nvme-6.9-2024-05-09' of git://git.infradead.org/nvme into block-6.9

Maurizio Lombardi (1):
      nvmet-auth: return the error code to the nvmet_auth_ctrl_hash() callers

Ming Lei (1):
      block: set default max segment size in case of virt_boundary

Sagi Grimberg (2):
      nvmet: make nvmet_wq unbound
      nvmet-rdma: fix possible bad dereference when freeing rsps

Sean Anderson (1):
      nvme-pci: Add quirk for broken MSIs

 block/blk-settings.c           |  5 ++++-
 drivers/nvme/host/nvme.h       |  5 +++++
 drivers/nvme/host/pci.c        | 14 +++++++++++---
 drivers/nvme/target/auth.c     |  2 +-
 drivers/nvme/target/configfs.c |  5 ++---
 drivers/nvme/target/core.c     |  3 ++-
 drivers/nvme/target/rdma.c     | 16 ++++------------
 7 files changed, 29 insertions(+), 21 deletions(-)

-- 
Jens Axboe

