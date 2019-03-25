Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73122C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CBC20879
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 05:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DA2ifDZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfCYFrq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:47:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57802 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCYFrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 01:47:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P5iMEW004246;
        Mon, 25 Mar 2019 05:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ss1t3DJAWRqtk33Piyd+aeKtdRJeAop5F6RCCUL08C8=;
 b=DA2ifDZNV8rFkr9Zy5rlLdWnEfOUnqCRCXzXy0bz7tmZChch6/Dvgi0Z4hcB2LCV/+y5
 sXT7eZWe+JTd7J75sCy+q5xPpyNlLylzPszfJjpNGOzQYDWjEWbdGIWf7SDQAydBK0MG
 s3Xmbm6geuNRm0zIHY1sGPksKdKy1rTLwqOfMBYrzmUPE0+ZKP5ed9tq40u1TtDiJpzc
 qQTtiW1HiBwuWawpf4LhChaMUzyu24tIX1x5DCYgVWxa6Tc+w027ZpAHH02I8y0VmvZo
 ucVKSlWbFFqo4gxsBptYOR3tkVx3Xwyf8luwCPC9sdk3yK//z5BpT/T7VYqb4rFQwG8G PQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2re6g0ht0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:47:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5lJ45012747
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:47:20 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5lJ2u031755;
        Mon, 25 Mar 2019 05:47:19 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Mar 2019 22:47:18 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/8] skd: use blk_mq_queue_tag_inflight_iter
Date:   Mon, 25 Mar 2019 13:38:36 +0800
Message-Id: <1553492318-1810-7-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250044
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/block/skd_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 7d3ad6c..0213b19 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -395,7 +395,7 @@ static int skd_in_flight(struct skd_device *skdev)
 {
 	int count = 0;
 
-	blk_mq_tagset_busy_iter(&skdev->tag_set, skd_inc_in_flight, &count);
+	blk_mq_queue_tag_inflight_iter(skdev->queue, skd_inc_in_flight, &count);
 
 	return count;
 }
@@ -1916,7 +1916,7 @@ static bool skd_recover_request(struct request *req, void *data, bool reserved)
 
 static void skd_recover_requests(struct skd_device *skdev)
 {
-	blk_mq_tagset_busy_iter(&skdev->tag_set, skd_recover_request, skdev);
+	blk_mq_queue_tag_inflight_iter(skdev->queue, skd_recover_request, skdev);
 }
 
 static void skd_isr_msg_from_dev(struct skd_device *skdev)
-- 
2.7.4

