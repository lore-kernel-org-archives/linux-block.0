Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBACBC4332F
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 00:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D417D60F11
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 00:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhJMA47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 20:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235946AbhJMA45 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 20:56:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B7CB60EBB;
        Wed, 13 Oct 2021 00:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634086494;
        bh=8bTqGk9Z1B/OzSB3jKH7yuCKj6EGCG9rzMTqHhDTk8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzBAeuqKfOY7GGwGScdUDgPlk40iQazbLzcjPvBjWHGajKks3LTXDtEW+gTRFhjP3
         EaRu3chUVGyIkpcONZQSTDonmwKGKtotrbjTdjitjHTdQYzHGELnQrPpArRtVhh64n
         Crj+/lIqdVraei0U0k4bdcmeZALQIeHqd4Vq+VBXmWfggSd1yK7iZ1ZTmt9qG8A09E
         8mfrZ1OG2sXbZ2SRMkjsIoiQKaKgnKUGaC4KlZ4JvrSuNEoUy0eIL7pTHCOZWaY7v4
         o63/Qb7to1uBN91a9bk5PwpZkA0nM8W7bFx3OVyMKOPyhR6xJ0MZ8nT7fYQq4fEK5C
         HRzMjXHEIEeMg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 05/17] block: decode QUEUE_FLAG_HCTX_ACTIVE in debugfs output
Date:   Tue, 12 Oct 2021 20:54:29 -0400
Message-Id: <20211013005441.699846-5-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013005441.699846-1-sashal@kernel.org>
References: <20211013005441.699846-1-sashal@kernel.org>
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
index 4b66d2776eda..3b38d15723de 100644
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

