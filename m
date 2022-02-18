Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D1EC433F5
	for <linux-block@archiver.kernel.org>; Fri, 18 Feb 2022 03:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiBRDsp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 22:48:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBRDsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 22:48:45 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55EC4ECC2
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 19:48:28 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id x11so6160890pll.10
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 19:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=rh9E5hVzHKf8Hq4mp5T4NxauljnDhznInuHhIXBFoNM=;
        b=PnydVvfK72xMzS3Oj8MmpA8B76klPC5uftUIpBfvkCgdQU38lBFauolaeXHPyW2SDm
         ezCuIIBPilqc6/XTQfRO4MRvwirMuySQkBbBLPhY/qM/HaUArcvFoT/956RLiJSVIaQU
         PCoobFsmFEuMdDMx8BqJZATk/zVq7hTx4pCqh2rv3odzyma6kw2I9dAQcrBAVBzG4rCA
         uxpHKBXBsSDIt7P+QxuMQRCAbuXG3WHLMOECnBvOhUVN9nH+CWzojeBJ89SEyn2BM3kU
         8CMyBOZc6INCLn6LvRcDkayEo8kZheIQi/ISk+BKufaJKbSTpIZqFk/kqqRv+PowkJuD
         djvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=rh9E5hVzHKf8Hq4mp5T4NxauljnDhznInuHhIXBFoNM=;
        b=onjShJ4co2zmvihiJELHdoP5izMEayksBYnn+VCDfpbq+RYQPjrffRAU5LUSBvkfnL
         wV38e5izDIQCaoBeIjM/F/MkmD1omyjF3AlvcNEOBcsfrzGtwWaqgtv5VvMkKLCqJCgZ
         m9wYVD7grNJF7XkTxYTX1Re7+1uFuX8qnJxRH/2+i3jh83+YiOj36DVZALPKEYqIIcdi
         pqPu38OM0ZLhhqpY0a73CTW+mImmLCW5TQGnQPFjKsiFb27QSi3U2hGmRjGUjSVLzdNO
         9qUg2rsr9DqiA7W5BY5qAs9d5YW8CxPx4F1PTqWVGTJ1YLGpBnjcTo8upDxmSxAdVUAx
         eDOQ==
X-Gm-Message-State: AOAM532SAfGwh8ur68jHpG4OCjcUoORzndLDwDRbhErogkVyJYCFurzG
        mrU/YJm1jxF8cJPebEQykaj5rSuK/xf2oQ==
X-Google-Smtp-Source: ABdhPJy59+dcLA00fbdpkugPdejb9tWIqovhvvA8Bu+mUeWJucTIZkTkH7uKUPAT6rtR9AhenpOxYg==
X-Received: by 2002:a17:90a:e284:b0:1b8:ad26:7edb with SMTP id d4-20020a17090ae28400b001b8ad267edbmr6315995pjz.53.1645156107309;
        Thu, 17 Feb 2022 19:48:27 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v10sm1051954pfu.38.2022.02.17.19.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 19:48:26 -0800 (PST)
Message-ID: <5922f9b2-a23d-20b5-c8ae-619422a08df7@kernel.dk>
Date:   Thu, 17 Feb 2022 20:48:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.17-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

- Surprise removal fix (Christoph)

- Ensure that pages are zeroed before submitted for userspace IO
  (Haimin)

- Fix blk-wbt accounting issue with BFQ (Laibin)

- Use bsize for discard granularity in loop (Ming)

- Fix missing zone handling in blk_complete_request() (Pankaj)

Please pull!


The following changes since commit bf23747ee05320903177809648002601cd140cdd:

  loop: revert "make autoclear operation asynchronous" (2022-02-11 05:51:23 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-17

for you to fetch changes up to e92bc4cd34de2ce454bdea8cd198b8067ee4e123:

  block/wbt: fix negative inflight counter when remove scsi device (2022-02-17 07:54:03 -0700)

----------------------------------------------------------------
block-5.17-2022-02-17

----------------------------------------------------------------
Christoph Hellwig (1):
      block: fix surprise removal for drivers calling blk_set_queue_dying

Haimin Zhang (1):
      block-map: add __GFP_ZERO flag for alloc_page in function bio_copy_kern

Laibin Qiu (1):
      block/wbt: fix negative inflight counter when remove scsi device

Ming Lei (1):
      block: loop:use kstatfs.f_bsize of backing file to set discard granularity

Pankaj Raghav (1):
      block: Add handling for zone append command in blk_complete_request

 block/bfq-iosched.c               |  2 ++
 block/blk-core.c                  | 10 ++--------
 block/blk-map.c                   |  2 +-
 block/blk-mq.c                    |  4 ++++
 block/elevator.c                  |  2 --
 block/genhd.c                     | 14 ++++++++++++++
 drivers/block/loop.c              |  8 +++++++-
 drivers/block/mtip32xx/mtip32xx.c |  2 +-
 drivers/block/rbd.c               |  2 +-
 drivers/block/xen-blkfront.c      |  2 +-
 drivers/md/dm.c                   |  2 +-
 drivers/nvme/host/core.c          |  2 +-
 drivers/nvme/host/multipath.c     |  2 +-
 include/linux/blkdev.h            |  3 ++-
 14 files changed, 38 insertions(+), 19 deletions(-)

-- 
Jens Axboe

