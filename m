Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C1C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407742184D
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDOzgYh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfA2LHR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:07:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43343 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfA2LHQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:07:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so21516603wrs.10
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 03:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8JaSsc/YYZ/kdnvfBrrFjWTAlWsvvc6dlhkWZwzIj+Q=;
        b=jDOzgYh+7JYBxH0+MkncQ3vaM6G1Wwz/zf4/BEGiViuG5e2T+PP/awx4hfjQQJzq4o
         YZf+PzUJlNnIkncTTrYZrkQRjIGafwLxTEYhosPBqcbspQ3tc3VqYsXYT9acbSshwXsm
         o+krKWN7u2PKp1ijOnxKTWPCL6r8kjlcvyqS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8JaSsc/YYZ/kdnvfBrrFjWTAlWsvvc6dlhkWZwzIj+Q=;
        b=AOgQ4a+2oK1E4EoDS7raIMJ5SIKzpPp8oX8Qk1yn1rCJadNsZ7gQ3yF2vAYQWn8gaP
         ludKmf+qUXWTEqAsm6Bh/X99qI1Kr7qFBr5m5JLVIt6d6IUVISH8LtrzZzgxZ9zOq7at
         1H3pvzgsXDzHGUavjQdcVk9ZDSZr0kpZqIJwd/Lss+2LkNsQ59QTP85OUNDU7LtsJfJM
         9sFpRnmZ87a6JyzullhUFChpZiLvWN7pvdMSbMpN4ig1kzN5+2nxgOyeLuJFzhOCY5EI
         SaKAiSc4rON+MNB81hgYU65Qp3l8Elev7Ymo/3p53utwwZYCXopSoX/QNQ5WpIxBktOs
         RGKw==
X-Gm-Message-State: AHQUAub8mymlUbM1j5ztIzmfboSnWjuKbiUfz8dRnvvnGcVJ2CmA5jSX
        Wtw/3gNQ0lo5E20tPwpMqOj4ZQ==
X-Google-Smtp-Source: AHgI3IZp+jZT9UKS7sUYJA6gDD8eKqjxbmrelTmX1Wv1yhd73BdRwGh/3wlWrdZEzIYaNpZVUfNRrQ==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr4708238wrm.143.1548760034065;
        Tue, 29 Jan 2019 03:07:14 -0800 (PST)
Received: from localhost.localdomain ([88.147.67.218])
        by smtp.gmail.com with ESMTPSA id s132sm2066112wmf.28.2019.01.29.03.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:07:13 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, mancha@tower-research.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 13/14] block, bfq: do not overcharge writes in asymmetric scenarios
Date:   Tue, 29 Jan 2019 12:06:37 +0100
Message-Id: <20190129110638.12652-14-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129110638.12652-1-paolo.valente@linaro.org>
References: <20190129110638.12652-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Writes tend to starve reads. bfq counters this problem by overcharging
writes with an inflated service w.r.t. the actual service (number of
sector written) they receive.

Yet his overcharging is useless, and actually causes unfairness in the
opposite direction, when bfq happens to be enforcing strong I/O
control. bfq does this enforcing when the scenario is asymmetric,
i.e., when some bfq_queue or group of bfq_queues is to be granted a
different bandwidth than some other bfq_queue or group of
bfq_queues. So, in such a scenario, this commit disables write
overcharging.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 2ab53d93ba12..06268449d2ca 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -888,7 +888,8 @@ static struct request *bfq_find_next_rq(struct bfq_data *bfqd,
 static unsigned long bfq_serv_to_charge(struct request *rq,
 					struct bfq_queue *bfqq)
 {
-	if (bfq_bfqq_sync(bfqq) || bfqq->wr_coeff > 1)
+	if (bfq_bfqq_sync(bfqq) || bfqq->wr_coeff > 1 ||
+	    !bfq_symmetric_scenario(bfqq->bfqd))
 		return blk_rq_sectors(rq);
 
 	return blk_rq_sectors(rq) * bfq_async_charge_factor;
-- 
2.20.1

