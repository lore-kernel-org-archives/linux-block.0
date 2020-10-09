Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8B4C433E7
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 01:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8829822240
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 01:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a0rKEOKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgJIBPw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 21:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgJIBPv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 21:15:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5F9C0613D2
        for <linux-block@vger.kernel.org>; Thu,  8 Oct 2020 18:15:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f19so5432167pfj.11
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2020 18:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lr9Cl6CQScrL/3POBphaVGhNCcH+oBEFFv+WHlBOkTA=;
        b=a0rKEOKrOvzQO8fkYcYateea/Elo4fvMRz1jRpD6+tH8L6w4g1nkWRNwWEX321q65D
         24O85GSo0ZZoyg7Yb/CuE+D/ZDufO0V7I/nDal8tLhzYAc/YQK986iGyUGMgBU0UEO+A
         Gzx9d6d3SOMCzA8NbCVKs0vWqzxm9jixfjuwpwfjPXT3h/XiPglEc3tikj7KJW+2hVcS
         jqYdjl45pJ1a3mjejFSOEue6JXgEzKCmJKjzEnaMlDOlkRvCUcIEjMGnRTbb4JgF5y1p
         7cX5BZZIx1lSu6olCv9a7AVhlnJD5YdSidfGhxNP6/ILv0AYnotQy1UgRYKk6gR4CxGE
         3tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lr9Cl6CQScrL/3POBphaVGhNCcH+oBEFFv+WHlBOkTA=;
        b=IlIjOaV8Pg8XvAyhxnkV67t/qQA5iS5FYnCojBSEvit8XSFD+GFX0ks1d1ohCtNCXM
         gbbDRQC30iDccgc5jmWzz6/jHqexi71d62Dn4i9U3KjjegzHmRTi2KEMw0lwu8gVOke/
         owWJQ8cxAHp4cQhRtnFbBS5d8Q/tuS4RoHG/j8Aj3lXk8kSoJeB+4tlx8Jykx2Yv1FUN
         c8MFoOTBfZ/KweVkPAeFEwrUTJ9ouwnuSXt6MEwTn/07h4iIp8FnmSYBCtvOV1CMFexF
         YFtXrstKDmk6QgluA+sB6JbMvIa9Ulpr+gTxDH4F9sh53VMhtApVI6odSOTjJjMZEW6W
         rAXQ==
X-Gm-Message-State: AOAM533k5nAcmdpypOYOpDsLB5ruYhSuXTTCfX9RMJVwlJurdtEygJij
        zma5xT4dyhuHKlaRmd6RcKza/7hT3C8IzIc1
X-Google-Smtp-Source: ABdhPJzkRUt5qdik2QU9E+Ko74LImzGKliJtCGIOIlZkJcvEu8CNirYaf2u+g2o0/nRDbDZZ6UCQSg==
X-Received: by 2002:a17:90a:3984:: with SMTP id z4mr1681458pjb.131.1602206149893;
        Thu, 08 Oct 2020 18:15:49 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q23sm9105153pfl.162.2020.10.08.18.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 18:15:49 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.9-final
Message-ID: <29e650f4-7e4b-bd7b-57ab-15e762d38cff@kernel.dk>
Date:   Thu, 8 Oct 2020 19:15:47 -0600
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

A few fixes that should go into this release:

- NVMe controller error path reference fix (Chaitanya)

- Fix regression with IBM partitions on non-dasd devices (Christoph)

- Fix a missing clear in the compat CDROM packet structure (Peilin)

Please pull!


The following changes since commit 632bfb6323799c087fcb4108dfe59518609667a7:

  blk-mq: call commit_rqs while list empty but error happen (2020-09-29 08:10:17 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block5.9-2020-10-08

for you to fetch changes up to e0894cd618e420d7bacebadcd26b7193780332e2:

  Merge tag 'nvme-5.9-2020-10-07' of git://git.infradead.org/nvme into block-5.9 (2020-10-07 08:24:09 -0600)

----------------------------------------------------------------
block5.9-2020-10-08

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: put ctrl ref when module ref get fail

Christoph Hellwig (1):
      partitions/ibm: fix non-DASD devices

Jens Axboe (1):
      Merge tag 'nvme-5.9-2020-10-07' of git://git.infradead.org/nvme into block-5.9

Peilin Ye (1):
      block/scsi-ioctl: Fix kernel-infoleak in scsi_put_cdrom_generic_arg()

 block/partitions/ibm.c   | 7 +++----
 block/scsi_ioctl.c       | 1 +
 drivers/nvme/host/core.c | 4 +++-
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
Jens Axboe

