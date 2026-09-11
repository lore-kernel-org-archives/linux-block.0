Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC632D0C8F
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126495; cv=none; b=Ahy3iAQX7B1PQilAaC0RKSC1U4yjGtrGQ2xnuANlVtFh5dO9SosmnvBcpVtjNmdUoy2c4qE7QHnKq5rJPa0ptF6Kwv9bmKIkt4Zp3SWmvs/xtdxTxZjc+Mj7Cmf/A8UPNnCPumZZRaDoURAf+tSo0FjmqbTC8GpsTHIi/+jjtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126495; c=relaxed/simple;
	bh=uSENhsjHLMag1yw4ubPaOkKXgaHQgR7pN3TBtgw88SY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=u3zp7GMKO4WQONB7JCwNAktHmWD/vIRI9ZnwUQlCRayXTfD8ru/FPEgAxkfUVMJ1mdj6HrwSsS8dct27eIcStG1EjtBFEBvPlddaqEaNimFwdDG0qpNxaxtNv2ihYH3RWTWe9+MrZKQEgD64oCdb+Zqx+HRhVs8oiJtG6At50ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=aWrUsDNr; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="aWrUsDNr"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4a4cb36ae00so690553b6e.0
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789126486; x=1789731286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E1MKScrqDW/JeFHQxtKlAMq5jZO/K5+SFYOUQ9DUJP4=;
        b=aWrUsDNrd+fgkSbGngU1N8Exu3ftojjddYfytk0D7lSlgntgSW/2xIuFbwnwuFEoB6
         yKk2Wnh8693RdVbEbTqBWEfN6Lq84rKzk6jBBwJcqxFUmNYkRxXErWTT8VS6pyLf+egP
         qN9+3WkUnsxHBYwdnXLBtY3yQeimNv+LhU+zExReE4pJPQCE8/YNK4dgTBFyrbddy2H1
         OZFZodAw60BFcfjVCJPAG7pclYNsGDe2Ub8+1DZHubHSfKe79ea5mEo4LUkE9sNNZCdH
         XKOonpjRM6DBRBiZCcl93N34Q5DreO6HiEbNKQM0bZzP0bS4wx9cR3mrB+Sn1cWwfNDl
         zdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789126486; x=1789731286;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1MKScrqDW/JeFHQxtKlAMq5jZO/K5+SFYOUQ9DUJP4=;
        b=DsFmmzDqgwAxhj+z7ZK2ilfAtNr2zpxex2cjknarNBulYUzcpyS/0TJ+noJQH4hwn1
         /FIGMfxscma9BxZig6nYRCHnySMrHMQuKCVMjZwdO98zjxzC474rBlxp1Vkfkz8VVLaQ
         jF87YZnWtja9Ay7ZkZf7SO7bxBKVSRAuctQD8GVSVRi/0qhTtjW44nVnE1a4ea7BHFez
         T+zfn/XK/xBcOISbXYaBepFinJx7nrc9XLASrk23LnL6fBk2nHfvjTRqcKDDX8lSm3XB
         2V9iJr/eO78DivFbtHgSReY/24BWtn4B1kvElxizzh/vTKrjgmFNSKCeqDjfowWNF3tV
         eMow==
X-Gm-Message-State: AFuF++n837nRjqpSSRG/gOkYOXcA8LEgQJlc0F9tXbhyn0f90HzzfHBE
	cCZ1QunFa1YQqX4AM5kDRFKUK1s5jXREoNUIsIA94gyMm5SiR+CzAeSTLZgqCKbnYhoDANQYHac
	73X4n7P0=
X-Gm-Gg: AYBFou1ZDw3+AWHuHEM+7NiqqdoAU9h7PehFUHdrkD2oo0nJys/PNmghA20UocnB/j+
	pbE7Julae1qVJA8TKRq4SanIp7HNJSsojzd2oo03fyXdfPw5XKSnTIjTNSCyaZwlTheiI9dPNq1
	4fBQDB2TdBJ8/CJtZgt2nzIEEy0JNylo7bM5EAMap57iLR8kB3RhonFxCmty3I32anlP5JZooRw
	PFzcnzNFgNFAP9nzL+pWibRQ+pNvJAAYoygk5Gawgi5LzbXoTqFbb72PytUvY0wdNy3JSPwSbSa
	EjzJw1M9KyVpo7wBfSv7SvQ3/7jw9MXqxcvE2AtsaFT4BxHSTbdcAwJ/+ZAW2gvjo+IJKNhbsv4
	lm35GD6D871bINZmhbi4e+1+csFKS2LXSaQ4GerhIASaDWeGZd4EQotr/pwEBA2JX3PJ7tKhWyR
	VdCeKsykHQKz9ctHIhDplQS7ym0ROhIe9pYCnKdcasiOGl5V2o7r8qn2qv62RQH6GEe/4v1ak9i
	0Ep9u3leS9wTEqTW/r/k4nwwj9fI+yERg9jqXVsJc/wu8pRGpDaGs4a7Q==
X-Received: by 2002:a05:6809:2d7:10b0:4c3:82cd:601a with SMTP id 5614622812f47-4c382cd6184mr1208452b6e.32.1789126485770;
        Fri, 11 Sep 2026 04:34:45 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c3314b17d0sm1802737b6e.8.2026.09.11.04.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 04:34:44 -0700 (PDT)
Message-ID: <1b9b8e2c-463e-43e1-95d7-308c07b500f0@kernel.dk>
Date: Fri, 11 Sep 2026 05:34:43 -0600
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
Subject: [GIT PULL] Block fixes for 7.3-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few block fixes for this week. This pull request contains:

- Fix the start and length check added to iov_iter_extract_bvecs(),
  which used iter_iov_addr()/iter_iov_len() helpers that aren't safe
  for the ITER_BVEC/FOLIOQ/etc iterator types passed.

- sunvdc fixes for an -EIO issue from lack of retries, and unmapping
  LDC cookies when the descriptor send fails

- Clear force_abort in ublk_queue_reset_io_flags()

- ublk selftest install fix

Please pull!


The following changes since commit 00ef2248c5dae08548f7ceb6951b022f89905330:

  Merge tag 'nvme-7.3-2026-09-03' of git://git.infradead.org/nvme into block-7.3 (2026-09-03 19:48:07 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20260911

for you to fetch changes up to 94b1a3ca9b8db3151f1416263704c159a9470da5:

  selftests: ublk: add batch IO cases to recover_03 (2026-09-10 20:19:21 -0600)

----------------------------------------------------------------
block-7.3-20260911

----------------------------------------------------------------
David Howells (1):
      block: Fix start and length check added to iov_iter_extract_bvecs()

Jens Axboe (1):
      sunvdc: fix -EIO issue due to lack of retries

Mahmoud Nagy Adam (1):
      selftests: ublk: install test_common.sh and trace/ scripts

Stian Halseth (1):
      sunvdc: unmap LDC cookies when the descriptor send fails

Yang Xiuwei (2):
      ublk: clear force_abort in ublk_queue_reset_io_flags()
      selftests: ublk: add batch IO cases to recover_03

 drivers/block/sunvdc.c                          | 26 ++++++++++++++++++++++++-
 drivers/block/ublk_drv.c                        |  1 +
 lib/iov_iter.c                                  | 18 +++++++++++++++--
 tools/testing/selftests/ublk/Makefile           |  2 ++
 tools/testing/selftests/ublk/test_recover_03.sh |  5 +++++
 5 files changed, 49 insertions(+), 3 deletions(-)

-- 
Jens Axboe

