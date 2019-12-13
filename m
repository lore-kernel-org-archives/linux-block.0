Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9795EC43603
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 01:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695C521655
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 01:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Pq0CA1mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfLMBXh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:23:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34602 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731311AbfLMBXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 20:23:36 -0500
Received: by mail-pl1-f195.google.com with SMTP id x17so518948pln.1
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 17:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zuuAZQMrh1RslBXGt01TyyaSoW+HIS0Avq2rcjTZNGg=;
        b=Pq0CA1mi+1cIXL+X9p1sheSXD5DrzHLDeanLMvqUtpc+oI9OjIPQwVilnBhV0hwvRO
         UdxDO0+wR8GMT5XM/b2/sBfGg/O6VRGSijJTLVfOXdm1lYC8neqO+eald6qqDzTAxeoc
         nDh1fA2gjgAFjWurvp+KJdaIu0fJWplxzNfC6cPvpubcYgLGgOc7ktJyE07mw+cM2BJ8
         SOjMh6ohqcBN0ObABN9gXGT8bRmf1vj7kXMhdEpc/owxpNW5mbxVKzMSTrGymd0IF3sO
         fj30LKSxzhgx1F8FJz1ETH33UNje3eGute4JBg1nDnk6hRqdyzZcJ3L2LJACtoSF05OX
         gyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zuuAZQMrh1RslBXGt01TyyaSoW+HIS0Avq2rcjTZNGg=;
        b=prcyBu+pADrtqbVicDAbhJ8vI/y9FpfdxDFt8sw/ZxfkdDQIq1FOkJGL1JzTlsw8nE
         Ctxh13vWUjeCxZ/Ujxiigzchzdk8n5UCYfytFimgs08KqtSyjYsfmM7iuTd/gy0SHDso
         dNsWYmBF0MHT5MqNyIVK/qjlqgRBz8r59WW6nGy9jVZe4UzQ8Nk21JL1/rzc+SNR5afM
         X/e2oR6MamrZGQnV0PhGMXv2aEuzHDmON+hPr1kjS5j9MqatzslY2XXf4Rf+V0hP2YOm
         L8AgFbPi9Bwzee8T6WrWOu8HbrooBbMX0wDJfsY6JKwztRr28+r+kbdiObRDr+fqZRsI
         Rymw==
X-Gm-Message-State: APjAAAXfP9ImFw2scIl7zH7G8BrLtH6BdtPuj4RhNNiWbZSKN4q5KLGD
        NGi0WCK+2TDXDOBSgtP3EZXigTNxsDA/RA==
X-Google-Smtp-Source: APXvYqwhucVdsCzVHHWve48Rr5QSXjxxuoUFEZAYZ5f98LJTEcf4ELEOqcONYpt4XH9Az0/i8vJxoQ==
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr13734736pjk.100.1576200215545;
        Thu, 12 Dec 2019 17:23:35 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id p5sm8371672pgj.63.2019.12.12.17.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 17:23:34 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.5-rc2
Message-ID: <1202a2e6-8527-4bd1-7b38-806aafe50e2c@kernel.dk>
Date:   Thu, 12 Dec 2019 18:23:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's a set of fies for the block side that should go into 5.5-rc2.
This pull request contains:

- stable fix for the bi_size overflow. Not a corruption issue, but a
  case wher we could merge but disallowed (Andreas)

- NVMe pull request via Keith, with various fixes.

- MD pull request from Song.

- Merge window regression fix for the rq passthrough stats (Logan)

- Remove unused blkcg_drain_queue() function (Guoqing)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20191212


----------------------------------------------------------------
Andreas Gruenbacher (1):
      block: fix "check bi_size overflow before merge"

Edmund Nadolski (1):
      nvme: else following return is not needed

Guoqing Jiang (2):
      raid5: need to set STRIPE_HANDLE for batch head
      blk-cgroup: remove blkcg_drain_queue

Israel Rukshin (3):
      nvme-rdma: Avoid preallocating big SGL for data
      nvme-fc: Avoid preallocating big SGL for data
      nvmet-loop: Avoid preallocating big SGL for data

James Smart (3):
      nvme_fc: add module to ops template to allow module references
      nvme: add error message on mismatching controller ids
      nvme-fc: fix double-free scenarios on hw queues

Jens Axboe (2):
      Merge branch 'nvme/for-5.5' of git://git.infradead.org/nvme into for-linus
      Merge branch 'md-fixes' of git://git.kernel.org/.../song/md into for-linus

Keith Busch (5):
      nvme: Namepace identification descriptor list is optional
      nvme/pci: Remove last_cq_head
      nvme/pci: Fix write and poll queue types
      nvme/pci Limit write queue sizes to possible cpus
      nvme/pci: Fix read queue count

Logan Gunthorpe (1):
      block: fix NULL pointer dereference in account statistics with IDE

Yufen Yu (1):
      md: make sure desc_nr less than MD_SB_DISKS

Zhiqiang Liu (1):
      md: raid1: check rdev before reference in raid1_sync_request func

 block/bio.c                     |  4 +++-
 block/blk-cgroup.c              | 20 --------------------
 block/blk-core.c                |  5 +++--
 drivers/md/md.c                 |  1 +
 drivers/md/raid1.c              |  2 +-
 drivers/md/raid5.c              |  2 +-
 drivers/nvme/host/core.c        |  6 ++++++
 drivers/nvme/host/fc.c          | 40 +++++++++++++++++++++++++++++++---------
 drivers/nvme/host/nvme.h        |  6 ++++++
 drivers/nvme/host/pci.c         | 23 +++++++++--------------
 drivers/nvme/host/rdma.c        | 10 +++++-----
 drivers/nvme/target/fcloop.c    |  1 +
 drivers/nvme/target/loop.c      |  8 ++++----
 drivers/scsi/lpfc/lpfc_nvme.c   |  2 ++
 drivers/scsi/qla2xxx/qla_nvme.c |  1 +
 include/linux/blk-cgroup.h      |  2 --
 include/linux/nvme-fc-driver.h  |  4 ++++
 17 files changed, 78 insertions(+), 59 deletions(-)

-- 
Jens Axboe

