Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E4DC433EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 09:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D083761051
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 09:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhKAJP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 05:15:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25332 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhKAJPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 05:15:25 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HjRyb5T44zbcwY;
        Mon,  1 Nov 2021 17:08:07 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 17:12:50 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 17:12:49 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] nbd: error out if socket index doesn't match in nbd_handle_reply()
Date:   Mon, 1 Nov 2021 17:25:38 +0800
Message-ID: <20211101092538.1155842-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

commit fcf3d633d8e1 ("nbd: check sock index in nbd_read_stat()") just
add error message when socket index doesn't match. Since the request
and reply must be transmitted over the same socket, it's ok to error
out in such situation.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b47b2a87ae8f..18da6385645c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -755,6 +755,8 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 	if (cmd->index != index) {
 		dev_err(disk_to_dev(nbd->disk), "Unexpected reply %d from different sock %d (expected %d)",
 			tag, index, cmd->index);
+		ret = -ENOENT;
+		goto out;
 	}
 	if (cmd->cmd_cookie != nbd_handle_to_cookie(handle)) {
 		dev_err(disk_to_dev(nbd->disk), "Double reply on req %p, cmd_cookie %u, handle cookie %u\n",
-- 
2.31.1

