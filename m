Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39862C31E5E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1321D20657
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qb0n4oIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfFSROU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:14:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54057 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfFSROU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 13:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560964460; x=1592500460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XLB4y84qryt/o20ieADyCTLritHYsqyXsy9EGUzPvOM=;
  b=qb0n4oIPUSXw3kdzduOtSlNA8vkhyZhIDvMgpnLMPO4jlgRLgEYAM5WZ
   eaQL5U0kwA+dQTuWDaLW0/Hct/FIWDCjJigF5EwiS3OzL6Il0MFDJeD/S
   vzQdGiDFfJ/ILvKWhznVw0Zbq8TizFRlcwv5noFgv7TOm6W2ASSb45HLY
   rKihYR3dXAVHRh+O0C1Kn3gr1v0A/y9FdQw4Lcd+Yo1myvx8lHsvY4dbr
   xcgitvbY/wD1VdkFzYbuXKAlrRacxIveQtm+IZ8l5EHekyxCMep3QEd8H
   TXhl+SRYaQOrf3CLxbQrpmwJGAD/ZM9jaDG8vXS+nw7vNcMUOjlMecd97
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,393,1557158400"; 
   d="scan'208";a="112626244"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 01:14:13 +0800
IronPort-SDR: JIjV6l0EHwshiffDgjMw4lNng9phxM0zbIlFIiU0D89QgeVOJxru5wvBDW5a5d3rekvjDyeD1j
 rmjgXEXv8Cvq4cVcBNXyOI/DxhyuyUDYXp5xHf6e/ETHBz7QXQWtDE6qiOorvIq2YYLk3wzMPR
 Q3nMJHIVkTiaEfCezk5ClzoTJ/jErjmyvInG76ku/74L25PXXfzAKu2Pwe8Wf+DW5FSVHeir04
 F4ojaSJd2qsj8H1cfiG/VTwCYC0LN8JgExQVH7tSiNbAou9mX4MlKVPEf5AoplNDeA3Q1wANqd
 41hIWNZ76XIF53jZVt5jWrlT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Jun 2019 10:13:40 -0700
IronPort-SDR: WmCIhKe3cHrGVnQij00xHiHtMNyPABlnUanPbIZNs4dfmUvpoGCSoWLhN+ueDPU9O7qHHkJFdO
 t1uhZZsYaXEKPwlN9bbLnytCsH8ObyzSDdfLfFdhjycapoDoLLjebuVExacw02BaADFv3Rgldq
 aEaX/kx/WTOeCw3HgyVi24XQDFVIkSSKIVvySjRcErDpKQm0JY8ZVrmLP+XE9uca5M+0mXOTii
 SQIs+suNPSz3qSb1tebCHAOK/uVRBpsfcCp/0n8WhVwmqnlBuNpVr2YKBJL+Jphgnu3Vxq2rsX
 gig=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 10:14:12 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 5/5] f2fs: use block layer helper for show_bio_op macro
Date:   Wed, 19 Jun 2019 10:13:02 -0700
Message-Id: <20190619171302.10146-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adjust the f2fs tracing code to use newly introduced block layer
function blk_op_str() which converts the REQ_OP_XXX into the string
XXX.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/trace/events/f2fs.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 53b96f12300c..e3dc031af7f5 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -76,16 +76,7 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
 #define show_bio_type(op,op_flags)	show_bio_op(op),		\
 						show_bio_op_flags(op_flags)
 
-#define show_bio_op(op)							\
-	__print_symbolic(op,						\
-		{ REQ_OP_READ,			"READ" },		\
-		{ REQ_OP_WRITE,			"WRITE" },		\
-		{ REQ_OP_FLUSH,			"FLUSH" },		\
-		{ REQ_OP_DISCARD,		"DISCARD" },		\
-		{ REQ_OP_SECURE_ERASE,		"SECURE_ERASE" },	\
-		{ REQ_OP_ZONE_RESET,		"ZONE_RESET" },		\
-		{ REQ_OP_WRITE_SAME,		"WRITE_SAME" },		\
-		{ REQ_OP_WRITE_ZEROES,		"WRITE_ZEROES" })
+#define show_bio_op(op)		blk_op_str(op)
 
 #define show_bio_op_flags(flags)					\
 	__print_flags(F2FS_BIO_FLAG_MASK(flags), "|",			\
-- 
2.19.1

