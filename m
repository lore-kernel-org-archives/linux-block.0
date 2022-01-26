Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE6DC2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 15:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiAZPu5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiAZPu5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 10:50:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D97C06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 07:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lAttBb6jzcoQiCN980ndkgL1pDdiW3XLywWeEkss3D4=; b=3J6vg4GpIEI8/5J1DL+d4Ufte7
        c5AC56tg+oME3NUBg3OcqQoZyx/xBgRGZFJ265AneTBVuu39g9aePbg1iLo0v6RGGkkmRwnRvAGiF
        7noYiaR4BEtlVC4IfVUxBvTECUcvnM8jGAGD3uSlaNOASI0Kt0fT/MjNY0ZTfEmMoVFyuqkoiOoJz
        kypiFFM9G61xuGXb0Qe6tS/DESOrx64s4KEXQhRzWWAvO02f7/a8o2UmD1dlFmArUU/4HmZAu5qCa
        AP+kwuGz0b+QDxDwflmEBUKo2uo85rkc8IuqixHeeUoaNEDN5KOuFYicZwBmzDav+o+GSu73qr/v1
        mR9KVO2A==;
Received: from [2001:4bb8:180:4c4c:c422:bb0a:5a5f:dce0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCkZS-00CQ99-0R; Wed, 26 Jan 2022 15:50:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/8] loop: only take lo_mutex for the last reference in lo_release
Date:   Wed, 26 Jan 2022 16:50:36 +0100
Message-Id: <20220126155040.1190842-5-hch@lst.de>
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
and thus protected by open_mutex.  Only take lo_mutex when lo_release
actually takes action for the final release.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d3a7f281ce1b6..43980ec69dfdd 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1740,10 +1740,10 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 {
 	struct loop_device *lo = disk->private_data;
 
-	mutex_lock(&lo->lo_mutex);
-	if (atomic_dec_return(&lo->lo_refcnt))
-		goto out_unlock;
+	if (!atomic_dec_and_test(&lo->lo_refcnt))
+		return;
 
+	mutex_lock(&lo->lo_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		if (lo->lo_state != Lo_bound)
 			goto out_unlock;
-- 
2.30.2

