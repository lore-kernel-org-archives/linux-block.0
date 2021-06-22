Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B4CC49EAB
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 17:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1860E61378
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 17:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhFVRrJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhFVRrH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 13:47:07 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF21C061756;
        Tue, 22 Jun 2021 10:44:50 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 5748B2E15B7;
        Tue, 22 Jun 2021 20:44:45 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id N7kVkD13qi-iiReSdmm;
        Tue, 22 Jun 2021 20:44:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1624383885; bh=2Zn8QKK4xousuCUlCWjAKT/AXeO6YfqAZ4AsRrA38Nc=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=YKFGLiSi8ENJoDVSMpuK24KOGvXK1grtMwTv94ubpQb2FSmgVu1fsXSEOLIT0aFnq
         uJ7jLO5CbItm85Ty+XBLBBgJTW2IzLSkKxS95BYrzFN2M89tPRcxOu/ML2gjC1wk+O
         DcHG9F4JHb9c/JNTJsNLyoFDFOV29vWxzCHtD6xE=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gVbf2yAtam-ii9m8cJW;
        Tue, 22 Jun 2021 20:44:44 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     willy@infradead.org
Cc:     dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, warwish@yandex-team.ru
Subject: [PATCH v2 01/10] drbd: reduce stack footprint in drbd_report_io_error()
Date:   Tue, 22 Jun 2021 20:44:15 +0300
Message-Id: <20210622174424.136960-2-warwish@yandex-team.ru>
In-Reply-To: <20210622174424.136960-1-warwish@yandex-team.ru>
References: <YLe9eDbG2c/rVjyu@casper.infradead.org>
 <20210622174424.136960-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Stack usage reduced (measured with allyesconfig):

./drivers/block/drbd/drbd_req.c drbd_report_io_error    200     72      -128

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 drivers/block/drbd/drbd_req.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 13beb98a7c5a..bd7265edf614 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -510,16 +510,14 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 
 static void drbd_report_io_error(struct drbd_device *device, struct drbd_request *req)
 {
-        char b[BDEVNAME_SIZE];
-
 	if (!__ratelimit(&drbd_ratelimit_state))
 		return;
 
-	drbd_warn(device, "local %s IO error sector %llu+%u on %s\n",
-			(req->rq_state & RQ_WRITE) ? "WRITE" : "READ",
-			(unsigned long long)req->i.sector,
-			req->i.size >> 9,
-			bdevname(device->ldev->backing_bdev, b));
+	drbd_warn(device, "local %s IO error sector %llu+%u on %pg\n",
+		  (req->rq_state & RQ_WRITE) ? "WRITE" : "READ",
+		  (unsigned long long)req->i.sector,
+		  req->i.size >> 9,
+		  device->ldev->backing_bdev);
 }
 
 /* Helper for HANDED_OVER_TO_NETWORK.
-- 
2.25.1

