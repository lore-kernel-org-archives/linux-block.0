Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C7C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 10:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2392168B
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 10:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="H0/L6W7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409554AbfIXKpc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:45:32 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:46322 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409553AbfIXKpb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 06:45:31 -0400
Received: by mail-pg1-f171.google.com with SMTP id a3so1074749pgm.13
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2019 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=q1G0viLU/RDlSSmlgOAiQZrcDIGZRL5YHKlCgfal0JY=;
        b=H0/L6W7mj+4h4I2DCedWOPdjxxQ+V1sEdmSNAcdE83eSd0pzN75EU1Su6CuCyEE0X4
         5REI/+N/yZspB/4ILgWwIBMU7YATXaRATMEEijlJTnH88zG0gMPw131AdRTzZ8W3q62r
         8WNKQ4JZZlWehO1nmUGFK7i0JBk6m3iORJAGsS3tL0FrBF3fP2p6GCptfGqqy8BsW0F/
         umU8qZUSIFxoBiRWYfb0pDaTznrA6BIMjlnCTc2DRYjjXu+ODzimo9lVL5h4T+wAUM0C
         S+6tSsKfJ1BAOdXInO9kK6YnnA+9LFyEkbZwxh7a6L296Hg/TCEVIHjmjXzhgXAydfIL
         ROhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=q1G0viLU/RDlSSmlgOAiQZrcDIGZRL5YHKlCgfal0JY=;
        b=oQmo8MxhKHHmkSBFYo89nMwZcg9SN3kAg5iIEQOHjyI/uf2O8NvYdBzGTx2ZT/oqDW
         97i2TnyrGAI+ZUkThK+WJkhXo9RGqxxzmpmeqCidoeJwStkhuSDsLmYNXdy0beM/IhG9
         CT2wbpLxx1UPH/CHllqS1DsyAf1O4HoOv8YA0jOPh7Q6RZefHVLTRxiOg/bTCjv62mKX
         94VJqL8D9bIyY8f3iFOp1ggowuSVv0lJCqEXQ2Wbbaltj1ARwiPs/VKKErqjuoDzEyfG
         EdnzfcaBqlihfY0ONPO3NULgRwNJ2XLvJ4UHc0GiymWsHQjcczX66zYZwWhH7qbwGptj
         IWJQ==
X-Gm-Message-State: APjAAAXM3fMnZ08tVRUgErkf4fqAQOq40+o77jNSncXP0apAvHkXvznq
        AmxGwj7o3xif+cgdaPNUv1zs+klacsJzbjji
X-Google-Smtp-Source: APXvYqwsdCUVLm55EYxLVxNlpbGTfl60+k0ztWlyUrHspkjN6wi9ukFDn332eFfa0ND3IwEiZBOw4w==
X-Received: by 2002:a17:90a:fe04:: with SMTP id ck4mr2308006pjb.74.1569321928322;
        Tue, 24 Sep 2019 03:45:28 -0700 (PDT)
Received: from ?IPv6:2600:380:8419:743e:a9a6:f93b:f300:79e6? ([2600:380:8419:743e:a9a6:f93b:f300:79e6])
        by smtp.gmail.com with ESMTPSA id h8sm1719742pfo.64.2019.09.24.03.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:45:27 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block bits for 5.4-rc1
Message-ID: <b1a3b9fe-7e66-4275-2a84-da70a4580637@kernel.dk>
Date:   Tue, 24 Sep 2019 12:45:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Some later additions that weren't quite done for the first pull request,
and also a few fixes that have arrived since. This pull request
contains:

- Kill silly pktcdvd warning on attempting to register a non-scsi
  passthrough device (me)

- Use symbolic constants for the block t10 protection types, and switch
  to handling it in core rather than in the drivers (Max)

- libahci platform missing node put fix (Nishka)

- Small series of fixes for BFQ (Paolo)

- Fix possible nbd crash (Xiubo)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.4/post-2019-09-24


----------------------------------------------------------------
Jens Axboe (1):
      pktcdvd: remove warning on attempting to register non-passthrough dev

Martin Wilck (1):
      block: drop device references in bsg_queue_rq()

Max Gurtovoy (3):
      block: use symbolic constants for t10_pi type
      block: centralize PI remapping logic to the block layer
      block: t10-pi: fix -Wswitch warning

Nishka Dasgupta (1):
      ata: libahci_platform: Add of_node_put() before loop exit

Paolo Valente (4):
      block, bfq: update inject limit only after injection occurred
      block, bfq: reduce upper bound for inject limit to max_rq_in_driver+1
      block, bfq: increase update frequency of inject limit
      block, bfq: push up injection only after setting service time

Xiubo Li (2):
      nbd: rename the runtime flags as NBD_RT_ prefixed
      nbd: fix possible page fault for nbd disk

 block/bfq-iosched.c            |  35 ++++++---
 block/blk-core.c               |   7 ++
 block/blk-integrity.c          |  11 +++
 block/blk-mq.c                 |   6 ++
 block/bsg-lib.c                |  10 ++-
 block/t10-pi.c                 | 169 +++++++++++++++++++++--------------------
 drivers/ata/libahci_platform.c |   9 ++-
 drivers/block/nbd.c            | 108 +++++++++++++++++---------
 drivers/block/pktcdvd.c        |   1 -
 drivers/md/dm-integrity.c      |  10 +++
 drivers/nvme/host/core.c       |   9 ---
 drivers/scsi/sd.c              |   8 --
 include/linux/blkdev.h         |   4 +
 include/linux/t10-pi.h         |  14 ----
 14 files changed, 237 insertions(+), 164 deletions(-)

-- 
Jens Axboe

