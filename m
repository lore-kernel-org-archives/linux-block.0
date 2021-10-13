Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C165C433FE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 00:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7693F60EB4
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 00:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhJMA6D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 20:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236845AbhJMA5m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 20:57:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F019A60EB4;
        Wed, 13 Oct 2021 00:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634086540;
        bh=1rXrvtHjJ+u+9yzUUuiHLMJgH9Xy7NFvXkfLnU9sx3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0fTqaiVks7f4QwrNxtUg696AtPmk+squnvqes4+TFFtZU1IxbFl0S+SByD+i2ZEt
         ZWM8SupF+wL8R4+K/FiZaSzyltTOP9D554aVk6nPjf+8H5T2rrujz0QavkRP8vtisQ
         YDuQI9mIPyqPyOe7p/Fw7B5HYYpaiwll9tTiOmppGK8JeXzNIOMNonOZcp/8TwnR6x
         e2epv+hhMTpPt4zEHFV9fatPWj9I6JehvBYr2cBh1HvbdxLrR6fvM3QLxMjyu2shQv
         UqvtHxlE/TcWHcv3WBP+65DTPwXjKdCJ+XturX/i3lXkvn5Z1vlGPE4Nwv9dvF5P8V
         f4hLl5mp3b6Ww==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 04/11] block: decode QUEUE_FLAG_HCTX_ACTIVE in debugfs output
Date:   Tue, 12 Oct 2021 20:55:24 -0400
Message-Id: <20211013005532.700190-4-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013005532.700190-1-sashal@kernel.org>
References: <20211013005532.700190-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 1dbdd99b511c966be9147ad72991a2856ac76f22 ]

While debugging an issue we've found that $DEBUGFS/block/$disk/state
doesn't decode QUEUE_FLAG_HCTX_ACTIVE but only displays its numerical
value.

Add QUEUE_FLAG(HCTX_ACTIVE) to the blk_queue_flag_name array so it'll get
decoded properly.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/4351076388918075bd80ef07756f9d2ce63be12c.1633332053.git.johannes.thumshirn@wdc.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4de03da9a624..b5f26082b959 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -129,6 +129,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(PCI_P2PDMA),
 	QUEUE_FLAG_NAME(ZONE_RESETALL),
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
+	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(NOWAIT),
 };
 #undef QUEUE_FLAG_NAME
-- 
2.33.0

