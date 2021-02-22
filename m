Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BE5C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 05:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789BD64E61
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 05:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBVFb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 00:31:29 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:31328 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhBVFb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 00:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613971887; x=1645507887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4d2sXcIVAfHu+kk27+0p4rEb0sVQNT6B5jFqgSBoXBo=;
  b=bOdAMv9z47SN+xcYawcCcaO1ae4fXEtzRWOPIH/PTk2d5BkP6fWQhdHj
   yE3mAfdsJAsPfVH9nV1yH8VdxnmAZkfXz5sH7moikPu4eTijn1+Dgo0H+
   a2sPOYqYTy2uV0ocEybPi5NxkBa8J8R6xa7olBQhsgFeFbqkTAVgkz551
   CBgKkYja6w5jU4kJsamtePEsBvPeKR/mRzLJpOuEzy8uHK+o8XUDljgqk
   5KGL8SdMioM3obvIXVurucuL/f2ot0m2oknr91t2ltXX5GWiZ0z7kB0cS
   AmbozAGLeJMnam4q6Re1iFFVBIeZxr8AMzhzNwasfllTJyxVFgaLfT/j8
   Q==;
IronPort-SDR: R0pMjUTLCb6TKHAuFi1YLSIc5iZLNBoabzxj9Wkm2wN9sOH/2Y1aAymnGuhuJpkbiPtzbN5gmX
 /cNWuiJq/s1J0t86jH9f5pbajExFU8Sms7nshsBdIiuL88pOxWbk09+gWNIy42yGfw/RMr1Yjm
 nJc/hl7+LaoFEXkND2w6hVL47xjHCDiadd24xppeQGE0e7hld5XdL5vr9z9msZwks3NuRyG+j8
 p0KyOjug/NPmj7Gn7a5sfi+iHu5bW9TNdBg/gZp9krpb41Q3jb/8IDzYOKG6vdd9AtOqs6kLJJ
 gLU=
X-IronPort-AV: E=Sophos;i="5.81,196,1610380800"; 
   d="scan'208";a="160464884"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2021 13:30:18 +0800
IronPort-SDR: jxC+l4ShtPO034WA6xr/k6/8fG6MLYNiUr/ua13cCG+GeV9ep8T1x7Mumolyts5JIZwyY95ose
 osLZTRf2pAi+vP+1yTEH2GXLh062cGOjQfNzn4HC2LsxsTE12rFP9UP7d1COGutfGyUbIZmaq1
 KriRd/WX9zQ4frn6TG7VmzNmKlhCC2vULXNcFC14fvOdYLFt+0VWwwjVx2J42KwidmSSIWBeYe
 jEz9LpObDYU4I0KKObKQcx+cVc1YCCGzUWLEEyLIJjqW1Uue1lOEAMhq7dwXBSNgsbl8Ud57Hn
 3Po7NG3q57FYmAFZqQFcsK8V
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 21:11:50 -0800
IronPort-SDR: Yz/3JUS1ZdZ13bIrJ2xj+nrbeVHBPUcXECiFHZbmtePAqrHbAkMESXFFskBXjst3BrQTPxqeR9
 WZkYqlw8C4L1FDtVimiCT3QnkrpYXbHOHgld6L7fiwxSXcTZ9EKYF8IYGtusmIkbRNM5cfJrfY
 tjptvt2oUUN08uUoNFvCUuid4ebcNZRP0lZ3ICZwqSM6Y2mGpw8/4nMDGJ/IOAW/VUxb72KAu3
 GQh8DjCqMMMC8F8RFB2i8TpCc3BrqfQmqbWLQRcaLp29wP8ecxP2AjJ/XSmUQh6EDxHJIoZ7RL
 dGI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Feb 2021 21:30:19 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, hare@suse.de, colyli@suse.de,
        tj@kernel.org, rdunlap@infradead.org, jack@suse.cz, hch@lst.de
Subject: [PATCH V3 2/5] blktrace: add blk_fill_rwbs documentation comment
Date:   Sun, 21 Feb 2021 21:29:56 -0800
Message-Id: <20210222052959.23155-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
References: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_fill_rwbs() is an expoted function, add kernel style documentation
comment.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blktrace_api.h |  2 +-
 kernel/trace/blktrace.c      | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 11484f1d19a1..e17d04abf6a3 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -119,7 +119,7 @@ struct compat_blk_user_trace_setup {
 
 #endif
 
-extern void blk_fill_rwbs(char *rwbs, unsigned int op);
+void blk_fill_rwbs(char *rwbs, unsigned int op);
 
 static inline sector_t blk_rq_trace_sector(struct request *rq)
 {
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8a2591c7aa41..d7ebef83771c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1867,6 +1867,16 @@ void blk_trace_remove_sysfs(struct device *dev)
 
 #ifdef CONFIG_EVENT_TRACING
 
+/**
+ * blk_fill_rwbs - Fill the buffer rwbs by mapping op to character string.
+ * @rwbs	buffer to be filled
+ * @op:		REQ_OP_XXX for the tracepoint
+ *
+ * Description:
+ *     Maps the REQ_OP_XXX to character and fills the buffer provided by the
+ *     caller with resulting string.
+ *
+ **/
 void blk_fill_rwbs(char *rwbs, unsigned int op)
 {
 	int i = 0;
-- 
2.22.1

