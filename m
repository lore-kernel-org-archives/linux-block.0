Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E61C282E5
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 12:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF8B2184B
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 12:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfDWM37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:29:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:37888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727673AbfDWM37 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 08:29:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5AD1ADE6;
        Tue, 23 Apr 2019 12:29:57 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/5] blk-mq: fixes for Ming Leis V6 patchset
Date:   Tue, 23 Apr 2019 14:29:46 +0200
Message-Id: <20190423122951.134531-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

to clarify my comments to your patch to introduce dead_hctx_list here's
a small patchset to address my concerns.
If you agree it would possibly be best to fold it into your patchset.

Patches are relative to the 'nvme-5.2' branch of the nvme git repository
plus the 'V6' iteration of Mings patchset
'blk-mq: fix races related with freeing queue'.

Hannes Reinecke (5):
  blk-mq: rename 'dead_hctx_XX' to 'unused_hctx_XX'
  blk-mq: drop 'hctx_idx' argument from blk_mq_alloc_hctx()
  blk-mq: remove 'nr_queue' argument in blk_mq_exit_hw_queues()
  blk-mq: Set hctx pointer to NULL in blk_mq_exit_hw_queues()
  blk-mq: free q->queue_hw_ctx in blk_mq_exit_queue()

 block/blk-mq.c         | 45 +++++++++++++++++++++++++--------------------
 block/blk-mq.h         |  2 +-
 include/linux/blkdev.h |  6 +++---
 3 files changed, 29 insertions(+), 24 deletions(-)

-- 
2.16.4

