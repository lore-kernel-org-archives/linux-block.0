Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D6CC433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 15:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376612AbiCYP1Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377708AbiCYPYa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 11:24:30 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D837E996A
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 08:18:38 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r11so5427760ila.1
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=0vqS8dB8WjgmJeLNyA9GcuCyHHyYYs5YScRuKKL2LyY=;
        b=Fz85o4iFF0HQpXGGAfuFrAl4sG7eB3pSoTPIk76CJ995I1D6scTJ+rY4THHaJc91Ra
         jLvkOIkGNmfVxsg6juxDyD8eRtGFzkYEULLgslp9hgxi1/O+Slbwvzagca76WV+d7D0p
         W0XY1gt4yhVSs8MsfSP0oIKPpglNhBpxS5A5IhShgjXTV91Oskb4L6uDEOpdH8z/b54x
         5MMUbajr3T2EW6/z3jjirSSSo7QnhxDyWCupjvzviT/j+j42oe2wrdFPnRGAkAU7HH7k
         sCsX+I149dAj+FvvTnGV6pyJmA7Yq0SXBFxZxdtaIXZ0CvAYWhPwRJ9JpDmdonp2aXwk
         YAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=0vqS8dB8WjgmJeLNyA9GcuCyHHyYYs5YScRuKKL2LyY=;
        b=YoOucT9DpfEOxdB7pvs27fd0DJGabuTClbpuD199uRQLNv2ITURpLC1lBGSogxSWmP
         Sg8XRV8C3skuKe1gIuvHxZM/yT1hmyBQDlrVSwvSla8/xcVrHHjJqgKDLBxcXLX9rvH9
         f4yQhdMjc70QNFLHTDjKweAIlT45C2YmyNrAgyJXtLFhoc7NaOTgjWZ1T1fllteQKmwD
         JIuBkvGkOXzWgmJx8sgXqLkp6ISZ9JC+Ch6FXhYHo/pbCw5mU++AyJ35/jzRDZif74KS
         xJnHuRh5OhZGk3FOWyt/1VVlC3/Xo4m5t/q8e0F97EnkFLsVsrmH94HyH7OlM6NfVooy
         boRA==
X-Gm-Message-State: AOAM533Fqj8i+wtsPDP4VxGyXEvWLaRzIMXewcYIhWwOa80HnZ8Va21A
        Znenu6AXTQQFB+VXTql5K5+mcopUiRQcakze
X-Google-Smtp-Source: ABdhPJwUL6W8IlH3h3jKghkKr6rQOSIMJyr8QAkxG3oK1lbjgMtb3EwTvdCEIGVjn5W+fOISZRzp8A==
X-Received: by 2002:a05:6e02:168f:b0:2c8:6b4d:e9dc with SMTP id f15-20020a056e02168f00b002c86b4de9dcmr4909423ila.317.1648221517206;
        Fri, 25 Mar 2022 08:18:37 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y20-20020a5d94d4000000b00640843474e2sm3079664ior.10.2022.03.25.08.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 08:18:36 -0700 (PDT)
Message-ID: <37e3c459-0de0-3d23-11d2-7d7d39e5e941@kernel.dk>
Date:   Fri, 25 Mar 2022 09:18:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Support for 64-bit data integrity
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This pull request adds support for 64-bit data integrity in the block
layer and in NVMe.

For avoiding conflicts, this was layered on top of the write streams
removal pull request that was just sent.

Please pull!

The following changes since commit c75e707fe1aab32f1dc8e09845533b6542d9aaa9:

  block: remove the per-bio/request write hint (2022-03-07 12:45:57 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.18/64bit-pi-2022-03-25

for you to fetch changes up to 1e21270685ae4c14361dd501da62cdc4be867d4e:

  crypto: fix crc64 testmgr digest byte order (2022-03-22 19:44:29 -0600)

----------------------------------------------------------------
for-5.18/64bit-pi-2022-03-25

----------------------------------------------------------------
Jens Axboe (4):
      Merge branch 'for-5.18/block' into for-5.18/64bit-pi
      Merge branch 'for-5.18/drivers' into for-5.18/64bit-pi
      Merge branch 'for-5.18/alloc-cleanups' into for-5.18/64bit-pi
      Merge branch 'for-5.18/write-streams' into for-5.18/64bit-pi

Keith Busch (9):
      block: support pi with extended metadata
      nvme: allow integrity on extended metadata formats
      asm-generic: introduce be48 unaligned accessors
      linux/kernel: introduce lower_48_bits function
      lib: add rocksoft model crc64
      crypto: add rocksoft 64b crc guard tag framework
      block: add pi for extended integrity
      nvme: add support for enhanced metadata
      crypto: fix crc64 testmgr digest byte order

 block/Kconfig                   |   1 +
 block/bio-integrity.c           |   1 +
 block/t10-pi.c                  | 198 +++++++++++++++++++++++++++++++++++++++-
 crypto/Kconfig                  |   5 +
 crypto/Makefile                 |   1 +
 crypto/crc64_rocksoft_generic.c |  89 ++++++++++++++++++
 crypto/testmgr.c                |   7 ++
 crypto/testmgr.h                |  15 +++
 drivers/nvme/host/core.c        | 165 +++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h        |   4 +-
 include/asm-generic/unaligned.h |  26 ++++++
 include/linux/blk-integrity.h   |   1 +
 include/linux/crc64.h           |   7 ++
 include/linux/kernel.h          |   9 ++
 include/linux/nvme.h            |  53 +++++++++--
 include/linux/t10-pi.h          |  20 ++++
 lib/Kconfig                     |   9 ++
 lib/Makefile                    |   1 +
 lib/crc64-rocksoft.c            | 126 +++++++++++++++++++++++++
 lib/crc64.c                     |  28 ++++++
 lib/gen_crc64table.c            |  51 ++++++++---
 21 files changed, 770 insertions(+), 47 deletions(-)
 create mode 100644 crypto/crc64_rocksoft_generic.c
 create mode 100644 lib/crc64-rocksoft.c

-- 
Jens Axboe

