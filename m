Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FC6C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 02:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67FC2084D
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 02:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeLPCZh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Dec 2018 21:25:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbeLPCZg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Dec 2018 21:25:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C102874F02;
        Sun, 16 Dec 2018 02:25:36 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53C7A1057075;
        Sun, 16 Dec 2018 02:25:27 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/4] blk-mq: queue mapping fix & improvement
Date:   Sun, 16 Dec 2018 10:25:13 +0800
Message-Id: <20181216022517.26650-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 16 Dec 2018 02:25:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch fixes queue mapping when there isn't poll/write queues,
and turns out IO hang can be caused by this bad queue mapping.

The 2nd patch fixes allocation for queue mapping table.

The 3rd patch improves blk_mq_map_swqueue() a bit, and makes it
more robust for dealing with shared queue mapping.

The 4th patch exports hctx->type in debugfs, so that we can write
debugfs based test for verifying if queue mapping is valid.

Ming Lei (4):
  nvme-pci: correct mapping for poll queue(s)
  blk-mq: fix allocation for queue mapping table
  blk-mq: deal with shared queue mapping reliably
  blk-mq-debugfs: export hctx->type

 block/blk-mq-debugfs.c  |  9 +++++++++
 block/blk-mq.c          |  5 ++++-
 drivers/nvme/host/pci.c | 36 ++++++++++++++++++++----------------
 3 files changed, 33 insertions(+), 17 deletions(-)

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>

-- 
2.9.5

