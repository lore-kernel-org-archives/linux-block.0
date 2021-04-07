Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AC3C433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 18:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154C66124C
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 18:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355067AbhDGSDX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 14:03:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62754 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232163AbhDGSDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Apr 2021 14:03:22 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137HtIBq030161
        for <linux-block@vger.kernel.org>; Wed, 7 Apr 2021 11:03:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=1CcQ9x5X2Jkfw8Q9bvOrtQpSZ6g4vQz7LGnG3UaOiBk=;
 b=lc7yeooO73SXdOyiueqQ886L1sJ5lVmuxg8SLucML2Zw7vSa8pmmVOsf92I0PFF5JJsr
 XOFw33Wj+8U6cJVqR2zNTi5laTK8MmRf7/FdcLZP6YX11yux+3CltiqR6yTMRq8OrfL1
 g4SZgwc+N7snGtNPzyGMic6bgvGL6wTLoNo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37seq89h2p-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 07 Apr 2021 11:03:12 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 11:00:09 -0700
Received: from devvm1945.atn0.facebook.com (localhost [127.0.0.1])
        by devvm1945.atn0.facebook.com (Postfix) with ESMTP id 50F1351ACC2D;
        Wed,  7 Apr 2021 11:00:06 -0700 (PDT)
Received: (from saravanand@localhost)
        by devvm1945.atn0.facebook.com (8.15.2/8.15.2/Submit) id 137I05lP4130564;
        Wed, 7 Apr 2021 11:00:05 -0700
X-Authentication-Warning: devvm1945.atn0.facebook.com: saravanand set sender to saravanand@fb.com using -f
From:   Saravanan D <saravanand@fb.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <tj@kernel.org>, <kernel-team@fb.com>,
        Saravanan D <saravanand@fb.com>
Subject: [PATCH] blk-mq: Fix spurious debugfs directory creation during initialization
Date:   Wed, 7 Apr 2021 10:59:58 -0700
Message-ID: <20210407175958.4129976-1-saravanand@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7MbEPmIeMHSKZn6oySWxe8j89wul9CEC
X-Proofpoint-ORIG-GUID: 7MbEPmIeMHSKZn6oySWxe8j89wul9CEC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_09:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_debugfs_register_sched_hctx() called from
device_add_disk()->elevator_init_mq()->blk_mq_init_sched()
initialization sequence does not have relevant parent directory
setup and thus spuriously attempts "sched" directory creation
from root mount of debugfs for every hw queue detected on the
block device

dmesg
...
debugfs: Directory 'sched' with parent '/' already present!
debugfs: Directory 'sched' with parent '/' already present!
.
.
debugfs: Directory 'sched' with parent '/' already present!
...

The parent debugfs directory for hw queues get properly setup
device_add_disk()->blk_register_queue()->blk_mq_debugfs_register()
->blk_mq_debugfs_register_hctx() later in the block device
initialization sequence.

A simple check for debugfs_dir has been added to thwart premature
debugfs directory/file creation attempts.

Signed-off-by: Saravanan D <saravanand@fb.com>
---
 block/blk-mq-debugfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 271f6596435b..2a75bc7401df 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -972,6 +972,14 @@ void blk_mq_debugfs_register_sched_hctx(struct reque=
st_queue *q,
 {
 	struct elevator_type *e =3D q->elevator->type;
=20
+	/*
+	 * If the parent debugfs directory has not been created yet, return;
+	 * We will be called again later on with appropriate parent debugfs
+	 * directory from blk_register_queue()
+	 */
+	if (!hctx->debugfs_dir)
+		return;
+
 	if (!e->hctx_debugfs_attrs)
 		return;
=20
--=20
2.30.2

