Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC63EC433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 12:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614FB619B8
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 12:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhCWM4J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 08:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhCWMzk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 08:55:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D34619C2;
        Tue, 23 Mar 2021 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616504139;
        bh=g8c3uxdKrpmxUuNjoAwznCNrlaiTJm8qlDIHtTeQkSU=;
        h=From:To:Cc:Subject:Date:From;
        b=o2VP3Wx/3B3eoEDwF46on2ovZ3XGfrawww5w8h4d0KDXBJs2ru9QCwu8wpi2d35VP
         PtT/sx5g6U3jOANm029jo+nun/nKm6NYaP4MHUru+NfEjIXUv1xLLhcllDox6peI3q
         poQa7EHNsLHHkd8LmXNA+I8k7NcV5r5nONGo43RYYrBDfzLKgWs1DpDCq/UBAiq5JD
         zkFK5fKSS/nEBWI3gdbCJVnrnK3uSim9l5MqmKm2VKPgMYsWRs/0DYp5KgzvmVWgQJ
         DtwTYctG/8cJmjy5b49NEYIfqByo3wuthq2Jd+QblMyuMUupSPYoU4kexNJGkhwNgT
         ve0zmScPVDt/A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block/rnbd-clt: fix overlapping snprintf arguments
Date:   Tue, 23 Mar 2021 13:55:24 +0100
Message-Id: <20210323125535.1866249-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The -Wrestrict warning (disabled by default) points out undefined
behavior calling snprintf():

drivers/block/rnbd/rnbd-clt-sysfs.c: In function 'rnbd_clt_get_path_name':
drivers/block/rnbd/rnbd-clt-sysfs.c:486:8: error: 'snprintf' argument 4 overlaps destination object 'buf' [-Werror=restrict]
  486 |  ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
      |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/block/rnbd/rnbd-clt-sysfs.c:472:67: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
  472 | static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
      |                                                             ~~~~~~^~~

This can be simplified by using a single snprintf() to print the
whole buffer, avoiding the undefined behavior.

Fixes: 91f4acb2801c ("block/rnbd-clt: support mapping two devices with the same name from different servers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index d4aa6bfc9555..38251b749664 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -479,11 +479,7 @@ static int rnbd_clt_get_path_name(struct rnbd_clt_dev *dev, char *buf,
 	while ((s = strchr(pathname, '/')))
 		s[0] = '!';
 
-	ret = snprintf(buf, len, "%s", pathname);
-	if (ret >= len)
-		return -ENAMETOOLONG;
-
-	ret = snprintf(buf, len, "%s@%s", buf, dev->sess->sessname);
+	ret = snprintf(buf, len, "%s@%s", pathname, dev->sess->sessname);
 	if (ret >= len)
 		return -ENAMETOOLONG;
 
-- 
2.29.2

