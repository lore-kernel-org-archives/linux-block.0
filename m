Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F5DC433DF
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B935620679
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgFAMjZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:39:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5321 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbgFAMjY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jun 2020 08:39:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7252BF6B52CED81A3185;
        Mon,  1 Jun 2020 20:39:22 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 1 Jun 2020
 20:39:14 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <martin.petersen@oracle.com>, <wenwen@cs.uga.edu>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] block/bio-integrity: don't free 'buf' if bio_integrity_add_page() failed
Date:   Mon, 1 Jun 2020 20:38:56 +0800
Message-ID: <20200601123856.3895734-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug") add a
kree() for 'buf' if bio_integrity_add_page() return '0'. However, the
object will be freed in bio_integrity_free() since 'bio->bi_opf' and
'bio->bi_integrity' was set previousy in bio_integrity_alloc().

Fixes: commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 block/bio-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bf62c25cde8f..ae07dd78e951 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -278,7 +278,6 @@ bool bio_integrity_prep(struct bio *bio)
 
 		if (ret == 0) {
 			printk(KERN_ERR "could not attach integrity payload\n");
-			kfree(buf);
 			status = BLK_STS_RESOURCE;
 			goto err_end_io;
 		}
-- 
2.25.4

