Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB67C433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 16:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiBBQBb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345635AbiBBQBb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 11:01:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D2FC06173B
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 08:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZdpH0Dvvs/Dm4a6IaYQGVHJPIYUa7UOvgcazFhG1ngc=; b=lhzpTxB744VOcjS8rHWtgoFU4Q
        /kQp+0VLvl+qM0+5RbwAwzyYznIsg6+aiJbarjmAoEsLLIkCZZ6nxKCTj2Dun4JL5NRd+PdMaQ6oJ
        He0hVLmC7Q6a7mh4zSxN+YLgJiKPZeiegAdtoztE9tH6TXwuHa6ldl/V0c7BQl86JzXotaQrGygbw
        4MzzMJkekmAk9oJdes4Tw2JGCLOIKG3zhJzXFrHL4EY/qTMYiRmx1p/NqGLBVuJQ727SDqMeZLxtz
        WiYWHibNG76P7Zpkvltyo1b3r0x0gpHVSC1+W5/1aIpllXmiS5hkmGas3E6EDrb8jsqv9g5p/O9Gd
        LXXCTi+w==;
Received: from [2001:4bb8:191:327d:b3e5:1ccd:eaac:6609] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFI4V-00G82n-L5; Wed, 02 Feb 2022 16:01:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 06/13] dm: pass the bio instead of tio to __map_bio
Date:   Wed,  2 Feb 2022 17:01:02 +0100
Message-Id: <20220202160109.108149-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This simplifies the callers a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 90341b7fa5809..a43d280e9bc54 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1117,11 +1117,11 @@ static noinline void __set_swap_bios_limit(struct mapped_device *md, int latch)
 	mutex_unlock(&md->swap_bios_lock);
 }
 
-static void __map_bio(struct dm_target_io *tio)
+static void __map_bio(struct bio *clone)
 {
+	struct dm_target_io *tio = clone_to_tio(clone);
 	int r;
 	sector_t sector;
-	struct bio *clone = &tio->clone;
 	struct dm_io *io = tio->io;
 	struct dm_target *ti = tio->ti;
 
@@ -1227,7 +1227,7 @@ static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
 	if (bio_integrity(bio))
 		bio_integrity_trim(clone);
 
-	__map_bio(tio);
+	__map_bio(clone);
 	return 0;
 free_tio:
 	free_tio(tio);
@@ -1283,11 +1283,9 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
 	alloc_multiple_bios(&blist, ci, ti, num_bios, len);
 
 	while ((clone = bio_list_pop(&blist))) {
-		struct dm_target_io *tio = clone_to_tio(clone);
-
 		if (len)
 			bio_setup_sector(clone, ci->sector, *len);
-		__map_bio(tio);
+		__map_bio(clone);
 	}
 }
 
-- 
2.30.2

