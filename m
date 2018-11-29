Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B55C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 10:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A86C2081C
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 10:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A86C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeK2V1q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:27:46 -0500
Received: from mx2.didichuxing.com ([36.110.17.22]:23718 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726740AbeK2V1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 16:27:46 -0500
X-ASG-Debug-ID: 1543486967-0e408836ca1cf30001-Cu09wu
Received: from BJEXMBX012.didichuxing.com (bjexmbx012.didichuxing.com [172.20.2.191]) by bsf01.didichuxing.com with ESMTP id 1q9NhABXiz8x7Dvf; Thu, 29 Nov 2018 18:22:47 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Thu, 29 Nov
 2018 18:22:46 +0800
Date:   Thu, 29 Nov 2018 18:22:41 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <bvanassche@acm.org>, <linux-block@vger.kernel.org>
Subject: [PATCH v2] block: add documentation for io_timeout
Message-ID: <20181129102237.GA29592@192.168.3.9>
X-ASG-Orig-Subj: [PATCH v2] block: add documentation for io_timeout
Mail-Followup-To: axboe@kernel.dk, bvanassche@acm.org,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS002.didichuxing.com (172.20.1.42) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexmbx012.didichuxing.com[172.20.2.191]
X-Barracuda-Start-Time: 1543486967
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1760
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0001 1.0000 -2.0201
X-Barracuda-Spam-Score: -1.52
X-Barracuda-Spam-Status: No, SCORE=-1.52 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.62675
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
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
index dea212db9df3..6befa2ce667d 100644
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
+		io_timeout is the timeout in milliseconds of a request in
+		block layer. The block layer will start a timer when low
+		level device driver start the request, and cancel timer
+		when request completes.
diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 2c1e67058fd3..c0f2a9c92cce 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -67,6 +67,12 @@ If set to a value larger than 0, the kernel will put the process issuing
 IO to sleep for this amont of microseconds before entering classic
 polling.
 
+io_timeout (RW)
+---------------
+This is the timeout in milliseconds of a request in block layer.
+The block layer will start a timer when low level device driver start
+the request, and cancel timer when request completes.
+
 iostats (RW)
 -------------
 This file is used to control (on/off) the iostats accounting of the
-- 
2.14.1

