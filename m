Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959A9C433F5
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 11:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiCCLfk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiCCLfT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 06:35:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6535BE40;
        Thu,  3 Mar 2022 03:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2e8X21nKPcQgvz9UXWL0zk5b2nxs/yzM+chK1IEMLUc=; b=OLRzNYV4Ywf1h8kqedT00LxQVD
        X3ccleUWQ3cc1n7C+d5Au8bNFvD33QHhEVal4gYk/Q5pOt2w+fC8kJevtk0Z1RmX3OnR0R+C3nurK
        gvynpABsGjCB6TvdMheGhVfFYteaKmvD+0bTioKa5+KRtFQfyuAKpBw3gSIkVQneRwYZBXMkHwJBA
        vF2m2axLl4lvnpcE2tsi8cJo0MbzN5lRE8Q3roRvL0zcmQC6LD2aqmQMESpkwheTsyEingOs90nZT
        r6r7AGrt+xp+F5lHa/+viaYTs5B1Dx1qb/WWOAPCClRpWgBTgE5erzZaDixSV+7HeBZetSBrF0Yxi
        99WGy6+w==;
Received: from [91.93.38.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjhR-006Dfo-AN; Thu, 03 Mar 2022 11:32:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Kees Cook <keescook@chromium.org>, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-security-module@vger.kernel.org
Subject: [PATCH 5/5] loadpin: stop using bdevname
Date:   Thu,  3 Mar 2022 14:32:23 +0300
Message-Id: <20220303113223.326220-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220303113223.326220-1-hch@lst.de>
References: <20220303113223.326220-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the %pg format specifier to save on stack consuption and code size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 security/loadpin/loadpin.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e3..ad4e6756c0386 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -78,11 +78,8 @@ static void check_pinning_enforcement(struct super_block *mnt_sb)
 	 * device, allow sysctl to change modes for testing.
 	 */
 	if (mnt_sb->s_bdev) {
-		char bdev[BDEVNAME_SIZE];
-
 		ro = bdev_read_only(mnt_sb->s_bdev);
-		bdevname(mnt_sb->s_bdev, bdev);
-		pr_info("%s (%u:%u): %s\n", bdev,
+		pr_info("%pg (%u:%u): %s\n", mnt_sb->s_bdev,
 			MAJOR(mnt_sb->s_bdev->bd_dev),
 			MINOR(mnt_sb->s_bdev->bd_dev),
 			ro ? "read-only" : "writable");
-- 
2.30.2

