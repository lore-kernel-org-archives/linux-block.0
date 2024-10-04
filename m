Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB1F14A4F0
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054665; cv=none; b=RHhiri2BWM0V7FJDl/T74uDlwk6uPXY09lwMDU19cKAOrAVq/yIin3AsLYrfINOrEAPPUoo3Ov1WmITOlfyAhQFrpXeqUcs4K4gxeXAwqI+2xs73bNY728A0CK3bw7P2/57z94+gHA+644kZYeMhMopQxnrsm6dnCp0MaZbQ3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054665; c=relaxed/simple;
	bh=jnFHM6r84Lfl4o6JLyFBiFlq646o9aL1iijbE9lg7Qo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ADN5MLZdrZIvvV4hwf+06KnISJOfTU2uvQmBwUjCkZ5RGWZxHu40vP/92492glpc42rULjYzuhHAS6DcY5i3k9qkz/HqcsOVBn+gbD4X6gkAJdy2KFqtICvZmJn6doeWfwXaD97NvVOGqejwvimIhm0c3itMm6vSp1Jb2Zsyzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hpFzPiza; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hpFzPiza"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82aa8c36eefso123136039f.3
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2024 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728054662; x=1728659462; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tYC/ZBKecAVxkW5RVRCH9rQaXnyU8yQuRYba++SXmc=;
        b=hpFzPizaNffTp3sUlRoVXClUAbLW4Fni8DcYP10lGROv1uXuesQXkwqqivBDKnnjvb
         l6LdeWhVfwJfUXTFlO2L1ZL6LUjp0nyVUdkg7gH2jvpQIpm2V04bN0c7Wp6pu2orCjuS
         2fz0Z93xVd5Z+ZzKF1bfaI+7TdL9+4wgyCI90Iy5e6ZdryKaFL0C+1het6NbzIFqaiFk
         6D8v1fMHVAgsPR+IFJbcW360ra9oiBZCba7GAwWgDVjXhlnH6Epp+sW+z+fmRGEtnFV9
         c+nkkFUj5cyORTQTJHmi0Wk1XDoaY9PRR3q6s2ZvKbpzjonFoBbm3r2+r9w48G76fNCV
         fEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054662; x=1728659462;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0tYC/ZBKecAVxkW5RVRCH9rQaXnyU8yQuRYba++SXmc=;
        b=f8iS17wNgCqUM3x7X5RsfHEn85xnF2IICQf5N3G5Ffq2mJ20d6NrEj7DvstJ377gco
         xMawvxhFf8xG/kfGNPdVBC+aH6qdFz5CsHuNcoeBeh2bSeU/5z5AJHpULj9/SZQioVPF
         t0KC4ZTcPeg0uXxuB3t29mlKt/Mjks0IL25JMA3fAKPYL4e6XxMfggbW8h/F9VkwwYqQ
         ZKjWb7hVRvCUgHBkS2bTpfzvN8AHv0j9slLq138LgPKFGfw1VZcSw1jjWxZveFrIKApT
         R/XhEaI1aZVzovTFH9+I/RPQvL4qqzIwpg7wgvAuzxasmnw8xf5njtf03sSOvuRWE31U
         jaxw==
X-Gm-Message-State: AOJu0YwChQnN2ynH4jS8YuEbfoQr6N8SjJyBH0lHE1cR4RZ9URFMtDVw
	nVp98q9kjytxA2/ErZ8z2ZNtiYxFjAG+Zp0rgPSZBs+GWJdEHzu846WpfMhXs8ybmHkP1OWMVFg
	z59k=
X-Google-Smtp-Source: AGHT+IGl120Gyp+DnSn31/PKOF3vxTsl2vgUqZ6j5Q2Yi2Pv6dskZPIR0J2AogO0QDLtgrTa4aAoog==
X-Received: by 2002:a05:6602:6c09:b0:82d:13ce:2956 with SMTP id ca18e2360f4ac-834f7d620e9mr339160539f.10.1728054662233;
        Fri, 04 Oct 2024 08:11:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ebf0adbsm8922173.115.2024.10.04.08.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 08:11:01 -0700 (PDT)
Message-ID: <bc04d464-e0bd-457f-83d1-95f12b95f54e@kernel.dk>
Date: Fri, 4 Oct 2024 09:11:01 -0600
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
Subject: [GIT PULL] Block fixes for 6.12-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes for the block stack that should go into 6.12-rc2:

- Fix another use-after-free in aoe

- Fixup wrong nested non-saving irq disable/restore in blk-iocost.

- Fixup a kerneldoc complaint introduced by a merge window patch.

Please pull!


The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.12-20241004

for you to fetch changes up to 6d6e54fc71ad1ab0a87047fd9c211e75d86084a3:

  aoe: fix the potential use-after-free problem in more places (2024-10-02 07:16:44 -0600)

----------------------------------------------------------------
block-6.12-20241004

----------------------------------------------------------------
Chun-Yi Lee (1):
      aoe: fix the potential use-after-free problem in more places

Dan Carpenter (1):
      blk_iocost: remove some duplicate irq disable/enables

Keith Busch (1):
      block: fix blk_rq_map_integrity_sg kernel-doc

 block/blk-integrity.c      |  3 +--
 block/blk-iocost.c         |  8 ++++----
 drivers/block/aoe/aoecmd.c | 13 ++++++++++++-
 3 files changed, 17 insertions(+), 7 deletions(-)

-- 
Jens Axboe

