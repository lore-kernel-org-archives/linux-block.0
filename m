Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977F8C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 08:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6307C206C0
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 08:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XyVbCwe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgD1IwL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726373AbgD1IwL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 04:52:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6232C03C1A9
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LQwzSd+Za7ttFGMG6L+ljm6ijNUnmW+Z0uTqoe0VQ2o=; b=XyVbCwe8DHJumiOawgXYuNV28s
        PzZQheASg6VgOuaCLofJf+5q8FF2F4FncxJZaF1dkk7KIV+BqGaCGruW8A5sTMuOmvAFSzuDc1HyV
        5X1dXG+XRHSbRYKI5Kyla6l4wLDwYYILiSUT25tEXkxlT0pgIw7ne5N9yrUdcBVcoAJerOJhxUOZx
        R1v5iyERYY1kZVhP1T1TbS+uf0EV7PQ7xtZiz7acDdBrc2PN3BtL843jjPhJkJXoiwTEJ8mtrvRrr
        +aFGA6opKfn9NvTkhC9/wQjxvi11JFubWelIJgzapAm7E4v+cy7Bhv4FWsp2F/7a+uR/UXBisQ/zF
        0wGK4oMw==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTLyH-0003MA-Iq; Tue, 28 Apr 2020 08:52:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     sandeen@sandeen.net, linux-block@vger.kernel.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] block: remove the bd_openers checks in blk_drop_partitions
Date:   Tue, 28 Apr 2020 10:52:03 +0200
Message-Id: <20200428085203.1852494-1-hch@lst.de>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When replacing the bd_super check with a bd_openers I followed a logical
conclusion, which turns out to be utterly wrong.  When a block device has
bd_super sets it has a mount file system on it (although not every
mounted file system sets bd_super), but that also implies it doesn't even
have partitions to start with.

So instead of trying to come up with a logical check for all openers,
just remove the check entirely.

Fixes: d3ef5536274f ("block: fix busy device checking in blk_drop_partitions")
Fixes: cb6b771b05c3 ("block: fix busy device checking in blk_drop_partitions again")
Reported-by: Michal Koutný <mkoutny@suse.com>
Reported-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index bc1ded1331b14..9ef48a8cff867 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -496,7 +496,7 @@ int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
 
 	if (!disk_part_scan_enabled(disk))
 		return 0;
-	if (bdev->bd_part_count || bdev->bd_openers > 1)
+	if (bdev->bd_part_count)
 		return -EBUSY;
 	res = invalidate_partition(disk, 0);
 	if (res)
-- 
2.26.1

