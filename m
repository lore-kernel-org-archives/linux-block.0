Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F9BC11D30
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 17:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1D020732
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 17:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I3d6TvBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBXRdG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:33:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55462 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgBXRdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 12:33:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OHWg1p058602;
        Mon, 24 Feb 2020 17:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=4x/bqQGcinOCm0Ul+wV171TuixMlWNFvth9yFHdF33E=;
 b=I3d6TvBOxMWD80X4TPULflHUoNCghWHCIKmALcPilGlGcGQsyPWTslFJvjSBnrCj0Wyt
 7ldnrPY9Qvl8vYfN+QifCqkiD9H2A1UpX90fSgQspH0XQ3Mf/Zsk8I1otrIwM79AMjS9
 i6biZeEOvTIGb5M9SHcGK2sg0kVCKlDsGihRt/Sz07rPxC/lTaVCStMcbXxkZNP7jaVM
 pnDoxIaGgYSP2LWUjHWOq3bxkpPhf4vZmJthjcqJVohcN0neaSGtehdc1ycrS+PAL/t9
 fbYEho40LPicQv9TYBD1pphc43zN8/7/xXTaMl87fapA6f6WRK6LJsDcAB/F/kGGqlUg Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yavxrguj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 17:33:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OHScG7046922;
        Mon, 24 Feb 2020 17:33:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ybdsh7r6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 17:33:04 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OHX1Ab014302;
        Mon, 24 Feb 2020 17:33:03 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 09:33:01 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] null_blk: remove unused 'll_list' in 'nullb_cmd'
Date:   Mon, 24 Feb 2020 09:24:51 -0800
Message-Id: <20200224172451.21320-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=1 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=989 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240131
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 'll_list' is no longer used since commit 3c395a969acc ("null_blk: set a
separate timer for each command").

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/block/null_blk.h      | 1 -
 drivers/block/null_blk_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index bc837862b767..34fec8814bf1 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -15,7 +15,6 @@
 
 struct nullb_cmd {
 	struct list_head list;
-	struct llist_node ll_list;
 	struct __call_single_data csd;
 	struct request *rq;
 	struct bio *bio;
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 16510795e377..07301c72b102 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1519,7 +1519,6 @@ static int setup_commands(struct nullb_queue *nq)
 	for (i = 0; i < nq->queue_depth; i++) {
 		cmd = &nq->cmds[i];
 		INIT_LIST_HEAD(&cmd->list);
-		cmd->ll_list.next = NULL;
 		cmd->tag = -1U;
 	}
 
-- 
2.17.1

