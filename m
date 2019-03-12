Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFC9C43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89030214D8
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bhYCaF6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfCLB20 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:28:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45526 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCLB20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 21:28:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2C1Il7b112673;
        Tue, 12 Mar 2019 01:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=yIB9yhUCdYLlG2cu/5oLydhDJhQQiZBh7E+wH+Xz4s4=;
 b=bhYCaF6y7zsFjQfrRAKUUSSF3oCAI8vOmvjIWLX1ltBPUX2PqOnXD9xVs/4txoA9zahH
 zgxD6ioDr03o9Eu41kSkvJlu0iyMGL2E1fhKX28vJeNWAJWsUbn9AUrIkHPnAHZqyve5
 rYp6eYFbWkMnXnWucpQY02MYTyzzHCAWYXtYMdbNYTBLHKg9TolokJawGQ+ikZWf3wG5
 GWJg0MOuijfUfxJESQ0FxSxMPa1AGuStA3bJEGz149zHeZZR0Li49h3PVJ/jJe20oemv
 7+LDy55IgXtFZ84ZRghRMk5dyRgnSUdySl3Ywp0+03VuJkRZZO5wN/3EpbTDXEXn5G// AA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2r44wu1qu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 01:28:22 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2C1SKlc005723
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 01:28:21 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2C1SKGe022767;
        Tue, 12 Mar 2019 01:28:20 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 18:28:19 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk
Subject: [PATCH 1/1] virtio_blk: replace 0 by HCTX_TYPE_DEFAULT to index blk_mq_tag_set->map
Date:   Tue, 12 Mar 2019 09:31:56 +0800
Message-Id: <1552354316-20204-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=761 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120007
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use HCTX_TYPE_DEFAULT instead of 0 to avoid hardcoding.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
This is the only place to cleanup under drivers/block/*. Another patch set
is sent to scsi and then all of below are cleaned up:
- block/*
- drivers/*

 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4bc083b..bed6035 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -691,7 +691,8 @@ static int virtblk_map_queues(struct blk_mq_tag_set *set)
 {
 	struct virtio_blk *vblk = set->driver_data;
 
-	return blk_mq_virtio_map_queues(&set->map[0], vblk->vdev, 0);
+	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
+					vblk->vdev, 0);
 }
 
 #ifdef CONFIG_VIRTIO_BLK_SCSI
-- 
2.7.4

