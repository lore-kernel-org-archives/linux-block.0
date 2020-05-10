Return-Path: <SRS0=ZTaq=6Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD717C47255
	for <linux-block@archiver.kernel.org>; Sun, 10 May 2020 01:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B439C208DB
	for <linux-block@archiver.kernel.org>; Sun, 10 May 2020 01:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ETkACeTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgEJBdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 May 2020 21:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726630AbgEJBdX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 May 2020 21:33:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA15C061A0C
        for <linux-block@vger.kernel.org>; Sat,  9 May 2020 18:33:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k7so1036240pjs.5
        for <linux-block@vger.kernel.org>; Sat, 09 May 2020 18:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=WqMnRNBCETALJbMSK3GnwKIEtxXc3JNvPBPsXk/tSgo=;
        b=ETkACeTx9l39mPfOflhM6DUy1tz5NW4HIsuIuNAGtiGgiqwDnZBRh4JXY2TQPEnoxw
         vnELAcT71u7Og1BhWEngQUUku1XWvgeQmi2DlsjjTTL1l74VBWOLMi2kKEva5AG6diyZ
         cm4EAHet8ryTdD2XQrt2Ni+SO7XrIBru5C1SB1aNGKYvKvq5pMZb4NIHs4oXdqVm+a0R
         KQMcph1bWZhlv5Os/wubAkxb/n3+YmLlMT2HP43OhgnSSGtfi+KLUvxgjOPRp44WzkKY
         RjtW6kKtUSm+g09lSVMkeK/u5KMYr1w1CIG3zJtTuy5+nu+xhAQWO/0Nkf1iYubXXgWr
         njag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WqMnRNBCETALJbMSK3GnwKIEtxXc3JNvPBPsXk/tSgo=;
        b=MhmEK3A4iva3OgCo+xQ3A603kdZ3lTmf4mDRBvaSMS2rPMzipIG2zJVM5XxU3LQbAD
         VzZ5D/PC2xyVaLeT/ouN50IAjPAtxF+sZQ+fJxpuaAVHWAw47ACjFFSpqHGYhetkTn2U
         6IiLX7SBJL4ksXGnK52VHdnQfEa4GRF9oos+miFw9A3olkQxF6PCYLWNvOmHPtbGiUHw
         6O8H1XVnQgebp9QWmIf2+GPqqq3wlWIzQFw+gEmIyTKXkZxSjrZ9GGACyV/P1vinOro2
         gquvhIWJijV6BKpuXy8SupnbcbCdsS/Gj5POOGP+8pVS93w9yvkIh3+fuMGwcpQntIys
         CL2Q==
X-Gm-Message-State: AGi0PubkhoCkd0bVG091GmWFdnegB9o13t1QfJtPm8Ul/gtDMtXmQkPI
        G4kVOeMMDRQAUNy1Nmn+52h360AFTlU=
X-Google-Smtp-Source: APiQypIX2btDRcBoyVPDrl6wYejYMQeFneybLm6Omyxv4KvxZvfhqwvhVn0+9R7EKt9XWa35HF+mkw==
X-Received: by 2002:a17:90a:25cb:: with SMTP id k69mr13924869pje.93.1589074401448;
        Sat, 09 May 2020 18:33:21 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z190sm5582003pfz.84.2020.05.09.18.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 18:33:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL v2] Block fixes for 5.7-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <98383cfe-ef17-45f3-a799-9eff8fc0f2fd@kernel.dk>
Date:   Sat, 9 May 2020 19:33:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Let's try this again... BFQ was missing a header, I fixed that up. To
avoid introducing a bisection breakage point, I rebased the branch.

A few fixes that should go into this series:

- Small series fixing a use-after-free of bdi name (Christoph,Yufen)

- NVMe fix for a regression with the smaller CQ update (Alexey)

- NVMe fix for a hang at namespace scanning error recovery (Sagi)

- Fix race with blk-iocost iocg->abs_vdebt updates (Tejun)

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.7-2020-05-09


----------------------------------------------------------------
Alexey Dobriyan (1):
      nvme-pci: fix "slimmer CQ head update"

Christoph Hellwig (3):
      vboxsf: don't use the source name in the bdi name
      bdi: move bdi_dev_name out of line
      bdi: add a ->dev_name field to struct backing_dev_info

Sagi Grimberg (1):
      nvme: fix possible hang when ns scanning fails during error recovery

Tejun Heo (1):
      iocost: protect iocg->abs_vdebt with iocg->waitq.lock

Yufen Yu (1):
      bdi: use bdi_dev_name() to get device name

 block/bfq-iosched.c              |   6 +-
 block/blk-cgroup.c               |   2 +-
 block/blk-iocost.c               | 117 ++++++++++++++++++++++++---------------
 drivers/nvme/host/core.c         |   2 +-
 drivers/nvme/host/pci.c          |   6 +-
 fs/ceph/debugfs.c                |   2 +-
 fs/vboxsf/super.c                |   2 +-
 include/linux/backing-dev-defs.h |   1 +
 include/linux/backing-dev.h      |   9 +--
 include/trace/events/wbt.h       |   8 +--
 mm/backing-dev.c                 |  13 ++++-
 tools/cgroup/iocost_monitor.py   |   7 ++-
 12 files changed, 107 insertions(+), 68 deletions(-)

-- 
Jens Axboe

