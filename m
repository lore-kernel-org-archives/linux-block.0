Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B462C433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 07:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B7E2396D
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 07:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbhAUHFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 02:05:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11844 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbhAUHEZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 02:04:25 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DLtcc6MzHz7VJ9;
        Thu, 21 Jan 2021 15:02:24 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 15:03:30 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
Subject: [PATCH v3 0/5] avoid double request completion and IO error
Date:   Thu, 21 Jan 2021 15:03:25 +0800
Message-ID: <20210121070330.19701-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add blk_mq_set_request_complete and nvme_complete_failed_req for two bug
fixs.
First avoid double request completion for nvmf_fail_nonready_command.
Second avoid IO error for nvme native multipath.

V3:
	- complete the request just for HBA driver path related error.
V2:
	- use "switch" instead "if" to check return status.

Chao Leng (5):
  blk-mq: introduce blk_mq_set_request_complete
  nvme-core: introduce complete failed request
  nvme-fabrics: avoid double request completion for
    nvmf_fail_nonready_command
  nvme-rdma: avoid IO error for nvme native multipath
  nvme-fc: avoid IO error for nvme native multipath

 drivers/nvme/host/fabrics.c | 4 +---
 drivers/nvme/host/fc.c      | 7 ++++++-
 drivers/nvme/host/nvme.h    | 8 ++++++++
 drivers/nvme/host/rdma.c    | 9 ++++++++-
 include/linux/blk-mq.h      | 5 +++++
 5 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.16.4

