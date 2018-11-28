Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCF2C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1422086B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1422086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeK2D4r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:56:47 -0500
Received: from mx2.didichuxing.com ([36.110.17.22]:12330 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1728141AbeK2D4r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 22:56:47 -0500
X-ASG-Debug-ID: 1543424063-0e40881e33c74d0001-Cu09wu
Received: from BJEXCAS007.didichuxing.com (bjexcas007.didichuxing.com [172.20.2.248]) by bsf01.didichuxing.com with ESMTP id QEZIZqDNQwH1fZ5Q; Thu, 29 Nov 2018 00:54:23 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Thu, 29 Nov
 2018 00:54:23 +0800
Date:   Thu, 29 Nov 2018 00:54:18 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <bvanassche@acm.org>, <linux-block@vger.kernel.org>
Subject: [PATCH] block: add documentation for io_timeout
Message-ID: <20181128165415.GA38237@192.168.3.9>
X-ASG-Orig-Subj: [PATCH] block: add documentation for io_timeout
Mail-Followup-To: axboe@kernel.dk, bvanassche@acm.org,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS002.didichuxing.com (172.20.1.42) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexcas007.didichuxing.com[172.20.2.248]
X-Barracuda-Start-Time: 1543424063
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1758
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0054 1.0000 -1.9860
X-Barracuda-Spam-Score: -1.99
X-Barracuda-Spam-Status: No, SCORE=-1.99 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.62617
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

add documentation for /sys/block/<disk>/queue/io_timeout

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 Documentation/ABI/testing/sysfs-block | 9 +++++++++
 Documentation/block/queue-sysfs.txt   | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index dea212db9df3..f37c0000ca16 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -271,3 +271,12 @@ Description:
 		size of 512B sectors of the zones of the device, with
 		the eventual exception of the last zone of the device
 		which may be smaller.
+
+What:		/sys/block/<disk>/queue/io_timeout
+Date:		November 2018
+Contact:	Weiping Zhang <zhangweiping@didiglobal.com>
+Description:
+		io_timeout is the timeout in millisecods of a request in
+		block layer. The block layer will start a timer when low
+		level device driver start the request, and cancle timer
+		when request completes.
diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 2c1e67058fd3..cbd44fe056fa 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -67,6 +67,12 @@ If set to a value larger than 0, the kernel will put the process issuing
 IO to sleep for this amont of microseconds before entering classic
 polling.
 
+io_timeout (RW)
+---------------
+This is the timeout in millisecods of a request in block layer.
+The block layer will start a timer when low level device driver start
+the request, and cancle timer when request completes.
+
 iostats (RW)
 -------------
 This file is used to control (on/off) the iostats accounting of the
-- 
2.14.1

