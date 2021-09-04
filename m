Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E89FC43219
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F1C61106
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350746AbhIDBgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 21:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350788AbhIDBgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFEAC0613D9;
        Fri,  3 Sep 2021 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=j1BgpbxfWBb8S5GPA1YHKp60xgsz7a/bFSDeN785DO8=; b=02m/oJRVVJ7UJDv269Dc6hGFLt
        RGD6O32C0b0JiHTdWZmHJbLqUWS4Dtq0ohkaDMZ5JxJ91wAUQlLFsv4p1DDb/+DbPM51wPoqXTRNV
        dLWAiOHciCUbQLyxV3YrluuQFGu2+hOYlBXirlPJydRnhf/pJFhIsV44Bn561DsYW+XQg9cYL7k3M
        8LI+icL8K9ic5leXgIZszD7FKM7s6fQpFq9sv0yW5ANZ80vpXh+4Rca+gO4dRbYyY8ucdYC9dPNqf
        Mfu30a/NAElfzZnL5KbpxfUu/KZj0GJ9zQp41xBdCjcpCQuP0KSUb1MCM44lwo56qgmm0Y0K4VW6A
        SJEBkMUg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLbJ-Kr; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 09/14] swim: add a floppy registration bool which triggers del_gendisk()
Date:   Fri,  3 Sep 2021 18:35:31 -0700
Message-Id: <20210904013536.3181237-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of calling del_gendisk() on exit alone, let's add
a registration bool to the floppy disk state, this way this can
be done on the shared caller, swim_cleanup_floppy_disk().

This will be more useful in subsequent patches. Right now, this
just shuffles functionality out to a helper in a safe way.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/swim.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 3deb9d9a59c0..b3ee3dad5a8c 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -184,6 +184,7 @@ struct floppy_state {
 
 	int		track;
 	int		ref_count;
+	bool registered;
 
 	struct gendisk *disk;
 	struct blk_mq_tag_set tag_set;
@@ -778,6 +779,9 @@ static void swim_cleanup_floppy_disk(struct floppy_state *fs)
 	if (!disk)
 		return;
 
+	if (fs->registered)
+		del_gendisk(fs->disk);
+
 	blk_cleanup_disk(disk);
 	blk_mq_free_tag_set(&fs->tag_set);
 }
@@ -839,6 +843,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 		swd->unit[drive].disk->private_data = &swd->unit[drive];
 		set_capacity(swd->unit[drive].disk, 2880);
 		add_disk(swd->unit[drive].disk);
+		swd->unit[drive].registered = true;
 	}
 
 	return 0;
@@ -915,10 +920,8 @@ static int swim_remove(struct platform_device *dev)
 	int drive;
 	struct resource *res;
 
-	for (drive = 0; drive < swd->floppy_count; drive++) {
-		del_gendisk(swd->unit[drive].disk);
+	for (drive = 0; drive < swd->floppy_count; drive++)
 		swim_cleanup_floppy_disk(&swd->unit[drive]);
-	}
 
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 
-- 
2.30.2

