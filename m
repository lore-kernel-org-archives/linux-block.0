Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4763C5518B
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC00206D4
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DypqFdLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDVHjx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726454AbgDVHjL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 03:39:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B3EC03C1A6;
        Wed, 22 Apr 2020 00:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3CgD7kZnnRJOUkHr7KSc3PD86gWCDQYdVaJYSXm6ZGo=; b=DypqFdLcVGl3eXDOt2DtTrk5+8
        h27qkI0VYxePsTGEjpHJG0YNs+y+IGs9B2Q5hqvrH2WJeXViQ/C7MfFHmvDjNvtQf62MTjKm/4V/d
        IFPPiD7Gr609bJefa7baZSucc+RhzTJN6NhCf3LFlZpwiBfHm61u+v2odUlY7dtuYxOnCGRNFQz+C
        c01cvmY+XdoCW5g5yEtHfEJ4dbR7DdT4h9lpo8uLVs7ECObGiyM6jHm8NhiA8VVpMZ6bgAPMhzr6O
        1VGj7sT217K074lvQhs+7vaZe60wdL4XpfouSUlQtxG7R0Qs5Kya18DxnZSuctF6cNTKcacKrr2WV
        sPrY48YQ==;
Received: from [2001:4bb8:191:e12c:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9yJ-0000AS-7q; Wed, 22 Apr 2020 07:39:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] bdi: add a ->dev_name field to struct backing_dev_info
Date:   Wed, 22 Apr 2020 09:38:46 +0200
Message-Id: <20200422073851.303714-5-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422073851.303714-1-hch@lst.de>
References: <20200422073851.303714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cache a copy of the name for the life time of the backing_dev_info
structure so that we can reference it even after unregistering.

Fixes: 68f23b89067f ("memcg: fix a crash in wb_workfn when a device disappears")
Reported-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/backing-dev-defs.h | 1 +
 mm/backing-dev.c                 | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 4fc87dee005a..2849bdbb3acb 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -220,6 +220,7 @@ struct backing_dev_info {
 	wait_queue_head_t wb_waitq;
 
 	struct device *dev;
+	char dev_name[64];
 	struct device *owner;
 
 	struct timer_list laptop_mode_wb_timer;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index c2c44c89ee5d..efc5b83acd2d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -938,7 +938,8 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	if (bdi->dev)	/* The driver needs to use separate queues per device */
 		return 0;
 
-	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
+	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
+	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
@@ -1047,7 +1048,7 @@ const char *bdi_dev_name(struct backing_dev_info *bdi)
 {
 	if (!bdi || !bdi->dev)
 		return bdi_unknown_name;
-	return dev_name(bdi->dev);
+	return bdi->dev_name;
 }
 EXPORT_SYMBOL_GPL(bdi_dev_name);
 
-- 
2.26.1

