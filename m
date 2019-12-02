Return-Path: <SRS0=iG2v=ZY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5399BC432C0
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 18:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280412073F
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575310936;
	bh=GM9x5oFD315ThqJdwgNwc9/W5+o4jD2xqsnfXr3DkqQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zQwf6Pv8+9bE7s9fCFOcNX60pzfErg00z+D3mZgdC5UmoJvogHdVsB/rRakdLpYSF
	 /6mJtxT0J1Qv2iXzNvQzd2jY+1JGuNmP4qqyB1t/SRbkW48jBfsMgIIYtCtRrMbPwo
	 ua/vRYYaooRiX4vIpN+ehUGysD+3j0JfiLISfhco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfLBSWP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:22:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbfLBSWP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Dec 2019 13:22:15 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9885A20718;
        Mon,  2 Dec 2019 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575310934;
        bh=GM9x5oFD315ThqJdwgNwc9/W5+o4jD2xqsnfXr3DkqQ=;
        h=From:To:Cc:Subject:Date:From;
        b=foXWy5F9W+QNZoHDNgM1wmWAh3R68egzgHWli6w18Jl/sUOZgg1G9kxDGGofc6+dt
         /T2p5oT+e68OcxnS0ofwuRwFJtnbfsMD7S9gfvQshay6nmmXQtjBwLu/9ZKTBf3RR4
         hEn192YI20efDh7amMMBRr3QQKdhU2iFLIWueKbU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH] block: don't send uevent for empty disk when not invalidating
Date:   Mon,  2 Dec 2019 10:21:34 -0800
Message-Id: <20191202182134.4004-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Commit 6917d0689993 ("block: merge invalidate_partitions into
rescan_partitions") caused a regression where systemd-udevd spins
forever using max CPU starting at boot time.

It's caused by a behavior change where a KOBJ_CHANGE uevent is now sent
in a case where previously it wasn't.

Restore the old behavior.

Fixes: 6917d0689993 ("block: merge invalidate_partitions into rescan_partitions")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index ee63c2732fa295..69bf2fb6f7cda0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1531,7 +1531,7 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 		ret = blk_add_partitions(disk, bdev);
 		if (ret == -EAGAIN)
 			goto rescan;
-	} else {
+	} else if (invalidate) {
 		/*
 		 * Tell userspace that the media / partition table may have
 		 * changed.
-- 
2.24.0.393.g34dc348eaf-goog

