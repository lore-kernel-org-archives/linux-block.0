Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4ADC10F14
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 02:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD6721929
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 02:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lO6m90ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfJKCPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 22:15:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45293 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfJKCPg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 22:15:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so3659227pgj.12
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2019 19:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=K850VEqip4n1PNpIDtDX4bLtkRD3H1AE4OPfaYytyqI=;
        b=lO6m90tsDHR+TVvw/BYvFtFLctWJDaMm5qmsnQwtmqg2fg8eMIlymMi79KM366dkFI
         j8M99jO0IKqPczI/CedXjAFbO1caHBdx7S9LFcSIk9cgrhk/25G2vO5cGN46CCQtTMDS
         pjyp6+FovDL4VZE3WM4MBOlVFjwXEyW6Es1dSZoVWHzBJpa+E0DpxNghar0uzy8Fv+IM
         uaPpw0JZWGEbAZCw6x73VLgIM9+YQhikwu3Akv8lRvCr9rSoS0WNTCulo3U0qVkxgJNY
         bDu/sPQkmInEwZrPfDG6Mo5KcGXC7v4p8OQ+0HdGPcguwzS31Zy5LF7ghT+dGwI+UKPl
         Jllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=K850VEqip4n1PNpIDtDX4bLtkRD3H1AE4OPfaYytyqI=;
        b=KNlmQK0aH5sWtpP2BTatvbxwlmQzBZWgy0d23qUS/QGn1sTn992qb2IoxK3ZSqWTsh
         2Iq4NABuQFsdE24T40ECxoyH9jnfrccagM/zxuq5F8zk2Y+YDT51HnMfoOZriQYTcQuk
         NkLAwxmfKQI/QljaH2DQd2hrRj3VHursQrXoPK2dNqYmX+XByzAI0UFZdy6aYxo16Nxm
         LdJ7BRvq5fcPiuNwSm6FD66Xr0KkKlhle53SmDMg8MQlP3ddZpHn2oAhox6iD43gIQfD
         KVo7XBLZIlvo4I3bu/laxjdcmbs8aDlMWDNlTcXY1Zw3IfqhbE+6ZZPzds8bXY1b4PBI
         BqxA==
X-Gm-Message-State: APjAAAUhyqGPIOnlfAWjPDj5ljmD3K82cSJgpdxbnJ4BsyFVEDGTodjK
        0a9z8LGR5zg/hOLKnn4FPdIsOIbM8FzzPg==
X-Google-Smtp-Source: APXvYqzEkT4NWbj/tf/13SBP0LcenoJJSjE/Pe3+ZDnXN24Q/8PiAJXvJFr1k/I7+oOvUZMcGASRyQ==
X-Received: by 2002:a17:90a:9dc7:: with SMTP id x7mr15059604pjv.103.1570760134531;
        Thu, 10 Oct 2019 19:15:34 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id s18sm6382966pji.30.2019.10.10.19.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 19:15:33 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.4-rc3
Message-ID: <da741fa2-7db4-95f4-18ee-5932fbd4b00a@kernel.dk>
Date:   Thu, 10 Oct 2019 20:15:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's a set of fixes that should go into this release. This pull
request contains:

- Fix wbt performance regression introduced with the blk-rq-qos
  refactoring (Harshad)

- Fix io_uring fileset removal inadvertently killing the workqueue (me)

- Fix io_uring typo in linked command nonblock submission (Pavel)

- Remove spurious io_uring wakeups on request free (Pavel)

- Fix null_blk zoned command error return (Keith)

- Don't use freezable workqueues for backing_dev, also means we can
  revert a previous libata hack (Mika)

- Fix nbd sysfs mutex dropped too soon at removal time (Xiubo)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20191010


----------------------------------------------------------------
Harshad Shirwadkar (1):
      blk-wbt: fix performance regression in wbt scale_up/scale_down

Jens Axboe (1):
      io_uring: only flush workqueues on fileset removal

Keith Busch (1):
      null_blk: Fix zoned command return code

Mika Westerberg (2):
      bdi: Do not use freezable workqueue
      Revert "libata, freezer: avoid block device removal while system is frozen"

Pavel Begunkov (2):
      io_uring: fix reversed nonblock flag for link submission
      io_uring: remove wait loop spurious wakeups

Xiubo Li (1):
      nbd: fix possible sysfs duplicate warning

 block/blk-rq-qos.c             | 14 +++++++++-----
 block/blk-rq-qos.h             |  4 ++--
 block/blk-wbt.c                |  6 ++++--
 drivers/ata/libata-scsi.c      | 21 ---------------------
 drivers/block/nbd.c            |  2 +-
 drivers/block/null_blk_zoned.c |  3 +--
 fs/io_uring.c                  | 24 ++++++++++--------------
 kernel/freezer.c               |  6 ------
 mm/backing-dev.c               |  4 ++--
 9 files changed, 29 insertions(+), 55 deletions(-)

-- 
Jens Axboe

