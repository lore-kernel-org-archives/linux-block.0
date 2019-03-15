Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FEFC43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07C2218CD
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 09:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DWsW8a2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfCOJHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:07:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44864 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbfCOJGv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 05:06:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2F8xIY1057463;
        Fri, 15 Mar 2019 09:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=fbPDd3Ab9z/qNbAoNclCyGS1HDGYOqc/WGMQxm0WqUo=;
 b=DWsW8a2mddlAgjY2fyj3TUc36Qu7ijpHf+mKUTjhARmB2THE+yf8oI+EtwDoKByd1PVU
 DZRX4+krJpazXOwER9ZrQULT9KOGlRTjxPWrUeVHIh0lQpOuPKnO8Aocg1GELtI4oWdT
 5ZkHB4DD8LniFgggCbN19wb+fIiw6dASO9+L09ZT3sUF2MWoplYwVsxOCf3WVwga0/Th
 3qn8QUiUHTOYkbjChGFmTImHkWCVDhC2l3hMz054HyQnyInW0NF6BKwKffXabUuJcNco
 V7H550l/M32a8mfmbXZbAnxObQ1V16mE0ZOnYZCLXGdNdxMPj7IKsNrH7Hik4jO4ETV/ 6w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2r430f61j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:19 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96ISZ007932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 09:06:19 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2F96IBg017585;
        Fri, 15 Mar 2019 09:06:18 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 09:06:18 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] blk-mq: use blk_mq_queue_tag_busy_iter in debugfs
Date:   Fri, 15 Mar 2019 16:57:39 +0800
Message-Id: <1552640264-26101-4-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9195 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=964 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150067
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7921573..7c4e771 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -442,8 +442,8 @@ static int hctx_busy_show(void *data, struct seq_file *m)
 	struct blk_mq_hw_ctx *hctx = data;
 	struct show_busy_params params = { .m = m, .hctx = hctx };
 
-	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
-				&params);
+	blk_mq_queue_tag_busy_iter(hctx->queue, hctx_show_busy_rq,
+				&params, true);
 
 	return 0;
 }
-- 
2.7.4

