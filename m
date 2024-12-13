Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADEB189BAC
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122923; cv=none; b=H13d5yw7/l355QVsdFrr0PJhfdaW4jKZg5J6Dwx/5IlILacT+n6eiNnVINCg3A8DVLJn5fDc/4LjuTtqWi6qnVba9DskPmGM6unUJLTCDaKX6xhu/to+0JhRSRuIW520tf4XFsykiVa+FBFulE6hbQKJ0mSnEIhtWpjnx5KMwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122923; c=relaxed/simple;
	bh=Mq7bWhatGkG58ih9K3DVUt02PdUa8dYdfx3U5DHnIVY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RVbX8fwI0K1naWOcFPQ0q2zjreC2PJNu5GTSvI5T0yj6oIkOTg4MRvuYyCO/vHT4gOj3RuJCaLnSIvqYkuPl/IqrUKjf617FcubzJoVPp14JW/v8EqKRVz2+IwK57ksC8y682ppGHgeq/7UpYu+liXc+NOM048F2uMPuJ3KmCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UQjfKSZh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UQjfKSZh"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728e3826211so1856931b3a.0
        for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 12:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734122920; x=1734727720; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCBIpej8Bar3OmRXFKc1fy+D4p8b1SV4OEjdinqmxcU=;
        b=UQjfKSZhNfWt0TIqSN12oyUUn4Fz1+SNyfXX+1GjNzM5En3b7qIkZKqupdP3t164W6
         Hjb8cYlFQIaC/YzUh65LEh2Le1QXW0eA1G7szG+Z9sOBH2SZcuekoqnzI3+IlCur95QP
         VaHB23ihUIHokrl/WLWOfMqSfSuucp6AcVjz+ECawDePLwktw9+lEvFNMrvUa4M4QrTI
         BevdcYl6x47yWrgAGM71nK/XlCHR+hbI6o4tam1zzVsz+y/a6I6Nj1sQ1AK1rjQUr/8l
         tDfJ+4BE3Ttc2dhYToovDtPijf+gbNnrRnFzY5VUO+6TYwMjTzCqESaH2UQ8I1i4bp1x
         o+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734122920; x=1734727720;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uCBIpej8Bar3OmRXFKc1fy+D4p8b1SV4OEjdinqmxcU=;
        b=k5Uw05B+XsAJd4T5Z0e1G3Cv566baBCFWMVE5XUECacU81dYQrNm3mBJon2IELldEI
         yP6HZYUkbGXi6fOBuQwRcVf5bH84PiNLFrpfNZPdUaIa493gArDJupl/b8MBOIiks7QE
         eplMNrkIzZ2sqXnPS0jnC/eg3JsH6cUB9TFw1Crc3rcN+wio+x10/dqNYK8Oh4M/FwV9
         Sj/qMaKcEOy2KantAphW06nBRJc1WD+jL1rchXa7wfd1+x0aoJEH9rWf54pvv2Vjlniu
         M5HuQKggnDWmIaUb4bLlIJnrgsAWdSnkp8vM0MUo2hTe9seKk087UIPWa3U03auGe5OE
         JSzQ==
X-Gm-Message-State: AOJu0YzJvRYjt/LxRPkrB+Emh21APm+k4iF3lHLyZw4/jNeUyYxyWMJ0
	8RKGSJ/OzlGAdum700gcOWDbV5h40/RKyjLXK4XdFEWnz4TshllIYvKUztcsWhSMGr2XbY0yzHe
	s
X-Gm-Gg: ASbGncsY7dT69TsjLPJQwjwiOvJfPcV1rhhO351ZOADctmUsK9Mn2hgiIvdYlRpcCrf
	BdXv+52OI6OYAEZ5NRE9ejMdLEAOpdDWlU6m30AxOh8zSLujpfU0bIPGZj66SfFl4IA9mLnnRvV
	seA7O3F8Uda6xqDHgQgWIOgdmZhn+76xUoeYlVHIzQpvxgzAIYX9WFo6LhHnYGjxwj9b58/UXD3
	dZOgi6nabV8XjMPIlUQa46HJuN1pqCxjAie5ZzZ/1gypFkY0gE0aw==
X-Google-Smtp-Source: AGHT+IFHdmM6EXwify/Qy89AwlgbrmSe1GAVm3qfPI7T7j0DudiX+SDcv8sCR+ARbLC6Vc5swYxWig==
X-Received: by 2002:a05:6a00:288a:b0:728:cd4f:d5d7 with SMTP id d2e1a72fcca58-7290be874e5mr6198089b3a.0.1734122920174;
        Fri, 13 Dec 2024 12:48:40 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5296sm218570b3a.22.2024.12.13.12.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 12:48:39 -0800 (PST)
Message-ID: <d2acd3cb-188c-4ad5-91db-efbc6e50a1c1@kernel.dk>
Date: Fri, 13 Dec 2024 13:48:38 -0700
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
Subject: [GIT PULL] Block fixes for 6.13-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A collection of fixes for the block area, which should go into the
6.13-rc3 release. This pull request contains:

- Series from Damien fixing issues with the zoned write plugging

- Fix for a potential UAF in block cgroups

- Fix deadlock around queue freezing and the sysfs lock

- Various little cleanups and fixes

Please pull!


The following changes since commit 22465bbac53c821319089016f268a2437de9b00a:

  blk-mq: move cpuhp callback registering out of q->sysfs_lock (2024-12-06 09:48:46 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.13-20241213

for you to fetch changes up to be26ba96421ab0a8fa2055ccf7db7832a13c44d2:

  block: Fix potential deadlock while freezing queue and acquiring sysfs_lock (2024-12-13 10:51:58 -0700)

----------------------------------------------------------------
block-6.13-20241213

----------------------------------------------------------------
Bart Van Assche (3):
      mq-deadline: Remove a local variable
      blk-mq: Clean up blk_mq_requeue_work()
      block: Fix queue_iostats_passthrough_show()

Coly Li (1):
      MAINTAINERS: update Coly Li's email address

Damien Le Moal (4):
      block: Use a zone write plug BIO work for REQ_NOWAIT BIOs
      block: Ignore REQ_NOWAIT for zone reset and zone finish operations
      dm: Fix dm-zoned-reclaim zone write pointer alignment
      block: Prevent potential deadlocks in zone write plug error recovery

John Garry (1):
      block: Make bio_iov_bvec_set() accept pointer to const iov_iter

LongPing Wei (1):
      block: get wp_offset by bdev_offset_from_zone_start

Nathan Chancellor (1):
      blk-iocost: Avoid using clamp() on inuse in __propagate_weights()

Nilay Shroff (1):
      block: Fix potential deadlock while freezing queue and acquiring sysfs_lock

Tejun Heo (1):
      blk-cgroup: Fix UAF in blkcg_unpin_online()

 MAINTAINERS                   |   2 +-
 block/bio.c                   |   2 +-
 block/blk-cgroup.c            |   6 +-
 block/blk-iocost.c            |   9 +-
 block/blk-map.c               |   2 +-
 block/blk-mq-sysfs.c          |  16 +-
 block/blk-mq.c                |  39 ++--
 block/blk-sysfs.c             |   6 +-
 block/blk-zoned.c             | 508 +++++++++++++++++++-----------------------
 block/mq-deadline.c           |   5 +-
 drivers/md/dm-zoned-reclaim.c |   6 +-
 include/linux/bio.h           |   2 +-
 include/linux/blkdev.h        |   5 +-
 13 files changed, 279 insertions(+), 329 deletions(-)

-- 
Jens Axboe

