Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52552C04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F2820878
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F2820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeLEPgR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:36:17 -0500
Received: from mx2.didiglobal.com ([111.202.154.82]:9267 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1727103AbeLEPgR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 10:36:17 -0500
X-ASG-Debug-ID: 1544024169-0e4088301528cdb0001-Cu09wu
Received: from BJEXCAS003.didichuxing.com (bjexcas003.didichuxing.com [172.20.1.43]) by bsf01.didichuxing.com with ESMTP id TxN8jIPdufje9dZG; Wed, 05 Dec 2018 23:36:09 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 5 Dec
 2018 23:36:10 +0800
Date:   Wed, 5 Dec 2018 23:36:03 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH 0/2] get rid of BLK_MAX_TIMEOUT
Message-ID: <cover.1544023832.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH 0/2] get rid of BLK_MAX_TIMEOUT
Mail-Followup-To: axboe@kernel.dk, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS002.didichuxing.com (172.20.1.42) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexcas003.didichuxing.com[172.20.1.43]
X-Barracuda-Start-Time: 1544024169
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 396
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0002 1.0000 -2.0199
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63115
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Get rid of BLK_MAX_TIMEOUT, since we want use io_timeout to control
the maximun timeouts of a request, so remove this limitation.

Weiping Zhang (2):
  block: get rid of BLK_MAX_TIMEOUT
  block: add BLK_DEF_TIMEOUT

 block/blk-mq.c      |  2 +-
 block/blk-timeout.c | 13 +------------
 block/blk.h         |  5 ++---
 3 files changed, 4 insertions(+), 16 deletions(-)

-- 
2.14.1

