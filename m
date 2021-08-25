Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF72C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5BB61002
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhHYQiO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhHYQiO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 12:38:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F06C061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=L7GOW6bbWREAk67/0GlhVh0s9lBsMWcRXP4c/xXKmhk=; b=pPdTc5u/lOtSDhP8WFaj68iz5s
        l7hOnLhRBSBqov99WazEWoW1OyQNWku9KcetGbFfg++q0QAhlDaSMV+ZB9cIFcchJjpFiQXa4FelZ
        ZjTPkRnCs/NWJISLJKawI2+QDBJOfpracYCntNU3Jtp4PXZRcqEuooaz2A9F5+SDXd7H5qia55e5u
        p0nng/KAxctWIpuPFoqBXa5VkK7KfHsWragzWLrSrmHc7tTsmXhggUbZYRGOU1GRvCykyKx4hy5JZ
        phQrHeUJl71S6Kyt7pcPtVvVeRTmzkHvtFB3tJF7+ByttqE2wHFg/hDHfLCKHbLUMdIdRNGa50TGS
        EidW9I5w==;
Received: from [2001:4bb8:193:fd10:a3f9:5689:21a4:711f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIvsJ-00CTq0-Oq; Wed, 25 Aug 2021 16:36:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Xiubo Li <xiubli@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Hillf Danton <hdanton@sina.com>
Subject: [PATCH 2/6] nbd: reset NBD to NULL when restarting in nbd_genl_connect
Date:   Wed, 25 Aug 2021 18:31:04 +0200
Message-Id: <20210825163108.50713-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825163108.50713-1-hch@lst.de>
References: <20210825163108.50713-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When nbd_genl_connect restarts to wait for a disconnecting device, nbd
needs to be reset to NULL.  Do that by facoring out a helper to find
an unused device.

Fixes: 6177b56c96ff ("nbd: refactor device search and allocation in nbd_genl_connect")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2c63372a31dd..69971a47c36f 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1785,6 +1785,20 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	return ERR_PTR(err);
 }
 
+static struct nbd_device *nbd_find_unused(void)
+{
+	struct nbd_device *nbd;
+	int id;
+
+	lockdep_assert_held(&nbd_index_mutex);
+
+	idr_for_each_entry(&nbd_index_idr, nbd, id)
+		if (!refcount_read(&nbd->config_refs))
+			return nbd;
+
+	return NULL;
+}
+
 /* Netlink interface. */
 static const struct nla_policy nbd_attr_policy[NBD_ATTR_MAX + 1] = {
 	[NBD_ATTR_INDEX]		=	{ .type = NLA_U32 },
@@ -1832,7 +1846,7 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
 static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 {
 	DECLARE_COMPLETION_ONSTACK(destroy_complete);
-	struct nbd_device *nbd = NULL;
+	struct nbd_device *nbd;
 	struct nbd_config *config;
 	int index = -1;
 	int ret;
@@ -1853,20 +1867,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	}
 again:
 	mutex_lock(&nbd_index_mutex);
-	if (index == -1) {
-		struct nbd_device *tmp;
-		int id;
-
-		idr_for_each_entry(&nbd_index_idr, tmp, id) {
-			if (!refcount_read(&tmp->config_refs)) {
-				nbd = tmp;
-				break;
-			}
-		}
-	} else {
+	if (index == -1)
+		nbd = nbd_find_unused();
+	else
 		nbd = idr_find(&nbd_index_idr, index);
-	}
-
 	if (nbd) {
 		if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
 		    test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) {
-- 
2.30.2

