Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A65C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BE42082B
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FIbxAGZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BE42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeLFWUc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:20:32 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44535 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLFWUc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 17:20:32 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so1683076iod.11
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 14:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=T+SEFfR31RhWVxomNCLe19Q87AMxJcdwzmDYNMbLTrE=;
        b=FIbxAGZUr+deRGDfUHnrQcg1x/g+S0+iFQh4BYLKx6t9Y8p1SHieWK2Re/Jl5TERxX
         KSCcfAecdux1nr77ESYGHAIIxZN7iOYsw0FjWWwjqBGJVE9KtqtiHZCsGgIT6uf6FXz7
         fK8QdkZsXo5zq2pXTp8/P2fqkmBlalMuWcTw4JDf0sO/tR6AW9C8bL/67Ve2lu5wuXl6
         Untg/gAHJ+TcsLXf8lSnDy1/FgDWT7oZz/H4fQniDLNCBu2uKuKVP7f8UTTUBR1tUk7H
         99+vnwzy2n99kdo9X8aIQEIv/8F9L+E68yKNKX1RFk7ZV5wY8Rjize7lEYBkcTh3wKxP
         x6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=T+SEFfR31RhWVxomNCLe19Q87AMxJcdwzmDYNMbLTrE=;
        b=rm1YkzsX9tOleVzZlUx5qFKg9Zl9EO0QBlcZQ7F+GsVB0L1l4XAthn3UMKvXucFUGQ
         X36RZlbVkyNHS1vZaAESAGYsTVQOIrFVh9/hwKacFMFX1E3jY01TdAyzC8gVq7+0tR7C
         320LM2liWjyui9qXEsuy+P2ay1c5erFUDLiV/y6LSJBTBqwxnp0ip/dPkZjvoGZHV0Sg
         3+FV6j0RfOXqOG0zxzo2VbGLwIJfS1JgF2gOUv2rMubLjTLKv2It16x3FAwA31u04Biv
         5iK1y+DsYDrrxkp47pX/sDqoDIu5a7Zi2FA/WBGc7gd+sO1RAhpZkY85JisBYVZBakBR
         0MjA==
X-Gm-Message-State: AA+aEWb7K7pHbOd2qiUZ+Mvcw2w2JDFPcSy0pzd0zVB2x4p08IAEvTTJ
        o6hyqHB+eEPO9nWLpWfO0PxZpg==
X-Google-Smtp-Source: AFSGD/U7xNzJ9tDfcQ22uCcRO0UwVhC5vTx7M2ERUgKy9bqOQdOTs14vX4qILfBhEsMZ5kHL1yBcAg==
X-Received: by 2002:a6b:4106:: with SMTP id n6mr25640174ioa.171.1544134831806;
        Thu, 06 Dec 2018 14:20:31 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t10sm669395ioi.4.2018.12.06.14.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 14:20:30 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: fix direct dispatch issue failure for clones
Message-ID: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
Date:   Thu, 6 Dec 2018 15:20:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After the direct dispatch corruption fix, we permanently disallow direct
dispatch of non read/write requests. This works fine off the normal IO
path, as they will be retried like any other failed direct dispatch
request. But for the blk_insert_cloned_request() that only DM uses to
bypass the bottom level scheduler, we always first attempt direct
dispatch. For some types of requests, that's now a permanent failure,
and no amount of retrying will make that succeed.

Don't use direct dispatch off the cloned insert path, always just use
bypass inserts. This still bypasses the bottom level scheduler, which is
what DM wants.

Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-core.c b/block/blk-core.c
index deb56932f8c4..4c44e6fa0d08 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2637,7 +2637,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 		 * bypass a potential scheduler on the bottom device for
 		 * insert.
 		 */
-		return blk_mq_request_issue_directly(rq);
+		blk_mq_request_bypass_insert(rq, true);
+		return BLK_STS_OK;
 	}
 
 	spin_lock_irqsave(q->queue_lock, flags);

-- 
Jens Axboe

