Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBDAC433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 03:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C67B64E25
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 03:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhBADu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jan 2021 22:50:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12056 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhBADu0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jan 2021 22:50:26 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DTYnM4PFJzMSmt;
        Mon,  1 Feb 2021 11:48:07 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 11:49:41 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
Subject: [PATCH v5 0/3] avoid double request completion and IO error
Date:   Mon, 1 Feb 2021 11:49:37 +0800
Message-ID: <20210201034940.18891-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

First, avoid double request completion for nvmf_fail_nonready_command if
the request is freed asynchronously.
Second, avoid IO error. If work with nvme native multipath, rdma HBA
drivers may failed due to failed hardware, queue_rq should failed the
request instead of returning error to block layer, So upper layer can
failover the request if another path is available.
Need set the state of request to MQ_RQ_COMPLETE when queue_rq directly
complete the request. So introduce blk_mq_set_request_complete.

V5:
	- add comment for blk_mq_set_request_complete.
	- fail the request just for -EIO returned by rdma HBA drivers.
	- delete the helper: nvme_complete_failed_req.
V4:
	- add status parameter for nvme_complete_failed_req.
	- export nvme_complete_failed_req instead of inline function.
V3:
	- complete the request just for HBA driver path related error.
V2:
	- use "switch" instead "if" to check return status.

Chao Leng (3):
  blk-mq: introduce blk_mq_set_request_complete
  nvme-fabrics: avoid double request completion for
    nvmf_fail_nonready_command
  nvme-rdma: avoid IO error for nvme native multipath

 drivers/nvme/host/fabrics.c |  2 +-
 drivers/nvme/host/rdma.c    | 13 ++++++++++++-
 include/linux/blk-mq.h      |  9 +++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.16.4

