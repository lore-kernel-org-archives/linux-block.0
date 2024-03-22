Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7C5FDA8
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127355; cv=none; b=T63JVwo31XeW6g4v7mxMdMJ3vM9gnUcSzVblEzJEqQG1bFJl1KeZtlr8blWTsfVcoNTNL1Mqyym2c88IJsit13Q5ELma+LtPLJLC2ZCfWl5HgvgK1MWvSdK65RE/SP37XE9CBR+vn0JIYCBwWdNW6R2XcE9E98GGx+xjVFryfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127355; c=relaxed/simple;
	bh=5Ah7jRJ4r6/H52gSplca+UCBjE4DsbRQYEM2nkK3Kmo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hpEiANDyh6RGQyzWPc6OSW1RiAUbo3kJQRrjSHduVh5QlEj47/DSp4OLDmMSI5k44NJV9klWZPqphHPqtcAM4FEsFwopNgwdj2GPK0/5NZNlQGC8VcQm9OiS2CD5A8ZOJBmUMWD67okYxK9VVICN7R5F3pkKMeyxfo7tSJoa12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bGo8M6eM; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bGo8M6eM"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so39644939f.1
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711127351; x=1711732151; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLSydQEqVPdVgqVpIN5j9BaMxUkbqoWH3WCxEHs6B7Y=;
        b=bGo8M6eMCPoso7AvQImTeo/07n8U40aXWUPkCU8EMoSBQL8VJPXJlhX6HWHiSo++Pu
         HwEoeQ0BNdbu4KEErIAPyeRXziJlRShgTOWbWRxerH0Xk9PGXiDsqTpS1HuvOvKkJxMg
         V5Hg2yy30IFa/Qpdxm1UxtWDrfo5Wot0IpGGeDcYsKsDkxjOVLcoInHj3BiWaF+YjGkG
         UtOjWXLCV5Z+ORuxBpkJl30ebknnbQRyUQ76G+Cy9DENQ2iiNOBBZwEbWmIWBIYe99yB
         tzIUV+m13U/V6FuXtLK/58XbFa0JTSAvPImmB2iXAWJAxEXkLhR01e+JrmnBkeK7C+0f
         Y29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127351; x=1711732151;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YLSydQEqVPdVgqVpIN5j9BaMxUkbqoWH3WCxEHs6B7Y=;
        b=snIXiESaq0fAsDLGH94a+Z7xovRK6QhQXsCon5jB9GP3pW7tdgNvVFRx1KZUi5EKi0
         C0kwpvt5bTT0UCp7kK2JPUE/IMZDAOWOJXzZT/GEDg/nIQ5irEoJKBmY5K25M4FSCnup
         jzHpvaD4E7sZ0+PwkxcHi07dkFR+oh9425U5tSsJh3o/UkL+uvU2q9yu+1C+7YqsWDs7
         foctBsavujqU6w04TYVlz3nIZqSX7AjHb0igGvFYF/lZKKFffN02+hm42x+QYghA6msP
         mYxo+N7RyPiDFEMqHswLJtTZeTyaE4JXdiYbwxDqz8+cgcZLhWiAkRl1U3USNLnCxDJ7
         OYnQ==
X-Gm-Message-State: AOJu0YxCfnAl2jZaYx6mWwp/uMaX7WaD8M3cmTK70pwcCJF8YoCFEfEc
	QtHXJ7dSVfWc7J1miaNMKIYrqoqsLRutWxdPuY/kSfULHUoszVb/dJdUoyCYH1Q=
X-Google-Smtp-Source: AGHT+IGcdgW2fbLyqk3qr5IkMtXkWO89PDYcIgeR9YzwRKf6YDeY20kC9JlqouSnQ6o+u56ZyGCdQQ==
X-Received: by 2002:a05:6602:335a:b0:7d0:32b0:5764 with SMTP id c26-20020a056602335a00b007d032b05764mr119781ioz.0.1711127351621;
        Fri, 22 Mar 2024 10:09:11 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g4-20020a0566380bc400b0047be3be32ebsm606779jad.113.2024.03.22.10.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 10:09:11 -0700 (PDT)
Message-ID: <64206ee9-68fc-4ff4-8b28-a9fd0e09aad5@kernel.dk>
Date: Fri, 22 Mar 2024 11:09:10 -0600
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
Subject: [GIT PULL] Block fixes for 6.9-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Followup fixes for the block area:

- NVMe pull request via Keith
	- Make an informative message less ominous (Keith)
	- Enhanced trace decoding (Guixin)
	- TCP updates (Hannes, Li)
	- Fabrics connect deadlock fix (Chunguang)
	- Platform API migration update (Uwe)
	- A new device quirk (Jiawei)"
- Remove dead assignment in fd (Yufeng)

Please pull!


The following changes since commit 4c4ab8ae416350ce817339f239bdaaf351212f15:

  block: fix mismatched kerneldoc function name (2024-03-14 09:40:47 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.9-20240322

for you to fetch changes up to 07602678091c0096e79f04aea8a148b76eee0d7e:

  Merge tag 'nvme-6.9-2024-03-21' of git://git.infradead.org/nvme into block-6.9 (2024-03-21 13:23:07 -0600)

----------------------------------------------------------------
block-6.9-20240322

----------------------------------------------------------------
Chunguang Xu (1):
      nvme: fix reconnection fail due to reserved tag allocation

Guixin Liu (8):
      nvmet: add tracing of authentication commands
      nvmet: add tracing of zns commands
      nvme: use nvme_disk_is_ns_head helper
      nvme: parse zns command's zsa and zrasf to string
      nvme: add tracing of reservation commands
      nvme: parse format command's lbafu when tracing
      nvme: remove redundant BUILD_BUG_ON check
      nvmet-rdma: remove NVMET_RDMA_REQ_INVALIDATE_RKEY flag

Hannes Reinecke (1):
      nvmet-tcp: do not continue for invalid icreq

Jens Axboe (1):
      Merge tag 'nvme-6.9-2024-03-21' of git://git.infradead.org/nvme into block-6.9

Jiawei Fu (iBug) (1):
      drivers/nvme: Add quirks for device 126f:2262

Keith Busch (1):
      nvme: change shutdown timeout setting message

Li Feng (2):
      nvme-tcp: Export the nvme_tcp_wq to sysfs
      nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq

Uwe Kleine-König (1):
      nvme-apple: Convert to platform remove callback returning void

Yufeng Wang (1):
      floppy: remove duplicated code in redo_fd_request()

 drivers/block/floppy.c      |   1 -
 drivers/nvme/host/apple.c   |   6 +--
 drivers/nvme/host/core.c    |  11 +++--
 drivers/nvme/host/fabrics.h |   7 ---
 drivers/nvme/host/pci.c     |   3 ++
 drivers/nvme/host/pr.c      |   3 +-
 drivers/nvme/host/sysfs.c   |   3 +-
 drivers/nvme/host/tcp.c     |  21 +++++++--
 drivers/nvme/host/trace.c   | 105 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/target/rdma.c  |   8 ++--
 drivers/nvme/target/tcp.c   |   1 +
 drivers/nvme/target/trace.c |  98 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 233 insertions(+), 34 deletions(-)
-- 
Jens Axboe

