Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E82C43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 19:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CD6218DE
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 19:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xffuaH2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfABTHj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:07:39 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52294 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfABTHj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 14:07:39 -0500
Received: by mail-it1-f195.google.com with SMTP id g76so42240774itg.2
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 11:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Njx7GgOrOzb4U1NRWk8/CphzihZEK5phCYCCeRnP+04=;
        b=xffuaH2+63syuh2lF/5IiWKA/da3G9lUMYCCY6SWBetRgQR0ubPvyUv66cEFG8ufRi
         T/v9LSNkgbdM8VXubIVtVas/1as1ezH1AxrN2UBLaAKGHJEUvendJDAsjs8fvrKjdYZ9
         um0PZLyPJeqipfoYMP1uNW/ggNi7l8n5TjEO64ZWzslla9at/3VwqsAOt4DE5lfOdTuF
         /fEofSpWJMSCbV4fubgJ5VCrO7x2/x9Zuas/QOTUIOJxiO9ZdG9ynGogSOu4Soi1vgi3
         Yn1/bIIp3YmcxKR4amcRNf2fowAKGPjMsWsdp7IlWhBaZDUZaQz084vkx5o5oO7IpS3B
         UplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Njx7GgOrOzb4U1NRWk8/CphzihZEK5phCYCCeRnP+04=;
        b=ZISZjageCFtu9XBk4c2NFuNjr9FyMYF9bEmm4pzwYDMLij/hXTmN/1QH2Sl7T9DExL
         pGGl33T3ippwwsrgEnz9LWp/NpufBP/Y9Hq95Ke6wl8lNkD2uFW2P1+Rrq71N6FgvBiX
         heNiKCUL/VRKFAYFg5izhJEWlIsF3PImzhx/bpobAVGjFnAtaTbOYKK1BpiRjayEZ0Mv
         c1P0WaWaT2CUHIxLdgGVjLKQEOXTTpgr1T6FcPugDm+U6WzhMZbk9YGNzXcnHpdS8uEU
         1ZH27hIwqFfWt3ctlWhPH6cixkj0B9D54GNro6MVP45DeJ6eTa9MwBj/tCIYI9ODhd44
         PQ8Q==
X-Gm-Message-State: AA+aEWbAb394JwjTxvjSyrzlZBvNSpTpk/zwx5WxlDX4liPBgeLRob7M
        ZxBIB72LE1ehSy5C29rJPT/LQmjRsTwwOA==
X-Google-Smtp-Source: AFSGD/W6jWj0F+RmhvF5zs2hNuu+Z0vc9tnFyDko5Fj5U+pobSY8gkCc+km2zgMGcyq6Q1K2s1R+vA==
X-Received: by 2002:a02:9b74:: with SMTP id g49mr29441590jal.76.1546456057984;
        Wed, 02 Jan 2019 11:07:37 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 195sm21243291itm.2.2019.01.02.11.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 11:07:37 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Late block changes for this merge window
Message-ID: <f623a113-03ed-aead-33bc-65737ae36cc5@kernel.dk>
Date:   Wed, 2 Jan 2019 12:07:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Block fixes/changes that should go into this merge window, but were a
little late. Both because of the earlier pull request, but also just
late in general (like drbd). This pull request contains:

- Dead code removal for loop/sunvdc (Chengguang)

- Mark BIDI support for bsg as deprecated, logging a single dmesg
  warning if anyone is actually using it (Christoph)

- blkcg cleanup, killing a dead function and making the tryget_closest
  variant easier to read (Dennis)

- Floppy fixes, one fixing a regression in swim3 (Finn)

- lightnvm use-after-free fix (Gustavo)

- gdrom leak fix (Wenwen)

- Set of drbd updates (Lars, Luc, Nathan, Roland)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-4.21/block-20190102


----------------------------------------------------------------
Chengguang Xu (2):
      block: loop: remove redundant code
      block: sunvdc: remove redundant code

Christoph Hellwig (1):
      bsg: deprecate BIDI support in bsg

Dennis Zhou (2):
      blkcg: clean up blkg_tryget_closest()
      blkcg: remove unused __blkg_release_rcu()

Finn Thain (4):
      block/amiflop: Don't log error message on invalid ioctl
      block/swim3: Remove dead return statement
      block/swim3: Fix -EBUSY error when re-opening device after unmount
      block/swim3: Fix regression on PowerBook G3

Gustavo A. R. Silva (1):
      lightnvm: pblk: fix use-after-free bug

Lars Ellenberg (13):
      drbd: must not use connection after kref_put(&connection->kref)
      drbd: centralize printk reporting of new size into drbd_set_my_capacity()
      drbd: ignore "all zero" peer volume sizes in handshake
      drbd: disconnect, if the wrong UUIDs are attached on a connected peer
      drbd: fix confusing error message during attach
      drbd: attach on connected diskless peer must not shrink a consistent device
      drbd: reject attach of unsuitable uuids even if connected
      drbd: fix comment typos
      drbd: do not block when adjusting "disk-options" while IO is frozen
      drbd: avoid spurious self-outdating with concurrent disconnect / down
      drbd: don't retry connection if peers do not agree on "authentication" settings
      drbd: skip spurious timeout (ping-timeo) when failing promote
      drbd: introduce P_ZEROES (REQ_OP_WRITE_ZEROES on the "wire")

Luc Van Oostenryck (1):
      drbd: fix print_st_err()'s prototype to match the definition

Nathan Chancellor (2):
      drbd: Avoid Clang warning about pointless switch statment
      drbd: Change drbd_request_detach_interruptible's return type to int

Roland Kammerer (1):
      drbd: narrow rcu_read_lock in drbd_sync_handshake

Wenwen Wang (1):
      gdrom: fix a memory leak bug

 block/bio.c                        |   4 +
 block/blk-cgroup.c                 |  23 ----
 block/bsg.c                        |   4 +
 drivers/block/amiflop.c            |   2 -
 drivers/block/drbd/drbd_debugfs.c  |   2 +
 drivers/block/drbd/drbd_int.h      |  19 +--
 drivers/block/drbd/drbd_main.c     |  28 ++++-
 drivers/block/drbd/drbd_nl.c       | 133 ++++++++++++++++----
 drivers/block/drbd/drbd_protocol.h |  47 +++++++
 drivers/block/drbd/drbd_receiver.c | 251 ++++++++++++++++++++++++++++++++-----
 drivers/block/drbd/drbd_req.c      |  19 +--
 drivers/block/drbd/drbd_req.h      |   2 +
 drivers/block/drbd/drbd_state.c    |  11 +-
 drivers/block/drbd/drbd_state.h    |   5 +-
 drivers/block/drbd/drbd_worker.c   |   2 +-
 drivers/block/loop.c               |   1 -
 drivers/block/sunvdc.c             |   1 -
 drivers/block/swim3.c              |  14 ++-
 drivers/cdrom/gdrom.c              |   1 +
 drivers/lightnvm/pblk-recovery.c   |   1 -
 include/linux/blk-cgroup.h         |  21 +++-
 include/linux/drbd.h               |   2 +-
 include/linux/genl_magic_struct.h  |   5 +-
 23 files changed, 467 insertions(+), 131 deletions(-)

-- 
Jens Axboe

