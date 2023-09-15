Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44008EED60B
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 15:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbjIOPrZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Sep 2023 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbjIOPrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2023 11:47:10 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062FD30FB
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 08:46:19 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-792973a659fso12353139f.0
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694792778; x=1695397578; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WcrzRW9qCSWpBjVS2ZjXqT6s+xONMwYvkWNoX6Olbc=;
        b=ftSstBwqR+HGrBFKX0TFEvmV8WzKAaa95Pm3Pjkfw3k+j5TSeQ0YfiR93m2wiLU4qd
         DDYPuBDiVyFOTmKgRrZ22DFL86f+bU+lb9FALgm2bdcau0Rn+QK+sbP5hHI4jC/4gxRc
         IFWlDelHy81GK/YBjDX216BshQ3av9coCqiXR93qFC9g3uMLe8GeuTa3EcA2YiBr9AtT
         3niaKOs1U5lJJFMQRhO/al7qI46cwdftaUTEHx0cc5uSkdKoGJ1BWqzC9rBV+c8bp8id
         BdacqaNE9BileyeBCx4Bo1Ib5QjqrqHLo3odOdGo/50nvSa8NeWvh+9y8fcQ2ea8MGcQ
         Y3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792778; x=1695397578;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1WcrzRW9qCSWpBjVS2ZjXqT6s+xONMwYvkWNoX6Olbc=;
        b=PkAjstv4wX04+r9L3qyIzysW0WHn71pmxIfO9eXlZwIXgzFvOIcMmQjjoWzngDJARk
         HBafMpBDQs9Bd6G+reNxY+596QtSYgUU0FN4w073shzQDKtsb+jblhS11l/BSlt7DUbH
         fRUzF7a0wySNVPDf1a5omvuSVH6maEwICY62VyLtSU64szW4uO1RzbboZOpKz/209RsS
         ZXUwWkjbGSngapUijx+Ezls4xHKlIzbUaHzw9vGny3uamD/+OIfTeVAFp3EL8gt6a96e
         kjgGq6YGXFhsEqn4/jJZzIHj907pNfN5duBs8+H2dhOcoZ7a+5NWwZag/ZHCM6yYzO9I
         yjlw==
X-Gm-Message-State: AOJu0YxvziwDATtmItQp7UETZlpmqMo5UmNSWir7bRslDaRya+hUY6AR
        RB7+5G2SX+XAN4T+ao/wBaLof2tSKC/MKZfsFpaO0w==
X-Google-Smtp-Source: AGHT+IGqf80pgLzh/+AOwjcjY9H5C53FLXDQ40PwgERx/izA6OsMK8Z3TIBVNg23N8Wc27FCYTplwQ==
X-Received: by 2002:a05:6602:1681:b0:792:6068:dcc8 with SMTP id s1-20020a056602168100b007926068dcc8mr3240247iow.2.1694792778310;
        Fri, 15 Sep 2023 08:46:18 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e24-20020a02a518000000b0042bae96eba7sm1119917jam.7.2023.09.15.08.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:46:17 -0700 (PDT)
Message-ID: <6bda4994-5bda-4b18-9143-c862baa9de35@kernel.dk>
Date:   Fri, 15 Sep 2023 09:46:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.6-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of block fixes that should go into the 6.6 kernel release:

- NVMe pull via Keith
	- nvme-tcp iov len fix (Varun)
	- nvme-hwmon const qualifier for safety (Krzysztof)
	- nvme-fc null pointer checks (Nigel)
	- nvme-pci no numa node fix (Pratyush)
	- nvme timeout fix for non-compliant controllers (Keith)

- MD pull via Song fixing regressions with both 6.5 and 6.6

- Fix a use-after-free regression in resizing blk-mq tags (Chengming)

Please pull!


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.6-2023-09-15

for you to fetch changes up to c266ae774effb858266e64b0dfd7018e58278523:

  Merge tag 'nvme-6.6-2023-09-14' of git://git.infradead.org/nvme into block-6.6 (2023-09-14 16:20:31 -0600)

----------------------------------------------------------------
block-6.6-2023-09-15

----------------------------------------------------------------
Chengming Zhou (1):
      blk-mq: fix tags UAF when shrinking q->nr_hw_queues

Jens Axboe (2):
      Merge tag 'md-fixes-20230914' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.6
      Merge tag 'nvme-6.6-2023-09-14' of git://git.infradead.org/nvme into block-6.6

Keith Busch (1):
      nvme: avoid bogus CRTO values

Krzysztof Kozlowski (1):
      nvme: host: hwmon: constify pointers to hwmon_channel_info

Mariusz Tkaczyk (1):
      md: Put the right device in md_seq_next

Nigel Croxon (1):
      md/raid1: fix error: ISO C90 forbids mixed declarations

Nigel Kirkland (1):
      nvme-fc: Prevent null pointer dereference in nvme_fc_io_getuuid()

Pratyush Yadav (1):
      nvme-pci: do not set the NUMA node of device if it has none

Varun Prakash (1):
      nvmet-tcp: pass iov_len instead of sg->length to bvec_set_page()

Yu Kuai (2):
      md: don't dereference mddev after export_rdev()
      md: fix warning for holder mismatch from export_rdev()

 block/blk-mq.c            | 13 ++++++------
 drivers/md/md.c           | 23 ++++++++++++++------
 drivers/md/md.h           |  3 +++
 drivers/md/raid1.c        |  3 +--
 drivers/nvme/host/core.c  | 54 ++++++++++++++++++++++++++++++-----------------
 drivers/nvme/host/fc.c    |  2 +-
 drivers/nvme/host/hwmon.c |  2 +-
 drivers/nvme/host/pci.c   |  3 ---
 drivers/nvme/target/tcp.c |  2 +-
 9 files changed, 65 insertions(+), 40 deletions(-)

-- 
Jens Axboe

