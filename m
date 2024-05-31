Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6639AE3
	for <linux-block@vger.kernel.org>; Fri, 31 May 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166040; cv=none; b=TQOd+vAdwDyWFWQIeUEHcCtXHSTBPUVLkm6enkTrcCaEWltCvfNhUyYMPfZTAg4BBjGdVr7CxlP7MpctD7T1ht0UMjR4uNztCbFqTJN3Ko9hfIjbCwmb4q1AIyfpDidHNILqBE3Wa3wWAqgxoe3kWgcwYTUGUmiIkFdOmrBYzn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166040; c=relaxed/simple;
	bh=ZPsHJkSW6lsWZLWxSGyefQfCpMtT9TACp631Rz7driU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=t1EPcdVuA2RceFEZ56W+LoQZykDaQvh/jivfmJ+LPNCzMHNJXjBPGJUZA0ceFumjd3pL5PbKO9PZx09oQcx+eu8gzC753d1h+X4mt+WPmGn9SMD0vveC+wfu6rysJZod498oTLwZHH+opulF9CoyB1YTOBOx2YxVtLb87V7Er2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uQsxvQ/m; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uQsxvQ/m"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f90679d3bbso49846a34.0
        for <linux-block@vger.kernel.org>; Fri, 31 May 2024 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717166035; x=1717770835; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFOiVua3aBgyOhu4hLBGVqqHst3odYdNGRYkuP/usRw=;
        b=uQsxvQ/mHw6hFo9j20WFmOKEnjYxwrgEbA15z36w7G4a2OkXTR/7w6RWUIFEDt9kx4
         MlWklEPkT1pN4Pf+J1GmG7AFaN1yfqJ1wnZhKzBMjgz+KX9/Zlo5Tf6AfQtdEJKU+PIn
         258IkGuVBr7KN8X8sVl98y9z/EuGS0i6pH+mVKP6tEgS015QbZmnqNtWq/4WoJ9CVAAG
         B7EObFga7vRSTTZ0/+CGCZyqgI91FG9jKgLHWtmTkpHWWbTDemV7+/8//Zy5OrUu+K6N
         XesZM+8x2s5XC0ETj1KEm9dE6ZAOsjk+j1lTgBuMEl58U/8QSJ0GA4G1EvyQPPQkE4LN
         UZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717166035; x=1717770835;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UFOiVua3aBgyOhu4hLBGVqqHst3odYdNGRYkuP/usRw=;
        b=HGy/t5ZZCSvbEgd/oq3fv8G7eyAcPjJTdY5vsNdZH6++EZVmLqAA3ZfMFFDvwA9zP6
         3FcoPdQ3HKYtiyXe2dscvYbxM3lSmTrSpGypxERGakLfUWs0E68r1x9sT1iq8/2no4wY
         a4IXfyEGC0zuOygbN34dKyyRgu75mVd+Zv/lXVEpAcrCU/mI+PZkGbuI6KBp5HH5VdJI
         GPqsOqnZ20thOj4vxiQZZI0+9nPZyKlNpKF++/7StnP2Dgp8MrqQNaS6/91ODkChk0fw
         yTTuT4PQKwq+eOhr6rB42TnUEmzbzNgECHO6etyg1NRJEKFrXKgMX+wDfQx/cckrFSOs
         kDMA==
X-Gm-Message-State: AOJu0YyxKzTxrx8zxI+jQLw6vULOA5bJnIe3iwT9pyYUU+M5QdELQPsC
	QcER6O/cfGGqeOjEpLmw2ozM3fhTO9RxFE1Ajfu97qkvdl+4bbSjkaIYUHJtGADPnKi2Xdgx6G2
	r
X-Google-Smtp-Source: AGHT+IEoN5+ABUcXPwxgdm9W65sj3oDwlsdT3q5cU9xhD/BjkQCHcK6hpOCFfs5F67g2RZ6ws2qgdA==
X-Received: by 2002:a9d:6056:0:b0:6f9:543:cc81 with SMTP id 46e09a7af769-6f911fb5679mr2159397a34.3.1717166035030;
        Fri, 31 May 2024 07:33:55 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91059cc5asm345512a34.64.2024.05.31.07.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 07:33:54 -0700 (PDT)
Message-ID: <87063af8-c102-4e64-a00d-15d76786c893@kernel.dk>
Date: Fri, 31 May 2024 08:33:53 -0600
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
Subject: [GIT PULL] Block fixes for 6.10-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Block fixes for 6.10-rc2:

- NVMe fixes via Keith:
	- Removing unused fields (Kanchan)
	- Large folio offsets support (Kundan)
	- Multipath NUMA node initialiazation fix (Nilay)
	- Multipath IO stats accounting fixes (Keith)
	- Circular lockdep fix (Keith)
	- Target race condition fix (Sagi)
	- Target memory leak fix (Sagi)

- bcache fixes

- null_blk fixes (Damien)

- Fix regression in io.max due to throttle low removal (Waiman)

- DM limit table fixes (Christoph)

- SCSI and block limit fixes (Christoph)

- zone fixes (Damien)

- Misc fixes (Christoph, Hannes, hexue)

Please pull!


The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.10-20240530

for you to fetch changes up to 0a751df4566c86e5a24f2a03290dad3d0f215692:

  blk-throttle: Fix incorrect display of io.max (2024-05-30 19:44:29 -0600)

----------------------------------------------------------------
block-6.10-20240530

----------------------------------------------------------------
Christoph Hellwig (6):
      block: remove blk_queue_max_integrity_segments
      dm: move setting zoned_enabled to dm_table_set_restrictions
      dm: remove dm_check_zoned
      dm: make dm_set_zones_restrictions work on the queue limits
      sd: also set max_user_sectors when setting max_sectors
      block: stack max_user_sectors

Coly Li (2):
      bcache: call force_wake_up_gc() if necessary in check_should_bypass()
      bcache: code cleanup in __bch_bucket_alloc_set()

Damien Le Moal (5):
      null_blk: Fix return value of nullb_device_power_store()
      null_blk: Print correct max open zones limit in null_init_zoned_dev()
      null_blk: Do not allow runt zone with zone capacity smaller then zone size
      block: Fix validation of zoned device with a runt zone
      block: Fix zone write plugging handling of devices with a runt zone

Dongsheng Yang (1):
      bcache: allow allocator to invalidate bucket in gc

Hannes Reinecke (1):
      block: check for max_hw_sectors underflow

Jens Axboe (1):
      Merge tag 'nvme-6.10-2024-05-29' of git://git.infradead.org/nvme into block-6.10

Kanchan Joshi (1):
      nvme: remove sgs and sws

Keith Busch (3):
      nvme: fix multipath batched completion accounting
      nvme-multipath: fix io accounting on failover
      nvme: use srcu for iterating namespace list

Kundan Kumar (1):
      nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset

Nilay Shroff (1):
      nvme-multipath: find NUMA path only for online numa-node

Sagi Grimberg (2):
      nvmet: fix ns enable/disable possible hang
      nvmet: fix a possible leak when destroy a ctrl during qp establishment

Waiman Long (1):
      blk-throttle: Fix incorrect display of io.max

hexue (1):
      block: delete redundant function declaration

 block/blk-settings.c           |  10 +++-
 block/blk-stat.h               |   1 -
 block/blk-throttle.c           |  24 ++++-----
 block/blk-throttle.h           |   8 +--
 block/blk-zoned.c              |  47 +++++++++++++----
 drivers/block/null_blk/main.c  |   1 +
 drivers/block/null_blk/zoned.c |  13 ++++-
 drivers/md/bcache/alloc.c      |  21 +++-----
 drivers/md/bcache/bcache.h     |   1 +
 drivers/md/bcache/btree.c      |   7 ++-
 drivers/md/bcache/request.c    |  16 +++++-
 drivers/md/dm-table.c          |  15 +++---
 drivers/md/dm-zone.c           |  72 ++++++++++++-------------
 drivers/md/dm.h                |   3 +-
 drivers/nvme/host/core.c       | 116 +++++++++++++++++++++++++----------------
 drivers/nvme/host/ioctl.c      |  15 +++---
 drivers/nvme/host/multipath.c  |  26 +++++----
 drivers/nvme/host/nvme.h       |   7 +--
 drivers/nvme/host/pci.c        |   3 +-
 drivers/nvme/target/configfs.c |   8 +++
 drivers/nvme/target/core.c     |   9 ++++
 drivers/scsi/sd.c              |   4 +-
 include/linux/blk-integrity.h  |  10 ----
 include/linux/blkdev.h         |   1 +
 24 files changed, 262 insertions(+), 176 deletions(-)

-- 
Jens Axboe

