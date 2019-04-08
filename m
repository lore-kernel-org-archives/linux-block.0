Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991F8C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 22:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656BF213F2
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 22:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDHWbe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:31:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfDHWbe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 18:31:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71F2D30821FF;
        Mon,  8 Apr 2019 22:31:34 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15D211001E69;
        Mon,  8 Apr 2019 22:31:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: [PATCH V4 0/2] blk-mq/nvme: cancel request synchronously
Date:   Tue,  9 Apr 2019 06:31:20 +0800
Message-Id: <20190408223122.29844-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 08 Apr 2019 22:31:34 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patchset introduces blk_mq_complete_request_sync() for canceling
request synchronously in error handler context, then one race between
completing request remotely and destroying contoller/queues can be fixed.


V4:
	- drop return value
	- don't handle fake timeout

V3:
	- avoid extra cost to blk_mq_complete_request

V2:
	- export via EXPORT_SYMBOL_GPL
	- minor commit log change

Ming Lei (2):
  blk-mq: introduce blk_mq_complete_request_sync()
  nvme: cancel request synchronously

 block/blk-mq.c           | 7 +++++++
 drivers/nvme/host/core.c | 2 +-
 include/linux/blk-mq.h   | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: James Smart <james.smart@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org


-- 
2.9.5

