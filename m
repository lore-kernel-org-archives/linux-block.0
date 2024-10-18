Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A78472
	for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274554; cv=none; b=ocIuqXZK4wJ+L1ElSmj2rNMhwOZ1uL69iEvkopP9MCUe/iiSeYzfXLnhxTsb5pxoArqYvptYwpfD01/5UiQOq6ZsKvLOk6J6+qLjGT461OmTj6cYq1XZQkFZKo3qGK/b7DtK2MniJVFEf7kORnmta55STtySsM66TzhKATvMduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274554; c=relaxed/simple;
	bh=E9cOejgHRKHdsvVhn1KWe45RA5ZLHcQpZtBCFlLnUJY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WSRJqaCrTJlyJ4IEF/9sY0dD5nLoely4tYTQaH+l7JRMTmH6t0O5utW/vv/TwekMDB/mX296w3Y710WhT7jDB0WoplfKCX2FGu5Xnmj7osD1wrrmdR7m1uA8Ovn7RaSHsisuNdYKXz+gGmP8hxzV29Q0E8y1tU4uVHO0V2ejCg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Cjvf8A8q; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Cjvf8A8q"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a3b2499c65so8606115ab.0
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729274549; x=1729879349; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puObo/rJVx0TDOOXrRsE80cMk6efhdGPJX8F3+Hjc4E=;
        b=Cjvf8A8q6AU5dt9ipYh4ht1lwgAEzDOWHyGJDzCm9BNJQdY0pKZgXavlpJZka0qJRj
         sCbNinQtcsdWM4o+gXNMvsj0aavPugxZPhprhxLucmpmCrF8b/5STUj5L34qRUmmmzrw
         Xf6srDx6JJfPzMbLp/RXkYC2PkDGplgSStzgfGsWQyuGr2QOveSJI4XMc/o2KqzziH5G
         BQE4k/PvuLYQD9pMusYPLVTE5SrC8h7FcWndQ5yVJPj5VAq5bCzTv/rM04tkbwuR/0E0
         rJCTpmB7uHTVtgb33nhMaa4agpD4zScHy9CxMkxDcfTwvCeaOFLc3i0TVwa2cgIk7o1W
         PeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729274549; x=1729879349;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=puObo/rJVx0TDOOXrRsE80cMk6efhdGPJX8F3+Hjc4E=;
        b=tPYiZVPob+hmvHSXGRB0WK3pbQBmpW5bzAQHUuiWU1QjWZhzFyqpw/dgYiMFTbSoY5
         S16rDj/MS4/WdFyldHURl9bTRQdez6I1qBOjGxHDHrzxPsb5U0rfpTpA3jwYFtXY8GeV
         rvPEFVoae7AyKkZi+ZexADyFs4EzI4xOUd9o0rs84pk742kyyfEeWuVjPsBORT/9RKPe
         ESUiTz4JZuud/mCLpdZ8KUI8kuwqubrahx5zxfwcOu3E9RRo0TWcv6vyFBQmlEUmk2mc
         l+mjVVaxKIgWpHrF757uqWDBuvy5ErKyLPrZQcnSGHLrHl0osl3OgdeYpezV2V0x5T6j
         R4Fg==
X-Gm-Message-State: AOJu0YwC5KPJf3G7ExbaRt764GxsMTEPlFHkw4yDjro1rGQkWHdHlF+0
	fCZ7meyfKDZZhh1nDsOyLrI8ZXHLnvcmLIkUGJoP9l91aaPbQRykTNEHnmHQggHuZ397gcRRCUJ
	6
X-Google-Smtp-Source: AGHT+IHH+q4VSsBCtaAjgqcMKtpyZnEvvj4mriRCVP3PPFkmln2QrZbVeGgXOCqNWkMZSL7mAaxhVA==
X-Received: by 2002:a05:6e02:2185:b0:3a3:b4ec:b3ea with SMTP id e9e14a558f8ab-3a3f40a843bmr35609785ab.16.1729274549093;
        Fri, 18 Oct 2024 11:02:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10c2b415sm533077173.105.2024.10.18.11.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 11:02:28 -0700 (PDT)
Message-ID: <72c65a83-f629-45ed-b9b9-bc3efd88e86b@kernel.dk>
Date: Fri, 18 Oct 2024 12:02:27 -0600
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
Subject: [GIT PULL] Block fixes for 6.12-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes that should go into the -rc4 kernel release:

- NVMe pull request via Keith
	- Fix target passthrough identifier (Nilay)
	- Fix tcp locking (Hannes)
	- Replace list with sbitmap for tracking RDMA rsp tags (Guixen)
	- Remove unnecessary fallthrough statements (Tokunori)
	- Remove ready-without-media support (Greg)
	- Fix multipath partition scan deadlock (Keith)
	- Fix concurrent PCI reset and remove queue mapping (Maurizio)
	- Fabrics shutdown fixes (Nilay)

- Fix for a kerneldoc warning (Keith)

- Fix a race with blk-rq-qos and wakeups (Omar)

- Cleanup of checking for always-set tag_set (SurajSonawane2415)

- Fix for a crash with CPU hotplug notifiers (Ming)

- Don't allow zero-copy ublk on unprivileged device (Ming)

- Use array_index_nospec() for CDROM (Josh)

- Remove dead code in drbd (David)

- Tweaks to elevator loading (Breno)

Please pull!


The following changes since commit 6d6e54fc71ad1ab0a87047fd9c211e75d86084a3:

  aoe: fix the potential use-after-free problem in more places (2024-10-02 07:16:44 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.12-20241018

for you to fetch changes up to b0bf1afde7c34698cf61422fa8ee60e690dc25c3:

  cdrom: Avoid barrier_nospec() in cdrom_ioctl_media_changed() (2024-10-17 19:47:15 -0600)

----------------------------------------------------------------
block-6.12-20241018

----------------------------------------------------------------
Breno Leitao (2):
      elevator: do not request_module if elevator exists
      elevator: Remove argument from elevator_find_get

Dr. David Alan Gilbert (1):
      drbd: Remove unused conn_lowest_minor

Greg Joyce (1):
      nvme: disable CC.CRIME (NVME_CC_CRIME)

Guixin Liu (1):
      nvmet-rdma: use sbitmap to replace rsp free list

Hannes Reinecke (1):
      nvme: tcp: avoid race between queue_lock lock and destroy

Jens Axboe (1):
      Merge tag 'nvme-6.12-2024-10-18' of git://git.infradead.org/nvme into block-6.12

Josh Poimboeuf (1):
      cdrom: Avoid barrier_nospec() in cdrom_ioctl_media_changed()

Keith Busch (2):
      block: fix blk_rq_map_integrity_sg kernel-doc
      nvme-multipath: defer partition scanning

Maurizio Lombardi (1):
      nvme-pci: fix race condition between reset and nvme_dev_disable()

Ming Lei (2):
      blk-mq: setup queue ->tag_set before initializing hctx
      ublk: don't allow user copy for unprivileged device

Nilay Shroff (4):
      nvmet-passthru: clear EUID/NGUID/UUID while using loop target
      nvme-loop: flush off pending I/O while shutting down loop controller
      nvme: make keep-alive synchronous operation
      nvme: use helper nvme_ctrl_state in nvme_keep_alive_finish function

Omar Sandoval (1):
      blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wake_function race

SurajSonawane2415 (1):
      block: Fix elevator_get_default() checking for NULL q->tag_set

Tokunori Ikegami (1):
      nvme: delete unnecessary fallthru comment

 block/blk-mq.c                 |  8 ++++--
 block/blk-rq-qos.c             |  2 +-
 block/elevator.c               | 21 ++++++++++------
 drivers/block/drbd/drbd_int.h  |  1 -
 drivers/block/drbd/drbd_main.c | 14 -----------
 drivers/block/ublk_drv.c       | 11 ++++++++-
 drivers/cdrom/cdrom.c          |  2 +-
 drivers/nvme/host/core.c       | 41 +++++++++++++------------------
 drivers/nvme/host/multipath.c  | 40 ++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h       |  1 +
 drivers/nvme/host/pci.c        | 19 +++++++++++---
 drivers/nvme/host/tcp.c        |  7 +++---
 drivers/nvme/target/loop.c     | 13 ++++++++++
 drivers/nvme/target/passthru.c |  6 ++---
 drivers/nvme/target/rdma.c     | 56 ++++++++++++++++++++----------------------
 include/uapi/linux/ublk_cmd.h  |  8 +++++-
 16 files changed, 152 insertions(+), 98 deletions(-)

-- 
Jens Axboe

