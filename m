Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000D5125DE
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481043; cv=none; b=SDRl08vznc5LeTWILSR6brAK87OWe6jUjV1u4+D0moJiUDsmvxLianohlMFwEz74O7W2+BYoYPTfMKIxkekvfr+BpFKqOkbLHftQKkq7B3lDP7Y/goSPVcmZ2z9T1nMIIUybf6937lS4wJW/g2Vfj4z/nIpK05cr8fTsPBiH100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481043; c=relaxed/simple;
	bh=hfjm9J2XbJtmycTTEZ07y0luKw60MRdFxgh5XwiKcXE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tcwfqgXmf79iyrh98SD3TC8lmc2Wqmkiu/3mx1Qje9HyrbXKGoAKvMfd3bTAxaLnXxE6F879p1GGCldi0jcHV77uT0bjDuctJtnvqkX4RCwLe9izHDjVnB8TTrmsTU/gt033bfXu6FP4U68pe+2aWdbph6l3NJ4SikCXg7sF+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JcVuIeKV; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JcVuIeKV"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-37215bacfbeso1690745ab.0
        for <linux-block@vger.kernel.org>; Thu, 23 May 2024 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716481040; x=1717085840; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcikrIIjTkWkP+cZIoNGMnPlNq9rpRJzUa+wHtTlDeg=;
        b=JcVuIeKVW4NHVjjlm60Z0I0Q+rrHiVGYndSS70Rk3Hq9quY7KugDIbAzXy5Q9xwhXW
         jcUdm3jUXBqsdfDtLSzEs3gIbEsCVIrXZfTAzYdfv4Z+0W2GjptH0beje+0OC+ePU9PM
         Xna6HdjQvDWmEFA9x2qcaCBB+EGe6f85ep3JGzF6xgb0DJttWE/ec15WOs9A04agiZNS
         t3uZrDzgrhkbMgy8MsBCEHifNVMPIYg5XgvqsTHcZTeIlfUor8FY7VsYAmXKbtiDglMv
         jbOJa3LztvoPIoEed+bZgQ/2Y+QpzCr3FlO+RwVphuSjhkK8ht4fM0tEPZ4QGBHtHdOY
         loeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716481040; x=1717085840;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OcikrIIjTkWkP+cZIoNGMnPlNq9rpRJzUa+wHtTlDeg=;
        b=gdZ6tuyaTL0MdAIomKQyevoDEksoLrJGGO/HJ2AFMNU4/3rNjub+RAIWGVgJqapgjO
         imr1DKmB1ZVnUd9mfMv2Cq09pNJ0qjDn2m7quId8gAzQAv2KtC7hJiPDzLzNMY2nkr0B
         9P1p9/x++6Xyc0GTfUQQZOux1c+bnchgKjXZSmhZVnNcydU83seoWI+7irbCqFIJmy/k
         VptEYCGaonH7Bxo0gOTqt3VT1jn97F8ndSPTXD5J3bXm1WbXdcchHN/elabbETrxR1U6
         cc7JSaNTJI1Xp0MuvfkjL52oiMybiSrFEapwMvy6KVev2LimDEAcwql4DEC601VAZr6y
         yaGQ==
X-Gm-Message-State: AOJu0YyrQDjrYvLBekFjnGE5l4RX32Tktclb9+cWnUSiTCLQzIK+u2lD
	TODMaFkSfxWnN4RQST8XURG4u41GNU97sTByl0bFzrhW+kIZnef4+KhuE4d4+yvuvt8JgqACs6+
	Y
X-Google-Smtp-Source: AGHT+IGDjSy1BasyrI8O0tfVoR5k+LHIM1Z3sV9/H7Zoz4YtqQOG0I2eg9SoN2OO2F4/kj6JjijDlg==
X-Received: by 2002:a5d:84ca:0:b0:7de:f48e:36c3 with SMTP id ca18e2360f4ac-7e360c17344mr563368439f.0.1716481040037;
        Thu, 23 May 2024 09:17:20 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-48a5cf9fec9sm4702316173.127.2024.05.23.09.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 09:17:19 -0700 (PDT)
Message-ID: <9287b1fa-f8d5-475a-8846-47cf79b1a577@kernel.dk>
Date: Thu, 23 May 2024 10:17:18 -0600
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
Subject: [GIT PULL] Block fixes for 6.10-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Followup block pull request for 6.10-rc1, mostly due to NVMe being a bit
late to the party. But nothing major in there, so not a big deal. In
detail, this pull request contains:

- NVMe pull request via Keith
	- Fabrics connection retries (Daniel, Hannes)
	- Fabrics logging enhancements (Tokunori)
	- RDMA delete optimization (Sagi)

- ublk DMA alignment fix (me)

- null_blk sparse warning fixes (Bart)

- Discard support for brd (Keith)

- blk-cgroup list corruption fixes (Ming)

- blk-cgroup stat propagation fix (Waiman)

- Regression fix for plugging stall with md (Yu)

- Misc fixes or cleanups (David, Jeff, Justin)

This will throw a merge conflict in block/blk-core.c due to the changes
from Al, however it's very minor. I'm including my resolution below, but
if you need it, we'll have to revoke your git merge card. Look at your
own peril.

Please pull!


The following changes since commit a7c840ba5fa78d7761b9fedc33d69cef44986d79:

  Merge tag 'tag-chrome-platform-firmware-for-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux (2024-05-13 16:48:15 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.10-20240523

for you to fetch changes up to a2db328b0839312c169eb42746ec46fc1ab53ed2:

  null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues' (2024-05-23 06:58:13 -0600)

----------------------------------------------------------------
block-6.10-20240523

----------------------------------------------------------------
Bart Van Assche (6):
      null_blk: Fix two sparse warnings
      nbd: Use NULL to represent a pointer
      nbd: Remove superfluous casts
      nbd: Improve the documentation of the locking assumptions
      nbd: Remove a local variable from nbd_send_cmd()
      nbd: Fix signal handling

Daniel Wagner (1):
      nvme: do not retry authentication failures

Dr. David Alan Gilbert (1):
      blk-throttle: remove unused struct 'avg_latency_bucket'

Hannes Reinecke (4):
      nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
      nvmet: return DHCHAP status codes from nvmet_setup_auth()
      nvme: return kernel error codes for admin queue connect
      nvme-fabrics: short-circuit reconnect retries

Jeff Johnson (1):
      block: t10-pi: add MODULE_DESCRIPTION()

Jens Axboe (2):
      ublk_drv: set DMA alignment mask to 3
      Merge tag 'nvme-6.10-2024-05-14' of git://git.infradead.org/nvme into block-6.10

Justin Stitt (1):
      cdrom: rearrange last_media_change check to avoid unintentional overflow

Keith Busch (1):
      brd: implement discard support

Ming Lei (3):
      blk-cgroup: fix list corruption from resetting io stat
      blk-cgroup: fix list corruption from reorder of WRITE ->lqueued
      blk-mq: add helper for checking if one CPU is mapped to specified hctx

Sagi Grimberg (1):
      nvmet-rdma: Avoid o(n^2) loop in delete_ctrl

Tokunori Ikegami (1):
      nvme-rdma, nvme-tcp: include max reconnects for reconnect logging

Waiman Long (1):
      blk-cgroup: Properly propagate the iostat update up the hierarchy

Yu Kuai (2):
      block: fix lost bio for plug enabled bio based device
      null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'

 block/blk-cgroup.c                     | 87 ++++++++++++++++++++++++----------
 block/blk-core.c                       | 13 ++---
 block/blk-mq.c                         | 20 +++++++-
 block/blk-throttle.c                   |  5 --
 block/t10-pi.c                         |  2 +-
 drivers/block/brd.c                    | 26 ++++++++++
 drivers/block/nbd.c                    | 41 ++++++++--------
 drivers/block/null_blk/main.c          | 42 ++++++++++------
 drivers/block/null_blk/trace.h         |  7 ++-
 drivers/block/ublk_drv.c               |  1 +
 drivers/cdrom/cdrom.c                  |  2 +-
 drivers/nvme/host/auth.c               |  6 +--
 drivers/nvme/host/core.c               |  6 +--
 drivers/nvme/host/fabrics.c            | 51 ++++++++++++--------
 drivers/nvme/host/fabrics.h            |  2 +-
 drivers/nvme/host/fc.c                 |  4 +-
 drivers/nvme/host/nvme.h               |  2 +-
 drivers/nvme/host/rdma.c               | 23 +++++----
 drivers/nvme/host/tcp.c                | 30 +++++++-----
 drivers/nvme/target/auth.c             | 22 ++++-----
 drivers/nvme/target/configfs.c         | 22 +++++++--
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++----------
 drivers/nvme/target/fabrics-cmd.c      | 11 +++--
 drivers/nvme/target/nvmet.h            |  8 ++--
 drivers/nvme/target/rdma.c             | 16 +++----
 include/trace/events/nbd.h             |  2 +-
 26 files changed, 314 insertions(+), 186 deletions(-)


commit 33682c9a0f7aea5a9be2187dcb7d9591fbc70c94
Merge: c760b3725e52 a2db328b0839
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu May 23 10:06:39 2024 -0600

    Merge branch 'block-6.10' into test
    
    * block-6.10: (24 commits)
      null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'
      blk-throttle: remove unused struct 'avg_latency_bucket'
      block: fix lost bio for plug enabled bio based device
      block: t10-pi: add MODULE_DESCRIPTION()
      blk-mq: add helper for checking if one CPU is mapped to specified hctx
      blk-cgroup: Properly propagate the iostat update up the hierarchy
      blk-cgroup: fix list corruption from reorder of WRITE ->lqueued
      blk-cgroup: fix list corruption from resetting io stat
      cdrom: rearrange last_media_change check to avoid unintentional overflow
      nbd: Fix signal handling
      nbd: Remove a local variable from nbd_send_cmd()
      nbd: Improve the documentation of the locking assumptions
      nbd: Remove superfluous casts
      nbd: Use NULL to represent a pointer
      brd: implement discard support
      null_blk: Fix two sparse warnings
      ublk_drv: set DMA alignment mask to 3
      nvme-rdma, nvme-tcp: include max reconnects for reconnect logging
      nvmet-rdma: Avoid o(n^2) loop in delete_ctrl
      nvme: do not retry authentication failures
      ...
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --cc block/blk-core.c
index ea44b13af9af,dd29d5465af6..82c3ae22d76d
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@@ -618,7 -619,9 +621,9 @@@ static void __submit_bio(struct bio *bi
  	if (unlikely(!blk_crypto_bio_prep(&bio)))
  		return;
  
+ 	blk_start_plug(&plug);
+ 
 -	if (!bio->bi_bdev->bd_has_submit_bio) {
 +	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
  		blk_mq_submit_bio(bio);
  	} else if (likely(bio_queue_enter(bio) == 0)) {
  		struct gendisk *disk = bio->bi_bdev->bd_disk;

-- 
Jens Axboe

