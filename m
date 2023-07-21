Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A816C001DE
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 19:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjGUTef (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGUTed (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 15:34:33 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC75BE68
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 12:34:17 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7835bbeb6a0so30001739f.0
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689968057; x=1690572857;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AezxeCxJ9+yi0vDNbVIWAknf+DHGZl9cVrhAtzomDkU=;
        b=CwtrkH0/17KVJvMG0cj8gsNfW/ECumqyVK6MrgCEb4Oe54AAEbMAzskF/HCW7WYLbB
         u1ejcR6oHqod1H9aWL468NXzLfRDmolNvn/5wWm3XVZHOF/K6XMsz3EnSEj6mrEe7T7c
         4ZU6vx2AXIeQNVayeQK1ap3dHYY3R0z9NgCzj99uZ5HHyJ7otTzC0Tf7tUmgVTtnFZR8
         cB75j8kS783+eINw7peTdsDLYUwswrjzPAnRP0ec6fU/QRHr0T4yuVS6Ri6TB+5uaRoz
         iSSjVDZelXxI2luqlVCMGjXETRDFKCUPVeRz6Iai0AE2zEJz0/BlwaNiNkE8vSRGsNUj
         HaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689968057; x=1690572857;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AezxeCxJ9+yi0vDNbVIWAknf+DHGZl9cVrhAtzomDkU=;
        b=JovsGWwMO0SLVD74fSoBuWI9IXz3CBFRNGlecjM7J2Rq55kHj6zowXIOCDsX7fOJXX
         XB0aGIJw1TXoJTB05YPL/0Qiak7/chlJXmLWoVEbQj4+VtA4IPj2pL9lLxliMJa4P8tE
         BhuiDCMlGZ7VmxwwkkqHhQgWiLFIzmpcyNkhceFXMEM0MIWOmcq3eR1HLS+Fnlflzlbw
         seXweABLvpDU2iiMoCKTnlRZGr12cO2//H6Pm44tStdsyEABhQHRKCElZi5nzVuZeG3Q
         2p9H+ORhk53dNBqQAQd6y2RYGO73c4nkfF014yEyyqawBXupesrknARxkVoaOek6Fdgg
         T9gA==
X-Gm-Message-State: ABy/qLZeJIijh4YcaWKtS73UjsKK4DbIPZAUS95nrDxSoodxxIaYgx56
        KI88Vtf/DcilwhuM2Nw+ZwS/ZbYXoUAIk+gDtdg=
X-Google-Smtp-Source: APBJJlGdfKVFV5rzfReRheVi4Z8SNLM3Sqxn+9RcVwD1QPLpqkn5I1RROIlDSEluCr6DOSRRADNz+Q==
X-Received: by 2002:a05:6602:1a05:b0:780:c6bb:ad8d with SMTP id bo5-20020a0566021a0500b00780c6bbad8dmr2851629iob.0.1689968057277;
        Fri, 21 Jul 2023 12:34:17 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gu21-20020a0566382e1500b0042b09bde126sm1226749jab.165.2023.07.21.12.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 12:34:16 -0700 (PDT)
Message-ID: <4f37fe3b-7c26-742a-1fe9-f869b6303f79@kernel.dk>
Date:   Fri, 21 Jul 2023 13:34:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.5-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes related to block that should go into 6.5-rc3:

- Fix for loop regressions (Mauricio)

- Fix a potential stall with batched wakeups in sbitmap (David)

- Fix for stall with recursive plug flushes (Ross)

- Skip accounting of empty requests for blk-iocost (Chengming)

- Remove a dead field in struct blk_mq_hw_ctx (Chengming)

Please pull!


The following changes since commit 9f87fc4d72f52b26ac3e19df5e4584227fe6740c:

  block: queue data commands from the flush state machine at the head (2023-07-14 08:42:58 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.5-2023-07-21

for you to fetch changes up to bb5faa99f0ce40756ab7bbbce4f16c01ca5ebd5a:

  loop: do not enforce max_loop hard limit by (new) default (2023-07-21 13:20:57 -0600)

----------------------------------------------------------------
block-6.5-2023-07-21

----------------------------------------------------------------
Chengming Zhou (2):
      blk-mq: delete dead struct blk_mq_hw_ctx->queued field
      blk-iocost: skip empty flush bio in iocost

David Jeffery (1):
      sbitmap: fix batching wakeup

Mauricio Faria de Oliveira (2):
      loop: deprecate autoloading callback loop_probe()
      loop: do not enforce max_loop hard limit by (new) default

Ross Lagerwall (1):
      blk-mq: Fix stall due to recursive flush plug

 block/blk-core.c       |  3 +--
 block/blk-iocost.c     |  4 ++++
 block/blk-mq.c         |  9 ++++++++-
 drivers/block/loop.c   | 40 ++++++++++++++++++++++++++++++++++++++--
 include/linux/blk-mq.h |  2 --
 lib/sbitmap.c          | 15 +++++++--------
 6 files changed, 58 insertions(+), 15 deletions(-)

-- 
Jens Axboe

