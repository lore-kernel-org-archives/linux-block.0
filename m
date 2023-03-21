Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC319C6FD20
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 21:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCUVuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 17:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCUVue (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 17:50:34 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323E32E54
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 14:50:33 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LIOFLU005652
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 14:50:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=mjZsaOpwR1GRuAdQwudtlE6kfNLVwybwZDHdfenMzgQ=;
 b=Xhstcz/ABMZzSnG5usdqCTZQ1Cno1yyZzWab4ENBgQ94IhOo8q773Pm2XHHoaApp3mtW
 bf99xOevnFCloIY6H0RchFwmW3+PNsf4zXZVZhZDp+E5Au3ceka+c9QFI5Vn2sCn0kG/
 LGa9jog7UMNJHF3AxysZoeWhMQprymjdp1oTSHUMb6hRDYtV+6/svY8ObbqHx2Mls3KE
 Q8Bu7Quc+vsT+9FKxUK5b9WewT+oOdh1esK37CRmpRCap+e9oKeL/vRiAMyKqLuONmID
 kS0ewr2rh2i56qEovRIW1Emm4q578/DEyMAavXakty+uRlndIWxB+tjXurRClZCoeIG0 zw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pfdx9uba4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 14:50:33 -0700
Received: from twshared7147.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Mar 2023 14:50:08 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 9C2DC141735C0; Tue, 21 Mar 2023 14:50:02 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] blk-mq: fix forward declaration for rdma mapping
Date:   Tue, 21 Mar 2023 14:50:01 -0700
Message-ID: <20230321215001.2655451-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3_Wzra8ujGOm0pEn5ZO96RWrjnmc-L0W
X-Proofpoint-ORIG-GUID: 3_Wzra8ujGOm0pEn5ZO96RWrjnmc-L0W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

blk_mq_rdma_map_queues() used to take a 'blk_mq_tag_set *' parameter,
but was changed to 'blk_mq_queue_map *'. The forward declaration needs
to be updated so .c files won't have to include headers in a specific
order.

Fixes: e42b3867de4bd5e ("blk-mq-rdma: pass in queue map to blk_mq_rdma_ma=
p_queues")
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq-rdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk-mq-rdma.h b/include/linux/blk-mq-rdma.h
index 53b58c610e767..d7ead42f1c6ad 100644
--- a/include/linux/blk-mq-rdma.h
+++ b/include/linux/blk-mq-rdma.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_BLK_MQ_RDMA_H
 #define _LINUX_BLK_MQ_RDMA_H
=20
-struct blk_mq_tag_set;
+struct blk_mq_queue_map;
 struct ib_device;
=20
 void blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
--=20
2.34.1

