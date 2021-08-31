Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A64C432BE
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 16:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740A161076
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 16:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbhHaQfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhHaQfv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Aug 2021 12:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630427695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4Nm2E5dDL0fqt1nXLGqz42Tw2VD6isEQXWzJaVAHvdA=;
        b=GWha+xuTkGsPN5pV+Q2k7XDs+X3gr0/tO4yh6q/CvdLgB3iLHZv6W2djMkjsR8Z1vqDlkn
        V/t1K+EAG7kixdpPJXmYdU8rpFIituiGhmPFYT9AYCgVZjDQ9cHz5Zybyo4ELqyuS9MMEf
        ym4FuOU2cN0c2q1M2ymzRbeAJGChwM8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-q6X4MzLjP0KfjkrdJqo_kQ-1; Tue, 31 Aug 2021 12:34:54 -0400
X-MC-Unique: q6X4MzLjP0KfjkrdJqo_kQ-1
Received: by mail-qk1-f200.google.com with SMTP id c27-20020a05620a165b00b003d3817c7c23so3429133qko.16
        for <linux-block@vger.kernel.org>; Tue, 31 Aug 2021 09:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4Nm2E5dDL0fqt1nXLGqz42Tw2VD6isEQXWzJaVAHvdA=;
        b=WvMxgWrM1XBjcY01qrSvamchYWXisxi1EYU3bzZu9q05WtIcrU6GQDIFoQeS9HYgWx
         PrkQm9XBNwVG9RdvS1vy0pQ9GmjT2pPFwvsTeSzTc+96ZXhF0msSCZcx80j/nKf8v85N
         RMjNY3jx5u1iuwNXfaHP3t7TwdGP+eQ93A1M3ddRlFwVmJN19sk5p9F2x61birZJ+9st
         5gF1pAz2IW2zu/crRXiSamgPvhMNCZxQObiG2Tg+x+lu5kQ/BFfpXYR4wXRlaLA7oKCo
         dO9OntGEbTp//dqkaElYIP9TfAcYc3dvKmH6WNDMPLrR3Qc2Xvn4vAkeLwYq1EaLl6uJ
         W7rA==
X-Gm-Message-State: AOAM532Hl9bUM/+cNGjrSvyjh0mjwgr6KQew76j4q8yR1OO6j/D5fmTT
        PIHNSrSUu/oVgWT4+j1m7VjXE2JfrK3Q+aP7PhXiFRq/f2znrRqfI+IZfx5GKimp6etyz3jjgtQ
        CeSCzxhd781M0w5bL180Fcg==
X-Received: by 2002:ad4:4b61:: with SMTP id m1mr30323914qvx.32.1630427693830;
        Tue, 31 Aug 2021 09:34:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9WRe9d9sxtAwb5w51gXgJZE9Z3oYHRGzs+W/AgNdM2lsO7m9vb7Uhv+/pRaD9jfA6bUTEyw==
X-Received: by 2002:ad4:4b61:: with SMTP id m1mr30323889qvx.32.1630427693650;
        Tue, 31 Aug 2021 09:34:53 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u7sm10573661qtc.75.2021.08.31.09.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:34:53 -0700 (PDT)
Date:   Tue, 31 Aug 2021 12:34:52 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Arne Welzel <arne.welzel@corelight.com>,
        Changbin Du <changbin.du@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: [git pull] device mapper changes for 5.15
Message-ID: <YS5aLC4FSqL31PLI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 99d26de2f6d79badc80f55b54bd90d4cb9d1ad90:

  writeback: make the laptop_mode prototypes available unconditionally (2021-08-10 07:00:50 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.15/dm-changes

for you to fetch changes up to d3703ef331297b6daa97f5228cbe2a657d0cfd21:

  dm crypt: use in_hardirq() instead of deprecated in_irq() (2021-08-20 16:25:07 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Add DM infrastructure for IMA-based remote attestion. These changes
  are the basis for deploying DM-based storage in a "cloud" that must
  validate configurations end-users run to maintain trust. These DM
  changes allow supported DM targets' configurations to be measured
  via IMA. But the policy and enforcement (of which configurations are
  valid) is managed by something outside the kernel (e.g. Keylime).

- Fix DM crypt scalability regression on systems with many cpus due to
  percpu_counter spinlock contention in crypt_page_alloc().

- Use in_hardirq() instead of deprecated in_irq() in DM crypt.

- Add event counters to DM writecache to allow users to further assess
  how the writecache is performing.

- Various code cleanup in DM writecache's main IO mapping function.

----------------------------------------------------------------
Arne Welzel (1):
      dm crypt: Avoid percpu_counter spinlock contention in crypt_page_alloc()

Changbin Du (1):
      dm crypt: use in_hardirq() instead of deprecated in_irq()

Mike Snitzer (3):
      dm writecache: split up writecache_map() to improve code readability
      dm writecache: factor out writecache_map_remap_origin()
      dm writecache: further writecache_map() cleanup

Mikulas Patocka (2):
      dm writecache: report invalid return from writecache_map helpers
      dm writecache: add event counters

Tushar Sugandhi (13):
      dm ima: measure data on table load
      dm ima: measure data on device resume
      dm ima: measure data on device remove
      dm ima: measure data on table clear
      dm ima: measure data on device rename
      dm: update target status functions to support IMA measurement
      dm: add documentation for IMA measurement support
      dm ima: prefix dm table hashes in ima log with hash algorithm
      dm ima: add version info to dm related events in ima log
      dm ima: prefix ima event name related to device mapper with dm_
      dm ima: add a warning in dm_init if duplicate ima events are not measured
      dm ima: update dm target attributes for ima measurements
      dm ima: update dm documentation for ima measurement support

 Documentation/admin-guide/device-mapper/dm-ima.rst | 715 ++++++++++++++++++++
 Documentation/admin-guide/device-mapper/index.rst  |   1 +
 .../admin-guide/device-mapper/writecache.rst       |  16 +-
 drivers/md/Makefile                                |   4 +
 drivers/md/dm-cache-target.c                       |  24 +
 drivers/md/dm-clone-target.c                       |   5 +
 drivers/md/dm-core.h                               |   5 +
 drivers/md/dm-crypt.c                              |  38 +-
 drivers/md/dm-delay.c                              |   4 +
 drivers/md/dm-dust.c                               |   4 +
 drivers/md/dm-ebs-target.c                         |   3 +
 drivers/md/dm-era-target.c                         |   4 +
 drivers/md/dm-flakey.c                             |   4 +
 drivers/md/dm-ima.c                                | 750 +++++++++++++++++++++
 drivers/md/dm-ima.h                                |  78 +++
 drivers/md/dm-integrity.c                          |  24 +
 drivers/md/dm-ioctl.c                              |  24 +-
 drivers/md/dm-linear.c                             |  10 +-
 drivers/md/dm-log-userspace-base.c                 |   3 +
 drivers/md/dm-log-writes.c                         |   4 +
 drivers/md/dm-log.c                                |  10 +
 drivers/md/dm-mpath.c                              |  40 +-
 drivers/md/dm-ps-historical-service-time.c         |   3 +
 drivers/md/dm-ps-io-affinity.c                     |   3 +
 drivers/md/dm-ps-queue-length.c                    |   3 +
 drivers/md/dm-ps-round-robin.c                     |   4 +
 drivers/md/dm-ps-service-time.c                    |   3 +
 drivers/md/dm-raid.c                               |  39 ++
 drivers/md/dm-raid1.c                              |  17 +
 drivers/md/dm-snap-persistent.c                    |   4 +
 drivers/md/dm-snap-transient.c                     |   4 +
 drivers/md/dm-snap.c                               |  13 +
 drivers/md/dm-stripe.c                             |  15 +
 drivers/md/dm-switch.c                             |   4 +
 drivers/md/dm-thin.c                               |   8 +
 drivers/md/dm-unstripe.c                           |   4 +
 drivers/md/dm-verity-target.c                      |  43 ++
 drivers/md/dm-writecache.c                         | 467 ++++++++-----
 drivers/md/dm-zoned-target.c                       |   3 +
 drivers/md/dm.c                                    |  12 +-
 include/linux/device-mapper.h                      |   6 +-
 include/uapi/linux/dm-ioctl.h                      |   6 +
 security/integrity/ima/ima_main.c                  |   1 +
 43 files changed, 2235 insertions(+), 197 deletions(-)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-ima.rst
 create mode 100644 drivers/md/dm-ima.c
 create mode 100644 drivers/md/dm-ima.h

