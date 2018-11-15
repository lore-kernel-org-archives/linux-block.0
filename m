Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC96BC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 01:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BB32147C
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 01:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xUw7ikqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BB32147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeKOL0g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeKOL0g (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 06:26:36 -0500
Received: from ebiggers.mtv.corp.google.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F0802147C;
        Thu, 15 Nov 2018 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542244855;
        bh=n3H2KxvNnJ7UuRf6AxhvKhDyEp3ZMWNTbuaPuvRG5Ig=;
        h=From:To:Subject:Date:From;
        b=xUw7ikqZcu3pDu+HE4x5Bdkh21B0Cq/8TQL6PY28SM9VpaqEF9Pq4SyEATRoRzMjL
         ccoDbIPGP54NwrotN8bNNcKc421RwGnnd0dw11djpB8uFSlvFY1K5zzED8aLE27pxI
         9h7Ph/VVIYjIBROQduDGYxjTt0cTT/d9ib1iClYw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: make blk_try_req_merge() static
Date:   Wed, 14 Nov 2018 17:19:46 -0800
Message-Id: <20181115011946.123485-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

blk_try_req_merge() is only used in block/blk-merge.c, so make it
static.

This addresses a gcc warning when -Wmissing-prototypes is enabled.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-merge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index e7696c47489ad..badccafc91303 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -731,7 +731,8 @@ static inline bool blk_discard_mergable(struct request *req)
 	return false;
 }
 
-enum elv_merge blk_try_req_merge(struct request *req, struct request *next)
+static enum elv_merge blk_try_req_merge(struct request *req,
+					struct request *next)
 {
 	if (blk_discard_mergable(req))
 		return ELEVATOR_DISCARD_MERGE;
-- 
2.19.1.930.g4563a0d9d0-goog

