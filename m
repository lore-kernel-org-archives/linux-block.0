Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F39C2BB85
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 16:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9BC2222D
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 16:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WFyjsN8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbgDPQzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730006AbgDPQzJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 12:55:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395BCC061A41;
        Thu, 16 Apr 2020 09:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dlyE334XNbXAO1yrRqKpTMtbtOYh3JOVxfUhLYXdrm0=; b=WFyjsN8tlQm87tPoVGyUxwi8H9
        MRHkuTd4V4Xb4J86Qvn4iSrN/r0V281EiemBS27fgpCgW58AN1Ri2yaEK7mzOBZgr8YEXLMRZmtcC
        hjZazg1DRKZh9M2vUHY0I8zixFl0UqlSXQCLfiQXZr2dSiV7OKYOxnEnZe+m4EDwXpNkkSuM0gmpA
        LYiQmExYV1SGpZyueldxnR8CalFkeyGT8rmkL5HLyJBPjRbsX/zz5AZciZOc8Fkw3Ed0Di9cWroxz
        NBpCi38vwtZiQaM73abXk17GNGwBllEiU8ImN5Qn47FGPCqxCECtp0oDV812jyjeOtfZSxycZOhMJ
        VPvjN6lg==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP7n0-0001xz-Gw; Thu, 16 Apr 2020 16:54:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] bdi: move bdi_dev_name out of line
Date:   Thu, 16 Apr 2020 18:54:46 +0200
Message-Id: <20200416165453.1080463-2-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416165453.1080463-1-hch@lst.de>
References: <20200416165453.1080463-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bdi_dev_name is not a fast path function, move it out of line.  This
prepares for using it from modular callers without having to export
an implementation detail like bdi_unknown_name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/backing-dev.h |  9 +--------
 mm/backing-dev.c            | 10 +++++++++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index f88197c1ffc2..c9ad5c3b7b4b 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -505,13 +505,6 @@ static inline int bdi_rw_congested(struct backing_dev_info *bdi)
 				  (1 << WB_async_congested));
 }
 
-extern const char *bdi_unknown_name;
-
-static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
-{
-	if (!bdi || !bdi->dev)
-		return bdi_unknown_name;
-	return dev_name(bdi->dev);
-}
+const char *bdi_dev_name(struct backing_dev_info *bdi);
 
 #endif	/* _LINUX_BACKING_DEV_H */
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index c81b4f3a7268..c2c44c89ee5d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -21,7 +21,7 @@ struct backing_dev_info noop_backing_dev_info = {
 EXPORT_SYMBOL_GPL(noop_backing_dev_info);
 
 static struct class *bdi_class;
-const char *bdi_unknown_name = "(unknown)";
+static const char *bdi_unknown_name = "(unknown)";
 
 /*
  * bdi_lock protects bdi_tree and updates to bdi_list. bdi_list has RCU
@@ -1043,6 +1043,14 @@ void bdi_put(struct backing_dev_info *bdi)
 }
 EXPORT_SYMBOL(bdi_put);
 
+const char *bdi_dev_name(struct backing_dev_info *bdi)
+{
+	if (!bdi || !bdi->dev)
+		return bdi_unknown_name;
+	return dev_name(bdi->dev);
+}
+EXPORT_SYMBOL_GPL(bdi_dev_name);
+
 static wait_queue_head_t congestion_wqh[2] = {
 		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[0]),
 		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[1])
-- 
2.25.1

