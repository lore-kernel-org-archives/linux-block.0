Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D9DC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CE020866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dsYRMx+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfEAE26 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:28:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63878 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfEAE26 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685002; x=1588221002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZyyK9ufRJmyy8qS1kXlfIh7wxjzqBg+b5fDXK+bKhaA=;
  b=dsYRMx+F/G7C1X+C++XH8/Nz9lVkCFrrEVgjx7UmivDX4KCOCTmCuCaf
   kRuBE1mkFuZKUKMSkcNJY8aQL6rpxDtkSrbOkYV9M8N6MCGrGSaXOG9Tl
   yKxOdY8gGzaff7EfxX2aROdNK4hY9mVtnAsm0l4pL0ZgIxcZjMl4MaYNt
   JFpO8+1Ezmd64XGPrEwIK7S2l3wwseHMT9ljY5pYswzhMfbt/3mgRCsTC
   lXJxOpVyGH45A39osXhcY9PbLRHs4dli0vUp0xZo6ZwXtsreIRDlYAZtU
   siOx7eT1im+t2j0teDW3XhFJLCchuKBaYFULRAKUDL6Ib+tFMfP67Fkw8
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432276"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:02 +0800
IronPort-SDR: u24C2NlYzVN8r1OKFyEiStPqjhRpN33LfN9FxbRxeGtiZl81W7ALPOkTNR/z+Z3RTe3Wt5mIgs
 /3k3oJdmoBFpoU8xiw2zJAZnyy3MP81zU7gMxDtcIonOCgHmM2KFzO6APInVg4OxHmbM9JICAt
 Q9vEG6vNmyqB3Pnp4tGlPjd1KPbbNn4HTlt6bQkT3lSY7c595dma4LkbYxxIowJNYq87oPvQjI
 tpe7U4ByPuU3RdxEPNNLMGIRrwwbxA9qOSo8NEX0WVqKYnx88u2TyW9GOeMY4zD9loDn4ecOt0
 pdBybw7/67q+J2k/GLaC09Ym
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:27 -0700
IronPort-SDR: FspY5bMLOMnCHVNpKHDLPD3OOMMql81eSPFt0SOo4czpF77zQ5w5dfZsus4Qp7aVKxSPtDQtNt
 n+gxT/pY3lM/T0uiFmudSTLaOo3B8ltFCgqeeOEku6KTfsZ2fr+6sK5HuR9tdhaqAn5RAxVR2G
 XoJDHQ3cHTWAqPwQW6+L8HB8hUL/lcAEos8bVXREwYs7VpJCUhR6AoGRTO9Rh5GAeJ3FrX/f9j
 IefsEZyJAA/0DUjUtePXe7JqohhzjS1O2kYlvnd6cxcpZ1LeMI7JR/gLb/8gk60EwupJ2xLTkY
 tPE=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:28:58 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 05/18] blktrace: add iopriority mask
Date:   Tue, 30 Apr 2019 21:28:18 -0700
Message-Id: <20190501042831.5313-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update the blktrace API header with to handle the priority mask.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/linux/blktrace_api.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 403d4cfc6a52..1b9a8b30cf9c 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -19,6 +19,7 @@ struct blk_trace {
 	unsigned char __percpu *msg_data;
 #ifdef CONFIG_BLKTRACE_EXT
 	u64 act_mask;
+	u32 prio_mask;
 #else
 	u16 act_mask;
 #endif /* CONFIG_BLKTRACE_EXT */
-- 
2.19.1

