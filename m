Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1681C27
	for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834975; cv=none; b=Q44d5Lhrs9a0sZEp40qWPvo2pG0m1+lvQ99AlM06ki0t7I22ittbBthNGaAQlBBs525Qlnvfbz0Z8aaDL4bcraYpjm9/1QtFVJz0O69upP3n5W3OP9uOK3Ev+8P8WLEr8nN95sBZoW950Wl88C+jLqceuaHohcIz4xBl83aNA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834975; c=relaxed/simple;
	bh=yJulIx5Jdu/ANiHZgztyyQgFODLRkmcuOLK7sWJyujs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=btLxbE4TOxw4biZOcWsn7NU2E4Hd/N+A8XuNTUKKpCnSdpseJ8jovN4/YXnhm+GKITX2QiQ1Sj0kP+8wQGvDcZ4I9FeOrZrDtFC0wkcB4lLw2wKEwtJ4Yp/mqCXnuAmBHT+VGwwXg/CbjKFWgEJ93LXB86j0mqGpmBKEXkwR1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zrmZjwSX; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zrmZjwSX"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39b3a9f9f4fso1466545ab.0
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 12:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723834971; x=1724439771; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YfrnOBpAm6Irhcb5VIa1tWyOWS9/ezixO/rJOuImx0=;
        b=zrmZjwSXJkwVDpRQABGDAS4gK/d9GepOzTCynsWelSxZU7CryOwPEJWYoqM311jTJK
         vfOmhD/Vv7dGpK62kRW++6Zz/aPA2v1cBrK6KLAxNvocJrSyKaLMRQkG7FVhxvxv4tFA
         UkO6YZAllEoUoenXaW7D5plaeKk2+pidbfJ7ISzb50TcodcjQR05fyD38c2CnRYwnx34
         soNmNSfZIOGuRqzSGuq9tPaow0C6Tea+XULq02rLX+McLIhFzy3cvVaiIcauOpHvIKZl
         09QdHSHkdVRMzZ1cs8u02/te8mi+/mfYpQ77Qww/ob2+rM8kKZiSqRxXyCdxI82qnv+f
         mJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723834971; x=1724439771;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+YfrnOBpAm6Irhcb5VIa1tWyOWS9/ezixO/rJOuImx0=;
        b=xK/SUz1HvEauEkYNhhm2TOPNNdZhRfvfoKMG/FOOvpJfiZOc39yNzO5qfv/HtYYL+4
         VxryPR3Fa4bI0O4TQ7S+hMjpntUbj2UjtgjdGFYl+8jKIGyTCW1fD9aVdYTwZhkck8ie
         1dui/7cn3OVWJBEtuJ8pzk74h7444SQK/4VwAhyEGbzBp7byAJOHjg3Gz9YCTcz8kvUY
         +/nNTkIdNnFIX6JpYRJMzK0kYjRua7P9196bfZhk/LxeERXSThpG5faj9Q4VgpVzvaBU
         im6dXJ0Wp6uqnOCZo1VW9IzIfRTXw+CkqFVUuAZouR2CWMG5XpGrWSZ3kz4rEVG7aBzp
         BvQA==
X-Gm-Message-State: AOJu0Yy7gfnpxXO4h6lsitxXBYjV7S38Lbun9e1RChfoK2bZuO2Dhvpu
	Dvq/lE7tyy3mY30DBvlDjNHYTVC7A7j+IQsBTl0RhT7tfjIwbsRCBbjfPlEx815MbN6d6MXDWNA
	Y
X-Google-Smtp-Source: AGHT+IGruKZ0lNFTJgZMWDkgbHeDk/bD5Ae8EkvdOWDKw4sMIxrCGC0Jum03tDmMij0WrRxkZhENeg==
X-Received: by 2002:a5d:91c9:0:b0:822:3c35:5fc0 with SMTP id ca18e2360f4ac-824f2721fa8mr262560439f.3.1723834971404;
        Fri, 16 Aug 2024 12:02:51 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6f74c38sm1388166173.135.2024.08.16.12.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 12:02:50 -0700 (PDT)
Message-ID: <1c41cbc8-dd07-42ba-a192-665103012e64@kernel.dk>
Date: Fri, 16 Aug 2024 13:02:50 -0600
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
Subject: [GIT PULL] Block fixes for 6.11-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes for the block side for the 6.11 release:

- Fix corruption issues with s390/dasd (Eric, Stefan)

- Fix a misuse of non irq locking grab of a lock (Li)

- MD pull request with a single data corruption fix for raid1 (Yu)

And I just now notice that I used the wrong data on both this one and
the io_uring pull request. Oh well, it's just a tag name.

Please pull!


The following changes since commit eded04fe3bdad9b11bc82b972b4c6fa79f1726ba:

  Merge tag 'nvme-6.11-2024-08-08' of git://git.infradead.org/nvme into block-6.11 (2024-08-08 12:27:40 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.11-20240824

for you to fetch changes up to b313a8c835516bdda85025500be866ac8a74e022:

  block: Fix lockdep warning in blk_mq_mark_tag_wait (2024-08-15 19:25:03 -0600)

----------------------------------------------------------------
block-6.11-20240824

----------------------------------------------------------------
Eric Farman (1):
      s390/dasd: Remove DMA alignment

Jens Axboe (1):
      Merge tag 'md-6.11-20240815' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.11

Li Lingfeng (1):
      block: Fix lockdep warning in blk_mq_mark_tag_wait

Stefan Haberland (1):
      s390/dasd: fix error recovery leading to data corruption on ESE devices

Yu Kuai (1):
      md/raid1: Fix data corruption for degraded array with slow disk

 block/blk-mq-tag.c                 |  5 ++--
 drivers/md/raid1.c                 | 14 +++++++---
 drivers/s390/block/dasd.c          | 36 ++++++++++++++++---------
 drivers/s390/block/dasd_3990_erp.c | 10 ++-----
 drivers/s390/block/dasd_eckd.c     | 55 +++++++++++++++++---------------------
 drivers/s390/block/dasd_genhd.c    |  1 -
 drivers/s390/block/dasd_int.h      |  2 +-
 7 files changed, 63 insertions(+), 60 deletions(-)

-- 
Jens Axboe

