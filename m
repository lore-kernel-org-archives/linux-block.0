Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EFB2E266E
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034339; cv=none; b=djwr4mNP84B1EUUA7GfVe9HMp86NLxfB+RnniQJuxBbGITI4eYsoOGmm/rejTaMojmF8gAWnk+8maftrJdBs7Brniyu+nk0RC6XwQ4HNl9Tn8UukLBqOxD5vM/E33QzzeCN8dHhaQgyrbkcsUwjMIukz2FDNAU0ub4Y2XsOWfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034339; c=relaxed/simple;
	bh=RGhUT7bDXhDas356sizXw+qOMGeZAQh2f9FaHHGncmY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=XdfPGm47ZGaEFR4J/HXw9tkr1GDYi71og+6QxUDtJyCuKae7dnxVANt28nYfPjDqFdz2CsrcdLfNBVk05g6N4WcIuT6GtQ26GlVQ8QjbVZOq0NmIxCVz3tDi/X06NwJvWiTf7VmOdAOZiZAMp634DPSFaNIcovdCSfB6GkO38Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iPZAUTEJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iPZAUTEJ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so2068021b3a.1
        for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751034334; x=1751639134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyJj9qrK/OQrgQwB+r94MAcUkW6fA988OlwYIGZtZCA=;
        b=iPZAUTEJCF1CxiLD89W38R+IWy77jKdPyKMDZa6SfGm5TcZR6uaFAcVw0uTHYYD6iy
         jCItW5yozV3wlV9K9asbKdLBXNAl4/RHHZgf6fW0ePQfS9npEK0Ps5qFCVfoBBUoCmrq
         JbaViGO6KV/nh+pSuDE/V6TkdTVdhmTsRfTX2fL72eih5SeLudUUenEg0iT6GPOjQ96/
         cEDreTyU2DllpHf5X5LcdwNt17Yg/ziQmPqVlki5urTx7SqXuyub4eDgDGpSxYT3Oc1Q
         fg5zDOgeEzE67ZTNmCpiIWu/BwxPy6BImMQHWmQrJDLVznLr31v4F2ZHTFKcrunLNUf5
         r6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751034334; x=1751639134;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eyJj9qrK/OQrgQwB+r94MAcUkW6fA988OlwYIGZtZCA=;
        b=G9lZZjL/vSQEyezIoCDTUWM5zm/XYCK/aS7qenGd6XrMpmFcmbZ8NAu2zKioVgsyfj
         OAgJTrIXIjkvmlgzlJd7QIv9ufGIm/A+fxbl4fkLJf2lDVRMzeJrJciifuW7FksywAax
         Mu0HYF8obOKmZxf3zoDUN6DsANq4dTUKZnfeaRIGO/7+OEtHLF8ExYOrFulDjBzXrFYE
         iPeeYH8XnVXRaMs1ZXJYSvHc1ZEUGDFGnB23gMBqd8tHsi46ggeUnKHUUUx0DEah9Ve6
         qK5nWV2xlhgaOjG1TXKrya2mFE6mtEzp1pmc3nfKZ6cUGHYxnZr3NRlBA0KJioiRPimn
         vycw==
X-Gm-Message-State: AOJu0Yz5JgBOvGOO4Hjh7e1WJDoWgv64nSO6XH79UAqU6Cs1jJ8dBc2g
	e7rJ4H31iXfwZxdB5MjYwxj8g0QwhTW668eTF7YROrCU3pDseIuy7EjyRRI+7stYM2kTcg9QxIG
	vKmIC
X-Gm-Gg: ASbGnctJ0ofhdS1ULDwAE5KqXQF6pWHdUYmU19ZyIcNufm3jRzdl57j5yXvP6I7TzE/
	oxDASILOELVZ766guwe6AZLaibBAaL5beKmbgSHy9ZGTp/HQa6J1vGIXuYhrrEfWHSdTBp3C5wX
	bX6eRcL8GJof09NSDQQctehXHcMU8ROazrzlgArShDXo8cG5RxfrOQVQcOfRctPCXNdX89+evpp
	yMVtH0JRowyy7rLq8eWrlTHpSKKUnWVTkmthmUAa87ntsE7foy1ErRK4qwYX7z0bz9syifvMgsP
	bTnpmit3kzRVDJx2yTLIPCgRsDfCWMdM0pN10L8S2cUKtHw3NxtBv45oQg==
X-Google-Smtp-Source: AGHT+IFmZFfKdTFjEEjnB65+1L91IowJw+MB9b4DoEK2jyJbysGKV++GieLQW8YdtVKDX2sR2qUfYw==
X-Received: by 2002:a05:6a00:9195:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-74ae40c2799mr9642518b3a.9.1751034333767;
        Fri, 27 Jun 2025 07:25:33 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5409a41sm2293256b3a.29.2025.06.27.07.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 07:25:33 -0700 (PDT)
Message-ID: <63eaea99-fa38-4aef-8254-934ec0504067@kernel.dk>
Date: Fri, 27 Jun 2025 08:25:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.16-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here are a set of block fixes that should go into the 6.16 kernel
release. This pull request contains:

- Fixes for ublk
	- Fix C++ narrowing warnings in the uapi header
	- Update/improve UBLK_F_SUPPORT_ZERO_COPY comment in uapi header
	- Fix for the ublk ->queue_rqs() implementation, limiting a
	  batch to just the specific task AND ring
	- ublk_get_data() error handling fix
	- Sanity check more arguments in ublk_ctrl_add_dev()
	- selftest addition

- NVMe pull request via Christoph
	- reset delayed remove_work after reconnect
	- fix atomic write size validation

- Fix for a warning introduced in bdev_count_inflight_rw() in this merge
  window

Please pull!


The following changes since commit 8c8472855884355caf3d8e0c50adf825f83454b2:

  ublk: santizize the arguments from userspace when adding a device (2025-06-19 07:53:24 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.16-20250626

for you to fetch changes up to c007062188d8e402c294117db53a24b2bed2b83f:

  block: fix false warning in bdev_count_inflight_rw() (2025-06-26 07:34:11 -0600)

----------------------------------------------------------------
block-6.16-20250626

----------------------------------------------------------------
Caleb Sander Mateos (2):
      ublk: fix narrowing warnings in UAPI header
      ublk: update UBLK_F_SUPPORT_ZERO_COPY comment in UAPI header

Christoph Hellwig (2):
      nvme: refactor the atomic write unit detection
      nvme: fix atomic write size validation

Jens Axboe (1):
      Merge tag 'nvme-6.16-2025-06-26' of git://git.infradead.org/nvme into block-6.16

Keith Busch (1):
      nvme: reset delayed remove_work after reconnect

Ming Lei (3):
      ublk: build batch from IOs in same io_ring_ctx and io task
      selftests: ublk: don't take same backing file for more than one ublk devices
      ublk: setup ublk_io correctly in case of ublk_get_data() failure

Ronnie Sahlberg (1):
      ublk: sanity check add_dev input for underflow

Yu Kuai (1):
      block: fix false warning in bdev_count_inflight_rw()

 block/genhd.c                                  | 26 ++++----
 drivers/block/ublk_drv.c                       | 49 +++++++++++----
 drivers/nvme/host/core.c                       | 87 +++++++++++++-------------
 drivers/nvme/host/multipath.c                  |  2 +-
 drivers/nvme/host/nvme.h                       |  3 +-
 include/uapi/linux/ublk_cmd.h                  | 32 ++++++++--
 tools/testing/selftests/ublk/test_stress_03.sh |  5 +-
 7 files changed, 125 insertions(+), 79 deletions(-)

-- 
Jens Axboe

