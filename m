Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C616C4332D
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409A464EAC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhBBFdf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:33:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64769 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhBBFdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244002; x=1643780002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dic+HnxA2At3onZOZ03Gimr1Nue7Lho32Ioi8MGn8ZA=;
  b=Ncz4wGItnaMpV5lNolgUfuHP59JnTX31kgfevEjOfu9BZt12kU4QhOuo
   FCaH8DQZ952/6ICh1XoR40lVDW0Hx3ETq0FypYjzPYQwGwrdqYaQldAUg
   RteFNp5cAPOXagUT1o0YiX3GuThG0+/2NZpMueWK4uDNSKQh2DKkRQ1Zv
   +Mo6sBwVo+Q9ZsYvoseHdL2kCwd8t3c2Fa6lj5q09tDV64Gn8UqgZQtYK
   jTi5zZzbuNHO6JkQ4qoIMgMVJ/WrVfpHmMqHu16T1eysTsLGZcZu+lW86
   XjEQ3iUFwlxDWISWeeJaP1H2p1ycx649e6ewUo+pyDmAAl51ZL6Ptee34
   Q==;
IronPort-SDR: WFEEnVHL/EhSqNAAkwDWdZN/w+bbdTEjo4Pk4Pt5GoyB0+JZW5cWr2Bo6sX2ckZ4G7uVC8WWt3
 rHBRwJvjHSCDzqsUgirPRLyOlh6t5QpBSwJjSo6QyVOIjK7FD66DLUNtny+nTKzgKoQgdMiep5
 MYK3/icgbbYWb8AT0RXL2xFaKBeiaZw9YErolKj2zbaWbIO9U7Imw9RFFzrI8SD/pcMKQTp3kK
 GIo9lhBhacWAwonj+TSieE3ljvzofvoEhQoXnAeGd82E/UnZF7OBCR95HoboHJnOrV5CYKaa8S
 hw8=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163333683"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:27:18 +0800
IronPort-SDR: PRdwdGbSLwy61/oI919kAzE+0n/C4LlQN4AOdb2EOpoxh7YJrxCjWGxjrcLraFpNz7TlSpq18S
 MsJwhIWy6zZTf1TZES+kNv4hc/B2+TEsnUKGzXKCvqSA+4q7goCpUSnpSdctr2GNerEu9sQQTa
 Kpdw9CyTv70PJYQMGDPmca+m/Y1iPAMrMb7VETFfGhqOsLiJmBnhsacu797rvVJp6nsV0iG08H
 PmD8qEeh2hSfCCYeprfCcJzaJezHaLXBSfrReYbkoZ3JzOE2lKAADxgDmYR9/QiHTjwf01vnj+
 TzivwxKhopA/4ZJSwvOnwd58
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:11:27 -0800
IronPort-SDR: t+5vN+3M9yM9T662ivmMRGoNqpANt/fiwKbQ4CNuLJOvRydGt1s+mUpvq8N024jM0qW2OQlrg+
 MHF69Fy6qvKu80sAjjhQDFRyj79QLQl/RLzqmZtXbYQaQKyjaH01phOqRBtvEz/YOZMpapjeWf
 K0uUIfT7CBgRrDd0/PyrjkZZfWCLJvflNSrDbpcBKRqHmF7HdRypmy9lD7WZZJBxX8Pt8nv8Iv
 /n9dqb60rBRvkS/Z0LfeTYfjI9YyMAHZ8C1nzkhc9m9Hyr0UyMYj7iI4yVcJktQAsWDlM7M7yV
 hBQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:27:17 -0800
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
Subject: [PATCH 2/7] blktrace: add blk_fill_rwbs documentation comment
Date:   Mon,  1 Feb 2021 21:25:39 -0800
Message-Id: <20210202052544.4108-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_fill_rwbs() is an expoted function, add kernel style documentation
comment.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8a2591c7aa41..1a931afcf5c4 100644
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

