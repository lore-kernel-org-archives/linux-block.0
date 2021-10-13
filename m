Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0986C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84AA160724
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhJMRUE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbhJMRUE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:20:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9505C061746
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UF3SguvXUb7qSk9biJD4bmzRoQCQwhLERCmJ+QxyBaM=; b=Un/XEjgjSeXwRq9jRCVya+p351
        hSGMldScg5tEQfDk22gQTySb9z8TGNGdmFzDVTWOjdbYn5+2xk1eAFZFN35NpRar9HmK0K0oOoJhT
        r8xFJ0TP12oVYCmAOUZjbUrOBYYglBpRs7UphyVOepfEoIh7TwweXpG1Tyt+zXD+J4hJtNvLFZGN8
        nnriCADaxgl1tBo7ob7sn5gvS+4iTR4bJQG8gZ87FD0/HJl6uWTOeJEdx0WDS/1N0r4+OdDGE8JTW
        XcPnCMhRLvez07uBh7XQ7Ko++0RPAeNmDzjpAyT3SvI7hwQZiL+1R0ufVHL6hHmmy7GnkClG1vRAA
        Rq+dZjhg==;
Received: from [2001:4bb8:199:73c5:265:8549:750e:c7f7] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mahrv-007eYI-B3; Wed, 13 Oct 2021 17:17:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 4/6] block: open code blk_max_size_offset in blk_rq_get_max_sectors
Date:   Wed, 13 Oct 2021 19:12:13 +0200
Message-Id: <20211013171215.1177671-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013171215.1177671-1-hch@lst.de>
References: <20211013171215.1177671-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_rq_get_max_sectors always uses q->limits.chunk_sectors as the
chunk_sectors argument, and already checks for max_sectors through the
call to blk_queue_get_max_sectors.  That means much of
blk_max_size_offset is not needed and open coding it simplifies the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8ed50952e93ad..3e9dde152fdcd 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -605,8 +605,8 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 	    req_op(rq) == REQ_OP_DISCARD ||
 	    req_op(rq) == REQ_OP_SECURE_ERASE)
 		return max_sectors;
-
-	return min(max_sectors, blk_max_size_offset(q, offset, 0));
+	return min(max_sectors,
+		   blk_chunk_sectors_left(offset, q->limits.chunk_sectors));
 }
 
 static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
-- 
2.30.2

