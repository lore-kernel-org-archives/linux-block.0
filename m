Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795F3CDB474
	for <linux-block@archiver.kernel.org>; Tue, 17 Oct 2023 18:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjJQSsr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 14:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJQSsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 14:48:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D681F9F;
        Tue, 17 Oct 2023 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0KHrNOLeXAvlCnl+foXim6n8WJn/OE532LLlnYjnot4=; b=4nI0BtNm3eNIytc+Qk8UvPefiD
        m2SL10YJP1ysHbUiCmaDNw55Ke4ElvXfBNHuNQ+K2if1zo2pUGEMvRNLeKVA7gKtOePX/+Lx73nIG
        NLKzyfIqF1+6hnHUx5YHsYthFX8quKCo9D7WpWGWZrdQKwMbtkC3Hm/i7vuY9SSrJ9RUSZrdZ/SaR
        odEfsdGbr2Zey3hzfYSI7DEs+j1tQ27u14PqoonJ6K+435avBxBFh5orHu3kdO0Geec5fXeuZ3+Xe
        3xwlMeoXx/UELjlC/vmjzVvmFReztMA90TY1cWPhf5VzuXWZ1+4St/2nZUjLaa4svbC4rAqbqa+A6
        WiySBblQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsp7R-00D0M3-2w;
        Tue, 17 Oct 2023 18:48:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] fs: assert that open_mutex isn't held over holder ops
Date:   Tue, 17 Oct 2023 20:48:23 +0200
Message-Id: <20231017184823.1383356-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017184823.1383356-1-hch@lst.de>
References: <20231017184823.1383356-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

With recent block level changes we should never be in a situation where
we hold disk->open_mutex when calling into these helpers. So assert that
in the code.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 26b96191e9b3ca..ce54cfcecaa156 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1443,6 +1443,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 
 	/* bd_holder_lock ensures that the sb isn't freed */
 	lockdep_assert_held(&bdev->bd_holder_lock);
+	lockdep_assert_not_held(&bdev->bd_disk->open_mutex);
 
 	if (!super_lock_shared_active(sb))
 		return;
@@ -1462,6 +1463,7 @@ static void fs_bdev_sync(struct block_device *bdev)
 	struct super_block *sb = bdev->bd_holder;
 
 	lockdep_assert_held(&bdev->bd_holder_lock);
+	lockdep_assert_not_held(&bdev->bd_disk->open_mutex);
 
 	if (!super_lock_shared_active(sb))
 		return;
-- 
2.39.2

