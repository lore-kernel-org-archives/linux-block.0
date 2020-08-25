Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A29C433E5
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 04:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE8920737
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 04:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgHYE7L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:59:11 -0400
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:50258 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728666AbgHYE4y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 00:56:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E4F91100E7B40;
        Tue, 25 Aug 2020 04:56:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shoes50_100f5dc27059
X-Filterd-Recvd-Size: 1584
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:56:51 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/29] drbd: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:03 -0700
Message-Id: <1c8081264d82101d7837220c5ee221c307da5d91.1598331148.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/block/drbd/drbd_receiver.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 422363daa618..87f732fb5456 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -111,8 +111,10 @@ static struct page *page_chain_tail(struct page *page, int *len)
 {
 	struct page *tmp;
 	int i = 1;
-	while ((tmp = page_chain_next(page)))
-		++i, page = tmp;
+	while ((tmp = page_chain_next(page))) {
+		++i;
+		page = tmp;
+	}
 	if (len)
 		*len = i;
 	return page;
-- 
2.26.0

