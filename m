Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2B7C433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 12:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC00420758
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 12:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgEOMKh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 08:10:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4789 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbgEOMKh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 08:10:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E8474193311A1C622AEB;
        Fri, 15 May 2020 20:10:32 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 20:10:25 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH] blkcg:fixes memory leaks in blkg_conf_prep()
Date:   Fri, 15 May 2020 20:24:03 +0800
Message-ID: <1589545443-151387-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkg_conf_prep():
 
new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
...
blkg = blkg_lookup_check(pos, pol, q);
if (IS_ERR(blkg)) {
	ret = PTR_ERR(blkg);
	goto fail_unlock;
}
...


if calling blkg_lookup_check() failed, at the IS_ERR block, 
the new_blkg should be free before goto lable fail_unlock
in blkg_conf_prep() function.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 930212c..afeb769 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -682,6 +682,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		blkg = blkg_lookup_check(pos, pol, q);
 		if (IS_ERR(blkg)) {
 			ret = PTR_ERR(blkg);
+			blkg_free(new_blkg);
 			goto fail_unlock;
 		}
 
-- 
1.8.3.1

