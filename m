Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623BDC43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB9A20652
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etStToFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfFXQJO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:09:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37621 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfFXQJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 12:09:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so15081949qtk.4;
        Mon, 24 Jun 2019 09:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCpezpLtCB1J9Gal7ptkDlYgmZl63QGP8artZkviCDA=;
        b=etStToFOav+7bM42+SKEzJy5f/AScX04IseFYdc4Nm8Bc6tPADY2ROkboZShxOZLjN
         T5DdXgzO/yRsO+xQkDqieqB/h4rlLStssB/aRi/wU85Vfxq+IFthM7NCzmFQ1d0oFoVV
         cg6eRsMe06hlXqVAkY3UGhvqUAepoVpFRccv0sTdwRbOKbiaJw6NAv38m/fZqJP2i7b/
         xmDlMOYu15NiEKgYHiOL5Xadw/5yRbbQcjM7B3TEG1z+ajWNMP0n/TaCvdMPxvVkSeTq
         lde5OYPkrRzTq4hVwEbqeTNUbEnOKsCfKtUihWNY7x1iOrf4Ifwuvq9gDS2PGzdD+TXo
         6V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCpezpLtCB1J9Gal7ptkDlYgmZl63QGP8artZkviCDA=;
        b=mcupy2MT8K5mGwFkm8a1dvArNdbqRQiffRpPVquCUmzG8DQA8Bdh6uYw+vk3pCt/Ah
         9jYb1yEXbYOKyKmOj7ZVuf+0CVo0gj1bLKippYmWId+nmkO6Ad3reZ/nCXThkCICU//p
         DRiJjNEk3Bbd3u6KbHTOuAolGhYnUvrv/bgVt7FjRO9JvcasSKMLYpOQ7MjB7xqeyMsE
         b95OyM9U/AJnN73e9wDqQpnVkwC0DhJGQp2ex9yGpRolzsiYIWAOHtOTLiAvlC9dg8JH
         wUwXyL2CMJiRQcX5HtRfn7kLnaJarNwI6XGm4/TPzMnanZOoI4rZf1SRtj9XILa9Xx6U
         HxUA==
X-Gm-Message-State: APjAAAW0Q44iqQL53EeArg2XLnJGSBleFjAoex9Mpe9w1Ut2rQpDRInO
        OY9cPqZtPmwk8SDiD97Mr8+womT5TtI=
X-Google-Smtp-Source: APXvYqzmTaHXwZxuG+EwWxfqCNTumIMVXGVIF5v19QQPeIRAiB74jnqEp3jhXTw732c8NNyCSZ6QiQ==
X-Received: by 2002:ac8:253d:: with SMTP id 58mr32092359qtm.40.1561392552988;
        Mon, 24 Jun 2019 09:09:12 -0700 (PDT)
Received: from continental.prv.suse.net ([177.132.134.92])
        by smtp.gmail.com with ESMTPSA id f132sm5549791qke.88.2019.06.24.09.09.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 09:09:11 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:NETWORK BLOCK DEVICE (NBD)),
        nbd@other.debian.org (open list:NETWORK BLOCK DEVICE (NBD))
Subject: [PATCH] driver: block: nbd: Replace magic number 9 with SECTOR_SHIFT
Date:   Mon, 24 Jun 2019 13:09:33 -0300
Message-Id: <20190624160933.23148-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

set_capacity expects the disk size in sectors of 512 bytes, and changing
the magic number 9 to SECTOR_SHIFT clarifies this intent.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3a9bca3aa093..fd3bc061c600 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -288,7 +288,7 @@ static void nbd_size_update(struct nbd_device *nbd)
 	}
 	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
-	set_capacity(nbd->disk, config->bytesize >> 9);
+	set_capacity(nbd->disk, config->bytesize >> SECTOR_SHIFT);
 	if (bdev) {
 		if (bdev->bd_disk) {
 			bd_set_size(bdev, config->bytesize);
-- 
2.21.0

