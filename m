Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1DFC7EE26
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 15:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjEAPdc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjEAPda (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 11:33:30 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0FB10D5
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 08:33:25 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3414BRZm030792
        for <linux-block@vger.kernel.org>; Mon, 1 May 2023 08:33:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=R3QDeXh55fnTIvcRbRzVRlMMfaK54UFaOPj/dGklld8=;
 b=Pyvw3ykE1yQFrizdi+qBwCoEir6xYr6NZHHxw5mWMku27gZzjfHb6ZCIoXkHig41y8fI
 iEWivfI1oCWTaYnzoln79y6Gt2GtiNQPGJKRVgghJd9p7LFIMWJhpSkR9eXKIAxoERS9
 hNISlkgXu0W6+Yl6qp2jl15bYmA9ncrgKkj9LdFCvHrDWObMlg+vrgLbQzsW4aXnDYE/
 CSUiivRUkU8hnOYx3dlnZKtGKpgfygoUtVDXUkf/eAgOqowfKpptVlK1n6LQPapmfNRl
 xIpQEcpW/jtVd/NjNVXD4vYo53cTK5tsKd/cMarUm4ESa9xMPJFrgdx5yNBllBM9Poks +g== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q8xjw49pn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 01 May 2023 08:33:25 -0700
Received: from twshared31955.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:33:24 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 900FC1777ADC0; Mon,  1 May 2023 08:33:07 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <joshi.k@samsung.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <xiaoguang.wang@linux.alibaba.com>
CC:     Keith Busch <kbusch@kernel.org>
Subject: [RFC 2/3] nvme: fix cdev name leak
Date:   Mon, 1 May 2023 08:33:05 -0700
Message-ID: <20230501153306.537124-3-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230501153306.537124-1-kbusch@meta.com>
References: <20230501153306.537124-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Byqhx-hnoMdcrKfJukYZeyX1BifR0bGl
X-Proofpoint-ORIG-GUID: Byqhx-hnoMdcrKfJukYZeyX1BifR0bGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

If we fail to add the device, free the name allocated for it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1bfd52eae2eeb..0f1cb6f418182 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4079,8 +4079,16 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
 	if (ret)
 		return ret;
=20
-	return nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
+	ret =3D nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
 			     ns->ctrl->ops->module);
+	if (ret)
+		goto out_free_name;
+
+	return 0;
+
+out_free_name:
+	kfree_const(ns->cdev_device.kobj.name);
+	return ret;
 }
=20
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
--=20
2.34.1

