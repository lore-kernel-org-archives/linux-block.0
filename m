Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E786BC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDD764E94
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBBFd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:33:27 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42122 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhBBFdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612245111; x=1643781111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dic+HnxA2At3onZOZ03Gimr1Nue7Lho32Ioi8MGn8ZA=;
  b=eds1kKwtPiA586V0RYezYEva2Nw86eBnpQWNBrNH5DKtz9X1z/ctASht
   Ej+Zmk5hQHTUa/biPHFUCHSGpLh71x7h1CuiD22QqttXmXSkfHEN6s9ki
   MVyzEtdKlGvOdT62b4Y7wO6oFJMTE2Da7Qb3WGUWfOKRzSrd95xgMEbBH
   QfCk5iTT4lJkVqThrrSsZS+SKznecjBzztEzetQfJJxb83WIVU8GuWhIM
   c1t6NSXvMqjqeeduNMhUP4CNGtuzpuBRarJDzsZa01Nby1njHjkcIzZl8
   pP5JXYOVqId77C5Dz1KtUQCFE6gFYCK+HwYZwFO0uuITPKl+uuN/bbbZr
   w==;
IronPort-SDR: +R/YqXslUDNQfCdXa0TJP5Ufdf5EmTeydtKw0/g4JATdPE81AbVtk7CVXrd39ERbo5Vl+0FXT3
 yDbO77tXmKAaJJDXcBLkJ5o1HtA7lUXbZWhqqSsduscxbHzNEtEoU6rbyUH7edulkTwRPH+HBz
 sC1zexPMIObTi9jdZ8cSwtxevcQ5Y6VsSh1roum61haZLkdP0LsFfulbNw8AJ4C+Re3l7tXDJZ
 eiTuIAONGX1bY8gH96emXwFqlHKyJlvwhe1RfTtk3h3T0NI7KSuIvjW9yLQuXIBSSaJeAuy88X
 Few=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="262961072"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:41:07 +0800
IronPort-SDR: hcUkR5BRLx9IpLKhOu7eA0bJCZwE+5eYkeZDgCfIiPDcXyKerD0XIF3icqiC+n2e6y0r+hcNYj
 YxtFl+R5mpmFZ312sTSpmX/QEskO5NR4UUAxeUetfbawTxmmNnKvIE1jp/QyN7EBGUkO12gO7t
 IsEgsg3Ins5JRQPguC6nR0ScSmOsxZv9ybhxHSxAKNUSVZXD5AvmiShPulweEooNQAWqYiRhTB
 SKyk4E8JJlJg1UYNTcA3aWYzrV3fMr1YzApLfhMOdGFg7QoidAYeEnktNmCSgZccP9zAV/pBeB
 EQVfxD6pipgJ2QklOPtGnSm9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:10:17 -0800
IronPort-SDR: Ike+Y8s0my+1O7dm1Z5gM3faq1CcqIKSvVjQWGpHzYcZJjh3beQMFPU6vr/i5+tghTL6yNpiEw
 WERdRewCtHFT0XEelqXgVcFg/d/7gf/GWYi8USa2QNVxUx5o7BMLoLeCq677gi/gggAjDms8Km
 l72Ldt5FJHzlwO4yZKszE35B/qi+BV7LvnwPK5sIHNFg7m2HDDw53pjJG+EOGXICOm9JnF63qN
 oLHE84mErGsZUlv+nVKERA34HpSy2xDsAuuUJ6dlj8+plQqs2HroOkrKPTkbcNKFRjhYo+8CSe
 13o=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:26:08 -0800
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
Date:   Mon,  1 Feb 2021 21:25:31 -0800
Message-Id: <20210202052544.4108-3-chaitanya.kulkarni@wdc.com>
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

