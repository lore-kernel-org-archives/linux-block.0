Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F28C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2570364E94
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhBBFeG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:34:06 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42122 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhBBFeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612245180; x=1643781180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d0/IH7i+oVuHvN9VVrN5674v1nvrYU6Nas++JivtJic=;
  b=a36EthF0TZmW5nQVjuOBVooBKUszofVA060kXgdd7dr7Br4CJC0mH8q7
   5zA3IDWI0DFZikFnf6zUargA7KuTBTiJV+dXgqURTBEpnj7dObCOXDbHP
   qJBfN43stqYjCXZ/nVhliEdt8YCTVk9v5w+/Yn0ihIJk2Vv2DJ2ufuQBF
   mm/ARrh33NLU0yQyAZgNH7/KOdYaomhO5AwF1vE0JThZ42/x1UtWwKab9
   ppoScH58eJ8Jxtj61z6P867+bmFB2FdG7hJvG9P/w8lTinlEwwzt01IHB
   zlcTJsjhs3LgQSykwkV6ATTgQWTAP9KxcaMidgETMuUlfN2+S1+c4mWyF
   A==;
IronPort-SDR: eCduXhKtUNtFfA1jKfblivTKrv/8LqGJPMSqdwOyRUNdnhH7In+jrRZwUQKKlvkXqp/mU9jbrE
 rVsLFyWjkWsVgwk4n0nMFKGyHeYBtkhvu0dI2ve+V8/3Z4deBTLdGSqbWaGeZ862MrF9RWFQh4
 WlnZyJkfqAxRR/yfG1tirrsg4XyVZR5kNBjxEMBOwbg+YlXzEQvGY50Vj+b61JE76MRzB7ixMs
 /lz+/DpIpqJPNfba4wqbmbABP9kNY2fHe1JKJT4HC90IMHJPBWUBrqB0xn8rwIiJZHAdZVFN/L
 sI8=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="262961187"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:43:16 +0800
IronPort-SDR: 1qo3jULHQXVbX04Uz283hIOauCWFdzsnG0T6i9x7L+A/+dnVkfY5UEz62jc3pwAW1g9iUPu3MB
 Phobb78GVAfuOnzMY9E8kC5B7uOvko3hDRWo32Lqe0Qo33ih4Usqx7UQHPGOF55ByD7DZR6saS
 +qO44oyWaqil6ynC5MkTt8Eu9sk2w/DnlJAY4ypQJDm1J7HTClS19mmSDMeCMK8sHXAOjQ3JwK
 NHiajp8KNNMwUkBUvRSgualcss77wnEwdbD5q288uFNbbmEqNJdWx6mMbhHMy7nh2uTUYd95Nn
 /9xVFi/XHn6BDOq/VElkLVTa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:09:43 -0800
IronPort-SDR: 7d93h5+DpLuW8AYKCP2qkYr7b0TMlXKzOxInYd5vuzkpas/u2wLW8LmLFuCFBnKi5H5/lRvzga
 ftXULseFr9brYeLtjulc+UyZrc+3gjkKswxpg9g/DCPMd8vzNjGodgJ4V9tKFKOwIrigHncuAE
 BDCDaGQU8o1EEk9s3+7T5XihKQLxCiqRPdoNQfLyKcI8VYrnlLVV0A0tHniwTgMnSRkdisy1ng
 h1chiiHSv4UoNoyvCW+3NvHLCb5dxNTVvXkuie2BkqoY6ca9WygIbdwHC+W5zKBBg6iCympfwB
 7/Y=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:27:34 -0800
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
Subject: [PATCH 4/7] blktrace: fix blk_rq_merge documentation
Date:   Mon,  1 Feb 2021 21:25:41 -0800
Message-Id: <20210202052544.4108-13-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit f3bdc62fd82e ("blktrace: Provide event for request merging")
added the comment for blk_rq_merge() tracepoint. Remove the duplicate
word from the tracepoint documentation.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/trace/events/block.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 004cfe34ef37..cc5ab96a7471 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -210,7 +210,7 @@ DEFINE_EVENT(block_rq, block_rq_issue,
 
 /**
  * block_rq_merge - merge request with another one in the elevator
- * @rq: block IO operation operation request
+ * @rq: block IO operation request
  *
  * Called when block operation request @rq from queue @q is merged to another
  * request queued in the elevator.
-- 
2.22.1

