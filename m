Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C9EC433F5
	for <linux-block@archiver.kernel.org>; Thu,  9 Dec 2021 06:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhLIGfM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbhLIGfM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 01:35:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB52C061746
        for <linux-block@vger.kernel.org>; Wed,  8 Dec 2021 22:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wZHE8St2dFNYE49zLSl0uhPwIAi3dd8UAEcC8B1YOl4=; b=rgfU7Ej+QLBplaOmAAcEd5lkn/
        GA3VcpSpR2VaPCBY/eH159QXyg4agqODuGIqgjTuS6x5QAiZbVljmh91Z8FcQMWXLY+4teySUL7fa
        87u+deR9kAX2Q6paGOfO+2j9Aaziq4DBttDmHggLCUKha2ZEEPnRAvE+iZTyhjrZMaCPTFvuvHfCP
        Ps42hxOp5AXDlwZl/KuEy+NAEcE9CpAUlrtmH04p98zuNnsACFPNGSqbE3blHrggokZOVRWmpkhP3
        E69FpA27MxEuE70Ap0pevZ9+iWuj0LeRGTTTDThYFJmgFauY9bx3E7964GS+9a4Bxn9boVA86VKTF
        Qz1Aywlg==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvCxq-0096Si-R0; Thu, 09 Dec 2021 06:31:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 02/11] block: simplify struct io_context refcounting
Date:   Thu,  9 Dec 2021 07:31:22 +0100
Message-Id: <20211209063131.18537-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063131.18537-1-hch@lst.de>
References: <20211209063131.18537-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't hold a reference to ->refcount for each active reference, but
just one for all active references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/blk-ioc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 96336c2134efa..9cde3906be3c6 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -180,10 +180,8 @@ static void put_io_context_active(struct io_context *ioc)
 {
 	struct io_cq *icq;
 
-	if (!atomic_dec_and_test(&ioc->active_ref)) {
-		put_io_context(ioc);
+	if (!atomic_dec_and_test(&ioc->active_ref))
 		return;
-	}
 
 	spin_lock_irq(&ioc->lock);
 	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
@@ -335,7 +333,6 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
 	 * Share io context with parent, if CLONE_IO is set
 	 */
 	if (clone_flags & CLONE_IO) {
-		atomic_long_inc(&ioc->refcount);
 		atomic_inc(&ioc->active_ref);
 		tsk->io_context = ioc;
 	} else if (ioprio_valid(ioc->ioprio)) {
-- 
2.30.2

