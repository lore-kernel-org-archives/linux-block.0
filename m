Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10770C5519F
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 18:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F32E22245
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 18:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ve5OBmSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgKNSMz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Nov 2020 13:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKNSMy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Nov 2020 13:12:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACF4C0613D1;
        Sat, 14 Nov 2020 10:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5Eexzr2a9Yf/fh6sHK18AOYOQ9Ow0gRnkkcLXSt5AXc=; b=Ve5OBmSQCIdrlcm6adCJMrZ0Ai
        g7NFyADO8YzKGJ9B5Oa0P5U42VBRVaMucfXHxvfd+oP3qBaEvse0VcwbgA51YWqD2/GQc4EWsdzid
        2pXmkk8/iIIgKERh9NY/T8zX+Rj+3Yp9LLD+rVMexwFUjtDY/8k2/xyDk8dUkMOUAISgbbmpbG++A
        VbxRqY3yC2g44RIYaUaEYJIBVgMdrTd4JEbg/aDTHKEixnDHLd2wPv2MGqNUig9WEW79Ywu5hgAgd
        yqChbkWdhSGErCCj4BAN9HzIuTTzjCqCLOsn6xGTMHeCZMCVdtIDjj1ODy6ZpIx/eVfIn4iKHeYig
        opMya+wQ==;
Received: from [2001:4bb8:180:6600:c0c4:d8af:ec59:797] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ke02a-0001uf-Oc; Sat, 14 Nov 2020 18:12:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     boris@bur.io, cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] blk-cgroup: fix a hd_struct leak in blkcg_fill_root_iostats
Date:   Sat, 14 Nov 2020 19:12:46 +0100
Message-Id: <20201114181246.107007-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

disk_get_part needs to be paired with a disk_put_part.

Fixes: ef45fe470e1 ("blk-cgroup: show global disk stats in root cgroup io.stat")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c68bdf58c9a6e1..54fbe1e80cc41a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -849,6 +849,7 @@ static void blkcg_fill_root_iostats(void)
 			blkg_iostat_set(&blkg->iostat.cur, &tmp);
 			u64_stats_update_end(&blkg->iostat.sync);
 		}
+		disk_put_part(part);
 	}
 }
 
-- 
2.28.0

