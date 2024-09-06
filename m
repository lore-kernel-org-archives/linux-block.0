Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB71C9ED9
	for <linux-block@vger.kernel.org>; Fri,  6 Sep 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629463; cv=none; b=Y1qYU+ngsEdVUwMAhqrJslnPAzrINdzzt/xRIA9yZ8WLWhvUeS5yhfke2KdFNBUctxFdc9qArodkOMJ1iSiYHxcpn21WNEsebuTLNlWEueXilxxaMYS+JXxQCjIDZmG7heRtMa0fREEhZTceYC43b6Jk0pzh69SKMYv91Xa3MzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629463; c=relaxed/simple;
	bh=ISShPFdbWdnbbODRfOAk9mEWgE1TWDKP5qxBL+fjn4k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=O5vRRbswmMGbN8rv67Y3Ff1ISbD6EcQfDfsbfDbkLKx70OU0Q3RKsGRswqu5eSyMwKZKcw3sJ/HNov9A8hT+NwHSK46avBCv1abwwPHr3O0k3XvjHLYM+SxeNpYLSMWNZ0YUQnlVshI2TyUDVI+7AMiQIjRsnnujPgehtDGpMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Se/FUBXZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Se/FUBXZ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so1505562a12.1
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2024 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725629458; x=1726234258; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9ZOsfShkSTEJgmu7wPAO+Yvcxucqv3wdpdP/jZ9lsY=;
        b=Se/FUBXZCCoT67CYas9SgJzwlX/jVr21MwfcmEGMONpr4XEiGgbZFKP7fQbCUqj8ci
         NV7QvquRLvfYnrddMn8SDpI/37zxfMs8mSIaRrSTdjhhMuBu5g4zE4+JQlCEHAljpFVX
         4agRbObgUFFH7dCbAZWKMUAHpL7HAVH/6jX3/8afK9HBvV4dHQttJJtv7UWUKBJqdOtd
         M9aaeIRQee+BpDlE5aTBjRbIUTU45yyesQBvWKCYx3lDsUFwKUN89zVvGf4YyWbwJ40Z
         0ppvQsHNXKhwjouUXBVaJ3KWJT4ojcCMRLL7hc7+WS1WvrUko/C8jsK+OcUv8w0glMte
         foUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629458; x=1726234258;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P9ZOsfShkSTEJgmu7wPAO+Yvcxucqv3wdpdP/jZ9lsY=;
        b=egYeDcTgPavvg3v4PNWyzy7dml5inmzY/1mKYdK+wWJnx0Wy5pk1CBdp8bD04NfXCL
         KI+h11X62+dNJW1QNu7TBCKzixaQEx35kTbFwHvhHAtCy3E87ky9FVGbPbF51ZiJERVb
         uij9v+SF9YvtOKkcc8QBEyalhdQAhdz64ptqyVudU3YSmISH/oOIxtaYmR/dUGIs1fBC
         NhfVB+kFjIxL0u9UrkpzykorVAq3tnCGGKv/Okx1BNC9AAAEcuFERKHnjfsZeZJSdOEo
         B7zqJcGgsUDkqiXfwUluErqi0SC07758dPq69K8+lj39FfF78mVrUWY3KGuwQHVNH4h8
         XDzg==
X-Gm-Message-State: AOJu0YwnurHV4BBpHQC5y19GNbn064LcAkSal52VGl7xv/SDw1KhhWsc
	bPOsEAcKYgsN7WiT2mLSVsl8nUe+ItMjUqW6ImzpK54572RqJ5C+RWQOxDqlNqT+glTCq4n55Ja
	y
X-Google-Smtp-Source: AGHT+IGvFLj9tHZtMQvoYb9pxKz3m70Ab4i2Ricrk8djZwiv4VqMOXwFd7TX06wax8WvpJZngzZhqg==
X-Received: by 2002:a17:903:192:b0:206:8d6e:d003 with SMTP id d9443c01a7336-206ee9255b4mr41492555ad.4.1725629457817;
        Fri, 06 Sep 2024 06:30:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea5ee23sm43138055ad.241.2024.09.06.06.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 06:30:57 -0700 (PDT)
Message-ID: <e49dcbce-3af6-47b1-96ee-a1046324b152@kernel.dk>
Date: Fri, 6 Sep 2024 07:30:56 -0600
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
Subject: [GIT PULL] Block fixes for 6.11-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Mostly just some fixlets for NVMe, but also a bug fix for the ublk
driver and an integrity fix.

Please pull!


The following changes since commit e33a97a830b230b79a98dbbb4121d4741a2be619:

  block: fix detection of unsupported WRITE SAME in blkdev_issue_write_zeroes (2024-08-28 08:49:25 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.11-20240906

for you to fetch changes up to 4ba032bc71dad8d604d308afffaa16b81816c751:

  Merge tag 'nvme-6.11-2024-09-05' of git://git.infradead.org/nvme into block-6.11 (2024-09-05 08:45:54 -0600)

----------------------------------------------------------------
block-6.11-20240906

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: set BLK_FEAT_ZONED for ZNS multipath disks

Georg Gottleuber (1):
      nvme-pci: Add sleep quirk for Samsung 990 Evo

Jens Axboe (1):
      Merge tag 'nvme-6.11-2024-09-05' of git://git.infradead.org/nvme into block-6.11

Jinjie Ruan (1):
      nvmet: Make nvmet_debugfs static

Keith Busch (2):
      nvme: use better description for async reset reason
      nvme-pci: allocate tagset on reset if necessary

Li Nan (1):
      ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()

Maurizio Lombardi (2):
      nvmet-tcp: fix kernel crash if commands allocation fails
      nvmet: Identify-Active Namespace ID List command should reject invalid nsid

Mikulas Patocka (1):
      bio-integrity: don't restrict the size of integrity metadata

 block/bio-integrity.c           |  4 ----
 drivers/block/ublk_drv.c        |  2 ++
 drivers/nvme/host/core.c        |  3 ++-
 drivers/nvme/host/multipath.c   |  4 +++-
 drivers/nvme/host/pci.c         | 17 +++++++++++++++++
 drivers/nvme/target/admin-cmd.c | 10 ++++++++++
 drivers/nvme/target/debugfs.c   |  2 +-
 drivers/nvme/target/tcp.c       |  4 +++-
 8 files changed, 38 insertions(+), 8 deletions(-)

-- 
Jens Axboe

