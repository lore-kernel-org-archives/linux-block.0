Return-Path: <SRS0=MH8N=5U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04D8C2BA16
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 13:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B007B206C3
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 13:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDDNgD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Apr 2020 09:36:03 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:10654 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1726005AbgDDNgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Apr 2020 09:36:03 -0400
X-ASG-Debug-ID: 1586007341-0e4108639f281e10001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.175]) by bsf02.didichuxing.com with ESMTP id OKBHSKNYDbPoInQI; Sat, 04 Apr 2020 21:35:41 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 4 Apr
 2020 21:35:41 +0800
Date:   Sat, 4 Apr 2020 21:35:40 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v2 0/2] Fix potential kernel panic when increase hardware
 queue
Message-ID: <cover.1586006904.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v2 0/2] Fix potential kernel panic when increase hardware
 queue
Mail-Followup-To: axboe@kernel.dk, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.175]
X-Barracuda-Start-Time: 1586007341
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 536
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.1930 1.0000 -0.8649
X-Barracuda-Spam-Score: -0.86
X-Barracuda-Spam-Status: No, SCORE=-0.86 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.80990
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patchset fix a potential kernel panic when increase more hardware
queue at runtime.

Patch1 fix a seperate issue, since patch2 depends on it, so I send a
new patchset.

Change since V1:
 * Add second patch to fix kernel panic when update hardware queue

Weiping Zhang (2):
  block: save previous hardware queue count before udpate
  block: alloc map and request for new hardware queue

 block/blk-mq.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

-- 
2.18.1

