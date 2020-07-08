Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BD0C433E2
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 12:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3DA20720
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 12:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FvJ4nHy+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgGHMl6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:41:58 -0400
Received: from casper.infradead.org ([90.155.50.34]:34022 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgGHMl4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 08:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nCaWLKXo+tr/eEJ5CbH+6GpvCXBBLXFgjESqdoFH3tI=; b=FvJ4nHy+63Lc4RMGwVlRUdox0d
        YlekPZD8LYJe6Ih1OUzKrwioMvc3EBCIRgNTcqa7IBUnQUxmixBadyYV3MJwlxKaEWGbjq9K5JIpJ
        nHNMpxfjQR8plBv7w/Q67/CQHvXJymxziz8U7zPSFZJWTl63xZuUJ4T5GKBAJsZKu8+xIxeDLAeiM
        nnTUTCmVCyN9S7dq6I0h21Zr7dNkYdOQrVH+ccE5g8ilRES6fBmYUanRATFx9vXncd5Jc2sayMrQ9
        TmdVl2fuFZWOoc5onK3a+p9qpGIm2C6yxeKF3kx6q+3GM/Ls+geotoOKf6nPC84Iub1YwTEqZ8tcJ
        Pf15sI7w==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jt9OU-0002XX-Mu; Wed, 08 Jul 2020 12:41:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/6] mmc: remove the call to check_disk_change
Date:   Wed,  8 Jul 2020 14:25:46 +0200
Message-Id: <20200708122546.214579-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708122546.214579-1-hch@lst.de>
References: <20200708122546.214579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The mmc driver doesn't support event notifications, which means
that check_disk_change is a no-op.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/block.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4791c82f8f7c78..fa313b63413547 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -312,10 +312,7 @@ static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
 
 	mutex_lock(&block_mutex);
 	if (md) {
-		if (md->usage == 2)
-			check_disk_change(bdev);
 		ret = 0;
-
 		if ((mode & FMODE_WRITE) && md->read_only) {
 			mmc_blk_put(md);
 			ret = -EROFS;
-- 
2.26.2

