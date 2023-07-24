Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1CEC0015E
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 16:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjGXQyg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjGXQyf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 12:54:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F410F6
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fo891t+MRuPQ6hqtNNoXRls0WMaXaEefJnnr0O2/hDE=; b=t77oPWR7xbM1JPbK11oQp8uXr+
        tNUCxletgrisw9YU+H+/VU974ujGueouskQW5SDrdn4NuB7ptzILcuVkFKI94SatkS2z1yw4MiB7N
        2AYKtKCfE4pN6dLuW4NUNZd0fzy/VVR9+bC/cOYUtYg8PJTfEa3XONRiNZZ/3ec/g70dxzfHtatIE
        eT6gPxoXnrMSzXRgqNOhPKLSBhVP7Bqd8aGkQPj+Kbauv123pD2PhUwW25bYdkxjB5LFUs3esNPQa
        PXAZsOOCu/URwckGMf4n3W03j5GwzcZ4IfXKgUhpxOL5Tavf+W2mGsBOn4aiuFvg8T/YkkuhVvJMy
        Xwo2jebw==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNypN-004vu4-2X;
        Mon, 24 Jul 2023 16:54:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/8] block: use SECTOR_SHIFT bio_add_hw_page
Date:   Mon, 24 Jul 2023 09:54:27 -0700
Message-Id: <20230724165433.117645-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724165433.117645-1-hch@lst.de>
References: <20230724165433.117645-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the SECTOR_SHIFT magic constant instead of the magic number.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jinyoung Choi <j-young.choi@samsung.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 72488ecea47acf..445be4bdd99bdb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1007,7 +1007,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
-	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
+	if (((bio->bi_iter.bi_size + len) >> SECTOR_SHIFT) > max_sectors)
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-- 
2.39.2

