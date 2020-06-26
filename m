Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA18C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 19:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0695A206C3
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 19:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Wn8OdBAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgFZTkt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgFZTkt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 15:40:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197D4C03E979
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 12:40:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so5347499pge.12
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=b6bWTKBCohzXknciIdj4/TB9JpdLvGJ+V/Qc2SJ7UpY=;
        b=Wn8OdBADrajOuELUVHBDDa1Jd6u4xaWwS5Wppyc6vatdMtffU23WLuhPpfT/g7xmVs
         s4wVDyaNUx68vaGc7R3764vT/JUe+MusQM72twD/N62bze66jTU8Yzu0Zg9NxgS8gUL6
         ApTgdra9y3XMEjp297Ky5y/vCdtmVw2b416LTsdObbfSS1b7iO/wcYyF0OAmcslY6/vR
         gwOEugDICm5iau93ccxKAu2/3Suoaxk5gDA19yhehNeJ9CArLs7ZTKKqklrJ4N2Zbtnx
         RmxdAyL0AxMwg5NRxFAVJS3H2wLAb5eriRkF6mMKhmkl6GIFLutVHJtusmB7mdvwWbNQ
         A6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=b6bWTKBCohzXknciIdj4/TB9JpdLvGJ+V/Qc2SJ7UpY=;
        b=elJG5pIHM490Iqf1gNjxNX+1u/44DZ9R0xYvjp6BmsB9ZAvsXitZ2ApjGVkII9u4M8
         ufbrE3aNRJt0gMVRXtVx3l5kUyv7w/kGMOq2lWqMGBnYA6BXDuU+4lDibdRtJDPxHXwU
         tk8wq4vdsuG29OXIlUDeH92kOwks4nHsX7mn+okxczuyz3mW+EJ5p8eBfVYUPABWtGJ6
         HL82dQwQOIqEZ682smIBZIZxXmfPnaTAnuAcyqbraTxar45Q4lsJ5doqASZvcuIMu9Jo
         90hm/y+IUnGqCsBotW3F/hMtYS0L3bYwGSn0XTL7rM6WfhtuBECPBplkvpoT2+DTQ6S8
         XJKQ==
X-Gm-Message-State: AOAM533p9TU5+y8rzJCTsAa7o4BTuIaShhvHdVEJo7b0UCVE2g7dKpkZ
        qK7brXNEmDxHZXZRfqCz4q4BEJykFuHBAg==
X-Google-Smtp-Source: ABdhPJyKmIfLO3Pjfo+GY7TRdyK9p7Kb0dTJR6RFywiDFAvXgR0cZDsJxeDGJpXI8DDKo2q43Wm8Gw==
X-Received: by 2002:a63:d318:: with SMTP id b24mr223683pgg.403.1593200448201;
        Fri, 26 Jun 2020 12:40:48 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o1sm28515896pfu.70.2020.06.26.12.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 12:40:47 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.8-rc3
Message-ID: <cb6043bd-9ab0-0d3f-af78-cf9b72f10b20@kernel.dk>
Date:   Fri, 26 Jun 2020 13:40:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's a set of changes that should go into the current release:

- NVMe pull request from Christoph:
	- multipath deadlock fixes (Anton)
	- NUMA fixes (Max)
	- RDMA completion vector fix (Max)
	- IO deadlock fix (Sagi)
	- multipath reference fix (Sagi)
	- NS mutation fix (Sagi)
- Use right allocator when freeing bip in error path (Chengguang)

Please pull!

The following changes since commit 3373a3461aa15b7f9a871fa4cb2c9ef21ac20b47:

  block: make function 'kill_bdev' static (2020-06-18 09:24:35 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.8-2020-06-26

for you to fetch changes up to 1b52671d79c4b9fdc91a85f99f69b7c91a3b1b71:

  Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8 (2020-06-25 12:57:17 -0600)

----------------------------------------------------------------
block-5.8-2020-06-26

----------------------------------------------------------------
Anton Eidelman (2):
      nvme-multipath: fix deadlock between ana_work and scan_work
      nvme-multipath: fix deadlock due to head->lock

Chengguang Xu (1):
      block: release bip in a right way in error path

Jens Axboe (1):
      Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8

Max Gurtovoy (6):
      nvme: set initial value for controller's numa node
      nvme-pci: override the value of the controller's numa node
      nvme-pci: initialize tagset numa value to the value of the ctrl
      nvme-tcp: initialize tagset numa value to the value of the ctrl
      nvme-loop: initialize tagset numa value to the value of the ctrl
      nvme-rdma: assign completion vector correctly

Sagi Grimberg (3):
      nvme: fix possible deadlock when I/O is blocked
      nvme: don't protect ns mutation with ns->head->lock
      nvme-multipath: fix bogus request queue reference put

 block/bio-integrity.c         | 23 +++++++++++++---------
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 46 +++++++++++++++++++++++++++----------------
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/pci.c       |  6 ++++--
 drivers/nvme/host/rdma.c      |  2 +-
 drivers/nvme/host/tcp.c       |  4 ++--
 drivers/nvme/target/loop.c    |  4 ++--
 8 files changed, 55 insertions(+), 34 deletions(-)

-- 
Jens Axboe

