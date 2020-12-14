Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82498C4361B
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 15:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5E322B3B
	for <linux-block@archiver.kernel.org>; Mon, 14 Dec 2020 15:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407077AbgLNPbg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Dec 2020 10:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732559AbgLNPb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Dec 2020 10:31:26 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865CEC0613D3
        for <linux-block@vger.kernel.org>; Mon, 14 Dec 2020 07:30:46 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id v3so16158230ilo.5
        for <linux-block@vger.kernel.org>; Mon, 14 Dec 2020 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CS7jWRi4jjj7WMmZa4T9gXUMbDZLAiUdFVPX1hb+y/o=;
        b=K8nnmrY7lWTypLpyOKb0H0gYeHwS00xmP6SS1CswkNmuZS1viC0DYKB7jLCsrPMbbR
         /Uu9RtfwMH3kiT+LKoTDH4vPSn59J+5bLO39vRwjUVdCe+ts/4A1V+RMjJVaI60EBuCr
         bnA4cu7N+J4yALB87HD24W2ykmuBwQ5AiNmwFClqIuXnUxr4tEtqlpscHOW7osGuU95q
         0JO7vHoVb55bfnpnuzjr1ao1u6FuiE0dFJe6dHLWxGnR11SHcQuhzPQl4t4nXyMWPsbS
         t/XT3Rou0MEa72jZASXdIbbNvo6vVNXA9XFsoTUSjemwNVHZoBdBuxUEkU6BAp7j4kpc
         0xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CS7jWRi4jjj7WMmZa4T9gXUMbDZLAiUdFVPX1hb+y/o=;
        b=klAGU3Jj9rZJcs7XkW+1a9YmBrQFvgO7xFrQm775NtZlMH9bB6L+reHibNasWDrNFh
         ACJLE3bzptIk/N2+IJUZqxhdiKHOE/d5AF3af/BWA5xftpmwusek6QKwRtjt0Gv5Xy6A
         VTnzeezeD2or2oC46hGn4NmkcJaprGgC1Jqgw3A5Z/tQOSAhgNOU6UHlp2N7Roii9sCq
         XVf19X/U1vcZK/Yx6fHTw/a92d71jfkA0XJnR9zJuuJYcfY0v2jJTn2F7iNlTG6ube3q
         4JUPtudYxpBrT0u17+9u3yZWjGZdQZ2xrhowNpH5juyAHq3JEYWQu4uGFVC9tEUMjDfu
         7u+A==
X-Gm-Message-State: AOAM5310oQNjzeSf7w5idV3KEnUFwVAhE4VqUW3FY0JTUWq7wMbj6AOq
        IoZLSDTQYQ9ViWm2W4TIc4Ov3JTn5Wi2qw==
X-Google-Smtp-Source: ABdhPJwQZSi6LgwEVJAhYYYnw7w77CLlVSyBygXje+xJgO2Pzt1CciTT/B8+0tqg01f7JSBkcKokhg==
X-Received: by 2002:a92:9ec7:: with SMTP id s68mr35506033ilk.171.1607959845419;
        Mon, 14 Dec 2020 07:30:45 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u24sm11805594ili.47.2020.12.14.07.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 07:30:44 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver changes for 5.11
Message-ID: <8238bb43-756b-e0dc-2484-7e1e21928c0c@kernel.dk>
Date:   Mon, 14 Dec 2020 08:30:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the core block branch (which is for 5.11, regardless of the
typo in the subject there...), here are the driver changes queued up for
5.11. Nothing major in here.

Note that this throws a merge conflict in drivers/md/raid10.c, again due
to the late md discard revert for 5.10. Resolution is straight forward,
__make_request() just needs to use the non-HEAD part of the resolution:

r10_bio->read_slot = -1;                                                
memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->geo.raid_disks);

This pull request contains:

- NVMe pull request from Christoph:
	- nvmet passthrough improvements (Chaitanya Kulkarni)
	- fcloop error injection support (James Smart)
	- read-only support for zoned namespaces without Zone Append
	  (Javier González)
	- improve some error message (Minwoo Im)
	- reject I/O to offline fabrics namespaces (Victor Gladkov)
	- PCI queue allocation cleanups (Niklas Schnelle)
	- remove an unused allocation in nvmet (Amit Engel)
	- a Kconfig spelling fix (Colin Ian King)
	- nvme_req_qid simplication (Baolin Wang)

- MD pull request from Song:
	- Fix race condition in md_ioctl() (Dae R. Jeong)
	- Initialize read_slot properly for raid10 (Kevin Vigor)
	- Code cleanup (Pankaj Gupta)
	- md-cluster resync/reshape fix (Zhao Heming)

- Move null_blk into its own directory (Damien Le Moal)

- null_blk zone and discard improvements (Damien Le Moal)

- bcache race fix (Dongsheng Yang)

- Set of rnbd fixes/improvements (Gioh Kim, Guoqing Jiang, Jack Wang,
  Lutz Pogrell, Md Haris Iqbal)

- lightnvm NULL pointer deref fix (tangzhenhao)

- sr in_interrupt() removal (Sebastian Andrzej Siewior)

- FC endpoint security support for s390/dasd (Jan Höppner, Sebastian
  Ott, Vineeth Vijayan). From the s390 arch guys, arch bits included as
  it made it easier for them to funnel the feature through the block
  driver tree.

- Follow up fixes (Colin Ian King)

Please pull!


The following changes since commit e2b6b301871719d1db0b1ed7a1ed9e06750c80fc:

  block: fix the kerneldoc comment for __register_blkdev (2020-11-16 08:14:31 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.11/drivers-2020-12-14

for you to fetch changes up to aeb2b0b1a3da5791d3b216e71ec72db7570f3571:

  block: drop dead assignments in loop_init() (2020-12-12 11:18:56 -0700)

----------------------------------------------------------------
for-5.11/drivers-2020-12-14

----------------------------------------------------------------
Amit (1):
      nvmet: remove unused ctrl->cqs

Baolin Wang (1):
      nvme: simplify nvme_req_qid()

Chaitanya Kulkarni (9):
      nvme: centralize setting the timeout in nvme_alloc_request
      nvme: use consistent macro name for timeout
      nvmet: add passthru admin timeout value attr
      nvmet: add passthru io timeout value attr
      block: move blk_rq_bio_prep() to linux/blk-mq.h
      nvme: split nvme_alloc_request()
      nvmet: remove op_flags for passthru commands
      nvmet: use blk_rq_bio_prep instead of blk_rq_append_bio
      nvmet: use inline bio for passthru fast path

Colin Ian King (2):
      nvmet: fix a spelling mistake "incuding" -> "including" in Kconfig
      block/rnbd: fix a null pointer dereference on dev->blk_symlink_name

Dae R. Jeong (1):
      md: fix a warning caused by a race between concurrent md_ioctl()s

Damien Le Moal (9):
      null_blk: Fix zone size initialization
      null_blk: Fail zone append to conventional zones
      block: Align max_hw_sectors to logical blocksize
      null_blk: improve zone locking
      null_blk: Improve implicit zone close
      null_blk: cleanup discard handling
      null_blk: discard zones on reset
      null_blk: Allow controlling max_hw_sectors limit
      null_blk: Move driver into its own directory

Dongsheng Yang (1):
      bcache: fix race between setting bdev state to none and new write request direct to backing

Gioh Kim (2):
      Documentation/ABI/rnbd-clt: fix typo in sysfs-class-rnbd-client
      Documentation/ABI/rnbd-clt: session name is appended to the device path

Guoqing Jiang (2):
      block/rnbd-clt: support mapping two devices with the same name from different servers
      block/rnbd: call kobject_put in the failure path

Jack Wang (1):
      Documentation/ABI/rnbd-srv: add document for force_close

James Smart (1):
      nvme-fcloop: add sysfs attribute to inject command drop

Jan Höppner (7):
      s390/dasd: Remove unused parameter from dasd_generic_probe()
      s390/dasd: Move duplicate code to separate function
      s390/dasd: Store path configuration data during path handling
      s390/dasd: Fix operational path inconsistency
      s390/dasd: Display FC Endpoint Security information via sysfs
      s390/dasd: Prepare for additional path event handling
      s390/dasd: Process FCES path event notification

Javier González (4):
      nvme: remove unnecessary return values
      nvme: rename controller base dev_t char device
      nvme: rename bdev operations
      nvme: export zoned namespaces without Zone Append support read-only

Jens Axboe (2):
      Merge branch 'md-next' of https://git.kernel.org/.../song/md into for-5.11/drivers
      Merge tag 'nvme-5.11-20201202' of git://git.infradead.org/nvme into for-5.11/drivers

Kevin Vigor (1):
      md/raid10: initialize r10_bio->read_slot before use.

Lukas Bulwahn (1):
      block: drop dead assignments in loop_init()

Lutz Pogrell (1):
      block/rnbd-srv: close a mapped device from server side.

Max Gurtovoy (1):
      nvmet: make sure discovery change log event is protected

Md Haris Iqbal (2):
      block/rnbd-clt: Make path parameter optional for map_device
      block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name

Minwoo Im (2):
      nvme: improve an error message on Identify failure
      nvme: print a warning for when listing active namespaces fails

Niklas Schnelle (2):
      nvme-pci: drop min() from nr_io_queues assignment
      nvme-pci: don't allocate unused I/O queues

Pankaj Gupta (3):
      md: improve variable names in md_flush_request()
      md: add comments in md_flush_request()
      md: use current request time as base for ktime comparisons

Sebastian Andrzej Siewior (3):
      cdrom: Reset sector_size back it is not 2048.
      sr: Switch the sector size back to 2048 if sr_read_sector() changed it.
      sr: Remove in_interrupt() usage in sr_init_command().

Sebastian Ott (1):
      s390/cio: Export information about Endpoint-Security Capability

Victor Gladkov (1):
      nvme-fabrics: reject I/O to offline device

Vineeth Vijayan (2):
      s390/cio: Provide Endpoint-Security Mode per CU
      s390/cio: Add support for FCES status notification

Zhao Heming (2):
      md/cluster: block reshape with remote resync job
      md/cluster: fix deadlock when node is doing resync job

tangzhenhao (1):
      drivers/lightnvm: fix a null-ptr-deref bug in pblk-core.c

 Documentation/ABI/testing/sysfs-class-rnbd-client  |   8 +-
 Documentation/ABI/testing/sysfs-class-rnbd-server  |   8 +
 arch/s390/include/asm/ccwdev.h                     |   2 +
 arch/s390/include/asm/cio.h                        |   1 +
 block/blk-settings.c                               |  23 +-
 block/blk.h                                        |  12 -
 drivers/block/Kconfig                              |   8 +-
 drivers/block/Makefile                             |   7 +-
 drivers/block/loop.c                               |   8 +-
 drivers/block/null_blk/Kconfig                     |  12 +
 drivers/block/null_blk/Makefile                    |  11 +
 drivers/block/{null_blk_main.c => null_blk/main.c} |  63 ++--
 drivers/block/{ => null_blk}/null_blk.h            |  32 +-
 .../block/{null_blk_trace.c => null_blk/trace.c}   |   2 +-
 .../block/{null_blk_trace.h => null_blk/trace.h}   |   2 +-
 .../block/{null_blk_zoned.c => null_blk/zoned.c}   | 333 +++++++++++++--------
 drivers/block/rnbd/rnbd-clt-sysfs.c                |  21 +-
 drivers/block/rnbd/rnbd-clt.c                      |  33 +-
 drivers/block/rnbd/rnbd-clt.h                      |   4 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c                |  66 +++-
 drivers/block/rnbd/rnbd-srv.c                      |  19 +-
 drivers/block/rnbd/rnbd-srv.h                      |   4 +-
 drivers/cdrom/cdrom.c                              |  12 +-
 drivers/lightnvm/pblk-core.c                       |   4 +
 drivers/md/bcache/super.c                          |   9 -
 drivers/md/bcache/writeback.c                      |   9 +
 drivers/md/md-cluster.c                            |  67 +++--
 drivers/md/md.c                                    |  33 +-
 drivers/md/md.h                                    |   6 +-
 drivers/md/raid10.c                                |   3 +-
 drivers/nvme/host/core.c                           | 150 +++++++---
 drivers/nvme/host/fabrics.c                        |  25 +-
 drivers/nvme/host/fabrics.h                        |   5 +
 drivers/nvme/host/fc.c                             |   2 +-
 drivers/nvme/host/lightnvm.c                       |   8 +-
 drivers/nvme/host/multipath.c                      |   2 +
 drivers/nvme/host/nvme.h                           |  11 +-
 drivers/nvme/host/pci.c                            |  27 +-
 drivers/nvme/host/rdma.c                           |   2 +-
 drivers/nvme/host/tcp.c                            |   2 +-
 drivers/nvme/host/zns.c                            |  13 +-
 drivers/nvme/target/Kconfig                        |   2 +-
 drivers/nvme/target/configfs.c                     |  40 +++
 drivers/nvme/target/core.c                         |  15 +-
 drivers/nvme/target/discovery.c                    |   1 +
 drivers/nvme/target/fcloop.c                       |  81 ++++-
 drivers/nvme/target/loop.c                         |   2 +-
 drivers/nvme/target/nvmet.h                        |   4 +-
 drivers/nvme/target/passthru.c                     |  37 +--
 drivers/s390/block/dasd.c                          |  22 +-
 drivers/s390/block/dasd_devmap.c                   | 109 +++++++
 drivers/s390/block/dasd_eckd.c                     | 175 +++++++----
 drivers/s390/block/dasd_fba.c                      |   2 +-
 drivers/s390/block/dasd_int.h                      | 111 ++++++-
 drivers/s390/cio/chp.c                             |  15 +
 drivers/s390/cio/chp.h                             |   1 +
 drivers/s390/cio/chsc.c                            | 145 ++++++++-
 drivers/s390/cio/chsc.h                            |   3 +-
 drivers/s390/cio/device.c                          |  15 +-
 drivers/scsi/sr.c                                  |  17 --
 drivers/scsi/sr_ioctl.c                            |   2 +
 include/linux/blk-mq.h                             |  12 +
 62 files changed, 1395 insertions(+), 485 deletions(-)
 create mode 100644 drivers/block/null_blk/Kconfig
 create mode 100644 drivers/block/null_blk/Makefile
 rename drivers/block/{null_blk_main.c => null_blk/main.c} (97%)
 rename drivers/block/{ => null_blk}/null_blk.h (83%)
 rename drivers/block/{null_blk_trace.c => null_blk/trace.c} (93%)
 rename drivers/block/{null_blk_trace.h => null_blk/trace.h} (97%)
 rename drivers/block/{null_blk_zoned.c => null_blk/zoned.c} (68%)

-- 
Jens Axboe

