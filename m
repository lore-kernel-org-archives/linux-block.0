Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C68BC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 14:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333B82084C
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 14:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333B82084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeLEORS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:17:18 -0500
Received: from mx2.didiglobal.com ([111.202.154.82]:7313 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1727025AbeLEORS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 09:17:18 -0500
X-ASG-Debug-ID: 1544019431-0e4108668a502db0001-Cu09wu
Received: from BJEXCAS006.didichuxing.com (bjexcas006.didichuxing.com [172.20.2.189]) by bsf02.didichuxing.com with ESMTP id HbE47xweLHuVCpEh; Wed, 05 Dec 2018 22:17:11 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 5 Dec
 2018 22:17:12 +0800
Date:   Wed, 5 Dec 2018 22:17:06 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <bvanassche@acm.org>, <linux-block@vger.kernel.org>
Subject: [PATCH v3] block: add documentation for io_timeout
Message-ID: <20181205141701.GA33910@192.168.3.9>
X-ASG-Orig-Subj: [PATCH v3] block: add documentation for io_timeout
Mail-Followup-To: axboe@kernel.dk, bvanassche@acm.org,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS002.didichuxing.com (172.20.1.42) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexcas006.didichuxing.com[172.20.2.189]
X-Barracuda-Start-Time: 1544019431
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1903
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.2176 1.0000 -0.7363
X-Barracuda-Spam-Score: -0.24
X-Barracuda-Spam-Status: No, SCORE=-0.24 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63111
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add documentation for /sys/block/<disk>/queue/io_timeout.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 Documentation/ABI/testing/sysfs-block | 10 ++++++++++
 Documentation/block/queue-sysfs.txt   |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index dea212db9df3..f254a374710a 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -271,3 +271,13 @@ Description:
 		size of 512B sectors of the zones of the device, with
 		the eventual exception of the last zone of the device
 		which may be smaller.
+
+What:		/sys/block/<disk>/queue/io_timeout
+Date:		November 2018
+Contact:	Weiping Zhang <zhangweiping@didiglobal.com>
+Description:
+		io_timeout is a request’s timeouts at block layer in
+		milliseconds. When the underlying driver starts processing
+		a request, the generic block layer will start a timer, if
+		this request cannot be completed in io_timeout milliseconds,
+		a timeout event will occur.
diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 2c1e67058fd3..f0c9bbce73fd 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -67,6 +67,13 @@ If set to a value larger than 0, the kernel will put the process issuing
 IO to sleep for this amont of microseconds before entering classic
 polling.
 
+io_timeout (RW)
+---------------
+This is a request’s timeouts at block layer in milliseconds. When the
+underlying driver starts processing a request, the generic block layer
+will start a timer, if this request cannot be completed in io_timeout
+milliseconds, a timeout event will occur.
+
 iostats (RW)
 -------------
 This file is used to control (on/off) the iostats accounting of the
-- 
2.14.1

