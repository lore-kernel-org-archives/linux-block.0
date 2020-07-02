Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C735EC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71222088E
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dP0MTDkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGBIt0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgGBItZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:49:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9436EC08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 01:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/+bs9PLAAXK7prLaqGkUBN2MMIOC32HFr2vxtRpOOnE=; b=dP0MTDkN0D6tzNfpTfMqtRtBdY
        hfEE/KS2tt4XTuHhhxDikudPnyFrTG8+K3yYnN8NC3uJtT/v6hDidlWYca4DGVkY2RXFltCLy2tpH
        k1s402YCwH/SpH6SY/NGflqp6ftj45/s3hJJi2I8UvwaagT9JdtxdT2NEM83D7v9LhowG1Lyu9qEg
        PqcpXFU5BqbAAqilzgWsSn1hDNS7WZ1YKWZUe0oLCdNdLx1cnjFQKCmWHOEjLYERg+rj2jDu2/j6y
        S63F93tGbDv+s2rSErO162VT3swMXpcMC874IaHiTomSukMIkoANqHmZyq1zDNioev5fkecnypnhP
        AY99tLAg==;
Received: from [213.208.157.36] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jquuJ-0001Va-Aa; Thu, 02 Jul 2020 08:49:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: refactor bd_start_claiming
Date:   Thu,  2 Jul 2020 10:49:17 +0200
Message-Id: <20200702084919.3720275-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702084919.3720275-1-hch@lst.de>
References: <20200702084919.3720275-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the locking and assignment of bd_claiming from bd_start_claiming to
bd_prepare_to_claim.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 175161359664ca..1c9da1f08011b0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1015,19 +1015,14 @@ static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
 }
 
 /**
- * bd_prepare_to_claim - prepare to claim a block device
+ * bd_prepare_to_claim - claim a block device
  * @bdev: block device of interest
  * @whole: the whole device containing @bdev, may equal @bdev
  * @holder: holder trying to claim @bdev
  *
- * Prepare to claim @bdev.  This function fails if @bdev is already
- * claimed by another holder and waits if another claiming is in
- * progress.  This function doesn't actually claim.  On successful
- * return, the caller has ownership of bd_claiming and bd_holder[s].
- *
- * CONTEXT:
- * spin_lock(&bdev_lock).  Might release bdev_lock, sleep and regrab
- * it multiple times.
+ * Claim @bdev.  This function fails if @bdev is already claimed by another
+ * holder and waits if another claiming is in progress. return, the caller
+ * has ownership of bd_claiming and bd_holder[s].
  *
  * RETURNS:
  * 0 if @bdev can be claimed, -EBUSY otherwise.
@@ -1036,9 +1031,12 @@ static int bd_prepare_to_claim(struct block_device *bdev,
 			       struct block_device *whole, void *holder)
 {
 retry:
+	spin_lock(&bdev_lock);
 	/* if someone else claimed, fail */
-	if (!bd_may_claim(bdev, whole, holder))
+	if (!bd_may_claim(bdev, whole, holder)) {
+		spin_unlock(&bdev_lock);
 		return -EBUSY;
+	}
 
 	/* if claiming is already in progress, wait for it to finish */
 	if (whole->bd_claiming) {
@@ -1049,11 +1047,12 @@ static int bd_prepare_to_claim(struct block_device *bdev,
 		spin_unlock(&bdev_lock);
 		schedule();
 		finish_wait(wq, &wait);
-		spin_lock(&bdev_lock);
 		goto retry;
 	}
 
 	/* yay, all mine */
+	whole->bd_claiming = holder;
+	spin_unlock(&bdev_lock);
 	return 0;
 }
 
@@ -1134,19 +1133,13 @@ struct block_device *bd_start_claiming(struct block_device *bdev, void *holder)
 	if (!whole)
 		return ERR_PTR(-ENOMEM);
 
-	/* prepare to claim, if successful, mark claiming in progress */
-	spin_lock(&bdev_lock);
-
 	err = bd_prepare_to_claim(bdev, whole, holder);
-	if (err == 0) {
-		whole->bd_claiming = holder;
-		spin_unlock(&bdev_lock);
-		return whole;
-	} else {
-		spin_unlock(&bdev_lock);
+	if (err) {
 		bdput(whole);
 		return ERR_PTR(err);
 	}
+
+	return whole;
 }
 EXPORT_SYMBOL(bd_start_claiming);
 
-- 
2.26.2

