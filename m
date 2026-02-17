Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF418A921
	for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 03:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771300735; cv=none; b=npr28pvF59Wi40qnO6nUdzgtOVGmZbm5Ajk0J8AVx+UFsHRrcItTng7wOFbK2olM4ZjpsxVuyq1Z+HeFTznOptYRYRG9e/9vj4yS6cpPDcm/l/3mBOydvXCsb8fw1OiDuK2EGU19bceKyEzwFYD7wdskj8p/KolQEzs9C3OKVcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771300735; c=relaxed/simple;
	bh=02cmp6eWhvsy18s/dLkg9Ovv//m7jdKg0lobHaUzLqE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MiYJbmj5UTlVnOpSBCuo2Rq+X8WRPfrzGYrz++nzWF7COGyV8AYR1GWMlLBclEzO5PpNqm4cpoRzRMqfoGm6OD4s4LjvawbS2SnOvjlBpWWl9G+iBu14XbWitqIg75C2jZD3Tti6kDB5V09N+v9uj+he8L/rkdqA0SFPjzQa1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=l8zCUeF+; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="l8zCUeF+"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46398742245so894005b6e.1
        for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 19:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771300732; x=1771905532; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+J6sBI/eGPLuIpzrtHt1QbHvoyOMcYzEMwqoBZlqww=;
        b=l8zCUeF+/Sp8OXgfwX1Ko2pT/ljLn+mXh7xn4xjOtZNDSD/x+fW12gLpoYxC8UIYii
         hWsnGOdc035ZZ1Q9VD5DEHvO4lqJ6aeluJDVym6n7YlZRpJ97ZGoo2Dl7wN5dkBp2BUK
         8PaK/5jJ3RhB5kJTRYUTQaXkWsS1i8yKOyYvXKU3dBTOkXERKh9WC/XxxV+O3c8Ccg3C
         zSdIwa0OwQGGCi/V2rHwVSXMFojHv1Gqe0sPpTxGbVZ/4DGEyidqkN0TZbstDJFazxhd
         X7nJ/Nq9afTdnaKixT52ykqE3h3efa/woH22syteCKL0cvtWmI87z/lcQnc853hPDrKD
         /kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771300732; x=1771905532;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+J6sBI/eGPLuIpzrtHt1QbHvoyOMcYzEMwqoBZlqww=;
        b=hkBeR0YcZR0U4sVYNrMSvB/5mcmMYXwTpR1Ikdahh2XXVH/urQ7/bgip8rVoWZwDVZ
         Faf/jWezIzfFanvkhzhbMDtoIcaRqMDsBNlvUTcw7km+OqiBh6LUIPrHnnbxK/s+VsLb
         VU7TIzzhrxzh5EDGZcUP35a2PUyDOxkAvkbVuH7262G+e94E5bD5e/5HrBIYaB7mDnBd
         uFsJmfnwbUoL9ziMwakSz5/p+I+d5JJHv5bcPkESSVgo3XKR7gPJ5srfs9gYHfxjkk8o
         AVEpp9wWoABzpSEyk+GtmqNpbCRbNPnySUoFlZ58cKBTrvkr5i5ralhKuD/tvrHTpRVz
         LyWw==
X-Gm-Message-State: AOJu0YyJlq8Pe1SkNoImEyvK4zNvhquHC6ugknn22y3+QjLMh5DmBiEk
	whQy2TKhINsyMqJz7l+OShvfvWmpBGyUGnOEc/zEVMVuR3hcEsX6vkDBzey/ROr4HOvWeprsp0j
	BJn4nCqc=
X-Gm-Gg: AZuq6aLwJ4gavgLhhIf6VRkw7TwGYLhj/YZjUUmdXjQJ3OfvRxLmnOseKFJ3zuYvNmC
	OYzhaHwhf+Uho9CAQcuIckRtHHD9GTrH1+4zdFgACxOrEfIHIdIfblx76eRri+kpei4XBEWiu89
	RQyKd2ymulmNYwgrOP2V1GVq2jRmDvZM63yAH70CEN0Gx4BRWiZmx9V+QVQrFUAeN8sSizqIri4
	vsuCACOdi41UpvU0zmmgUWPXGbHbXBcNic/jjfumrj5YG/pfj1Jev5/wha/B18S63yTMOpjRTlg
	FZ4014e4p/+fnuNZGi70GInBJdn/xzq4FDETqSDHvKPk+NikzK4TKYfiKxF+1quBSSuPkSX43nz
	Izq+YzM1EyxVDLTxb7kuTSVrA3prykKaSnKSYK54qiWRkxsEq1MPW6b/u7hjZr7m6n6um3Aep7Q
	5/SA5TKOouqKMI9tdqjz3FZkPBM4/9RDvhU2IHqRV+b4v6ZLoESYUwXVE2Ivfp+5zR1rm+TstEC
	zfV9K2DpA==
X-Received: by 2002:a05:6808:1393:b0:45e:f089:99dd with SMTP id 5614622812f47-4639eb70221mr6538117b6e.0.1771300731936;
        Mon, 16 Feb 2026 19:58:51 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4636b065d5csm11972065b6e.13.2026.02.16.19.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 19:58:50 -0800 (PST)
Message-ID: <bb793bbc-5f7a-4cb5-bb05-5cdaa0ab8a7a@kernel.dk>
Date: Mon, 16 Feb 2026 20:58:49 -0700
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
Subject: [GIT PULL] Final block fixes and updates for 7.0-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes for block that have been queued up since the initial block
core pull request. This pull request contains:

- Fix partial IOVA mapping cleanup in error handling

- Minor prep series ignoring discard return value, as the inline value
  is always known.

- Ensure BLK_FEAT_STABLE_WRITES is set for drbd

- Fix leak of folio in bio_iov_iter_bounce_read()

- Allow IOC_PR_READ_* for read-only open

- Another debugfs deadlock fix

- A few doc updates

Please pull!


The following changes since commit 192c0159402e6bfbe13de6f8379546943297783d:

  Merge tag 'powerpc-7.0-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2026-02-10 21:46:12 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260216

for you to fetch changes up to dfe48ea179733be948c432f6af2fc3913cf5dd28:

  blk-mq: use NOIO context to prevent deadlock during debugfs creation (2026-02-16 10:47:25 -0700)

----------------------------------------------------------------
block-7.0-20260216

----------------------------------------------------------------
Andreas Hindborg (1):
      block: update docs for bio and bvec_iter

Chaitanya Kulkarni (4):
      block: fix partial IOVA mapping cleanup in blk_rq_dma_map_iova
      md: ignore discard return value
      nvmet: ignore discard return value
      block: change return type to void

Christoph B?hmwalder (1):
      drbd: always set BLK_FEAT_STABLE_WRITES

Jens Axboe (1):
      block: fix folio leak in bio_iov_iter_bounce_read()

Randy Dunlap (2):
      block: fix enum descriptions kernel-doc
      blk-stat: convert struct blk_stat_callback to kernel-doc

Stefan Hajnoczi (1):
      block: allow IOC_PR_READ_* ioctls with BLK_OPEN_READ

Yu Kuai (1):
      blk-mq: use NOIO context to prevent deadlock during debugfs creation

 block/bio.c                       |  4 +++-
 block/blk-lib.c                   |  3 +--
 block/blk-mq-debugfs.c            | 10 +++-------
 block/blk-mq-dma.c                | 13 ++++++++-----
 block/blk-mq-sched.c              |  9 +++++----
 block/blk-stat.h                  |  9 +++++++--
 block/blk-sysfs.c                 |  9 +++++----
 block/blk-wbt.c                   | 10 ++++++----
 block/blk.h                       | 31 +++++++++++++++++++++++++++++++
 block/ioctl.c                     | 34 +++++++++++++++++++++++-----------
 drivers/block/drbd/drbd_main.c    |  3 ---
 drivers/block/drbd/drbd_nl.c      | 20 +++++++++++++++++++-
 drivers/md/md.c                   |  4 ++--
 drivers/nvme/target/io-cmd-bdev.c | 28 +++++++---------------------
 include/linux/blk_types.h         | 33 ++++++++++++++++++++-------------
 include/linux/blkdev.h            |  2 +-
 include/linux/bvec.h              | 29 +++++++++++++++++++++--------
 kernel/trace/blktrace.c           | 38 +++++++++++++++++++++-----------------
 18 files changed, 183 insertions(+), 106 deletions(-)

-- 
Jens Axboe

