Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3BCC4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Feb 2022 19:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353768AbiBCT3C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:29:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11612 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353775AbiBCT3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Feb 2022 14:29:01 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213I6VOB020537
        for <linux-block@vger.kernel.org>; Thu, 3 Feb 2022 11:29:01 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e08t14sqx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 03 Feb 2022 11:29:01 -0800
Received: from twshared11487.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 11:28:59 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6232F29525A9F; Thu,  3 Feb 2022 11:28:46 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC:     <kernel-team@fb.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <axboe@kernel.dk>, <hare@suse.de>,
        Song Liu <song@kernel.org>
Subject: [PATCH v2 0/3] block: scsi: introduce and use BLK_STS_OFFLINE
Date:   Thu, 3 Feb 2022 11:28:24 -0800
Message-ID: <20220203192827.1370270-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SXgH5UoImgOxg867CdeocG1_A6OQLOGf
X-Proofpoint-ORIG-GUID: SXgH5UoImgOxg867CdeocG1_A6OQLOGf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=587
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes v1 => v2:
1. Add patch 2/3 to change user visible return value to -ENODEV. (Hannes)
2. In the commit log, explain the reason to keep EIO in 1/3.

We have a use case where HDDs are regularly power on/off to perserve power.
When a drive is being removed, we often see errors like

   [  172.803279] I/O error, dev sda, sector 3137184

These messages are confusing for automations that grep dmesg, as they look
very similar to real HDD error.

Solve this issue with a new block state BLK_STS_OFFLINE. After the change,
the error message looks like

   [  172.803279] device offline error, dev sda, sector 3137184

so that the automations won't confuse them with real I/O error.

Song Liu (3):
  block: introduce BLK_STS_OFFLINE
  block: return -ENODEV for BLK_STS_OFFLINE
  scsi: use BLK_STS_OFFLINE for not fully online devices

 block/blk-core.c          | 1 +
 drivers/scsi/scsi_lib.c   | 2 +-
 include/linux/blk_types.h | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

--
2.30.2
