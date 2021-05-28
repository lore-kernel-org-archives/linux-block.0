Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE350C47087
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 21:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C7D6113E
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 21:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhE1V7Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 17:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhE1V7Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 17:59:16 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF47C061574
        for <linux-block@vger.kernel.org>; Fri, 28 May 2021 14:57:39 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id b25so5713468oic.0
        for <linux-block@vger.kernel.org>; Fri, 28 May 2021 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9pLf65VypM9zEpKp62hhTO1+PuTVCoFrwgDM7NNBeqY=;
        b=HggOeXT3TUt3ymG6Gjqn1xY9faxqBCJwgBGUN06/s4bs7EjNggEdbIj6FO9HhvXSa+
         3PlUOyZrd+CGj2xLecnqLcGw90j39vAg+1UM5MxKmCBuKDWUt97Tls2PVIq920CvrANk
         FmqZKOl5orO0CkKwP9CW6N7YyTsCG2btYSwScwhk67FIkweZzysDqWEDXz3jM/XhEQJt
         jNmwD83m+u4leonvhyVkJcMQZs2U3GS1hEV56CkZBhWkqoi5p/l/N5ubOJMynYJ6u8bS
         bgkkvSk94hOXkJxkbXtCS1sPm5eHlqZndAF5n9dTkL+ntf0fPiMpZmvwWzkkM2g10gD6
         /q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9pLf65VypM9zEpKp62hhTO1+PuTVCoFrwgDM7NNBeqY=;
        b=kPo/S8q4Spcuf6VJQQZ9MKS/L3l6bSh02MMZRR2jzkdBDayVp/oPLLFzPImsXgtBX3
         WlqblOAfL6JuvLxbESgyrOj1DOgOZrYRR2l+H/Jt3kY4uMPOAg1dUe+FQvojYTVSyA3m
         HegOJMN/4SUuQJwCRqhCMdzO6FxZ7SlMtUnyEs2jAkImPJdGjDtS3pOYuYh4F2t4sl7p
         w13ZRe/sEr6lopbEXrS1EnPT/KCXmN4LGB3sl3+vpq1RF97rUVMeteC9OYg7k9Khs8lN
         eQ3VBpPO+gxWFBYYEO3F7Rtcmc7CTs2eLWs9CxCwC03rnqPxjf9ZLhootielfpgE5LXX
         fBbw==
X-Gm-Message-State: AOAM532Zr+F9xsuWkj2bFRTON65mhT3H5lPZxpvhpukdap+h6UjnCYWs
        4gfs981RHazLEtJjz4xV2ouYOejIIeLmIA==
X-Google-Smtp-Source: ABdhPJzaRqxW5F5HDLgtYwwH1OANLx/xrznl3qQBdjKaeRX2waS8pDqXXBgv2VrXYuBG0TVLm7h0EA==
X-Received: by 2002:aca:34d6:: with SMTP id b205mr7531471oia.151.1622239058879;
        Fri, 28 May 2021 14:57:38 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id y20sm1336536ooc.38.2021.05.28.14.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 14:57:38 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.13-rc4
Message-ID: <d2e82bd5-21a7-f170-1da8-5528fb5724cd@kernel.dk>
Date:   Fri, 28 May 2021 15:57:35 -0600
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

Fixes for this release:

- NVMe pull request (Christoph)
	- fix a memory leak in nvme_cdev_add (Guoqing Jiang)
	- fix inline data size comparison in nvmet_tcp_queue_response
	  (Hou Pu)
	- fix false keep-alive timeout when a controller is torn down
	  (Sagi Grimberg)
	- fix a nvme-tcp Kconfig dependency (Sagi Grimberg)
	- short-circuit reconnect retries for FC (Hannes Reinecke)
	- decode host pathing error for connect (Hannes Reinecke)

- MD pull request (Song)
	- Fix incorrect chunk boundary assert (Christoph)

- Fix s390/dasd verification panic (Stefan)

Please pull!


The following changes since commit bc6a385132601c29a6da1dbf8148c0d3c9ad36dc:

  block: fix a race between del_gendisk and BLKRRPART (2021-05-20 07:59:35 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-28

for you to fetch changes up to a4b58f1721eb4d7d27e0fdcaba60d204248dcd25:

  Merge tag 'nvme-5.13-2021-05-27' of git://git.infradead.org/nvme into block-5.13 (2021-05-27 07:38:12 -0600)

----------------------------------------------------------------
block-5.13-2021-05-28

----------------------------------------------------------------
Christoph Hellwig (1):
      md/raid5: remove an incorrect assert in in_chunk_boundary

Guoqing Jiang (1):
      nvme: fix potential memory leaks in nvme_cdev_add

Hannes Reinecke (2):
      nvme-fc: short-circuit reconnect retries
      nvme-fabrics: decode host pathing error for connect

Hou Pu (1):
      nvmet-tcp: fix inline data size comparison in nvmet_tcp_queue_response

Jens Axboe (2):
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.13
      Merge tag 'nvme-5.13-2021-05-27' of git://git.infradead.org/nvme into block-5.13

Sagi Grimberg (2):
      nvme-tcp: remove incorrect Kconfig dep in BLK_DEV_NVME
      nvmet: fix false keep-alive timeout when a controller is torn down

Stefan Haberland (1):
      s390/dasd: add missing discipline function

 drivers/md/raid5.c             |  2 --
 drivers/nvme/host/Kconfig      |  3 ++-
 drivers/nvme/host/core.c       |  4 +++-
 drivers/nvme/host/fabrics.c    |  5 +++++
 drivers/nvme/host/fc.c         | 25 +++++++++++++++++--------
 drivers/nvme/target/core.c     | 15 +++++++++++----
 drivers/nvme/target/nvmet.h    |  2 +-
 drivers/nvme/target/tcp.c      |  2 +-
 drivers/s390/block/dasd_diag.c |  8 +++++++-
 drivers/s390/block/dasd_fba.c  |  8 +++++++-
 drivers/s390/block/dasd_int.h  |  1 -
 11 files changed, 54 insertions(+), 21 deletions(-)

-- 
Jens Axboe

