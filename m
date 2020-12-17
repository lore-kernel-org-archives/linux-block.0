Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7CFC4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA2A23975
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgLQQBJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 11:01:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725871AbgLQQBJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 11:01:09 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BHFXWcL126119;
        Thu, 17 Dec 2020 11:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=jtPki1yJhqps2YVLa9BpoClJ4eGOp1DNBdnx9Q8lDsk=;
 b=TAYGeu6LPYGX9olM78GwRqySQpdVJgnoH4WY4Dcb3VHQcknr8/RGiVE2kBKYda7TewFQ
 vPNJ+hJZLEOnxp4dc6HTUddWbVAG3m4XsWzEgamNAvBKVsJnlZjWWhzF80BhcoAPe71c
 NS3rp/RQzV2UxWrPNrkYxWN3a4+Vd1UlsR2XdGlfDNwOQyz+j7jAH9g655X3jfD7XKag
 ndggkJqPla/mNFeg580xP4xhiQcglKZYBSc3RrLgz5rWBMdhBGPJUvjy8NLBwJDfWMI/
 sy4vt1uHwYVm+7sEJDUZOmLarhqkGqlHO8GoKlpnw5zUWit0xZHoRDulE4hPDgv91PFC 1A== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35ga0s8xfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 11:00:27 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BHFrBuM023407;
        Thu, 17 Dec 2020 16:00:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 35cng8g63d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 16:00:25 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BHFx7HY26083780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 15:59:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98492AE055;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 846EDAE053;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 360F9E0399; Thu, 17 Dec 2020 16:59:07 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/4] s390/dasd: fix list corruption of lcu list
Date:   Thu, 17 Dec 2020 16:59:07 +0100
Message-Id: <20201217155907.36436-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217155907.36436-1-sth@linux.ibm.com>
References: <20201217155907.36436-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_10:2020-12-15,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=953 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170106
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In dasd_alias_disconnect_device_from_lcu the device is removed from any
list on the LCU. Afterwards the LCU is removed from the lcu list if it
does not contain devices any longer.

The lcu->lock protects the lcu from parallel updates. But to cancel all
workers and wait for completion the lcu->lock has to be unlocked.

If two devices are removed in parallel and both are removed from the LCU
the first device that takes the lcu->lock again will delete the LCU because
it is already empty but the second device also tries to free the LCU which
leads to a list corruption of the lcu list.

Fix by removing the device right before the lcu is checked without
unlocking the lcu->lock in between.

Fixes: 8e09f21574ea ("[S390] dasd: add hyper PAV support to DASD device driver, part 1")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_alias.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index 60344e13e87b..dc78a523a69f 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -256,7 +256,6 @@ void dasd_alias_disconnect_device_from_lcu(struct dasd_device *device)
 		return;
 	device->discipline->get_uid(device, &uid);
 	spin_lock_irqsave(&lcu->lock, flags);
-	list_del_init(&device->alias_list);
 	/* make sure that the workers don't use this device */
 	if (device == lcu->suc_data.device) {
 		spin_unlock_irqrestore(&lcu->lock, flags);
@@ -283,6 +282,7 @@ void dasd_alias_disconnect_device_from_lcu(struct dasd_device *device)
 
 	spin_lock_irqsave(&aliastree.lock, flags);
 	spin_lock(&lcu->lock);
+	list_del_init(&device->alias_list);
 	if (list_empty(&lcu->grouplist) &&
 	    list_empty(&lcu->active_devices) &&
 	    list_empty(&lcu->inactive_devices)) {
-- 
2.17.1

