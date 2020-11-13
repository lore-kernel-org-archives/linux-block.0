Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E96EC4742C
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 21:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8AC2224D
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 21:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T88zqg3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgKMVVX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgKMVVS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 16:21:18 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150D5C0613D1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 13:21:18 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so8084846pgg.13
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 13:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VM9D1Zy9yJQaJoMT6K9uZI8vCmKT7CVSAlCa8DT+vus=;
        b=T88zqg3F5KAik52qaaKRAnXP+FKBHbHVp7DiWonQC1laPg3yarcFjBntHq6bsSTTML
         p3WU0S0hyzjkzFsM661i6SBlZmAnMgsEXhw7ek0r29uZiPGuvS0agASVKYhVY3t3djs2
         Km+/gVnrkNp085WjkI19OPkQAtPXFbVe88WLkT+MuFPo3XU7AvoZPmJAZiaLRUDqAsLi
         lBTX1oWj7FrUfdt11E5RhYrkECOMhSyWPrNMDbIrpw/XzqvtLDCYDkaDFbImpMAfNrq9
         rdu0peUiwhj6bKAZtm74sCqTKv9YUg5jiBxEjWv00zM2TQcSkZLcHz19GlodWMT6wSMJ
         mVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VM9D1Zy9yJQaJoMT6K9uZI8vCmKT7CVSAlCa8DT+vus=;
        b=Yd3rrPoio/PS7pj0SvmdsOOgqtZ+gDOeJTvKHcNjjUOw5IwtnpN7B+tfbNZOxEy5/k
         A837O4JIelxh7v7xevdbwx8vQbegmJ5HlcnEq3zLNkcf7BCnzDuMbASnl2Pnm5IVFQSE
         pJJeE/LPTkQIGF0PdGdyS7yLApt6mYYz/7HrbwxKyDQr4lc4pu3efDIbEmj2p7zi3ZMy
         RhvPcCU8dzUnkjwAVGyd2j0U45nHv1aQP83CPjs32HifzDD9GUJal56yjTIociylDhqk
         IDNgzUcUspWrhn4bBdR16w+fWsoKDLMM/5LQleZhAdjwEeRZU8VcPtrcrw+hDI84/zMD
         KY8g==
X-Gm-Message-State: AOAM531OuwXPx+UaPIBzHlQ6y48jDeDU8JkyhzP8XIJLtmsPEzqLXueG
        oO1Z4RuJd7/fDy3MyZ7IuclVozW9LhBhug==
X-Google-Smtp-Source: ABdhPJymxFwP1DWqLyILpAohJKoa4ema8yof/wzPRtocA8TOhjOMb3CkxBMxM9B1+B5wXcAOG76GAw==
X-Received: by 2002:a63:4765:: with SMTP id w37mr3441178pgk.332.1605302477417;
        Fri, 13 Nov 2020 13:21:17 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 23sm10396580pfx.210.2020.11.13.13.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:21:16 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] block fixes for 5.10-rc
Message-ID: <dfbd8f5c-f72b-2341-0c26-546d924d5e4e@kernel.dk>
Date:   Fri, 13 Nov 2020 14:21:15 -0700
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

A few small fixes for 5.10-rc:

- NVMe pull request from Christoph:
	- don't clear the read-only bit on a revalidate (Sagi Grimberg)

- nbd error case refcount leak (Christoph)

- loop/generic uevent fix (Christoph, Petr)

Please pull!


The following changes since commit e1777d099728a76a8f8090f89649aac961e7e530:

  null_blk: Fix scheduling in atomic with zoned mode (2020-11-06 09:36:42 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-13

for you to fetch changes up to c01a21b77722db0474bbcc4eafc8c4e0d8fed6d8:

  loop: Fix occasional uevent drop (2020-11-12 13:59:04 -0700)

----------------------------------------------------------------
block-5.10-2020-11-13

----------------------------------------------------------------
Christoph Hellwig (2):
      nbd: fix a block_device refcount leak in nbd_release
      block: add a return value to set_capacity_revalidate_and_notify

Jens Axboe (1):
      Merge tag 'nvme-5.10-2020-11-10' of git://git.infradead.org/nvme into block-5.10

Petr Vorel (1):
      loop: Fix occasional uevent drop

Sagi Grimberg (1):
      nvme: fix incorrect behavior when BLKROSET is called by the user

 block/genhd.c            | 5 ++++-
 drivers/block/loop.c     | 3 ++-
 drivers/block/nbd.c      | 1 +
 drivers/nvme/host/core.c | 2 --
 include/linux/genhd.h    | 2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)

-- 
Jens Axboe

