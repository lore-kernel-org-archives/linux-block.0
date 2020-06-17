Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58331C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 06:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1AF20739
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 06:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFQGyM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:54:12 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:11758 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725929AbgFQGyM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 02:54:12 -0400
X-Greylist: delayed 1959 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 02:54:01 EDT
X-ASG-Debug-ID: 1592374868-0e408814247687c0001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.207]) by bsf01.didichuxing.com with ESMTP id C5GDVdECNVCUoake; Wed, 17 Jun 2020 14:21:08 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Jun
 2020 14:18:55 +0800
Date:   Wed, 17 Jun 2020 14:18:37 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>, <tom.leiming@gmail.com>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH] block: update hctx map when use multiple maps
Message-ID: <20200617061830.GA15100@192.168.3.9>
X-ASG-Orig-Subj: [PATCH] block: update hctx map when use multiple maps
Mail-Followup-To: axboe@kernel.dk, bvanassche@acm.org,
        tom.leiming@gmail.com, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS05.didichuxing.com (172.20.36.127) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.207]
X-Barracuda-Start-Time: 1592374868
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1530
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82606
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is an issue when tune the number for read and write queues,
if the total queue count was not changed. The hctx->type cannot
be updated, since __blk_mq_update_nr_hw_queues will return directly
if the total queue count has not been changed.

Reproduce:

dmesg | grep "default/read/poll"
[    2.607459] nvme nvme0: 48/0/0 default/read/poll queues
cat /sys/kernel/debug/block/nvme0n1/hctx*/type | sort | uniq -c
     48 default

tune the write queues to 24:
echo 24 > /sys/module/nvme/parameters/write_queues
echo 1 > /sys/block/nvme0n1/device/reset_controller

dmesg | grep "default/read/poll"
[  433.547235] nvme nvme0: 24/24/0 default/read/poll queues

cat /sys/kernel/debug/block/nvme0n1/hctx*/type | sort | uniq -c
     48 default

The driver's hardware queue mapping is not same as block layer.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4f57d27bfa73..a9aa6d1e44cf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3479,7 +3479,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	if (set->nr_maps == 1 && nr_hw_queues > nr_cpu_ids)
 		nr_hw_queues = nr_cpu_ids;
-	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
+	if (nr_hw_queues < 1)
+		return;
+	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
 		return;
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-- 
2.18.2

