Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50136C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 03:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF7F20857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 03:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfCRDaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:30:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfCRDaD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 23:30:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DACAE3086208;
        Mon, 18 Mar 2019 03:30:02 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FE66600C7;
        Mon, 18 Mar 2019 03:29:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] blk-mq/nvme: cancel request synchronously
Date:   Mon, 18 Mar 2019 11:29:48 +0800
Message-Id: <20190318032950.17770-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 18 Mar 2019 03:30:03 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patchset introduces blk_mq_complete_request_sync() for canceling
request synchronously in error handler context, then one race between
completing request and destroying contoller/queues can be fixed.


Ming Lei (2):
  blk-mq: introduce blk_mq_complete_request_sync()
  nvme: cancel request synchronously

 block/blk-mq.c           | 20 ++++++++++++++++----
 drivers/nvme/host/core.c |  2 +-
 include/linux/blk-mq.h   |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org

-- 
2.9.5

