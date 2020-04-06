Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44FEC2BA2B
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 19:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CE5206F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 19:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgDFTgD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:36:03 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:26144 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725895AbgDFTgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 15:36:03 -0400
X-ASG-Debug-ID: 1586201760-0e4108639e378a20001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.244]) by bsf02.didichuxing.com with ESMTP id Ffo3N2feeRbTjYId; Tue, 07 Apr 2020 03:36:00 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Apr
 2020 03:36:00 +0800
Date:   Tue, 7 Apr 2020 03:35:59 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v3 0/7] Fix potential kernel panic when increase hardware
 queue
Message-ID: <cover.1586199103.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v3 0/7] Fix potential kernel panic when increase hardware
 queue
Mail-Followup-To: axboe@kernel.dk, bvanassche@acm.org,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS02.didichuxing.com (172.20.36.211) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.244]
X-Barracuda-Start-Time: 1586201760
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1778
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81033
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This series do some improvement base on V2, and also fix two memleaks.
And V2 import a regression for blktest/block/test/029, this test case
will increase and decrease hardware queue count quickly.


Memleak 1:

__blk_mq_alloc_rq_maps
	__blk_mq_alloc_rq_map

if fail
	blk_mq_free_rq_map

Actually, __blk_mq_alloc_rq_map alloc both map and request, here
also need free request.

Memleak 2:
When driver decrease hardware queue, set->nr_hw_queues will be changed
firstly in blk_mq_realloc_tag_set_tags or __blk_mq_update_nr_hw_queues,
then blk_mq_realloc_hw_ctxs and blk_mq_map_swqueue, even
blk_mq_free_tag_set have no chance to free these hardware queue resource,
because they iterate hardware queue by
for (i = 0; i < set->nr_hw_queues; i++).

Patch1~3: rename some function name, no function change.
Patch4: fix first memleak.
Patch5: fix prev_nr_hw_queues issue, need be saved before change.
Patch6: alloc map and request to fix potential kernel panic.


Changes since V2:
 * rename some functions name and fix memleak when free map and requests
 * Not free new allocated map and request, they will be relased when tagset gone

Changes since V1:
 * Add fix for potential kernel panic when increase hardware queue

Weiping Zhang (7):
  block: rename __blk_mq_alloc_rq_map
  block: rename __blk_mq_alloc_rq_maps
  block: rename blk_mq_alloc_rq_maps
  block: free both map and request
  block: save previous hardware queue count before udpate
  block: refactor __blk_mq_alloc_rq_map_and_requests
  block: alloc map and request for new hardware queue

 block/blk-mq.c         | 49 ++++++++++++++++++++++++++++++------------
 include/linux/blk-mq.h |  1 +
 2 files changed, 36 insertions(+), 14 deletions(-)

-- 
2.18.1

