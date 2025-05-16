Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A734502BE
	for <linux-block@vger.kernel.org>; Fri, 16 May 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401928; cv=none; b=e/pbMhN3DDhpFSpdH2XpCUELIbz4hsFvdkuETVzffVRgELOGYsGl9c7TvD9cXfKyM3dgF3BJc9vy1tTFkApqaI453rLXML0ewSUf2CsQUM7ELdKi43Rjecp4RbRQkzNTwlJC+Xb1LX0OvXXBoYsWEzGlp0h2kdpFVu58kFkAMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401928; c=relaxed/simple;
	bh=s5k/jNNETxgNeqNzBEbaklAGIBfl8ipKcF5OGaqgvAQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=C9WxJfn5Lm5abZ+fYmGrgzGK7CeyyWsO5bODw2+V+an4w0MQaNxtPnPIWYnzP7pdfPk0TvDn8vLw3YXWwwHkb0KeL/PFAlhw6OKsBgu6WvBA2iHzquyeUYHi4S1g/zkk3YRZ9JEBAtBmg00dUdipH6cDeGC2sNY2Nhp7iwPl6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Fs3th2/Z; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Fs3th2/Z"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3db6cda65efso11114285ab.1
        for <linux-block@vger.kernel.org>; Fri, 16 May 2025 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747401925; x=1748006725; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fRnR/n17qD2UBlkwNIKLOJbZGbv5+RE1H+GS/YREEQ=;
        b=Fs3th2/ZzRcIS/GRbcaqKds/iRJG6DOr2heHSgYQOk1FZ2TiDacgADPJZDxNKZuaNx
         zzKAWySKuuY//YNsW6bCTOytOnMxJo8Ip8R0ynQMbD/4XIBywcVvSjg2iHmSRzTtJxBW
         ORVBo4zAU2oZOYV7h9PaD4PbFyI3mT4O/tia1kFrRrBYI0EycN0gUcebNvHidsn4yfD6
         yfUlmwL4P7cfCn3WqZ0WAj6dDXIFBf6e3w1fS3uB6Y5s1mFdmfC8piHi4t845xt2Mz5a
         2l1x5bKMDm1qcQNJsE5eHJ0fHiPfgmCi0s6f4RxVp7T8yD5ufhpM20NUbHpw9fe2425N
         RkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747401925; x=1748006725;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/fRnR/n17qD2UBlkwNIKLOJbZGbv5+RE1H+GS/YREEQ=;
        b=LaUgv2Rc526Gtx8bQlXt0wVMAK+Vs2nXtXxfPPnPnUnbeypet9JDo3kZ6Qbys00YPH
         0BljbcPLktArhFCq0IgbJ+5s2xAD/AzovisglwaE4r/K2JaPWJC58XwgrNdPjAcFZAmk
         5dMMo8hQQKKJjgXEC2vi6T9Z4rKo1nPf0D8nnf6k7YPSZSVB4L0IgGvgXVj321SyKzmN
         jY+SOm4oeXIFFeYsXUd41p7HlWudMUmKSP8BD932G9U2GSM63fWv56GXZryebFjCbWrZ
         Zre1GiEZEg0VSlJ1N/Dck7SVrkq15ALzaN2zTv3q72BPoY+ANVOhzdRWinqpfevoqHU5
         qntQ==
X-Gm-Message-State: AOJu0YzHR6pbmxak5qPXbKTHz6jQb5NxWtBwDmb3jsr0G5KTuxXxwTlD
	psNsuZFck9xA0bTMP+ZTm8EWfNT3VYeySpNNRrsNcH6+t5laygldHhvfasKmY5joonPTgzALbSS
	osuOW
X-Gm-Gg: ASbGncsz+s9oUjziybINUqSIavc00yl0MLXbFkBINqSCoISr+13Bsyho7RPK2Qb7YOi
	f+9k/65MxOANCG5qHl4L0BIAq/g32hA1PWg9dUyZnQzLW1mJhJ0yl0lqgWe+3g4VDAs77Kbn4lh
	V1YUfLIwWHyArCczrVfjUtpEcCyZ7jKqNfC3NSiKQItlqurR2NBTVxuh2bHBQ4trczGubqrjhlD
	VaBhoalmuEpSUbv8G+CcBrgz/GsoRnJLQEDs5f5AfdrOFHTLGJ+9090hR8CuKAqzNgyp7mf3SF7
	ICmrfzt7NcfmO9ERstNCzVP+/XXevqTy0Y/6pdqpeuEb98A=
X-Google-Smtp-Source: AGHT+IEkhyzGf1wO6QJ80cki0bh0zp1lS0kTLt5Mfg5ojErbiM1m2s1sFdk5X3iM3DwcKMLC+c7iXQ==
X-Received: by 2002:a92:cda5:0:b0:3db:6dd4:c2f0 with SMTP id e9e14a558f8ab-3db778fc5abmr96532365ab.8.1747401925220;
        Fri, 16 May 2025 06:25:25 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3db84449204sm4833795ab.69.2025.05.16.06.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 06:25:24 -0700 (PDT)
Message-ID: <23fdc0b1-60ab-4875-9bc5-4b666fe2279f@kernel.dk>
Date: Fri, 16 May 2025 07:25:24 -0600
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
Subject: [GIT PULL] Block fixes for 6.15-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Some fixes for block that should go into the 6.15 kernel release. This
pull request contains:

- NVMe pull request via Christoph
	- fixes for atomic writes (Alan Adamson)
	- fixes for polled CQs in nvmet-epf (Damien Le Moal)
	- fix for polled CQs in nvme-pci (Keith Busch)
	- fix compile on odd configs that need to be forced to inline
	  (Kees Cook)
	- one more quirk (Ilya Guterman)"

- Fix for missing allocation of an integrity buffer for some cases.

- Fix for a regression with ublk command cancelation.

Please pull!


The following changes since commit dd90905d5a8a15a6d4594d15fc8ed626587187ca:

  Merge tag 'nvme-6.15-2025-05-08' of git://git.infradead.org/nvme into block-6.15 (2025-05-08 09:08:23 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.15-20250515

for you to fetch changes up to dd24f87f65c957f30e605e44961d2fd53a44c780:

  ublk: fix dead loop when canceling io command (2025-05-15 10:53:41 -0600)

----------------------------------------------------------------
block-6.15-20250515

----------------------------------------------------------------
Alan Adamson (2):
      nvme: multipath: enable BLK_FEAT_ATOMIC_WRITES for multipathing
      nvme: all namespaces in a subsystem must adhere to a common atomic write size

Damien Le Moal (5):
      nvmet: pci-epf: clear completion queue IRQ flag on delete
      nvmet: pci-epf: do not fall back to using INTX if not supported
      nvmet: pci-epf: cleanup nvmet_pci_epf_raise_irq()
      nvmet: pci-epf: improve debug message
      nvmet: pci-epf: remove NVMET_PCI_EPF_Q_IS_SQ

Ilya Guterman (1):
      nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro

Jens Axboe (1):
      Merge tag 'nvme-6.15-2025-05-15' of git://git.infradead.org/nvme into block-6.15

Kees Cook (1):
      nvme-pci: make nvme_pci_npages_prp() __always_inline

Keith Busch (2):
      block: always allocate integrity buffer when required
      nvme-pci: acquire cq_poll_lock in nvme_poll_irqdisable

Ming Lei (1):
      ublk: fix dead loop when canceling io command

 block/bio-integrity-auto.c    | 62 ++++++++++++++++++++++++++++++++-----------
 drivers/block/ublk_drv.c      |  2 +-
 drivers/nvme/host/core.c      | 30 ++++++++++++++++++---
 drivers/nvme/host/multipath.c |  3 ++-
 drivers/nvme/host/nvme.h      |  3 ++-
 drivers/nvme/host/pci.c       |  6 ++++-
 drivers/nvme/target/pci-epf.c | 39 ++++++++++++++++-----------
 7 files changed, 107 insertions(+), 38 deletions(-)

-- 
Jens Axboe

