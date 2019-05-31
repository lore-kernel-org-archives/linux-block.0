Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85488C04AB6
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 06:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F7E26431
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 06:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2EvJp7K6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfEaGHE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 May 2019 02:07:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55048 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaGHE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 02:07:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4V63x5w082033;
        Fri, 31 May 2019 06:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=H1T5Pw2VduTFeb2Xrn7dhLH9NNo+HGWkHj61LSeQLFo=;
 b=2EvJp7K6y14/EbcYrLaGrbq9fqJIR8LIJGUrsHofjMV10d77IyuALmNmwWVxVj4tCTzQ
 pkWH/ec+mbPaLkSgTfPi4CH9d3k8BUuPjR9NRNasl5fNQchI7oCN2Dam4xUXsdU8fDyH
 L/kgmHLo8IKDJno+Tr3BV/w4Gaalw6z96ZJJ/w2LQ+7FEurRe2Rmx5UVmDr+p/fcDjAL
 kBoX4FhV4V7J2CAvJ1HlcE59lYJnfcNb1aBhJqEAtRcE86hPaEYHVk6vDLdf2TrINf2C
 86lWev6wSmTPw5vT4b4ghfqFpZwuOGA2MvJlIJRkoMsoA2/DtdRmxB+6a2tGi21EU09x bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2spw4tv5jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 06:06:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4V65w1T124150;
        Fri, 31 May 2019 06:06:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2srbdyctc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 06:06:25 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4V66LaK006012;
        Fri, 31 May 2019 06:06:23 GMT
Received: from localhost.localdomain (/101.95.182.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 23:06:20 -0700
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hare@suse.com, hch@lst.de,
        martin.petersen@oracle.com, bart.vanassche@wdc.com,
        ming.lei@redhat.com, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH] block: null_blk: fix race condition for null_del_dev
Date:   Fri, 31 May 2019 14:05:45 +0800
Message-Id: <20190531060545.10235-1-bob.liu@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310040
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dulicate call of null_del_dev() will trigger null pointer error like below.
The reason is a race condition between nullb_device_power_store() and
nullb_group_drop_item().

 CPU#0                         CPU#1
 ----------------              -----------------
 do_rmdir()
  >configfs_rmdir()
   >client_drop_item()
    >nullb_group_drop_item()
                               nullb_device_power_store()
				>null_del_dev()

     >test_and_clear_bit(NULLB_DEV_FL_UP
      >null_del_dev()
      ^^^^^
      Duplicated null_dev_dev() triger null pointer error

				>clear_bit(NULLB_DEV_FL_UP

The fix could be keep the sequnce of clear NULLB_DEV_FL_UP and null_del_dev().

[  698.613600] BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
[  698.613608] #PF error: [normal kernel read fault]
[  698.613611] PGD 0 P4D 0
[  698.613619] Oops: 0000 [#1] SMP PTI
[  698.613627] CPU: 3 PID: 6382 Comm: rmdir Not tainted 5.0.0+ #35
[  698.613631] Hardware name: LENOVO 20LJS2EV08/20LJS2EV08, BIOS R0SET33W (1.17 ) 07/18/2018
[  698.613644] RIP: 0010:null_del_dev+0xc/0x110 [null_blk]
[  698.613649] Code: 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b eb 97 e8 47 bb 2a e8 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 54 53 <8b> 77 18 48 89 fb 4c 8b 27 48 c7 c7 40 57 1e c1 e8 bf c7 cb e8 48
[  698.613654] RSP: 0018:ffffb887888bfde0 EFLAGS: 00010286
[  698.613659] RAX: 0000000000000000 RBX: ffff9d436d92bc00 RCX: ffff9d43a9184681
[  698.613663] RDX: ffffffffc11e5c30 RSI: 0000000068be6540 RDI: 0000000000000000
[  698.613667] RBP: ffffb887888bfdf0 R08: 0000000000000001 R09: 0000000000000000
[  698.613671] R10: ffffb887888bfdd8 R11: 0000000000000f16 R12: ffff9d436d92bc08
[  698.613675] R13: ffff9d436d94e630 R14: ffffffffc11e5088 R15: ffffffffc11e5000
[  698.613680] FS:  00007faa68be6540(0000) GS:ffff9d43d14c0000(0000) knlGS:0000000000000000
[  698.613685] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  698.613689] CR2: 0000000000000018 CR3: 000000042f70c002 CR4: 00000000003606e0
[  698.613693] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  698.613697] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  698.613700] Call Trace:
[  698.613712]  nullb_group_drop_item+0x50/0x70 [null_blk]
[  698.613722]  client_drop_item+0x29/0x40
[  698.613728]  configfs_rmdir+0x1ed/0x300
[  698.613738]  vfs_rmdir+0xb2/0x130
[  698.613743]  do_rmdir+0x1c7/0x1e0
[  698.613750]  __x64_sys_rmdir+0x17/0x20
[  698.613759]  do_syscall_64+0x5a/0x110
[  698.613768]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 drivers/block/null_blk_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 62c9654..99dd0ab 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -326,11 +326,12 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 		dev->power = newp;
 	} else if (dev->power && !newp) {
-		mutex_lock(&lock);
-		dev->power = newp;
-		null_del_dev(dev->nullb);
-		mutex_unlock(&lock);
-		clear_bit(NULLB_DEV_FL_UP, &dev->flags);
+		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
+			mutex_lock(&lock);
+			dev->power = newp;
+			null_del_dev(dev->nullb);
+			mutex_unlock(&lock);
+		}
 		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 	}
 
-- 
2.9.5

