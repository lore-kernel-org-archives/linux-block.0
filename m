Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4FBC433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 03:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E634164FA3
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 03:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBEDwK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 22:52:10 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21807 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBEDwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 22:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612497129; x=1644033129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4d2sXcIVAfHu+kk27+0p4rEb0sVQNT6B5jFqgSBoXBo=;
  b=HGPB9sKoeggwXx4jep5YIhbr/0Gl7q5SJTTktGikRfId/EeS3Q0/4Kts
   jvlA4VGWIRRz2Os/LeSYz1iCL3JgikezKQRdVJxrKe0p/d72u/+mycAQi
   MbHCwXgxXLfP3ndfxmpvHX4ZSqiN9qzjoucmgOA1xC2EaRuQgSQhITx4/
   nunvIwVRK2LtJC/DzKCGiyGTkjePk++7U2TMcv27xmlj6YyaD+LpPRYOe
   NdIqdfGGTq+mH51LdrtCrWn/0H+a3wBI3EqbCsiAx4bhUZXgwe9zv9i87
   gV1Ey8vl17ldxm14U7+wILyq0VXoLvqdRHvrJ6t8zowLbVoAHzvHoRoJk
   Q==;
IronPort-SDR: wlS+2+aUQDIZBLPJ1Fz5flVPScM1FeA84pNRf6ccopsBxQVHASOBprgX4AhlV/QUNgzg8iXWQ3
 N4itxASRWfeRlUqGPNcHMtREyJ1NvBx2dxOzlUs7PaeRDuOiL1+9uZWCn6ISvo9AoyYqSF5N+I
 fwfXjNEVMhwi7WYxM7P9RxumxHpGGz6lC3Ra5q+ESArZBZxj3VRkKMOxRGMV+SyaFBJsLW6SAA
 Z0paQbMK4bxl5kg4oh474BBtG75ZUQHZ5z31ZFA0towYSvu06khuhE8HRa3tQF5EHvaomw+3PH
 Pe0=
X-IronPort-AV: E=Sophos;i="5.81,154,1610380800"; 
   d="scan'208";a="159196415"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 11:51:03 +0800
IronPort-SDR: MjKnLI2FsBBkm4YlS2dOuBEoeqMLrokoxZsUkifM7yKInBWAD0jgDfPkrPCYiuvrQl6b4SbnDI
 pK3txFkxJ8qyDtoBpWlGFfl9LXj+J0rjjKRVfTUYCc/m7+jljXhrFk0Fn0VbAs9MPonvLTH6U9
 +q6lkYy8MDo5NVit9I2fe4jBMGz+8y7ObgzAvqaEF5VYtnHX8HtwZsa7ZNKpzKm/4eHLmLg3dG
 Wfn8YyH5bh6akPUbvYJHRP5pXB3EvsF+Vd5tRON65/oLcWHSFlAjzR963Al/whJMj6hpBPZUE/
 ssZmXyQzJql30jn4NnZT9thQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 19:33:06 -0800
IronPort-SDR: gHmJyxL8vUOF34wEAfoLtW2cAfR99OY/evbJISIXVF8nxObZu3McLCoztkzWaRUs69CTtKotNO
 eXarYWW3UV1qwk6JiAtGDRVgoKj+nQQtycgnYi6SjgBw7flJYzmX/Kk3KxH6m4G917HWS1mR85
 zNaklBih0RUbvfG+TMUuWobjVoj3Np5bteDzwgNcN28TlzV6dXCeQUPAGyMOkB/MH8oxuG/WsM
 neOfz/gfom5esBWVErY4BavkqfGslZ/q/4p3Wxf3FjfNd20sHzAQKQuHfH+85VW+upA4rY50EO
 n+A=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 19:51:04 -0800
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
Subject: [PATCH V2 2/5] blktrace: add blk_fill_rwbs documentation comment
Date:   Thu,  4 Feb 2021 19:50:41 -0800
Message-Id: <20210205035044.5645-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
References: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
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

