Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288A21B8F5
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357564; cv=none; b=Fz446sfYXFOFG91R/HYuYLNujw2N8FL8RBSmWAPcph8XtwcBkqYbCBOAES1MJivNzOpYNTxHS+It9HJCrXKBq/pYjupjdBtk5uX1n892WrwMr98k5Nsl+IuMqHlAE7jwrFsMN8jia6Otj5P/mScL1g0r91Vs3naHyjxy17P+ssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357564; c=relaxed/simple;
	bh=4EvHlnf1fohRzjRimw6u7fxT7kyWfMjsVGtkFvJBDkg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ti5H02X8iKh70MrmnlX/7qT8K+WbJ1NQFclSxvqRrxZI3BLNBep5B9v8K1htb7dFoj+GKYJj4TctNoNR4xJlI4RSey60tlMSemPrd6WYshpTaUVCkDNYV8GvqY7BXdFyh6T2qQowo8dTmdEokb4eBUHMt+PganruqI+LchN67U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1jD5AbFb; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1jD5AbFb"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d439f01698so5950955ab.1
        for <linux-block@vger.kernel.org>; Fri, 07 Mar 2025 06:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741357561; x=1741962361; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8pbBCWCztgek4LA1HjYQblBwyJeccemjhH7UVsKwvc=;
        b=1jD5AbFbn1HswMd4gDPKFvSm5VitSnsPQ9mybHNgU8ToJhRSkX9cW6GoMgwGmhlSsm
         9BCbTJ386VzqkLaghm0iyQyv9lhdvu/TpSGBo/8UECP20pNiGq6kRitkRrPvZv0fHu4d
         k3m0toteRNL0u2vaPDAoXrmEYfqCOe3vmWZzPvRLOI2yKssPwzZy4Lm0Lg8Ia+CLp6Ss
         10LIiVYn1YO0rs4BANYVOFcgQgNkY1/MzxL858gKdRoHACzL+WXpag1CHGthXiN3brQb
         D8L4N2Db2K+O/f62h2Ip+L58wA+IV/K7EqzPgZTZEZCntkub3xVG9xfznG9mZoS7VQzt
         96oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741357561; x=1741962361;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u8pbBCWCztgek4LA1HjYQblBwyJeccemjhH7UVsKwvc=;
        b=jKion6c6QJLkLa5gbh7Hvb3OlLAlDds7iFqGnV+bnEhXZGia5AEQyaQb1azLo+sQwt
         70uZnq21h1B66oyEUqi/GWjkX+GpqqnCYbCLp8YjuiKvvcuhNJTqjh/30WETDjxoNQE2
         IwmJf2jgOU4BFoP4GDrPfwAMNDCG9ymUItM94OnfzqXNVHDpfGFs+UKaeu7rjUQ9sRmq
         o/2XyGUNBdorZbyfywlZyVay6sxw+H0wBTcyT/M4hd+DCi1RWnBx8p8ovd+gFEFrBuh7
         WzOwlPW6Cmxw1dTZWPAJdPIGrsW40OYWt9FFptHu3K4BykFbEfQMo4gmkeFTUr0Vt6jA
         lIvA==
X-Gm-Message-State: AOJu0Yzm4K9pDpkFNuFXyWhk7XjBPoBQVTka5VffHYi8uo5lH6wOr+nN
	gBOdNfj4Jn7XRxyzILpymvxcxjjRZC+/tohCrf2gKDQ8IfzEfgJXpoBwqSErzdT5lCEXsEafyoP
	n
X-Gm-Gg: ASbGncupTJ0xScMKvyPF+rL676laoHwVq9f+N696E6Ri5K8fmTRz5w9fCnS5kHurEqU
	cF87ylqgTZs0KLE9yZwoItzZBRsrS9xW6J9OiUxsTHlSrGWWKgOejupk16eoWV9qC5LjnZ+CUaS
	Z9imNj+GT6Zj4OIHFgXhmLpZ4d1FLoTkE9hG1l3Zprdeqg9bsFH6lk/BFSuc+nU0+SpZsVVEc7q
	Dc0l99Cipgq5YeRSX61gYSpO1542uk3Z60fKZfpFeQ6iTWDrggbo49iB8toz6pnGjfjuohDREiW
	Qb2de/DFzwEAvfSZIjl6sotsdF+9FgaNs+C6Sbx3
X-Google-Smtp-Source: AGHT+IHRc7LPjSFD0WwtfPIylZf/U9zZGM+DISs5RPg4HEhmQ2gzIQsGcO29EqKc37ljYiKnX7h9cg==
X-Received: by 2002:a92:d349:0:b0:3d3:d156:1dcd with SMTP id e9e14a558f8ab-3d436a77b84mr73823685ab.1.1741357560932;
        Fri, 07 Mar 2025 06:26:00 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b4e1fe1sm8170095ab.12.2025.03.07.06.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 06:26:00 -0800 (PST)
Message-ID: <d14d2623-6d7c-46fd-865b-c2334439eee8@kernel.dk>
Date: Fri, 7 Mar 2025 07:25:59 -0700
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
Subject: [GIT PULL] Block fixes for 6.14-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of block fixes that should go into the 6.14-rc6 kernel release. This
pull request contains:

- NVMe pull request via Keith
	- TCP use after free fix on polling (Sagi)
	- Controller memory buffer cleanup fixes (Icenowy)
	- Free leaking requests on bad user passthrough commands (Keith)
	- TCP error message fix (Maurizio)
	- TCP corruption fix on partial PDU (Maurizio)
	- TCP memory ordering fix for weakly ordered archs (Meir)
	- Type coercion fix on message error for TCP (Dan)

- Name the RQF flags enum, fixing issues with anon enums and BPF import
  of it.

- ublk parameter setting fix.

- GPT partition 7-bit conversion fix.

Please pull!


The following changes since commit b654f7a51ffb386131de42aa98ed831f8c126546:

  block: fix 'kmem_cache of name 'bio-108' already exists' (2025-02-28 07:06:42 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.14-20250306

for you to fetch changes up to e7112524e5e885181cc5ae4d258f33b9dbe0b907:

  block: Name the RQF flags enum (2025-03-06 17:50:55 -0700)

----------------------------------------------------------------
block-6.14-20250306

----------------------------------------------------------------
Breno Leitao (1):
      block: Name the RQF flags enum

Dan Carpenter (1):
      nvme-tcp: fix signedness bug in nvme_tcp_init_connection()

Icenowy Zheng (2):
      nvme-pci: clean up CMBMSC when registering CMB fails
      nvme-pci: skip CMB blocks incompatible with PCI P2P DMA

Jens Axboe (1):
      Merge tag 'nvme-6.14-2025-03-05' of git://git.infradead.org/nvme into block-6.14

Keith Busch (1):
      nvme-ioctl: fix leaked requests on mapping error

Maurizio Lombardi (3):
      nvmet: remove old function prototype
      nvme-tcp: Fix a C2HTermReq error message
      nvme-tcp: fix potential memory corruption in nvme_tcp_recv_pdu()

Meir Elisha (1):
      nvmet-tcp: Fix a possible sporadic response drops in weakly ordered arch

Olivier Gayot (1):
      block: fix conversion of GPT partition name to 7-bit

Sagi Grimberg (1):
      nvme-tcp: fix possible UAF in nvme_tcp_poll

Uday Shankar (1):
      ublk: set_params: properly check if parameters can be applied

 block/partitions/efi.c      |  2 +-
 drivers/block/ublk_drv.c    |  7 +++++--
 drivers/nvme/host/ioctl.c   | 12 ++++++++----
 drivers/nvme/host/pci.c     | 21 +++++++++++++--------
 drivers/nvme/host/tcp.c     | 45 ++++++++++++++++++++++++++++++++++++---------
 drivers/nvme/target/nvmet.h |  1 -
 drivers/nvme/target/tcp.c   | 15 +++++++++++----
 include/linux/blk-mq.h      |  2 +-
 8 files changed, 75 insertions(+), 30 deletions(-)

-- 
Jens Axboe

