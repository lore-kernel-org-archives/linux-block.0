Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7393AC43217
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 04:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358680AbiDTEbB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 00:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbiDTEbA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 00:31:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87282DE0;
        Tue, 19 Apr 2022 21:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FWpABD+wYsNJbTOYNRknLUaqgBYkljHxZCLKg/Ghs/k=; b=qVDpFHnA0++8zAeUACrsAqkpLM
        AsLLzUzFxeBBeMXuQaFLMtGXuAInVkXTCA6wD586JWcU1DNhi4Wz0IDIquCFWNU1GZq31ZhwXxhm3
        UlKZ/DZM7mFEA/Jnh4yriH7DlbkuQYDenS79lIVVcLMZ8X72WgqJU94629ntNN6L8AYwGIgGVbOJl
        aVJQAJX9tRZJFmC4oXSoZUyTZMhLujgu2gzr2dmrVFDcmRa+HesgW6AQ2/hpVY/k7zN+oxsV4m/Gj
        RDbVU/GqxWVwA23LhC0BO4za7A5zyut55+VywvUzTEwaCsYGaplIZ/VxF6/L/UHz8GU2dDdwxdmhN
        50p2p5pg==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wq-007Fj2-TI; Wed, 20 Apr 2022 04:28:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 15/15] kthread: unexport kthread_blkcg
Date:   Wed, 20 Apr 2022 06:27:23 +0200
Message-Id: <20220420042723.1010598-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
References: <20220420042723.1010598-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kthread_blkcg is only used by the built-in blk-cgroup code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/kthread.h | 4 ----
 kernel/kthread.c        | 1 -
 2 files changed, 5 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index de5d75bafd665..30e5bec81d2b6 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -222,9 +222,5 @@ void kthread_associate_blkcg(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *kthread_blkcg(void);
 #else
 static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
-static inline struct cgroup_subsys_state *kthread_blkcg(void)
-{
-	return NULL;
-}
 #endif
 #endif /* _LINUX_KTHREAD_H */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 50265f69a1354..544fd40974068 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1522,5 +1522,4 @@ struct cgroup_subsys_state *kthread_blkcg(void)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(kthread_blkcg);
 #endif
-- 
2.30.2

