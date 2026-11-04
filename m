Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793820315;
	b=Sen6Wezikl1jR3taGw1rYx4/R44M7CLfW8MN5mko1TawENQRuncMYxPjQa/j/niajMow
	 gKws8zB1XM3TYX+3EN5TBOFKb9OqMG9gOM79wwHs0ocmcjqDMW9SkrP3SuZlZETe8lDRl
	 UvZZDoXbSsF6Vr4D60OVXdU5ZMbL0skRXWq3d6BmzQ6T4kMSodF3lmvX4yTjBc1esGaN0
	 InSCub8Hg0+ePwEQSipaW3X+/17EAnzjpJt6eIfvTPm9axoYL9VfOT1/VEzSyinqE3l0s
	 VnKrRIFGtzEgU8pT3QatTE1PEb70xczIMyb/ZZOmCw+cRRA5z5JFZd6mqdBViAGLYFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820315;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=CxaIAJs6w/X8Iq5pOusNCO7dYPXXz9Eag9FYVsxJWoY=;
	b=qsUwPtmaRX38o3sJ5Mq2ubP92FQcDER3n+k1NYjltEc4a1TkYkkqMA03/7NHYls6VBDB
	 czNBqpzxF4cLUwXDzT0E1xH9J0Vo4LXc83Sxd2J3UXxXFHeM0RSsL0B0dn0VucjtaoLO1
	 0kxL4uE819AbZK1tBYQKlLcBGiKjptEU5brAAVt3WsFD/lP7+f2BIb0BOgJ59q7GImZmf
	 lCdQw6MoVtoFBV5L/vyZo0nu2kbsYWE4P0Uu1HbO0e28k9dw4sY7XroI10E2HOZ95aIH4
	 a9S6jgciX0ihswpYQpTZ07HM6gurCLEjuFGwOrlC8oXQDTKIPRbHgZ9ENBXRDSCi2rQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbbZJMeF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6C60807AE;
	Wed,  4 Nov 2026 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbbZJMeF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793820314;
	b=ehNBLN1w/3L/hGNmcMbT6C8OkOlvr0ZaVmGzwtShaziPjphoOEs1v2YM/Bt6xMIT8fNS
	 I+HpYtU86+wFawj6cBBjIr4oWV9f5sOSo0aLNiFWWTKXPnTlpTeSs+cms1KHx0nG7Y0hV
	 HNRKLzhJw8CYBtm5bnyRuqxfqIv5u+sF90EBx1blzyB0WQA2dlkRUx//jrxtXL7UOEcZ+
	 BKsVfCsCa/s4NTBegWNjRffywxbof8o5cS30ezcD072h5uTVKb6aqWPCTaAluwV7bRKSv
	 8LTYN5c+JtLISGnNk4ZIpfjy5n3jsDMM3Lppp3HI2DUKajWeV7T85d72zl6/2vhrAcA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793820314;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=CxaIAJs6w/X8Iq5pOusNCO7dYPXXz9Eag9FYVsxJWoY=;
	b=xfSgj17ES72g6TPezoKWowioEeu6jz8G2LxMqBzci5cSktW/baQbD4mkDigvrYOUcJwB
	 0Mek55z+U6TD9Y3HCXxG6Stmt3wYEBu9Hplecw/2jKX0c2SrwzMwNQe3b9/oMJLgfeUs2
	 wVzsiutv54KoSbIVpy1pZw8F3x6q2XrDjQdfXTt1tPvmhPM1WmOqCNk8GNtyfKgH2sHLu
	 urNuBFaixxBPwY0JN1hhU7BGqJ0WcHL7lYLRKVKHR2tAcbWDZ8KdtAUTy2h465colRYV3
	 SRU4cP8BTiN2/YXN3eiCcXGMV1lSPhFIVza4TC5Se7ewJFvk55IybTYxleZp+3xSXLA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E23781F00A2A;
	Wed,  4 Nov 2026 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820314;
	bh=CxaIAJs6w/X8Iq5pOusNCO7dYPXXz9Eag9FYVsxJWoY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=AbbZJMeFc4PHrh47U/yNvbWaigx7U6OP/k1jXwX7BlzS+ZZdxDrylVufmFtoeGbvz
	 XQ/QgQU2sMWWudrkw0KAh8qaaGlbm3KO8Nxw9spaZYhxEFw+mYUW58d4fqqpZZVftc
	 M7/xSEDew1wmVwkNXD7NcNQcIXGQHcWNLoCMRJPm8Jj1YPU5jZkIu+JmTxn0rkOD6B
	 cEwUr7AoUB7iwZDoI75qQAHDz/XF7agTHTf0rdLPp/3DzPCCb6ZA0ZQaUu3piHA+kb
	 cdnj+/7i47glpMDyZKpgHe8Le36hnNJRVUPwLcgt7dL15tSIjA5J0aOl6Unm5cMneF
	 zO8dPIg2TZikw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3446B46F5E;
	Wed,  4 Nov 2026 19:25:06 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Subject: [PATCH 0/2] ublk: don't let one stuck device block control of all
 ublk devices
Date: Thu, 05 Nov 2026 00:25:04 +0500
Message-Id: <20261105-ublk-del-gendisk-hang-v1-0-913a91a4314d@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkEtPfSV6JC51mJYKEUQ/T3rO
 DAzN2RKTBm66oZEJ2feYgFZVzAtY5wJ2RUGJZSRUrR42DWgoxVnio5zwM9Ca5vGa2OU9hpKuyf
 yfP3ffnieFzecOzVnAAAA
X-Change-ID: 20261104-ublk-del-gendisk-hang-bb33f56625f5
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>, 
 Mark Korenberg <socketpair@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793820305; l=3412;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=ed+++DV3HtIipUSehjA+fspJo3hIwQmkBnnMsoaxA5M=;
 b=IRpKMhVeG5cfku6a00obCR56pJkuAzujaK89yVgM4ezrw36H1p/L9VE5WEKVSQ7iEkUZVW/kf
 Ls89C11kNhtASBn32zNZiGKz3OIhRn7PTHGBmfXdZ8XEZPQNBsywi/o
X-Developer-Key: i=socketpair@gmail.com; a=ed25519;
 pk=2iAMjWhs7kA9X8ccetT2YVX8dvniXua2okQogw3Don8=
X-Endpoint-Received: by B4 Relay for socketpair@gmail.com/20260603 with
 auth_id=806
X-Original-From: Mark Korenberg <socketpair@gmail.com>
Reply-To: socketpair@gmail.com

If the filesystem on a ublk device is stuck, removing that device
blocks in del_gendisk(), which syncs the filesystem. DEL_DEV holds the
global ublk_ctl_mutex across the removal, so ADD_DEV and DEL_DEV of
every other ublk device hang too, until reboot. It doesn't matter
whether the server is alive: when it dies, the release work does the
same syncing del_gendisk() under ub->mutex, and DEL_DEV waits for
ub->mutex holding ublk_ctl_mutex.

I hit it with btrfs on a ublk zoned device whose writeback deadlocked
on its own (a btrfs bug, handled separately): killing the server as a
last resort didn't help, and no new ublk device could be created on the
machine afterwards.

Patch 2 removes the global part: DEL_DEV doesn't take ublk_ctl_mutex.
It relies on patch 1, which fixes an older race the mutex partly hid:
ADD_DEV makes a new device findable by its id before its char device is
added, and if adding it fails, a DEL_DEV that found the device removes
a char device that was never added. With a failure injected into
ublk_add_chdev() this oopses on master in kill_device() from
cdev_device_del(); with patch 1, DEL_DEV gets -ENODEV.

Reproducer, without btrfs or zoned: XFS (or ext4) on a ublk loop
device, its external log (journal) on dm-linear over null_blk:

  dmsetup suspend --nolockfs --noflush <log>
  write a file; syncfs                  # blocks, as expected
  kill -9 <ublk server>                 # optional
  DEL_DEV 0                             # directly, as libublk does
  ADD_DEV 1                             # null target
  dmsetup resume <log>                  # everything unwinds

           DEL_DEV 0                         ADD_DEV 1
  master   D, survives SIGKILL               hangs on ublk_ctl_mutex
  series   D, survives SIGKILL (see below)   ok

The stuck device itself still can't be stopped or deleted until its
filesystem moves: its STOP_DEV and DEL_DEV sleep uninterruptibly, in
del_gendisk() or on ub->mutex. When the server is gone, nothing can be
written anyway, so that removal should be a surprise one done without
ub->mutex, but marking the disk dead isn't enough (the filesystem's
->shutdown() and the writeback flush in bdi_unregister() can block the
same way), and doing the removal without ub->mutex races with the
release work, recovery and a new server attaching. I'll send that part
separately as an RFC.

Tested in a VM with lockdep on top of master c339f4010dea, XFS and ext4,
with and without the server killed; block for-next has no ublk_drv.c
changes on top of it. The ublk selftests give the same results with and
without the series (integrity_01/03 fail on both, no
CONFIG_BLK_DEV_INTEGRITY here); a stress of DEL_DEV racing ADD_DEV of
the same id shows no warnings, also with KASAN and KCSAN.

This series was developed with the help of an AI coding assistant
(Claude); I reviewed and tested the changes and take responsibility
for them.

---
Mark Korenberg (2):
      ublk: publish a new device by its id only once it is set up
      ublk: don't take ublk_ctl_mutex in DEL_DEV

 drivers/block/ublk_drv.c | 60 +++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 23 deletions(-)
---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261104-ublk-del-gendisk-hang-bb33f56625f5

Best regards,
-- 
Mark Korenberg <socketpair@gmail.com>


