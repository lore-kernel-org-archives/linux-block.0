Return-Path: <SRS0=AgPR=5H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F2CC54EEB
	for <linux-block@archiver.kernel.org>; Sun, 22 Mar 2020 09:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FD420753
	for <linux-block@archiver.kernel.org>; Sun, 22 Mar 2020 09:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gjmiSoZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgCVJaB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Mar 2020 05:30:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgCVJaB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Mar 2020 05:30:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02M9OcCX024473;
        Sun, 22 Mar 2020 09:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=eKfa3IdaCFFbAJ15qxfyTOoyMh8TmQPDYyEctN+Wptk=;
 b=gjmiSoZpCgsDQkNWcHI74TiI43MMrT2ACzIKf9oYCnczP4G9rEoUNmZahOiTzmd7aZ7i
 O9sJC1xnXuJaFfMp7QWqGJ8r+Fg+L5xwm2t5YCG036HbcyUMET8yFD8gmI4A3PGWjutd
 qpmk+XiI06el3FGn5VWYekrknacz52grncquq4V4gxokVE+qokpzPPQ2IrCPAvZha5fP
 gNW1szCQgeXUKPJuIJLqim5gq/yfP/zh/JyBCOXt9pYQcQOayR33HPC2I75yQGqQcdUf
 ocmnIi3XpJz1YPVqB9RewpmSVB1voe0sGBegdcP2GoIczkbdDePJcAAbkZbrk0Zyx/dc Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2ywbjmtmpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Mar 2020 09:29:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02M9NHNc031658;
        Sun, 22 Mar 2020 09:29:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ywwug7k85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Mar 2020 09:29:56 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02M9TtdP027561;
        Sun, 22 Mar 2020 09:29:55 GMT
Received: from localhost.localdomain (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 22 Mar 2020 02:29:54 -0700
From:   Bob Liu <bob.liu@oracle.com>
To:     dm-devel@redhat.com
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        Dmitry.Fomichev@wdc.com, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH] dm zoned: remove duplicated nr_rnd_zones increasement
Date:   Sun, 22 Mar 2020 17:29:12 +0800
Message-Id: <20200322092912.23148-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9567 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=1 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003220055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9567 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=1 impostorscore=0
 clxscore=1011 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003220055
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

zmd->nr_rnd_zones was increased twice by mistake.
The other place:
1131                 zmd->nr_useable_zones++;
1132                 if (dmz_is_rnd(zone)) {
1133                         zmd->nr_rnd_zones++;
					^^^

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 drivers/md/dm-zoned-metadata.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 516c7b6..369de15 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1109,7 +1109,6 @@ static int dmz_init_zone(struct blk_zone *blkz, unsigned int idx, void *data)
 	switch (blkz->type) {
 	case BLK_ZONE_TYPE_CONVENTIONAL:
 		set_bit(DMZ_RND, &zone->flags);
-		zmd->nr_rnd_zones++;
 		break;
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
-- 
2.9.5

