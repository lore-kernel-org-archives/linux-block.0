Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55243EB64DC
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 09:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjGTJtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjGTJsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 05:48:19 -0400
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A6935B8
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 02:47:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQ3vuI5C6djnpQbCi1PW59Gj+FCebISZRVuxTvWKvqo=;
        b=w4MmY0D51B5mbGeKCwtzsoKhqXXNdLV/Jh+Z8f4ocFu4r2lgNM2FMx5joP6MZg61eMRcPe
        SWTBP0I8vkvNLPEK871eybgV69GeQS2Ltb1S/JfKkNAgDSRsA3dseXHhNnlHdXo/ewd8zK
        JY+lUtfuC2q3a1WZ9PWsuyHaW+deVy0=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 3/6] sbitmap: don't loop twice in find_next_zero_bit()
Date:   Thu, 20 Jul 2023 17:45:52 +0800
Message-ID: <20230720094555.1397621-4-chengming.zhou@linux.dev>
In-Reply-To: <20230720094555.1397621-1-chengming.zhou@linux.dev>
References: <20230720094555.1397621-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

__sbitmap_get_shallow() try to allocate a free bit with a limited depth,
which always wrap when finding a free bit in the word, even in the
round-robin case. So it seems we don't need strict round-robin here.

This way will loop twice in find_next_zero_bit() in the word, no point
in looping twice in find_next_zero_bit() if we don't want strict
round-robin for this case.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 lib/sbitmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index ccb96d1f92ba..0f3943bd3940 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -268,7 +268,9 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 	unsigned int index;
 
 	index = SB_NR_TO_INDEX(sb, alloc_hint);
-	alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
+
+	/* No point in looping twice in find_next_zero_bit() for this case. */
+	alloc_hint = 0;
 
 	return sbitmap_find_bit(sb, shallow_depth, index, alloc_hint, true);
 }
-- 
2.41.0

