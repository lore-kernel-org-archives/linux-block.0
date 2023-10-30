Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74129C4167D
	for <linux-block@archiver.kernel.org>; Mon, 30 Oct 2023 15:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjJ3P2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Oct 2023 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjJ3P2S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2023 11:28:18 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD641C9
        for <linux-block@vger.kernel.org>; Mon, 30 Oct 2023 08:28:13 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35904093540so2575075ab.1
        for <linux-block@vger.kernel.org>; Mon, 30 Oct 2023 08:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698679693; x=1699284493; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzpfZ5D2QRh/2Y/JY2I577tVa8t/+bBA38dCTxBmo3c=;
        b=1M5F9Op0D4I+Isywh73SamL5cvUpbG1otNpl6U90Q1lExzw8jOW64ncsuKVAVkPvoV
         oL9gL9ksRtGm3yosUqFkOs5SBxw82CJNAxCRIH4jDmCWBqsjTK8slfDLNjEOXFZ/x8XZ
         8HtPiuIDXk6JNx1e8OC9UOXYPlxkGgm4sZUnfYuL+I7Lm9vdRxXCCVq6QJ+oiAgrXnuZ
         o5O9EAQ+DMHrfBZS+7SuQJBs2F39Dmx7a7HWSaYiG+9Kye6gHl9Y++Sr6p9AKX85+UZd
         OKsDK6odyP06gf1/686KijKA+uf6Ykvirj8sIS3v8Hw2iNiiIWytNVVSTXAhfDLdj4N8
         xDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698679693; x=1699284493;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CzpfZ5D2QRh/2Y/JY2I577tVa8t/+bBA38dCTxBmo3c=;
        b=FxwCuICvANB1UHr0GXan8E2bb3OfCDSpSzrgr+5kCthoKHzXdVGY9PrjoxpANc6Yb0
         ymmWOhUiqVREh9ahDW8j/q5Me1Kg+i+qfh2ed4jot5UHdTH1Hs4CJVH6EIsmfIz5Ql1B
         SrmqvvwSyCxxJ33qH9HkYDH3k7YNC1q1/5qVQyjlb25Uw/XywV7tvA3IJDDC+hvcsiFB
         VXIhjukghFphKSiy1dHbOX0HgPPZAr99FCOTBFrSPkdEiUM/EaLVz+AL9BuZkD9s2hos
         4OhosqwQixqc/OCQMAqEt4T9/l2PmngtuGeefAo8n3WoCYOUF0mjrtJVz8yw3vbY7Fsc
         66bQ==
X-Gm-Message-State: AOJu0YyiQYEwDsOH9kPvxuZBwy/d2ud2VBoZtdrTT20lDRvZQDvZA4SH
        hmC9hrDVNhJEuruM5VGr3SMjUKFNFr3N5jyKT1BYkQ==
X-Google-Smtp-Source: AGHT+IG/juhz7pKOt9UsplMV9a02aJfxK69hIDwzCZmTmJ7T61FSbExXKVgN/5Nwd7vB7r6nAIKscg==
X-Received: by 2002:a92:5406:0:b0:357:9e82:6ca7 with SMTP id i6-20020a925406000000b003579e826ca7mr9430836ilb.3.1698679693023;
        Mon, 30 Oct 2023 08:28:13 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h13-20020a92c26d000000b0034fd4562accsm2442099ild.28.2023.10.30.08.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 08:28:12 -0700 (PDT)
Message-ID: <1f416960-86d1-435f-825e-fc4a57747204@kernel.dk>
Date:   Mon, 30 Oct 2023 09:28:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 6.7-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the main block updates for the 6.7-rc1 merge window. Note that
this depends on for-6.7/io_uring which has been sent out, as it's
coordinating changes for uring_cmd cancelations with the ublk changes
being in this tree.

This pull request contains:

- Improvements to the queue_rqs() support, and adding null_blk support
  for that as well (Chengming)

- Series improving badblocks support (Coly)

- Key store support for sed-opal (Greg)

- IBM partition string handling improvements (Jan)

- Make number of ublk devices supported configurable (Mike)

- Cancelation improvements for ublk (Ming)

- MD pull requests via Song:
	- Handle timeout in md-cluster, by Denis Plotnikov
	- Cleanup pers->prepare_suspend, by Yu Kuai
	- Rewrite mddev_suspend(), by Yu Kuai
	- Simplify md_seq_ops, by Yu Kuai
	- Reduce unnecessary locking array_state_store(), by Mariusz
	  Tkaczyk
	- Make rdev add/remove independent from daemon thread, by Yu Kuai
	- Refactor code around quiesce() and mddev_suspend(), by Yu Kuai

- NVMe pull request via Keith:
	- nvme-auth updates (Mark)
	- nvme-tcp tls (Hannes)
	- nvme-fc annotaions (Kees)

- Misc cleanups and improvements (Jiapeng, Joel)

Note that this will throw a merge conflict in drivers/nvme/target/tcp.c
due to commit:

d920abd1e7c4 ("nvmet-tcp: Fix a possible UAF in queue intialization setup")

in your tree and commit

675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")

in this tree. The resolution is to kill the goto section, as was done by
the former, and add the queue->state assignment to the kernel_sendmsg()
error return. Here's my resolution:

diff --cc drivers/nvme/target/tcp.c
index 197fc2ecb164,4336fe048e43..92b74d0b8686
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@@ -910,8 -932,8 +933,10 @@@ static int nvmet_tcp_handle_icreq(struc
  	iov.iov_base = icresp;
  	iov.iov_len = sizeof(*icresp);
  	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
--	if (ret < 0)
 -		goto free_crypto;
++	if (ret < 0) {
++		queue->state = NVMET_TCP_Q_FAILED;
 +		return ret; /* queue removal will cleanup */
++	}
  
  	queue->state = NVMET_TCP_Q_LIVE;
  	nvmet_prepare_receive_pdu(queue);

Please pull!


The following changes since commit b3a4dbc89d4021b3f90ff6a13537111a004f9d07:

  io_uring/kbuf: Use slab for struct io_buffer objects (2023-10-05 08:38:17 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.7/block-2023-10-30

for you to fetch changes up to 0c696bb38f4cc0f0f90a8e06ae1eda21a9630cd0:

  Merge tag 'md-next-20231020' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.7/block (2023-10-20 10:37:01 -0600)

----------------------------------------------------------------
for-6.7/block-2023-10-30

----------------------------------------------------------------
Chengming Zhou (5):
      blk-mq: account active requests when get driver tag
      blk-mq: remove RQF_MQ_INFLIGHT
      blk-mq: support batched queue_rqs() on shared tags queue
      blk-mq: update driver tags request table when start request
      block/null_blk: add queue_rqs() support

Coly Li (6):
      badblocks: add more helper structure and routines in badblocks.h
      badblocks: add helper routines for badblock ranges handling
      badblocks: improve badblocks_set() for multiple ranges handling
      badblocks: improve badblocks_clear() for multiple ranges handling
      badblocks: improve badblocks_check() for multiple ranges handling
      badblocks: switch to the improved badblock handling code

Denis Plotnikov (1):
      md-cluster: check for timeout while a new disk adding

Greg Joyce (3):
      block:sed-opal: SED Opal keystore
      block: sed-opal: keystore access for SED Opal keys
      powerpc/pseries: PLPKS SED Opal keystore support

Hannes Reinecke (20):
      nvme-keyring: register '.nvme' keyring
      nvme-keyring: define a 'psk' keytype
      nvme: add TCP TSAS definitions
      nvme-tcp: add definitions for TLS cipher suites
      nvme-keyring: implement nvme_tls_psk_default()
      security/keys: export key_lookup()
      nvme-tcp: allocate socket file
      nvme-tcp: enable TLS handshake upcall
      nvme-tcp: control message handling for recvmsg()
      nvme-tcp: improve icreq/icresp logging
      nvme-fabrics: parse options 'keyring' and 'tls_key'
      nvmet: make TCP sectype settable via configfs
      nvmet-tcp: make nvmet_tcp_alloc_queue() a void function
      nvmet-tcp: allocate socket file
      nvmet: Set 'TREQ' to 'required' when TLS is enabled
      nvmet-tcp: enable TLS handshake upcall
      nvmet-tcp: control messages for recvmsg()
      nvmet-tcp: peek icreq before starting TLS
      nvme: rework NVME_AUTH Kconfig selection
      nvmet-tcp: use 'spin_lock_bh' for state_lock()

Jan Höppner (3):
      partitions/ibm: Remove unnecessary memset
      partitions/ibm: Replace strncpy() and improve readability
      partitions/ibm: Introduce defines for magic string length values

Jens Axboe (5):
      Merge tag 'md-next-20230927' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.7/block
      Merge tag 'md-next-20231012' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.7/block
      Merge branch 'for-6.7/io_uring' into for-6.7/block
      Merge tag 'nvme-6.7-2023-10-17' of git://git.infradead.org/nvme into for-6.7/block
      Merge tag 'md-next-20231020' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.7/block

Jiapeng Chong (1):
      block: ublk_drv: Remove unused function

Joel Granados (1):
      cdrom: Remove now superfluous sentinel element from ctl_table array

Justin Stitt (3):
      md: replace deprecated strncpy with memcpy
      null_blk: replace strncpy with strscpy
      aoe: replace strncpy with strscpy

Kees Cook (2):
      md/md-linear: Annotate struct linear_conf with __counted_by
      nvmet-fc: Annotate struct nvmet_fc_tgt_queue with __counted_by

Mariusz Tkaczyk (1):
      md: do not require mddev_lock() for all options in array_state_store()

Mark O'Donovan (3):
      nvme-auth: alloc nvme_dhchap_key as single buffer
      nvme-auth: use transformed key size to create resp
      nvme-auth: allow mixing of secret and hash lengths

Mike Christie (2):
      ublk: Limit dev_id/ub_number values
      ublk: Make ublks_max configurable

Ming Lei (7):
      ublk: don't get ublk device reference in ublk_abort_queue()
      ublk: make sure io cmd handled in submitter task context
      ublk: move ublk_cancel_dev() out of ub->mutex
      ublk: rename mm_lock as lock
      ublk: quiesce request queue when aborting queue
      ublk: replace monitor with cancelable uring_cmd
      ublk: simplify aborting request

Song Liu (1):
      Merge branch 'md-suspend-rewrite' into md-next

Yu Kuai (37):
      md: use separate work_struct for md_start_sync()
      md: factor out a helper to choose sync action from md_check_recovery()
      md: delay choosing sync action to md_start_sync()
      md: factor out a helper rdev_removeable() from remove_and_add_spares()
      md: factor out a helper rdev_is_spare() from remove_and_add_spares()
      md: factor out a helper rdev_addable() from remove_and_add_spares()
      md: delay remove_and_add_spares() for read only array to md_start_sync()
      md: initialize 'active_io' while allocating mddev
      md: initialize 'writes_pending' while allocating mddev
      md: don't rely on 'mddev->pers' to be set in mddev_suspend()
      md-bitmap: remove the checking of 'pers->quiesce' from location_store()
      md-bitmap: suspend array earlier in location_store()
      md: don't check 'mddev->pers' from suspend_hi_store()
      md: don't check 'mddev->pers' and 'pers->quiesce' from suspend_lo_store()
      md: factor out a helper from mddev_put()
      md: simplify md_seq_ops
      md/raid1: don't split discard io for write behind
      md: use READ_ONCE/WRITE_ONCE for 'suspend_lo' and 'suspend_hi'
      md/raid5-cache: use READ_ONCE/WRITE_ONCE for 'conf->log'
      md: replace is_md_suspended() with 'mddev->suspended' in md_check_recovery()
      md: add new helpers to suspend/resume array
      md: add new helpers to suspend/resume and lock/unlock array
      md/dm-raid: use new apis to suspend array
      md/md-bitmap: use new apis to suspend array for location_store()
      md/raid5-cache: use new apis to suspend array
      md/raid5: use new apis to suspend array
      md: use new apis to suspend array for sysfs apis
      md: use new apis to suspend array for adding/removing rdev from state_store()
      md: use new apis to suspend array for ioctls involed array reconfiguration
      md: use new apis to suspend array before mddev_create/destroy_serial_pool
      md: cleanup mddev_create/destroy_serial_pool()
      md/md-linear: cleanup linear_add()
      md/raid5: replace suspend with quiesce() callback
      md: suspend array in md_start_sync() if array need reconfiguration
      md: remove old apis to suspend the array
      md: rename __mddev_suspend/resume() back to mddev_suspend/resume()
      md: cleanup pers->prepare_suspend()

 arch/powerpc/platforms/pseries/Kconfig         |    6 +
 arch/powerpc/platforms/pseries/Makefile        |    1 +
 arch/powerpc/platforms/pseries/plpks_sed_ops.c |  131 ++
 block/Kconfig                                  |    1 +
 block/badblocks.c                              | 1618 +++++++++++++++++++-----
 block/blk-flush.c                              |   11 +-
 block/blk-mq-debugfs.c                         |    1 -
 block/blk-mq.c                                 |   45 +-
 block/blk-mq.h                                 |   57 +-
 block/partitions/ibm.c                         |   98 +-
 block/sed-opal.c                               |   18 +-
 drivers/block/aoe/aoenet.c                     |    3 +-
 drivers/block/null_blk/main.c                  |   22 +-
 drivers/block/ublk_drv.c                       |  342 +++--
 drivers/block/virtio_blk.c                     |    2 -
 drivers/cdrom/cdrom.c                          |    1 -
 drivers/md/dm-raid.c                           |   17 +-
 drivers/md/md-autodetect.c                     |    4 +-
 drivers/md/md-bitmap.c                         |   61 +-
 drivers/md/md-cluster.c                        |   15 +-
 drivers/md/md-linear.c                         |   28 +-
 drivers/md/md-linear.h                         |    2 +-
 drivers/md/md.c                                |  822 ++++++------
 drivers/md/md.h                                |   70 +-
 drivers/md/raid1.c                             |    6 +-
 drivers/md/raid10.c                            |    3 -
 drivers/md/raid5-cache.c                       |   64 +-
 drivers/md/raid5.c                             |  103 +-
 drivers/nvme/common/Kconfig                    |   13 +
 drivers/nvme/common/Makefile                   |    3 +-
 drivers/nvme/common/auth.c                     |   68 +-
 drivers/nvme/common/keyring.c                  |  182 +++
 drivers/nvme/host/Kconfig                      |   24 +-
 drivers/nvme/host/Makefile                     |    2 +-
 drivers/nvme/host/auth.c                       |   30 +-
 drivers/nvme/host/core.c                       |   14 +-
 drivers/nvme/host/fabrics.c                    |   67 +-
 drivers/nvme/host/fabrics.h                    |    9 +
 drivers/nvme/host/nvme.h                       |    5 +-
 drivers/nvme/host/pci.c                        |    1 -
 drivers/nvme/host/sysfs.c                      |   27 +-
 drivers/nvme/host/tcp.c                        |  184 ++-
 drivers/nvme/target/Kconfig                    |   22 +-
 drivers/nvme/target/auth.c                     |   31 +-
 drivers/nvme/target/configfs.c                 |  128 +-
 drivers/nvme/target/fc.c                       |    3 +-
 drivers/nvme/target/nvmet.h                    |   11 +
 drivers/nvme/target/tcp.c                      |  338 ++++-
 include/linux/badblocks.h                      |   30 +
 include/linux/blk-mq.h                         |    2 -
 include/linux/key.h                            |    1 +
 include/linux/nvme-auth.h                      |    7 +-
 include/linux/nvme-keyring.h                   |   36 +
 include/linux/nvme-tcp.h                       |    6 +
 include/linux/nvme.h                           |   10 +
 include/linux/sed-opal-key.h                   |   26 +
 security/keys/key.c                            |    1 +
 57 files changed, 3608 insertions(+), 1225 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks_sed_ops.c
 create mode 100644 drivers/nvme/common/keyring.c
 create mode 100644 include/linux/nvme-keyring.h
 create mode 100644 include/linux/sed-opal-key.h

-- 
Jens Axboe

