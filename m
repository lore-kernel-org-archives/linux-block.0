Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24281C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 10:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF44220874
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 10:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbeLQKm6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:42:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeLQKm6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 05:42:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25D7489AD5;
        Mon, 17 Dec 2018 10:42:58 +0000 (UTC)
Received: from localhost (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 305331001F58;
        Mon, 17 Dec 2018 10:42:54 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/4] blk-mq: queue mapping fix & improvement
Date:   Mon, 17 Dec 2018 18:42:44 +0800
Message-Id: <20181217104248.5828-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 17 Dec 2018 10:42:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch fixes allocation for queue mapping table.

The 2nd patch fixes shared queue mapping, which may cause IO
hang in case that both write_queues and poll_queues are zero.

The 3rd patch fixes dispatch from sw queue when there is either
write queue or poll queue.

The 4th patch exports hctx->type in debugfs, so that we can write
debugfs based test for verifying if queue mapping is valid.


V2:
	- remove hctx->type export from sysfs
	- take hch's patch to fix shared queue mapping
	- add the patch 3

Christoph Hellwig (1):
  blk-mq: fix shared queue mapping

Ming Lei (3):
  blk-mq: fix allocation for queue mapping table
  blk-mq: fix dispatch from sw queue
  blk-mq: export hctx->type in debugfs instead of sysfs

 block/blk-mq-debugfs.c  | 85 ++++++++++++++++++++++++++++++++-----------------
 block/blk-mq-sched.c    | 23 ++++++++-----
 block/blk-mq-sysfs.c    | 17 ----------
 block/blk-mq.c          | 57 ++++++++++++++++++++-------------
 block/blk-mq.h          | 21 +++++++-----
 drivers/nvme/host/pci.c |  6 +---
 6 files changed, 119 insertions(+), 90 deletions(-)

-- 
2.9.5

