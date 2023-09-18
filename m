Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89AACD342D
	for <linux-block@archiver.kernel.org>; Mon, 18 Sep 2023 11:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbjIRLGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Sep 2023 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbjIRLF2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F632100;
        Mon, 18 Sep 2023 04:05:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8345921AB7;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5QLmYcyiXCClm9oSal5AbLNc763FLILvTTexvLDtfw=;
        b=ZCSXK1SLt/Lfx4XzX4fIMcBfywjX7G9r/cC/rhMFkS2ddSGBKQiUpRcMl8Tv7sPrABU6Op
        UuOKQXhBGtUQbJXz73R+SoeQZ67521Ul/PbZUrTMZqByZQzG0HvQ3R+Z1Q/flgYr+rd7ov
        hCZwuvcyKVojvz0yjjEvdQWmxa1fdes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5QLmYcyiXCClm9oSal5AbLNc763FLILvTTexvLDtfw=;
        b=oiwuijSI3YH9IQAqPcKjx+5SZRpDIArylIaQqai6E/s3AiIYrBFa7aXAqocgcMGO7J6qtf
        g8lQh1Dlf3sDVPAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6D48D2C161;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 79D7751CD161; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/18] nvme: enable logical block size > PAGE_SIZE
Date:   Mon, 18 Sep 2023 13:05:10 +0200
Message-Id: <20230918110510.66470-19-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918110510.66470-1-hare@suse.de>
References: <20230918110510.66470-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

Don't set the capacity to zero for when logical block size > PAGE_SIZE
as the block device with iomap aops support allocating block cache with
a minimum folio order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a01b79148c..e72f1b1ee27a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1889,7 +1889,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 * The block layer can't support LBA sizes larger than the page size
 	 * yet, so catch this early and don't allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
+	if ((ns->lba_shift > PAGE_SHIFT) && IS_ENABLED(CONFIG_BUFFER_HEAD)) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
-- 
2.35.3

