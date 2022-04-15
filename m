Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D01C433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 13:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbiDON1Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiDON1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 09:27:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7522F01B
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 06:24:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so8362769pjb.1
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=PDaYToyZJy928mS0mZ04ICiqHISbtfenGJA8KikCA2M=;
        b=MZcsLnwhhcCWxiXi8ivMH0gLsOG6+XoKweneCNgVmxi5ibs0XGgCcOOJc8hKlojH5F
         +bBkXwUfWqzNGvez+oxeMH2yu7F8KTFjgBjODe8GWflaDutJ/h2lYE+g2TAk1Be/uchZ
         MN/3uje65CJSW0iKPjqiS9h5DOTKLlprSWezFtYIRJtlOE98vciVkXSWquQNhgYMhT8R
         o1uRy6FA3i0R8N4sIJH5d6k3kXpZxCmjcMDXCJljgWJqAdwkaQrODNH14y9re7JdVgTb
         Na+MjOB0s8buFk95QNfi6c9kJsBoIdUtaARDVOQnrscA9+2U4uXlEkJ3w6doOLy5JoA6
         784g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=PDaYToyZJy928mS0mZ04ICiqHISbtfenGJA8KikCA2M=;
        b=veIvF5yTXBaSFsLm27L2q8gBohE4fUZgfUl/f5vhQpunJdaABwPBVM3CP7mQj5WqXx
         6K8+sxdFtZ/2cnCA/2c5qex+MgMmxC/pcAqs5x/vB827u7FZ5SZXxVjdumhDOdPAYgmU
         +0jgfsBqxk2RKAMg+Ic+Ars7RzcutTTi1Wph23w0cknp40ghW4wy5lcXYv+8msxr61zc
         MlcLZQpxFA6Hv/unYhBnfUeeWkRbLO9A6iIFU0eyQMP6G+RImlyXjK17v9zHuDuKD8J3
         5ovHaPWKZso/80uSmx0ZYodK6YFQJkIsOt/qBsJyOQfwc4BJWcPRLn6YwxqX1PEWBViz
         yemw==
X-Gm-Message-State: AOAM532i1ha/phD2ZroYUpGbQIZOvc0bAYN39EGHJF8KxJz4xPk/iebA
        TMnc6SnOaaT5FCwglauNJ6ClRCtjk950IA==
X-Google-Smtp-Source: ABdhPJzMbdvnanptc9MfUlskXyL5wcSUBR3q6MC6mEqipGEyVxSkWwJMgnGq9MXjX77Q1GC9ikgXpQ==
X-Received: by 2002:a17:902:edd1:b0:158:8318:b51e with SMTP id q17-20020a170902edd100b001588318b51emr19331261plk.89.1650029087487;
        Fri, 15 Apr 2022 06:24:47 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a4d8200b001cb41f25148sm4993167pjh.17.2022.04.15.06.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 06:24:46 -0700 (PDT)
Message-ID: <3a9f60a9-01f7-64fc-cd84-b76d162b528f@kernel.dk>
Date:   Fri, 15 Apr 2022 07:24:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.18-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Nothing major here:

- Moving of lower_48_bits() to the block layer and a fix for the
  unaligned_be48 added with that originally (Alexander, Keith)

- Fix a bad WARN_ON() for trim size checking (Ming)

- A polled IO timeout fix for null_blk (Ming)

- Silence IO error printing for dead disks (Christoph)

- Compat mode range fix (Khazhismel)

- NVMe pull request via Christoph:
	- Tone down the error logging added this merge window a bit
	  (Chaitanya Kulkarni)
	- Quirk devices with non-unique unique identifiers (Christoph)


Please pull!


The following changes since commit 286901941fd18a52b2138fddbbf589ad3639eb00:

  drbd: set QUEUE_FLAG_STABLE_WRITES (2022-04-06 13:07:53 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.18-2022-04-15

for you to fetch changes up to 89a2ee91edd9c555c59e4d38dc54b99141632cc2:

  Merge tag 'nvme-5.18-2022-04-15' of git://git.infradead.org/nvme into block-5.18 (2022-04-15 06:33:49 -0600)

----------------------------------------------------------------
block-5.18-2022-04-15

----------------------------------------------------------------
Alexander Lobakin (1):
      asm-generic: fix __get_unaligned_be48() on 32 bit platforms

Chaitanya Kulkarni (1):
      nvme: don't print verbose errors for internal passthrough requests

Christoph Hellwig (4):
      nvme: add a quirk to disable namespace identifiers
      nvme-pci: disable namespace identifiers for the MAXIO MAP1002/1202
      nvme-pci: disable namespace identifiers for Qemu controllers
      block: don't print I/O error warning for dead disks

Jens Axboe (1):
      Merge tag 'nvme-5.18-2022-04-15' of git://git.infradead.org/nvme into block-5.18

Keith Busch (1):
      block: move lower_48_bits() to block

Khazhismel Kumykov (1):
      block/compat_ioctl: fix range check in BLKGETSIZE

Ming Lei (2):
      block: fix offset/size check in bio_trim()
      block: null_blk: end timed out poll request

 block/bio.c                     |  2 +-
 block/blk-mq.c                  |  3 ++-
 block/ioctl.c                   |  2 +-
 drivers/block/null_blk/main.c   |  2 +-
 drivers/nvme/host/core.c        | 27 ++++++++++++++++++++-------
 drivers/nvme/host/nvme.h        |  5 +++++
 drivers/nvme/host/pci.c         |  9 ++++++++-
 include/asm-generic/unaligned.h |  2 +-
 include/linux/kernel.h          |  9 ---------
 include/linux/t10-pi.h          |  9 +++++++++
 10 files changed, 48 insertions(+), 22 deletions(-)

-- 
Jens Axboe

