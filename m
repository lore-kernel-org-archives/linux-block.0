Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F80E7AD6E
	for <linux-block@archiver.kernel.org>; Tue,  3 Oct 2023 15:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjJCPbU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Oct 2023 11:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjJCPbT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2023 11:31:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C084283
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/LG92AyoogL6wVS5Dlap2fK3Op49TorhbTYoOe3dNAA=; b=slbbNCPrrLxDFfP2ymPbcu2gXs
        U3GdfNwNDXKx0Xq+jgIZP2vRY0QDKNAEbJDJ9fQiz5vqg+lK8KZo+/o0xEGSdP2TtGPxx2Iz5M6uX
        hPmCKdRUivDjet12aOaKizZaSh2FTrRtWEYUhUe6n+4rsGYfBa1ErwcISg3cicRPd+YRjv+m4uPzc
        b9cYT2pgV80O/KVcbW0nhObUMMqsBvMPC7usHIX3Ak9/KHzs5bT4PDFuQnUNDet0NCSiwZGxGqwb0
        F3KISXUgEr0qgJXbX4YBL0jXtwQLoJcJtOpt9RbAVdTPXfk2KVkCgQuxtKE1IztsK0md/l+WXbof8
        qmHhCfMA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qnhMc-00Esl6-1k;
        Tue, 03 Oct 2023 15:31:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     w@uter.be, linux-block@vger.kernel.org, nbd@other.debian.org,
        Samuel Holland <samuel.holland@sifive.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl
Date:   Tue,  3 Oct 2023 17:31:06 +0200
Message-Id: <20231003153106.1331363-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mark_disk_dead is the proper interface to shut down a block
device, but it also makes the disk unusable forever.

nbd_clear_sock_ioctl on the other hand wants to shut down the file
system, but allow the block device to be used again when when connected
to another socket.  Switch nbd to use disk_force_media_change and
nbd_bdev_reset to go back to a behavior of the old __invalidate_device
call, with the added benefit of incrementing the device generation
as there is no guarantee the old content comes back when the device
is reconnected.

Reported-by: Samuel Holland <samuel.holland@sifive.com>
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 0c1c9a27ce90 ("nbd: call blk_mark_disk_dead in nbd_clear_sock_ioctl")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index df1cd0f718b81c..800f131222fc8f 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1436,8 +1436,9 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd)
 
 static void nbd_clear_sock_ioctl(struct nbd_device *nbd)
 {
-	blk_mark_disk_dead(nbd->disk);
 	nbd_clear_sock(nbd);
+	disk_force_media_change(nbd->disk);
+	nbd_bdev_reset(nbd);
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);
-- 
2.39.2

