Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98848C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 05:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631D664E61
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 05:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBVFbn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 00:31:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29611 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhBVFbm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 00:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613971901; x=1645507901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NwgzSfysxAnsV/PwmEDbkBo+3nnTrLiXXNuavPj2YT4=;
  b=LkajCSm+SfRN+zzERDmIDgc7tQoxJa6AHAmh4Sa8lfp5M2eCrOwETVE/
   GOS+gEAwQOo/8f5uDI1C+EX7wDH7S75iGUifvV1JFphmdGSMVo/X/r1U0
   Hqhi9QnQVvDFE66Zaf4fYDKo7Y1ApoK5X1+OnD+YSrTjs+fjljA7AL3Yw
   up54fCHtyKISjUAqBPlwyVLnjyN59GBCyNiLUX7VMnUoT/77FmHy/MKxD
   4S1460UT2LXUcG/AKQpVIFE9xhifDnAVuLSzoRNNrmU8X1fzXS0VjSE1S
   SXGy33A+d+cLsQsW2N4yEsF8Gu5DKCoyExFNjfIqt0ljB95dLpjTZFIIw
   w==;
IronPort-SDR: RAN5KZBkIIR/xSi/EqpUgG/GNMdOLnPE/t6INqYyAuQf4aJApSFRM/dwENsweu7DFdfq9yZmsx
 /0NaHJGPheJo7SH65orphD+hHwU7QqVjGCMNeWoKL687dc3kTYS8TLDHs+hAta+/r449OwrL2W
 oHdMkOp74C0siLV59uYxNm4+W/9dbwuML9mpWnngBDGEzGoJL5qq7zVSpBSNW4pAm4PBV/WMvN
 A/W5TLg86ni5F+uSZbHrdtJPdhtSj67wMvw34dCEPQaGFPYRhKkF4dG66nupGV6J5FUwWijOd9
 sac=
X-IronPort-AV: E=Sophos;i="5.81,196,1610380800"; 
   d="scan'208";a="164956417"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2021 13:30:26 +0800
IronPort-SDR: L+whU/pFMbFaB1SlOF1e70c7HME410K7tvY7u/iqiK/oU5JAHZQM1pC2Ow6foolYORtdeFYwgY
 pDxa3wsaHNw+1VeOb3BWcO8JYb6lReqJwfG4UJ+GTsXmxNRTVOy9u4KLyqLidLaD3MEWQfVxzO
 +pgEdTsj4Z1Dc8QX+EaQYMJP1ECTTPQtqkiKqrTj+lAZtdOeWYSGmCTMGA4rNE35HfL9w7xPOD
 RCDfde7d4I+qUEsIUKCForubwIKDseZEU+sb/RrNlP0FqQqs9bFn2ifygpbRziCPzYB+J8vehe
 acal9wRoaA0a+KNk2UzLrX8f
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 21:11:59 -0800
IronPort-SDR: 0wG0KxYggb6QzcYn9PRFlluAdCcTHTdazO7bHKOp/VSl96P9rVzxheiQrz4mEf/C7MLWc+wlAZ
 gdJPv7f7i/bBFtLqQZ4wsz9g50kPZ8xMJoxzlOAjxh+CnGFOsx2NNJtcMbSPWxJ6LlVpZiedWY
 gFMJCJ2AO1uWnIIEaC/FffDU1F0Uqt2kJ+ahpTeF9xx+eCN8xVPk+1xhX0Kf6SPsksei/8N9oj
 pzUFNnO3YyOfPgL3iVAS3vSGhp+UYQrPRuvRT+9nHxSqtRe56J5CMFVeCFQWzavN+Zvl1JT2a+
 SzE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Feb 2021 21:30:27 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, hare@suse.de, colyli@suse.de,
        tj@kernel.org, rdunlap@infradead.org, jack@suse.cz, hch@lst.de
Subject: [PATCH V3 3/5] blktrace: fix blk_rq_issue documentation
Date:   Sun, 21 Feb 2021 21:29:57 -0800
Message-Id: <20210222052959.23155-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
References: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit 881245dcff29 ("Add DocBook documentation for the block tracepoints.")
added the comment for blk_rq_issue() tracepoint. Remove the duplicate
word from the tracepoint documentation.

Fixes: 881245dcff29 ("Add DocBook documentation for the block tracepoints.")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/trace/events/block.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 879cba8bdfca..004cfe34ef37 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -196,7 +196,7 @@ DEFINE_EVENT(block_rq, block_rq_insert,
 
 /**
  * block_rq_issue - issue pending block IO request operation to device driver
- * @rq: block IO operation operation request
+ * @rq: block IO operation request
  *
  * Called when block operation request @rq from queue @q is sent to a
  * device driver for processing.
-- 
2.22.1

