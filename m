Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522CC15573A
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735934745; cv=none; b=opGo9GGGQ0MvmvUz37aDvA7kHY1EGKe+DUkPoQNjHdvuFeAd2CFSxpgLKNSVTfZ/sxUpwtKXxxNOeUWPPycpzDGrK6O0Jo3MkiRJFhHjilbbrOtb831+OXOhH6Z+bfvxFNgzuTwcL6vh8iwLnwR6JjJ/z/p8YCnaa1bJmrzuXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735934745; c=relaxed/simple;
	bh=8nx8S0XaPAkLYOOX+vUENmL7DlOKOLpT3jMT0zOZgsc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EkK0E9ePX7Pz4ekJ19tbrDa8MXutssLgWmV5X1bbEqdqufcxdtcrpViy8eZFhQs3GWxVf0/VAeiBMZf80gr04RnW0y9IEyDY9JaHIlfl2m5A6yadsWEUT+fWdtX8HmuK5nqbAyQ4nlyRwsaVdc7Ff2kkNHa/ubJWgbWhuwAOuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OdHfWSa5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OdHfWSa5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2efb17478adso17518343a91.1
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2025 12:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1735934742; x=1736539542; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkEkxdNaTF8UA/tEnjww1GQm3iEHZmnaLVI8ddAhuDA=;
        b=OdHfWSa5D0Kf0JDKI7PLgPietmK2vm8EHq+lqj8gU4StPomKJmmk1bo5WAWWVDHrIh
         fIHN17h1aPytsE8iaKTTRMckxiX8r5AGuqFxUyGAncLjB1zgz5deZ5KU/slhUmJZDIvL
         x0MkzygabgGjPvPzFSf+Va1Ve+RIrJPvy/xx6P0CSqjOPREw36Ff3zOviYSj61IVagEo
         TdCbthYoe9sxhQnmX0L3Gd2Yc9Sc2MdMvGyuDb+GWAGMfc178VlZVs4b9jL16qKyB4KX
         KKKOUKNTJN1BxVXjVLSTLKxx3pN1AL097EWhoPLc+6kcYzdGtZYxtJZB8vwYkQegEpSY
         Befg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735934742; x=1736539542;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rkEkxdNaTF8UA/tEnjww1GQm3iEHZmnaLVI8ddAhuDA=;
        b=biokO/cphl+wSgoG+bEgcJIk8K+zknvv+6qcGuw3nBK0HvQaBwMKRen1+bG8JKFV12
         ozd1gZjpFRT0P3RjngYF8MFWSr+w7xDLbQmpVjml23wC7YutZjyX/Vp1icov2fj3VHuT
         sL7O0V9B/Vfwkjq0b0C1MH39xtpNNtOnUIcGKf3qxKA+aSFntVoTXfK4lWfvXxE2S0CV
         qZI78rDJRfBPhxGwtivY5xH/HHJEdn8oFvvvTdvsKUOvYNkmHQuoGPt+4+1Ygf/NUj85
         xE9KEGf0GRKkkY5Hi8mbTVQGa2P/IFax8kmRRaaMGYMOsXjVRja9L1/a9A/80LND+PXZ
         ZdBA==
X-Gm-Message-State: AOJu0YyP28G8emYOi4kbLXwZyALEYA/8IWojAFi2y0YbCtdw4n9EMbf0
	V8fEynUGNn6PzTfcLdLoO+5cDMaG5bVhQB9jbNXqXHurPNMY9M1g5HzidWZHPEz6VQjKLvGULPA
	W
X-Gm-Gg: ASbGncuamndNidl24WF11Dm77NWzGTxHvA7g4ld34JswyW4aK/18h8rw+E+kfF6sy2k
	R0fzYmy7mLBlaXbWpXk5GG9eA1M2Fb3Wu9wzmwORemfvfnWmSGbn+aUqMe/ESy9iFujqdklu+8Z
	AMkwuYC/ysxr5tq4pWGaeLKFmWoDcEBzcU98Fo7PF24I24RiSO57A7XdccWm+QURJ8H7VdvmeKZ
	tv9ctMKaoFZ5zYOqUPj9d6H8beQBtRKutuR+O9ohRW4m1hh+8NXBg==
X-Google-Smtp-Source: AGHT+IHe3uRRF2adD+/S9magHFQStvkgyF7CbbkPIVnjOILrHVvfQULtzzy9QD4dgo8TG7BQUJNcmQ==
X-Received: by 2002:a17:90a:e187:b0:2ee:8430:b847 with SMTP id 98e67ed59e1d1-2f452dfcd26mr70459704a91.6.1735934742655;
        Fri, 03 Jan 2025 12:05:42 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26fc22sm30781193a91.51.2025.01.03.12.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 12:05:42 -0800 (PST)
Message-ID: <4aec2afc-01c5-4e58-baf4-c9ba9dcb29b9@kernel.dk>
Date: Fri, 3 Jan 2025 13:05:41 -0700
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
Subject: [GIT PULL] Block fixes for 6.13-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Collection of fixes for block that should go into the 6.13-rc6 kernel
release. Particularly the target name overflow has been a bit annoying,
as it results in overwriting random memory and hence shows up as
triggering various other bugs. This pull request contains:

- NVMe pull request via Keith
	- Fix device specific quirk for PRP list alignment (Robert)
	- Fix target name overflow (Leo)
	- Fix target write granularity (Luis)
	- Fix target sleeping in atomic context (Nilay)
	- Remove unnecessary tcp queue teardown (Chunguang)

- Simple cdrom typo fix

Please pull!


The following changes since commit 75cd4005da5492129917a4a4ee45e81660556104:

  ublk: detach gendisk from ublk device if add_disk() fails (2024-12-26 06:42:55 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.13-20250103

for you to fetch changes up to cc0331e29fce4c3c2eaedeb7029360be6ed1185c:

  Merge tag 'nvme-6.13-2024-12-31' of git://git.infradead.org/nvme into block-6.13 (2024-12-31 10:41:58 -0700)

----------------------------------------------------------------
block-6.13-20250103

----------------------------------------------------------------
Chunguang.xu (1):
      nvme-tcp: remove nvme_tcp_destroy_io_queues()

Jens Axboe (1):
      Merge tag 'nvme-6.13-2024-12-31' of git://git.infradead.org/nvme into block-6.13

Leo Stone (1):
      nvmet: Don't overflow subsysnqn

Luis Chamberlain (1):
      nvmet: propagate npwg topology

Nilay Shroff (1):
      nvmet-loop: avoid using mutex in IO hotpath

Robert Beckett (1):
      nvme-pci: 512 byte aligned dma pool segment quirk

Steven Davis (1):
      cdrom: Fix typo, 'devicen' to 'device'

 drivers/cdrom/cdrom.c             |   2 +-
 drivers/nvme/host/nvme.h          |   5 ++
 drivers/nvme/host/pci.c           |   9 +++-
 drivers/nvme/host/tcp.c           |  18 +++----
 drivers/nvme/target/admin-cmd.c   |   9 ++--
 drivers/nvme/target/configfs.c    |  23 ++++----
 drivers/nvme/target/core.c        | 108 ++++++++++++++++++++++----------------
 drivers/nvme/target/io-cmd-bdev.c |   2 +-
 drivers/nvme/target/nvmet.h       |   7 +++
 drivers/nvme/target/pr.c          |   8 +--
 10 files changed, 109 insertions(+), 82 deletions(-)

-- 
Jens Axboe

