Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757814AbdLRHky (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Dec 2017 02:40:54 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neilb@suse.com>,
        Michele Ballabio <barra_cuda@katamail.com>,
        Vincent Batts <vbatts@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] block: fix two regressiones on bounce
Date: Mon, 18 Dec 2017 15:40:42 +0800
Message-Id: <20171218074044.1369-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

The 1st patch makes sure that passthrough IO won't enter .make_request_fn.

The 2nd one fixes blk_rq_append_bio(), which is from your post with
small change on failure handling.


Jens Axboe (1):
  block: fix blk_rq_append_bio

Ming Lei (1):
  block: don't let passthrough IO go into .make_request_fn()

 block/blk-map.c                    | 38 ++++++++++++++++++++++----------------
 block/bounce.c                     |  6 ++++--
 drivers/scsi/osd/osd_initiator.c   |  4 +++-
 drivers/target/target_core_pscsi.c |  4 ++--
 include/linux/blkdev.h             | 23 ++++++++++++++++++++---
 5 files changed, 51 insertions(+), 24 deletions(-)

-- 
2.9.5
