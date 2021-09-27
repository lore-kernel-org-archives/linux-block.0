Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDAFC43219
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC99B60EB6
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbhI0WHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbhI0WGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:41 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23639C05174E;
        Mon, 27 Sep 2021 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4imHp2CJ0meb7xhuvqWowaDJhq/kim8sGOgKxWzbOuY=; b=EuObWckMW3VBDLT2U6RXx8Gk8w
        DR0wABVa6MZv1QO6A3oasrM7ajQiMtGDJRFqDgs0PE+Or8nsKHrEHN731dApGgYJuowWvbTs7XIbQ
        TZUYlBv8AWzoidOOPSniYllbtPFF9TzncOW8vFC/4m9fzoQz7h2BQsLZigclq63MWwe24muyjzCUA
        R5m473v8VvCgkUT+gyob0kASVEQugCKnE4l2C2o/+lvbuI5XHov6FdnrgY3eas5IE5jbNYWodbLcZ
        XwbUkzYfIArl2E+OZTvNDvmbJX12cZI1aOUOcTu2/FfeVBa8BzfIYtH+IhxnQbktXw4uBR3krq52v
        SyCX1qfQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiG-004VJ3-91; Mon, 27 Sep 2021 22:03:04 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 14/14] block/ataflop: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:03:02 -0700
Message-Id: <20210927220302.1073499-15-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220302.1073499-1-mcgrof@kernel.org>
References: <20210927220302.1073499-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/ataflop.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index e9d874f51597..5dc9b3d32415 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2081,7 +2081,9 @@ static int __init atari_floppy_init (void)
 	for (i = 0; i < FD_MAX_UNITS; i++) {
 		unit[i].track = -1;
 		unit[i].flags = 0;
-		add_disk(unit[i].disk[0]);
+		ret = add_disk(unit[i].disk[0]);
+		if (ret)
+			goto err_out_dma;
 		unit[i].registered[0] = true;
 	}
 
@@ -2092,6 +2094,8 @@ static int __init atari_floppy_init (void)
 
 	return 0;
 
+err_out_dma:
+	atari_stram_free(DMABuffer);
 err:
 	while (--i >= 0)
 		atari_cleanup_floppy_disk(&unit[i]);
-- 
2.30.2

