Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80378C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 13:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B85206D6
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 13:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgD1N3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:29:25 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:14359 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1726900AbgD1N3Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 09:29:25 -0400
X-ASG-Debug-ID: 1588080560-0e41085959572b70001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.203]) by bsf02.didichuxing.com with ESMTP id lS6zGcTx2iNckKRN; Tue, 28 Apr 2020 21:29:20 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 28 Apr
 2020 21:29:20 +0800
Date:   Tue, 28 Apr 2020 21:29:19 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tom.leiming@gmail.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>
Subject: [RESEND PATCH v4 0/6] Fix potential kernel panic when increase
 hardware queue
Message-ID: <cover.1588078594.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [RESEND PATCH v4 0/6] Fix potential kernel panic when increase
 hardware queue
Mail-Followup-To: axboe@kernel.dk, tom.leiming@gmail.com,
        bvanassche@acm.org, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.203]
X-Barracuda-Start-Time: 1588080560
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1993
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81478
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20200428132919.9bHRgAY3SfYS2tSRPt1En2xSg9DiFTW2zmfXG-Ot570@z>

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

Patch1: fix Memleak 1.
Patch2: fix prev_nr_hw_queues issue, need be saved before change.
Patch3: refactor __blk_mq_alloc_rq_maps and fix Memleak 2.
Patch4: fix potential kernel panic when increase hardware queue.
Patch5~6: rename two function, because these two function alloc both
map and request, and keep in pair with blk_mq_free_map_and_request(s).

Changes since V3:
* record patchset, fix issue fistly then rename.
* rename function to blk_mq_alloc_map_and_request

Changes since V2:
 * rename some functions name and fix memleak when free map and requests
 * Not free new allocated map and request, they will be relased when tagset gone

Changes since V1:
 * Add fix for potential kernel panic when increase hardware queue

Weiping Zhang (6):
  block: free both rq_map and request
  block: save previous hardware queue count before udpate
  block: refactor __blk_mq_alloc_rq_maps
  block: alloc map and request for new hardware queue
  block: rename __blk_mq_alloc_rq_map
  block: rename blk_mq_alloc_rq_maps

 block/blk-mq.c         | 47 +++++++++++++++++++++++++++++-------------
 include/linux/blk-mq.h |  1 +
 2 files changed, 34 insertions(+), 14 deletions(-)

-- 
2.18.1

