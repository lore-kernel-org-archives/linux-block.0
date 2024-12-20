Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AB33062
	for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711943; cv=none; b=NjfkB90hKRwYQUI2UdwRbd36gltNTQouE90f0M1tMIsH+oIS/+/KHtaDP11ytAhTArEkGghY03OrVlahMfi1c5Wl2cBB2yN3tBPpbc+PtlsHHhX1ANWYs9VXb+b5VFfeDlVkFmJgaR/SS7ZffbmcK/Yd3q53s6Z9ZpBmtmE/xhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711943; c=relaxed/simple;
	bh=6haLjagzv1oEIeCYd/GOdBWPYaILrnGXmkzKh2bEeAY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tdPyZvdk5pFRoYZ/9I+8WQE3cn9eZk9JC/Rb7teRPPjFvt6U3udI22xVdJu0w/hXle8MwgM+jPWGwhaM26sH8/JnZvWqfo+gVY+BgKEedwzexfjJe7MCUs32kupV/5eKZTWy+VqIfKfCiQouUjLszZlYpCoOoPfjxNjpRSZU5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2M5Wfwao; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2M5Wfwao"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a777958043so7077975ab.2
        for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734711940; x=1735316740; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5d/xthRyT0vW8w91J6WSR4jMCSbxRhLEVrz3iiC3a8I=;
        b=2M5WfwaonQSpPU1NHaJCeqo4KusbLbB6gdokQIYwSkWoBIB8Mh0RdWup2+/x5TruF/
         w5MLW4+jfgs5fhxZ86XLgJk38SZlq+Oh0rlDfkIYwEzwvnHv+xQdECfaaKCScjPHk5Ro
         LQYjVQ1/vyrq/PfM9h77qrNaFCbUxg+f9y1qLhO2/T8EPj9xX37s0Bm8jSoXDnksmDm4
         EVgFLq0piaSxc9Rxk4A3Mki+aI0n+HQwEigX5XNDIsxT1ZqMcnl1SEhmvPMr6lc5Rq4J
         oEd/biy8RQ7cy8/ca5N3VvOZPraDWFo8kLsMflUpfBIeCovEI3RgewUj1IfNDKY5auS/
         v6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734711940; x=1735316740;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5d/xthRyT0vW8w91J6WSR4jMCSbxRhLEVrz3iiC3a8I=;
        b=eX8pDztHwPcOFa8myfo3LCapV+wdhH2wDDndjpaGlFQt5dxZtQOa+DhdeRzkh+Ghou
         ZSL+W4ahW4jshoIgc4o62xFkcbmuilk+Dth680PmAE+BVGWgkY0sgHtJL0s8R7q06syd
         CyFw4fakKOZP4sw8FhVK+LFNFcWTdlRIvCytKqETdDA+t0gpKY6cMHlXbbNP0HanOJha
         Tzu5op6ye199TRSp4cHn6jjJ56UKI57HNc8R76RL2nD9VdyeFolrnke1DpOv/ly0qA9t
         2M0QdImhasxlUKoeRFk5nSodQMlDUs54uNj0RnFZer/ZZuQpzHLuP/J8vc/YRGEeT++K
         uytA==
X-Gm-Message-State: AOJu0YxlWbM05sEHH1tWnm+InGTwd8Fd5agcclQCHv4OFLCGB/itdJzq
	OtwlTU2zXryOQu8v7kO7XGnze9VhBqXNMqTK9OX1cV4pWHCMCXpQRuU+lu89xw5WFWTXVrQusC9
	0
X-Gm-Gg: ASbGncv/FF5Bh80lcKooHwCaEOCcjhDEAitELxMLOP8erAyDdl3R8lBsl5xoKVVHmVE
	EZQc5nDrdBMlYqQH4nMCj5sYg4Irln0rmEZ3czHrQDFS7QBy/ydczby4lDFtgMJzbPJ/UmuIrzK
	qaWfa4pZV8+ICbCi6ADJwqwx0q8eMsYvXyxzYWVW9xUnkapz8rqANg8vgiKPdSmzCYy//7O9y6H
	ZWHZOel0HZLb76mbm6ZoDu31VttbcOkjuzeRhq79km2D+MvdN13
X-Google-Smtp-Source: AGHT+IESKQ4uz8PUgkgEGrmP4fTgXu1qdikQq0dAgTzxTXhOLLxclbez53EXCn3maC2WqaZ5ntfl5Q==
X-Received: by 2002:a05:6e02:216b:b0:3a7:a553:72f with SMTP id e9e14a558f8ab-3c2d51501d1mr38437905ab.18.1734711939755;
        Fri, 20 Dec 2024 08:25:39 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0df94997bsm9376265ab.34.2024.12.20.08.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 08:25:37 -0800 (PST)
Message-ID: <0369cf3f-fc02-46d0-b540-b021ce981f5c@kernel.dk>
Date: Fri, 20 Dec 2024 09:25:37 -0700
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
Subject: [GIT PULL] Block fixes for 6.13-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Fixes for the block area for 6.13-rc4. This pull request contains:

- Minor cleanups for bdev/nvme using the helpers introduced

- Revert of a deadlock fix that still needs more work

- Fix a UAF of hctx in the cpu hotplug code

Please pull!


The following changes since commit be26ba96421ab0a8fa2055ccf7db7832a13c44d2:

  block: Fix potential deadlock while freezing queue and acquiring sysfs_lock (2024-12-13 10:51:58 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.13-20241220

for you to fetch changes up to 85672ca9ceeaa1dcf2777a7048af5f4aee3fd02b:

  block: avoid to reuse `hctx` not removed from cpuhp callback list (2024-12-18 07:25:37 -0700)

----------------------------------------------------------------
block-6.13-20241220

----------------------------------------------------------------
Luis Chamberlain (2):
      block/bdev: use helper for max block size check
      nvme: use blk_validate_block_size() for max LBA check

Ming Lei (2):
      block: Revert "block: Fix potential deadlock while freezing queue and acquiring sysfs_lock"
      block: avoid to reuse `hctx` not removed from cpuhp callback list

 block/bdev.c             |  3 +--
 block/blk-mq-sysfs.c     | 16 ++++++++++------
 block/blk-mq.c           | 40 +++++++++++++++++++++-------------------
 block/blk-sysfs.c        |  4 ++--
 drivers/nvme/host/core.c |  2 +-
 5 files changed, 35 insertions(+), 30 deletions(-)

-- 
Jens Axboe

