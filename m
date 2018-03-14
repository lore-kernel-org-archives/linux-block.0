Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750779AbeCNOdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Mar 2018 10:33:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2EEV2eX102431
        for <linux-block@vger.kernel.org>; Wed, 14 Mar 2018 10:33:51 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gq5awgxq9-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 14 Mar 2018 10:33:50 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <maier@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 14:33:49 -0000
From: Steffen Maier <maier@linux.vnet.ibm.com>
To: dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc: linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steffen Maier <maier@linux.vnet.ibm.com>,
        Fedor Loshakov <loshakov@linux.vnet.ibm.com>
Subject: [PATCH] dm mpath: fix passing integrity data
Date: Wed, 14 Mar 2018 15:33:06 +0100
Message-Id: <20180314143306.98405-1-maier@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

After v4.12 commit e2460f2a4bc7 ("dm: mark targets that pass integrity
data"), dm-multipath, e.g. on DIF+DIX SCSI disk paths, does not support
block integrity any more. So add it to the whitelist.

This is also a pre-requisite to use block integrity with other dm layer(s)
on top of multipath, such as kpartx partitions (dm-linear) or LVM.

Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Bisected-by: Fedor Loshakov <loshakov@linux.vnet.ibm.com>
Fixes: e2460f2a4bc7 ("dm: mark targets that pass integrity data")
Cc: <stable@vger.kernel.org> #4.12+
---
 drivers/md/dm-mpath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 3fde9e9faddd..c174f0c53dc9 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -2023,7 +2023,8 @@ static int multipath_busy(struct dm_target *ti)
 static struct target_type multipath_target = {
 	.name = "multipath",
 	.version = {1, 12, 0},
-	.features = DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
+	.features = DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE |
+		    DM_TARGET_PASSES_INTEGRITY,
 	.module = THIS_MODULE,
 	.ctr = multipath_ctr,
 	.dtr = multipath_dtr,
-- 
2.13.5
