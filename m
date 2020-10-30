Return-Path: <SRS0=TFq0=EF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C1CC55179
	for <linux-block@archiver.kernel.org>; Fri, 30 Oct 2020 17:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ADA120756
	for <linux-block@archiver.kernel.org>; Fri, 30 Oct 2020 17:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U3mupc89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgJ3RJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Oct 2020 13:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgJ3RJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Oct 2020 13:09:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA459C0613CF
        for <linux-block@vger.kernel.org>; Fri, 30 Oct 2020 10:09:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j18so5851586pfa.0
        for <linux-block@vger.kernel.org>; Fri, 30 Oct 2020 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AgVtlzWmedWRmKYcHvtggpv5NYZty6RgsZLIF5KxQ5o=;
        b=U3mupc89MKuweL/ZUAEC8N7/MKy4i2CB8bj0GK7aboZo1HTfuyTZnyidKZEaoOSOxm
         E1B0CZdNomb1JYJVTWfdWnN4GmlMBAaME6PfG7TMrC+5K+R8LyGE/6Rzq/rxSsi54AmC
         o9vpv0J0AEGg/li+9yTiQ0vn4t8VJ1sINMWaUO8C7y+zLBfWXV1zifS950xg1DxjEaEr
         RGVNHAfTgj3aMpqr0rQIwur0U8k3w/+gXkVrJd0UYxf63W/qaA9ei/ioSJmY4YAWFMbP
         cw6akvYpYQYVVzFGPp7uOLHwtmfn+SPh6JpOeGF0pTAnLMC/dTNGUOMw6wxTDkisFSjK
         3VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AgVtlzWmedWRmKYcHvtggpv5NYZty6RgsZLIF5KxQ5o=;
        b=Mm3TloRK+IBkJp4RIxpF3QS+uRqAf5VSKnUrs4EDf7gBxGZf+0DqF2h99mJQzv02HD
         +GJ7ZNkxTukimjt1Wg+dzAPV4FAr0bq616GoZ2dbg7IGXhbWh9smHCpgC0tLvOqwXjr5
         8/9G+SbTMKslRUGDUAwQX+K5AYqMbSay5rv4wWwkIOT3Utcsnv4YA0Z3VTNkj/WImIiD
         7HC9m9IYjcQy9Rfi4VuN0GrS7quW9XzbAtkZ8DT+WWF4ueAp3MQkalnGC+cnC/G2uOpZ
         iDBRd5LOjOs0F1Cxt69uNT7elVzhrIH3jTVhrhgCqBM+k9plNUAYktL8/V5n3I/jVQ7i
         Ga2w==
X-Gm-Message-State: AOAM532vT7sgcR93zlDrDQLs0lCr6ea2b/G4MbQRNv+M60QjClG8+xuh
        BNDpWqUJI/ab+pm3A4hWVczgI9O61yK49g==
X-Google-Smtp-Source: ABdhPJxxBRP+RqAy4yRd1kmBOjx3fkwZdCdMNMWrrQwdvvwXKBBRqj/NLuJUJ8ziuw25WFi0jYF6xQ==
X-Received: by 2002:a63:4514:: with SMTP id s20mr2857760pga.298.1604077767853;
        Fri, 30 Oct 2020 10:09:27 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21cf::1547? ([2620:10d:c090:400::5:15c3])
        by smtp.gmail.com with ESMTPSA id 197sm6406178pfa.170.2020.10.30.10.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 10:09:27 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.10-rc
Message-ID: <bd2659a5-5cb7-d011-b3b7-25b197982845@kernel.dk>
Date:   Fri, 30 Oct 2020 11:09:26 -0600
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

Fixes that should go into this release:

- null_blk zone fixes (Damien, Kanchan)

- NVMe pull request from Christoph:
	- improve zone revalidation (Keith Busch)
	- gracefully handle zero length messages in nvme-rdma (zhenwei pi)
	- nvme-fc error handling fixes (James Smart)
	- nvmet tracing NULL pointer dereference fix (Chaitanya Kulkarni)"

- xsysace platform fixes (Andy)

- scatterlist type cleanup (David)

- blk-cgroup memory fixes (Gabriel)

- nbd block size update fix (Ming)

- Flush completion state fix (Ming)

- bio_add_hw_page() iteration fix (Naohiro)

Please pull!


The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.10-2020-10-30

for you to fetch changes up to 65ff5cd04551daf2c11c7928e48fc3483391c900:

  blk-mq: mark flush request as IDLE in flush_end_io() (2020-10-30 08:33:49 -0600)

----------------------------------------------------------------
block-5.10-2020-10-30

----------------------------------------------------------------
Andy Shevchenko (1):
      xsysace: use platform_get_resource() and platform_get_irq_optional()

Chaitanya Kulkarni (1):
      nvmet: fix a NULL pointer dereference when tracing the flush command

Damien Le Moal (2):
      null_blk: Fix zone reset all tracing
      null_blk: Fix locking in zoned mode

David Disseldorp (1):
      lib/scatterlist: use consistent sg_copy_buffer() return type

Gabriel Krisman Bertazi (2):
      blk-cgroup: Fix memleak on error path
      blk-cgroup: Pre-allocate tree node on blkg_conf_prep

James Smart (4):
      nvme-fc: track error_recovery while connecting
      nvme-fc: remove err_work work item
      nvme-fc: eliminate terminate_io use by nvme_fc_error_recovery
      nvme-fc: remove nvme_fc_terminate_io()

Jens Axboe (1):
      Merge tag 'nvme-5.10-2020-10-29' of git://git.infradead.org/nvme into block-5.10

Kanchan Joshi (1):
      null_blk: synchronization fix for zoned device

Keith Busch (1):
      nvme: ignore zone validate errors on subsequent scans

Ming Lei (2):
      nbd: don't update block size after device is started
      blk-mq: mark flush request as IDLE in flush_end_io()

Naohiro Aota (1):
      block: advance iov_iter on bio_add_hw_page failure

zhenwei pi (1):
      nvme-rdma: handle unexpected nvme completion data length

 block/bio.c                    |  11 +-
 block/blk-cgroup.c             |  15 ++-
 block/blk-flush.c              |   1 +
 drivers/block/nbd.c            |   9 +-
 drivers/block/null_blk.h       |   2 +
 drivers/block/null_blk_zoned.c | 123 +++++++++++++++----
 drivers/block/xsysace.c        |  49 ++++----
 drivers/nvme/host/core.c       |   2 +-
 drivers/nvme/host/fc.c         | 270 +++++++++++++++++------------------------
 drivers/nvme/host/rdma.c       |   8 ++
 drivers/nvme/target/core.c     |   4 +-
 drivers/nvme/target/trace.h    |  21 ++--
 lib/scatterlist.c              |   2 +-
 13 files changed, 281 insertions(+), 236 deletions(-)

-- 
Jens Axboe

