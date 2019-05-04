Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C46C43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6EE2084A
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 18:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="APmfL13e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfEDSkV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 14:40:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39103 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfEDSig (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 May 2019 14:38:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id q10so7855442ljc.6
        for <linux-block@vger.kernel.org>; Sat, 04 May 2019 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gj/yuGQs2NzUkZmqPY17o2QhTDN0kFaU7SFZqHnYJbI=;
        b=APmfL13e6+WIsIRju2Lorrwk8f++NLt92PVKF0smDJQlmVOCBxYtsUuMNoZi+tmrsl
         KwWHIx4oiG7mbBVhLV6oNx4TNOD3majLdjDO8MbTkAYweT5x2ZGt0c/wWHJEJDz5+xN3
         CZ7WD0Y7UVxxOlPso2UxB5TkE84g2zt6qY6PgdGWuIEWdWfUQsed1aAWP04rU4Cz4uVh
         WyTscCDhm4kf90uBTP3XLY4leeXXsxNAhf6tpDiwVV4DuS8C02d6QeqIFT0vORyJuSoq
         2JN1+HBuNFJjKMo5sdWT3B7Xls8MVrUK71k5i9SIFu8kc+SH92pFgD6Id70HjXT53+q0
         93rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gj/yuGQs2NzUkZmqPY17o2QhTDN0kFaU7SFZqHnYJbI=;
        b=Y5zu5J6v6K6p1/0b60Wvco8oUxnERIUuUq1F5g+WP5mJlM+IyF4n03SFrxgG3vpF5d
         47O7Mik3ozsEdBkaJkl4Qn5z+lxDjCdDXFdPkQbZ1g1K2Wj095cXr1U9R2ECBVc1ZtEe
         oGuCj8xfqe5fYr3a9jAg5dsi2Dsz5OcVB11ug0wRoTgGzvo6I5ig6CT4wR97QF5kN3I1
         0nk4pD+806nxlI8Zp3xVVjNLyfUXjVJHWBCNvsPJLxU3n69NEJSy0KOOAPBEHlG7BNym
         xliCGvAsddR8Mm9FzxnBivfCaXcfXgPgwbGepYPwmvCdRlAx3qQjI1yZJNYnaHt3Fn1m
         9UeQ==
X-Gm-Message-State: APjAAAUcY5Dn/XXdbEEWWeF3LAIWIqzh9zgLvU6CmOAid7cVRMUxPbRr
        LvxrH1qmgST0MYpX82wUEAxZXA==
X-Google-Smtp-Source: APXvYqybQkhDG2YODQje628BeV8Kwa8iZFZQs3CgscGeqrjhmj+Y/zwVrctXxkoZIYbabK+HfWCIiA==
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr7976733ljj.79.1556995113962;
        Sat, 04 May 2019 11:38:33 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:33 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 08/26] lightnvm: pblk: cleanly fail when there is not enough memory
Date:   Sat,  4 May 2019 20:37:53 +0200
Message-Id: <20190504183811.18725-9-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

L2P table can be huge in many cases, since it typically requires 1GB
of DRAM for 1TB of drive. When there is not enough memory available,
OOM killer turns on and kills random processes, which can be very
annoying for users.

This patch changes the flag for L2P table allocation on order to handle
this situation in more user friendly way.

GFP_KERNEL and __GPF_HIGHMEM are default flags used in parameterless
vmalloc() calls, so they are also keeped in that patch. Additionally
__GFP_NOWARN flag is added in order to hide very long dmesg warn in
case of the allocation failures. The most important flag introduced
in that patch is __GFP_RETRY_MAYFAIL, which would cause allocator
to try use free memory and if not available to drop caches, but not
to run OOM killer.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 81e8ed4d31ea..e0df3de1ce83 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -164,9 +164,14 @@ static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
 	int ret = 0;
 
 	map_size = pblk_trans_map_size(pblk);
-	pblk->trans_map = vmalloc(map_size);
-	if (!pblk->trans_map)
+	pblk->trans_map = __vmalloc(map_size, GFP_KERNEL | __GFP_NOWARN
+					| __GFP_RETRY_MAYFAIL | __GFP_HIGHMEM,
+					PAGE_KERNEL);
+	if (!pblk->trans_map) {
+		pblk_err(pblk, "failed to allocate L2P (need %zu of memory)\n",
+				map_size);
 		return -ENOMEM;
+	}
 
 	pblk_ppa_set_empty(&ppa);
 
-- 
2.19.1

