Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1AD53E15
	for <linux-block@vger.kernel.org>; Sat, 10 Feb 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707574614; cv=none; b=gZdbR8Tqa7ZdxunOB9QMWNlupsf1pzf4LZhuxtgOSG+ZK4BjMJ6zFFgq7tJk2n1gpWfB+uq8KSKpEUGNpNhe+Rfius+OMfUOvdVbFHcJm5JI/okWcFG7ELmkaJ3XbwQiUGbaQec42vI2Erw/3Y6IoLwHvyCRpAzfhxv/XjiQXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707574614; c=relaxed/simple;
	bh=RxN/jrzPvpvK7pnBKJYoymqpTIOW17FMLADQ3sNNdFs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EzWTun1J/r1dE4LfPByDiHn6n5PiyHILxzwKc/sqqfZ50d6aynG6MutZZ6r/SYXyJXaM7bzqdqWMsLeXM5UxGSJCPaC1k0F6V3g+fZs7R4UYO9YwlmytIt+h6bwwXLk5rrtX5QkZzjlbIcdfqqYGIuY9yZr0JxA8Q8BO18VibRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QDtOGQcj; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QDtOGQcj"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dc13b142ffso484294a12.1
        for <linux-block@vger.kernel.org>; Sat, 10 Feb 2024 06:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707574609; x=1708179409; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkB+rVb7G2AUbhRtwhtlDj7UV/gckJb0MioYTusj0M4=;
        b=QDtOGQcjbqRtQyVhtpRdV3e69oIaf+AT96CffzuQKrQagfHtAG2U/f+JyM8PY6PWzf
         OX3BXYHSFhPeX6hANek62ngGNHP06e9KOG95ZBpWLOXv8hE1MJXyW/7Sw/xpHr7Hnx8W
         V4+PtzA2oPrCyFTBjrS1NITQnkyVx32CEL0/A6VjF8gWLkoao6HEP5srwV26qv0vTQCl
         Koixm7rqdE4tew977KMWACVt8qN/J7efutlM5DqyuLMA6Bgw7iCXxo+19WrhqM6HEprz
         hAPLjUsHl58gGJE0g9eC87baWJ/4fMpHOqYoXyFFB9FSIG68KV2Xfgg3Y+WQYBxm3W0y
         5Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707574609; x=1708179409;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vkB+rVb7G2AUbhRtwhtlDj7UV/gckJb0MioYTusj0M4=;
        b=jZJcZE6haNb8So6bZ4R4kBOCB08MN9CV/ga/+sRyi7swwR15MWyEgxzHKI4FMbZOLt
         hkzAjpntlgJG+6zn1Or9fG/pckPxxLcBpXZZ6YbUCtf8MQ8R0t0vWF0RLVydVXRvdOzb
         +TPT6BnJv71Lwixh/d9xLfA8t3DM7JcllRJl9/p46Lbxi07B+X5bJGe0GcvwctV0U+jc
         nQivbfvdGlTfsfS4ET2XPZwqf8Sod7NdH2ZDD+NyBoN6z5m4YISF5jw+Ulw6HQaqscPH
         ZBl2V6E+uGOOzWyejCjMINSijIBWsoVKEp2dTXfak2eLtmwIn3DAvaOCtythDup/2vnE
         lh/A==
X-Gm-Message-State: AOJu0Ywx4loL3Z+Yvu/meZ4f2SlSvge+4lbpipjlaJwvrkUHz0d083my
	nG4LjaklBIMKezWiPY+yb31DL5rcUqPKhYwhNduwU7fvfw/Z0KcuMK6h8rfiwR0BBNTyrlFGnGg
	+4GM=
X-Google-Smtp-Source: AGHT+IH51KS5KLOpxHqpyFY9ohCam4rLd/tQtXQrO/yXzAa0RkAAD9J/CweylOsCDB3xJ1RUhACwiQ==
X-Received: by 2002:a17:90a:7405:b0:296:e093:c263 with SMTP id a5-20020a17090a740500b00296e093c263mr1538226pjg.4.1707574609118;
        Sat, 10 Feb 2024 06:16:49 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id pv6-20020a17090b3c8600b002971592bbe7sm1598594pjb.3.2024.02.10.06.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 06:16:48 -0800 (PST)
Message-ID: <d020ae53-c231-4a8b-ac6e-b7ca9788073c@kernel.dk>
Date: Sat, 10 Feb 2024 07:16:47 -0700
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
Subject: [GIT PULL] Block fixes for 6.8-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Block fixes that should go into the 6.8 kernel release:

- NVMe pull request via Keith
	- Update a potentially stale firmware attribute (Maurizio)
	- Fixes for the recent verbose error logging (Keith, Chaitanya)
	- Protection information payload size fix for passthrough
	  (Francis)

- Fix for a queue freezing issue in virtblk (Yi)

- blk-iocost underflow fix (Tejun)

- blk-wbt task detection fix (Jan)

Please pull!


The following changes since commit f3c89983cb4fc00be64eb0d5cbcfcdf2cacb965e:

  block: Fix where bio IO priority gets set (2024-02-01 11:00:06 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.8-2024-02-10

for you to fetch changes up to 5f63a493b99c848ad5200402bebe26211e00025a:

  Merge tag 'nvme-6.8-2023-02-08' of git://git.infradead.org/nvme into block-6.8 (2024-02-08 15:05:18 -0700)

----------------------------------------------------------------
block-6.8-2024-02-10

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: fix comment to reflect right functions

Francis Pravin (1):
      nvme: use ns->head->pi_size instead of t10_pi_tuple structure size

Jan Kara (1):
      blk-wbt: Fix detection of dirty-throttled tasks

Jens Axboe (1):
      Merge tag 'nvme-6.8-2023-02-08' of git://git.infradead.org/nvme into block-6.8

Keith Busch (1):
      nvme: move passthrough logging attribute to head

Maurizio Lombardi (1):
      nvme-host: fix the updating of the firmware version

Tejun Heo (1):
      blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Yi Sun (1):
      virtio-blk: Ensure no requests in virtqueues before deleting vqs.

 block/blk-iocost.c               |  7 +++++++
 block/blk-wbt.c                  |  4 ++--
 drivers/block/virtio_blk.c       |  7 ++++---
 drivers/nvme/host/core.c         | 14 ++++++++------
 drivers/nvme/host/ioctl.c        |  2 +-
 drivers/nvme/host/nvme.h         |  2 +-
 drivers/nvme/host/sysfs.c        | 30 +++++++++++++++---------------
 include/linux/backing-dev-defs.h |  7 +++++--
 mm/backing-dev.c                 |  2 +-
 mm/page-writeback.c              |  2 +-
 10 files changed, 45 insertions(+), 32 deletions(-)

-- 
Jens Axboe

