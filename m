Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727B4C2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 15:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiAZPvA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiAZPu7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 10:50:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E93C06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 07:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qKhz0X2dd6i6c7LeGK13mgBaFsVrZGCDY5syA5ZRQJ4=; b=UjiPaIKT++1j8knkybKJMTQ8jM
        bslE6dur9wbSwjl6fpp/bwhTU+5m2IXfbgZpPTCVGDFiJmEyDvhuND2QYFINR1nXJL0gwGfeJfBr9
        NDejxOAHSykOekiTFMKnHGITvM+uxv75cpyO3YsFGYhsIe2CieS1dZBqZEIlIv7iyoJPhDv+T4AcY
        K2MN9G62R35Nyd4q9ZVqYxKuPKVuWRNyuYk3+KizQh2adnjHFq5HSjorJMBsPhYpbJzY3adehLWzJ
        9POxmi4BcMaPpeAYM6wpBFZMmfdq9lQWoG6vA6g1FQoYARfFLRsT4dTRRAagCW7FCUnEog1hg+CAJ
        6MbEp2+w==;
Received: from [2001:4bb8:180:4c4c:c422:bb0a:5a5f:dce0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCkZU-00CQAQ-Ko; Wed, 26 Jan 2022 15:50:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/8] loop: only take lo_mutex for the first reference in lo_open
Date:   Wed, 26 Jan 2022 16:50:37 +0100
Message-Id: <20220126155040.1190842-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126155040.1190842-1-hch@lst.de>
References: <20220126155040.1190842-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

lo_refcnt is only incremented in lo_open and decremented in lo_release,
and thus protected by open_mutex.  Only take lo_mutex when lo_open is
called the first time, as only for the first open there is any affect
on the driver state (incremental opens on partitions don't end up in
lo_open at all already).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 43980ec69dfdd..4b0058a67c48e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1725,13 +1725,16 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
+	if (atomic_inc_return(&lo->lo_refcnt) > 1)
+		return 0;
+
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
-	if (lo->lo_state == Lo_deleting)
+	if (lo->lo_state == Lo_deleting) {
+		atomic_dec(&lo->lo_refcnt);
 		err = -ENXIO;
-	else
-		atomic_inc(&lo->lo_refcnt);
+	}
 	mutex_unlock(&lo->lo_mutex);
 	return err;
 }
-- 
2.30.2

