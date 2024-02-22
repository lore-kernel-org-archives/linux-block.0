Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77C1E522
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623979; cv=none; b=SA5r9MvGXrj0l/dcv6K2C/CKhay17NtLYKChajO0k0xFVUiVarEpVUIwzkO4rIytGgHz8Cqc/NMyQOHn1ycuU7yFQX+kOQhWz5pP4m6oK1aSpVJt2Uh7fD6ba2xIYTjcApfF8tzp//mJZkxzLQeYtLWTLJsQy2dcN9ZGeCu3mjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623979; c=relaxed/simple;
	bh=rdetp5rhJ1VDym4hkXIQlBqoc22+/8c1n2b3gybEJ7U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Gd8KJpY5yUc6Pm/qA/SEQWFLavS07Y1IMvpXk97y2tZv9nwhcV6T2xBz8hLUfNqhiyKoethOdzbR1kgGU1yrx+lKqaJm6ZHd6BELClVG48YqJVz4dN9Pm3yaPJ0lkaNycwHGPaRp9Kp5cRhalE/ErD3xQPgIecK0h7PafCgMhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sjaVM3jp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sjaVM3jp"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dc8961f5a9so463630a12.1
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 09:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708623975; x=1709228775; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwM8lz+0x/pV+VpLhdmoYO+IjnSV2xwYjYwCDyfKDyo=;
        b=sjaVM3jplQHHTKEaUE2kLxAO+NAZCwLYUk+ZgtS0TTIPW/zYDMbtbzMfdAJxqufiuL
         mZ3cYODH/ZAwwGaDx0OPcnUs5PgELri1EMseOWgRP/lOB4WisusC9vHrZuTy46QcPIS1
         GUhxv7E9lnREOlhmGZ4G6VVilO9VLli/iaoR/kFrL0KS1cjHy5nFvJW4UYObAowc/TPQ
         kvTorC/NPDZFz3DxqgcCIOdPrSL2rvnIU5xCkfVFPPso6JCeDaoW86wT3xgk9F5oMCqd
         odpJnDG/zLN7deskuRIrQZYpOy9iH8/w3TC17OGB/aQSvmBBJeGWviKU0EyiyLp4o1Ys
         1lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623975; x=1709228775;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NwM8lz+0x/pV+VpLhdmoYO+IjnSV2xwYjYwCDyfKDyo=;
        b=EE6H3lKV8Sv+nTM+3nrDrqH8glBu50X7xn8Wb/UVjpdHJjL6xtHRLHEBpJxXAHCEhK
         rVl0Mt/tNftUZJVWG1ykOkeEGFu7ahAXZLnKfh34l1EEnv8dwBuZyurVc5E6BHboyL2e
         TH0XpigIuSixl7Z8II2WoSaNH5oBk4Wqn3iVQq8Pfprv2VwfrDNIYBbDNBvQ1/g3iJAi
         N/BLUkfjoFzJ0agCGbBrB4NFLvvT95R4GFZBXqkc0WaQCC3nPS3CNzwlmeGXxytBjY+s
         z14Ka83Ig9n4PQL0BeICHhVizi4ZKHmO4aodTua7ubIzjqaRwK60KNGrUyywQcwxz3Lc
         In6g==
X-Gm-Message-State: AOJu0YxOnwwu8KX59ikteHndf0GGwIov5RzH3HCJMPDnJcBLA8j/kyWc
	pwBk5kr3bCbML7nTkqK+wlWMu83t9ek06GbTqNyh/coFIzqWyClRk+Fbq0OnbcAiBWZB/KswDnc
	H
X-Google-Smtp-Source: AGHT+IEcx4r5nHjuxitznBzBBVHqIgeME9AMO0goSLMQmLBftYNlxz1KAN866/c9BIdd3oiUncdcrw==
X-Received: by 2002:a05:6a20:da83:b0:1a0:7fa7:52b with SMTP id iy3-20020a056a20da8300b001a07fa7052bmr23708724pzb.5.1708623975618;
        Thu, 22 Feb 2024 09:46:15 -0800 (PST)
Received: from [172.20.8.9] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id fk10-20020a056a003a8a00b006df50bbbaecsm11286973pfb.86.2024.02.22.09.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:46:15 -0800 (PST)
Message-ID: <a9ffa3a2-2b49-409a-a256-a70f8f38b8e5@kernel.dk>
Date: Thu, 22 Feb 2024 10:46:14 -0700
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
Subject: [GIT PULL] Block fixes for 6.8-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes that should go into this release. Mostly just fixlets for
md, but also a sed-opal parsing fix.

Please pull!


The following changes since commit 9c10f2b172eb26007e9b641271798234911d24c2:

  Merge tag 'nvme-6.8-2024-02-15' of git://git.infradead.org/nvme into block-6.8 (2024-02-15 09:42:03 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.8-2024-02-22

for you to fetch changes up to 5429c8de56f6b2bd8f537df3a1e04e67b9c04282:

  block: sed-opal: handle empty atoms when parsing response (2024-02-16 15:52:45 -0700)

----------------------------------------------------------------
block-6.8-2024-02-22

----------------------------------------------------------------
Greg Joyce (1):
      block: sed-opal: handle empty atoms when parsing response

Jens Axboe (1):
      Merge tag 'md-6.8-20240216' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.8

Yu Kuai (6):
      md: Fix missing release of 'active_io' for flush
      md: Don't ignore suspended array in md_check_recovery()
      md: Don't ignore read-only array in md_check_recovery()
      md: Make sure md_do_sync() will set MD_RECOVERY_DONE
      md: Don't register sync_thread for reshape directly
      md: Don't suspend the array for interrupted reshape

 block/opal_proto.h  |  1 +
 block/sed-opal.c    |  6 ++++-
 drivers/md/md.c     | 70 +++++++++++++++++++++++++++++++++--------------------
 drivers/md/raid10.c | 16 ++----------
 drivers/md/raid5.c  | 29 ++--------------------
 5 files changed, 54 insertions(+), 68 deletions(-)

-- 
Jens Axboe

