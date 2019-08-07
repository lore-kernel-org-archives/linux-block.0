Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BAEC32751
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 13:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4522621E6B
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 13:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbfHGNTW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:19:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387970AbfHGNTW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Aug 2019 09:19:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4E29BCB498AC983FF2B8;
        Wed,  7 Aug 2019 21:19:20 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 7 Aug 2019
 21:19:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mb@lightnvm.io>, <hans@owltronix.com>, <hch@lst.de>,
        <axboe@kernel.dk>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] lightnvm: remove set but not used variables 'data_len' and 'rq_len'
Date:   Wed, 7 Aug 2019 21:18:47 +0800
Message-ID: <20190807131847.62412-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

drivers/lightnvm/pblk-read.c: In function pblk_submit_read_gc:
drivers/lightnvm/pblk-read.c:423:6: warning: variable data_len set but not used [-Wunused-but-set-variable]
drivers/lightnvm/pblk-recovery.c: In function pblk_recov_scan_oob:
drivers/lightnvm/pblk-recovery.c:368:15: warning: variable rq_len set but not used [-Wunused-but-set-variable]

They are not used since commit 48e5da725581 ("lightnvm:
move metadata mapping to lower level driver")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/lightnvm/pblk-read.c     | 2 --
 drivers/lightnvm/pblk-recovery.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index d572d45..0cdc48f 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -420,7 +420,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct nvm_rq rqd;
-	int data_len;
 	int ret = NVM_IO_OK;
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
@@ -445,7 +444,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
 	if (!(gc_rq->secs_to_gc))
 		goto out;
 
-	data_len = (gc_rq->secs_to_gc) * geo->csecs;
 	rqd.opcode = NVM_OP_PREAD;
 	rqd.nr_ppas = gc_rq->secs_to_gc;
 
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index d5e210c..299ef47 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -365,7 +365,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	__le64 *lba_list;
 	u64 paddr = pblk_line_smeta_start(pblk, line) + lm->smeta_sec;
 	bool padded = false;
-	int rq_ppas, rq_len;
+	int rq_ppas;
 	int i, j;
 	int ret;
 	u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
@@ -388,7 +388,6 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
 	if (!rq_ppas)
 		rq_ppas = pblk->min_write_pgs;
-	rq_len = rq_ppas * geo->csecs;
 
 retry_rq:
 	rqd->bio = NULL;
-- 
2.7.4


