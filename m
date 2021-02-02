Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F333C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422B864E94
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhBBFcn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:32:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64769 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbhBBFck (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612243959; x=1643779959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/yKFFxZIFPH4ommScjtAVEoptJgXEFRq8F+7i4VsxOI=;
  b=GPje78c0InKRtVwnRLDuktZt+UlrXZhVKTMz+hY/HTp/XiSs+Or38NhO
   9ML/u0H4JUSYvWNSt6xpu6loweoVUNaV3ZapKR71M9//0caZxtOU0vnJR
   xfh7led26X+z48FIX9SaNH/dFpzHMq6gOHKcGB+Ans4oowWUPhOJqq7td
   SwpCkvDI0F/PYoXQVbIh0wmbi+PB6ynKd+ZlxmnEAnAkFZOlB1p4WQuNa
   nfBy1VHwRdIOULp/SYbRFcf3D6dYl6LBGD2//qPjeaSPJ8sKI4w/17I8h
   HTNiVryHktvGt4svr6Q8Cqldxqq8kV4vHMX5ceYOWgLvtRzaMfSWjjiF7
   w==;
IronPort-SDR: 0NyRxN6xUbrtwpkAOK1Ah11NkJr5ImhmeFPezx4QRMq72zYcemgFPD1Hm2nwueukBDnu2Q2VUT
 a9HbkFBGfj2j9495NJtyhfsNBP+5tUgIVyu0TLGG7+RCbG6hVtpkNAe639ZfadEd3ICIB3Q7x7
 E5qs1zhNS1PtWaRmePJJdTeIZUqG6/NFcZ0xkaQbNPOXr2NHOSKyc7XR2C++/Tsl5cDk361wUv
 Q7DmKWpKTBM2efIRUudi+aslbEVBVJy8Cp3wWbcQ0E5+s7PfVfcIvV/GWMDhPjvVJD78nqji73
 tko=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163333690"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:27:26 +0800
IronPort-SDR: U8tXSCCG+mzkQ0e5jUqG5qo1eE/HKDJBiqI3bSvKrEN93DZu0GZcKaKKskVE4OZzrWRkDtxH4V
 xcxT3lGXIfsmQeXLqkNSixbH1evSAWkjl26Aqd3pmWW4Qsk80KyP2qGNjBSIQh4uAYOTz1QDMj
 xxznVz1UCvrHUyL/dQBuLLarHJAbAlvKrgNiQQq5yySNcuHd8tkD0Fxt/+f6MMRUNytQXf87Ts
 A+rKtIfR4P17aow64Tl8fkzoSq+Ee0JxHRwwn4wLC1EHdc2v4h/9mdoHg0B6cDr4WakozR/nXH
 D+TCnzflqf1QhHLmSzOmdKf4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:09:35 -0800
IronPort-SDR: 5feJos1SrIRFz0U4AosIE5NytSw+a2rndtegz1GyIxMpm7bJCjvd3tAoCtgr5BexgXmd4YP9nq
 CACpUZ9LM85PkPy3B+cU3LPUm9b+vsz5KtWRUWdsD4AkfS9Jzce9dp8/ED4xrQBvhd7AGgHjNW
 XVczM3Nc+0VPZ9LB4gjx+hK1hj80ymVkvRXGmz48fLrFhOsWT0WUcvdQex4kpMpkwnABByyItv
 E/8k+8XRJ2G4C/ozy0MiFPR06fngZroupmEGXT1kLWVBdXGCInueZXhkEUg2rer4OMRG2nI9NW
 VFs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:27:26 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, aravind.ramesh@wdc.com,
        joshi.k@samsung.com, niklas.cassel@wdc.com, hare@suse.de,
        colyli@suse.de, tj@kernel.org, rdunlap@infradead.org, jack@suse.cz,
        hch@lst.de
Subject: [PATCH 3/7] blktrace: fix blk_rq_issue documentation
Date:   Mon,  1 Feb 2021 21:25:40 -0800
Message-Id: <20210202052544.4108-12-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit 881245dcff29 ("Add DocBook documentation for the block tracepoints.")
added the comment for blk_rq_issue() tracepoint. Remove the duplicate
word from the tracepoint documentation.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
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

