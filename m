Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59112C43461
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 15:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0C520770
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 15:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P4MFbXs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgIDPYD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgIDPYC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Sep 2020 11:24:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E50C061244
        for <linux-block@vger.kernel.org>; Fri,  4 Sep 2020 08:24:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so4504403pgl.3
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2020 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VFCPhkQw53B8JgJxhDP9y1+TiaTYM1xjKsH4pOPSPHA=;
        b=P4MFbXs1lmTJ3F013B3PlHJVzn1uQh1uyf7stMg8h0lompDdEWu07HgferDx3afd1O
         xkjZBBvlP8MMAAZPr5yido5IvcfjygIio9pwEvYPcI8LDfIyV2S94B2RuA4VULhJy9DE
         60pgOM+HihZoVl9QytQ+HnW0AZCbi+1Q4QBm6mjJkoq3N2cQ8wrGBjfcbeMC81PGZmLj
         sFRd/17OeUHhC8d+C+iADJ7HcIu9Nmu+xAgy7vXLUvsx73EehC8wM4SGOKnt+B4U70XU
         OgExVJT3TCCWVy8BnD67SuVL9IBN+vgAKFxgEw/y4J9LchKk87/SuFu0n/LaKDs9OyLb
         6MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VFCPhkQw53B8JgJxhDP9y1+TiaTYM1xjKsH4pOPSPHA=;
        b=jUqXGFOGJ6QZA3q9nGf4zRhvnatjaZXq86JcabhOS8mK0zKVG3dz/fBz+KmLZhcP79
         1IrL6Uapaa5ZtF3LJW1JMjZSR5VLslNN75v7RjMhhP5/BaBFRfNurT4sHmK00RVGuqoS
         LUMqu1K+kujyfqxDIC0fyCzcQpUo9UtC7knEsN6PVMNd31ucqyFydVYU0mw6ol2HGFBw
         SBotm0jUQ5KyIz+yIRB0oNq5HLoKwSkH8cPgD56tloPMey+hDgfjcOBchg63ieXS3m+v
         qbSliL/F8T0IkwIufZghPKo6NdDvp4hNikkxQRfadIQPjjjJtSkvmF3ewLR5t0nkZBk7
         /2Fg==
X-Gm-Message-State: AOAM532GtsemucGii9RjIqHGtbhvIJ8AEjl6lPv72aX5u6mjEj4r8mn7
        +lUewx/CmybXCh0CG5ZTgHUYMkzg1jMYtXVA
X-Google-Smtp-Source: ABdhPJycIBmkEq1nZV2icceeKwVrUAeJO8dr47e9oMGq9ICzBoEUk8UaO9AYlNy/znVbVLi/A+UPHg==
X-Received: by 2002:a62:7789:: with SMTP id s131mr9021768pfc.25.1599233037934;
        Fri, 04 Sep 2020 08:23:57 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21cf::1188? ([2620:10d:c090:400::5:1a09])
        by smtp.gmail.com with ESMTPSA id s28sm7102199pfd.111.2020.09.04.08.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 08:23:44 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.9-rc4
Message-ID: <48487797-7770-0c9b-2a6f-bd3b3dae86f7@kernel.dk>
Date:   Fri, 4 Sep 2020 09:23:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A bit larger than usual this week, mostly due to the NVMe fixes arriving
late for -rc3 and hence didn't make last weeks pull request.

- NVMe:
	- instance leak and io boundary fixes from Keith
	- fc locking fix from Christophe
	- various tcp/rdma reset during traffic fixes from Sagi
	- pci use-after-free fix from Tong
	- tcp target null deref fix from Ziye

- Locking fix for partition removal (Christoph)

- Ensure bdi->io_pages is always set (me)

- Fixup for hd struct reference (Ming)

- Fix for zero length bvecs (Ming)

- Two small blk-iocost fixes (Tejun)

Please pull!


The following changes since commit a433d7217feab712ff69ef5cc2a86f95ed1aca40:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.9 (2020-08-28 07:52:02 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-04

for you to fetch changes up to 7e24969022cbd61ddc586f14824fc205661bb124:

  block: allow for_each_bvec to support zero len bvec (2020-09-02 20:59:40 -0600)

----------------------------------------------------------------
block-5.9-2020-09-04

----------------------------------------------------------------
Christoph Hellwig (1):
      block: fix locking in bdev_del_partition

Christophe JAILLET (1):
      nvmet-fc: Fix a missed _irqsave version of spin_lock in 'nvmet_fc_fod_op_done()'

Jens Axboe (2):
      Merge branch 'nvme-5.9-rc' of git://git.infradead.org/nvme into block-5.9
      block: ensure bdi->io_pages is always initialized

Keith Busch (2):
      nvme: fix controller instance leak
      nvme: only use power of two io boundaries

Ming Lei (2):
      block: release disk reference in hd_struct_free_work
      block: allow for_each_bvec to support zero len bvec

Sagi Grimberg (9):
      nvme-fabrics: don't check state NVME_CTRL_NEW for request acceptance
      nvme: have nvme_wait_freeze_timeout return if it timed out
      nvme-tcp: serialize controller teardown sequences
      nvme-tcp: fix timeout handler
      nvme-tcp: fix reset hang if controller died in the middle of a reset
      nvme-rdma: serialize controller teardown sequences
      nvme-rdma: fix timeout handler
      nvme-rdma: fix reset hang if controller died in the middle of a reset
      nvme: Fix NULL dereference for pci nvme controllers

Tejun Heo (2):
      blk-iocost: ioc_pd_free() shouldn't assume irq disabled
      blk-stat: make q->stats->lock irqsafe

Tong Zhang (1):
      nvme-pci: cancel nvme device request before disabling

Ziye Yang (1):
      nvmet-tcp: Fix NULL dereference when a connect data comes in h2cdata pdu

 block/blk-core.c            |  1 +
 block/blk-iocost.c          |  5 +--
 block/blk-stat.c            | 17 ++++++----
 block/partitions/core.c     | 37 ++++++++++++---------
 drivers/nvme/host/core.c    | 56 ++++++++++++++++++++++++-------
 drivers/nvme/host/fabrics.c |  1 -
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/pci.c     |  4 +--
 drivers/nvme/host/rdma.c    | 68 ++++++++++++++++++++++++++++----------
 drivers/nvme/host/tcp.c     | 80 ++++++++++++++++++++++++++++++++-------------
 drivers/nvme/target/fc.c    |  4 +--
 drivers/nvme/target/tcp.c   | 10 +++++-
 include/linux/bvec.h        |  9 ++++-
 13 files changed, 212 insertions(+), 82 deletions(-)

-- 
Jens Axboe

