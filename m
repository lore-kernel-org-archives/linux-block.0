Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A41C43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F81221EB
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NIKxzNpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIKQKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgIKQKP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 12:10:15 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2634BC061573
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 09:10:15 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a8so9514479ilk.1
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=glt0QoFiZf1HrseL+1Fb7noElaJhiqL+P8krsT1n5qo=;
        b=NIKxzNpzjhEi3NIMHT5J5XVIp5hJvAIUhVME68Y76ttSlm9JkmVT00kS+CjpSPZIpM
         ByEasgymEFxSHtlM+aPlQu5ekkJb2LMjmymuUHU+pdKiN8toq9LvPXcBNbGjfzsBujv/
         Bl1RixMGUy8/wgUY4fL6Ul+7EvC32I9oX7EKJ2bMct2QemleBVGNedwTgzBEgOYiggTj
         woIOEOaHRDmFotJgqXvPtUn+3RGun/dCa7DdGzGCk97Qsdz3ae4p8QftISahtIeEf+0u
         /hYOHjeaho6VGsCOOr5AafxJtYNzz3uT5ypAo+q8ptSwfnO2yQMJNEGI59vKOV6/8Nkc
         rltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=glt0QoFiZf1HrseL+1Fb7noElaJhiqL+P8krsT1n5qo=;
        b=pkbzsc6lpT1dFZDp1CJxaB1yMCEAS6yW8cTGhD+4shkTg8pBfDW8lYojxXuq9KgugP
         VAb4/+7oc10OZdFUGHQSGLXUPngMTTSUc2r1wA7vEy6GwC24y6LV+5qJPSDXhmF7gXRg
         X3AURw+LATAmDAC/VoA4Mx8eMYmYCZCI6xRUW+/Dv1D82SEKcMVbOaWAX4fO4D5n5y9z
         IKlM/iC130KypNaJTXFspJmwRlpjzneHDOy5AsFYrJ6WO8G6bZmmWnpVPIZ+eAh3ToaO
         bd2G9xl1AJ69ei/aOsq92k+rrvUud7pztXW/9PygQY0tDWz1x3wSrKw+H0MuaIKs6qCQ
         gVgA==
X-Gm-Message-State: AOAM530QvrgbQXwbSm28ypiB0wZBrzaAqL/ErrQcTn0Oml77bQt4nOiY
        yJTCd1icj3lbbBygI2xMEjzI4/KVjWfd5eMd
X-Google-Smtp-Source: ABdhPJzocrQKdrQQSmOuzzvd6HadgjyQ9ZsE5r7uVH0YoXdIsKKOPXH58JDfUv0ippbGQ2VeTRUnjQ==
X-Received: by 2002:a92:bb02:: with SMTP id w2mr2150084ili.215.1599840614163;
        Fri, 11 Sep 2020 09:10:14 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u89sm1494879ili.63.2020.09.11.09.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 09:10:13 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.9-rc5
Message-ID: <21cdf16d-2303-2eb7-c79b-21f75a268c43@kernel.dk>
Date:   Fri, 11 Sep 2020 10:10:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Trying to put the pull request changelog in the tag this time, not sure
what you prefer here. Anyway, a few fixes for block that we should have
in the next -rc, please pull!


The following changes since commit 7e24969022cbd61ddc586f14824fc205661bb124:

  block: allow for_each_bvec to support zero len bvec (2020-09-02 20:59:40 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-11

for you to fetch changes up to fd04358e0196fe3b7b44c69b755c7fc329360829:

  Merge tag 'nvme-5.9-2020-09-10' of git://git.infradead.org/nvme into block-5.9 (2020-09-10 07:12:22 -0600)

----------------------------------------------------------------
- Fix a regression in bdev partition locking (Christoph)

- NVMe pull request from Christoph:
	- cancel async events before freeing them (David Milburn)
	- revert a broken race fix (James Smart)
	- fix command processing during resets (Sagi Grimberg)

- Fix a kyber crash with requeued flushes (Omar)

- Fix __bio_try_merge_page() same_page error for no merging (Ritesh)

----------------------------------------------------------------
Christoph Hellwig (1):
      block: restore a specific error code in bdev_del_partition

David Milburn (3):
      nvme-fc: cancel async events before freeing event struct
      nvme-rdma: cancel async events before freeing event struct
      nvme-tcp: cancel async events before freeing event struct

James Smart (1):
      nvme: Revert: Fix controller creation races with teardown flow

Jens Axboe (1):
      Merge tag 'nvme-5.9-2020-09-10' of git://git.infradead.org/nvme into block-5.9

Omar Sandoval (1):
      block: only call sched requeue_request() for scheduled requests

Ritesh Harjani (1):
      block: Set same_page to false in __bio_try_merge_page if ret is false

Sagi Grimberg (1):
      nvme-fabrics: allow to queue requests for live queues

 block/bfq-iosched.c         | 12 ------------
 block/bio.c                 |  4 +++-
 block/blk-mq-sched.h        |  2 +-
 block/partitions/core.c     |  2 +-
 drivers/nvme/host/core.c    |  5 -----
 drivers/nvme/host/fabrics.c | 12 ++++++++----
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/nvme.h    |  1 -
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/host/tcp.c     |  1 +
 10 files changed, 16 insertions(+), 25 deletions(-)

-- 
Jens Axboe

