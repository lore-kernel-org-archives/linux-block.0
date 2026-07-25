Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC2DBE63
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784943238; cv=none; b=ccAgZVO/IhqcqIYiZgiIgGz1d49UdYfWXVQdcbBPCwVebeWgEgDSLKG+uBBjf8WkYvc2O6+sJY/RB89NxpGO1MpIsrdw5scvYB3Sc2ijtS4T3xlC2KlYAPfs8S9smDd9VLbjGjOmlMqaI3ugTWSjMOBjSmyJoyXu2Bi2fHnd8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784943238; c=relaxed/simple;
	bh=mZ1inUOTN+yH1N5I91jr69QiAJRXRSDLRebzGEpV2fY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lZykQjbuyjp6HNOApSe/KAL/2sB0ixY2M2buxX69J14YdArTmxzUNb9vrILEOpumxIQz1ASbwbGBH5US/gTxBpE4dqRMM2tSVSVZ+N0TP+FG2W7ITfo+7YF7B6OWpwelfl0JJuOGfTNXmB5ogkaStFvt3JeB/jAUYlzBzdjcqEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=cJh7P0LC; arc=none smtp.client-ip=74.125.224.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="cJh7P0LC"
Received: by mail-yx2-f3.google.com with SMTP id 00721157ae682-81dfd9cae2cso3328067b3.0
        for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 18:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784943235; x=1785548035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qElFBQ39C7n9ZaicWYMVoNS4PnOREctSMAe/+ybWRuA=;
        b=cJh7P0LCfUOrqyh7EIy3yc92Q7w/UejuHJBg18YyPzfR2dDnhjCm6KsZyn7AteNv8F
         vypOm5B8HClqjGKu9E7CmaEis4L6p866SfpuUxAijCFwDWO88EcjrtVTPMuX1ZKaxPB8
         dRgikLtV2t415QnW0EcG9K5HOhsO8HmPBT4KLs1DX8yWql1o9n3Msjvio1YHgfYQvKZA
         FehH/w/oi9zMAdm66qxqQ71VBjBzS4EXuIhHzM9RVG+wdM1nWy+guWgeXbydbbmSZ1ak
         0LtO5xkgSPGilEstR2nBlEZ643Mm8Ft8V8jUMppc6TPHGbLETBqtLFMI+P7O7l4ukzxh
         D7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784943235; x=1785548035;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qElFBQ39C7n9ZaicWYMVoNS4PnOREctSMAe/+ybWRuA=;
        b=kv4MMUds2jpTBWOwah3q0T8BmYcJaTmPjB2blWXx7fVQ3eOBDZp/WrC4rTT2W4naBX
         WqUvhjXtgn1czuKlDfIpS1j/3p0lBqZwNf1yYbPwRTEjMe434d9jTyDbsR0yLQwbT+mL
         69p4kAqlHBsrP0KAYLPlXInakCDKdyk9nabrTFCRbQ7LSOAwSe4lKymtD14fuOuR7JHT
         hSCJBHsz705aE/ktZF6+HSGG1ux6xXvezYw2yGYR2M0KtZUAcbTQoC62ktPwIoYqHiVj
         FYLLprvnKbyXw03GaamVM9Ehy/ekipb/9wwqHTLgwRvB+NT7alwQelqwTvhuC+MQSmr3
         tt4A==
X-Gm-Message-State: AOJu0Yx1TvyzJ/0VZWQIHdPbkauoVbryXXXKKIBY7Q5gQQDBNhCs33QT
	gLZrIsa0KZKr8ktKCszSZ5JCHu+bffadsy31NoVBdec7JX4CDmp9d9eZ0/CuPUpq5r2IKsLobCE
	tbnIepnXafhu1
X-Gm-Gg: AR+sD13z3RvmgCe+RklYXSd4eI2FNmuRArim6eYKYFh9eSW0nRK1ZLB2LE5nY1wEzko
	0fXvdM5SNtVO9liBaV188oKu/I4UiHvJ0/hzCOiAq4KyXcLMpkEJpatSkyGJFBnGsOqQVlLuWg2
	aRGG+VgKAN6GdXMIcjO56G0bqtubafA9sKMAOKwXv9uDxpl9n5eOKBnD14avaniVZViz37qprR5
	yMNPLI0UlQbt7oEeYC8EHvmsAv0mOFeGEwdea40uh0sWimnncZu2t2dnJRacH0boP8s6pigHHtV
	aRoLYTyQvpgMBSbl6sm9COlYt/KSYyZyAlKChcbE2YRzBljyPAyDifsrZk3dBT6mXVVV+odxct5
	jhJu4dpWMZc9dJR8Abujv16JgLDvDCScA0g7k5BMjHuBw8MOIHLDtOsG7sFzEIuPm279zJGvfZT
	+XIzLtNxEXoZERKuGCCcJENsLHoGZkH7GfnZKzJ3T8K5wtuL6NLl9RSSyD8Cs=
X-Received: by 2002:a05:690c:3344:b0:812:c236:1287 with SMTP id 00721157ae682-81f69e52984mr2649057b3.45.1784943234820;
        Fri, 24 Jul 2026 18:33:54 -0700 (PDT)
Received: from [172.17.0.108] ([50.168.186.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6576ee52sm7564057b3.3.2026.07.24.18.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 18:33:52 -0700 (PDT)
Message-ID: <3f1dae20-214a-4b2f-b13e-2c996b31acca@kernel.dk>
Date: Fri, 24 Jul 2026 19:33:51 -0600
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
Subject: [GIT PULL] block fixes for 7.2-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few block fixes for this week:

- Fix a ublk recovery hang, where END_USER_RECOVERY without a
  successful START_USER_RECOVERY could be satisfied by a stale
  completion latch.

- Fix a stack out-of-bounds read in the CDROMVOLCTRL ioctl.

- MAINTAINERS email address update for Roger Pau Monne

Please pull!


The following changes since commit df308a14585649f7683a560f5c94978ab4f8224d:

  block: fix aligning of bounced dio read bios (2026-07-16 06:11:37 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260724

for you to fetch changes up to 093fbffe03f5c1bb9c10a9e5aa65b23250844403:

  MAINTAINERS: update my email address (2026-07-21 06:24:43 -0600)

----------------------------------------------------------------
Ming Lei (1):
      ublk: wait on ublk_dev_ready() instead of ub->completion

Roger Pau Monne (1):
      MAINTAINERS: update my email address

Xu Rao (1):
      cdrom: fix stack out-of-bounds read in CDROMVOLCTRL

 MAINTAINERS              |  2 +-
 drivers/block/ublk_drv.c | 47 ++++++++++++++++++++++++++++++-----------------
 drivers/cdrom/cdrom.c    |  1 +
 3 files changed, 32 insertions(+), 18 deletions(-)

-- 
Jens Axboe

