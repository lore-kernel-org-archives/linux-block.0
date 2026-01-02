Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811F21D3C5
	for <linux-block@vger.kernel.org>; Fri,  2 Jan 2026 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767370411; cv=none; b=GTr0DQC96wrgg9wlGojM4yAO+m96ZdouesmMq3+wbERk79mNpXUGquuuAQNDUQ32iHWW/DAmOz47SStPkVr4mkebgXCg3da213R1WwM4ZnTCR9NgIXpEV6pdtn9UItsb9vdIbu3iwnu249imHpcof4vTlGWskf6vI/LwARYUWo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767370411; c=relaxed/simple;
	bh=/0j4jTV5e7W5aKdrlQjLfPLFnioIKMNWkikqICSTG4w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eATzgSTyvoU/zZRhnw4GOSyi7+5Qtf6LQrhBqmaATuYhgrkaL9qryqGGBD5Gx5deKDPryKDeXhfisE/ECeawRL7MepJdjqi+MM2u1SRGXehXJjVatGgw0Z3rP+I3gy1cgCc3kJY/Oe7R6TEtdMz6TS7kW38evm1D1dn8HMMeum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=o9TBSKQN; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="o9TBSKQN"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3eae4e590a4so6267988fac.1
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767370408; x=1767975208; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=929ng381HsJQb353irA69SEMuHXFfWEQE0+aHjHLPrg=;
        b=o9TBSKQNFBAst2dfMHw3+Vq+J2AMRqQjJKn1ilGawbk20WBHlH/JIn4CXSVJvAPI6+
         qj6Irq8gL6rDT0I0EbvGCTWYQYLZcOA3s4Edlr/MzMZfEEZ/oUqlHTxIMQMDTTm6K1vl
         t0Uc78nv31VJpm5Da4x/GA/uDVWnGXnvOfgF9e9JfcNy4H5UFtVvO7sC6GBx1TmNa09c
         EE++upxkf6hvh2iS5OEasoFrqYwjBFCsyrorG7c+nqzxBX3D42SdtQaqD8IZtLKSxSaS
         RcVjufCV5Iv2uHD86eJD/ofoj7VzNEVW3+0M9CWMZvGWmO9cQwoL1+XFafjmz11DQ1pr
         w96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767370408; x=1767975208;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=929ng381HsJQb353irA69SEMuHXFfWEQE0+aHjHLPrg=;
        b=G9awQDGZmGrYfVS+qdxCiYTerBU+R7P85M439wVutuRfkNKWYGvfImQ7N98E0uuosP
         gXVIHjWcd0j0dxfatWTHWXMR91vz9iELgymafvJOjUE70ycqtdfAKkHxJwv/nkXvgV7m
         nOshLiaDZqyB/eHfoWHE7U9+0gLQaAS65fsMSveIhz/bYk1+D0qLYn0EFbiSW3iu487Y
         IMoq0R6Q92lq7j1HQsfTaM9kbddRB6BT8o1oRAJFQY6ZOVK+I3FV3z8mfwzBzmhEf1RF
         foYfZd7IdmWdvAXGJm9mvENroLZkccqnkCqt88G8PDDcJH6+C2s+Ju905HqeDfboihLw
         S1Mw==
X-Gm-Message-State: AOJu0YzQ+VVR2n85WS6zjDoKbyHac+WCk/eXV/ZNul8feHRvz+RFCagQ
	Y4O3yYLwEQTgqfG0PvG//DnIIaZMykiTLx/luYMFZ1SEa5ab7HworQ7uvPEb5jd17Mnd0i52bgR
	3B0/o
X-Gm-Gg: AY/fxX6iY+9PTvlEZjx7sGnq/sYxfKyhT27DvA9FN8d08w1PWsfW2zig2qlrUrZutT2
	GsSli8V4z4VEJHvFzGGffsM7FgexzbuXEmgsgO19pAtEP6j8kA2nYqoNZGLEkWm7elN6Mv2LVga
	/WIZNpQIDakrqAKi1U5mYZDKDkuqYYzj4f4uIRPDgYPbFCIBaaGhmIFTXBOG0STu3OeLWg4Guvv
	/+w2+WmkqVHTbwfSk6p0IIZVhGLu2xSiYEBmju8sjWigZZHi6ewIROBJRJ3AwzGunRmSs8D6bOE
	h54WRLILpWxUMpdW1c+oRqobD2qQLz4L7MuN8JLA2mCPkzJLxzZNOpGCUzu+Z6M5ZGCzq1suOjG
	AwZrthUfMWmJfqbbv0NH57sqK67DF4yA3tzWRS17p9mk3gUewNXMT8jfSpfmglL8/7GUKPpbwKM
	kJMuLuDjGK
X-Google-Smtp-Source: AGHT+IHCYFXj3DSF0FtaPZxMzzjBZJGZfcF1SijscmboehwySshnkLUkiBacCZK5CeuqJKhvtYkhkQ==
X-Received: by 2002:a05:6870:e9aa:b0:3ec:554d:c233 with SMTP id 586e51a60fabf-3fda581afddmr21621248fac.28.1767370407650;
        Fri, 02 Jan 2026 08:13:27 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaa8d4521sm25604990fac.4.2026.01.02.08.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 08:13:26 -0800 (PST)
Message-ID: <8176248f-c50a-4e2f-8eb0-a16f1bb3122b@kernel.dk>
Date: Fri, 2 Jan 2026 09:13:26 -0700
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
Subject: [GIT PULL] Block fixes for 6.19-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here are a set of fixes for block that should go into the 6.19 kernel
release. This pull request contains:

- Scan partition tables asynchronously for ublk, similarly to how nvme
  does it. This avoids potential deadlocks, which is why nvme does it
  that way too. Includes a set of selftests as well.

- MD pull request via Yu
	- Fix null-pointer dereference in raid5 sysfs group_thread_cnt
	  store (Tuo Li)
	- Fix possible mempool corruption during raid1 raid_disks update
	  via sysfs (FengWei Shih)
	- Fix logical_block_size configuration being overwritten during
	  super_1_validate() (Li Nan)
	- Fix forward incompatibility with configurable logical block
	  size: arrays assembled on new kernels could not be assembled
	  on kernels <=6.18 due to non-zero reserved pad rejection
	  (Li Nan)
	- Fix static checker warning about iterator not incremented
	  (Li Nan)

- Skip CPU offlining notifications on unmapped hardware queues.

- bfq-iosched block stats fix

- Fix outdated comment in bfq-iosched

Please pull!


The following changes since commit 1ddb815fdfd45613c32e9bd1f7137428f298e541:

  block: rnbd-clt: Fix signedness bug in init_dev() (2025-12-20 12:56:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260102

for you to fetch changes up to 69153e8b97ebe2afc0dd101767a9805130305500:

  block, bfq: update outdated comment (2026-01-01 08:57:37 -0700)

----------------------------------------------------------------
block-6.19-20260102

----------------------------------------------------------------
Cong Zhang (1):
      blk-mq: skip CPU offline notify on unmapped hctx

FengWei Shih (1):
      md: suspend array while updating raid_disks via sysfs

Jens Axboe (1):
      Merge tag 'md-6.19-20251231' of gitolite.kernel.org:pub/scm/linux/kernel/git/mdraid/linux into block-6.19

Julia Lawall (1):
      block, bfq: update outdated comment

Li Nan (3):
      md: Fix static checker warning in analyze_sbs
      md: Fix logical_block_size configuration being overwritten
      md: Fix forward incompatibility from configurable logical block size

Ming Lei (3):
      ublk: scan partition in async way
      selftests/ublk: add test for async partition scan
      selftests/ublk: fix Makefile to rebuild on header changes

Tuo Li (1):
      md/raid5: fix possible null-pointer dereferences in raid5_store_group_thread_cnt()

shechenglong (1):
      block,bfq: fix aux stat accumulation destination

 block/bfq-cgroup.c                              |  2 +-
 block/bfq-iosched.h                             |  2 +-
 block/blk-mq.c                                  |  2 +-
 drivers/block/ublk_drv.c                        | 35 +++++++++++--
 drivers/md/md.c                                 | 61 ++++++++++++++++++----
 drivers/md/raid5.c                              | 10 ++--
 tools/testing/selftests/ublk/Makefile           |  5 +-
 tools/testing/selftests/ublk/test_common.sh     | 16 ++++--
 tools/testing/selftests/ublk/test_generic_15.sh | 68 +++++++++++++++++++++++++
 9 files changed, 174 insertions(+), 27 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_15.sh

-- 
Jens Axboe

