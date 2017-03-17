Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36720 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdCQWL4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2017 18:11:56 -0400
Received: by mail-pf0-f172.google.com with SMTP id o126so42932602pfb.3
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2017 15:11:56 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [RFC PATCH 0/4] blk-mq: multiqueue I/O scheduler
Date: Fri, 17 Mar 2017 15:03:29 -0700
Message-Id: <cover.1489787289.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This patch series implements an I/O scheduler for multiqueue devices
combining several techniques: the scalable bitmap library, the new
blk-stats API, and queue depth throttling similar to blk-wbt.

These patches are on top of my earlier blk-stats series [1]. They also
need a fix in Jens' for-linus branch in order to work properly [2].

Patches 1 and 2 implement a new sbitmap operation and patch 3 exports a
required function. Patch 4 implements the new scheduler, named Kyber.

The commit message in patch 4 describes Kyber in detail. The scheduler
employs some heuristics that I've experimented with, but that's probably
the area that needs the most work. I'll be at LSF/MM next week, and
there's currently a lightning talk on the schedule to discuss
improvements and extensions.

A quick test case that demonstrates the scheduler in action:

---
[global]
filename=/dev/nvme0n1
direct=1
runtime=10s
time_based
group_reporting

[writers]
numjobs=40
ioengine=libaio
iodepth=1024
rw=randwrite

[reader]
new_group
rate_iops=1000
ioengine=sync
rw=randread
---

With Kyber set to a target latency of 1 ms, the reader sees latencies of 8 ms
on average. Kyber brings this down to just over 1 ms.

Thanks!

1: http://marc.info/?l=linux-block&m=148952547205774&w=2
2: http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=efd4b81abbe1ac753717f2f10cd3dab8bed6c103

Omar Sandoval (4):
  sbitmap: add sbitmap_get_shallow() operation
  blk-mq: add shallow depth option for blk_mq_get_tag()
  blk-mq: export blk_mq_finish_request()
  blk-mq: introduce Kyber multiqueue I/O scheduler

 block/Kconfig.iosched   |   8 +
 block/Makefile          |   1 +
 block/blk-mq-tag.c      |   5 +-
 block/blk-mq.c          |   1 +
 block/blk-mq.h          |   1 +
 block/elevator.c        |   9 +-
 block/kyber-iosched.c   | 586 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sbitmap.h |  55 +++++
 lib/sbitmap.c           |  75 ++++++-
 9 files changed, 729 insertions(+), 12 deletions(-)
 create mode 100644 block/kyber-iosched.c

-- 
2.12.0
