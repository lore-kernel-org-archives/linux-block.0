Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779728BABA
	for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868963; cv=none; b=mXEttiDCIqAKalBEM9L9NpJ9IuLNK2lwuNfyge50zQhgRA0Fangt/ox9pUVW1UQCmwOm1ljx5P/kzNrquYpeiLF2c3cOtt5CiJRiNyxxNHUILFwMjaZV+/tw8E5FVjt/bmlqHzcIzlDAiL/uqvbsfK4eiEVam7qpLv/DSuT5/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868963; c=relaxed/simple;
	bh=fPrGcus9ToqMGbJctxK6AdAlu0aG2sUaZdcYe38F168=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NdPzkjvDbahJvZXMfRGye2EC23bjPQqt4oh27eN00GFP0AeFDOxPDKZ3KMsyCrGsJnT7ACWuXXvuloPe0N7Tz5Klov1WefD0H5u6YZCyDO2Hl2KIYWiH5FpPs4QdUe9TrJSwJDSu/SWqJrtWi/WZKLkAMHbXFcfFMExIBdDtsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=S3tLF5Jb; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="S3tLF5Jb"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e974105ab8so1787545ab.1
        for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755868960; x=1756473760; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwOYSNq4BwI97YHWGfFtoIVRox2mUdKf4CZ6j/qpjpo=;
        b=S3tLF5JbT4E1gB6Vx6RsMhUCCazHHHV7cqF7S9lMyb2lGGKgwpU4ozEPoPIsCth0WI
         0Vq+5laliT7GAmWWMO4AXqEEaQ9Y3WxkCad55/MFapF/zkM3mR8FMUikA2WlGDO9YQyb
         p5oPX2Bl20P2y5OlzZH10KjgpnEXSm3Pt03oilO3PrCe0xM383mZ0UBfZl75VJMl6OwJ
         rNJfS3cQ98evJZD7ndKcc4MBmizZQWjH/CM74UBDzXmNP+8rlnT/10iCkhhjbm6VC4hr
         OtgsNIns7IxDUKNLOkWCkVKRJQW8yhTlEqNAjT28H5XFtTWIWG15llpDPSVjmY7dwKim
         1sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868960; x=1756473760;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pwOYSNq4BwI97YHWGfFtoIVRox2mUdKf4CZ6j/qpjpo=;
        b=awV9u+6BSp6F1UPJU7NJeD6pIjMA9FsvytPVwgLvGA4PHcn0mPcrto8br1YiMm970l
         tveP7Qcqiwv61LObR5BsdoxTWRVx/rOCll1TA/KJW1ub3/yuDlAzHlO/Cyob7kC9u07G
         cYtjmaGOStUKqdlu2oMJpEfYmAwVTcjB80PGPl5JKIvjTz2rVWX2s4v5qSrXK+zkTHm1
         BqOopz7Xee+DHBljrHshNFothylhGmPUNCF8fMjvu+UDyvldoUi8lTqXU9GjwWxlJFvM
         T7UHmsNwaQfSSfgaWtN+dRGr+DkC5wh7MidDQtTHakbc1Tc9FHyDHftI7gGaDakFs+WT
         IRjQ==
X-Gm-Message-State: AOJu0Yz396rSCdbyoNAJ6Al/v5kjlsL8oAdllSgxZ+f0L2juZQmzt+6N
	QXh+XCsNVU3l+XFGSkJBYxHmd50bv3sbrVmxuRZd0g9CeucMZ9UInrrpCt6YYhY4olA=
X-Gm-Gg: ASbGnctXKG8Teakw2oGKaHmWe++cR6Xn5XyjNG0oTlSvpO62Bpul/HWksfK9SYmTdrk
	ABFI4EQTVviOWgheWaWDVQaybXvYnt5R7aKdag1xIu2vbQlkzR5F29408pGcPa/0F5XXeoi4TvW
	0lMlxsvPFv/dAjQmg7daD5BcS8p3VJV8e9cWMUDqE44CNB5qzaYB2dKdcAilKg344DCs5jZSwoK
	Cni5sYSYDnt6bJ4A3VK/jS5XQL131V6z75WkH7z+zMNkY6Mp47y07NG/wWxkAEGMMChnwjpt/lW
	rptsZVF8EV78RUQF6+NItqFAF/q+sgSpPoRFDAzOKtZY0O2JEurF8X8VfAU9YcsoyO/znva08XD
	OEV3gWyrLWCSgL+Svuso=
X-Google-Smtp-Source: AGHT+IGyQbFsohXvTREpANEsUsCk3jGpEAAkoFWeOTMnu0PngC3QRVnblHfXL58F0oKyK3MOt9/YVA==
X-Received: by 2002:a05:6e02:1807:b0:3e9:e1fd:2fa with SMTP id e9e14a558f8ab-3e9e1fd23efmr13523675ab.30.1755868960401;
        Fri, 22 Aug 2025 06:22:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f83eb6dsm916445939f.9.2025.08.22.06.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 06:22:39 -0700 (PDT)
Message-ID: <4761fdaa-c939-4150-9189-bb14ffbe6978@kernel.dk>
Date: Fri, 22 Aug 2025 07:22:38 -0600
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
Subject: [GIT PULL] Block fixes for 6.17-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into this tree. A bit larger than
I usually have at this point in time, a lot of that is the continued
fixing of the lockdep annotation for queue freezing that we recently
added, which has highlighted a number of little issues here and there.
This pull request contains:

- MD pull request via Yu
	- Add a legacy_async_del_gendisk mode, to prevent a user tools
	  regression. New user tools releases will not use such a mode,
	  the old release with a new kernel now will have warning about
	  deprecated behavior, and we prepare to remove this legacy mode
	  after about a year later.
	- The rename in kernel causing user tools build failure, revert
	  the rename in mdp_superblock_s.
	- Fix a regression that interrupted resync can be shown as
	  recover from mdstat or sysfs.

- Improve file size detection for loop, particularly for networked file
  systems, by using getattr to get the size rather than the cached inode
  size.

- Hotplug CPU lock vs queue freeze fix

- Lockdep fix while updating the number of hardware queues

- Fix stacking for PI devices

- Silence bio_check_eod() for the known case of device removal where the
  size is truncated to 0 sectors.

Please pull!


The following changes since commit 8f5845e0743bf3512b71b3cb8afe06c192d6acc4:

  block: restore default wbt enablement (2025-08-13 05:33:48 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.17-20250822

for you to fetch changes up to 370ac285f23aecae40600851fb4a1a9e75e50973:

  block: avoid cpu_hotplug_lock depedency on freeze_lock (2025-08-21 07:11:11 -0600)

----------------------------------------------------------------
block-6.17-20250822

----------------------------------------------------------------
Akhilesh Patil (1):
      selftests: ublk: Use ARRAY_SIZE() macro to improve code

Christoph Hellwig (3):
      block: handle pi_tuple_size in queue_limits_stack_integrity
      block: remove newlines from the warnings in blk_validate_integrity_limits
      block: tone down bio_check_eod

Jens Axboe (1):
      Merge tag 'md-6.17-20250819' of gitolite.kernel.org:pub/scm/linux/kernel/git/mdraid/linux into block-6.17

Ming Lei (1):
      blk-mq: fix lockdep warning in __blk_mq_update_nr_hw_queues

Nilay Shroff (3):
      block: skip q->rq_qos check in rq_qos_done_bio()
      block: decrement block_rq_qos static key in rq_qos_del()
      block: avoid cpu_hotplug_lock depedency on freeze_lock

Rajeev Mishra (2):
      loop: Consolidate size calculation logic into lo_calculate_size()
      loop: use vfs_getattr_nosec for accurate file size

Xiao Ni (2):
      md: add legacy_async_del_gendisk mode
      md: keep recovery_cp in mdp_superblock_s

Zheng Qixing (2):
      md: add helper rdev_needs_recovery()
      md: fix sync_action incorrect display during resync

 block/blk-core.c                     |   2 +-
 block/blk-mq-debugfs.c               |   1 +
 block/blk-mq.c                       |  13 ++--
 block/blk-rq-qos.c                   |   8 +--
 block/blk-rq-qos.h                   |  48 +++++++++-----
 block/blk-settings.c                 |  12 ++--
 drivers/block/loop.c                 |  39 +++++------
 drivers/md/md.c                      | 122 ++++++++++++++++++++++++++---------
 include/linux/blkdev.h               |   1 +
 include/uapi/linux/raid/md_p.h       |   2 +-
 tools/testing/selftests/ublk/kublk.c |   4 +-
 11 files changed, 169 insertions(+), 83 deletions(-)

-- 
Jens Axboe

