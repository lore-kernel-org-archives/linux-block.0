Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98338C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769FD61002
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbhHYQjm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbhHYQjl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 12:39:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C559C061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5NUzJdZ8nyTj2xk0B6C7gNl/dOwK748pl1vnltIU4Yk=; b=Qk/gTodJyba3ciDKQ2E/HGX10r
        85nHTqsIEJAoioElIz0vQQrUKhJZcXoTHZhQd5bfSxRm9R+DvIIfd68iFYLo/elrQBu3IexVHQcKC
        ceEStCsPTjaKdIeL1c8S+NSOVCBohVMMMOQhAl3TGmbfFumylNAu7Mv8qlAmAsqipTYtkl+HGFldx
        xTD2hsESfaUIoFBRnBljS6WuaR55NIwykIGNFxqWgRauOTddN0zBKWXxN1TcJJ2ccHDecx2puHK/0
        OGnbErdS7udPMwvjzcFkJdi+h11ylecur6RnUQCyvLbMUGiz9I71sxGaOAbYHzVZdVAYT/64ldCsv
        3nSCuQlQ==;
Received: from [2001:4bb8:193:fd10:a3f9:5689:21a4:711f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIvtm-00CTxQ-5N; Wed, 25 Aug 2021 16:37:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Xiubo Li <xiubli@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 3/6] nbd: prevent IDR lookups from finding partially initialized devices
Date:   Wed, 25 Aug 2021 18:31:05 +0200
Message-Id: <20210825163108.50713-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825163108.50713-1-hch@lst.de>
References: <20210825163108.50713-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

Previously nbd_index_mutex was held during whole add/remove/lookup
operations in order to guarantee that partially initialized devices are
not reachable via idr_find() or idr_for_each(). But now that partially
initialized devices become reachable as soon as idr_alloc() succeeds,
we need to skip partially initialized devices. Since it seems that
all functions use refcount_inc_not_zero(&nbd->refs) in order to skip
destroying devices, update nbd->refs from zero to non-zero as the last
step of device initialization in order to also skip partially initialized
devices.

Fixes: 6e4df4c64881 ("nbd: reduce the nbd_index_mutex scope")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
[hch: split from a larger patch, added comments]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 69971a47c36f..dfaa95df8d6c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1751,7 +1751,11 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 
 	mutex_init(&nbd->config_lock);
 	refcount_set(&nbd->config_refs, 0);
-	refcount_set(&nbd->refs, refs);
+	/*
+	 * Start out with a zero references to keep other threads from using
+	 * this device until it is fully initialized.
+	 */
+	refcount_set(&nbd->refs, 0);
 	INIT_LIST_HEAD(&nbd->list);
 	disk->major = NBD_MAJOR;
 
@@ -1770,6 +1774,11 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	disk->private_data = nbd;
 	sprintf(disk->disk_name, "nbd%d", index);
 	add_disk(disk);
+
+	/*
+	 * Now publish the device.
+	 */
+	refcount_set(&nbd->refs, refs);
 	nbd_total_devices++;
 	return nbd;
 
-- 
2.30.2

