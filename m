Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB31C43219
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 11:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiCCLfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiCCLez (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 06:34:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC393BA62;
        Thu,  3 Mar 2022 03:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pCNCWpfqsCcmh/mmv96Si48HeO0wpOZcENTc8oumegs=; b=kvC5S+L1QpodRlpumVDpJ03rIF
        jZDRiLRSozha86xGaSDDUjirEYs1OHF72dgaX7WF9HUqFmD8bIHJcNG81nUu4O/XneoV33Hn1X2hF
        dLYFY5kZm3lzcYkqI9jnNb/yNQ/GPsWsN3qjjPxYLjhMWtgcG87RYRV1gTilRc39M1ifCKkXl+ltQ
        DEPUXZBR+3RNGnzuCTAsoGn02qGnSVC9it6HnWtF9bkAAe7BINg1WYZa4yC7nPvKSgm+bosFHCvC5
        xQlSrbMgujouPiJcDcdQr/JSRQD56mzOMWUGI69bpEuJgBQXKSnnw6i7V6DBXcLRYLxBExneRfJ8n
        GA+dFzag==;
Received: from [91.93.38.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjhA-006DdN-4g; Thu, 03 Mar 2022 11:32:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Kees Cook <keescook@chromium.org>, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-security-module@vger.kernel.org
Subject: [PATCH 1/5] block: stop using bdevname in bdev_write_inode
Date:   Thu,  3 Mar 2022 14:32:19 +0300
Message-Id: <20220303113223.326220-2-hch@lst.de>
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
 block/bdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index a3632317c8aae..b4389f10ee7de 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -54,12 +54,10 @@ static void bdev_write_inode(struct block_device *bdev)
 	while (inode->i_state & I_DIRTY) {
 		spin_unlock(&inode->i_lock);
 		ret = write_inode_now(inode, true);
-		if (ret) {
-			char name[BDEVNAME_SIZE];
+		if (ret)
 			pr_warn_ratelimited("VFS: Dirty inode writeback failed "
-					    "for block device %s (err=%d).\n",
-					    bdevname(bdev, name), ret);
-		}
+					    "for block device %pg (err=%d).\n",
+					    bdev, ret);
 		spin_lock(&inode->i_lock);
 	}
 	spin_unlock(&inode->i_lock);
-- 
2.30.2

