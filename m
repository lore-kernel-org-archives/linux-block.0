Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC360C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE70E61027
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhHYQn6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbhHYQn6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 12:43:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C20C0613CF
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NlcZ0gDKD5494C/Zv3cmBbCH5hjShYV7uw5GYvnsZOQ=; b=MHeTNzP6eObKSZGJWpILX98C9m
        4Lwuh8CEDzM+Y365xmZNAbptgzAe5grnBxpnqI+skf7GFUMRBdAxOGmYQhxl/c2eJx0B/6FZb9sQU
        hjTgjPJHQ637801HgVn2IxA3lqsVdHnUra3J4Olp0gFHcvqWTc6geNf9086UnrTb5zzESLElWsa63
        LWDShrMSGaq8K7R5w1fJEWWe1iG9ChDFYpTQONzBsoeF06CKThuPQ0ht1PhYt5lwcjbzPsS02EcYv
        CUEBlJOWv0YiDAQE2w2clbMlSy4RZv1FLqthWeYLEn9n4oCcLGFQ3VZQ8u+VJ+fqAFzwSwPw46tHd
        M7iCUPcA==;
Received: from [2001:4bb8:193:fd10:a3f9:5689:21a4:711f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIvy6-00CUIz-Ln; Wed, 25 Aug 2021 16:42:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Xiubo Li <xiubli@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot+2c98885bcd769f56b6d6@syzkaller.appspotmail.com
Subject: [PATCH 6/6] nbd: remove nbd->destroy_complete
Date:   Wed, 25 Aug 2021 18:31:08 +0200
Message-Id: <20210825163108.50713-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825163108.50713-1-hch@lst.de>
References: <20210825163108.50713-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The nbd->destroy_complete pointer is not really needed.  For creating
a device without a specific index we now simplify skip devices marked
NBD_DESTROY_ON_DISCONNECT as there is not much point to reuse them.
For device creation with a specific index there is no real need to
treat the case of a requested but not finished disconnect different
than any other device that is being shutdown, i.e. we can just return
an error, as a slightly different race window would anyway.

Fixes: 6e4df4c64881 ("nbd: reduce the nbd_index_mutex scope")
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot+2c98885bcd769f56b6d6@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 52 ++++++++++++---------------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5c03f3eb3129..5170a630778d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -120,7 +120,6 @@ struct nbd_device {
 	struct task_struct *task_recv;
 	struct task_struct *task_setup;
 
-	struct completion *destroy_complete;
 	unsigned long flags;
 
 	char *backend;
@@ -235,19 +234,6 @@ static const struct device_attribute backend_attr = {
 	.show = backend_show,
 };
 
-/*
- * Place this in the last just before the nbd is freed to
- * make sure that the disk and the related kobject are also
- * totally removed to avoid duplicate creation of the same
- * one.
- */
-static void nbd_notify_destroy_completion(struct nbd_device *nbd)
-{
-	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
-	    nbd->destroy_complete)
-		complete(nbd->destroy_complete);
-}
-
 static void nbd_dev_remove(struct nbd_device *nbd)
 {
 	struct gendisk *disk = nbd->disk;
@@ -262,7 +248,6 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 	 */
 	mutex_lock(&nbd_index_mutex);
 	idr_remove(&nbd_index_idr, nbd->index);
-	nbd_notify_destroy_completion(nbd);
 	mutex_unlock(&nbd_index_mutex);
 
 	kfree(nbd);
@@ -1706,7 +1691,6 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 		BLK_MQ_F_BLOCKING;
 	nbd->tag_set.driver_data = nbd;
 	INIT_WORK(&nbd->remove_work, nbd_dev_remove_work);
-	nbd->destroy_complete = NULL;
 	nbd->backend = NULL;
 
 	err = blk_mq_alloc_tag_set(&nbd->tag_set);
@@ -1858,7 +1842,6 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
 
 static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 {
-	DECLARE_COMPLETION_ONSTACK(destroy_complete);
 	struct nbd_device *nbd;
 	struct nbd_config *config;
 	int index = -1;
@@ -1880,31 +1863,24 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	}
 again:
 	mutex_lock(&nbd_index_mutex);
-	if (index == -1)
+	if (index == -1) {
 		nbd = nbd_find_get_unused();
-	else
+	} else {
 		nbd = idr_find(&nbd_index_idr, index);
-	if (nbd && index != -1) {
-		if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
-		    test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) {
-			nbd->destroy_complete = &destroy_complete;
-			mutex_unlock(&nbd_index_mutex);
-
-			/* wait until the nbd device is completely destroyed */
-			wait_for_completion(&destroy_complete);
-			goto again;
-		}
-
-		if (!refcount_inc_not_zero(&nbd->refs)) {
-			mutex_unlock(&nbd_index_mutex);
-			pr_err("nbd: device at index %d is going down\n",
-				index);
-			return -EINVAL;
+		if (nbd) {
+			if ((test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
+			     test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) ||
+			    !refcount_inc_not_zero(&nbd->refs)) {
+				mutex_unlock(&nbd_index_mutex);
+				pr_err("nbd: device at index %d is going down\n",
+					index);
+				return -EINVAL;
+			}
 		}
-		mutex_unlock(&nbd_index_mutex);
-	} else {
-		mutex_unlock(&nbd_index_mutex);
+	}
+	mutex_unlock(&nbd_index_mutex);
 
+	if (!nbd) {
 		nbd = nbd_dev_add(index, 2);
 		if (IS_ERR(nbd)) {
 			pr_err("nbd: failed to add new device\n");
-- 
2.30.2

