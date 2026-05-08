Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149952E7BD3
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268197; cv=none; b=asmsWZIxNMkgQqSUqXzMAoxmb9iNwnG9LgTyIi7ASVIsPY9DmeSSFyT513Gg3MOiaYK2XD6PfIzO7yRvt0EHMRRb51+RDmkPseK1MQ1MGWRs7/jd5pID36/e5B4kxOmp7vsBYhRt9ZyN4iGO2fhqjDpSTHEQoyboKOp3vUxjP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268197; c=relaxed/simple;
	bh=9lu+svmkR4kYQtHFym6oy8j1i/LpOnyqspkAYn0ixqU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PFIZio2HV/bTKWXu6VrppVDI/kgW78YsTXCllLN9HhEXCTQHZbWBccz+87rsdO5hBjuWWl/D9BiMD61/Wh2dgZ6KKFUUd1CpIS0fgft7g/PQQc1sMzXn9gQZkTQna3RGLzuKFeAw/ydvUtMmigO0bsx7qqmneneu5P4Qlfyf9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=JkkLA8kQ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="JkkLA8kQ"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7de4be15125so1901460a34.0
        for <linux-block@vger.kernel.org>; Fri, 08 May 2026 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778268195; x=1778872995; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMMawRsNeOF2V9xnaQzJI1Y2OQV/JVr1ilC+c34eaTc=;
        b=JkkLA8kQ7QBPnin6InOqgoO7iTn1YhfpOnESJQIoh5NBX8O0Oe1BKD1xCuerOdXH5k
         ogyv6gIDd1V9Wcn1KDppxmqmlqnexixQcn0HX37K5ilh+9nnwXESLKrKC1UPAQAgqTZ3
         DgPXatveVXUPQcL3CkDq+tsHpLNgjQvr/8YDxtlqCU7eU5YkcQYutadjXS1cJditZB6y
         YJjBzjIA1tnXh+ALKuiKotgsjZbd7LPm9sFPUq/EBVQl2NyZFYH8OQ+K6XeMeyluAIJZ
         DkQDqJoTYRWAEN9AKnmt5b1lUioo1ZLShhXWR0DIvfrou7KsioE0xDMb6oT6xygPKi02
         Zb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778268195; x=1778872995;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aMMawRsNeOF2V9xnaQzJI1Y2OQV/JVr1ilC+c34eaTc=;
        b=Vav/bxXBV253CK+7fNcCoW010SRiY3ggPuiInWdQo4GNJEKiQWEEr/k278QfkE9pcN
         zqlcNIwcnEemXKStsTRoHvWS2a6m4cqEup0DQE+GDIdZMvTrPIZgGbM9mvzG7SFiu0h1
         tIOBwm88r8m5HWdPjb8jYxVGrDfBuaneztVnkcHh2qU2nL0C9wTjZPqsS4LSHkZy4Ve8
         oHTF6y07BEJBNk+q2/3J3vq3bVTEdTuPhQVtEVAR19FyBGH3II16Ls1Q9ZRwS8V/yb/V
         zKdZOmyOE05UTCOuvEHQHfayfS5ugGTTIlTL8s6z7c/1XsYk7UVWHyrn04aRiL8CUGCs
         RShg==
X-Gm-Message-State: AOJu0YxfzNgH8qD4KumHwUkIu3bYlINmodXn9mYB/WoyGqmWJ4DQ3N6f
	4Ot/TE/4e/NgkNbBDLcfJIFY7vTpTRxueOGkWuuCZPC4SCplNnHknl+Oxw2Z+FPcnx9a6uL/Mpk
	9kVGa
X-Gm-Gg: AeBDietOgXXI2NL03qyhMyUKVhm+Nn3i1T+MWLVG9cY3JwbNWomr2IT3tXj9842h5Ul
	X2tcIQllk/EzRzBs0H6NSXyZGpYJkqevpJLCJ/3dFqGXbDUfmmlDwzu+sqzq5kipyDUMFrMVXZl
	uBD+7CSUfZp7010rgWdYar/efVXgCcATpIMhwJWOL5JmObej2gPLmKm3RnzCCM/4yCBXOnEWcTR
	qmITcU2j4uzkjflpXH24LxH3MWe+SsD0zlmCQsbsXXrp5DKftj0tFxmMkBPu3tDtxCClEj9PyZs
	TEveZsvprNikvjAWayBqN27Fg6kJa1L/uXFRkUa2EAz8vL4VjsLIICB9pugKPjq15TEHrGXE2OK
	ejQFGd0kVmI6EBRLOnqtA4on58WAkmMfoNoPX4EgV8W49qmW7uKxxS2LvmShSw8b1QLhBusy21/
	sgff0kbePcmFMkZO01zXZ6+05wZ0puv7OuQyfX09vlIoDczNHxeNFq0sxBXf9azhX2ZwZf1rLSh
	k7OAwUp
X-Received: by 2002:a05:6830:67c6:b0:7dd:e032:3cdb with SMTP id 46e09a7af769-7e1df0d2a88mr9689962a34.18.1778268194962;
        Fri, 08 May 2026 12:23:14 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367a18481sm1693159a34.0.2026.05.08.12.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 12:23:13 -0700 (PDT)
Message-ID: <36745ebc-0658-48b4-9878-982d5644642a@kernel.dk>
Date: Fri, 8 May 2026 13:23:12 -0600
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
Subject: [GIT PULL] Block fixes for 7.1-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes for block that should go into the current kernel release.
These are mostly ublk related, in detail:

- Fix for ublk not doing an actual issue from the task_work fallback
  path. Any request hitting that should be canceled automatically.

- Fix for uring_cmd prep side handling, for the block side uring_cmd
  discard handling.

- Fix for missing validation of the io and physical block size shifts.

- Fix for a use-after-free in ublk's cancel command handling.

Please pull!


The following changes since commit 7e36e03d192a5547757bd8f9d9052a60f64e6d17:

  Merge tag 'md-7.1-20260428' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into block-7.1 (2026-04-28 08:36:26 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260508

for you to fetch changes up to f7700a4415afb3ac1767a556094e4ef8bd440e41:

  ublk: fix use-after-free in ublk_cancel_cmd() (2026-05-08 06:44:42 -0600)

----------------------------------------------------------------
block-7.1-20260508

----------------------------------------------------------------
Jens Axboe (2):
      ublk: don't issue uring_cmd from fallback task work
      block: only read from sqe on initial invocation of blkdev_uring_cmd()

Ming Lei (2):
      ublk: validate physical_bs_shift, io_min_shift and io_opt_shift
      ublk: fix use-after-free in ublk_cancel_cmd()

 block/ioctl.c            | 24 +++++++++++++++---------
 drivers/block/ublk_drv.c | 42 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 16 deletions(-)

-- 
Jens Axboe

