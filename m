Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0993FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 13:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiA1NAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiA1NAj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 08:00:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9C4C061714
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 05:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=40Ln9gDPp3kPkgkvhK8rKN7ZrGwDo8dGmxn1bbHSx0c=; b=MiF2eG7i5lXZxTX3xWB3Hp3gdf
        K8S/W48IzL9fVdtTnFElYu9t6nis/QQmG3ZudqJj6F0bNArBu9N3poA9/iZ+7DaexlRL/2DyfTf5y
        ZT4MK40kDD5rcmHzSx6Zj+vkcvtLR9t9OvJ8uvMWJGvPZ45ClY4D4tdE7LX/iUGJrCml2syfxbohm
        EB7dSp549MUQtte+W7POaudCIxHu3HJP1L4NS4FjTVOUgAhz+FfVhKqshVEYLcz8Uy3hZH0UchLy0
        TY0cNFYY1fV/Ab5WQ86YWUQU3T9gfiWukTW4BxpqcjAHLuT8EIh17K3Oqb+79eELs+AmPB23O58rm
        qisgOIlg==;
Received: from [2001:4bb8:180:4c4c:73e:e8c7:4199:32d7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDQrj-0028vY-Qr; Fri, 28 Jan 2022 13:00:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 4/8] loop: only take lo_mutex for the last reference in lo_release
Date:   Fri, 28 Jan 2022 14:00:18 +0100
Message-Id: <20220128130022.1750906-5-hch@lst.de>
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
and thus protected by open_mutex.  Only take lo_mutex when lo_release
actually takes action for the final release.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/block/loop.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d3a7f281ce1b6..b58dc95f80d96 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1740,10 +1740,14 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 {
 	struct loop_device *lo = disk->private_data;
 
-	mutex_lock(&lo->lo_mutex);
-	if (atomic_dec_return(&lo->lo_refcnt))
-		goto out_unlock;
+	/*
+	 * Note: this requires disk->open_mutex to protect against races
+	 * with lo_open.
+	 */
+	if (!atomic_dec_and_test(&lo->lo_refcnt))
+		return;
 
+	mutex_lock(&lo->lo_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		if (lo->lo_state != Lo_bound)
 			goto out_unlock;
-- 
2.30.2

