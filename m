Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6631459F5
	for <linux-block@vger.kernel.org>; Sat, 27 Jul 2024 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722085667; cv=none; b=WKICJzJJe7l8uRnIvUlKW/3BaPerjiy3Ne3+NvyZe1L70/0Me0gEMjhgOd7KghRjpxs+RsP/tOo8o8k01fjs+p8O6isNzF45EyoRXM/d0nH/BIjgXhYoHFl+aKFVFe05Vx1FHELEXbtkbnfbKvxaOl1xY4cU/lfBB4jWXWLm3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722085667; c=relaxed/simple;
	bh=FbrPr/bIFUHo/4UCFBntOKowKvnkJxJyCBBKaUza2AE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=r8STfCe514k+C70q6tNRYKDa/w69r0cPPIgEWzcnfq0rj3KvB7LfeNIe22GGUG7I2oJ2Azbg/SwfnH7RLeSIeGvfJJ71Bo76iJoH3VAnN9+9g3ECbw1HIEod4zSkjpTjuxOS9vEt7nN2ixNS71qGCzeqGk4w8C6BsX+EMGTh/fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZfDN6jMq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZfDN6jMq"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cd16900ec5so334469a91.3
        for <linux-block@vger.kernel.org>; Sat, 27 Jul 2024 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722085664; x=1722690464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCfB5nGzwsS6GaMsmiVVBT7q15CiVsElOGAqiQ062s8=;
        b=ZfDN6jMqZyNpCpNM831AIbIaERUaxLrANQ1tt906WJLMIHNmSJ4COpRc6ENYJ2TGOD
         29lpKt7qglvq9oOMFzZ9w+JfQurvIGtV1iSwjQX6VFkZ1nWe2x4H5PgiSyiRrbVQqOZW
         uBFwpk7n/es96I31aqnVJjlTqsxLFKdyJum5Yeof0hv9vLSqWD0CK6rdAw13uxhv1lcp
         Oah3m5lIf17sKCfBTeBWqTD0AAz/IxN1IYpxyiA6ZiB3AD35/Bb8HNggn/XDs1GInrqt
         UN2/mkPkv62ic2OqTRozM88HolSNm/ShtAW95OGFGGlWuKYrZz1w2o3meLGIAmxndYpO
         btrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722085664; x=1722690464;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCfB5nGzwsS6GaMsmiVVBT7q15CiVsElOGAqiQ062s8=;
        b=WOdzGlJ1616rnjY3F8e0HHbYN9OuyovCpj5rPFQ5MlVaB/QMMmISjUitHM9ONG+UOt
         935czo4QoOjoz+VFd0Sn/IKXuF+KH6C/jiVOiEhLyGAg0vRbJvy63nkVPdpyZTbkFUeW
         3R2V6+XJjCXwDQ6rrcs0eSKeGjARol4NQaRVOEcZUbBalYn4BudvSRCTZsrTav0/woAW
         /bzeax9XnK5ET7sQJskL5eKFLOm6fRMTe6HvTYaU3WR2IRWdM4WIJd16nvqEBd6Ph255
         UamNmMezL5PNbuLQJ916VvMEnJ1a02thz1nwZwuBr7QbaeOxGdB82bkLKyPwJyDZ5u55
         6Smw==
X-Gm-Message-State: AOJu0YweTJ4C3IOlCPtNXC6ICAMm9bvC0uPtDMgTBdhPBRGyF4heCwVm
	CNbXcNWd9iIa8kzYzZw0rhZ1aKq+XFhmXpnH0x51zEDcCHSnZdH441eAcPBhFrmJ+V+XJCO5urh
	B
X-Google-Smtp-Source: AGHT+IETTLBuFBQ+puU3hl4pMToOY1dpamRlf1sub53ordKjKYNIgdyNj6GfR1BL06YVSBs2JlKC7A==
X-Received: by 2002:a17:902:c40b:b0:1fc:52f4:9486 with SMTP id d9443c01a7336-1fed6d3938amr58786385ad.10.1722085663989;
        Sat, 27 Jul 2024 06:07:43 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee8177sm50116835ad.124.2024.07.27.06.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 06:07:43 -0700 (PDT)
Message-ID: <b1213d87-c86b-4105-9630-e92b2834a08a@kernel.dk>
Date: Sat, 27 Jul 2024 07:07:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Language: en-US
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

(resend with linux-block actually CC'ed...)

Hi Linus,

Block fixes that should go into the 6.11-rc1 release:

- NVMe pull request via Keith
	- Fix request without payloads cleanup  (Leon)
	- Use new protection information format (Francis)
	- Improved debug message for lost pci link (Bart)
	- Another apst quirk (Wang)
	- Use appropriate sysfs api for printing chars (Markus)

- ublk async device deletion fix (Ming)

- drbd kerneldoc fixups (Simon)

- Fix deadlock between sd removal and release (Yang)

Please pull!


The following changes since commit 66ebbdfdeb093e097399b1883390079cd4c3022b:

  Merge tag 'irq-msi-2024-07-22' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2024-07-22 14:02:19 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.11-20240726

for you to fetch changes up to f6bb5254b777453618a12d3bbf4a2a487acc8ee2:

  Merge tag 'nvme-6.11-2024-07-26' of git://git.infradead.org/nvme into block-6.11 (2024-07-26 08:06:15 -0600)

----------------------------------------------------------------
block-6.11-20240726

----------------------------------------------------------------
Bart Van Assche (1):
      nvme-pci: Fix the instructions for disabling power management

Francis Pravin (1):
      nvme-core: choose PIF from QPIF if QPIFS supports and PIF is QTYPE

Israel Rukshin (1):
      nvme: remove redundant bdev local variable

Jens Axboe (1):
      Merge tag 'nvme-6.11-2024-07-26' of git://git.infradead.org/nvme into block-6.11

Leon Romanovsky (1):
      nvme-pci: add missing condition check for existence of mapped data

Markus Elfring (1):
      nvme-fabrics: Use seq_putc() in __nvmf_concat_opt_tokens()

Ming Lei (1):
      ublk: fix UBLK_CMD_DEL_DEV_ASYNC handling

Simon Horman (1):
      drbd: Add peer_device to Kernel doc

WangYuli (1):
      nvme/pci: Add APST quirk for Lenovo N60z laptop

Yang Yang (1):
      block: fix deadlock between sd_remove & sd_release

 block/genhd.c                  |  2 +-
 drivers/block/drbd/drbd_main.c |  4 ++++
 drivers/block/ublk_drv.c       |  5 ++++-
 drivers/nvme/host/core.c       |  8 +++++++-
 drivers/nvme/host/fabrics.c    |  4 ++--
 drivers/nvme/host/pci.c        | 12 ++++++++++--
 drivers/nvme/host/sysfs.c      |  5 ++---
 include/linux/nvme.h           |  9 +++++++++
 8 files changed, 39 insertions(+), 10 deletions(-)

-- 
Jens Axboe

