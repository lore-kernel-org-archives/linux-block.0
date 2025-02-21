Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205EE1B85FD
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156587; cv=none; b=JPmQ3wGNWQq5wi++jP+YNm1OPlye1wNQLgzlIRIS9VG+YC5U8GvOOo63I8ERsaT66YB9f2nzPyiR1gOV/TIj1zUCzx5VPOG4xxGvVxHwNcnkm0bGG3+25c3hT8P7654Y2Q06B6IRu55TmhuJtpGsBoWOgKkh3XIybCHNg0lo1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156587; c=relaxed/simple;
	bh=3qVUvvU3uMFfHhL17H5Y0zMM8ZIbqeGudZTOFEZYOXE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=INH2R/HncF2BDdG4YdUdXPXhWhjRt//5Bh4J+WsDsxii16A6egIEuFJ3UvlMDay+LeKFmTnhoWTU67iXuQPIDe4X69tNYOlpQcjIgsaFHcab8nY+W2XQTMQ+4wsg6K8LctcO7BnYyuwT3qf1U0C2O2Ow5dSHuw/nqb1DmQPVH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vzgdf7ZY; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vzgdf7ZY"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-855a5aa9604so59119239f.2
        for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740156583; x=1740761383; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQcNjs38YGiutt9tQSexg/tVmDyBoGH0rc3ELambHuo=;
        b=Vzgdf7ZYzKID67Dn+E6yrasoK1PtzwTCnsmFe1zw8zcLzTyttkzNinpxCQyMoSvS8N
         veqpetTf109qkN9cnTboA0E7l/elXvNKYkKO4zkFNpO8HA5H681j4XqdMhvGIA9wmOaT
         uVuzfWpAlscvv41IqUVGl4oIunmIsDGm2Pwbw9tUmg2BQqpqnlr7YhoFmsqPYkW371V8
         97kxLpSNjeK+5r/SqEZfOAxZCnt8LHvGNpWHziJjl+H9//9Q8VEJo5bD6p1RW4tDNP3y
         63GVcfb4bK2h95FQOLQkfxkyHYcBod8UwheQz1Ix8e3/Vh5MSQtC/OQvzYlXKE0edZFx
         +GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156583; x=1740761383;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aQcNjs38YGiutt9tQSexg/tVmDyBoGH0rc3ELambHuo=;
        b=NV5yBqrGkJ1bEQJe17v/xIHHRLC1/oWRbxmSZ/Gy5Jx6ZjD+Fkif3vns8gxY0ebLeg
         qeeN1FryR/cxijR+rADvOxoSxWHnLK+dol50mMyut79eeoOVwyhQXAqKXOUkYWXaUpLp
         ZzbHyDXDE7/UqGmfAH+J3VYeX6jg5riqimbFNCAWtiGFpeUolm+8jrpBeowGiU5MOPVF
         Um8cOwt4COXdSPV3mChSDKIK34rH8TWZWhUcQz3Ci/xeti3UjKjp+pwaTle08rEkxNyv
         KFAK1MimUoQQVUNvSYQRIlCG7oGiy3sGQ2LMAbBPWJhF1ZAOkHQqkQUjVKyHkAg0SO6r
         o4YQ==
X-Gm-Message-State: AOJu0YxISWb+Ra88toD3IOB8yfVid2kIQ7QQh3Xj1Bo4uaCd9/mnNwj8
	UfU4XYOtq/xBIhy0Xz/LQL6NI/B7ONW4KxgSkGzsebcsyq5J2Tb0gLr67nH/TznnsGKjRNT0ObG
	+
X-Gm-Gg: ASbGncsktPlZVbcEnG87/z/S4yMIluZM5DgWSegwJKm1QRxM4SNXvmI0R98kf3KdB/h
	Zffws9lUWRvRoiMFptTsWlLSfz4gUo1b7mswiNLJCoWFnUgvdi99kQ3K7hoSSlP0W6hhaqO7PBG
	KYycfeZPexjYuoTTKNBzNnL5FkF7lO11Ggsk1uZcXWnxCcHckkFhBvcwTr6OPmV6n+U834mID0P
	keUuTnQFLY/k/0sXV/cnAAaBMnWT0QWP11I+/LyZO6Qo+iGs8sQixT+4qXbEIODrq+zCjaeEtEv
	CfmOGIqoF6cG4LvAvDzGnE8=
X-Google-Smtp-Source: AGHT+IGd7E8+Uy/3N3GOQEpPlFtB9R429Zl/AC82Q2y1fZC6QRttbXctrulBP2Ckiko7g7Gyep58jA==
X-Received: by 2002:a05:6602:6004:b0:855:8f17:cd8d with SMTP id ca18e2360f4ac-855dac41ffamr458500839f.14.1740156583118;
        Fri, 21 Feb 2025 08:49:43 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-855b28993b8sm144345739f.9.2025.02.21.08.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 08:49:42 -0800 (PST)
Message-ID: <3f1e6c92-ea9b-4d7c-95b9-9cb72311582f@kernel.dk>
Date: Fri, 21 Feb 2025 09:49:41 -0700
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
Subject: [GIT PULL] Block fixes for 6.14-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into the 6.14 kernel release. This
pull request contains:

- NVMe pull request via Keith
	- FC controller state check fixes (Daniel)
	- PCI Endpoint fixes (Damien)
	- TCP connection failure fixe (Caleb)
	- TCP handling C2HTermReq PDU (Maurizio)
	- RDMA queue state check (Ruozhu)
	- Apple controller fixes (Hector)
	- Target crash on disbaled namespace (Hannes)

- MD pull request via Yu
	- Fix queue limits error handling for raid0, raid1 and raid10.

- Fix for a NULL pointer deref in request data mapping.

- Code cleanup for request merging.

Please pull!


The following changes since commit 80e648042e512d5a767da251d44132553fe04ae0:

  partitions: mac: fix handling of bogus partition table (2025-02-14 08:38:28 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.14-20250221

for you to fetch changes up to 70550442f28eba83b3e659618bba2b64eb91575f:

  Merge tag 'nvme-6.14-2025-02-20' of git://git.infradead.org/nvme into block-6.14 (2025-02-20 17:43:59 -0700)

----------------------------------------------------------------
block-6.14-20250221

----------------------------------------------------------------
Bart Van Assche (1):
      md/raid*: Fix the set_queue_limits implementations

Caleb Sander Mateos (3):
      block/merge: remove unnecessary min() with UINT_MAX
      nvme-tcp: fix connect failure on receiving partial ICResp PDU
      nvme/ioctl: add missing space in err message

Christopher Lentocha (1):
      nvme-pci: quirk Acer FA100 for non-uniqueue identifiers

Damien Le Moal (6):
      nvmet: pci-epf: Correctly initialize CSTS when enabling the controller
      nvmet: pci-epf: Do not uselessly write the CSTS register
      nvmet: pci-epf: Avoid RCU stalls under heavy workload
      nvme: tcp: Fix compilation warning with W=1
      nvme: Cleanup the definition of the controller config register fields
      nvmet: Use enum definitions instead of hardcoded values

Daniel Wagner (2):
      nvme-fc: rely on state transitions to handle connectivity loss
      nvme: only allow entering LIVE from CONNECTING state

Hannes Reinecke (1):
      nvmet: Fix crash when a namespace is disabled

Hector Martin (2):
      apple-nvme: Release power domains when probe fails
      apple-nvme: Support coprocessors left idle

Jens Axboe (2):
      Merge tag 'md-6.14-20250218' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-6.14
      Merge tag 'nvme-6.14-2025-02-20' of git://git.infradead.org/nvme into block-6.14

Maurizio Lombardi (1):
      nvme-tcp: add basic support for the C2HTermReq PDU

Ming Lei (1):
      block: fix NULL pointer dereferenced within __blk_rq_map_sg

Ruozhu Li (1):
      nvmet-rdma: recheck queue state is LIVE in state lock in recv done

 block/blk-merge.c             |  7 +++--
 drivers/md/raid0.c            |  4 +--
 drivers/md/raid1.c            |  4 +--
 drivers/md/raid10.c           |  4 +--
 drivers/nvme/host/apple.c     | 55 ++++++++++++++++++++++++-----------
 drivers/nvme/host/core.c      |  2 --
 drivers/nvme/host/fc.c        | 67 ++++---------------------------------------
 drivers/nvme/host/ioctl.c     |  3 +-
 drivers/nvme/host/pci.c       |  2 ++
 drivers/nvme/host/tcp.c       | 50 ++++++++++++++++++++++++++++++--
 drivers/nvme/target/core.c    | 40 ++++++++++++--------------
 drivers/nvme/target/nvmet.h   | 14 ++++-----
 drivers/nvme/target/pci-epf.c | 39 ++++++++++++++++++-------
 drivers/nvme/target/rdma.c    | 33 ++++++++++++++-------
 include/linux/nvme-tcp.h      |  2 ++
 include/linux/nvme.h          | 40 +++++++++++++++++++++-----
 16 files changed, 216 insertions(+), 150 deletions(-)

-- 
Jens Axboe

