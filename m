Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F90C0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 12:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E6D218AD
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 12:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q0g8D2/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGCMYg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:24:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCMYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 08:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aML2q990XHtkl05AtwDviUUtQJ0V5OOEMsL81IZZ0cU=; b=q0g8D2/bC+vw5KStUxTobwpC4
        WY+WSi3nqJw7b3FyyxpkhzhVIj5DzsFNHFI1L4s1+rcZlNi9AJ1ZtMK48wZfmUSLkFFeInJS3zVtj
        v871EXAsv2lO4Wg0O86DSiYB1J9G/5GgNWZazTzIQC8J0JkwE01SxTkxbDph1gIB3q84sjhUfTvn5
        pAZKoWiogXmy1GzgYxBHwr4Ax2RYgjQ1/MybVbLKEONRx4o59A8HlbUqtjrkGRF0tlI2nu+C2/2lm
        TAmS5IatjeQ6K20Sr41Yc8d1O8T/80kV4N0k/QnVgztRgQkGtgoPtnzcI10sIxJI84cbW78roLb43
        2ecpna5Ew==;
Received: from [12.46.110.2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hieJP-0002Wh-Jw; Wed, 03 Jul 2019 12:24:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: nr_phys_segments needs to be zero for REQ_OP_WRITE_ZEROES
Date:   Wed,  3 Jul 2019 05:24:35 -0700
Message-Id: <20190703122435.18255-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix a regression introduced when removing bi_phys_segments for Write Zeroes
requests, which need to have a segment count of zero, as they don't have a
payload.

Fixes: 14ccb66b3f58 ("block: remove the bi_phys_segments field in struct bio")
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index ca45eb51c669..57f7990b342d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -105,7 +105,7 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
 {
-	*nsegs = 1;
+	*nsegs = 0;
 
 	if (!q->limits.max_write_zeroes_sectors)
 		return NULL;
-- 
2.20.1

