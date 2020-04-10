Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B358C2BA19
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 01:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDDE2074F
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 01:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bd53RL3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDJBIC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 21:08:02 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:53106 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDJBIC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Apr 2020 21:08:02 -0400
Received: by mail-pj1-f43.google.com with SMTP id ng8so215015pjb.2
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2020 18:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZrIPoscK1+YwMwnXLkdEmXWS6OMuVWRmxs0m8Yy8M7Q=;
        b=bd53RL3QPJpg5xJb9CzrtXz2zezLuwXTZB611F76kvsoC5hBicywHutQAEBU+Dzm7I
         3Vjwvx2EIUpn0mSru8qq1ZKMhrqetuPZoPn3lVTc19Akc52zY7/bHklbcOgb1XU089kf
         a3OZ9g2jjZycuQfy3QNMZOfinuyvHNiipecUoywyBth+XvQMyfW/PjS3/Z251tMyJL/B
         6Mqaf9UJQo7aNhuSkH6MFJn8XGZr7EAcseEKLnfxuFBmBAzgrwBWyuTwF0X+A2GKXnPI
         4iqc1vvOr4KfAttksBFrN+KwrM7N3DprNuTr383MePoQTy54YFnPZnYB9nH2MWWzKSFG
         Ff2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZrIPoscK1+YwMwnXLkdEmXWS6OMuVWRmxs0m8Yy8M7Q=;
        b=L0j0It26dZwO7H0E2kiQmiwJFaE+Gv49ZDKYoIWxinfDB69KxDwYE7z15PS67RakxS
         eFt9lZlJa565E2VLHiTbO3RK5wi5PX9uPBsoOQ1lZXfw/4AV2thpb1cKMbf1CAbw8foP
         n25nv8sSgbutwXPPhVc1ZIEAdrO/HvuUPPS1tacCYMQkmmSvEoaECLdKoWk3SyIEcnZR
         1b17t/fE1zNXBLpduJQAXp//C5TdccUodjid+arms+4dqj3RyRswPcZIMJzypTPKRfm/
         rGERXZc/FxyBpBEtINZtlEwCd0xJlcfkeaeFeYT1dy4dyi701dX7mQdeS7J/9fbun97T
         C48Q==
X-Gm-Message-State: AGi0Pub85dzmLcNQVDZgHQJdXYZoQ6KLI5lVEdFHsquRvD1YQ/s2I8by
        XoP5ggEgAkMcqJakGQ0DNh39JW6uJLo6mg==
X-Google-Smtp-Source: APiQypKNq8MetKZ9Bv/QimjQSI8PzSXhAcGa0X9kmkx9uATduHheIIvJA9I/X1FssqUM2qkbX80DWA==
X-Received: by 2002:a17:902:fe0f:: with SMTP id g15mr2312399plj.308.1586480879235;
        Thu, 09 Apr 2020 18:07:59 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:70f8:a8e1:daca:d677? ([2605:e000:100e:8c61:70f8:a8e1:daca:d677])
        by smtp.gmail.com with ESMTPSA id t4sm301818pfb.156.2020.04.09.18.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 18:07:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <0d580c9a-be04-0b48-0594-17a0339df1b5@kernel.dk>
Date:   Thu, 9 Apr 2020 18:07:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's a set of fixes that should go into this merge window. This pull
request contains:

- NVMe pull request from Christoph with various fixes

- Better discard support for loop (Evan)

- Only call ->commit_rqs() if we have queued IO (Keith)

- blkcg offlining fixes (Tejun)

Please pull! 


  git://git.kernel.dk/linux-block.git tags/block-5.7-2020-04-09


----------------------------------------------------------------
Christoph Hellwig (1):
      block: fix busy device checking in blk_drop_partitions

Evan Green (2):
      loop: Report EOPNOTSUPP properly
      loop: Better discard support for block devices

Israel Rukshin (2):
      nvme-rdma: Replace comma with a semicolon
      nvmet-rdma: fix double free of rdma queue

James Smart (3):
      nvme-fcloop: fix deallocation of working context
      nvmet-fc: fix typo in comment
      nvme-fc: Revert "add module to ops template to allow module references"

Jens Axboe (1):
      Merge branch 'nvme-5.7' of git://git.infradead.org/nvme into block-5.7

Keith Busch (1):
      blk-mq: don't commit_rqs() if none were queued

Nick Bowler (1):
      nvme: fix compat address handling in several ioctls

Sagi Grimberg (7):
      nvme-tcp: fix possible crash in write_zeroes processing
      nvme-tcp: don't poll a non-live queue
      nvme-tcp: fix possible crash in recv error flow
      nvme: inherit stable pages constraint in the mpath stack device
      nvmet: fix NULL dereference when removing a referral
      nvmet-rdma: fix bonding failover possible NULL deref
      nvme: fix deadlock caused by ANA update wrong locking

Tejun Heo (2):
      blkcg: rename blkcg->cgwb_refcnt to ->online_pin and always use it
      blkcg: don't offline parent blkcg first

 block/blk-cgroup.c              |  22 ++++-
 block/blk-mq.c                  |   9 +-
 block/partitions/core.c         |   2 +-
 drivers/block/loop.c            |  49 +++++++---
 drivers/nvme/host/core.c        |  34 +++++--
 drivers/nvme/host/fc.c          |  14 +--
 drivers/nvme/host/multipath.c   |   4 +-
 drivers/nvme/host/rdma.c        |   2 +-
 drivers/nvme/host/tcp.c         |  18 ++--
 drivers/nvme/target/configfs.c  |  10 +-
 drivers/nvme/target/fc.c        |   2 +-
 drivers/nvme/target/fcloop.c    |  77 ++++++++++-----
 drivers/nvme/target/rdma.c      | 205 +++++++++++++++++++++++++++-------------
 drivers/scsi/lpfc/lpfc_nvme.c   |   2 -
 drivers/scsi/qla2xxx/qla_nvme.c |   1 -
 include/linux/blk-cgroup.h      |  43 ++++-----
 include/linux/nvme-fc-driver.h  |   4 -
 mm/backing-dev.c                |   6 +-
 18 files changed, 324 insertions(+), 180 deletions(-)

-- 
Jens Axboe

