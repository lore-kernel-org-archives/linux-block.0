Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C44CC001DE
	for <linux-block@archiver.kernel.org>; Fri, 14 Jul 2023 19:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbjGNTnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jul 2023 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbjGNTnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2023 15:43:18 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD9B3A98
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 12:43:11 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7835bbeb6a0so16012639f.0
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689363791; x=1689968591;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oymtYFl7v7Qm5MJMHbCwpneRuMQ5D6lvTCH/yN2BJZg=;
        b=RWmIaWvTEIC56P5GAVs4E29tMuLgmgmWBVmrBrUERFixXk1x6abitxgeysd0vOoV1H
         yfgjp5/HyleS3En7EgAiKWax8xdfHxjz1W8JJkiqk0Tm5yNM03AIUjx5ej0HhD4A8sJ/
         Su18lN42L4Z5BccLfkriteQa+BGju6zZHB+6pza+7OP8+rvy3bViglUuZIuaLlHNzIer
         28nyYByNczC+NBmHT4nxHCShVWWMUhjMYfotDAwxAAucVD33D5Y83QEi8oa1s5nZ3R7o
         xpw61VZVLcAT/vV3arvx1vU2I6Udfn07HbBWDPVt6l0Nc3wi6yUwUJUxy/utsvs/az+4
         J0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689363791; x=1689968591;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oymtYFl7v7Qm5MJMHbCwpneRuMQ5D6lvTCH/yN2BJZg=;
        b=iEyQxSPtzfbNKcA5wh0DMcerZAeFtcMNPOhAdnK3nCM+XYM+aepkq/e92fHNuq9DSh
         fpZDo/KPd5sUxaTRmL7VDy4PMgO3gQ/EfL67J8ysQ9tGOQf3y8R2N8D/BbjDVTwvv5D7
         eVECKogCgdmgU78Mxk7z29FSRaU7GsXregerIvMabtrJdKmNURZ3Y0GbUT+LJ/WgM059
         JVKnIJw80ByHWsva9Qp3xsinrw5z9quobjUaIqdCY4IgfzRUbFUwhIDNmofGNR4Jg/Rz
         HRQlR8T9VY/cRbPbCKeXUAegh1KLPoXQLVlRpnDWjJ51LYHWYGKSoPz+95I5ckVv5h9E
         WkXg==
X-Gm-Message-State: ABy/qLZfBo/xudyxBjKazGtYggrc9vq0GI5Bc0C8lzYQLdXUFxgPsStI
        FaazLA7ocFc40QOs2pvnw/8Idg==
X-Google-Smtp-Source: APBJJlG4MqTXIB5SGTFXI4aYkHv2sQ/qw1OU/nm4E80qg0sA/FaL3n+UHtsFBKU5KATdM0dxsgNJkg==
X-Received: by 2002:a05:6602:164e:b0:783:6e76:6bc7 with SMTP id y14-20020a056602164e00b007836e766bc7mr176483iow.2.1689363791018;
        Fri, 14 Jul 2023 12:43:11 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l8-20020a02cd88000000b0042036f06b24sm2756941jap.163.2023.07.14.12.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 12:43:10 -0700 (PDT)
Message-ID: <cdb24723-26a4-3634-024f-239f380db6bf@kernel.dk>
Date:   Fri, 14 Jul 2023 13:43:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.5-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Fixes for the block area for the 6.5 kernel release. This pull request
contains:

- NVMe pull request via Keith
	- Don't require quirk to use duplicate namespace identifiers
          (Christoph, Sagi)
	- One more BOGUS_NID quirk (Pankaj)
	- IO timeout and error hanlding fixes for PCI (Keith)
	- Enhanced metadata format mask fix (Ankit)
	- Association race condition fix for fibre channel (Michael)
	- Correct debugfs error checks (Minjie)
	- Use PAGE_SECTORS_SHIFT where needed (Damien)
	- Reduce kernel logs for legacy nguid attribute (Keith)
	- Use correct dma direction when unmapping metadata (Ming)

- Fix for a flush handling regression in this release (Christoph)

- Fix for batched request time stamping (Chengming)

- Fix for a regression in the mq-deadline position calculation (Bart)

- Lockdep fix for blk-crypto (Eric)

- Fix for a regression in the Amiga partition handling changes (Michael)

Please pull!


The following changes since commit 6cd06ab12d1afdab3847e7981f301bd0404aaa5c:

  gup: make the stack expansion warning a bit more targeted (2023-07-05 09:33:31 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.5-2023-07-14

for you to fetch changes up to 9f87fc4d72f52b26ac3e19df5e4584227fe6740c:

  block: queue data commands from the flush state machine at the head (2023-07-14 08:42:58 -0600)

----------------------------------------------------------------
block-6.5-2023-07-14

----------------------------------------------------------------
Ankit Kumar (1):
      nvme: fix the NVME_ID_NS_NVM_STS_MASK definition

Bart Van Assche (1):
      block/mq-deadline: Fix a bug in deadline_from_pos()

Chengming Zhou (1):
      blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq

Christoph Hellwig (2):
      nvme: don't reject probe due to duplicate IDs for single-ported PCIe devices
      block: queue data commands from the flush state machine at the head

Damien Le Moal (1):
      nvmet: use PAGE_SECTORS_SHIFT

Eric Biggers (1):
      blk-crypto: use dynamic lock class for blk_crypto_profile::lock

Jens Axboe (2):
      block: remove dead struc request->completion_data field
      Merge tag 'nvme-6.5-2023-07-13' of git://git.infradead.org/nvme into block-6.5

Keith Busch (2):
      nvme: warn only once for legacy uuid attribute
      nvme: ensure disabling pairs with unquiesce

Michael Liang (2):
      nvme-fc: return non-zero status code when fails to create association
      nvme-fc: fix race between error recovery and creating association

Michael Schmitz (1):
      block/partition: fix signedness issue for Amiga partitions

Ming Lei (1):
      nvme-pci: fix DMA direction of unmapping integrity data

Minjie Du (1):
      nvme: fix parameter check in nvme_fault_inject_init()

Pankaj Raghav (1):
      nvme: add BOGUS_NID quirk for Samsung SM953

 block/blk-crypto-profile.c         | 12 ++++++++--
 block/blk-flush.c                  |  2 +-
 block/blk-mq.c                     | 47 ++++++++++++++++++++++++--------------
 block/mq-deadline.c                |  2 +-
 block/partitions/amiga.c           |  2 +-
 drivers/nvme/host/core.c           | 36 ++++++++++++++++++++++++++---
 drivers/nvme/host/fault_inject.c   |  2 +-
 drivers/nvme/host/fc.c             | 37 ++++++++++++++++++++++++------
 drivers/nvme/host/pci.c            | 29 +++++++++++++++--------
 drivers/nvme/host/sysfs.c          |  2 +-
 drivers/nvme/target/loop.c         |  2 +-
 drivers/nvme/target/passthru.c     |  4 ++--
 include/linux/blk-crypto-profile.h |  1 +
 include/linux/blk-mq.h             |  6 ++---
 include/linux/nvme.h               |  2 +-
 15 files changed, 136 insertions(+), 50 deletions(-)

-- 
Jens Axboe

