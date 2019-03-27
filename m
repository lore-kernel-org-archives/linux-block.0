Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B2C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 10:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563182075C
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 10:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ob7shVw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbfC0Kcy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:32:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33026 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfC0Kcv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 06:32:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2RADYV8043066;
        Wed, 27 Mar 2019 10:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Y1De08/xPcyggzI3BCpgTfIH3to8eq5cRgEsOUIlgQc=;
 b=ob7shVw8WrDBoRtuv0r0+8YY/J2J0HwBv5lkvbLyCNsUwh02bG88UFNFiamhWmROlraT
 3WhpMqu+GqQkupFCl8opo8BXEDALLlXcqoCBb6bNZ92ynojCIcbKuo9cVyMRkOaTSgtI
 w9KdixD4VE1bI01NiqKq/9JcSJXY1Vy9bhim0eaJty5kY6ytRqVulm0p7rh14ZxxIYx8
 7jDFWspTydDBeix6odvXxcs52B4z5MqPpL4jO27NRO7zTIrSC6dOLIydrX2AJVpTJGDv
 XB3sIcLygRVMUCQmt+QaXY6OTApPkPxqMEkYOdvDWS7STsim4urVmp3BqXvbcHbY5umV Nw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2re6g17njp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 10:32:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2RAWiXw000973
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 10:32:45 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2RAWirR001152;
        Wed, 27 Mar 2019 10:32:44 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 03:32:43 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scsi: virtio_scsi: limit number of hw queues by nr_cpu_ids
Date:   Wed, 27 Mar 2019 18:36:35 +0800
Message-Id: <1553682995-5682-3-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553682995-5682-1-git-send-email-dongli.zhang@oracle.com>
References: <1553682995-5682-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903270074
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When tag_set->nr_maps is 1, the block layer limits the number of hw queues
by nr_cpu_ids. No matter how many hw queues are used by virtio-scsi, as it
has (tag_set->nr_maps == 1), it can use at most nr_cpu_ids hw queues.

In addition, specifically for pci scenario, when the 'num_queues' specified
by qemu is more than maxcpus, virtio-scsi would not be able to allocate
more than maxcpus vectors in order to have a vector for each queue. As a
result, it falls back into MSI-X with one vector for config and one shared
for queues.

Considering above reasons, this patch limits the number of hw queues used
by virtio-scsi by nr_cpu_ids.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/scsi/virtio_scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 8af0177..9c4a3e1 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -793,6 +793,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
 
 	/* We need to know how many queues before we allocate. */
 	num_queues = virtscsi_config_get(vdev, num_queues) ? : 1;
+	num_queues = min_t(unsigned int, nr_cpu_ids, num_queues);
 
 	num_targets = virtscsi_config_get(vdev, max_target) + 1;
 
-- 
2.7.4

