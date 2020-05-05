Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6296C47247
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 06:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8EE206CC
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 06:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgEEGnR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 May 2020 02:43:17 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:2825 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725320AbgEEGnQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 May 2020 02:43:16 -0400
X-ASG-Debug-ID: 1588660986-0e4108595c82c750001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.143]) by bsf02.didichuxing.com with ESMTP id NzA2Gvrz4lknqfjj; Tue, 05 May 2020 14:43:06 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 May
 2020 14:43:06 +0800
Date:   Tue, 5 May 2020 14:43:05 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tom.leiming@gmail.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v5 0/5] Fix potential kernel panic when increase hardware
 queue
Message-ID: <cover.1588660550.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v5 0/5] Fix potential kernel panic when increase hardware
 queue
Mail-Followup-To: axboe@kernel.dk, tom.leiming@gmail.com,
        bvanassche@acm.org, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.143]
X-Barracuda-Start-Time: 1588660986
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1522
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0857 1.0000 -1.4792
X-Barracuda-Spam-Score: -1.48
X-Barracuda-Spam-Status: No, SCORE=-1.48 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81632
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This series mainly fix the kernel panic when increase hardware queue,
and also fix some other misc issue.

Memleak 1:

__blk_mq_alloc_rq_maps
	__blk_mq_alloc_rq_map

if fail
	blk_mq_free_rq_map

Actually, __blk_mq_alloc_rq_map alloc both map and request, here
also need free request.


Patch1: fix Memleak 1.
Patch2: fix prev_nr_hw_queues issue, need be saved before change.
Patch3: From Ming, fix potential kernel panic when increase hardware queue.
Patch4~5: rename two function, because these two function alloc both
map and request, and keep in pair with blk_mq_free_map_and_request(s).

Changes since V4:
 * use another way to fix kernel panic when increase hardware queue,
   this patch from Ming.

Changes since V3:
* record patchset, fix issue fistly then rename.
* rename function to blk_mq_alloc_map_and_request

Changes since V2:
 * rename some functions name and fix memleak when free map and requests
 * Not free new allocated map and request, they will be relased when tagset gone

Changes since V1:
 * Add fix for potential kernel panic when increase hardware queue

Ming Lei (1):
  block: alloc map and request for new hardware queue

Weiping Zhang (4):
  block: free both rq_map and request
  block: save previous hardware queue count before udpate
  block: rename __blk_mq_alloc_rq_map
  block: rename blk_mq_alloc_rq_maps

 block/blk-mq.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

-- 
2.18.1

