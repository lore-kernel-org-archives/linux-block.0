Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11368C7EE23
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 06:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbjEXGGM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 02:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239525AbjEXGGJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 02:06:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65E51B5
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 23:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/W2PorTvI4Tifm9yRZuhFGvQ0vIXYf/OFZzMOK9si0o=; b=tx3yF9x12O3wJklnYVUJMQluVT
        Va+T9xne0v9AkmGw211NOPzjuiVSsK6IXg8OeB1HPpt8uDOVd7sr5Qth7pE2evykmj2C4fz53Nk8Z
        p06Gz8Mcq+23J3SO1edaongZHRcTy6GOiXHPk1KZHJdZLOCGG97vMsOqMVrs3Upgc7j2eq3zEpvuG
        aq2gH3nLtMPonbQffDxRLbSarEz25uoNzwrO/imjuu42c6aFRM0O1zFYMFHln28B+Rf+nGmt6zeIB
        EF3efi0k8qXFAfsYI9a+eQBCQ2q92Xdi2019itSKLzYX2y3CE8sJXm5VkXyHW2wnWmtX09q0R+tEh
        d3m7v7MA==;
Received: from [2001:4bb8:188:23b2:cbb8:fcea:a637:5089] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1hcz-00CSjc-2a;
        Wed, 24 May 2023 06:05:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     minchan@kernel.org, senozhatsky@chromium.org,
        linux-block@vger.kernel.org,
        syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com
Subject: [PATCH] block: make bio_check_eod work for zero sized devices
Date:   Wed, 24 May 2023 08:05:38 +0200
Message-Id: <20230524060538.1593686-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the dawn of time bio_check_eod has a check for a non-zero size of
the device.  This doesn't really make any sense as we never want to send
I/O to a device that's been set to zero size, or never moved out of that.

I am a bit surprised we haven't caught this for a long time, but the
removal of the extra validation inside of zram caused syzbot to trip
over this issue recently.  I've added a Fixes tag for that commit, but
the issue really goes back way before git history.

Fixes: 9fe95babc742 ("zram: remove valid_io_request")
Reported-by: syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 00c74330fa92c2..1da77e7d628946 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -520,7 +520,7 @@ static inline int bio_check_eod(struct bio *bio)
 	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
 	unsigned int nr_sectors = bio_sectors(bio);
 
-	if (nr_sectors && maxsector &&
+	if (nr_sectors &&
 	    (nr_sectors > maxsector ||
 	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
 		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
-- 
2.39.2

