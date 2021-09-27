Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED7FC433FE
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC58A60EB6
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbhI0WEB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbhI0WDg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:03:36 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EAFC06127F;
        Mon, 27 Sep 2021 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GTqlLrZsj3Suk0ZD1zxrlS/P00ynG/BQTDmWUdhTXPM=; b=pZ75FiviARqXSmE5LIDqLZZHBc
        Df6eRurl8Nmk0UFJNmGWSDr7RWS8BGLcsRgHgu7zMKMlFEY40TMSBy4za1WmqcOQudbdRWnYv3JNR
        uxiE7y88AYxvBbosyU3OMbABdNr7z5XOGskwQ6Ic89l8o+vBoqRtpGxRaf/wpT8iVW+gzJ9F0iG+2
        DVQK4kQkcuDPQFldVywiQfEPJQrXA/2JNACdvPqfalrHhaqWVNolh2QcVriVKhjnrGEbV7O9thybr
        koXWQuGwkW2Fax82PYSPuXh1BHd+AABFPtQe+CFX0daPHhHbHYw+9hXAeY/9aIDZ9XdQ9Ot1jsngq
        pxMsNZnw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUygS-004TPm-Av; Mon, 27 Sep 2021 22:01:12 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 15/15] pd: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:01:10 -0700
Message-Id: <20210927220110.1066271-16-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
References: <20210927220110.1066271-1-mcgrof@kernel.org>
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
 drivers/block/paride/pd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 500b89a4bdaf..e59759bcf416 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -938,8 +938,12 @@ static int pd_probe_drive(struct pd_unit *disk, int autoprobe, int port,
 	if (ret)
 		goto put_disk;
 	set_capacity(disk->gd, disk->capacity);
-	add_disk(disk->gd);
+	ret = add_disk(disk->gd);
+	if (ret)
+		goto cleanup_disk;
 	return 0;
+cleanup_disk:
+	blk_cleanup_disk(disk->gd);
 put_disk:
 	put_disk(p);
 	disk->gd = NULL;
-- 
2.30.2

