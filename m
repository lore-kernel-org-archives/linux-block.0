Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB519539F
	for <linux-block@vger.kernel.org>; Fri, 19 Dec 2025 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766116039; cv=none; b=Jvy7hbBh/iqPX7m1jl91wswE6p0kwsbuUpf+ux5PRVFdlf7amEAmx2Yzz0sfTszAFwd2SadlRe8U8ZacVqCs3wGgQ4BX1zwAGSLClU9Zv+iZGtydClcKrmm9TK6X8TSZ+qiwGUsR8Jojs5r23AAcWIbcpVcFnY1YHzkU41Z08F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766116039; c=relaxed/simple;
	bh=dS3tOLOlGIRL0SLC0gVxQnIpNdn4aUmrmoNM6oGU4pg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=KVL2S1RZfpZaoSTuWwIgmnkZHGpuMsJBVQfBfLLDwiQllb/Q4zRIftMn5kiORXTpS3hl4eORzs8Mnw+H8F0SPKFheGSJfte2h/Wzh8uKf3rmbYFwEuReOf7tzVL1dgVqvbrzZlP5zDmntsiIR0Lmh7Q8KGmfmSUqIXtgA9rrFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=udKWUllO; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="udKWUllO"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c75dd36b1bso978601a34.2
        for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 19:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766116035; x=1766720835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uegVhfQnnU1cX8sexYFclXHfDotWyZxghUCchPhacU8=;
        b=udKWUllOQ4LBOjDg8GtwXEl7f/MGGhd4q+kkDcBMbdsugRV1K0aHh+nwbvqH3SNjAT
         z7rCzvc9midzbDnbOOOqv/VsQsvrx4lcy5JYZKwG/aebRQnfymEpPW0THsRFdqH5Azog
         W7WxkWmlFtZ15XQ1ePDA6Mu+10AYE283mpGaGujultQgy3zyxF7/4GCeAf+ozV1USM8X
         J9tsBy8nQQ01QCmOzm/bTeyK2N0nMFNd6Hszh7aOjFD4EYo/l029VDfbmNDzgLM9fWmC
         ObCiudlQ9XyVSw7K5aCipJtqjUM3uh0K5ZncZVoGvfGJin3nBZcROeyOn0aXDwiPs0h7
         Zjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766116035; x=1766720835;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uegVhfQnnU1cX8sexYFclXHfDotWyZxghUCchPhacU8=;
        b=JFzpBJB+eWEOsuthm56aiTSsSZOBX4uoP5egWkmHqL52ATdzACCkgxwvRz+C0r5X0K
         ZzhfOuni/OPG/lQGJIQy2ABi1wgbRdqR8fGAuptptbVZ+Ci0e4GvS5zqhpNkHDuE7zma
         BOuAeQkg1GzxYP37U76hW/m7uZMPafM35zNXDodEEVpJBikbpKM4hL2waMLvVnw+oQzD
         BnoAuGabKOJJhikffiKlavua2ZD375E+n24aJx2Hq9GrhYvoKTpyR/WrCW592hARnnTy
         bUEvQGmO+WpuWmuV3+ftCsSV4h2ps/gCybsRpZx5b3l1/LECxMVykL5efRbCwjx/HPNd
         8O3w==
X-Gm-Message-State: AOJu0YzDf7NgGlVu8a2LHq2uXx8Z/ok8JVrANKzbhYfEsZ61c6kvNxdr
	XxUO5Kkyvo1jD/VlLZXDOC5BH7ydcdCA9aWdWDEDeIipPTe5izNDMVKQhOAnKLB92Ts=
X-Gm-Gg: AY/fxX4um6GhrBpmtOHbaqeTqPpDxB/DasHhmJLG5W3Vy+wvDgJ6AgrWdv5a51cG/5k
	oKpQKkI9PAMlrrxmclwtM77txlhmUskFY+ME9xx5/tx3jlGtzTRnpqP8nppUQcTT9f9p30h/zBl
	tkxucMPCwhYyOV/qnOnPJfe7mhoo6NVMVC9PGn4HbEMj02hG5elnDZkEGqO0zG4xihAL0QX+iQJ
	n0mBFgK63OFMKZqoDpnv5PZsGa9aPKNERI+bOw4ZGP/Om2D9Qb58rOQB+ZvrrSY6hurAf5kpizW
	JD5w+PWXr1DJNJS/2cUdRZBisu0mnaJlZ4DZ/1UxV1l6uSnjUA/9vGf5n1U8AisshWGef08+4j4
	+JfssIiQLu48dM2kbLMdrM/KOCJNc1T4lPPalft05NSLAhxXv9y99iSHWShEun1cXx3kf2qawGb
	5CWcBzRQk=
X-Google-Smtp-Source: AGHT+IE3oDb55R6z+36AX8gk4f9nyuj2+fHxS6OL4LBw0hYxd/vKrlBhcgaGLMcCgH73ggOawstKEQ==
X-Received: by 2002:a05:6830:4c0c:b0:7c7:6626:b586 with SMTP id 46e09a7af769-7cc66acdb9dmr849035a34.25.1766116035410;
        Thu, 18 Dec 2025 19:47:15 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc6680e5bfsm994070a34.31.2025.12.18.19.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 19:47:14 -0800 (PST)
Message-ID: <32fe4659-1347-4bee-9628-1dd1ce3b1987@kernel.dk>
Date: Thu, 18 Dec 2025 20:47:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.19-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into the 6.19 kernel release. This
pull request contains:

- Set of ublk selftests for missing coverage.

- Two fixes for the block integrity code.

- Fix for the newly added newly added PR read keys ioctl, limiting the
  memory that can be allocated.

- Work around for a deadlock that can occur with ublk, where partition
  scanning ends up recursing back into file closure, which needs the
  same mutex grabbed. Not the prettiest thing in the world, but an
  acceptable work-around until we can eliminate the reliance on
  disk->open_mutex for this.

- Fix for a race between enabling writeback throttling and new IO
  submissions.

- Moving a bit of bio flag handling code. No changes, but needed for
  a patchset for a future kernel.

- Fix for an init time id leak failure in rnbd.

- loop/zloop state check fix.

Please pull!


The following changes since commit a0750fae73c55112ea11a4867bee40f11e679405:

  blk-mq-dma: always initialize dma state (2025-12-10 13:41:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251218

for you to fetch changes up to af65faf34f6e9919bdd2912770d25d2a73cbcc7c:

  block: validate interval_exp integrity limit (2025-12-18 09:51:49 -0700)

----------------------------------------------------------------
block-6.19-20251218

----------------------------------------------------------------
Caleb Sander Mateos (10):
      selftests: ublk: correct last_rw map type in seq_io.bt
      selftests: ublk: remove unused ios map in seq_io.bt
      selftests: ublk: fix fio arguments in run_io_and_recover()
      selftests: ublk: use auto_zc for PER_IO_DAEMON tests in stress_04
      selftests: ublk: don't share backing files between ublk servers
      selftests: ublk: forbid multiple data copy modes
      selftests: ublk: add support for user copy to kublk
      selftests: ublk: add user copy test cases
      block: validate pi_offset integrity limit
      block: validate interval_exp integrity limit

Deepanshu Kartikey (1):
      block: add allocation size check in blkdev_pr_read_keys()

Ming Lei (3):
      selftests: ublk: fix overflow in ublk_queue_auto_zc_fallback()
      block: fix race between wbt_enable_default and IO submission
      ublk: fix deadlock when reading partition table

Pavel Begunkov (1):
      block: move around bio flagging helpers

Thomas Fourier (1):
      block: rnbd-clt: Fix leaked ID in init_dev()

Yongpeng Yang (3):
      loop: use READ_ONCE() to read lo->lo_state without locking
      zloop: use READ_ONCE() to read lo->lo_state in queue_rq path
      Documentation: admin-guide: blockdev: replace zone_capacity with zone_capacity_mb when creating devices

 Documentation/admin-guide/blockdev/zoned_loop.rst |  2 +-
 block/bfq-iosched.c                               |  2 +-
 block/blk-settings.c                              | 14 +++--
 block/blk-sysfs.c                                 |  2 +-
 block/blk-wbt.c                                   | 20 +++++--
 block/blk-wbt.h                                   |  5 ++
 block/elevator.c                                  |  4 --
 block/elevator.h                                  |  1 -
 block/ioctl.c                                     |  9 ++--
 drivers/block/loop.c                              | 22 ++++----
 drivers/block/rnbd/rnbd-clt.c                     | 13 +++--
 drivers/block/ublk_drv.c                          | 32 ++++++++++--
 drivers/block/zloop.c                             |  8 +--
 include/linux/bio.h                               | 30 +++++------
 include/uapi/linux/pr.h                           |  2 +
 tools/testing/selftests/ublk/Makefile             |  8 +++
 tools/testing/selftests/ublk/file_backed.c        |  7 +--
 tools/testing/selftests/ublk/kublk.c              | 64 ++++++++++++++++++++---
 tools/testing/selftests/ublk/kublk.h              | 23 +++++---
 tools/testing/selftests/ublk/stripe.c             |  2 +-
 tools/testing/selftests/ublk/test_common.sh       |  5 +-
 tools/testing/selftests/ublk/test_generic_04.sh   |  2 +-
 tools/testing/selftests/ublk/test_generic_05.sh   |  2 +-
 tools/testing/selftests/ublk/test_generic_11.sh   |  2 +-
 tools/testing/selftests/ublk/test_generic_14.sh   | 40 ++++++++++++++
 tools/testing/selftests/ublk/test_loop_06.sh      | 25 +++++++++
 tools/testing/selftests/ublk/test_loop_07.sh      | 21 ++++++++
 tools/testing/selftests/ublk/test_null_03.sh      | 24 +++++++++
 tools/testing/selftests/ublk/test_stress_04.sh    | 12 +++--
 tools/testing/selftests/ublk/test_stress_05.sh    | 10 ++--
 tools/testing/selftests/ublk/test_stress_06.sh    | 39 ++++++++++++++
 tools/testing/selftests/ublk/test_stress_07.sh    | 39 ++++++++++++++
 tools/testing/selftests/ublk/test_stripe_05.sh    | 26 +++++++++
 tools/testing/selftests/ublk/test_stripe_06.sh    | 21 ++++++++
 tools/testing/selftests/ublk/trace/seq_io.bt      |  3 +-
 35 files changed, 450 insertions(+), 91 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_07.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_06.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_07.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_05.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_06.sh

-- 
Jens Axboe

