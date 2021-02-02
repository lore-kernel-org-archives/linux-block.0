Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D991C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C61664EDA
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhBBF1b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:27:31 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13882 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhBBF1X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612243643; x=1643779643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/yKFFxZIFPH4ommScjtAVEoptJgXEFRq8F+7i4VsxOI=;
  b=f4orAnxnXRupSZoiHnStvKswjo3hrocwnagCcsMe/QU05vlQqarecwQF
   Ak/IxRdEK8RSehVy/w10a+BkYw2Fk3uRcKbUzuRY2ThWquaHirvc/e3GR
   NRS6d1hzlWNZ959mq5P6IdDiQMKK1Xh2DL4ogPh/dcNhRvBl5wVv0iYMA
   LRNtWGR79Q6WMa3Hv4BTON1IROx/F4kya0bWEnS6PRpu9qe8eG1dhX2S3
   s1RQ/Te+z5LSPQR7QT2QDlQhFg9MIuzALG/y+dH3KuUxx0vBSA2Hw/nVs
   oUFKf4vAmdl62aQK8kgHOQQwZAUmqTqc7O0NRBX0baAIvyHVXXiHGxTrS
   A==;
IronPort-SDR: bWPu0AOfeKVOK2wQH9I4ZNMiqL4tDnmhHmUvGWTZZjWk26dP1QipvDEoHM1NWvDM6b0p7SNckJ
 SXHMM10aZwHdoHgSLNDhaSh9pRyJtssRqZcGSrSt2wG384V3x84kYzCTQeo0dtZEQkqAndP7FU
 9Q/wuID82SH/AP2zZI7SHqDATk2pxowu7Db/YPn6O2caiapYCBXnP0exWRyWyhUO5KcbIdHiOA
 iPBDtQMoJZRr9vBPEhBRoKuEUp4Wf8VgVQ2cGeCQVGJQQz1ndrR/p4yycgO+UhrylDNEMCAypZ
 O9g=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158884299"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:26:18 +0800
IronPort-SDR: YyntR9IJibbVgIV1mVlg8fMulMuhQWZBh3r+qig+mi3A0Zu6M5dGHH9oTpmPhqxDpFEo+C8s6i
 M/kp4C/8yPQwBf9yo2Uv4L6Yf5blGfi00iOp1Cafw9ufrHGGslGSngQmXFqi44hjpowafRlFmB
 ag4CLK10Rn22ydaWjZRlTGKhTz0TVqUZQXiBqv2JgYWgaWMN/iHCX78dx746WTrswZ6W8glhTd
 HuZ5BA8qZjPAwdeOnPM1T3zm7sXZov+WYg81ULwWM/8XB+dpiM31npQUYDnDTY4yomnzETQEDI
 hfM/Gouia13f5WxsYs9mtJhE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:10:27 -0800
IronPort-SDR: HQIKAYe7ZMeNrvb22D7JqTzM+Npk6/Lbj/bJ0dgIyjqN+/cHiHPS/E6/zxxJFthnRH+KGWaBST
 a1nMVwd4RSux8gGCtlKP5JULEUj/Ch8RtPsvEncUuZLlUMJCNo/Ejn0D90SEoAHWmR9gnymYmc
 fKKd3xuNcAKUK5rX+/rmM5CsOe5vOdy8GTJNBPDRMs2X4TsfReYN2I/PO8eowyepcPR+Mr8rga
 HJsH7uI24JoLKV5sl3KZn90mHGiRwSbH56Zv1IcLeIAwfHDqWC25wOhpboGzXyU+aMHcys8R1z
 Ucg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:26:18 -0800
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
Date:   Mon,  1 Feb 2021 21:25:32 -0800
Message-Id: <20210202052544.4108-4-chaitanya.kulkarni@wdc.com>
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

