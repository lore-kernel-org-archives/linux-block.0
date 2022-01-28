Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89D5C433FE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 13:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiA1NAu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237978AbiA1NAm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 08:00:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFD4C061714
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 05:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QN0jIFsrp8ko8wj9AqIVzq+uRa+idXWnDN8mNvLkSaA=; b=HbDufvgc6jKWNSjKudaLKhIsLu
        10o8m85Uj+2RppmMOlPaqCb1VJ2EK9uutySJjDkD5yJg0mavPFByiHs+v5+tc9KhC3gTFObQXjnGh
        wuBlGoArxcIhb7Pn7MjiJRZTgme1DgE8J589UzvfsR4xScjbEpoOhuxdJU/3B577L0P10OXlbymAw
        wTLh15YfAQkIV9YvoVLQO15FUwYCppI0vV1XND5+Otvr/rJ0nRQqE3fM9/OPuWqHu0b/BFAQNCca1
        i4KvoxR0OebDIKiaanNMFPmvP+A6K4qM0P/OBIxlzhvALe3yMmVxaWBvCXEZItrQUWZySzhqjTFLx
        o5wZ0fzw==;
Received: from [2001:4bb8:180:4c4c:73e:e8c7:4199:32d7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDQrm-0028wz-MM; Fri, 28 Jan 2022 13:00:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 5/8] loop: only take lo_mutex for the first reference in lo_open
Date:   Fri, 28 Jan 2022 14:00:19 +0100
Message-Id: <20220128130022.1750906-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128130022.1750906-1-hch@lst.de>
References: <20220128130022.1750906-1-hch@lst.de>
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
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/block/loop.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b58dc95f80d96..f349ddfc0e84a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1725,13 +1725,20 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
+	/*
+	 * Note: this requires disk->open_mutex to protect against races
+	 * with lo_release.
+	 */
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

