Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56752C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F08A61058
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbhI0WGo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbhI0WGZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:25 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFEEC061BD2;
        Mon, 27 Sep 2021 15:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/Fh2lmOhLx61pNto8wOBpgjdx63cIFvAcZhSgHtAR7M=; b=SMP4FDNuOn/O76PIw9Hxc779Pr
        iDdXCBxk6gLk/dUFntCkLNkP0ZpcqBofBKl4UjEjpINecwY4PtBqOAkw2HTOtH8C1MZ602xTOqU8f
        e/SHxNUV7Wz2lm0xlo+mJzvxny0ZuMhNf2HNLDf78MdWRQitDWGM+cn4wtz54KlC55Yup08WGWWk5
        9f1VvBzkc2clsUB4UhqP/plRs8g0pEYbGH2PR/hiln7Xr3kC6FOHndG++BK9p+xWAgiDc3LUNryV+
        Ad5VZpDW7D6WF9fmfDTBKPqnoJKlZjY31dwfYohddywcdncZlVWeLgdfpXtaIBUfMBF4VcwMPRqmX
        DKrxowUA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiF-004VHs-CN; Mon, 27 Sep 2021 22:03:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 01/14] block/swim3: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:02:49 -0700
Message-Id: <20210927220302.1073499-2-mcgrof@kernel.org>
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
 drivers/block/swim3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 965af0a3e95b..f7e3482e846b 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1229,7 +1229,9 @@ static int swim3_attach(struct macio_dev *mdev,
 	disk->flags |= GENHD_FL_REMOVABLE;
 	sprintf(disk->disk_name, "fd%d", floppy_count);
 	set_capacity(disk, 2880);
-	add_disk(disk);
+	rc = add_disk(disk);
+	if (rc)
+		goto out_cleanup_disk;
 
 	disks[floppy_count++] = disk;
 	return 0;
-- 
2.30.2

