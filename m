Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64CDC433ED
	for <linux-block@archiver.kernel.org>; Sat, 15 May 2021 03:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEA1613D2
	for <linux-block@archiver.kernel.org>; Sat, 15 May 2021 03:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhEODkr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 23:40:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2987 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEODkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 23:40:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FhrgM1jXVzldmC;
        Sat, 15 May 2021 11:37:19 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 11:39:26 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Matias Bjorling <mb@lightnvm.io>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        linux-block <linux-block@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] lightnvm: pblk: Fix error return code in pblk_recov_pad_lineq()
Date:   Sat, 15 May 2021 11:38:44 +0800
Message-ID: <20210515033844.6930-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix to return -EFAULT from the error handling case instead of 0, as done
elsewhere in this function.

Fixes: ee8d5c1ad54e ("lightnvm: pblk: remove target using async. I/Os")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/lightnvm/pblk-recovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 0e6f0c76e93027a..0772bd46bf61495 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -207,6 +207,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
 next_pad_rq:
 	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	if (rq_ppas < pblk->min_write_pgs) {
+		ret = -EFAULT;
 		pblk_err(pblk, "corrupted pad line %d\n", line->id);
 		goto fail_complete;
 	}
-- 
2.26.0.106.g9fadedd


