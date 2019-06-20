Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E652C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 18:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C3F20665
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 18:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kSu7JUF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfFTR77 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:59:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35454 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfFTR74 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 13:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561053595; x=1592589595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XLB4y84qryt/o20ieADyCTLritHYsqyXsy9EGUzPvOM=;
  b=kSu7JUF6rqXRzY5q5QF7WG0Ccy2gUp83Oj+dKBDb1jZDUOpfi+qJOQlD
   uch+o+vADwdA5spuHHemi8NiOTmCNcd6xzooIeA6I2ls764TE0+viGhPE
   u8+jW4fo4qcJTLfFVuueuhC/5iaKOEpwZ5BHAYTNyypMz5E5toXkIk6Wh
   gh1N2p6fWajG//3OeohhZaMa//RMCT91dD0KZkR7jhwUGnIkuHDYv4Qn8
   VqZkFFkCx6ykXEFMSSvykXn3LVU2zPQ+XCsfIHmsCFdOsFguykbQa1vNv
   60raa/v/mtLJ5EdajV94unkyq9mThDhq7ubW+zhqSG4AFxmB7di5E3SBC
   A==;
X-IronPort-AV: E=Sophos;i="5.63,397,1557158400"; 
   d="scan'208";a="217443502"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2019 01:59:55 +0800
IronPort-SDR: Wp/kgTa8A2JrMOIE3H1hjCi6a7kblRkECBanUCUdG7mTWkh0wi9aMbMU3uEHmDdw5/3oKlLXzy
 r4cBdNSOIj0tpCYWs6c3aitoacpi+n1ML8VE8iSa7gc9fYeFpbTr6/4yMLMPsVGEaLeTrHved7
 04lYCItSbwBLNeB3vdQbToL38FyXhljbPECrDoWEWea4/9uc/CUq0+1mlb9Qif+zMoGePDer02
 WWKkfV6lV3T+TQdvOwroedEMPLr4RKX1uYpvLaow50fxYxP5r4VCHAsygTJlSDn3U2zTaYbsdV
 Q+0ZTELsjfT1Pc98YIEO1wQJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 20 Jun 2019 10:59:14 -0700
IronPort-SDR: hsa7EYi1XKrtVI5ipv9Jli4na7fl+bD6dmsIRcGpP0o9RqcN5SjJ3LCXGdi+ZIme2sDzkmjXCO
 kGDdhty5f/7NveDvXlXm5PnxmufLwps/hKSCARIQAAUYnImkcQjQhZTaPrhre9V6KpMPw6OnJN
 wBEHtYS/zYP7qWJAnW61Ck+kfSgdVbAwWyNn/uw+7WL0btrPDRxp07Tfw1y5bx7vKgsxQNT1pU
 d4zlvIw8xG+tN14bR4E/goebfcOg5SS0eFAMadB0Q2x24RqcE5phkcvGfZaOdDllu3RPH8MMbI
 xp8=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jun 2019 10:59:55 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V5 5/5] f2fs: use block layer helper for show_bio_op macro
Date:   Thu, 20 Jun 2019 10:59:19 -0700
Message-Id: <20190620175919.3273-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
References: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
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

