Return-Path: <SRS0=3mrF=YM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D409CA9EA0
	for <linux-block@archiver.kernel.org>; Sat, 19 Oct 2019 01:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168AC20663
	for <linux-block@archiver.kernel.org>; Sat, 19 Oct 2019 01:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Smi7r0vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfJSB4Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 21:56:25 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:33898 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfJSB4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 21:56:24 -0400
Received: by mail-pl1-f172.google.com with SMTP id k7so3703410pll.1
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2019 18:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fzCM0mtYgudjK1Mv602bo2zytMunOTLlRSlk0pNbqt8=;
        b=Smi7r0vchkeiLm+RJScWdfXNMLqai8ZJEyMuljJHg2S20PZOl95/NhRCuJK/mKsQPF
         kqn9s1z0vVCs11c5isc8QSfv/xn5jJUuyMLmlgoAU8uMvacd0Zki9aPImbOZ5dfIjvhE
         G5ZrgyGUtAxedjSrrRjYy/9dvITAVRzHKhPKOKgTJHaNh+7lFXmaQa03EB71Fl1aRfdQ
         cXPfanuJb7O0KLwRxlwsJhZrQ78mjRWMFJQWsLYH+noweM2pbKEP8uF/uhIxwhIn6Z8M
         QQh1kH2miY2rs2YNGjIJKsjjNhzyWixxP8nZf7t7+wgqCJxlPZd03yEV27YewXPRo0X8
         H4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fzCM0mtYgudjK1Mv602bo2zytMunOTLlRSlk0pNbqt8=;
        b=LWLAQgMYHfFEUCfNwXEKEJqDPWmA3HY86Y0bSJywAvw81Q+Xw42/89K/w4nD2M4AOF
         dpZ/WXs0j6o7hQseEn3V8WvAzSpwWu5wfQ7Mu4mAJ60WmckvQcSACp9WZIqmOGfU0rCq
         8C7N9KwIq4claWeGycLu4Z+UAomcWV1aoAAGTzRrfEcKcDSpMe5K83KTy/BXmhpg0RQN
         FwgoG1Off3e+zbCaP80/juRgjtKBlFXLoLSYuafZEymi545KeKAqIwsjOtASnll2uH55
         zlFt1tEZ1N560aBB+1pBeIerG24TqQjgJi2ZVCfVYiNsHMNJn1uu6gap6F+Hih/YZxZ9
         kWHg==
X-Gm-Message-State: APjAAAWPbOxYLhpreKqu4+1/ubqew7Lxyv9yRZ9vShI2IIMKKik/WlQu
        7gIfWQN3JKtsAC81L8dKVE4oEeAy9QmRJw==
X-Google-Smtp-Source: APXvYqzu+WatCxutvo1vOA6hLzIhHtUnQMVTRWSgQnhukgQu614dW64dPi/vo7OpUq0w4gADxSSQGg==
X-Received: by 2002:a17:902:6bc5:: with SMTP id m5mr13162406plt.282.1571450183381;
        Fri, 18 Oct 2019 18:56:23 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e6sm8858080pfl.146.2019.10.18.18.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 18:56:22 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.4-rc4
Message-ID: <10411f93-6c87-7332-1d62-03498b7fff17@kernel.dk>
Date:   Fri, 18 Oct 2019 19:56:20 -0600
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

Here's a set of fixes that should go into this series. This pull request
contains:

- NVMe pull request from Keith that address deadlocks, double
  resets, memory leaks, and other regression.

- Fixup elv_support_iosched() for bio based devices (Damien)

- Fixup for the ahci PCS quirk (Dan)

- Socket O_NONBLOCK handling fix for io_uring (me)

- Timeout sequence io_uring fixes (yangerkun_

- MD warning fix for parameter default_layout (Song)

- blkcg activation fixes (Tejun)

- blk-rq-qos node deletion fix (Tejun)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-2019-10-18


----------------------------------------------------------------
Ard Biesheuvel (1):
      nvme: retain split access workaround for capability reads

Damien Le Moal (1):
      block: Fix elv_support_iosched()

Dan Williams (1):
      libata/ahci: Fix PCS quirk application

Jens Axboe (3):
      Merge branch 'md-fixes' of https://git.kernel.org/.../song/md into for-linus
      io_uring: fix up O_NONBLOCK handling for sockets
      Merge branch 'nvme-5.4' of git://git.infradead.org/nvme into for-linus

Keith Busch (5):
      nvme-pci: Free tagset if no IO queues
      nvme: Remove ADMIN_ONLY state
      nvme: Restart request timers in resetting state
      nvme: Prevent resets during paused controller state
      nvme: Wait for reset state when required

Kevin Hao (1):
      nvme-pci: Set the prp2 correctly when using more than 4k page

Max Gurtovoy (2):
      nvmet-loop: fix possible leakage during error flow
      nvme-tcp: fix possible leakage during error flow

Sagi Grimberg (1):
      nvme: fix possible deadlock when nvme_update_formats fails

Sebastian Andrzej Siewior (1):
      nvme-tcp: Initialize sk->sk_ll_usec only with NET_RX_BUSY_POLL

Song Liu (1):
      md/raid0: fix warning message for parameter default_layout

Tejun Heo (2):
      blkcg: Fix multiple bugs in blkcg_activate_policy()
      blk-rq-qos: fix first node deletion of rq_qos_del()

yangerkun (2):
      io_uring: consider the overflow of sequence for timeout req
      io_uring: fix logic error in io_timeout

 block/blk-cgroup.c          | 69 ++++++++++++++++++++++++---------
 block/blk-rq-qos.h          | 13 +++----
 block/elevator.c            |  3 +-
 drivers/ata/ahci.c          |  4 +-
 drivers/md/raid0.c          |  2 +-
 drivers/nvme/host/core.c    | 94 ++++++++++++++++++++++++++++++++-------------
 drivers/nvme/host/fabrics.h |  3 +-
 drivers/nvme/host/nvme.h    |  5 ++-
 drivers/nvme/host/pci.c     | 83 +++++++++++++++++++++++----------------
 drivers/nvme/host/rdma.c    |  8 ++++
 drivers/nvme/host/tcp.c     | 11 ++++++
 drivers/nvme/target/loop.c  |  4 +-
 fs/io_uring.c               | 84 ++++++++++++++++++++++++++++------------
 13 files changed, 266 insertions(+), 117 deletions(-)

-- 
Jens Axboe

