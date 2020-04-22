Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A41C55186
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 09:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6D02075A
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 09:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="YibQfwnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgDVJBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725961AbgDVJBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 05:01:13 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7272DC03C1A6
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 02:01:13 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d184so748040pfd.4
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 02:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UQDMG4sxhPSdGt8yBRftaMYo19D7wntblzJjX2TGklE=;
        b=YibQfwnAhwk3DmCVSVBByQkG8ozO/w3Rk5ClvMgKnydfOhiA/o1tDkhBWxzFbbOJJW
         f/+F6L33FN2+GkYXmcbgcRetRJ686wLCFxOOXkxCmUSaQlxp6GMOLheLY8DXe6DmnvzA
         RvLs05yetatdt2f+2FqcFa1uLGHHviAXbTO5uhnt+JcF5cAoaNHdLKgtufJq0+DCjXJG
         Nj2oqUD3bRmd5VVaPoX8JGoVEx+kk73FWD9JdzMzOR1E+njuhR9fwe+3gRE6TvCT80BJ
         KLljN3Cun9yokjrCLeR0KemLYmHAhUAJUe/1XlwPls2xMy9LRC/iljPnrv0jo+4UdhSb
         hJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UQDMG4sxhPSdGt8yBRftaMYo19D7wntblzJjX2TGklE=;
        b=SkvXkgkr4JA9z3hRVzANGQLYC/GA7wqqle9T16G0Ap4uJcGnQy/NKSPZfKfytitfHF
         9TjZbwV6OBJQxcTkoO8BU4MyQ++ugIniS3cF8eedbcGrhaJhBu7rCJ8mgK+jQOJ3Y5o9
         +GUla4ZWJNFGW3adAV+hSuTB523j1poiHLW9+pqPi3jzB885D3nG1fM8m/TLzoyDUNFx
         uBdk6C42008lwFn8TajNMUVcFDkMkuNrQPZEXydgHhP546Ng9VOhpqTT6W8WEasZE2sO
         uc+G1qgYALYsUu7CquDA1Rx+5tBbVLHYdEJHpzpbRDIfCfx98H9M0o/uT0RCQMx0CfWv
         bpmg==
X-Gm-Message-State: AGi0PuZ6YRqS+S1Cg0T20FWrg4NbeHzhigEE6emfaAvshaP930Ca431T
        a2746sngGW2qBmkvTmm4kim46Q==
X-Google-Smtp-Source: APiQypLcs+w53IDgp3BZroig/y72wzEF35ywjDJH8Jptw359SoFjY5cMmnHvidJUoC7U/FxbigLtrw==
X-Received: by 2002:a62:6106:: with SMTP id v6mr27006762pfb.199.1587546073037;
        Wed, 22 Apr 2020 02:01:13 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id p66sm4660054pfb.65.2020.04.22.02.01.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 02:01:12 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mpa@pengutronix.de, linux-block@vger.kernel.org,
        nbd@other.debian.org, Hou Pu <houpu@bytedance.com>
Subject: [PATCH 2/2] nbd: set max discard sectors in the unit of sector
Date:   Wed, 22 Apr 2020 05:00:18 -0400
Message-Id: <20200422090018.23210-3-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200422090018.23210-1-houpu@bytedance.com>
References: <20200422090018.23210-1-houpu@bytedance.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change blk_queue_max_discard_sectors from bytes to sector
to be more clearly.

Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 59c6ce2d2e43..8c59ada4be64 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -304,7 +304,7 @@ static void nbd_size_update(struct nbd_device *nbd)
 	if (config->flags & NBD_FLAG_SEND_TRIM) {
 		nbd->disk->queue->limits.discard_granularity = config->blksize;
 		nbd->disk->queue->limits.discard_alignment = config->blksize;
-		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
+		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX >> 9);
 	}
 	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
@@ -1224,7 +1224,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 		nbd->tag_set.timeout = 0;
 		nbd->disk->queue->limits.discard_granularity = 0;
 		nbd->disk->queue->limits.discard_alignment = 0;
-		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
+		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX >> 9);
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, nbd->disk->queue);
 
 		mutex_unlock(&nbd->config_lock);
-- 
2.11.0

