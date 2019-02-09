Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92495C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 16:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5340720836
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 16:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BX/7AFUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfBIQjL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:39:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45760 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBIQjL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 11:39:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id j3so3105222pfi.12
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 08:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0fnpwLu8b/pM0jyq9cNV9mZ9ONkzI5pESca4WYgJmas=;
        b=BX/7AFUU8XZA5jogFwDZCSmuDrO1n3spXQm3/cQJCYigrUFiyc+mrnnpgBitmdTusu
         9jJ6xFLgC9z1cBzOBoc6ouJk0R5Upl60TYCHNCOUU3SuR2RK3+Lv87gFi9smnfI4TMhz
         OM2vwyqcMbTc76umnYV8sIQ2d0CcMbb5fdSro21oFsQidd3KjrlCuWCM7ob1Bc19pqK+
         xUyUNFaE8XQrVRqvo1ImDYOX08EbrD3GqNqdX+1d08TICVVKCBgzbSAF1Otcsg7+DZv0
         +2cavpkwBW017DBo0/S7MI7QkfiHGiAua5uUeCFyGSghL8UYekm3OXmaU5LI8aiJtMNH
         i78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0fnpwLu8b/pM0jyq9cNV9mZ9ONkzI5pESca4WYgJmas=;
        b=iSBV49OgWrpvClzqTlR9ZCAkDa42P1R+8FBJpvwW9aUpIzIrT6/CK159wIVXr7urpE
         juhivqwLp4txKe49j1JW2qUWFb/iBZRedZ+3qSsL6bKmCHktmwhEM6dQr/aWrvZF59tv
         V5kKt5E9VxSjZcSqUTKaZsy7VJy6TgPmRwXusYNS4HW7GE7/0oc68wPSynHd5PZUSeW5
         9+wmAh/CVQyheixHm6eFucIgdqvHc0b1MTkNYdufl8s2yk/aOx2ytBp25s49CxLpHppK
         AUGKS1GfYBXZWQmuamwmORd0kcwox4rxUbQvePAExNJ9KVeM3oChVyWanEUICDStlk4b
         qpZg==
X-Gm-Message-State: AHQUAuaepj9iRnrObaSkfH5vDmDp5JcR3X00rF2jCac6x6YWAwUSgpWe
        U4pn9Kf9fg9XjL9JP7jXa2vvqudyAJoizg==
X-Google-Smtp-Source: AHgI3IYHdKXkNpKhfFlOd2MPuETVPOSQHDmk8criB+nvgYBm271pNAs9zW5Tl0oszbjhW4DzFV9uBw==
X-Received: by 2002:a63:f444:: with SMTP id p4mr11045239pgk.124.1549730349827;
        Sat, 09 Feb 2019 08:39:09 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id r12sm6127690pgv.83.2019.02.09.08.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 08:39:08 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.0-rc6
Message-ID: <ba1c1ae7-edcd-c918-069f-23818cf873c4@kernel.dk>
Date:   Sat, 9 Feb 2019 09:39:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Some fixes that should go into this release. This pull request contains:

- NVMe pull request from Christoph, fixing namespace locking when
  dealing with the effects log, and a rapid add/remove issue (Keith)

- blktrace tweak, ensuring requests with -1 sectors are shown (Jan)

- Link power management quirk for a Smasung SSD (Hans)

- m68k nfblock dynamic major number fix (Chengguang)

- Series fixing blk-iolatency inflight counter issue (Liu)

- Ensure that we clear ->private when setting up the aio kiocb (Mike)

- __find_get_block_slow() rate limit print (Tetsuo)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190209


Chengguang Xu (1):
      m68k: set proper major_num when specifying module param major_num

Hans de Goede (1):
      libata: Add NOLPM quirk for SAMSUNG MZ7TE512HMHP-000L1 SSD

Jan Kara (1):
      blktrace: Show requests without sector

Jens Axboe (1):
      Merge branch 'nvme-5.0' of git://git.infradead.org/nvme into for-linus

Keith Busch (2):
      nvme: lock NS list changes while handling command effects
      nvme-pci: fix rapid add remove sequence

Liu Bo (3):
      blk-iolatency: fix IO hang due to negative inflight counter
      Blk-iolatency: warn on negative inflight IO counter
      blk-mq: remove duplicated definition of blk_mq_freeze_queue

Mike Marshall (1):
      aio: initialize kiocb private in case any filesystems expect it.

Tetsuo Handa (1):
      fs: ratelimit __find_get_block_slow() failure message.

 arch/m68k/emu/nfblock.c      | 10 +++++---
 block/blk-iolatency.c        | 56 +++++++++++++++++++++++++++++++++++++-------
 block/blk-mq.h               |  1 -
 drivers/ata/libata-core.c    |  1 +
 drivers/nvme/host/core.c     |  8 ++++++-
 drivers/nvme/host/nvme.h     |  1 +
 drivers/nvme/host/pci.c      | 22 +++++++++--------
 fs/aio.c                     |  1 +
 fs/buffer.c                  | 19 ++++++++-------
 include/linux/blktrace_api.h |  8 ++++++-
 10 files changed, 94 insertions(+), 33 deletions(-)

-- 
Jens Axboe

