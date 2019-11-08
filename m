Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F30AC17441
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 23:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6ED215EA
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 23:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f+rDNgTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfKHXXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 18:23:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42570 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHXXf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 18:23:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id j12so4841171plt.9
        for <linux-block@vger.kernel.org>; Fri, 08 Nov 2019 15:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=K7xQonolaC0yja0MNzkg7NiJ7wFj/oZWASuxgG6iYsM=;
        b=f+rDNgTMoW1DGnikJc+7/e4f5nkGohJRUnZK/7/LBVG0fNxs4slYgRACRml9cI4KC1
         Sa0tdfhnYGbzvJbsPWzIIBeEY0nFlYF+T1D3QlRFYx9OaBGWsIlUta27CeDSYOvsGURt
         cO44RcR3de+bqa5atS/+35stEYHcwIz2DfxSFCrRX+gSD/JBAQowoAyfUrjRNGfyYRCH
         qy7yzwo1qjlYeLYwrKZx2fedRQb+3nyLBcKgDkg3JyOx+jSHnquRl/QeKEByL6o+iobC
         hGGYPyX8GHj5gx7Tcge6fb5KST5ECfEFXvMUJmjdlZng6ZXQBtlCjAoB0wlIyUvhYMNi
         IqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=K7xQonolaC0yja0MNzkg7NiJ7wFj/oZWASuxgG6iYsM=;
        b=sWc+mv2iWq82GKn9HVw9JuSfswmAEH9vqB+2TFFHFfISUqOTfRe1S20Z+rz2uyQbX4
         2B1tdmFvlyut8vrZ2GFdEaDYMp6vffrLQgZdnEIA7FMNOJXzQsjjxm0x+Jp5Faaqkbd6
         aqgl4tAxlbhPP7avem1xRK80zdp9nJUZLWp7FO1EcpOpkroCCqn4MRNw2+NGJWZDVsvr
         QOv0ycQy24haFo7Xiie51ZBVDNWWwPWCCkxJK7QRaIU11MmgKjpP5NH+5H5cP0zZI7xH
         29EAq1LCVEFhPQoyZHru4RFAN6VmKJe0BtL70SWFk2DG93IRxolCKnqJgQzuHX2gLl+I
         TnwA==
X-Gm-Message-State: APjAAAXbE3uIshlAWJRgEwKfZvbSa7+BZGiSukKCBWOVhZlFMgKTIoCX
        0WhrVk0NL/TT1viGoxK45bXczlkktRM=
X-Google-Smtp-Source: APXvYqyz0pQqHqee4t1GYG+8X4B2poLMrx17gSqh+4PS8K1cx/CWoR8QkBPSHXgLP13XnV8IMV77+g==
X-Received: by 2002:a17:902:122:: with SMTP id 31mr9780880plb.257.1573255413903;
        Fri, 08 Nov 2019 15:23:33 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id v17sm7531175pfc.41.2019.11.08.15.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 15:23:32 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.4-rc7
Message-ID: <81051323-ef16-30a4-805b-029e2358fbac@kernel.dk>
Date:   Fri, 8 Nov 2019 16:23:29 -0700
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

Here's a small collection of fixes that should go into this release.
This pull request contains:

- Two NVMe device removal crash fixes, and a compat fixup for for an
  ioctl that was introduced in this release (Anton, Charles, Max - via
  Keith)

- Missing error path mutex unlock for drbd (Dan)

- cgroup writeback fixup on dead memcg (Tejun)

- blkcg online stats print fix (Tejun)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-2019-11-08


----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix crash in nvme_mpath_clear_ctrl_paths

Charles Machalow (1):
      nvme: change nvme_passthru_cmd64 to explicitly mark rsvd

Dan Carpenter (1):
      block: drbd: remove a stray unlock in __drbd_send_protocol()

Jens Axboe (1):
      Merge branch 'nvme-5.4-rc7' of git://git.infradead.org/nvme into for-linus

Max Gurtovoy (1):
      nvme-rdma: fix a segmentation fault during module unload

Tejun Heo (2):
      blkcg: make blkcg_print_stat() print stats only for online blkgs
      cgroup,writeback: don't switch wbs immediately on dead wbs if the memcg is dead

 block/blk-cgroup.c              | 13 ++++++++-----
 drivers/block/drbd/drbd_main.c  |  1 -
 drivers/nvme/host/multipath.c   |  2 ++
 drivers/nvme/host/rdma.c        |  8 ++++++++
 fs/fs-writeback.c               |  9 ++++++---
 include/uapi/linux/nvme_ioctl.h |  1 +
 6 files changed, 25 insertions(+), 9 deletions(-)

-- 
Jens Axboe

