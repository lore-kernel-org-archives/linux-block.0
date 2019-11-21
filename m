Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5776BC432C0
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 17:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C42B2067D
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 17:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="glW0jlC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKURXo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:23:44 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44144 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKURXo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 12:23:44 -0500
Received: by mail-io1-f67.google.com with SMTP id j20so4310328ioo.11
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2019 09:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=EuMkZCtRW11lPNc/7SdaBZZQOZZNZLP3L2g1n8DSZpw=;
        b=glW0jlC9YCqHSTbXMmPn6uUzdfU92CNeF6hWrCqNLi1LJeGtz5xr7UXWMtbWDNQ7GK
         QV59Y1GwBjsJu9v7LL0z8oJXxHTFoZQ750eWsakwaFC39MT2EMbBTQK6PK8vpTzT3iyg
         8bEJkbalk22ebH8lTaN3ASe5di2TEiokuH8FhIfw7SxNC7EAntSa2O65JfoQ/OFS9QjR
         uXVUo+0y3IPhReP1mmN+5ygYs+2IievE2cxSyGRlHVBzibhK0OS1qoXe2tXkSdwNFcb1
         51G7/jAv2P7kTrx+V8OhaBl6jJzYWyjkkLNy3yL+TLs5eJhE/ptAdVHR5/ydEb0CRbIn
         YHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=EuMkZCtRW11lPNc/7SdaBZZQOZZNZLP3L2g1n8DSZpw=;
        b=j3PssLLZWO2ghAtwaqjHk4PhYVgDqf3pOLqAqlbuCG8kKrIi7YioSRn7ucSmrJJ38s
         xPe9CzP5mV4qw4ijd+egJNheLZb5pkjumKufEjXn4AJ40IzcrY/p7MRFVYuU5ahSCqRc
         dah1jMxWt5IUXqLhbO0RE2NRNKtk+ds2O2nVWfhdYvJqGS7/YbVsfJQ5ImuyMmKACVcv
         98UGpzVZ1SANkf27+AdLSRaDF3Sd4HMohVp+dk50hNfY8lqePebnSsYeiFUA+LVE3qdy
         pFziKBxvheL6saSi3KvBIUBMldMYWcFASF/Oi1Yt+sCmWC2C4z9bkBdxW5lRzBFMO/rM
         IfCw==
X-Gm-Message-State: APjAAAV4MHItWaTzUYMVOporEiU3If6+k2wCsTQPOTGqBiTJEK1PVK5k
        MjSrzX7AQGd2qzpYDUPUrzmxgtSqfu09dw==
X-Google-Smtp-Source: APXvYqx3BQHyPNhf8BOIDv/ygCSCxR6qucHBLCkB3HR/XzlaOboeU2ANjt8BVpYr7u3QmLCzls0xyg==
X-Received: by 2002:a6b:f302:: with SMTP id m2mr8786047ioh.109.1574357020981;
        Thu, 21 Nov 2019 09:23:40 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c5sm1105096ioc.26.2019.11.21.09.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 09:23:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Core block changes for 5.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <01989838-5239-70b9-a3b6-f2d73e311c97@kernel.dk>
Date:   Thu, 21 Nov 2019 10:23:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This pull request contains the core block changes for 5.5. Due to more
granular branches, this one is small and will be followed with other
core branches that add specific features. I meant to just have a core
and drivers branch, but external dependencies we ended up adding a few
more that are also core. For this request, the changes are:

- Fixes and improvements for the zoned device support (Ajay, Damien)

- sed-opal table writing and datastore UID (Revanth)

- blk-cgroup (and bfq) blk-cgroup stat fixes (Tejun)

- Improvements to the block stats tracking (Pavel)

- Fix for overruning sysfs buffer for large number of CPUs (Ming)

- Optimization for small IO (Ming, Christoph)

- Fix typo in RWH lifetime hint (Eugene)

- Dead code removal and documentation (Bart)

- Reduction in memory usage for queue and tag set (Bart)

- Kerneldoc header documentation (André)

- Device/partition revalidation fixes (Jan)

- Stats tracking for flush requests (Konstantin)

- Various other little fixes here and there (et al)


Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.5/block-20191121


----------------------------------------------------------------
Ajay Joshi (2):
      block: add zone open, close and finish operations
      block: add zone open, close and finish ioctl support

André Almeida (2):
      blk-mq: remove needless goto from blk_mq_get_driver_tag
      blk-mq: fill header with kernel-doc

Bart Van Assche (9):
      block: Fix three kernel-doc warnings
      block: Fix writeback throttling W=1 compiler warnings
      block: Remove request_queue.nr_queues
      block: Remove "dying" checks from sysfs callbacks
      block: Reduce sysfs_lock locking inside blk_cleanup_queue()
      block: Document all members of blk_mq_tag_set and bkl_mq_queue_map
      block: Remove the synchronize_rcu() call from __blk_mq_update_nr_hw_queues()
      block: Reduce the amount of memory required per request queue
      block: Reduce the amount of memory used for tag sets

Christoph Hellwig (1):
      block: avoid blk_bio_segment_split for small I/O operations

Damien Le Moal (2):
      block: Remove REQ_OP_ZONE_RESET plugging
      block: Simplify REQ_OP_ZONE_RESET_ALL handling

David Sterba (1):
      block: reorder bio::__bi_remaining for better packing

Dmitry Monakhov (1):
      block,bfq: Skip tracing hooks if possible

Eugene Syromiatnikov (1):
      fcntl: fix typo in RWH_WRITE_LIFE_NOT_SET r/w hint name

Jan Kara (3):
      bdev: Factor out bdev revalidation into a common helper
      bdev: Refresh bdev size for disks without partitioning
      block: Warn if elevator= parameter is used

Jens Axboe (2):
      Merge branch 'for-linus' into for-5.5/block
      Revert "block: split bio if the only bvec's length is > SZ_4K"

John Garry (3):
      blk-mq: Make blk_mq_run_hw_queue() return void
      blk-mq: Delete blk_mq_has_free_tags() and blk_mq_can_queue()
      sbitmap: Delete sbitmap_any_bit_clear()

Konstantin Khlebnikov (1):
      block: add iostat counters for flush requests

Logan Gunthorpe (1):
      block: account statistics for passthrough requests

Ming Lei (4):
      blk-mq: avoid sysfs buffer overflow with too many CPU cores
      blk-mq: make sure that line break can be printed
      block: still try to split bio if the bvec crosses pages
      block: split bio if the only bvec's length is > SZ_4K

Pavel Begunkov (4):
      blk-mq: Inline status checkers
      blk-mq: Reuse callback in blk_mq_in_flight*()
      blk-mq: Embed counters into struct mq_inflight
      blk-stat: Optimise blk_stat_add()

Revanth Rajashekar (4):
      block: sed-opal: Generalizing write data to any opal table
      block: sed-opal: Add support to read/write opal tables generically
      block: sed-opal: Introduce Opal Datastore UID
      block: sed-opal: Introduce SUM_SET_LIST parameter and append it using 'add_token_u64'

Sebastian Andrzej Siewior (1):
      block: Don't disable interrupts in trigger_softirq()

Tejun Heo (7):
      bfq-iosched: relocate bfqg_*rwstat*() helpers
      bfq-iosched: stop using blkg->stat_bytes and ->stat_ios
      blk-throtl: stop using blkg->stat_bytes and ->stat_ios
      blk-cgroup: remove now unused blkg_print_stat_{bytes|ios}_recursive()
      blk-cgroup: reimplement basic IO stats using cgroup rstat
      blk-cgroup: separate out blkg_rwstat under CONFIG_BLK_CGROUP_RWSTAT
      blk-cgroup: cgroup_rstat_updated() shouldn't be called on cgroup1

 Documentation/ABI/testing/procfs-diskstats |   5 +
 Documentation/ABI/testing/sysfs-block      |   6 +
 Documentation/admin-guide/iostats.rst      |   9 +
 Documentation/block/stat.rst               |  14 +-
 block/Kconfig                              |   4 +
 block/Kconfig.iosched                      |   1 +
 block/Makefile                             |   1 +
 block/bfq-cgroup.c                         |  85 ++++----
 block/bfq-iosched.c                        |   4 +
 block/bfq-iosched.h                        |  10 +
 block/blk-cgroup-rwstat.c                  | 129 ++++++++++++
 block/blk-cgroup-rwstat.h                  | 149 ++++++++++++++
 block/blk-cgroup.c                         | 304 +++++++++------------------
 block/blk-core.c                           |  16 +-
 block/blk-exec.c                           |   2 +
 block/blk-flush.c                          |  15 +-
 block/blk-merge.c                          |  17 +-
 block/blk-mq-sysfs.c                       |  31 ++-
 block/blk-mq-tag.c                         |   8 -
 block/blk-mq-tag.h                         |   1 -
 block/blk-mq.c                             | 136 ++++++------
 block/blk-mq.h                             |   9 -
 block/blk-softirq.c                        |   4 -
 block/blk-stat.c                           |   7 +-
 block/blk-sysfs.c                          |   8 -
 block/blk-throttle.c                       |  71 ++++++-
 block/blk-zoned.c                          |  99 ++++-----
 block/blk.h                                |   7 +-
 block/elevator.c                           |   9 +
 block/genhd.c                              |   8 +-
 block/ioctl.c                              |   5 +-
 block/opal_proto.h                         |   6 +-
 block/partition-generic.c                  |   7 +-
 block/sed-opal.c                           | 318 ++++++++++++++++++++++-------
 block/t10-pi.c                             |   8 +-
 drivers/md/dm-zoned-metadata.c             |   6 +-
 fs/block_dev.c                             |  37 ++--
 fs/f2fs/segment.c                          |   3 +-
 fs/fcntl.c                                 |   2 +-
 include/linux/blk-cgroup.h                 | 199 ++++--------------
 include/linux/blk-mq.h                     | 300 ++++++++++++++++++++++-----
 include/linux/blk_types.h                  |  28 ++-
 include/linux/blkdev.h                     |  16 +-
 include/linux/sbitmap.h                    |   9 -
 include/linux/sed-opal.h                   |   1 +
 include/trace/events/wbt.h                 |  12 +-
 include/uapi/linux/blkzoned.h              |  17 +-
 include/uapi/linux/fcntl.h                 |   9 +-
 include/uapi/linux/sed-opal.h              |  20 ++
 lib/sbitmap.c                              |  17 --
 tools/include/uapi/linux/fcntl.h           |   9 +-
 51 files changed, 1398 insertions(+), 800 deletions(-)
 create mode 100644 block/blk-cgroup-rwstat.c
 create mode 100644 block/blk-cgroup-rwstat.h

-- 
Jens Axboe

