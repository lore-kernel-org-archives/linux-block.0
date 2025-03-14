Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB61F4716
	for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964006; cv=none; b=BaDE987U8IsjbwDtAGZziv43NoHFZNG4tNVGytAjfji9sorIyTkhenwhp9EuGr5/ErQ3IXQc0s8FhakHIJUQvUKSWttzNGyzNcojaXMeSOT0tu1EEEQLqHeerWBm0Ha7A5SLgCQkTmf6e8M3pNTbs0fB8JXiiqK6Acr1FU9LcYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964006; c=relaxed/simple;
	bh=35mBIMYKOqRLZT04hOvrAl8Z7XOvI7OMdSANAGvALNg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=afVzqX+sekbmvb9xqxiIrDc9DmhG4am8sFAOZn2r25+jjLuE+MF9gRLBu+5vTBg0oI2IzlgP7G3z2WBfJsfgjh7bGsESxFVvAXaL2i0kqwua5iVp2RN5ehnMoYOzBvJ6A6kOmPO2Mf9jz5vXx7yw93tlAkbOMjnSWcse4B3agRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H4ghaqQk; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H4ghaqQk"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so7434495ab.0
        for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741964001; x=1742568801; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocb12fwyeVfviG3UI6QA2CNOWbf9Abl8GuGxnQTrHhY=;
        b=H4ghaqQkiWErm/eXafHt1vM9/kRWZSUiixh0HrGOzUNsdOtnfGDIJj1DmyKGms4nT5
         RWYzSWeLa9tYdwunIX3Jxop9ey8jFcSwWBL1kVEPMYExx621otvbBzQMgNA/Zq7l7Fz9
         t42lw0Dk3ah7wGCBzT9ZqeZonkjUNCadBmmRr6bItNYRvsMglVy9/2wTkFVl4C52jtkM
         dVu2h+OdwVzxGCQK2epkuHzOdwgtQut+Sz1UCBSDgE1PYzeqpFQMdUGB14JoMKi8ppjA
         +Spa61gD/zq5QAxX4z7NQ46d4i+OE+ijtnlfidjhzftwOYm5GlhHRwTqr8s/ejb0caHD
         4Rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741964001; x=1742568801;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ocb12fwyeVfviG3UI6QA2CNOWbf9Abl8GuGxnQTrHhY=;
        b=q0NriZOOC+QDu2s1CTgOB014Fwg/ZntexIoxCVdlHNlY0IImXb4zUZTwv7nsmw6hBV
         VfEH/8hzDafhKDa5mT2R748vpLULDqNvb1WKZID5V8V8XLZv/xN2BdkIu7nXVPqvp1a4
         719h1nNd7vCOuAdHQNkjKVQ30cmEJ+V0+df065CHoy+KrKYlHvlZOgLRKcuPHCVCY7V8
         TyCErxj5GiVRaKAjFXjCaVP9eBEbv4tdNpFlkbU0AWvhGuyQ22YwUYvSc1rFEsvMYH+V
         BfvLcxmqyn1wcrf6+ipDg4vR/MDTY30oEGsIgsChxljGmI+Y3cy+FPwfyLFDhMPfLNB1
         VKbw==
X-Gm-Message-State: AOJu0Yw9rFESd3FwlVX44twMTpu5CoRL8gYXwsqsHrRB1z6Dy/+w5wGc
	3/AUGJEtg6qMrzMvGCSZy/cEyeFvrgkF7cwpc3j3ycyjl5tlLYL72PbZPT6sgJpOYy7et93roVx
	W
X-Gm-Gg: ASbGncs2rknEp5qMIVX0JoprYoqUOcnYKpLRNamFvg7H0TdnmZcc7VXBnj7MtLQedoR
	aEvGlYdZ315nzCF8Qqk9FuUM6y1oj6PI6yR/EEBGsLFCMsxohA8OkN+mc1h/eg2GheR0beYssWd
	aVOYfeDfUS/vcSeR7tkNalFtkbi1NCnfAMenWZZBQdW23c0r+52PlO5jF+Z8jF+A9oMiByN7BxR
	3lNIxWqoFDoI01HX1jnxVSBgj4qcO0T2y9pb8FxnhDNARb6vNMk/1cOpbHzXOJSkfxxXZuiRkE9
	kQ5ChpDTTVMSoRf2GNpbNBqtCcyHq5XZ7SdzEuVk7Q==
X-Google-Smtp-Source: AGHT+IE+IhCFE8W2RkMDKHTTcDkB6+CJYT7lS8sqv8qYpaJNKkctnLnnyOU8FGAwN7VjwoGhbyqPSA==
X-Received: by 2002:a05:6e02:1a27:b0:3d1:78f1:8a9e with SMTP id e9e14a558f8ab-3d483a80000mr26166085ab.20.1741964001194;
        Fri, 14 Mar 2025 07:53:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2638147bcsm883298173.120.2025.03.14.07.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:53:20 -0700 (PDT)
Message-ID: <8bb4ab47-d557-4017-ba70-308ad3251c94@kernel.dk>
Date: Fri, 14 Mar 2025 08:53:20 -0600
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
Subject: [GIT PULL] Block fixes for 6.14-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes that should go into the 6.14-rc7 kernel. This pull request
contains:

- NVMe pull request via Keith
	- Concurrent pci error and hotplug handling fix (Keith)
	- Endpoint function fixes (Damien)

- Fix for a regression introduced in this cycle with error checking for
  batched request completions (Shin'ichiro)

Please pull!


The following changes since commit e7112524e5e885181cc5ae4d258f33b9dbe0b907:

  block: Name the RQF flags enum (2025-03-06 17:50:55 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.14-20250313

for you to fetch changes up to a9381351dd6c52bf465233cae5f50da227834607:

  Merge tag 'nvme-6.14-2025-03-13' of git://git.infradead.org/nvme into block-6.14 (2025-03-13 09:41:57 -0600)

----------------------------------------------------------------
block-6.14-20250313

----------------------------------------------------------------
Damien Le Moal (2):
      nvmet: pci-epf: Set NVMET_PCI_EPF_Q_LIVE when a queue is fully created
      nvmet: pci-epf: Do not add an IRQ vector if not needed

Jens Axboe (1):
      Merge tag 'nvme-6.14-2025-03-13' of git://git.infradead.org/nvme into block-6.14

Keith Busch (1):
      nvme-pci: fix stuck reset on concurrent DPC and HP

Shin'ichiro Kawasaki (2):
      nvme: move error logging from nvme_end_req() to __nvme_end_req()
      block: change blk_mq_add_to_batch() third argument type to bool

 drivers/block/null_blk/main.c |  4 ++--
 drivers/block/virtio_blk.c    |  5 +++--
 drivers/nvme/host/apple.c     |  3 ++-
 drivers/nvme/host/core.c      | 12 ++++++------
 drivers/nvme/host/pci.c       | 18 +++++++++++++++---
 drivers/nvme/target/pci-epf.c | 28 ++++++++++++++--------------
 include/linux/blk-mq.h        | 16 ++++++++++++----
 7 files changed, 54 insertions(+), 32 deletions(-)

-- 
Jens Axboe

