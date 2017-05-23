Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933875AbdEWLru (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 07:47:50 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blk-mq: merge bio into sw queue before plugging
Date: Tue, 23 May 2017 19:47:34 +0800
Message-Id: <20170523114736.12026-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

The 1st patch moves sw queue's bio merge before plugging, then
the sequential I/O performance regression by blk-mq can be fixed.

The 2nd patch makes the sw queue's bio merge as the default .bio_merge
if no io scheduler is used or the io scheduler doesn't provide
.bio_merge.

This post splits the orginal one into two patches to make diff easy-read
as suggested by Christoph.

Thanks,
Ming


Ming Lei (2):
  blk-mq: merge bio into sw queue before plugging
  blk-mq: make per-sw-queue bio merge as default .bio_merge

 block/blk-mq-sched.c | 62 ++++++++++++++++++++++++++++++++++++----
 block/blk-mq-sched.h |  4 +--
 block/blk-mq.c       | 80 +++++++---------------------------------------------
 3 files changed, 68 insertions(+), 78 deletions(-)

-- 
2.9.4
