Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE637C433F5
	for <linux-block@archiver.kernel.org>; Thu,  3 Feb 2022 19:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353764AbiBCT26 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:28:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353766AbiBCT25 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Feb 2022 14:28:57 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213I6TZL007248
        for <linux-block@vger.kernel.org>; Thu, 3 Feb 2022 11:28:57 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e058jwnhc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 03 Feb 2022 11:28:57 -0800
Received: from twshared6457.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 11:28:56 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 9D9CF29525AA5; Thu,  3 Feb 2022 11:28:48 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC:     <kernel-team@fb.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <axboe@kernel.dk>, <hare@suse.de>,
        Song Liu <song@kernel.org>
Subject: [PATCH v2 2/3] block: return -ENODEV for BLK_STS_OFFLINE
Date:   Thu, 3 Feb 2022 11:28:26 -0800
Message-ID: <20220203192827.1370270-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203192827.1370270-1-song@kernel.org>
References: <20220203192827.1370270-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: sSCIaaDSW500gX-NS5MAEZ7PHuwyiFc4
X-Proofpoint-ORIG-GUID: sSCIaaDSW500gX-NS5MAEZ7PHuwyiFc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change the user visible return value for BLK_STS_OFFLINE to -ENODEV, which
is more descriptive than existing -EIO.

Signed-off-by: Song Liu <song@kernel.org>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 24035dd2eef1..be8812f5489d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -164,7 +164,7 @@ static const struct {
 	[BLK_STS_RESOURCE]	= { -ENOMEM,	"kernel resource" },
 	[BLK_STS_DEV_RESOURCE]	= { -EBUSY,	"device resource" },
 	[BLK_STS_AGAIN]		= { -EAGAIN,	"nonblocking retry" },
-	[BLK_STS_OFFLINE]	= { -EIO,	"device offline" },
+	[BLK_STS_OFFLINE]	= { -ENODEV,	"device offline" },
 
 	/* device mapper special case, should not leak out: */
 	[BLK_STS_DM_REQUEUE]	= { -EREMCHG, "dm internal retry" },
-- 
2.30.2

