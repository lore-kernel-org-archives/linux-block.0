Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2BBC3DA7A
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 01:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiL3BJs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 20:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiL3BJr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 20:09:47 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB081178BC
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 17:09:44 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672362582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=616ci9PMTT0tjTOekGy8tLs59wrxFJNnobUgpAaykvw=;
        b=Xp2ho/0n1PEDxU+E3lzjVnArJbZkqW2mlzvkFQ3Va5UAzX8IsGwSX+gRYuno2us0MsEN3c
        Nh2qDWcj5ZcwlGgNqabTdwY/nnhtonLgYDDpgi/xReOgxkAwUzmZE/zdwLPSs0Oyo9ShXq
        O4ZYJSXlHlDNNWOhcOLOpPGE9fcfJBU=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk,
        christophe.jaillet@wanadoo.fr
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V2] block/rnbd-clt: fix wrong max ID in ida_alloc_max
Date:   Fri, 30 Dec 2022 09:09:26 +0800
Message-Id: <20221230010926.32243-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to pass 'end - 1' to ida_alloc_max after switch from
ida_simple_get to ida_alloc_max.

Otherwise smatch warns.

drivers/block/rnbd/rnbd-clt.c:1460 init_dev() error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?

Fixes: 24afc15dbe21 ("block/rnbd: Remove a useless mutex")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
V2 changes:
1. add parentheses around ‘-’ per lkp

 drivers/block/rnbd/rnbd-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 78334da74d8b..5eb8c7855970 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1440,7 +1440,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 		goto out_alloc;
 	}
 
-	ret = ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BITS),
+	ret = ida_alloc_max(&index_ida, (1 << (MINORBITS - RNBD_PART_BITS)) - 1,
 			    GFP_KERNEL);
 	if (ret < 0) {
 		pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",
-- 
2.35.3

