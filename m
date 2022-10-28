Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF1CFA3740
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 21:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJ1VP6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiJ1VPp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 17:15:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B250CC707D
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 14:15:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso5592483pjc.5
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM+7jGbRz9CHy5W/YzETUnKbQlc2CDGUJyvj3qlziCE=;
        b=PgCFNLJbgd4fSJtSTzdZ2cr+up4btSvIqT98LLiGt0mgUOmQrgtw0LR9jD5EYNgT73
         PSVeLo3QQccHgBsdgeq1ngoAalU1KjBrTfU1geebSzrObhUh5SdEsOfHKYefFi+OBGB6
         k+UAb3JaLZSQ4zmNv8osrm2kfzObaPjZuAKcoJ5NZXMD72sTZqueeXGRoPIKuqrcd/Xq
         SvdDxLpAAB0NhEsR5OBNSBpG/p9OIjT2rGyhgBqD67WYQXt1MBPtGnsXWQbxfsoLzkUm
         yPb3cNc3PbutzD7+xOhR8Tq/j2O8+uuFgxqBpA2dIjiLmopReNKpS6HXASrap3s/rmz5
         9J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VM+7jGbRz9CHy5W/YzETUnKbQlc2CDGUJyvj3qlziCE=;
        b=s5ZEfE7NcIqUvPiSjn2hOhEzSWqghJOlAWslRgiInOacpXzkaYaHj40ca25yM+wo3B
         tspR4WDBHEm1V2shWl3WoeEVonz+krfdc6F8DqVzbBMp1Rjn8VTTpJW3p/HGmj1AR5U3
         jJka2qj5t3ryaWEQ5+Kixzs/PIXO9EMATOlEjnhpNEd58DL4yDLJNOzKapoWHTJbPte3
         Ospik+AfRpyNHTOliQ9MYEnLkSPwNwRHrS/Mr/If8b+VsDOJSbaBARHiMG6iX5iu6yNq
         P05yguczaEYQgzNQflcz6PF2zlNtNTbQ6A3ve+6f+lVZ1yE5izGb8Pom8H4jbqjbVvKH
         6tTw==
X-Gm-Message-State: ACrzQf1GwMbvElA/CMmsd3sV6PEM+iwVX0S7ALSEEwvriiB/hJE7RKxH
        Coz+g+C/u18zC2b1N7iEAs6ILxz0uaHSxJx3
X-Google-Smtp-Source: AMsMyM5H7TSQRZIQKMx6oAPgDtluUzTHQ5tlZlU7mfsJythfdysLUxn3eHWlWe69HRGlOjZTvS9BPQ==
X-Received: by 2002:a17:90b:38cf:b0:212:e4c8:6263 with SMTP id nn15-20020a17090b38cf00b00212e4c86263mr1313406pjb.82.1666991728562;
        Fri, 28 Oct 2022 14:15:28 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d26-20020aa797ba000000b0056cc99862f8sm1878592pfq.92.2022.10.28.14.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:15:28 -0700 (PDT)
Message-ID: <2866e5f1-4cb0-ee89-d418-a663d4b54b7c@kernel.dk>
Date:   Fri, 28 Oct 2022 15:15:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.1-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of fixes that should go into 6.1-rc3. This pull request contains:

- NVMe pull request via Christoph
	- make the multipath dma alignment match the non-multipath one
	  (Keith Busch)
	- fix a bogus use of sg_init_marker() (Nam Cao)
	- fix circulr locking in nvme-tcp (Sagi Grimberg)

- Initialization fix for requests allocated via the special hw queue
  allocator (John)

- Fix for a regression added in this release with the batched
  completions of end_io backed requests (Ming)

- Error handling leak fix for rbd (Yang)

- Error handling leak fix for add_disk() failure (Yu)

Please pull!


The following changes since commit 2db96217e7e515071726ca4ec791742c4202a1b2:

  blktrace: remove unnessary stop block trace in 'blk_trace_shutdown' (2022-10-20 06:02:52 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.1-2022-10-28

for you to fetch changes up to e3c5a78cdb6237bfb9641b63cccf366325229eec:

  blk-mq: Properly init requests from blk_mq_alloc_request_hctx() (2022-10-28 07:54:47 -0600)

----------------------------------------------------------------
block-6.1-2022-10-28

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'nvme-6.1-2022-10-27' of git://git.infradead.org/nvme into block-6.1

John Garry (1):
      blk-mq: Properly init requests from blk_mq_alloc_request_hctx()

Keith Busch (1):
      nvme-multipath: set queue dma alignment to 3

Ming Lei (1):
      blk-mq: don't add non-pt request with ->end_io to batch

Nam Cao (1):
      nvme-tcp: replace sg_init_marker() with sg_init_table()

Sagi Grimberg (1):
      nvme-tcp: fix possible circular locking when deleting a controller under memory pressure

Yang Yingliang (1):
      rbd: fix possible memory leak in rbd_sysfs_init()

Yu Kuai (1):
      block: fix memory leak for elevator on add_disk failure

 block/blk-mq.c                |  7 ++++++-
 block/genhd.c                 | 12 ++++++++----
 drivers/block/rbd.c           |  4 +++-
 drivers/nvme/host/multipath.c |  1 +
 drivers/nvme/host/tcp.c       | 13 +++++++++++--
 include/linux/blk-mq.h        |  3 ++-
 6 files changed, 31 insertions(+), 9 deletions(-)

-- 
Jens Axboe
