Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6702BC4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C00161051
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhHYQmz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhHYQmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 12:42:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A755C061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F65aCye5Zgky/rqbGwTTs59TxsS7/7gjLFX7TO/jgO0=; b=BIWOjr2orzbRJ5VeY0OHQHosSF
        Dk0KW5zKfKpsuaBW5O43pihR/Bhb/hHbD0s5JPn8CjZnrB8wiatgJyWT23HNrza09ZAB7/UZ80tm8
        IFMOhyDwrR/Wa3ChmqiXMhE5EO5+a2o1wkqqNSj+hfuGakjfV1La5RujRZKuVGApNKSDTJa04J8ZF
        FGPR95t+PgEMsXHlzsNTWRxMKLv//p8BQuzKJJYBnkbUbUmeITTHdgKIDxG78x2eeNc0Vfq6ij8S7
        wprjxXiTQKz9Aot4O5tAZO/au559jDI1jF+N5u9tbjz363L45h3WUenEJfsl9YvcSS7c826ilIvGo
        D+gXqMOA==;
Received: from [2001:4bb8:193:fd10:a3f9:5689:21a4:711f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIvwo-00CUDF-3t; Wed, 25 Aug 2021 16:40:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Xiubo Li <xiubli@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH 5/6] nbd: only return usable devices from nbd_find_unused
Date:   Wed, 25 Aug 2021 18:31:07 +0200
Message-Id: <20210825163108.50713-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825163108.50713-1-hch@lst.de>
References: <20210825163108.50713-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Device marked as NBD_DESTROY_ON_DISCONNECT can and should be skipped
given that they won't survive the disconnect.  So skip them and try
to grab a reference directly and just continue if the the devices
is being torn down or created and thus has a zero refcount.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 042af761d3a4..5c03f3eb3129 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1794,16 +1794,20 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	return ERR_PTR(err);
 }
 
-static struct nbd_device *nbd_find_unused(void)
+static struct nbd_device *nbd_find_get_unused(void)
 {
 	struct nbd_device *nbd;
 	int id;
 
 	lockdep_assert_held(&nbd_index_mutex);
 
-	idr_for_each_entry(&nbd_index_idr, nbd, id)
-		if (!refcount_read(&nbd->config_refs))
+	idr_for_each_entry(&nbd_index_idr, nbd, id) {
+		if (refcount_read(&nbd->config_refs) ||
+		    test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags))
+			continue;
+		if (refcount_inc_not_zero(&nbd->refs))
 			return nbd;
+	}
 
 	return NULL;
 }
@@ -1877,10 +1881,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 again:
 	mutex_lock(&nbd_index_mutex);
 	if (index == -1)
-		nbd = nbd_find_unused();
+		nbd = nbd_find_get_unused();
 	else
 		nbd = idr_find(&nbd_index_idr, index);
-	if (nbd) {
+	if (nbd && index != -1) {
 		if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
 		    test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) {
 			nbd->destroy_complete = &destroy_complete;
@@ -1893,8 +1897,6 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 
 		if (!refcount_inc_not_zero(&nbd->refs)) {
 			mutex_unlock(&nbd_index_mutex);
-			if (index == -1)
-				goto again;
 			pr_err("nbd: device at index %d is going down\n",
 				index);
 			return -EINVAL;
-- 
2.30.2

