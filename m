Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4533C11F68
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 11:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925DE61C72
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 11:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhGFLTs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 07:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232566AbhGFLSd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 07:18:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 466D261C73;
        Tue,  6 Jul 2021 11:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570155;
        bh=C7djTTCjYd0cKj88eqwliCRjLiPRX/To8ipnMZj28IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMBNs7TsYsMr7p8ZSpDFz4n1LrajOJjXgJAoBKpwJayIvWWKB9XVPaS25dempyp+H
         HA0Ct9E2Ak2oe4Vvsoi+WPOct3hoZRCHOc16PpqHKp4rfTmikHYqM2yXU3TXgq0veD
         TC+3oujimV/17NEnwbFEenv4WRtvY15L6B6nuTs4Qr4Dj3ZVD2TwUjotc7BZn3JtYH
         GOMTGLyA+/rRcyYWvrso4o3N9M3NbcQBEL5ReKmWFljT8M95Lfe8FyF6zwoxUZ9feU
         uKqc/sG1B/nH6aAUvxOtoGk3dJwgZKj/C29ACGXHzWqNBVnenjqUTpGij/jkAcOmHa
         x1s21AyPgWrsw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 077/189] block: introduce BIO_ZONE_WRITE_LOCKED bio flag
Date:   Tue,  6 Jul 2021 07:12:17 -0400
Message-Id: <20210706111409.2058071-77-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

[ Upstream commit 9ffbbb435d8f566a0924ce4b5dc7fc1bceb6dbf8 ]

Introduce the BIO flag BIO_ZONE_WRITE_LOCKED to indicate that a BIO owns
the write lock of the zone it is targeting. This is the counterpart of
the struct request flag RQF_ZONE_WRITE_LOCKED.

This new BIO flag is reserved for now for zone write locking control
for device mapper targets exposing a zoned block device. Since in this
case, the lock flag must not be propagated to the struct request that
will be used to process the BIO, a BIO private flag is used rather than
changing the RQF_ZONE_WRITE_LOCKED request flag into a common REQ_XXX
flag that could be used for both BIO and request. This avoids conflicts
down the stack with the block IO scheduler zone write locking
(in mq-deadline).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/blk_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..e5cf12f102a2 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -304,6 +304,7 @@ enum {
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
 	BIO_REMAPPED,
+	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
 	BIO_FLAG_LAST
 };
 
-- 
2.30.2

