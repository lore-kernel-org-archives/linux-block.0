Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857C7C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF97610FC
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhI0WF0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbhI0WFO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:05:14 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B7DC061211;
        Mon, 27 Sep 2021 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JRWTgzBcm05V8ySpKi+Sn387LcpeiWI92yzQrCXgXhI=; b=PkFreus+OyH9OhtirxXvpPHryN
        E3CEpDcIJqXTbwH3Nn7zTHGIkjKDat1oUO+HMwRsegJ2duFMKCfKasb2I9MihJGYzIiXTk/Cw0M0e
        b5T4RRN1axX1ux1NQ6NgGHkweaYtaGTypTFKKZQRZtidG1B8nU6kP9+r+9WcO2YTe+eGHiawDP7zl
        Qq9RUWwfCC+iOtqeQ0lN/NBnuK39zbbhd0dvQPCKlLTubtUH4UgqGgAClSsGqDUAqxnJpURKoqfjW
        8juL0YNksH3DHVxMmU/M/8H7Qq75bBYOF5IKUlLW5ofE4D0oVTcGWjt/EjLE1WtMBkLalM2XNOWY6
        Hsd20z5Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyhC-004UJI-DG; Mon, 27 Sep 2021 22:01:58 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bhelgaas@google.com, liushixin2@huawei.com,
        thunder.leizhen@huawei.com, lee.jones@linaro.org,
        geoff@infradead.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, jim@jtan.com, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, josh.h.morris@us.ibm.com,
        pjk1939@linux.ibm.com, tim@cyberelk.net, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 02/10] pktcdvd: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:01:49 -0700
Message-Id: <20210927220157.1069658-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220157.1069658-1-mcgrof@kernel.org>
References: <20210927220157.1069658-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

The out_mem2 error label already does what we need so
re-use that.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/pktcdvd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 0f26b2510a75..415248962e67 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2729,7 +2729,9 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	/* inherit events of the host device */
 	disk->events = pd->bdev->bd_disk->events;
 
-	add_disk(disk);
+	ret = add_disk(disk);
+	if (ret)
+		goto out_mem2;
 
 	pkt_sysfs_dev_new(pd);
 	pkt_debugfs_dev_new(pd);
-- 
2.30.2

