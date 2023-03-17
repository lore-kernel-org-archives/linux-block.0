Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9FAC6FD1D
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 17:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCQRQK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 13:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCQRQJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 13:16:09 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639AE41B53
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 10:16:04 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id w4so3124823ilv.0
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679073363;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+2mo/Vzi3ge/4A4/fqvv00FCpmrQsh4bkyQdNMcG9E=;
        b=q06kx3OrmgkoxM9UQjW2oVLxZz4zty1ocQKadZkjaCLk/UI+E87FiZH656po2LN2aW
         VV8SsZIfLi/nxe0Nelr+BRUic9HK2/IE/isJQ02/nVW1lJ2GBJpRLGHodlzaxjuEfMlm
         VBLE8n2NPTEJjpCscqVovq97M7IjORsfMTU14sDizZAxzku++/z5U3mRrUTkHMFCbkAV
         EK4ZMvO3NOJjKthR+IZrc1EWZmRQGBLWrKguOG1D1XzKIediLweSaZh9YppO+Ash0pQe
         3M93DEhGVbsc0NolQ/1eha9wJJ6Qk+W1SSS5jHjgbsY/VqomJprfRy5gqEw2oJ/nuNpS
         MQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679073363;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/+2mo/Vzi3ge/4A4/fqvv00FCpmrQsh4bkyQdNMcG9E=;
        b=5xQBxFFTdJYLLAshdRQVdcekztc4Nfc3FBo2SqtxJJokXyzBOBCzVXj6D9I3Tcb8/B
         uHBqqfmsS+YonYevPZOmkyaM03vETa49VoFUsH6XtslQ7fsuaOTj1T2pdQshx181nkut
         SW0aelgyZYtCRX8DGNh0qLVjEMVC3UA79at61KpgtghG4rIHALwq8TijRK3jjab8UfUf
         eEuQSlOUYqjvgx5GJaHqZtPNwZLUCEXD+6W5az8GENw66rCcZwjYsMJvju10wSunv8Zv
         NhMpk/UfbW2wdNlnvuOaJ5ALxYKhkYuHPxRhPNu+4BB5l5sCnQn6m7jcGutmvpK89EjF
         wGzw==
X-Gm-Message-State: AO0yUKVACFRiTOKwKgj5bwdoboBlz1StWo/vBHNcEDap0AgVHyXU3xta
        tpuHOoaKa/I/OZHEEunB3oJ6yVktDNFcRizl4ozsew==
X-Google-Smtp-Source: AK7set/Y65+ORjcZAs6k/sAEs5RAlpa5NgYJPuRNiWslEBAYptNZwAO0UFOOjIU0a0Q+SzN/u6hcOQ==
X-Received: by 2002:a92:c547:0:b0:318:8674:be8 with SMTP id a7-20020a92c547000000b0031886740be8mr4092046ilj.2.1679073363585;
        Fri, 17 Mar 2023 10:16:03 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b23-20020a026f57000000b00406431d0fb5sm518089jae.72.2023.03.17.10.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 10:16:03 -0700 (PDT)
Message-ID: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
Date:   Fri, 17 Mar 2023 11:16:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.3-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of fixes for block that should go into the 6.3-rc3 release. A bit
bigger than usual, as the NVMe pull request missed last weeks
submission. In detail:

- NVMe pull request via Christoph:
	- Avoid potential UAF in nvmet_req_complete (Damien Le Moal)
	- More quirks (Elmer Miroslav Mosher Golovin, Philipp Geulen)
	- Fix a memory leak in the nvme-pci probe teardown path
	  (Irvin Cote)
	- Repair the MAINTAINERS entry (Lukas Bulwahn)
	- Fix handling single range discard request (Ming Lei)
	- Show more opcode names in trace events (Minwoo Im)
	- Fix nvme-tcp timeout reporting (Sagi Grimberg)

- MD pull request via Song:
	- Two fixes for old issues (Neil)
	- Resource leak in device stopping (Xiao)

- Bio based device stats fix (Yu)

- Kill unused CONFIG_BLOCK_COMPAT (Lukas)

- sunvdc missing mdesc_grab() failure check (Liang)

- Fix for reversal of request ordering upon issue for certain cases
  (Jan)

- null_blk timeout fixes (Damien)

- Loop use-after-free fix (Bart)

- blk-mq SRCU fix for BLK_MQ_F_BLOCKING devices (Christ)

Side note - when doing the usual allmodconfig builds with gcc-12 and
clang before sending them out, for the latter I see this warning being
spewed with clang-15:

drivers/media/i2c/m5mols/m5mols.o: warning: objtool: m5mols_set_fmt() falls through to next function m5mols_get_frame_desc()

Obviously not related to my changes, but mentioning it in case it has
been missed as I know you love squeaky clean builds :-). Doesn't happen
with clang-14.

Please pull!


The following changes since commit e2f2a39452c43b64ea3191642a2661cb8d03827a:

  block, bfq: fix uaf for 'stable_merge_bfqq' (2023-03-08 07:34:50 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.3-2023-03-16

for you to fetch changes up to 8f0d196e4dc137470bbd5de98278d941c8002fcb:

  block: remove obsolete config BLOCK_COMPAT (2023-03-16 09:35:44 -0600)

----------------------------------------------------------------
block-6.3-2023-03-16

----------------------------------------------------------------
Bart Van Assche (1):
      loop: Fix use-after-free issues

Chris Leech (1):
      blk-mq: fix "bad unlock balance detected" on q->srcu in __blk_mq_run_dispatch_ops

Damien Le Moal (3):
      block: null_blk: Fix handling of fake timeout request
      block: null_blk: cleanup null_queue_rq()
      nvmet: avoid potential UAF in nvmet_req_complete()

Elmer Miroslav Mosher Golovin (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV3000

Irvin Cote (1):
      nvme-pci: fixing memory leak in probe teardown path

Jan Kara (1):
      block: do not reverse request order when flushing plug list

Jens Axboe (2):
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.3
      Merge tag 'nvme-6.3-2022-03-16' of git://git.infradead.org/nvme into block-6.3

Liang He (1):
      block: sunvdc: add check for mdesc_grab() returning NULL

Lukas Bulwahn (2):
      MAINTAINERS: repair malformed T: entries in NVM EXPRESS DRIVERS
      block: remove obsolete config BLOCK_COMPAT

Ming Lei (1):
      nvme: fix handling single range discard request

Minwoo Im (1):
      nvme-trace: show more opcode names

NeilBrown (2):
      md: avoid signed overflow in slot_store()
      md: select BLOCK_LEGACY_AUTOLOAD

Philipp Geulen (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM620

Sagi Grimberg (2):
      nvme-tcp: fix opcode reporting in the timeout handler
      nvme-tcp: add nvme-tcp pdu size build protection

Xiao Ni (1):
      md: Free resources in __md_stop

Yu Kuai (1):
      block: count 'ios' and 'sectors' when io is done for bio-based device

 MAINTAINERS                   |  8 ++++----
 block/Kconfig                 |  3 ---
 block/blk-core.c              | 16 ++++++----------
 block/blk-mq.c                |  5 +++--
 block/blk-mq.h                |  5 +++--
 drivers/block/loop.c          | 25 +++++++++++++++++--------
 drivers/block/null_blk/main.c | 31 +++++++++++++++----------------
 drivers/block/sunvdc.c        |  2 ++
 drivers/md/Kconfig            |  4 ++++
 drivers/md/dm.c               |  6 +++---
 drivers/md/md.c               | 17 ++++++++---------
 drivers/nvme/host/core.c      | 28 +++++++++++++++++++---------
 drivers/nvme/host/multipath.c |  8 ++++----
 drivers/nvme/host/pci.c       |  5 +++++
 drivers/nvme/host/tcp.c       | 33 +++++++++++++++++++++++++++------
 drivers/nvme/target/core.c    |  4 +++-
 include/linux/blk-mq.h        |  6 ++++++
 include/linux/blkdev.h        |  5 ++---
 include/linux/nvme.h          |  5 +++++
 19 files changed, 136 insertions(+), 80 deletions(-)

-- 
Jens Axboe

