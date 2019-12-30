Return-Path: <SRS0=HKcR=2U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD4DC2D0C2
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 12:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6386C20730
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 12:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfL3MRv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Dec 2019 07:17:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727376AbfL3MRv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Dec 2019 07:17:51 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B5710449A74B5DD08040;
        Mon, 30 Dec 2019 20:17:48 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 30 Dec 2019
 20:17:42 +0800
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <jens.axboe@oracle.com>, <namhyung@gmail.com>,
        <bharrosh@panasas.com>, renxudong <renxudong1@huawei.com>
CC:     Mingfangsen <mingfangsen@huawei.com>, <zhengbin13@huawei.com>,
        Guiyao <guiyao@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] blk-map: add kernel address validation in blk_rq_map_kern
 func
Message-ID: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
Date:   Mon, 30 Dec 2019 20:17:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: renxudong <renxudong1@huawei.com>

Blk_rq_map_kern func is used to map kernel data to a request,
in which kbuf par should be a valid kernel buffer. However,
kbuf par is only checked whether it is null in blk_rq_map_kern func.

If users pass a non kernel address to blk_rq_map_kern func in the
non-aligned scenario, the invalid kbuf will be set to bio->bi_private.
When the request is completed, bio_copy_kern_endio_read will be called
to copy data to the kernel address in bio->bi_private. If the bi_private
is not a valid kernel address, the system will oops. In this case, we
cannot judge whether the bio structure is damaged or the kernel address is
invalid.

Here, we add kernel address validation by calling virt_addr_valid.

Signed-off-by: renxudong <renxudong1@huawei.com>
Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 block/blk-map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 3a62e471d81b..7deb1b44d1e3 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -229,7 +229,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,

 	if (len > (queue_max_hw_sectors(q) << 9))
 		return -EINVAL;
-	if (!len || !kbuf)
+	if (!len || !virt_addr_valid(kbuf))
 		return -EINVAL;

 	do_copy = !blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf);
-- 
2.24.0.windows.2

