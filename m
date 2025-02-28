Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35025F984
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751942; cv=none; b=WiuqojRNE3CyWeX35X7zBAoO9gaT+SR6FAZxZERfRW6ascqTdp7f9T+FDDG16JU5ibJWSY5pTgn0xT0LVZyjadVCFBWFOohjNBbFxO38aH5GtDrZlwJ5/JZWfEaha+6bzt4cyb6bcSYeodJzsPMrab1MfaldUqDpKd/6E4XLf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751942; c=relaxed/simple;
	bh=vL9tcYruTM3SJ/2SpmhRLifvvKcOb08Leulv0tOG2DE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RL4J6fUfAHztbVG73+Btil/AdNnb6zssrRPxAivJrHmfOMkApcGSjKFIS3SlBOnAMraJg2erqaq529MHK6W0jT+P58mutUUndxvOACOcY7IAQgD4Tt/nGJwpL63RDzMwXpwW7e4RhYqL4mLT4FuV7xumsAWWQRs0O22SsHwF6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EazlFf4F; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EazlFf4F"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-221206dbd7eso44851715ad.2
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 06:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740751939; x=1741356739; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4bqe2YXY7LtrG/bSVRnhlklCMTxjE7JkqwV4qPsxWM=;
        b=EazlFf4FYHpD0XhNzjQARfXMjddeaJ7aFhM/YjU5rhBiGTrF88H++v5S/pmgeu6eK2
         usWAojmThE9qi5fvWbyYOUDqyrMl6MM/U7MPt1NAAcCswbc8KLUvZyu5niEKzLhSIiKd
         PS/T91rUdxG9dUOE720/QJ1bXinrPbCBIN/psrI9c7uJbjYZuZjwQdgK7lsa2mG8Deef
         mE/nMv3K0w3CQRKOLqYTKP0028XsdR2EmdFcBUWJrJ+09YLObn3P8GksEOJukI8V1zXw
         bYNKBgGHuAeX7qHcioLP1T1SCusDEkEDHItd60rEGoIsy5USiYhnWLBY+iHBJpYTCb5r
         iPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751939; x=1741356739;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4bqe2YXY7LtrG/bSVRnhlklCMTxjE7JkqwV4qPsxWM=;
        b=kceUUlNFKImmeSSM+dWtrvaE4O2ZhEqz2ukL56R+0hADhxndnZwHl8eHE84Uzmmbml
         L5PuU7o7zb4zqitOV0U2NWmDXnM0+Vy6wZYWn53vJmJgBaNXshKW+KtOjhzIX48HOQQX
         Enm6Sl8t8XlF93cT476ZxYgXPQOa/GzQ6uYr8/yt46fCKwUAty/h5OO7oMLNdV4Xppaf
         Xh5ZgyDcQaoDtWcuQIaY7ySRCgaIg84icAV0jmCiPLeM8xDzUDH1vugA1HdhOTq1223n
         yOIPeYjtlDnPz8fzYU/6YxutTyzK8L6csy8XQMpDPckczdQQ/9OKFTug6wfPBFWgQSfu
         rZ5Q==
X-Gm-Message-State: AOJu0Yz06MuIu29bhFag3FHcSBgjGR4nuNLGQwBL0xSJXh+MtOtkzQaQ
	6t2eCdaiBhw8cCE/gmP1pEcACKdImc06RRq0PEBAr9IipG29jt2O4puPRjxEJlU=
X-Gm-Gg: ASbGncslAs1dzRVaFaQVcXP2SZ+jabpQiXIKtfz5PV0DUytD/yvyMqSmgaBHc7HW2sN
	vAaviZMtzj6sVip5+wPkL0v6aYO8gWtWo+8AQUIm9Bjfuc94F/4PGhqpGFXee0r8CbZmKmpDhgs
	LUFtlVa9BjfR5bhV4E8rKhltFig/IzT5BO4Wt3+5JHyPLiO5AhY3BFi/JV+74M/gt1qt8PTeqUo
	HiD/XH6Y7WLqvv0dNVlDu8V1I8fDhTbiAL089ow6KPdgqZ/38F6UMmjh3vgjqKDbeOTu4lLtX9U
	tXs/gxZi7FSHZYZV9n1sRQJdRzWgNMHEGoPYvA==
X-Google-Smtp-Source: AGHT+IHr3B9nqcOBHxQlENa826MwA0vgH4yQYv0FCqA0t9qfvnq5/zcp4WvLxxEscIOzD1p7MXfg8g==
X-Received: by 2002:a05:6a00:1702:b0:732:623e:2bdc with SMTP id d2e1a72fcca58-734ac36274bmr6082370b3a.2.1740751939270;
        Fri, 28 Feb 2025 06:12:19 -0800 (PST)
Received: from [172.16.2.60] ([4.96.84.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0024bcdsm3856773b3a.90.2025.02.28.06.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 06:12:18 -0800 (PST)
Message-ID: <e7425917-0e60-4c84-a6d0-8dd967a0d8a4@kernel.dk>
Date: Fri, 28 Feb 2025 07:12:18 -0700
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
Subject: [GIT PULL] Block fixes for 6.14-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes that should go into the 6.14 kernel release. This pull
request contains:

- Fix plugging for native zone writes

- Fix segment limit settings for != 4K page size archs

- Fix for slab names overflowing

Please pull!


The following changes since commit 70550442f28eba83b3e659618bba2b64eb91575f:

  Merge tag 'nvme-6.14-2025-02-20' of git://git.infradead.org/nvme into block-6.14 (2025-02-20 17:43:59 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.14-20250228

for you to fetch changes up to b654f7a51ffb386131de42aa98ed831f8c126546:

  block: fix 'kmem_cache of name 'bio-108' already exists' (2025-02-28 07:06:42 -0700)

----------------------------------------------------------------
block-6.14-20250228

----------------------------------------------------------------
Damien Le Moal (1):
      block: Remove zone write plugs when handling native zone append writes

Ming Lei (2):
      block: make segment size limit workable for > 4K PAGE_SIZE
      block: fix 'kmem_cache of name 'bio-108' already exists'

 block/bio.c            |  2 +-
 block/blk-merge.c      |  2 +-
 block/blk-settings.c   | 14 ++++++++--
 block/blk-zoned.c      | 76 +++++++++++++++++++++++++++++++++++++++++++++-----
 block/blk.h            |  9 ++++--
 include/linux/blkdev.h |  8 ++++--
 6 files changed, 94 insertions(+), 17 deletions(-)

-- 
Jens Axboe

