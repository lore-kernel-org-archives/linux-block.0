Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD82C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 12:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhK3Mum (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 07:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhK3MuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 07:50:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4D6C061748
        for <linux-block@vger.kernel.org>; Tue, 30 Nov 2021 04:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NbgYne6q4541wB0r0paU4D08lIBCJKTKuAZf9zu2Hi0=; b=YgCyNzY9D//mbdgnWSGRrEuQUm
        l8rCMEeU8W8Kuha6QqDWXCxOyYD3SZj9xdZTzjFC6JK9f3/5Xc3qAOT3etGyl47W1XN1hmGeHFGkc
        uOTMgmuBfLFJxPTruMA90Q3ZB19j5bIf6MbwT9AEnfqZjH4ak8YZ9Mm/ZOAKwSovWnty7lhxwbxWL
        FaiXtusj0721ZqvPYib7veg4lSUVHcqZSDK/luWN1QOwgCHZxUeB+hhELQ0PXx4hnRVhLharYkqWP
        AQ1+EfbCTLQaF7vkYPnVp0WoV9cnF3xxNm04nopqsVv4FMRzemHn7uIwZXMQGr5ITF53JT/PXwXdj
        3kXGu0SA==;
Received: from [2001:4bb8:184:4a23:f08:7851:5d49:c683] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms2Wy-00CFb7-GU; Tue, 30 Nov 2021 12:46:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/7] block: simplify struct io_context refcounting
Date:   Tue, 30 Nov 2021 13:46:31 +0100
Message-Id: <20211130124636.2505904-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211130124636.2505904-1-hch@lst.de>
References: <20211130124636.2505904-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't hold a reference to ->refcount for each active reference, but
just one for all active references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

