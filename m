Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DD0C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F8C218D0
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o1/Fx7dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfCOQwP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:52:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33900 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfCOQwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 12:52:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so6889492pgq.1
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=FSZvontptuzzwpJJ1cHxXYnynMkbbfRuKeOSHi5kh3w=;
        b=o1/Fx7drE0CATqbZoZsVaPz3JNc9IKisR9FqKv0v1Iv0gXc2vIUpQehpDLXPHCI8Yg
         772eSUSOaz8d8pzj9O0na7bSyUGAv+AIVHWxQ6QqiEynaNBYfDty9f2BCfl209FKIao3
         GTLsWeMK0rYA8PuyMKQlZ/Z/aFKWunC4rYTkUE3Lbqbd3HoCBh+9Y4GdMOuevMpvcrYn
         ve4orzLyp1L6IcEO0iw9KpLJT5bsiS/9RVN+8KiRn0zmTSfwDmfrbs2zxhAW9CwrWKrs
         ayBu6iF6qCFkgdlbX/ovqMa9NCCRedTnod0AemCfUcBSiP9Qiref5GV2U7RnIz5Lsf4W
         l7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=FSZvontptuzzwpJJ1cHxXYnynMkbbfRuKeOSHi5kh3w=;
        b=iFBQkTss4eOxjW/zDDX84djr8TF94bA2btjvxBIXUaeoHqJzF5V6MG+xNpFVIQoV6u
         42COfIoFLAIiF6nBh9+KQnCvF4M7/aP1vMaLpNu9RXbCJnMoRWnkqabxXnwuAYJJtOB+
         kg8W/4TOcwIc39OR8CUf1mTUhwWi4AAAtlMwFys2dKswZZSc20FXGZ7lITMlBGhwGosN
         4bRZ5c84gG367jtyc9HOpZmC1xckwgHyPhoFWL3WwUqoHLEZKTjNTBGWRmpUauOnHCHq
         9vYyerRK+WNLd4uZtCb3YSEYZwfT890BUUBtZovRVt1Q1O72qX6JHjvR8EyqhWT4dsQe
         4P6Q==
X-Gm-Message-State: APjAAAW0bvAUsNfAhRHwGIBkCi2RdgMRBiTpitSgqod2P1Betd2saGn7
        bhQARqHFRqmVHtBgIJnl4BJE8KJNNy64Zw==
X-Google-Smtp-Source: APXvYqwmOCi48PiiAQzs/5zg837j4kKj0neanLaqjQT2uwyFgJoHOzhjKqFwu5XBaeC4Imc69g2FIw==
X-Received: by 2002:a17:902:bf05:: with SMTP id bi5mr5136157plb.252.1552668734198;
        Fri, 15 Mar 2019 09:52:14 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p6sm3523866pgd.69.2019.03.15.09.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:52:13 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Late block changes for 5.1-rc1
Message-ID: <011c7a37-d0c2-0084-a8a6-4b91875171f6@kernel.dk>
Date:   Fri, 15 Mar 2019 10:52:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This is a collection of both stragglers, and fixes that came in after I
finalized the initial pull. This pull request contains:

- An MD pull request from Song, with a few minor fixes.

- Set of NVMe patches via Christoph.

- Pull request from Konrad, with a few fixes for xen/blkback.

- pblk fix IO calculation fix (Javier)

- Segment calculation fix for pass-through (Ming)

- Fallthrough annotation for blkcg (Mathieu)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.1/block-post-20190315


----------------------------------------------------------------
Aditya Pakki (1):
      md: Fix failed allocation of md_register_thread

Christoph Hellwig (5):
      nvme: disable Write Zeroes for qemu controllers
      nvme: remove nvme_ns_config_oncs
      nvme: add proper discard setup for the multipath device
      nvme: add proper write zeroes setup for the multipath device
      nvmet: ignore EOPNOTSUPP for discard

Dongli Zhang (2):
      xen/blkback: add stack variable 'blkif' in connect_ring()
      xen/blkback: rework connect_ring() to avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront

James Smart (5):
      nvme-fc: use nr_phys_segments to determine existence of sgl
      nvme-fc: fix numa_node when dev is null
      nvme-fc: reject reconnect if io queue count is reduced to zero
      nvmet-fc: fix issues with targetport assoc_list list walking
      nvmet-fc: bring Disconnect into compliance with FC-NVME spec

Javier González (1):
      pblk: fix max_io calculation

Jens Axboe (2):
      Merge branch 'stable/for-jens-5.1' of git://git.kernel.org/.../konrad/xen into for-5.1/block-post
      Merge branch 'for-5.1/md-post' of https://github.com/liu-song-6/linux into for-5.1/block-post

Keith Busch (2):
      nvme: don't warn on block content change effects
      nvme-trace: fix cdw10 buffer overrun

Mariusz Dabrowski (1):
      raid5: set write hint for PPL

Mathieu Malaterre (1):
      blkcg: annotate implicit fall through

Max Gurtovoy (1):
      nvme: add get-feature to admin cmds tracer

Ming Lei (1):
      block: fix segment calculation for passthrough IO

Sagi Grimberg (2):
      nvme: put ns_head ref if namespace fails allocation
      nvme-tcp: support C2HData with SUCCESS flag

Xiao Ni (1):
      It's wrong to add len to sector_nr in raid10 reshape twice

Yufen Yu (2):
      nvme: update comment to make the code easier to read
      nvme-loop: init nvmet_ctrl fatal_err_work when allocate

 Documentation/admin-guide/md.rst   |  3 ++
 block/blk-merge.c                  | 15 +++---
 drivers/block/xen-blkback/xenbus.c | 99 ++++++++++++++++++++++----------------
 drivers/lightnvm/pblk-rl.c         |  7 ++-
 drivers/md/raid10.c                |  3 +-
 drivers/md/raid5-log.h             |  1 +
 drivers/md/raid5-ppl.c             | 63 ++++++++++++++++++++++++
 drivers/md/raid5.c                 |  3 ++
 drivers/nvme/host/core.c           | 28 +++++------
 drivers/nvme/host/fc.c             | 36 ++++++++++++--
 drivers/nvme/host/nvme.h           |  5 ++
 drivers/nvme/host/pci.c            |  3 +-
 drivers/nvme/host/tcp.c            | 32 ++++++++++--
 drivers/nvme/host/trace.c          | 14 ++++++
 drivers/nvme/host/trace.h          |  2 +-
 drivers/nvme/target/core.c         | 20 ++++----
 drivers/nvme/target/fc.c           | 42 +++-------------
 drivers/nvme/target/io-cmd-bdev.c  |  8 +--
 drivers/nvme/target/io-cmd-file.c  |  2 +-
 kernel/trace/blktrace.c            |  1 +
 20 files changed, 259 insertions(+), 128 deletions(-)

-- 
Jens Axboe

