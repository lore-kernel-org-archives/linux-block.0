Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BCBC4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 11:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiCCLfj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiCCLfR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 06:35:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912ED4D275;
        Thu,  3 Mar 2022 03:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=e5E6EFviE2jb4KRrMO1+wVe/laDvyFev6ciGNxnhDh0=; b=vOINOJ89TM7VKrAFoQ6zKrQSYD
        y8f3vQimMuYi+MPSUkluZHPK+MQ5tMzF25PIcTgklQuRhWvt0gDBkgHIMEVG8751TkDRWfPHEvTQl
        16zrTjYmxnD49Lyw0BeaZcpGJSiRYZGF1P1lDlXYgmBRK2v7YewC2HVZ2cIQAxLy9F5+B5peJPWbW
        36+8FOEoG5N5vB2OMvV2Md2NS+9dbt2Exjq34Qvg1g5IbOqo9wgmtpF/tvrwoRmZTVCf3mgiAsK8q
        IGNywHOYKEbTxJ88xO+OxadN9LCJpiv4hHcX9y9qIn6hEA3wJ6hGWMSfM1oigpRSzdTLHWqH8auE3
        oy1bU3/g==;
Received: from [91.93.38.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjhJ-006DeL-3U; Thu, 03 Mar 2022 11:32:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Kees Cook <keescook@chromium.org>, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-security-module@vger.kernel.org
Subject: [PATCH 3/5] block: stop using bdevname in drbd_report_io_error
Date:   Thu,  3 Mar 2022 14:32:21 +0300
Message-Id: <20220303113223.326220-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220303113223.326220-1-hch@lst.de>
References: <20220303113223.326220-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the %pg format specifier to save on stack consuption and code size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_req.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index c00ae8619519e..82a9adb7d55ce 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -511,16 +511,14 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 
 static void drbd_report_io_error(struct drbd_device *device, struct drbd_request *req)
 {
-        char b[BDEVNAME_SIZE];
-
 	if (!__ratelimit(&drbd_ratelimit_state))
 		return;
 
-	drbd_warn(device, "local %s IO error sector %llu+%u on %s\n",
+	drbd_warn(device, "local %s IO error sector %llu+%u on %pg\n",
 			(req->rq_state & RQ_WRITE) ? "WRITE" : "READ",
 			(unsigned long long)req->i.sector,
 			req->i.size >> 9,
-			bdevname(device->ldev->backing_bdev, b));
+			device->ldev->backing_bdev);
 }
 
 /* Helper for HANDED_OVER_TO_NETWORK.
-- 
2.30.2

