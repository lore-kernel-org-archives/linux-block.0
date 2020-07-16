Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92245C433E3
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D298206F4
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ilqmhLBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgGPOdR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPOdR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 10:33:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A873C061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ogni89yUVV/gCuY4mF2UPPoyZIMVax7pm/2sFwwrfxI=; b=ilqmhLBtGSXmgbo97V457Mqw+x
        Sd9xq/e6IhvaSwiRlU0W9P3c6e/jDn3Cn74Dk0NSaeYrJBxLFM8tB1ua7mypsljFkWa75hjpaj89R
        trwqQjAoZGGnfOxLa4l8vfvOmst0k2+5A03Dkp16NkfwSR+qFYRqX2Iv4Oyx4lmETkMiuQ9mU9JlC
        NJbVeNscNkZCyBRjpjC3ysY45K7S7cqfGBBQkQuRBsXziP5YFJfjT34dZ0Nm4x9kordrUxAj7PnhW
        S4ZTDJKtvlni/FOKQRfPZKZud/ul8KCqbDYMJSVKy7yPkvan4tKSyDh/O+YmLS6zRaO5Wnm+ShvSQ
        SHjYijvw==;
Received: from [2001:4bb8:105:4a81:1bd9:4dba:216e:37b8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw4wk-0000C9-Kj; Thu, 16 Jul 2020 14:33:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: refactor bd_start_claiming
Date:   Thu, 16 Jul 2020 16:33:08 +0200
Message-Id: <20200716143310.473136-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716143310.473136-1-hch@lst.de>
References: <20200716143310.473136-1-hch@lst.de>
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
index 376832250c8e91..b7b2ee4b288ae9 100644
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
2.27.0

