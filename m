Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B16C43387
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308B9206B7
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GX05d6lS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfALVJV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:09:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41760 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfALVJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:09:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so8338211plm.8
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vlw27pvDHSB3annpzDZqjhQGmZ0TEuGYbMwl6+Ifb0w=;
        b=GX05d6lSA9n6Jmk0DfevGi/AzpQAZWwqK3mou32tEIQ09FEk9u7vWu0hUPZFd4RRc9
         ODaZo2OwJMoNNQBJ2ks6R91H2WuaQoRWzlAv0miEX+hdULqSpWWfpHbn919A+ZRjsnh9
         MtQw0ajJ/VFoY0lSzPux2zN5uzK0NaV4Rt7BxckeICT9HSc3Wl188xraWJQLRcBE2vQ7
         X5AXdBSnYEpM4DgxYR78/TU9s65jOGvM0Y0YXHNbAUaxl3r5GuwWAXBci5n1iYVkw/wK
         Pq0Pw6/2w5+m8kGppVXq8zFjqr3f3PwPlim1zAXeKoy2dd+2930rZOt9WqJ1tzwAqUvk
         OZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=vlw27pvDHSB3annpzDZqjhQGmZ0TEuGYbMwl6+Ifb0w=;
        b=Px1xjSmgckklWI8jIhnD1gqeUqtP5gLEY7ZG3fYzp7ExUMvSfXLkvSJJJLq+0XGtb5
         N2EKHJYCcsLW5Uf2Z9gqwCap6GA0khwesrz6mYBnIHFxCMjvKj4XxPR+mvSIHF4KYx2v
         ta4RiitFghcgyTCeiYywl7l07CUU0+BSj5nFEwnNoZv4d8/J8ksbNvUoAwJ9J5Dtepay
         Hi315rhSUi2G+noM0eydIc4dqvCHAyrtiKPXdB10la88ZOh0blx6UZrnjUWbCaI3qnu5
         fwz96rVK32JAi85CQxivB5VKcuo0brUIO09BPkPI8c9B+ks/wwBUX8UAZe1ac9o+Tbgr
         p/FQ==
X-Gm-Message-State: AJcUukdUIEao6CUVEKfW5is3sC/PeLS3wcH9ZctHA7Vy4yjiQiy6heu1
        NoZ4Qd78FlQ9cTjeZZ6LCLvQ422SpsaW1Q==
X-Google-Smtp-Source: ALg8bN4zbKNHrII1mvYHhAJdp2gxDWDe5UMJTzD+PFPofFkTuXvrnriPQlxNwLwsa6lgKBC4SBNAWQ==
X-Received: by 2002:a17:902:7e0d:: with SMTP id b13mr20082404plm.154.1547327360054;
        Sat, 12 Jan 2019 13:09:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b9sm114969767pfi.118.2019.01.12.13.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:09:18 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.0-rc2
Message-ID: <8137c662-f43e-ddc2-807c-155016e46fed@kernel.dk>
Date:   Sat, 12 Jan 2019 14:09:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's a set of fixes that should make it into this series. This pull
request contains:

- NVMe pull request from Christoph, with little fixes all over the map

- Loop caching fix for offset/bs change (Jaegeuk Kim)

- Block documentation tweaks (Jeff, Jon, Weiping, John)

- null_blk zoned tweak (John)

- ahch mvebu suspend/resume support. Should have gone into the merge
  window, but there was some confusion on which tree had it. (Miquel)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190112


----------------------------------------------------------------
Andrey Smirnov (1):
      nvme: don't initlialize ctrl->cntlid twice

Hannes Reinecke (1):
      nvme-multipath: zero out ANA log buffer

Hongbo Yao (1):
      nvme-pci: fix out of bounds access in nvme_cqe_pending

Jaegeuk Kim (1):
      loop: drop caches if offset or block_size are changed

James Dingwall (1):
      nvme: introduce NVME_QUIRK_IGNORE_DEV_SUBNQN

Jeff Moyer (1):
      block: clarify documentation for blk_{start|finish}_plug

Jens Axboe (1):
      Merge branch 'nvme-5.0' of git://git.infradead.org/nvme into for-linus

Jianchao Wang (1):
      nvme-pci: fix the wrong setting of nr_maps

John Pittman (2):
      null_blk: add zoned config support information
      block: doc: add slice_idle_us to bfq documentation

Jonathan Corbet (1):
      block: fix kerneldoc comment for blk_attempt_plug_merge()

Keith Busch (2):
      nvme-pci: rerun irq setup on IO queue init errors
      nvme: pad fake subsys NQN vid and ssvid with zeros

Liviu Dudau (1):
      nvme-pci: use the same attributes when freeing host_mem_desc_bufs.

Miquel Raynal (5):
      ata: libahci_platform: comply to PHY framework
      ata: ahci: mvebu: remove stale comment
      ata: ahci: mvebu: do Armada 38x configuration only on relevant SoCs
      ata: ahci: mvebu: add Armada 3700 initialization needed for S2RAM
      ata: ahci: mvebu: request PHY suspend/resume for Armada 3700

Sagi Grimberg (3):
      nvme-tcp: remove dead code
      nvme-tcp: don't ask if controller is fabrics
      nvme-fabrics: unset write/poll queues for discovery controllers

Weiping Zhang (1):
      block: add documentation for io_timeout

 Documentation/ABI/testing/sysfs-block |  9 ++++
 Documentation/block/bfq-iosched.txt   |  7 +++
 Documentation/block/null_blk.txt      |  3 +-
 Documentation/block/queue-sysfs.txt   |  7 +++
 block/blk-core.c                      | 20 +++++++-
 drivers/ata/ahci.h                    |  2 +
 drivers/ata/ahci_mvebu.c              | 87 ++++++++++++++++++++++++++---------
 drivers/ata/libahci_platform.c        | 13 ++++++
 drivers/block/loop.c                  | 35 +++++++++++++-
 drivers/block/null_blk.h              |  1 +
 drivers/nvme/host/core.c              | 19 ++++----
 drivers/nvme/host/fabrics.c           |  2 +
 drivers/nvme/host/multipath.c         |  2 +
 drivers/nvme/host/nvme.h              |  5 ++
 drivers/nvme/host/pci.c               | 67 +++++++++++++++++++--------
 drivers/nvme/host/tcp.c               | 16 +++----
 16 files changed, 229 insertions(+), 66 deletions(-)

-- 
Jens Axboe

