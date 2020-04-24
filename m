Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEE8C54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 18:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713CC20704
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 18:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iJcj1g8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgDXSAr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXSAr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 14:00:47 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7315FC09B048
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 11:00:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b12so11272730ion.8
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2020 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Hd6p5JUYfkrZldFITRJChPWsyY3nqqxtyeW+PzK3+ds=;
        b=iJcj1g8nasH25NrAQhAMX1MKRv4CHIeMesonTQxuwVo2FME0wB4JxJAhrek5bZmsxJ
         rNBjiyYiYPNCDu+kI72321A+8i3oufKUX/zNwuXi8WnhijM0ibj9N9oKp5hLhNOAkD6y
         M4KXCkCMytB/nbtWqEUeZA3dtfceChZ6segYD25dG8nm3/FvvazmG3wLGDYjaEoNqII7
         V1+Lo5GjOlN7/wbYDfUrec5oqa0F4j5ekQA3LdrGMrtw17jeKUJEDpYkyAdDF9fd+JiD
         MA3/k0k1uqghkI6eXqttmpH8tNQz789GlQpD9LSfM/f1nkP1unC0lENnV+YDdryfNIxq
         yWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Hd6p5JUYfkrZldFITRJChPWsyY3nqqxtyeW+PzK3+ds=;
        b=p+fZ3QzWDCxX1ksQwwRovvPk2ynnMPhhHQ8AQ5E6JcYWn4OQgqunepcLhgtuBv4Wlc
         LDbn+NnnPloK78Sql3BtbRGqt6IB4SJlfpW6DbEjCK3FxWtDLm8QiSPzo49dZHdjddt2
         /TRhZcRT/eK07I4KoVSaOpo4au6Ftrqg7FEMzlkDCh0anDEM/flmU6+ZEqVAWN9xnL4z
         ck6DQKGbQi+lLde0xwk2mPKGDCpqd2s1kyiKL6nUMGgKDGID/47hwop3kV2n+BIm1/No
         SX8NXnEEYmsp9wNTTDveeQJ9T3JjfsvnQJorlpGl0jTNV9ZuGEvVcC6pmbz6K+Cb0bGm
         GLRA==
X-Gm-Message-State: AGi0PuaHEsjzumfltAv0aL+dlivsfYhQGxy0x6LIzrv7fagFWhp7kHeh
        q9sPPuRF55OjzPCkmNFKutYacWAV0awMMw==
X-Google-Smtp-Source: APiQypKkj/lhMeMBPgT24jh07WcXWPhz/8C44nkYhMG5bw0lWpnFNFPLC//FAsHuzNWSlVJa4M0p3Q==
X-Received: by 2002:a02:84ee:: with SMTP id f101mr9479367jai.95.1587751243402;
        Fri, 24 Apr 2020 11:00:43 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k23sm2341078ila.45.2020.04.24.11.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:00:42 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.7-rc3
Message-ID: <ba58ee4a-7203-0365-6939-1096c8693cf9@kernel.dk>
Date:   Fri, 24 Apr 2020 12:00:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes/changes that should go into this release:

- null_blk zoned fixes (Damien)

- blkdev_close() sync improvement (Douglas)

- Fix regression in blk-iocost that impacted (at least) systemtap
  (Waiman)

- Comment fix, header removal (Zhiqiang, Jianpeng)

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.7-2020-04-24


----------------------------------------------------------------
Damien Le Moal (2):
      null_blk: Fix zoned command handling
      null_blk: Cleanup zoned device initialization

Douglas Anderson (1):
      bdev: Reduce time holding bd_mutex in sync in blkdev_close()

Ma, Jianpeng (1):
      block: remove unused header

Waiman Long (1):
      blk-iocost: Fix error on iocost_ioc_vrate_adj

Zhiqiang Liu (1):
      buffer: remove useless comment and WB_REASON_FREE_MORE_MEM, reason.

 block/blk-iocost.c               |  4 +--
 drivers/block/null_blk.h         | 29 ++++++++++++-------
 drivers/block/null_blk_main.c    | 62 ++++++++++++++++++++--------------------
 drivers/block/null_blk_zoned.c   | 45 +++++++++++++++++++++--------
 fs/block_dev.c                   | 11 ++++++-
 fs/buffer.c                      |  2 +-
 include/linux/backing-dev-defs.h |  1 -
 include/trace/events/iocost.h    |  6 ++--
 include/trace/events/writeback.h |  1 -
 9 files changed, 99 insertions(+), 62 deletions(-)

-- 
Jens Axboe

