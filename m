Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF36C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECEB207E8
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wszMeS8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgGBEbs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGBEbs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 00:31:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D237C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 21:31:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j12so11956603pfn.10
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 21:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sM6+cAU7blGUyETzpilLp6xInI6z6Aa9hhzxNArtq+E=;
        b=wszMeS8AAlNgHwEqRvATspMLwEXwdAHjpJkdoBm5dWUKYHiKS9z4RrU0UJJj2ZpeZc
         HE6oXcjResEz27DWAPFH7Ceh48CDzGXfrIVcWgHK3ODyfic3w9mxRjaen2HGf4eTd9ZN
         KB2lsK5nJxzf8YKlS/hWM+3z2wTGFJHKqSeEWKypM6Kv60AQaybZs7TtkXYYBFW3mjfP
         pWTB/s3nayYWkAi5iFoQQsEkfPPYsUnYQRsfFEM9xIRPiAWVdLUuaO7A/3YFZjGpEt1S
         XuKfb4ZoEqvN9iubEuQ2c3LNLFPFylT21/4Fk0waFCYlk63j2juRdHpEX1rNLlxatNjO
         l6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sM6+cAU7blGUyETzpilLp6xInI6z6Aa9hhzxNArtq+E=;
        b=bW7vGCVCCHeTqqMgLAHg//2LvrEnWhGPI790fNz/Mq6VMyXquupzNTqEzAzpXyCo6W
         C3h7AEXJ0lt2MSWWO5wKm/OPY3K1hYc268LpTBC2fMNyNQ9R0TrisnDUeD+8c89JiC7f
         MvkiQepNn205EXUEGqvIlgfkD2jFSIOBlPRj63KQgL9X/nQlAg3UE6EL9TWVTs9CNtOv
         KBEArvN4ryCEh0ywV/30uXCizU+kzHaUQxIGDfaVq2a60KAiquSMJsmAoUE9GVuMRoS9
         0cOhKjOTiJMCUuXFJlI+gsY+nyWlOiL1af/72gNjIhtRljmIAHsLfjzFEqlUd3rcwAcZ
         iZKQ==
X-Gm-Message-State: AOAM531XPjdLO8cfZP+6nNWPZFHUprA8JZyotMA/pJfPV1B5KQaZei7s
        EutjsH31hFuyXDagqZ7b41Lmcfb57glawg==
X-Google-Smtp-Source: ABdhPJwT5/snnU/eRnzweqmYpZlNN6w670ioC9MN0CU0FUSg5QkaqGLAVZYyRqBhXftTZkvMFF9DCw==
X-Received: by 2002:a63:7b15:: with SMTP id w21mr23904533pgc.386.1593664307370;
        Wed, 01 Jul 2020 21:31:47 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:b0a2:2229:1cbe:53d2? ([2605:e000:100e:8c61:b0a2:2229:1cbe:53d2])
        by smtp.gmail.com with ESMTPSA id r8sm6566991pje.28.2020.07.01.21.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 21:31:46 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.8-rc4
Message-ID: <70c99f08-5396-92d3-ff45-091a56216452@kernel.dk>
Date:   Wed, 1 Jul 2020 22:31:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

- Use kvfree_sensitive() for the block keyslot free (Eric)
- Sync blk-mq debugfs flags (Hou)
- Memory leak fix in virtio-blk error path (Hou)

Please pull!

The following changes since commit 1b52671d79c4b9fdc91a85f99f69b7c91a3b1b71:

  Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8 (2020-06-25 12:57:17 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.8-2020-07-01

for you to fetch changes up to e7eea44eefbdd5f0345a0a8b80a3ca1c21030d06:

  virtio-blk: free vblk-vqs in error path of virtblk_probe() (2020-06-30 19:02:58 -0600)

----------------------------------------------------------------
block-5.8-2020-07-01

----------------------------------------------------------------
Eric Biggers (1):
      block/keyslot-manager: use kvfree_sensitive()

Hou Tao (2):
      blk-mq-debugfs: update blk_queue_flag_name[] accordingly for new flags
      virtio-blk: free vblk-vqs in error path of virtblk_probe()

 block/blk-mq-debugfs.c     | 3 +++
 block/keyslot-manager.c    | 3 +--
 drivers/block/virtio_blk.c | 1 +
 include/linux/blkdev.h     | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

-- 
Jens Axboe

