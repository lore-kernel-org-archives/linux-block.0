Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE5DC64EC3
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 05:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjAaFBl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 00:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjAaFBj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 00:01:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A58241DF;
        Mon, 30 Jan 2023 21:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zUDyjWaGRtgYGdvYrnVq8nWDrZ+yfRpHok4S5KW+urg=; b=vyCtK2dO30DXQZldkQeVMGXe8Q
        WAta1+efMkMtiTpf7O+Z+RRXriDkFhYc3v73jQFUvEtUMTJ5aLGsnYCM8bUax3+nkFKfoXUPrHmyH
        Y6nn+arRohrLgsWjsCZ1Lyc7i3yZZ8Pb7VDcbzRoDaHOOu+6RiH2N6SxvcTNkL9gAcnK5kxdhSgLn
        b9JQ92lfT2bZA3nqASX3iNqSqLOjzxDnNyiNK4aGASHQs7btcri4MRuVzrgchkgrNAmI3PxEaei21
        Iy/9WeDIFt74JaAILzqyv+x62bVtxmS3Zey/Eq6uNLZF09GsSdw8XXRgtnW6fuwoHwBA3ljavnfge
        JyNRhN6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMilz-00B1Tq-Af; Tue, 31 Jan 2023 05:01:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] block: Remove mm.h from bvec.h
Date:   Tue, 31 Jan 2023 05:01:32 +0000
Message-Id: <20230131050132.2627124-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This was originally added for the definition of nth_page(), but we no
longer use nth_page() in this header, so we can drop the heavyweight
mm.h now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bvec.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 35c25dff651a..7939b345ee7f 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/limits.h>
 #include <linux/minmax.h>
-#include <linux/mm.h>
 #include <linux/types.h>
 
 struct page;
-- 
2.35.1

