Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A04C6D
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746625; cv=none; b=BB4tpI9ZpCYTPbJM7d6clDZf5vp6zbYyi1GBOMAtbUwB1FPZxTz3ayvRXFhc2xzRbmXXI3llNdirdbvIFu/BF8ARRnThekmb5X7POCAMHcJDDSS4hl9R0OKPmdPUMHPRmYcUoCkRMGA+ZpBDRJ9N+AD4/I0yLFTvhCfw4jmUn4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746625; c=relaxed/simple;
	bh=MSikU1PMU+V/QUKyzwiiAw75Wriw2mH41FxPmVsZA6Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jxKhPt178lnD4sPhwD0u11OSaJJCFvFNnVwpIHXMZyNOfbt/7B0ijgs3LLIAksqNjPYueE15WzXyd4phKJ195QDO3Yo/dkaKGEmeoLbJwzMqcJK95FhwPheblIPU+oFHXXTkEi9slP/znFZIba+j/mPWiDMQRJT3AeyI/u/5M1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Zs879OEi; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Zs879OEi"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7da55194b31so80707239f.3
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714746620; x=1715351420; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u75/tE/E9Lgr5AsxzWrQ/IQ9yZAKTRq3TVG8b1s6jiA=;
        b=Zs879OEiMhuFioF44eCMTLADEBDD3jyk9v/ZgXEQSSpt4WXjOY7CNOlzsOdavvW8D9
         SKBrZSXW+7PUl8RULWTQVUqR7eYyhN/7xDJlbYSTtyW9+8c6knr2DKRiY1HUhr3zms+6
         3vtd7OFwTe3o/GfZGbGUd5xpAq5Vfm35B3Ffpp9Kv3QsQHpla9GIySwwPQk0ivb4iERt
         qPEB5Egg9fnqdHH88KHGe4uFSL9wpJgjaaXjUfovZamzIoJU8JyNNXOicJI2gmgBqOhc
         kceT+1Y8c76VOnao0lJ3G+UHsmpk8i00BmiY9kokRoHFPDprn2oGzdKl6qrEX/A0In/F
         7Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714746620; x=1715351420;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u75/tE/E9Lgr5AsxzWrQ/IQ9yZAKTRq3TVG8b1s6jiA=;
        b=IOepVi4L23Ui7oKR85ptAxkl/GnUWEnF5srvjQfEqHqv7KXZ2/P8ooVdfpC1vkVVdz
         p406UXfMpkVLJD389cTd4qjRHgfhvu91I7xhqArQ9UdIo79kJPOU5FnwJ3VFDFCSDgK0
         Qwm+IK6HOXJdnP6AG42Ve7vEHbsdztbXY392edG4xW+rlwq9M21bmjFK+OL6autYGpf+
         SgTnW9jJe+OBmIPwcu9R9lFOeADyjYxtblheGBxnbr39nBdJhngPKaMBE4PxW8Qcbn9o
         MWFXptkVUsRiRlWdBoLUc2upbd8/O1/LXcMnS/GcW9VXKMg3TjJ6ZBem0Kh/FadMRZIR
         8v3Q==
X-Gm-Message-State: AOJu0YzQOSbDs5qwjDICtq//90ptVdSY8ciUW0aeaK+diupg3ap1M75V
	Ey7TH0KDLLCXvD388LCWngGowf6S3pHWdqfmA9TZB5gXs94YtiSweCEocWD7eDj9900YLgD2+Y+
	l
X-Google-Smtp-Source: AGHT+IFkfRR/Y+SAz9cAdr4v/fRIcQnThKtoRN/vBSJUuAgAMD/z/ezBRLwb94Fj9xcy3spHEr/bDQ==
X-Received: by 2002:a05:6602:2557:b0:7dd:88df:b673 with SMTP id cg23-20020a056602255700b007dd88dfb673mr3125414iob.0.1714746619947;
        Fri, 03 May 2024 07:30:19 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dm2-20020a0566384c0200b00488101433ddsm811877jab.111.2024.05.03.07.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 07:30:19 -0700 (PDT)
Message-ID: <442223dc-d734-4c8e-abf8-1e89e92eb1ec@kernel.dk>
Date: Fri, 3 May 2024 08:30:18 -0600
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
Subject: [GIT PULL] Block fixes for 6.9-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Nothing major in here - an nvme pull request with mostly auth/tcp fixes,
and a single fix for ublk not setting segment count and size limits.

Please pull!


The following changes since commit 01bc4fda9ea0a6b52f12326486f07a4910666cf6:

  blk-iocost: do not WARN if iocg was already offlined (2024-04-19 08:06:24 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.9-20240503

for you to fetch changes up to fb15ffd06115047689d05897510b423f9d144461:

  Merge commit '50abcc179e0c9ca667feb223b26ea406d5c4c556' of git://git.infradead.org/nvme into block-6.9 (2024-05-02 07:22:51 -0600)

----------------------------------------------------------------
block-6.9-20240503

----------------------------------------------------------------
Hannes Reinecke (1):
      nvme-tcp: strict pdu pacing to avoid send stalls on TLS

Jens Axboe (1):
      Merge commit '50abcc179e0c9ca667feb223b26ea406d5c4c556' of git://git.infradead.org/nvme into block-6.9

Maurizio Lombardi (2):
      nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
      nvmet-auth: replace pr_debug() with pr_err() to report an error.

Nilay Shroff (2):
      nvme: find numa distance only if controller has valid numa id
      nvme: cancel pending I/O if nvme controller is in terminal state

Sagi Grimberg (2):
      nvmet-tcp: fix possible memory leak when tearing down a controller
      nvmet: fix nvme status code when namespace is disabled

Uday Shankar (1):
      ublk: remove segment count and size limits

Yi Zhang (1):
      nvme: fix warn output about shared namespaces without CONFIG_NVME_MULTIPATH

 drivers/block/ublk_drv.c       |  3 ++-
 drivers/nvme/host/core.c       | 23 +----------------------
 drivers/nvme/host/multipath.c  |  3 ++-
 drivers/nvme/host/nvme.h       | 21 +++++++++++++++++++++
 drivers/nvme/host/pci.c        |  8 +++++++-
 drivers/nvme/host/tcp.c        | 10 ++++++++--
 drivers/nvme/target/auth.c     |  8 ++++----
 drivers/nvme/target/configfs.c | 13 +++++++++++++
 drivers/nvme/target/core.c     |  5 ++++-
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/tcp.c      | 11 ++++-------
 11 files changed, 67 insertions(+), 39 deletions(-)

-- 
Jens Axboe

