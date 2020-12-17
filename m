Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9468BC4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6843623975
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgLQQAB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 11:00:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727566AbgLQQAA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 11:00:00 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BHFZGTv099126;
        Thu, 17 Dec 2020 10:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=XCsE/Z4qtG6y7bi9HsfBYxdU1uZirKiPp9pLxFai24Q=;
 b=o3kXNO/pWLUpQFs/Ve5yhECukNSXecRpJueUMkxu1tI4TxZuX+BRc/aE3f/2b33abC2a
 QTL+58RTo6loGf86YnGNvhQKBDKe3zWi7oF5zNhL0EJgVYLPh+Tt1JDAnwHQP9ydsUX7
 O21u/xT+iW2uecg1fr0K86k7UuBxn7N/xtgZs39DrnA5+A/K2ADaV4naANkkqabVmzze
 nckAHk3gHXtR+RUZe1ED2ox72b8YpM12FeWuA8/1dnyUrQUOK0DuFSv5iBLYAVxBcah5
 o3BvOUOiOd7Y8WZErmrbgwXNVqIbSlX9rDQiwkLOyz6khMHuU8tl1My3oqdaF52qMsYV lA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35g994agsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 10:59:19 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BHFq639014536;
        Thu, 17 Dec 2020 15:59:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 35cng8dgeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 15:59:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BHFx7BY26935594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 15:59:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95FFD4204C;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83A3C42045;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 17 Dec 2020 15:59:07 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 3362DE0384; Thu, 17 Dec 2020 16:59:07 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/4] s390/dasd: fix list corruption of pavgroup group list
Date:   Thu, 17 Dec 2020 16:59:06 +0100
Message-Id: <20201217155907.36436-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217155907.36436-1-sth@linux.ibm.com>
References: <20201217155907.36436-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_10:2020-12-15,2020-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=994 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170106
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dasd_alias_add_device() moves devices to the active_devices list in case
of a scheduled LCU update regardless if they have previously been in a
pavgroup or not.

Example: device A and B are in the same pavgroup.

Device A has already been in a pavgroup and the private->pavgroup pointer
is set and points to a valid pavgroup. While going through dasd_add_device
it is moved from the pavgroup to the active_devices list.

In parallel device B might be removed from the same pavgroup in
remove_device_from_lcu() which in turn checks if the group is empty
and deletes it accordingly because device A has already been removed from
there.

When now device A enters remove_device_from_lcu() it is tried to remove it
from the pavgroup again because the pavgroup pointer is still set and again
the empty group will be cleaned up which leads to a list corruption.

Fix by setting private->pavgroup to NULL in dasd_add_device.

If the device has been the last device on the pavgroup an empty pavgroup
remains but this will be cleaned up by the scheduled lcu_update which
iterates over all existing pavgroups.

Fixes: 8e09f21574ea ("[S390] dasd: add hyper PAV support to DASD device driver, part 1")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_alias.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index f841518de6c5..60344e13e87b 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -642,6 +642,7 @@ int dasd_alias_add_device(struct dasd_device *device)
 	}
 	if (lcu->flags & UPDATE_PENDING) {
 		list_move(&device->alias_list, &lcu->active_devices);
+		private->pavgroup = NULL;
 		_schedule_lcu_update(lcu, device);
 	}
 	spin_unlock_irqrestore(&lcu->lock, flags);
-- 
2.17.1

