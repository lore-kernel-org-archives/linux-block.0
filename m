Return-Path: <SRS0=oKFV=PD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0995C43387
	for <linux-block@archiver.kernel.org>; Wed, 26 Dec 2018 03:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DFC2148E
	for <linux-block@archiver.kernel.org>; Wed, 26 Dec 2018 03:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbeLZD4m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:56:42 -0500
Received: from mx2.didiglobal.com ([111.202.154.82]:25430 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725933AbeLZD4m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Dec 2018 22:56:42 -0500
X-ASG-Debug-ID: 1545796599-0e4108417c1b09f0001-Cu09wu
Received: from BJEXCAS011.didichuxing.com (bjexcas011.didichuxing.com [172.20.1.45]) by bsf02.didichuxing.com with ESMTP id TrGGvyOp7rMtS6zx; Wed, 26 Dec 2018 11:56:39 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 26 Dec
 2018 11:56:39 +0800
Date:   Wed, 26 Dec 2018 11:56:33 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <bvanassche@acm.org>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>
Subject: [PATCH v4] block: add documentation for io_timeout
Message-ID: <20181226035613.GA16642@192.168.3.9>
X-ASG-Orig-Subj: [PATCH v4] block: add documentation for io_timeout
Mail-Followup-To: axboe@kernel.dk, bvanassche@acm.org, hch@infradead.org,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS002.didichuxing.com (172.20.1.42) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexcas011.didichuxing.com[172.20.1.45]
X-Barracuda-Start-Time: 1545796599
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1881
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0002 1.0000 -2.0196
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.64538
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add documentation for /sys/block/<disk>/queue/io_timeout.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 Documentation/ABI/testing/sysfs-block | 9 +++++++++
 Documentation/block/queue-sysfs.txt   | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index 7710d4022b19..dfad7427817c 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -279,3 +279,12 @@ Description:
 		size in 512B sectors of the zones of the device, with
 		the eventual exception of the last zone of the device
 		which may be smaller.
+
+What:		/sys/block/<disk>/queue/io_timeout
+Date:		November 2018
+Contact:	Weiping Zhang <zhangweiping@didiglobal.com>
+Description:
+		io_timeout is the request timeout in milliseconds. If a request
+		does not complete in this time then the block driver timeout
+		handler is invoked. That timeout handler can decide to retry
+		the request, to fail it or to start a device recovery strategy.
diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 39e286d7afc9..83b457e24bba 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -67,6 +67,13 @@ If set to a value larger than 0, the kernel will put the process issuing
 IO to sleep for this amount of microseconds before entering classic
 polling.
 
+io_timeout (RW)
+---------------
+io_timeout is the request timeout in milliseconds. If a request does not
+complete in this time then the block driver timeout handler is invoked.
+That timeout handler can decide to retry the request, to fail it or to start
+a device recovery strategy.
+
 iostats (RW)
 -------------
 This file is used to control (on/off) the iostats accounting of the
-- 
2.14.1

