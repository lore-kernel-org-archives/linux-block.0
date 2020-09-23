Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B6FC4363D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 15:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BA321D43
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 15:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZqGSfaKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIWPHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWPHS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 11:07:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB88C0613CE
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8zKWAu6CeIU1WKwzKJ5UfrcUnrlilisubLtZJL3ffbM=; b=ZqGSfaKmNXmvV6IBNa1OCDmRoe
        17FBbVMlZYf3p8n+gidx8853yRXvVOvpDvzx/gPY2gcM1yDPy6g9a2DfLc5i3FFBZLbHvWU/C1bl3
        Z0Er+dbpAaybv69L9c+JOlTgItMdZcW0kI7dExymJsIprNDRl5nBSYyBAXM+aAxcUgAxX4MfN8iRz
        hzf5RGO7siElHRLURIxKsit9PA9bAoKCmxrWuFR7wt7hdSUrONkly0kHkjtGzRGI63DaSus2/LbLy
        J1+pYN+4L6miqlZrfgggL3+KD5giKwONjLNsE+WTIHslnceEKHOyIyhSCo36BdBlO/2GxDRrdIcpY
        JiTrLuoA==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kL6MU-0005dg-1B; Wed, 23 Sep 2020 15:07:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     mhartmay@linux.ibm.com, linux-block@vger.kernel.org
Subject: [PATCH] block: fix bmd->is_null_mapped initialization
Date:   Wed, 23 Sep 2020 17:07:13 +0200
Message-Id: <20200923150713.416286-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bmd is allocated using kmalloc in bio_alloc_map_data, so make sure
is_null_mapped is properly initialized to false for the !null_mapped
case.

Fixes: f3256075ba49 ("block: remove the BIO_NULL_MAPPED flag")
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index be118926ccf4e3..21630dccac628c 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -148,6 +148,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 	 * shortlived one.
 	 */
 	bmd->is_our_pages = !map_data;
+	bmd->is_null_mapped = (map_data && map_data->null_mapped);
 
 	nr_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
 	if (nr_pages > BIO_MAX_PAGES)
@@ -218,8 +219,6 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 	}
 
 	bio->bi_private = bmd;
-	if (map_data && map_data->null_mapped)
-		bmd->is_null_mapped = true;
 
 	bounce_bio = bio;
 	ret = blk_rq_append_bio(rq, &bounce_bio);
-- 
2.28.0

