Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED051C433E0
	for <linux-block@archiver.kernel.org>; Sun, 24 Jan 2021 18:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DF522583
	for <linux-block@archiver.kernel.org>; Sun, 24 Jan 2021 18:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbhAXSvD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 13:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbhAXSvC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 13:51:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F5CC061573
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 10:50:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id my11so8203023pjb.1
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 10:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wuUuJw3YQG9c7bOcLvNV2/Uggb4QG21vcoNm7Qy76l0=;
        b=AjOXCtHqBhJY3gtCI7fyMU2T6LdKIzmFXWOGzkqcTp8HeQKU9h8d0g17Vj0YhZHVfK
         zyno8feeVLBkh93FGStbxdeUvjcXYHFd5pmcdiYDx0vPzAuqtwyY+ro3/HDwrNiVP/Wu
         GrMAz1lFfZTGUCbVkPW0pVeG7nObYPNoBWlgzLg8DGDh+w59nzIkS3tUYB1+JPPXHVtx
         Md5DU1sM7I7TOH0HNfNggmoaaoEqKhErVVZ/2j717cI8ZuvJTQp6pIGPaPClgz0zhwae
         uHcJ9PfdEET2vs2v7XDX5LYre1wn5qc3OpBtu7Mk2alHwdbTHeAWAI3DYHNBtyPBc3/j
         FDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wuUuJw3YQG9c7bOcLvNV2/Uggb4QG21vcoNm7Qy76l0=;
        b=BIOIFufEM7q0wk0UFb7GFIc+HIP4MFJjeYp1iY2CDzNITcPnWAuDQkR8meuvb31kLk
         4vlbVGPBAzSGG3YP0xgHyxDQsdSxtqgnNaMBHkp8EHtWiuXECLofLL/uNXmf4QIeBGeU
         VOgIsBzr234Azq82J+x5nrrQQFB+19Ybg3jBS+t3CnUf3ClzMEHIxpEuYKBte5m6lqf+
         KWEbGDjHfPl85v4Kw2w7qRy4MjP55i0HPf4SlJf4fIAE0cxc/zfjxA3i7NWUz673tIZ9
         U5hcuKUihZZTiSPHtZyJ1jTa3QH8e3a0De77RLNNIYjcmJ6uf/3wtKfmhOiQThfa69M7
         CzCw==
X-Gm-Message-State: AOAM531GWRyyO28TlZ1Vl3IXXYcwBnr4Xw4T8rMF0VGODV85/5DkucT7
        tTXYdh+MMtgznlCBIlvRnYByEVPz6kCXAA==
X-Google-Smtp-Source: ABdhPJwSKD0kcWgJnv2QvQD79ySHd/6//L3gr9bJcuF6OK7oGnvvBgEQRO6GNuMjhyCJhj3iI5nfWg==
X-Received: by 2002:a17:902:aa43:b029:dc:26a7:7391 with SMTP id c3-20020a170902aa43b02900dc26a77391mr15975572plr.51.1611514221810;
        Sun, 24 Jan 2021 10:50:21 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id s1sm4081624pjg.17.2021.01.24.10.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 10:50:21 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.11-rc5
Message-ID: <c97bdf40-6552-ab35-3071-a5b96855c80a@kernel.dk>
Date:   Sun, 24 Jan 2021 11:50:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

- NVMe pull request from Christoph:
	- fix a status code in nvmet (Chaitanya Kulkarni)
	- avoid double completions in nvme-rdma/nvme-tcp (Chao Leng)
	- fix the CMB support to cope with NVMe 1.4 controllers (Klaus Jensen)
	- fix PRINFO handling in the passthrough ioctl (Revanth Rajashekar)
	- fix a double DMA unmap in nvme-pci

- lightnvm error path leak fix (Pan)

- MD pull request from Song:
	- Flush request fix (Xiao)

Please pull!


The following changes since commit b4f664252f51e119e9403ef84b6e9ff36d119510:

  Merge tag 'nvme-5.11-2021-01-14' of git://git.infradead.org/nvme into block-5.11 (2021-01-14 15:17:33 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-24

for you to fetch changes up to 97784481757fba7570121a70dd37ca74a29f50a8:

  lightnvm: fix memory leak when submit fails (2021-01-21 05:45:51 -0700)

----------------------------------------------------------------
block-5.11-2021-01-24

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: set right status on error in id-ns handler

Chao Leng (2):
      nvme-rdma: avoid request double completion for concurrent nvme_rdma_timeout
      nvme-tcp: avoid request double completion for concurrent nvme_tcp_timeout

Christoph Hellwig (2):
      nvme-pci: refactor nvme_unmap_data
      nvme-pci: fix error unwind in nvme_map_data

Jens Axboe (2):
      Merge branch 'md-fixes' of https://git.kernel.org/.../song/md into block-5.11
      Merge tag 'nvme-5.11-2020-01-21' of git://git.infradead.org/nvme into block-5.11

Klaus Jensen (1):
      nvme-pci: allow use of cmb on v1.4 controllers

Pan Bian (1):
      lightnvm: fix memory leak when submit fails

Revanth Rajashekar (1):
      nvme: check the PRINFO bit before deciding the host buffer length

Xiao Ni (1):
      md: Set prev_flush_start and flush_bio in an atomic way

 drivers/lightnvm/core.c         |   3 +-
 drivers/md/md.c                 |   2 +
 drivers/nvme/host/core.c        |  17 +++++-
 drivers/nvme/host/pci.c         | 119 +++++++++++++++++++++++++++-------------
 drivers/nvme/host/rdma.c        |  15 +++--
 drivers/nvme/host/tcp.c         |  14 +++--
 drivers/nvme/target/admin-cmd.c |   8 ++-
 include/linux/nvme.h            |   6 ++
 8 files changed, 132 insertions(+), 52 deletions(-)

-- 
Jens Axboe

