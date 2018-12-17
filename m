Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F21AC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471D72145D
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeLQMIy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:08:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbeLQMIy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 07:08:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C2F6C04DBEE;
        Mon, 17 Dec 2018 12:08:54 +0000 (UTC)
Received: from localhost (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C593F5E7DD;
        Mon, 17 Dec 2018 12:08:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V3 0/4] blk-mq: queue mapping fix & improvement
Date:   Mon, 17 Dec 2018 20:08:41 +0800
Message-Id: <20181217120844.8131-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 17 Dec 2018 12:08:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch fixes allocation for queue mapping table.

The 2nd patch exports hctx->type in debugfs, so that we can write
debugfs based test for verifying if queue mapping is valid.

The 3rd patch fixes dispatch from sw queue when there is either
write queue or poll queue.


V3:
	- drop the original 2nd patch, which can be done by hch's two
	patches
	- add changelog on patch3

V2:
	- remove hctx->type export from sysfs
	- take hch's patch to fix shared queue mapping
	- add the patch 3

Ming Lei (3):
  blk-mq: fix allocation for queue mapping table
  blk-mq: export hctx->type in debugfs instead of sysfs
  blk-mq: fix dispatch from sw queue

 block/blk-mq-debugfs.c | 85 ++++++++++++++++++++++++++++++++------------------
 block/blk-mq-sched.c   | 23 +++++++++-----
 block/blk-mq-sysfs.c   | 17 ----------
 block/blk-mq.c         | 54 +++++++++++++++++++-------------
 block/blk-mq.h         | 10 +++---
 5 files changed, 108 insertions(+), 81 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>

-- 
2.9.5

