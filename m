Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A153C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 13:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026A12086C
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 13:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfBTNXG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:23:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4242 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfBTNXG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 08:23:06 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8F7B76F6E1156B3CCB0F;
        Wed, 20 Feb 2019 21:22:57 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 21:22:47 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 0/1] Fix NULL pointer dereference in register_disk
Date:   Wed, 20 Feb 2019 21:27:04 +0800
Message-ID: <1550669225-77623-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When I use syzkaller test kernel, there is a NULL pointer dereference
in register_disk. The better solution is add return code to
__device_add_disk. There is a patchset(http://lists.infradead.org/pipermail
/linux-nvme/2016-August/005860.html) from Fam Zheng, int this patchset, the
modify is as follows:
 int device_add_disk() {
        ...alloc A...
        retval = alloc B
        if (retval)
            goto fail;
        ...
	fail:
	    return retval;  --->did not free A
   }
There are many callers, ie:
loop_add-->add_disk-->device_add_disk-->__device_add_disk
loop_remove-->del_gendisk
----->This will free all resources, inclue B(free fail)

Maybe the better way is that if device_add_disk return fail, it should
free all resources? This needs to modify all the callers(Otherwise the
callers will double free), unfortunately, I am not very familiar with it.

zhengbin (1):
  Fix NULL pointer dereference in register_disk

 block/genhd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--
2.7.4

