Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7829EC77B6C
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 16:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDGQup (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 12:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDGQun (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 12:50:43 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC25C15A
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 09:50:41 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3230125dde5so1802035ab.1
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680886241;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2wEWCBXZz4FvlQWLtEGWe0fF/78tqvkEK7ameOAIKE=;
        b=3MQaHtBcX2OD4ZgPoX8PO8nKKfdo4FVxy7iAK4dHV7CAiXmdY99EjYcDot169H8VW3
         NyuUpwxk67ZRBf/P0xf38myjPUn3zU8rn9K+AnCNEET8dgHVAtZa4aa78tZdD0Lb6ILU
         J0auCNFGQsNIg1wxSXuwZIWxnI3Y6y9Mru7tYgxfNVZoCBZUXukiJdvtIaxrQj6l+HW2
         PqIDXMfWv7Y0+G7BtLwS1fe6MoR1GBHFJQartS6VkwvNMs3uc4r9rtGkNN7gFH/VoHTg
         klPMrN1u8MqG96iCOk1sN3p7SZfRZZBECVorhSj92D/g4dqa0puGJ1NV7vyO/E44rmXU
         oRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680886241;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F2wEWCBXZz4FvlQWLtEGWe0fF/78tqvkEK7ameOAIKE=;
        b=goZogaEa6Rb/afUBoKhOMCngGswpyd2bXAWU0Nc1TuofjULmDCWcVpSiBTwcoOl7LH
         T/n+zS7LILS3HJSRW2ADBv8/+uzTvzU/bcxdg0KOGl6o6g5o/fXk6ewjTunEcvpHUt2z
         aMVGZ/QmIEEcI+qLwXhJDHS1fgzlBS/uLL+PrGGatqtxNbIkRQ0MFyUlyX6y0M3Amg5M
         nPYO2OVj0oRhtH8r2+nKJnivTaDEW6xYz0tpHvdcRRvG7TPy5LrMKac3tBIbuzoBWAbv
         95/BCk6Wr/f5Sb0ufqWc237oXQJeS6gwwokseU7Dh77RMKLg+CiS2wfm+MqzdKzxTPW0
         XSXw==
X-Gm-Message-State: AAQBX9egP57MEYxkmKIyUs635+mdwNHQEvFklsdQi2OePC+s4mPkybQp
        Ta4LU6eo/NQqetRvwVy7zoCC6dihBqN0h3ET8i0T5g==
X-Google-Smtp-Source: AKy350ZhJ8SRYSrEcSjO9F7XMHc8yVs5t5l9tCyxWxjn753rDSIK+3GHSOMVXpCtPdwLvdn+QkGNWg==
X-Received: by 2002:a05:6602:2a48:b0:759:485:41d with SMTP id k8-20020a0566022a4800b007590485041dmr83519iov.0.1680886241222;
        Fri, 07 Apr 2023 09:50:41 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c62-20020a029644000000b00406431d0fb5sm1177037jai.72.2023.04.07.09.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 09:50:40 -0700 (PDT)
Message-ID: <52f2b320-dbcf-f276-bd86-ec6dd21b88dc@kernel.dk>
Date:   Fri, 7 Apr 2023 10:50:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.3-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few block fixes that should go into the 6.3 release:

- Ensure that ublk always reads the whole sqe upfront (me)

- Fix for a block size probing issue with ublk (Ming)

- Fix for the bio based polling (Keith)

- NVMe pull request via Christoph
	- fix discard support without oncs (Keith Busch)

- Partition scan error handling regression fix (Yu)

Please pull!


The following changes since commit 24ab70d83784a807c9ddff939ea762ef19bd4ffd:

  Merge tag 'md-fixes-2023-03-29' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.3 (2023-03-30 20:29:47 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.3-2023-04-06

for you to fetch changes up to 3723091ea1884d599cc8b8bf719d6f42e8d4d8b1:

  block: don't set GD_NEED_PART_SCAN if scan partition failed (2023-04-06 20:41:53 -0600)

----------------------------------------------------------------
block-6.3-2023-04-06

----------------------------------------------------------------
Jens Axboe (2):
      ublk: read any SQE values upfront
      Merge tag 'nvme-6.3-2023-04-06' of git://git.infradead.org/nvme into block-6.3

Keith Busch (2):
      blk-mq: directly poll requests
      nvme: fix discard support without oncs

Ming Lei (1):
      block: ublk: make sure that block size is set correctly

Yu Kuai (1):
      block: don't set GD_NEED_PART_SCAN if scan partition failed

 block/blk-mq.c           |  4 +---
 block/genhd.c            |  8 +++++++-
 drivers/block/ublk_drv.c | 26 +++++++++++++++++++++++---
 drivers/nvme/host/core.c |  6 +++---
 4 files changed, 34 insertions(+), 10 deletions(-)

-- 
Jens Axboe

